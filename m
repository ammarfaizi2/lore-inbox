Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUIVORw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUIVORw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 10:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUIVORv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 10:17:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48402 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265489AbUIVORp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 10:17:45 -0400
Date: Wed, 22 Sep 2004 15:17:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MMC compatibility fix - GO_IDLE
Message-ID: <20040922151735.D2347@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <414C065A.7000602@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <414C065A.7000602@drzeus.cx>; from drzeus-list@drzeus.cx on Sat, Sep 18, 2004 at 11:56:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 18, 2004 at 11:56:42AM +0200, Pierre Ossman wrote:
> This patch adds a GO_IDLE before sending a new SEND_OP_COND (as required 
> by MMC standard).

Thanks; I haven't completely vanished off the face of the planet.

We already have a function using MMC_GO_IDLE_STATE, so I suggest we
separate this out.  If you need a 1ms delay after sending this, maybe
the other case also needs this delay as well?

How about this patch?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mmc-idlecards.diff"

diff -u linux-2.6-mmc/drivers/mmc/mmc.c linux/drivers/mmc/mmc.c
--- linux-2.6-mmc/drivers/mmc/mmc.c	Mon Sep 20 10:23:16 2004
+++ linux/drivers/mmc/mmc.c	Wed Sep 22 15:14:00 2004
@@ -451,11 +451,26 @@
 }
 
 /*
+ * Tell attached cards to go to IDLE state
+ */
+static void mmc_idle_cards(struct mmc_host *host)
+{
+	struct mmc_command cmd;
+
+	cmd.opcode = MMC_GO_IDLE_STATE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_NONE;
+
+	mmc_wait_for_cmd(host, &cmd, 0);
+
+	mmc_delay(1);
+}
+
+/*
  * Apply power to the MMC stack.
  */
 static void mmc_power_up(struct mmc_host *host)
 {
-	struct mmc_command cmd;
 	int bit = fls(host->ocr_avail) - 1;
 
 	host->ios.vdd = bit;
@@ -470,12 +485,6 @@
 	host->ops->set_ios(host, &host->ios);
 
 	mmc_delay(2);
-
-	cmd.opcode = MMC_GO_IDLE_STATE;
-	cmd.arg = 0;
-	cmd.flags = MMC_RSP_NONE;
-
-	mmc_wait_for_cmd(host, &cmd, 0);
 }
 
 static void mmc_power_off(struct mmc_host *host)
@@ -647,12 +656,22 @@
 		u32 ocr;
 
 		mmc_power_up(host);
+		mmc_idle_cards(host);
 
 		err = mmc_send_op_cond(host, 0, &ocr);
 		if (err != MMC_ERR_NONE)
 			return;
 
 		host->ocr = mmc_select_voltage(host, ocr);
+
+		/*
+		 * Since we're changing the OCR value, we seem to
+		 * need to tell some cards to go back to the idle
+		 * state.  We wait 1ms to give cards time to
+		 * respond.
+		 */
+		if (host->ocr)
+			mmc_idle_cards(host);
 	} else {
 		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 		host->ios.clock = host->f_min;

--Dxnq1zWXvFF0Q93v--
