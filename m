Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTHYMXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTHYMXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:23:12 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:14555 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261767AbTHYMWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:22:45 -0400
Message-Id: <200308251222.h7PCM3sG003428@ginger.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: Vinay K Nallamothu <vinay-rc@naturesoft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Reply-to: chas3@users.sourceforge.net
Subject: Re: [PATCH 2.6.0-test4][ATM][RESEND] fix ambassador.c 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Sun, 24 Aug 2003 03:46:37 PDT." <20030824034637.522fdeb3.davem@redhat.com> 
Date: Mon, 25 Aug 2003 08:22:04 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-2.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030824034637.522fdeb3.davem@redhat.com>,"David S. Miller" writes:
>Please make sure to send this to the ATM maintainer.  He's very
>responsible so I only take significant ATM patches that come through

responsible perhaps but slow.  anyway the changes seem fine.  del_timer
during module exit should probably be del_timer_sync so i have included
that as a seperate patch.

[atm]: [ambassador] clean up the code making use of sti/cli (from vinay-rc@naturesoft.net)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1281  -> 1.1282 
#	drivers/atm/ambassador.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/25	chas@relax.cmf.nrl.navy.mil	1.1282
# [ambassador] clean up the code making use of sti/cli (from vinay-rc@naturesoft.net)
# --------------------------------------------
#
diff -Nru a/drivers/atm/ambassador.c b/drivers/atm/ambassador.c
--- a/drivers/atm/ambassador.c	Mon Aug 25 08:12:53 2003
+++ b/drivers/atm/ambassador.c	Mon Aug 25 08:12:53 2003
@@ -310,10 +310,11 @@
   0xdeadbeef
 };
 
+static void do_housekeeping (unsigned long arg);
 /********** globals **********/
 
 static amb_dev * amb_devs = NULL;
-static struct timer_list housekeeping;
+static struct timer_list housekeeping = TIMER_INITIALIZER(do_housekeeping, 0, 1);
 
 static unsigned short debug = 0;
 static unsigned int cmds = 8;
@@ -937,63 +938,6 @@
   return IRQ_HANDLED;
 }
 
-/********** don't panic... yeah, right **********/
-
-#ifdef DEBUG_AMBASSADOR
-static void dont_panic (amb_dev * dev) {
-  amb_cq * cq = &dev->cq;
-  volatile amb_cq_ptrs * ptrs = &cq->ptrs;
-  amb_txq * txq;
-  amb_rxq * rxq;
-  command * cmd;
-  tx_in * tx;
-  tx_simple * tx_descr;
-  unsigned char pool;
-  rx_in * rx;
-  
-  unsigned long flags;
-  save_flags (flags);
-  cli();
-  
-  PRINTK (KERN_INFO, "don't panic - putting adapter into reset");
-  wr_plain (dev, offsetof(amb_mem, reset_control),
-	    rd_plain (dev, offsetof(amb_mem, reset_control)) | AMB_RESET_BITS);
-  
-  PRINTK (KERN_INFO, "marking all commands complete");
-  for (cmd = ptrs->start; cmd < ptrs->limit; ++cmd)
-    cmd->request = cpu_to_be32 (SRB_COMPLETE);
-
-  PRINTK (KERN_INFO, "completing all TXs");
-  txq = &dev->txq;
-  tx = txq->in.ptr;
-  while (txq->pending--) {
-    if (tx == txq->in.start)
-      tx = txq->in.limit;
-    --tx;
-    tx_descr = bus_to_virt (be32_to_cpu (tx->tx_descr_addr));
-    amb_kfree_skb (tx_descr->skb);
-    kfree (tx_descr);
-  }
-  
-  PRINTK (KERN_INFO, "freeing all RX buffers");
-  for (pool = 0; pool < NUM_RX_POOLS; ++pool) {
-    rxq = &dev->rxq[pool];
-    rx = rxq->in.ptr;
-    while (rxq->pending--) {
-      if (rx == rxq->in.start)
-	rx = rxq->in.limit;
-      --rx;
-      dev_kfree_skb_any (bus_to_virt (rx->handle));
-    }
-  }
-  
-  PRINTK (KERN_INFO, "don't panic over - close all VCs and rmmod");
-  set_bit (dead, &dev->flags);
-  restore_flags (flags);
-  return;
-}
-#endif
-
 /********** make rate (not quite as much fun as Horizon) **********/
 
 static unsigned int make_rate (unsigned int rate, rounding r,
@@ -1420,32 +1364,6 @@
   return;
 }
 
-/********** DebugIoctl **********/
-
-#if 0
-static int amb_ioctl (struct atm_dev * dev, unsigned int cmd, void * arg) {
-  unsigned short newdebug;
-  if (cmd == AMB_SETDEBUG) {
-    if (!capable(CAP_NET_ADMIN))
-      return -EPERM;
-    if (copy_from_user (&newdebug, arg, sizeof(newdebug))) {
-      // moan
-      return -EFAULT;
-    } else {
-      debug = newdebug;
-      return 0;
-    }
-  } else if (cmd == AMB_DONTPANIC) {
-    if (!capable(CAP_NET_ADMIN))
-      return -EPERM;
-    dont_panic (dev);
-  } else {
-    // moan
-    return -ENOIOCTLCMD;
-  }
-}
-#endif
-
 /********** Set socket options for a VC **********/
 
 // int amb_getsockopt (struct atm_vcc * atm_vcc, int level, int optname, void * optval, int optlen);
@@ -1524,33 +1442,6 @@
   tx.tx_descr_length = cpu_to_be16 (sizeof(tx_frag)+sizeof(tx_frag_end));
   tx.tx_descr_addr = cpu_to_be32 (virt_to_bus (&tx_descr->tx_frag));
   
-#ifdef DEBUG_AMBASSADOR
-  /* wey-hey! */
-  if (vc == 1023) {
-    unsigned int i;
-    unsigned short d = 0;
-    char * s = skb->data;
-    switch (*s++) {
-      case 'D': {
-	for (i = 0; i < 4; ++i) {
-	  d = (d<<4) | ((*s <= '9') ? (*s - '0') : (*s - 'a' + 10));
-	  ++s;
-	}
-	PRINTK (KERN_INFO, "debug bitmap is now %hx", debug = d);
-	break;
-      }
-      case 'R': {
-	if (*s++ == 'e' && *s++ == 's' && *s++ == 'e' && *s++ == 't')
-	  dont_panic (dev);
-	break;
-      }
-      default: {
-	break;
-      }
-    }
-  }
-#endif
-  
   while (tx_give (dev, &tx))
     schedule();
   return 0;
@@ -1663,21 +1554,14 @@
 /********** Operation Structure **********/
 
 static const struct atmdev_ops amb_ops = {
-  .open	= amb_open,
+  .open         = amb_open,
   .close	= amb_close,
-  .send	= amb_send,
+  .send         = amb_send,
   .proc_read	= amb_proc_read,
   .owner	= THIS_MODULE,
 };
 
 /********** housekeeping **********/
-
-static inline void set_timer (struct timer_list * timer, unsigned long delay) {
-  timer->expires = jiffies + delay;
-  add_timer (timer);
-  return;
-}
-
 static void do_housekeeping (unsigned long arg) {
   amb_dev * dev = amb_devs;
   // data is set to zero at module unload
@@ -1693,7 +1577,7 @@
       
       dev = dev->prev;
     }
-    set_timer (&housekeeping, 10*HZ);
+    mod_timer(&housekeeping, jiffies + 10*HZ);
   }
   
   return;
@@ -2579,11 +2463,7 @@
   devs = amb_probe();
   
   if (devs) {
-    init_timer (&housekeeping);
-    housekeeping.function = do_housekeeping;
-    // paranoia
-    housekeeping.data = 1;
-    set_timer (&housekeeping, 0);
+    mod_timer (&housekeeping, jiffies);
   } else {
     PRINTK (KERN_INFO, "no (usable) adapters found");
   }


[atm]: [ambassador] use del_timer_sync instead

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1282  -> 1.1283 
#	drivers/atm/ambassador.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/25	chas@relax.cmf.nrl.navy.mil	1.1283
# [ambassador] use del_timer_sync instead
# --------------------------------------------
#
diff -Nru a/drivers/atm/ambassador.c b/drivers/atm/ambassador.c
--- a/drivers/atm/ambassador.c	Mon Aug 25 08:13:04 2003
+++ b/drivers/atm/ambassador.c	Mon Aug 25 08:13:04 2003
@@ -2480,7 +2480,7 @@
   
   // paranoia
   housekeeping.data = 0;
-  del_timer (&housekeeping);
+  del_timer_sync(&housekeeping);
   
   while (amb_devs) {
     dev = amb_devs;
