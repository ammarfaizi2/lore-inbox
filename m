Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbTHVJeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 05:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTHVJeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 05:34:17 -0400
Received: from [203.145.184.221] ([203.145.184.221]:52996 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263065AbTHVJeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 05:34:06 -0400
Subject: Re: [PATCH 2.6.0-test3-bk8][ATM] fix ambassador.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.com,
       Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030821193149.A18920@electric-eye.fr.zoreil.com>
References: <1061478906.1069.23.camel@lima.royalchallenge.com> 
	<20030821193149.A18920@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 22 Aug 2003 15:24:15 +0530
Message-Id: <1061546055.1108.7.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-21 at 23:01, Francois Romieu wrote:
> Vinay K Nallamothu <vinay-rc@naturesoft.net> :
> [...]
> > drivers/atm/ambassador.c: 
> > This patch cleans up sti/cli usage as well as minor timer cleanups.
> [...]
> 
> The "dont_panic" function which uses cli/sti is only called from code
> belonging to a "#if 0" section since revision 1.1 according to bk.
> 
> Remove it, everybody should feel better.
Thanks for the suggestions. Here is the updated patch. Applies cleanly
against 2.6.0-test3-bk9

drivers/atm/ambassador.c:
1. remove the function dont_panic which is mostly unused.
2. remove amb_ioctl which is never used.
3. minor timer code cleanups

 ambassador.c |  132
++---------------------------------------------------------
 1 files changed, 6 insertions(+), 126 deletions(-)

diff -urN linux-2.6.0-test3-bk9/drivers/atm/ambassador.c linux-2.6.0-test3-nvk/drivers/atm/ambassador.c
--- linux-2.6.0-test3-bk9/drivers/atm/ambassador.c	2003-08-22 15:04:47.000000000 +0530
+++ linux-2.6.0-test3-nvk/drivers/atm/ambassador.c	2003-08-22 14:56:11.000000000 +0530
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

