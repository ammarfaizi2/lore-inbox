Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUKVKdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUKVKdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUKVKbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:31:16 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:50180 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262020AbUKVK3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:29:05 -0500
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: Add disable_clkrun option
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 22 Nov 2004 19:28:34 +0900
Message-ID: <87brdqxjn1.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I received report that transmission of Realtek 8139 doesn't work.  The
cause of this problem was CLKRUN protocols of laptop's TI 12xx CardBus
bridge.

And I remember that this problem had happened on Thinkpad before. In
the case, problem seems solved by similar workaround of sound/oss/cs46xx.c.

This patch adds "disable_clkrun" option as workaround of problem to
yenta_socket.

Please apply.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/pcmcia/ti113x.h       |   11 ++++++++---
 drivers/pcmcia/yenta_socket.c |    2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff -puN drivers/pcmcia/ti113x.h~pcmcia-clkrun-disable drivers/pcmcia/ti113x.h
--- linux-2.6.10-rc2/drivers/pcmcia/ti113x.h~pcmcia-clkrun-disable	2004-11-21 15:49:44.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/drivers/pcmcia/ti113x.h	2004-11-21 15:49:44.000000000 +0900
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
--- linux-2.6.10-rc2/drivers/pcmcia/yenta_socket.c~pcmcia-clkrun-disable	2004-11-21 15:49:44.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/drivers/pcmcia/yenta_socket.c	2004-11-22 18:56:20.000000000 +0900
@@ -28,6 +28,8 @@
 #include "yenta_socket.h"
 #include "i82365.h"
 
+static int disable_clkrun;
+module_param(disable_clkrun, bool, 0444);
 
 #if 0
 #define debug(x,args...) printk(KERN_DEBUG "%s: " x, __func__ , ##args)
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
