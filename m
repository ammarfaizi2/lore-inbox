Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbSBKFnu>; Mon, 11 Feb 2002 00:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287212AbSBKFnl>; Mon, 11 Feb 2002 00:43:41 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:3757 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S287208AbSBKFni>; Mon, 11 Feb 2002 00:43:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] [CFT] First take on porting 8139too to new kthread API
Date: Sun, 10 Feb 2002 23:42:55 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Christoph Hellwig <hch@caldera.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020211054332.JVFK1147.rwcrmhc52.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This work was done as part of the Kernel Janitors weekend party.  Believe the 
rumors; I saw Jules Asner here, it was a wild party!

Below find my first take on porting the 8139too driver to the new kthread 
API.  This patch is against 2.5.3-dj5 plus Christoph's kthread API.  I don't 
have an 8139 to test on, so if you have hardware, please let me how this 
works.  Jeff, Christoph: is there anything I misunderstood in my changes?

-- 
akk~

=============================================================================

diff -u /home/adam/code/kernel/janitor-linux.orig/drivers/net/8139too.c 
/home/adam/code/kernel/janitor-linux/drivers/net/8139too.c
--- /home/adam/code/kernel/janitor-linux.orig/drivers/net/8139too.c	Sun Feb 
10 23:23:22 2002
+++ /home/adam/code/kernel/janitor-linux/drivers/net/8139too.c	Sun Feb 10 
23:23:22 2002
@@ -82,6 +82,8 @@
 
 		Robert Kuebel - Save kernel thread from dying on any signal.
 
+		Adam Keys - Changed to new kthread API
+
 	Submitting bug reports:
 
 		"rtl8139-diag -mmmaaavvveefN" output
@@ -110,6 +112,7 @@
 #include <linux/mii.h>
 #include <linux/completion.h>
 #include <linux/crc32.h>
+#include <linux/kthread.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -556,7 +559,7 @@
 	unsigned int medialock:1;	/* Don't sense media type. */
 	spinlock_t lock;
 	chip_t chipset;
-	pid_t thr_pid;
+	struct kthread *thr;
 	wait_queue_head_t thr_wait;
 	struct completion thr_exited;
 	u32 rx_config;
@@ -585,7 +588,7 @@
 static int mdio_read (struct net_device *dev, int phy_id, int location);
 static void mdio_write (struct net_device *dev, int phy_id, int location,
 			int val);
-static int rtl8139_thread (void *data);
+static int rtl8139_thread (struct kthread *kth, void *data);
 static void rtl8139_tx_timeout (struct net_device *dev);
 static void rtl8139_init_ring (struct net_device *dev);
 static int rtl8139_start_xmit (struct sk_buff *skb,
@@ -1291,10 +1294,18 @@
 			dev->irq, RTL_R8 (MediaStatus),
 			tp->mii.full_duplex ? "full" : "half");
 
-	tp->thr_pid = kernel_thread (rtl8139_thread, dev, CLONE_FS | CLONE_FILES);
-	if (tp->thr_pid < 0)
-		printk (KERN_WARNING "%s: unable to start kernel thread\n",
-			dev->name);
+	tp->thr = (struct kthread*)kmalloc( sizeof( struct kthread ), GFP_KERNEL );
+	if ( tp->thr == NULL ) {
+		printk( KERN_ERR "8139too: Could not allocate memory for kthread\n" );
+		return -ENOMEM;
+	}
+
+	tp->thr->name = "8139too";
+	tp->thr->main = rtl8139_thread;
+	if ( kthread_start( tp->thr, dev ) < 0 ) {
+		printk( KERN_WARNING "%s: unable to start kernel thread\n", dev->name );
+	}
+		
 
 	return 0;
 }
@@ -1547,7 +1562,7 @@
 }
 
 
-static int rtl8139_thread (void *data)
+static int rtl8139_thread (struct kthread *kth, void *data)
 {
 	struct net_device *dev = data;
 	struct rtl8139_private *tp = dev->priv;
@@ -2080,21 +2095,17 @@
 {
 	struct rtl8139_private *tp = dev->priv;
 	void *ioaddr = tp->mmio_addr;
-	int ret = 0;
 	unsigned long flags;
 
 	netif_stop_queue (dev);
 
-	if (tp->thr_pid >= 0) {
+	if ( tp->thr != NULL ) {
 		tp->time_to_die = 1;
 		wmb();
-		ret = kill_proc (tp->thr_pid, SIGTERM, 1);
