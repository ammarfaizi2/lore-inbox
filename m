Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbUKWFAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbUKWFAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbUKWEtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 23:49:19 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:14098 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262237AbUKWDrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 22:47:45 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Add disable_clkrun option
References: <87brdqxjn1.fsf@devron.myhome.or.jp>
	<20041122142439.45d5f439.akpm@osdl.org>
	<87fz31wbfp.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 23 Nov 2004 12:47:24 +0900
In-Reply-To: <87fz31wbfp.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Tue, 23 Nov 2004 11:23:22 +0900")
Message-ID: <87pt25usz7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> +MODULE_PARM_DESC(disable_clkrun, "If PC card does'nt function properly, please try this option");
                                                ^^^^^^^
Oooops. Typo. I'm sorry. Please apply the following instead.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


 drivers/pcmcia/ti113x.h       |   11 ++++++++---
 drivers/pcmcia/yenta_socket.c |    3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff -puN drivers/pcmcia/ti113x.h~pcmcia-clkrun-disable drivers/pcmcia/ti113x.h
--- linux-2.6.10-rc2/drivers/pcmcia/ti113x.h~pcmcia-clkrun-disable	2004-11-23 12:33:20.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/drivers/pcmcia/ti113x.h	2004-11-23 12:33:20.000000000 +0900
@@ -592,15 +592,20 @@ out:
 
 static int ti12xx_override(struct yenta_socket *socket)
 {
-	u32 val;
+	u32 val, val_orig;
 
 	/* make sure that memory burst is active */
-	val = config_readl(socket, TI113X_SYSTEM_CONTROL);
+	val_orig = val = config_readl(socket, TI113X_SYSTEM_CONTROL);
+	if (disable_clkrun && PCI_FUNC(socket->dev->devfn) == 0) {
+		printk(KERN_INFO "Yenta: Disabling CLKRUN feature\n");
+		val |= TI113X_SCR_KEEPCLK;
+	}
 	if (!(val & TI122X_SCR_MRBURSTUP)) {
 		printk(KERN_INFO "Yenta: Enabling burst memory read transactions\n");
 		val |= TI122X_SCR_MRBURSTUP;
-		config_writel(socket, TI113X_SYSTEM_CONTROL, val);
 	}
+	if (val_orig != val)
+		config_writel(socket, TI113X_SYSTEM_CONTROL, val);
 
 	/*
 	 * for EnE bridges only: clear testbit TLTEnable. this makes the
diff -puN drivers/pcmcia/yenta_socket.c~pcmcia-clkrun-disable drivers/pcmcia/yenta_socket.c
--- linux-2.6.10-rc2/drivers/pcmcia/yenta_socket.c~pcmcia-clkrun-disable	2004-11-23 12:33:20.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/drivers/pcmcia/yenta_socket.c	2004-11-23 12:37:34.000000000 +0900
@@ -28,6 +28,9 @@
 #include "yenta_socket.h"
 #include "i82365.h"
 
+static int disable_clkrun;
+module_param(disable_clkrun, bool, 0444);
+MODULE_PARM_DESC(disable_clkrun, "If PC card doesn't function properly, please try this option");
 
 #if 0
 #define debug(x,args...) printk(KERN_DEBUG "%s: " x, __func__ , ##args)
_
