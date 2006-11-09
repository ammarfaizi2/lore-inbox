Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754761AbWKII2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbWKII2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 03:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbWKII2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 03:28:54 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:8853 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1754761AbWKII2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 03:28:53 -0500
Message-ID: <4552E6C4.2020703@drzeus.cx>
Date: Thu, 09 Nov 2006 09:28:52 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MMC update
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

        git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git
for-linus

to receive the following updates:

 drivers/mmc/mmc.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

Timo Teras:
      MMC: Poll card status after rescanning cards
      MMC: Do not set unsupported bits in OCR response

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ee8863c..766bc54 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -475,7 +475,7 @@ static u32 mmc_select_voltage(struct mmc
        if (bit) {
                bit -= 1;

-               ocr = 3 << bit;
+               ocr &= 3 << bit;

                host->ios.vdd = bit;
                mmc_set_ios(host);
@@ -1178,14 +1178,29 @@ static void mmc_rescan(void *data)
 {
        struct mmc_host *host = data;
        struct list_head *l, *n;
+       unsigned char power_mode;

        mmc_claim_host(host);

-       if (host->ios.power_mode == MMC_POWER_ON)
+       /*
+        * Check for removed cards and newly inserted ones. We check for
+        * removed cards first so we can intelligently re-select the VDD.
+        */
+       power_mode = host->ios.power_mode;
+       if (power_mode == MMC_POWER_ON)
                mmc_check_cards(host);

        mmc_setup(host);

+       /*
+        * Some broken cards process CMD1 even in stand-by state. There is
+        * no reply, but an ILLEGAL_COMMAND error is cached and returned
+        * after next command. We poll for card status here to clear any
+        * possibly pending error.
+        */
+       if (power_mode == MMC_POWER_ON)
+               mmc_check_cards(host);
+
        if (!list_empty(&host->cards)) {
                /*
                 * (Re-)calculate the fastest clock rate which the

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
