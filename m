Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUGMVWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUGMVWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUGMVWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:22:17 -0400
Received: from gprs214-20.eurotel.cz ([160.218.214.20]:12416 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265932AbUGMVWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:22:12 -0400
Date: Tue, 13 Jul 2004 23:21:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: Trivial cleanups & 64-bit fixes for donauboe.c
Message-ID: <20040713212156.GA2971@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

donauboe uses __u32; this is kernel code, you are allowed to use u32
which is less ugly. ASSERT() is pretty ugly. I made it 64-bit clean,
and if it is outside 32-bit range, it BUG()s. Not ideal, but better
than not compiling.


Index: drivers/net/irda/donauboe.c
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/drivers/net/irda/donauboe.c,v
retrieving revision 1.19
diff -u -r1.19 donauboe.c
--- drivers/net/irda/donauboe.c	2 Jul 2004 21:07:38 -0000	1.19
+++ drivers/net/irda/donauboe.c	13 Jul 2004 21:09:03 -0000
@@ -28,6 +28,7 @@
  * Modified: 2.17 jeu sep 12 08:50:20 2002 (save_flags();cli(); replaced by spinlocks)
  * Modified: 2.18 Christian Gennerat <christian.gennerat@polytechnique.org>
  * Modified: 2.18 ven jan 10 03:14:16 2003 Change probe default options
+ * Modified: 2.19 Pavel Machek <pavel@suse.cz>
  *
  *     Copyright (c) 1999 James McKenzie, All Rights Reserved.
  *
@@ -247,7 +248,7 @@
 static void
 toshoboe_dumpregs (struct toshoboe_cb *self)
 {
-  __u32 ringbase;
+  u32 ringbase;
 
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
@@ -552,7 +553,7 @@
 static void
 toshoboe_startchip (struct toshoboe_cb *self)
 {
-  __u32 physaddr;
+  unsigned long physaddr;
 
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
@@ -587,9 +588,7 @@
   /*Find out where the rings live */
   physaddr = virt_to_bus (self->ring);
 
-  ASSERT ((physaddr & 0x3ff) == 0,
-          printk (KERN_ERR DRIVER_NAME "ring not correctly aligned\n");
-          return;);
+  BUG_ON(physaddr & 0xffffffff000003ff);
 
   OUTB ((physaddr >> 10) & 0xff, OBOE_RING_BASE0);
   OUTB ((physaddr >> 18) & 0xff, OBOE_RING_BASE1);
@@ -601,7 +600,7 @@
   /* Start up the clocks */
   OUTB (OBOE_ENABLEH_PHYANDCLOCK, OBOE_ENABLEH);
 
-  /*set to sensible speed */
+  /* Set to sensible speed */
   self->speed = 9600;
   toshoboe_setbaud (self);
   toshoboe_initptrs (self);
@@ -1622,22 +1621,18 @@
       goto freeregion;
     }
 
-#if (BITS_PER_LONG == 64)
-#error broken on 64-bit:  casts pointer to 32-bit, and then back to pointer.
-#endif
-
-  /*We need to align the taskfile on a taskfile size boundary */
+  /* We need to align the taskfile on a taskfile size boundary */
   {
     unsigned long addr;
 
-    addr = (__u32) self->ringbuf;
+    addr = (unsigned long) self->ringbuf;
     addr &= ~(OBOE_RING_LEN - 1);
     addr += OBOE_RING_LEN;
     self->ring = (struct OboeRing *) addr;
   }
 
   memset (self->ring, 0, OBOE_RING_LEN);
-  self->io.mem_base = (__u32) self->ring;
+  self->io.mem_base = (unsigned long) self->ring;
 
   ok = 1;
   for (i = 0; i < TX_SLOTS; ++i)
Index: drivers/net/irda/donauboe.h
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/drivers/net/irda/donauboe.h,v
retrieving revision 1.2
diff -u -r1.2 donauboe.h
--- drivers/net/irda/donauboe.h	11 Oct 2002 20:53:05 -0000	1.2
+++ drivers/net/irda/donauboe.h	13 Jul 2004 21:07:18 -0000
@@ -268,12 +268,11 @@
 
 struct OboeSlot
 {
-  __u16 len;                    /*Tweleve bits of packet length */
-  __u8 unused;
-  __u8 control;                 /*Slot control/status see below */
-  __u32 address;                /*Slot buffer address */
-}
-__attribute__ ((packed));
+  u16 len;                    /*Tweleve bits of packet length */
+  u8 unused;
+  u8 control;                 /*Slot control/status see below */
+  u32 address;                /*Slot buffer address */
+} __attribute__ ((packed));
 
 #define OBOE_NTASKS OBOE_TXRING_OFFSET_IN_SLOTS
 
@@ -316,7 +315,7 @@
   chipio_t io;                  /* IrDA controller information */
   struct qos_info qos;          /* QoS capabilities for this device */
 
-  __u32 flags;                  /* Interface flags */
+  u32 flags;                  /* Interface flags */
 
   struct pci_dev *pdev;         /*PCI device */
   int base;                     /*IO base */

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
