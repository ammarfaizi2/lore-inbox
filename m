Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264056AbVBETEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbVBETEO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 14:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbVBETEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 14:04:14 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:17423 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264059AbVBETDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 14:03:38 -0500
To: Marco Rogantini <marco.rogantini@supsi.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rtl8139 (8139too) net problem in linux 2.6.10
References: <Pine.LNX.4.62.0502051818370.4821@rost.dti.supsi.ch>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Feb 2005 04:03:22 +0900
In-Reply-To: <Pine.LNX.4.62.0502051818370.4821@rost.dti.supsi.ch> (Marco
 Rogantini's message of "Sat, 5 Feb 2005 18:29:17 +0100 (CET)")
Message-ID: <87wttmg77p.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Rogantini <marco.rogantini@supsi.ch> writes:

> sort kernel: NETDEV WATCHDOG: eth1: transmit timed out
> sort kernel: eth1: Transmit timeout, status 0d 0000 c07f media 00.

This state seems the hardware problem. Probably TX pending was not
processed, so any pending interrupts is nothing.

What CardBus bridge are you using? If TI12xx bridge, can you try the
attached patch? (Try "disable_clkrun" module option with yenta_socket.ko)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



[PATCH] pcmcia: Add disable_clkrun option

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
 drivers/pcmcia/yenta_socket.c |    3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff -puN drivers/pcmcia/ti113x.h~pcmcia-clkrun-disable drivers/pcmcia/ti113x.h
--- linux-2.6.10/drivers/pcmcia/ti113x.h~pcmcia-clkrun-disable	2004-12-25 23:37:27.000000000 +0900
+++ linux-2.6.10-hirofumi/drivers/pcmcia/ti113x.h	2004-12-25 23:37:27.000000000 +0900
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
--- linux-2.6.10/drivers/pcmcia/yenta_socket.c~pcmcia-clkrun-disable	2004-12-25 23:37:27.000000000 +0900
+++ linux-2.6.10-hirofumi/drivers/pcmcia/yenta_socket.c	2004-12-25 23:37:27.000000000 +0900
@@ -28,6 +28,9 @@
 #include "yenta_socket.h"
 #include "i82365.h"
 
+static int disable_clkrun;
+module_param(disable_clkrun, bool, 0444);
+MODULE_PARM_DESC(disable_clkrun, "If PC card doesn't function properly, please try this option");
 
 #if 0
 #define debug(x,args...) printk(KERN_DEBUG "%s: " x, __func__ , ##args)
_
