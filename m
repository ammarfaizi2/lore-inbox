Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271758AbTHHSyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271756AbTHHSyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:54:02 -0400
Received: from palrel10.hp.com ([156.153.255.245]:40385 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S271750AbTHHSvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:51:18 -0400
Date: Fri, 8 Aug 2003 11:51:16 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] Donauboe probe fix
Message-ID: <20030808185116.GB13274@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir260_donau_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Christian Gennerat>
	o [CORRECT] Disable chip probing that fail too often
	o [FEATURE] Cleanup STATIC


diff -u -p linux/drivers/net/irda/donauboe.d1.c linux/drivers/net/irda/donauboe.c
--- linux/drivers/net/irda/donauboe.d1.c	Wed Jul 16 13:55:30 2003
+++ linux/drivers/net/irda/donauboe.c	Wed Jul 16 13:59:21 2003
@@ -6,6 +6,7 @@
  *                FIR Chipset, also supports the DONAUOBOE (type-DO
  *                or d01) FIR chipset which as far as I know is
  *                register compatible.
+ * Documentation: http://libxg.free.fr/irda/lib-irda.html
  * Status:        Experimental.
  * Author:        James McKenzie <james@fishsoup.dhs.org>
  * Created at:    Sat May 8  12:35:27 1999
@@ -25,6 +26,8 @@
  * Modified: 2.16 Sat Jun 22 18:54:29 2002 (fix freeregion, default to verbose)
  * Modified: 2.17 Christian Gennerat <christian.gennerat@polytechnique.org>
  * Modified: 2.17 jeu sep 12 08:50:20 2002 (save_flags();cli(); replaced by spinlocks)
+ * Modified: 2.18 Christian Gennerat <christian.gennerat@polytechnique.org>
+ * Modified: 2.18 ven jan 10 03:14:16 2003 Change probe default options
  *
  *     Copyright (c) 1999 James McKenzie, All Rights Reserved.
  *
@@ -48,7 +51,7 @@
 
 
 static char *rcsid =
-  "$Id: donauboe.c V2.17 jeu sep 12 08:50:20 2002 $";
+  "$Id: donauboe.c V2.18 ven jan 10 03:14:16 2003$";
 
 /* See below for a description of the logic in this driver */
 
@@ -57,12 +60,14 @@ static char *rcsid =
 #undef CRC_EXPORTED
 
 /* User servicable parts */
-/* Enable the code which probes the chip and does a few tests */
+/* USE_PROBE Create the code which probes the chip and does a few tests */
+/* do_probe module parameter Enable this code */
 /* Probe code is very useful for understanding how the hardware works */
 /* Use it with various combinations of TT_LEN, RX_LEN */
 /* Strongly recomended, disable if the probe fails on your machine */
 /* and send me <james@fishsoup.dhs.org> the output of dmesg */
-#define DO_PROBE 1
+#define USE_PROBE 1
+#undef  USE_PROBE
 
 /* Trace Transmit ring, interrupts, Receive ring or not ? */
 #define PROBE_VERBOSE 1
@@ -145,8 +150,6 @@ static char *rcsid =
 
 /* No user servicable parts below here */
 
-#define STATIC static
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -200,7 +203,9 @@ MODULE_DEVICE_TABLE(pci, toshoboe_pci_tb
 static char *driver_name = DRIVER_NAME;
 
 static int max_baud = 4000000;
-static int do_probe = DO_PROBE;
+#ifdef USE_PROBE
+static int do_probe = 0;
+#endif
 
 
 /**********************************************************************/
@@ -245,7 +250,7 @@ static __u16 const irda_crc16_table[256]
 };
 #endif
 
-STATIC int
+static int
 toshoboe_checkfcs (unsigned char *buf, int len)
 {
   int i;
@@ -268,7 +273,7 @@ toshoboe_checkfcs (unsigned char *buf, i
 /* Generic chip handling code */
 #ifdef DUMP_PACKETS
 static unsigned char dump[50];
-STATIC void 
+static void
 _dumpbufs (unsigned char *data, int len, char tete)
 {
 int i,j;
@@ -277,13 +282,14 @@ for (i=0;i<len;i+=16) {
     for (j=0;j<16 && i+j<len;j++) { sprintf(&dump[3*j],"%02x.",data[i+j]); }
     dump [3*j]=0;
     IRDA_DEBUG (2, "%c%s\n",head , dump);
-    head='+'; 
+    head='+';
     }
 }
 #endif
 
+#ifdef USE_PROBE
 /* Dump the registers */
-STATIC void
+static void
 toshoboe_dumpregs (struct toshoboe_cb *self)
 {
   __u32 ringbase;
@@ -329,9 +335,10 @@ toshoboe_dumpregs (struct toshoboe_cb *s
       printk ("\n");
     }
 }
+#endif
 
 /*Don't let the chip look at memory */
-STATIC void
+static void
 toshoboe_disablebm (struct toshoboe_cb *self)
 {
   __u8 command;
@@ -344,7 +351,7 @@ toshoboe_disablebm (struct toshoboe_cb *
 }
 
 /* Shutdown the chip and point the taskfile reg somewhere else */
-STATIC void
+static void
 toshoboe_stopchip (struct toshoboe_cb *self)
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
@@ -376,7 +383,7 @@ toshoboe_stopchip (struct toshoboe_cb *s
 }
 
 /* Transmitter initialization */
-STATIC void
+static void
 toshoboe_start_DMA (struct toshoboe_cb *self, int opts)
 {
   OUTB (0x0, OBOE_ENABLEH);
@@ -386,7 +393,7 @@ toshoboe_start_DMA (struct toshoboe_cb *
 }
 
 /*Set the baud rate */
-STATIC void
+static void
 toshoboe_setbaud (struct toshoboe_cb *self)
 {
   __u16 pconfig = 0;
@@ -521,7 +528,7 @@ toshoboe_setbaud (struct toshoboe_cb *se
 }
 
 /*Let the chip look at memory */
-STATIC void
+static void
 toshoboe_enablebm (struct toshoboe_cb *self)
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
@@ -529,7 +536,7 @@ toshoboe_enablebm (struct toshoboe_cb *s
 }
 
 /*setup the ring */
-STATIC void
+static void
 toshoboe_initring (struct toshoboe_cb *self)
 {
   int i;
@@ -552,7 +559,7 @@ toshoboe_initring (struct toshoboe_cb *s
     }
 }
 
-STATIC void
+static void
 toshoboe_resetptrs (struct toshoboe_cb *self)
 {
   /* Can reset pointers by twidling DMA */
@@ -565,7 +572,7 @@ toshoboe_resetptrs (struct toshoboe_cb *
 }
 
 /* Called in locked state */
-STATIC void
+static void
 toshoboe_initptrs (struct toshoboe_cb *self)
 {
 
@@ -587,7 +594,7 @@ toshoboe_initptrs (struct toshoboe_cb *s
 
 /* Wake the chip up and get it looking at the rings */
 /* Called in locked state */
-STATIC void
+static void
 toshoboe_startchip (struct toshoboe_cb *self)
 {
   __u32 physaddr;
@@ -645,12 +652,12 @@ toshoboe_startchip (struct toshoboe_cb *
   toshoboe_initptrs (self);
 }
 
-STATIC void
+static void
 toshoboe_isntstuck (struct toshoboe_cb *self)
 {
 }
 
-STATIC void
+static void
 toshoboe_checkstuck (struct toshoboe_cb *self)
 {
   unsigned long flags;
@@ -669,7 +676,7 @@ toshoboe_checkstuck (struct toshoboe_cb 
 }
 
 /*Generate packet of about mtt us long */
-STATIC int
+static int
 toshoboe_makemttpacket (struct toshoboe_cb *self, void *buf, int mtt)
 {
   int xbofs;
@@ -678,7 +685,7 @@ toshoboe_makemttpacket (struct toshoboe_
   xbofs=xbofs/80000; /*Eight bits per byte, and mtt is in us*/
   xbofs++;
 
-  IRDA_DEBUG (2, DRIVER_NAME 
+  IRDA_DEBUG (2, DRIVER_NAME
       ": generated mtt of %d bytes for %d us at %d baud\n"
 	  , xbofs,mtt,self->speed);
 
@@ -695,10 +702,17 @@ toshoboe_makemttpacket (struct toshoboe_
   return xbofs;
 }
 
+static int toshoboe_invalid_dev(int irq)
+{
+  printk (KERN_WARNING DRIVER_NAME ": irq %d for unknown device.\n", irq);
+  return 1;
+}
+
+#ifdef USE_PROBE
 /***********************************************************************/
 /* Probe code */
 
-STATIC void
+static void
 toshoboe_dumptx (struct toshoboe_cb *self)
 {
   int i;
@@ -708,7 +722,7 @@ toshoboe_dumptx (struct toshoboe_cb *sel
   PROBE_DEBUG(" [%d]\n",self->speed);
 }
 
-STATIC void
+static void
 toshoboe_dumprx (struct toshoboe_cb *self, int score)
 {
   int i;
@@ -739,19 +753,13 @@ stuff_byte (__u8 byte, __u8 * buf)
     }
 }
 
-STATIC int toshoboe_invalid_dev(int irq) 
-{
-  printk (KERN_WARNING DRIVER_NAME ": irq %d for unknown device.\n", irq);
-  return 1;
-}
-
-STATIC irqreturn_t
+static irqreturn_t
 toshoboe_probeinterrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb *) dev_id;
   __u8 irqstat;
 
-  if (self == NULL && toshoboe_invalid_dev(irq)) 
+  if (self == NULL && toshoboe_invalid_dev(irq))
     return IRQ_NONE;
 
   irqstat = INB (OBOE_ISR);
@@ -794,7 +802,7 @@ toshoboe_probeinterrupt (int irq, void *
   return IRQ_HANDLED;
 }
 
-STATIC int
+static int
 toshoboe_maketestpacket (unsigned char *buf, int badcrc, int fir)
 {
   int i;
@@ -831,7 +839,7 @@ toshoboe_maketestpacket (unsigned char *
   return len;
 }
 
-STATIC int
+static int
 toshoboe_probefail (struct toshoboe_cb *self, char *msg)
 {
   printk (KERN_ERR DRIVER_NAME "probe(%d) failed %s\n",self-> speed, msg);
@@ -841,7 +849,7 @@ toshoboe_probefail (struct toshoboe_cb *
   return 0;
 }
 
-STATIC int
+static int
 toshoboe_numvalidrcvs (struct toshoboe_cb *self)
 {
   int i, ret = 0;
@@ -852,7 +860,7 @@ toshoboe_numvalidrcvs (struct toshoboe_c
   return ret;
 }
 
-STATIC int
+static int
 toshoboe_numrcvs (struct toshoboe_cb *self)
 {
   int i, ret = 0;
@@ -863,7 +871,7 @@ toshoboe_numrcvs (struct toshoboe_cb *se
   return ret;
 }
 
-STATIC int
+static int
 toshoboe_probe (struct toshoboe_cb *self)
 {
   int i, j, n;
@@ -899,7 +907,7 @@ toshoboe_probe (struct toshoboe_cb *self
       self->speed = bauds[j];
       toshoboe_setbaud (self);
       toshoboe_initptrs (self);
-      spin_unlock_irqrestore(&self->spinlock, flags); 
+      spin_unlock_irqrestore(&self->spinlock, flags);
 
       self->ring->tx[self->txs].control =
 /*   (FIR only) OBOE_CTL_TX_SIP needed for switching to next slot */
@@ -919,7 +927,7 @@ toshoboe_probe (struct toshoboe_cb *self
       self->txs++;
       self->txs %= TX_SLOTS;
 
-      self->ring->tx[self->txs].control = 
+      self->ring->tx[self->txs].control =
         (fir) ? OBOE_CTL_TX_HW_OWNS | OBOE_CTL_TX_RTCENTX
               : OBOE_CTL_TX_HW_OWNS ;
       self->ring->tx[self->txs].len =
@@ -1014,12 +1022,13 @@ toshoboe_probe (struct toshoboe_cb *self
 
   return 1;
 }
+#endif
 
 /******************************************************************/
 /* Netdev style code */
 
 /* Transmit something */
-STATIC int
+static int
 toshoboe_hard_xmit (struct sk_buff *skb, struct net_device *dev)
 {
   struct toshoboe_cb *self;
@@ -1032,12 +1041,12 @@ toshoboe_hard_xmit (struct sk_buff *skb,
 
   ASSERT (self != NULL, return 0; );
 
-  IRDA_DEBUG (1, "%s.tx:%x(%x)%x\n", __FUNCTION__ 
+  IRDA_DEBUG (1, "%s.tx:%x(%x)%x\n", __FUNCTION__
       ,skb->len,self->txpending,INB (OBOE_ENABLEH));
   if (!cb->magic) {
       IRDA_DEBUG (2, "%s.Not IrLAP:%x\n", __FUNCTION__, cb->magic);
 #ifdef DUMP_PACKETS
-      _dumpbufs(skb->data,skb->len,'>'); 
+      _dumpbufs(skb->data,skb->len,'>');
 #endif
     }
 
@@ -1066,7 +1075,7 @@ toshoboe_hard_xmit (struct sk_buff *skb,
           IRDA_DEBUG (1, "%s: Queued TxDone scheduled speed change %d\n" ,
 		      __FUNCTION__, speed);
           /* if no data, that's all! */
-          if (!skb->len) 
+          if (!skb->len)
             {
 	      spin_unlock_irqrestore(&self->spinlock, flags);
               dev_kfree_skb (skb);
@@ -1074,12 +1083,12 @@ toshoboe_hard_xmit (struct sk_buff *skb,
             }
           /* True packet, go on, but */
           /* do not accept anything before change speed execution */
-          netif_stop_queue(dev); 
+          netif_stop_queue(dev);
           /* ready to process TxDone interrupt */
 	  spin_unlock_irqrestore(&self->spinlock, flags);
         }
       else
-        { 
+        {
           /* idle and no data, change speed now */
           self->speed = speed;
           toshoboe_setbaud (self);
@@ -1106,7 +1115,7 @@ toshoboe_hard_xmit (struct sk_buff *skb,
       /* which we will add a wrong checksum to */
 
       mtt = toshoboe_makemttpacket (self, self->tx_bufs[self->txs], mtt);
-      IRDA_DEBUG (1, "%s.mtt:%x(%x)%d\n", __FUNCTION__ 
+      IRDA_DEBUG (1, "%s.mtt:%x(%x)%d\n", __FUNCTION__
           ,skb->len,mtt,self->txpending);
       if (mtt)
         {
@@ -1143,7 +1152,7 @@ toshoboe_hard_xmit (struct sk_buff *skb,
     }
 
 #ifdef DUMP_PACKETS
-dumpbufs(skb->data,skb->len,'>'); 
+dumpbufs(skb->data,skb->len,'>');
 #endif
 
   spin_lock_irqsave(&self->spinlock, flags);
@@ -1196,14 +1205,14 @@ dumpbufs(skb->data,skb->len,'>'); 
 }
 
 /*interrupt handler */
-STATIC irqreturn_t
+static irqreturn_t
 toshoboe_interrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb *) dev_id;
   __u8 irqstat;
   struct sk_buff *skb = NULL;
 
-  if (self == NULL && toshoboe_invalid_dev(irq)) 
+  if (self == NULL && toshoboe_invalid_dev(irq))
     return IRQ_NONE;
 
   irqstat = INB (OBOE_ISR);
@@ -1276,7 +1285,7 @@ toshoboe_interrupt (int irq, void *dev_i
         {
           int len = self->ring->rx[self->rxs].len;
           skb = NULL;
-          IRDA_DEBUG (3, "%s.rcv:%x(%x)\n", __FUNCTION__ 
+          IRDA_DEBUG (3, "%s.rcv:%x(%x)\n", __FUNCTION__
 		      ,len,self->ring->rx[self->rxs].control);
 
 #ifdef DUMP_PACKETS
@@ -1319,7 +1328,7 @@ dumpbufs(self->rx_bufs[self->rxs],len,'<
                       len = 0;
                   IRDA_DEBUG (1, "%s.FIR:%x(%x)\n", __FUNCTION__, len,enable);
                 }
-              else 
+              else
                   IRDA_DEBUG (0, "%s.?IR:%x(%x)\n", __FUNCTION__, len,enable);
 
               if (len)
@@ -1339,13 +1348,13 @@ dumpbufs(self->rx_bufs[self->rxs],len,'<
                     }
                   else
                     {
-                      printk (KERN_INFO 
+                      printk (KERN_INFO
                               "%s(), memory squeeze, dropping frame.\n",
 			      __FUNCTION__);
                     }
                 }
             }
-          else 
+          else
             {
             /* TODO: =========================================== */
             /*  if OBOE_CTL_RX_LENGTH, our buffers are too small */
@@ -1387,7 +1396,7 @@ dumpbufs(self->rx_bufs[self->rxs],len,'<
   return IRQ_HANDLED;
 }
 
-STATIC int
+static int
 toshoboe_net_init (struct net_device *dev)
 {
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
@@ -1402,7 +1411,7 @@ toshoboe_net_init (struct net_device *de
   return 0;
 }
 
-STATIC int
+static int
 toshoboe_net_open (struct net_device *dev)
 {
   struct toshoboe_cb *self;
@@ -1445,7 +1454,7 @@ toshoboe_net_open (struct net_device *de
   return 0;
 }
 
-STATIC int
+static int
 toshoboe_net_close (struct net_device *dev)
 {
   struct toshoboe_cb *self;
@@ -1481,7 +1490,7 @@ toshoboe_net_close (struct net_device *d
  *    Process IOCTL commands for this device
  *
  */
-STATIC int
+static int
 toshoboe_net_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
   struct if_irda_req *irq = (struct if_irda_req *) rq;
@@ -1546,10 +1555,12 @@ MODULE_LICENSE("GPL");
 MODULE_PARM (max_baud, "i");
 MODULE_PARM_DESC(max_baud, "Maximum baud rate");
 
+#ifdef USE_PROBE
 MODULE_PARM (do_probe, "i");
 MODULE_PARM_DESC(do_probe, "Enable/disable chip probing and self-test");
+#endif
 
-STATIC void
+static void
 toshoboe_close (struct pci_dev *pci_dev)
 {
   int i;
@@ -1588,7 +1599,7 @@ toshoboe_close (struct pci_dev *pci_dev)
   return;
 }
 
-STATIC int
+static int
 toshoboe_open (struct pci_dev *pci_dev, const struct pci_device_id *pdid)
 {
   struct toshoboe_cb *self;
@@ -1634,7 +1645,7 @@ toshoboe_open (struct pci_dev *pci_dev, 
     }
 
   spin_lock_init(&self->spinlock);
-  
+
   irda_init_max_qos_capabilies (&self->qos);
   self->qos.baud_rate.bits = 0;
 
@@ -1711,12 +1722,15 @@ toshoboe_open (struct pci_dev *pci_dev, 
       goto freebufs;
     }
 
+
+#ifdef USE_PROBE
   if (do_probe)
     if (!toshoboe_probe (self))
       {
         err = -ENODEV;
         goto freebufs;
       }
+#endif
 
   if (!(dev = dev_alloc ("irda%d", &err)))
     {
@@ -1770,7 +1784,7 @@ freeself:
   return err;
 }
 
-STATIC int
+static int
 toshoboe_gotosleep (struct pci_dev *pci_dev, u32 crap)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
@@ -1799,7 +1813,7 @@ toshoboe_gotosleep (struct pci_dev *pci_
   return 0;
 }
 
-STATIC int
+static int
 toshoboe_wakeup (struct pci_dev *pci_dev)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
