Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131808AbQKJVa0>; Fri, 10 Nov 2000 16:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131820AbQKJVaQ>; Fri, 10 Nov 2000 16:30:16 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:27666 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131808AbQKJVaD>;
	Fri, 10 Nov 2000 16:30:03 -0500
Date: Fri, 10 Nov 2000 16:29:51 -0500
Message-Id: <200011102129.QAA13369@havoc.gtf.org>
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com, netdev@oss.sgi.com
Subject: PATCH: 8139too kernel thread
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(note Linus, not for applying...)

Here is a patch, against 2.4.0-test11-pre2, that I wanted to forward
to the lists for comment.

Many of the ethernet drivers have timer routines, which are
called every three-five seconds or so.  These timer routines
typically do stuff related to media selection or checking, and call
mdio_{read,write} to interact with the phy.

I have converted the timer routine over to a kernel thread, to
gain some flexibility.  Most importantly we can sleep in the kernel
thread.. sometimes media selection takes a long time.  Also, figuring
out locking gets easier.  For the primary case I see, mdio_xxx usage
in timer and ioctl, converting to a kernel thread means we can grab
rtnl_lock in the thread and be totally identical with ioctl's locking
and sleeping rules.

Bonus features:  user can kill the thread to stop media pinging, can't
do this in most drivers.  And, if we want to do spiffy background
stuff, the framework will already be in place.

The main motivation for this scheme is that there are corner cases
all over the place (in other drivers) where code exists basically
because a timer is less flexible than a kthread.  Or, the timer does
evil stuff like delays for a -really- long time while doing media
selection, and it should be in a kthread anyway.

The only disadvantage to this scheme is the added cost of a kernel
thread over a kernel timer.  I think this is an ok cost, because this
is a low-impact thread that sleeps a lot..

Finally, there are some unrelated changes in the patch presented below.
Just ignore those :)


Index: linux_2_4/drivers/net/8139too.c
diff -u linux_2_4/drivers/net/8139too.c:1.1.1.7 linux_2_4/drivers/net/8139too.c:1.1.1.7.2.5
--- linux_2_4/drivers/net/8139too.c:1.1.1.7	Thu Nov  9 18:09:11 2000
+++ linux_2_4/drivers/net/8139too.c	Fri Nov 10 12:51:09 2000
@@ -134,6 +134,9 @@
 
 */
 
+#define __KERNEL_SYSCALLS__ 1
+
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -142,17 +145,20 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/delay.h>
+#include <linux/unistd.h>
 #include <asm/io.h>
 
 
-#define RTL8139_VERSION "0.9.11"
-#define RTL8139_MODULE_NAME "8139too"
-#define RTL8139_DRIVER_NAME   RTL8139_MODULE_NAME " Fast Ethernet driver " RTL8139_VERSION
-#define PFX RTL8139_MODULE_NAME ": "
+#define RTL8139_VERSION "0.9.12cvs"
+#define MODNAME "8139too"
+#define RTL8139_DRIVER_NAME   MODNAME " Fast Ethernet driver " RTL8139_VERSION
+#define PFX MODNAME ": "
 
 
-/* define to 1 to enable PIO instead of MMIO */
-#undef USE_IO_OPS
+/* enable PIO instead of MMIO, if CONFIG_8139TOO_PIO is selected */
+#ifdef CONFIG_8139TOO_PIO
+#define USE_IO_OPS 1
+#endif
 
 /* define to 1 to enable copious debugging info */
 #undef RTL8139_DEBUG
@@ -179,6 +185,8 @@
 #endif
 
 
+static int errno;
+
 /* A few user-configurable values. */
 /* media options */
 static int media[] = {-1, -1, -1, -1, -1, -1, -1, -1};
@@ -502,7 +510,6 @@
 	int drv_flags;
 	struct pci_dev *pci_dev;
 	struct net_device_stats stats;
-	struct timer_list timer;	/* Media selection timer. */
 	unsigned char *rx_ring;
 	unsigned int cur_rx;	/* Index into the Rx buffer of next Rx pkt. */
 	unsigned int tx_flag;
@@ -524,6 +531,9 @@
 	unsigned int mediasense:1;	/* Media sensing in progress. */
 	spinlock_t lock;
 	chip_t chipset;
+	wait_queue_head_t thr_wait;
+	int thr_shutdown;
+	pid_t thr_pid;
 };
 
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@mandrakesoft.com>");
@@ -538,7 +548,7 @@
 static int mdio_read (struct net_device *dev, int phy_id, int location);
 static void mdio_write (struct net_device *dev, int phy_id, int location,
 			int val);
-static void rtl8139_timer (unsigned long data);
+static int rtl8139_thread (void *data);
 static void rtl8139_tx_timeout (struct net_device *dev);
 static void rtl8139_init_ring (struct net_device *dev);
 static int rtl8139_start_xmit (struct sk_buff *skb,
@@ -867,7 +876,8 @@
 	tp->pci_dev = pdev;
 	tp->board = ent->driver_data;
 	tp->mmio_addr = ioaddr;
-	tp->lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init (&tp->lock);
+	init_waitqueue_head (&tp->thr_wait);
 
 	pdev->driver_data = dev;
 
@@ -897,7 +907,7 @@
 	RTL_W8_F (HltClk, 'H');	/* 'R' would leave the clock running. */
 
 	/* The lower four bits are the media type. */
-	option = (board_idx > 7) ? 0 : media[board_idx];
+	option = (board_idx >= ARRAY_SIZE(media)) ? 0 : media[board_idx];
 	if (option > 0) {
 		tp->full_duplex = (option & 0x200) ? 1 : 0;
 		tp->default_port = option & 15;
@@ -1193,6 +1203,7 @@
 
 	tp->full_duplex = tp->duplex_lock;
 	tp->tx_flag = (TX_FIFO_THRESH << 11) & 0x003f0000;
+	tp->twistie = 1;
 
 	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
@@ -1203,13 +1214,7 @@
 			dev->irq, RTL_R8 (MediaStatus),
 			tp->full_duplex ? "full" : "half");
 
-	/* Set the timer to switch to check for link beat and perhaps switch
-	   to an alternate media type. */
-	init_timer (&tp->timer);
-	tp->timer.expires = jiffies + 3 * HZ;
-	tp->timer.data = (unsigned long) dev;
-	tp->timer.function = &rtl8139_timer;
-	add_timer (&tp->timer);
+	tp->thr_pid = kernel_thread (rtl8139_thread, dev, 0);
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
@@ -1330,7 +1335,10 @@
 }
 
 
-#ifndef RTL_TUNE_TWISTER
+/* This must be global for CONFIG_8139TOO_TUNE_TWISTER case */
+static int next_tick = 3 * HZ;
+
+#ifndef CONFIG_8139TOO_TUNE_TWISTER
 static inline void rtl8139_tune_twister (struct net_device *dev,
 				  struct rtl8139_private *tp) {}
 #else
@@ -1338,6 +1346,7 @@
 				  struct rtl8139_private *tp)
 {
 	int linkcase;
+	void *ioaddr = tp->mmio_addr; /* SAM */
 
 	DPRINTK ("ENTER\n");
 
@@ -1421,18 +1430,18 @@
 
 	DPRINTK ("EXIT\n");
 }
-#endif /* RTL_TUNE_TWISTER */
+#endif /* CONFIG_8139TOO_TUNE_TWISTER */
 
 
-static void rtl8139_timer (unsigned long data)
+static void rtl8139_thread_iter (struct net_device *dev,
+				 struct rtl8139_private *tp,
+				 void *ioaddr)
 {
-	struct net_device *dev = (struct net_device *) data;
-	struct rtl8139_private *tp = (struct rtl8139_private *) dev->priv;
-	void *ioaddr = tp->mmio_addr;
-	int next_tick = 60 * HZ;
 	int mii_reg5;
 
+	spin_lock (&tp->lock);
 	mii_reg5 = mdio_read (dev, tp->phys[0], 5);
+	spin_unlock (&tp->lock);
 
 	if (!tp->duplex_lock && mii_reg5 != 0xffff) {
 		int duplex = (mii_reg5 & 0x0100)
@@ -1450,6 +1459,8 @@
 		}
 	}
 
+	next_tick = HZ * 60;
+
 	rtl8139_tune_twister (dev, tp);
 
 	DPRINTK ("%s: Media selection tick, Link partner %4.4x.\n",
@@ -1462,9 +1473,34 @@
 	DPRINTK ("%s:  Chip config %2.2x %2.2x.\n",
 		 dev->name, RTL_R8 (Config0),
 		 RTL_R8 (Config1));
+}
+
+
+static int rtl8139_thread (void *data)
+{
+	struct net_device *dev = data;
+	struct rtl8139_private *tp = dev->priv;
+	void *ioaddr = tp->mmio_addr;
+	unsigned long timeout;
+
+	MOD_INC_USE_COUNT;
 
-	tp->timer.expires = jiffies + next_tick;
-	add_timer (&tp->timer);
+	daemonize ();
+	sprintf (current->comm, "k8139d-%s", dev->name);
+
+	while (!test_bit(1, &tp->thr_shutdown)) {
+		timeout = next_tick;
+		do {
+			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
+		} while (!signal_pending (current) && (timeout > 0));
+		if (signal_pending (current))
+			break;
+
+		rtl8139_thread_iter (dev, tp, ioaddr);
+	}
+
+	MOD_DEC_USE_COUNT;
+	return 0;
 }
 
 
@@ -1550,11 +1586,20 @@
 	assert (tp->tx_info[entry].mapping == 0);
 
 	tp->tx_info[entry].skb = skb;
-	/* tp->tx_info[entry].mapping = 0; */
-	memcpy (tp->tx_buf[entry], skb->data, skb->len);
+	if ((long) skb->data & 3) {	/* Must use alignment buffer. */
+		/* tp->tx_info[entry].mapping = 0; */
+		memcpy (tp->tx_buf[entry], skb->data, skb->len);
+		RTL_W32 (TxAddr0 + (entry * 4),
+			 tp->tx_bufs_dma + (tp->tx_buf[entry] - tp->tx_bufs));
+	} else {
+		tp->tx_info[entry].mapping =
+		    pci_map_single (tp->pci_dev, skb->data, skb->len,
+				    PCI_DMA_TODEVICE);
+		RTL_W32 (TxAddr0 + (entry * 4), tp->tx_info[entry].mapping);
+	}
 
 	/* Note: the chip doesn't have auto-pad! */
-	RTL_W32 (TxStatus0 + (entry * sizeof(u32)),
+	RTL_W32 (TxStatus0 + (entry * sizeof (u32)),
 		 tp->tx_flag | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
 
 	dev->trans_start = jiffies;
@@ -1962,19 +2007,21 @@
 
 static int rtl8139_close (struct net_device *dev)
 {
-	struct rtl8139_private *tp = (struct rtl8139_private *) dev->priv;
+	struct rtl8139_private *tp = dev->priv;
 	void *ioaddr = tp->mmio_addr;
 	unsigned long flags;
 
 	DPRINTK ("ENTER\n");
 
+	set_bit (1, &tp->thr_shutdown);
+	wake_up_interruptible (&tp->thr_wait);
+	waitpid (tp->thr_pid, NULL, 0);
+
 	netif_stop_queue (dev);
 
 	DPRINTK ("%s: Shutting down ethercard, status was 0x%4.4x.\n",
 			dev->name, RTL_R16 (IntrStatus));
 
-	del_timer_sync (&tp->timer);
-
 	spin_lock_irqsave (&tp->lock, flags);
 
 	/* Stop the chip's Tx and Rx DMA processes. */
@@ -2015,9 +2062,8 @@
 
 static int mii_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct rtl8139_private *tp = (struct rtl8139_private *) dev->priv;
+	struct rtl8139_private *tp = dev->priv;
 	u16 *data = (u16 *) & rq->ifr_data;
-	unsigned long flags;
 	int rc = 0;
 
 	DPRINTK ("ENTER\n");
@@ -2028,9 +2074,9 @@
 		/* Fall Through */
 
 	case SIOCDEVPRIVATE + 1:	/* Read the specified MII register. */
-		spin_lock_irqsave (&tp->lock, flags);
+		spin_lock (&tp->lock);
 		data[3] = mdio_read (dev, data[0], data[1] & 0x1f);
-		spin_unlock_irqrestore (&tp->lock, flags);
+		spin_unlock (&tp->lock);
 		break;
 
 	case SIOCDEVPRIVATE + 2:	/* Write the specified MII register */
@@ -2039,9 +2085,9 @@
 			break;
 		}
 
-		spin_lock_irqsave (&tp->lock, flags);
+		spin_lock (&tp->lock);
 		mdio_write (dev, data[0], data[1] & 0x1f, data[2]);
-		spin_unlock_irqrestore (&tp->lock, flags);
+		spin_unlock (&tp->lock);
 		break;
 
 	default:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
