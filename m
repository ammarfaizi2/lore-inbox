Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSFQPfB>; Mon, 17 Jun 2002 11:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSFQPfA>; Mon, 17 Jun 2002 11:35:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5381 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314458AbSFQPe7>;
	Mon, 17 Jun 2002 11:34:59 -0400
Date: Mon, 17 Jun 2002 16:35:00 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: serial drivers using BHs
Message-ID: <20020617163500.X9435@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The quest to eradicate bottom halves continues.  This installment: all the
serial drivers.  They each have a bottom half which, er, does exactly the
same thing as IMMEDIATE_BH.  So why not make them all use IMMEDIATE_BH?
This patch does exactly that:

ftp://ftp.uk.linux.org/pub/linux/willy/patches/serial-bh-ectomy.diff

(it's 30k, and i seem to remember l-k having a limit of 20k).  Here's
a sample from it; all drivers are pretty much equivalent here:

diff -urNX dontdiff linux-2.5.22/drivers/char/cyclades.c linux-2.5.22-bh/drivers/char/cyclades.c
--- linux-2.5.22/drivers/char/cyclades.c	Sun Jun  2 18:44:43 2002
+++ linux-2.5.22-bh/drivers/char/cyclades.c	Mon Jun 17 07:04:32 2002
@@ -712,8 +712,6 @@
 
 #define	JIFFIES_DIFF(n, j)	((j) - (n))
 
-static DECLARE_TASK_QUEUE(tq_cyclades);
-
 static struct tty_driver cy_serial_driver, cy_callout_driver;
 static int serial_refcount;
 
@@ -934,8 +932,8 @@
 cy_sched_event(struct cyclades_port *info, int event)
 {
     info->event |= 1 << event; /* remember what kind of event and who */
-    queue_task(&info->tqueue, &tq_cyclades); /* it belongs to */
-    mark_bh(CYCLADES_BH);                       /* then trigger event */
+    queue_task(&info->tqueue, &tq_immediate); /* it belongs to */
+    mark_bh(IMMEDIATE_BH);                       /* then trigger event */
 } /* cy_sched_event */
 
 
@@ -962,12 +960,6 @@
  * had to poll every port to see if that port needed servicing.
  */
 static void
-do_cyclades_bh(void)
-{
-    run_task_queue(&tq_cyclades);
-} /* do_cyclades_bh */
-
-static void
 do_softint(void *private_)
 {
   struct cyclades_port *info = (struct cyclades_port *) private_;
@@ -5513,8 +5505,6 @@
   unsigned short chip_number;
   int nports;
 
-    init_bh(CYCLADES_BH, do_cyclades_bh);
-
     show_version();
 
     /* Initialize the tty_driver structure */
@@ -5791,7 +5781,6 @@
 #endif /* CONFIG_CYZ_INTR */
 
     save_flags(flags); cli();
-    remove_bh(CYCLADES_BH);
 
     if ((e1 = tty_unregister_driver(&cy_serial_driver)))
             printk("cyc: failed to unregister Cyclades serial driver(%d)\n",

BTW, people have been asking why I don't include a patch which removes
the now-unused constants from interrupt.h -- the reson is that these
patches might be applied out of order and we'd get spurious conflicts.
Also, it's an enum and I'd prefer to add numbers to them if we're going
to start removing some from the middle.  In my tree, we're down to just
IMMEDIATE_BH and TIMER_BH in that enum.  I believe Robert Love has a
patch to kill TIMER_BH, and I'm working on IMMEDIATE_BH.

-- 
Revolutions do not require corporate support.
