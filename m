Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUGYMIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUGYMIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 08:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUGYMIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 08:08:53 -0400
Received: from aun.it.uu.se ([130.238.12.36]:60102 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262744AbUGYMIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 08:08:44 -0400
Date: Sun, 25 Jul 2004 14:08:41 +0200 (MEST)
Message-Id: <200407251208.i6PC8foi007406@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: haiquy@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: More compile errors, 2.4.27-rc3 with gcc-3.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004 22:30:13 +0000 (UTC), haiquy@yahoo.com wrote:
>kernel 2.4.27-rc3 with the gcc-2.4.0 compile fix patch
>
>gcc-4 -D__KERNEL__ -I/home/linux-2.4.27-rc3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fno-strength-reduce -ffast-math -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -fno-unit-at-a-time -DMODULE -DHISAX_MAX_CARDS=8 -nostdinc -iwithprefix include -DKBUILD_BASENAME=st5481_usb  -c -o st5481_usb.o st5481_usb.c
>st5481_usb.c: In function `usb_next_ctrl_msg':
>st5481_usb.c:51: error: parse error before "__FUNCTION__"

__FUNCTION__ string concatenation errors

>gcc-4 -D__KERNEL__ -I/home/linux-2.4.27-rc3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fno-strength-reduce -ffast-math -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -fno-unit-at-a-time -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ns83820  -c -o ns83820.o ns83820.c
>ns83820.c:591: error: conflicting types for 'rx_refill_atomic'
>ns83820.c:589: error: previous declaration of 'rx_refill_atomic' was here

FASTCALL/fastcall mismatches

>gcc-4 -D__KERNEL__ -I/home/linux-2.4.27-rc3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fno-strength-reduce -ffast-math -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -fno-unit-at-a-time -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=core  -c -o core.o core.c
>core.c:410: error: conflicting types for '__rfcomm_dlc_throttle'
>/home/linux-2.4.27-rc3/include/net/bluetooth/rfcomm.h:265: error: previous declaration of '__rfcomm_dlc_throttle' was here

FASTCALL/fastcall mismatches

These problems are fixed in
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-v4-2.4.27-rc3>
or apply the incremental patch below. The fixes are trivial
and correspond to changes already present in the 2.6 kernel.

/Mikael

--- linux-2.4.27-rc3/drivers/isdn/hisax/st5481.h.~1~	2004-07-25 13:26:44.000000000 +0200
+++ linux-2.4.27-rc3/drivers/isdn/hisax/st5481.h	2004-07-25 13:44:20.000000000 +0200
@@ -219,13 +219,13 @@
 #define L1_EVENT_COUNT (EV_TIMER3 + 1)
 
 #define ERR(format, arg...) \
-printk(KERN_ERR __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
+printk(KERN_ERR "%s:%s: " format "\n" , __FILE__,  __FUNCTION__ , ## arg)
 
 #define WARN(format, arg...) \
-printk(KERN_WARNING __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
+printk(KERN_WARNING "%s:%s: " format "\n" , __FILE__,  __FUNCTION__ , ## arg)
 
 #define INFO(format, arg...) \
-printk(KERN_INFO __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
+printk(KERN_INFO "%s:%s: " format "\n" , __FILE__,  __FUNCTION__ , ## arg)
 
 #include "isdnhdlc.h"
 #include "fsm.h"
--- linux-2.4.27-rc3/drivers/net/ns83820.c.~1~	2004-02-18 15:16:23.000000000 +0100
+++ linux-2.4.27-rc3/drivers/net/ns83820.c	2004-07-25 13:34:50.000000000 +0200
@@ -587,7 +587,7 @@
 }
 
 static void FASTCALL(rx_refill_atomic(struct ns83820 *dev));
-static void rx_refill_atomic(struct ns83820 *dev)
+static void fastcall rx_refill_atomic(struct ns83820 *dev)
 {
 	rx_refill(dev, GFP_ATOMIC);
 }
@@ -608,7 +608,7 @@
 }
 
 static void FASTCALL(phy_intr(struct ns83820 *dev));
-static void phy_intr(struct ns83820 *dev)
+static void fastcall phy_intr(struct ns83820 *dev)
 {
 	static char *speeds[] = { "10", "100", "1000", "1000(?)", "1000F" };
 	u32 cfg, new_cfg;
@@ -793,7 +793,7 @@
 }
 
 static void FASTCALL(ns83820_rx_kick(struct ns83820 *dev));
-static void ns83820_rx_kick(struct ns83820 *dev)
+static void fastcall ns83820_rx_kick(struct ns83820 *dev)
 {
 	/*if (nr_rx_empty(dev) >= NR_RX_DESC/4)*/ {
 		if (dev->rx_info.up) {
@@ -814,7 +814,7 @@
  *	
  */
 static void FASTCALL(rx_irq(struct ns83820 *dev));
-static void rx_irq(struct ns83820 *dev)
+static void fastcall rx_irq(struct ns83820 *dev)
 {
 	struct rx_info *info = &dev->rx_info;
 	unsigned next_rx;
--- linux-2.4.27-rc3/net/bluetooth/rfcomm/core.c.~1~	2004-04-14 20:22:21.000000000 +0200
+++ linux-2.4.27-rc3/net/bluetooth/rfcomm/core.c	2004-07-25 13:41:03.000000000 +0200
@@ -406,7 +406,7 @@
 	return len;
 }
 
-void __rfcomm_dlc_throttle(struct rfcomm_dlc *d)
+void fastcall __rfcomm_dlc_throttle(struct rfcomm_dlc *d)
 {
 	BT_DBG("dlc %p state %ld", d, d->state);
 
@@ -417,7 +417,7 @@
 	rfcomm_schedule(RFCOMM_SCHED_TX);
 }
 
-void __rfcomm_dlc_unthrottle(struct rfcomm_dlc *d)
+void fastcall __rfcomm_dlc_unthrottle(struct rfcomm_dlc *d)
 {
 	BT_DBG("dlc %p state %ld", d, d->state);
 
