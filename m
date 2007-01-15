Return-Path: <linux-kernel-owner+w=401wt.eu-S1751819AbXAOFq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbXAOFq3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 00:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbXAOFq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 00:46:28 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40696 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbXAOFq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 00:46:28 -0500
Message-ID: <45AB1542.7000109@drzeus.cx>
Date: Mon, 15 Jan 2007 06:46:42 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MMC updates
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

        git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git
for-linus

to receive the following updates:

 drivers/mmc/imxmmc.c    |    3 ---
 drivers/mmc/omap.c      |   15 +++++++++------
 drivers/mmc/pxamci.c    |    2 +-
 drivers/mmc/tifm_sd.c   |    3 ---
 include/linux/mmc/mmc.h |    2 +-
 5 files changed, 11 insertions(+), 14 deletions(-)

Carlos Eduardo Aguiar (1):
      omap: Update MMC response types

Philip Langdale (1):
      mmc: Correct definition of R6

diff --git a/drivers/mmc/imxmmc.c b/drivers/mmc/imxmmc.c
index 06e7fcd..bfb9ff6 100644
--- a/drivers/mmc/imxmmc.c
+++ b/drivers/mmc/imxmmc.c
@@ -351,9 +351,6 @@ static void imxmci_start_cmd(struct imxmci_host
*host, struct mmc_command *cmd,
        case MMC_RSP_R3: /* short */
                cmdat |= CMD_DAT_CONT_RESPONSE_FORMAT_R3;
                break;
-       case MMC_RSP_R6: /* short CRC */
-               cmdat |= CMD_DAT_CONT_RESPONSE_FORMAT_R6;
-               break;
        default:
                break;
        }
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index 9488408..d30540b 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -91,7 +91,6 @@


 #define DRIVER_NAME "mmci-omap"
-#define RSP_TYPE(x)    ((x) & ~(MMC_RSP_BUSY|MMC_RSP_OPCODE))

 /* Specifies how often in millisecs to poll for card status changes
  * when the cover switch is open */
@@ -204,18 +203,22 @@ mmc_omap_start_command(struct mmc_omap_host *host,
struct mmc_command *cmd)
        cmdtype = 0;

        /* Our hardware needs to know exact type */
-       switch (RSP_TYPE(mmc_resp_type(cmd))) {
-       case RSP_TYPE(MMC_RSP_R1):
-               /* resp 1, resp 1b */
+       switch (mmc_resp_type(cmd)) {
+       case MMC_RSP_NONE:
+               break;
+       case MMC_RSP_R1:
+       case MMC_RSP_R1B:
+               /* resp 1, 1b, 6, 7 */
                resptype = 1;
                break;
-       case RSP_TYPE(MMC_RSP_R2):
+       case MMC_RSP_R2:
                resptype = 2;
                break;
-       case RSP_TYPE(MMC_RSP_R3):
+       case MMC_RSP_R3:
                resptype = 3;
                break;
        default:
+               dev_err(mmc_dev(host->mmc), "Invalid response type:
%04x\n", mmc_resp_type(cmd));
                break;
        }

diff --git a/drivers/mmc/pxamci.c b/drivers/mmc/pxamci.c
index 45a9283..6073d99 100644
--- a/drivers/mmc/pxamci.c
+++ b/drivers/mmc/pxamci.c
@@ -171,7 +171,7 @@ static void pxamci_start_cmd(struct pxamci_host
*host, struct mmc_command *cmd,

 #define RSP_TYPE(x)    ((x) & ~(MMC_RSP_BUSY|MMC_RSP_OPCODE))
        switch (RSP_TYPE(mmc_resp_type(cmd))) {
-       case RSP_TYPE(MMC_RSP_R1): /* r1, r1b, r6 */
+       case RSP_TYPE(MMC_RSP_R1): /* r1, r1b, r6, r7 */
                cmdat |= CMDAT_RESP_SHORT;
                break;
        case RSP_TYPE(MMC_RSP_R3):
diff --git a/drivers/mmc/tifm_sd.c b/drivers/mmc/tifm_sd.c
index f18ad99..fa4a528 100644
--- a/drivers/mmc/tifm_sd.c
+++ b/drivers/mmc/tifm_sd.c
@@ -173,9 +173,6 @@ static unsigned int tifm_sd_op_flags(struct
mmc_command *cmd)
        case MMC_RSP_R3:
                rc |= TIFM_MMCSD_RSP_R3;
                break;
-       case MMC_RSP_R6:
-               rc |= TIFM_MMCSD_RSP_R6;
-               break;
        default:
                BUG();
        }
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index a3594df..bcf2490 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -42,7 +42,7 @@ struct mmc_command {
 #define MMC_RSP_R1B
(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
 #define MMC_RSP_R2     (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
 #define MMC_RSP_R3     (MMC_RSP_PRESENT)
-#define MMC_RSP_R6     (MMC_RSP_PRESENT|MMC_RSP_CRC)
+#define MMC_RSP_R6     (MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)

 #define mmc_resp_type(cmd)     ((cmd)->flags &
(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))


-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
