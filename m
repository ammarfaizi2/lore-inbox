Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbSJVAaD>; Mon, 21 Oct 2002 20:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSJVAaD>; Mon, 21 Oct 2002 20:30:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51204 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261837AbSJVAaB>;
	Mon, 21 Oct 2002 20:30:01 -0400
Message-ID: <3DB49D81.6000607@pobox.com>
Date: Mon, 21 Oct 2002 20:36:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: VDA@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: ewrk3 cli/sti removal by VDA
References: <20021019021340.GA8388@www.kroptech.com>
Content-Type: multipart/mixed;
 boundary="------------050809080806070906000705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050809080806070906000705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adam Kropelin wrote:
> Below is a patch from Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> which
> removes cli/sti in the ewrk3 driver. It tests out fine here with SMP & preempt.
> 
> Applies against 2.5.34 + ewrk3-ethtool patch. Also applies without ethtool patch
> with some offsets.
> 
> (Denis, I took the liberty of forwarding this to Jeff since it works fine for me
> and the driver is pretty much useless without it. Scream if you don't want it
> applied...)

Applied and then cleaned up...  ETHTOOL_PHYS_ID needs to use 
schedule_timeout(), and using typeof should be avoided.

New patch attached.

--------------050809080806070906000705
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.751   -> 1.752  
#	 drivers/net/ewrk3.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/21	jgarzik@redhat.com	1.752
# Remove cli/sti from ewrk3 net driver.
# Also, comment out ETHTOOL_PHYS_ID until its sleeping is fixed.
#   
# Originally by Denis Vlasenko, then via Adam Kropelin, and
# finally cleaned up by me.
# --------------------------------------------
#
diff -Nru a/drivers/net/ewrk3.c b/drivers/net/ewrk3.c
--- a/drivers/net/ewrk3.c	Mon Oct 21 20:35:04 2002
+++ b/drivers/net/ewrk3.c	Mon Oct 21 20:35:04 2002
@@ -262,20 +262,22 @@
 #define EWRK3_PKT_BIN_SZ  128	/* Should be >=100 unless you
 				   increase EWRK3_PKT_STAT_SZ */
 
+struct ewrk3_stats {
+	u32 bins[EWRK3_PKT_STAT_SZ];
+	u32 unicast;
+	u32 multicast;
+	u32 broadcast;
+	u32 excessive_collisions;
+	u32 tx_underruns;
+	u32 excessive_underruns;
+};
+
 struct ewrk3_private {
 	char adapter_name[80];	/* Name exported to /proc/ioports */
 	u_long shmem_base;	/* Shared memory start address */
 	u_long shmem_length;	/* Shared memory window length */
 	struct net_device_stats stats;	/* Public stats */
-	struct {
-		u32 bins[EWRK3_PKT_STAT_SZ];	/* Private stats counters */
-		u32 unicast;
-		u32 multicast;
-		u32 broadcast;
-		u32 excessive_collisions;
-		u32 tx_underruns;
-		u32 excessive_underruns;
-	} pktStats;
+	struct ewrk3_stats pktStats; /* Private stats counters */
 	u_char irq_mask;	/* Adapter IRQ mask bits */
 	u_char mPage;		/* Maximum 2kB Page number */
 	u_char lemac;		/* Chip rev. level */
@@ -940,6 +942,7 @@
 	spin_unlock(&lp->hw_lock);
 }
 
+/* Called with lp->hw_lock held */
 static int ewrk3_rx(struct net_device *dev)
 {
 	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
@@ -1065,8 +1068,9 @@
 }
 
 /*
-   ** Buffer sent - check for TX buffer errors.
- */
+** Buffer sent - check for TX buffer errors.
+** Called with lp->hw_lock held
+*/
 static int ewrk3_tx(struct net_device *dev)
 {
 	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
@@ -1760,6 +1764,7 @@
 		return 0;
 	}
 
+#ifdef BROKEN
 	/* Blink LED for identification */
 	case ETHTOOL_PHYS_ID: {
 		struct ethtool_value edata;
@@ -1813,6 +1818,7 @@
 		spin_unlock_irqrestore(&lp->hw_lock, flags);
 		return ret;
 	}
+#endif /* BROKEN */
 
 	}
 
@@ -1830,6 +1836,7 @@
 	u_long iobase = dev->base_addr;
 	int i, j, status = 0;
 	u_char csr;
+	unsigned long flags;
 	union ewrk3_addr {
 		u_char addr[HASH_TABLE_LEN * ETH_ALEN];
 		u_short val[(HASH_TABLE_LEN * ETH_ALEN) >> 1];
@@ -1953,19 +1960,26 @@
 		}
 
 		break;
-	case EWRK3_GET_STATS:	/* Get the driver statistics */
-		cli();
-		ioc->len = sizeof(lp->pktStats);
-		if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
-			status = -EFAULT;
-		sti();
+	case EWRK3_GET_STATS: { /* Get the driver statistics */
+		struct ewrk3_stats *tmp_stats =
+        		kmalloc(sizeof(lp->pktStats), GFP_KERNEL);
+		if (!tmp_stats) return -ENOMEM;
 
+		spin_lock_irqsave(&lp->hw_lock, flags);
+		memcpy(tmp_stats, &lp->pktStats, sizeof(lp->pktStats));
+		spin_unlock_irqrestore(&lp->hw_lock, flags);
+
+		ioc->len = sizeof(lp->pktStats);
+		if (copy_to_user(ioc->data, tmp_stats, sizeof(lp->pktStats)))
+    			status = -EFAULT;
+		kfree(tmp_stats);
 		break;
+	}
 	case EWRK3_CLR_STATS:	/* Zero out the driver statistics */
 		if (capable(CAP_NET_ADMIN)) {
-			cli();
+			spin_lock_irqsave(&lp->hw_lock, flags);
 			memset(&lp->pktStats, 0, sizeof(lp->pktStats));
-			sti();
+			spin_unlock_irqrestore(&lp->hw_lock,flags);
 		} else {
 			status = -EPERM;
 		}

--------------050809080806070906000705--

