Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269172AbUIRJ6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269172AbUIRJ6A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 05:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269173AbUIRJ6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 05:58:00 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:23171 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269172AbUIRJ4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 05:56:36 -0400
Message-ID: <414C065A.7000602@drzeus.cx>
Date: Sat, 18 Sep 2004 11:56:42 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-18180-1095501420-0001-2"
To: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 1/3] MMC compatibility fix - GO_IDLE
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-18180-1095501420-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a GO_IDLE before sending a new SEND_OP_COND (as required 
by MMC standard).

--=_hades.drzeus.cx-18180-1095501420-0001-2
Content-Type: text/x-patch; name="mmc-goidle.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-goidle.patch"

Index: linux-wbsd/drivers/mmc/mmc.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc.c	(revision 57)
+++ linux-wbsd/drivers/mmc/mmc.c	(revision 58)
@@ -579,6 +579,8 @@
 
 static void mmc_setup(struct mmc_host *host)
 {
+	struct mmc_command cmd;
+	
 	if (host->ios.power_mode != MMC_POWER_ON) {
 		int err;
 		u32 ocr;
@@ -613,6 +615,16 @@
 	if (host->ocr == 0)
 		return;
 
+	/* Put cards in idle before sending new OCR */
+
+	cmd.opcode = MMC_GO_IDLE_STATE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_NONE;
+	
+	mmc_wait_for_cmd(host, &cmd, 0);
+
+	mmc_delay(1);
+	
 	/*
 	 * Send the selected OCR multiple times... until the cards
 	 * all get the idea that they should be ready for CMD2.

--=_hades.drzeus.cx-18180-1095501420-0001-2--
