Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbTGDCVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTGDCTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:19:14 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:40103 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265665AbTGDCRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:17:17 -0400
Date: Thu, 03 Jul 2003 22:31:27 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Message-id: <200307032231.39842.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_5+ztBL0+KOSUBUfAD6Oe6Q)"
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_5+ztBL0+KOSUBUfAD6Oe6Q)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The variables for network statistics (in struct net_device_stats) are unsigned 
longs. On 32-bit architectures, this makes them overflow every 4GB or 2^32 
packets. The following series of patches [against 2.5.74] makes the 
statistics variable type configurable. The default is to leave everything the 
way it was (unsigned long). However, when NETSTATS64 is set in the config, 
the statistics use 64-bit variables (u_int64_t) - this works only on 32-bit 
architectures.

These patches are *not* ready to be included due to the fact that they add an 
API layer that controls the statistics and all the drivers have to be 
checked. For easier coding, the patch renames the fields in struct 
net_device_stat - this breaks everything (so all the previous code is easily 
visible.)  (The names are prefixed with _.)

This is a RFC, please let me know what you think should be improved.

*NOTE* I am aware that locking is suboptimal - I am looking for other 
solutions.

The patches include:
	- Documentation/networking/64bitstats.txt with description of the API, and 
current status of this project (I'm not sure about some of the arch dependent 
suff)
	- updated drivers to use new API
		- 8139too
		- 8390
		- dummy
		- eepro100
		- loopback
		- ne2k-pci
		- pcnet32
	- update for procfs and sysfs interfaces

Thanks,
Jeff.

- -- 
You measure democracy by the freedom it gives its dissidents, not the
freedom it gives its assimilated conformists.
		- Abbie Hoffman




-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BOcHwFP0+seVj/4RAs8dAJ9UqAyKB3ADE11o6Wo5kP2MYMUrVACeMWKw
OiQPdQD85s9u+G4F/t0GraA=
=aZf/
-----END PGP SIGNATURE-----

--Boundary_(ID_5+ztBL0+KOSUBUfAD6Oe6Q)
Content-type: text/x-diff; charset=us-ascii; name=net.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=net.diff

diff -X dontdiff -Naur linux-2.5.74-vanilla/net/Kconfig linux-2.5.74-nx/net/Kconfig
--- linux-2.5.74-vanilla/net/Kconfig	2003-07-02 16:40:31.000000000 -0400
+++ linux-2.5.74-nx/net/Kconfig	2003-07-03 15:11:00.000000000 -0400
@@ -48,6 +48,20 @@
 	  mechanism that results in faster communication.
 
 	  If unsure, say N.
+  
+config NETSTATS64
+	bool "64-bit statistics"
+	depends on NET && (X86 || ARM || PARISC || SPARC32) && !(X86_64)
+	help
+	  If you say Y here, the network statistics will use 64-bit values
+	  no matter what architecture you are on. If you are on a 64-bit
+	  architecture, say N here, the overhead required by this code is
+	  not justifiable. If, however you are on a 32-bit architecture,
+	  you have a choice. You can say:
+	  	Y and statistics will be 64-bit
+	  	N and statistics will remain 32-bit
+	  	
+	  If unsure, say N.
 
 config NETLINK_DEV
 	tristate "Netlink device emulation"
diff -X dontdiff -Naur linux-2.5.74-vanilla/net/core/dev.c linux-2.5.74-nx/net/core/dev.c
--- linux-2.5.74-vanilla/net/core/dev.c	2003-07-02 16:48:08.000000000 -0400
+++ linux-2.5.74-nx/net/core/dev.c	2003-07-03 15:11:00.000000000 -0400
@@ -18,6 +18,7 @@
  *		Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
  *		Adam Sulmicki <adam@cfar.umd.edu>
  *              Pekka Riikonen <priikone@poesidon.pspt.fi>
+ *		Josef "Jeff" Sipek <jeffpc@optonline.net>
  *
  *	Changes:
  *              D.J. Barrow     :       Fixed bug where dev->refcnt gets set
@@ -70,6 +71,7 @@
  *              			indefinitely on dev->refcnt
  * 		J Hadi Salim	:	- Backlog queue sampling
  *				        - netif_rx() feedback
+ *	Josef "Jeff" Sipek	:	- using new API for network statistics
  */
 
 #include <asm/uaccess.h>
@@ -1869,23 +1871,23 @@
 	struct net_device_stats *stats = dev->get_stats ? dev->get_stats(dev) :
 							  NULL;
 	if (stats)
-		seq_printf(seq, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
-				"%8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
-			   dev->name, stats->rx_bytes, stats->rx_packets,
-			   stats->rx_errors,
-			   stats->rx_dropped + stats->rx_missed_errors,
-			   stats->rx_fifo_errors,
-			   stats->rx_length_errors + stats->rx_over_errors +
-			     stats->rx_crc_errors + stats->rx_frame_errors,
-			   stats->rx_compressed, stats->multicast,
-			   stats->tx_bytes, stats->tx_packets,
-			   stats->tx_errors, stats->tx_dropped,
-			   stats->tx_fifo_errors, stats->collisions,
-			   stats->tx_carrier_errors +
-			     stats->tx_aborted_errors +
-			     stats->tx_window_errors +
-			     stats->tx_heartbeat_errors,
-			   stats->tx_compressed);
+		seq_printf(seq, "%6s:%8llu %7llu %4llu %4llu %4llu %5llu %10llu %9llu "
+				"%8llu %7llu %4llu %4llu %4llu %5llu %7llu %10llu\n",
+			   dev->name, net_stats_get(rx_bytes,stats), net_stats_get(rx_packets,stats),
+			   net_stats_get(rx_errors,stats),
+			   net_stats_get(rx_dropped,stats) + net_stats_get(rx_missed_errors,stats),
+			   net_stats_get(rx_fifo_errors,stats),
+			   net_stats_get(rx_length_errors,stats) + net_stats_get(rx_over_errors,stats) +
+			     net_stats_get(rx_crc_errors,stats) + net_stats_get(rx_frame_errors,stats),
+			   net_stats_get(rx_compressed,stats), net_stats_get(multicast,stats),
+			   net_stats_get(tx_bytes,stats), net_stats_get(tx_packets,stats),
+			   net_stats_get(tx_errors,stats), net_stats_get(tx_dropped,stats),
+			   net_stats_get(tx_fifo_errors,stats), net_stats_get(collisions,stats),
+			   net_stats_get(tx_carrier_errors,stats) +
+			     net_stats_get(tx_aborted_errors,stats) +
+			     net_stats_get(tx_window_errors,stats) +
+			     net_stats_get(tx_heartbeat_errors,stats),
+			   net_stats_get(tx_compressed,stats));
 	else
 		seq_printf(seq, "%6s: No statistics available.\n", dev->name);
 }
diff -X dontdiff -Naur linux-2.5.74-vanilla/net/core/net-sysfs.c linux-2.5.74-nx/net/core/net-sysfs.c
--- linux-2.5.74-vanilla/net/core/net-sysfs.c	2003-07-02 16:55:46.000000000 -0400
+++ linux-2.5.74-nx/net/core/net-sysfs.c	2003-07-03 15:11:00.000000000 -0400
@@ -2,6 +2,9 @@
  * net-sysfs.c - network device class and attributes
  *
  * Copyright (c) 2003 Stephen Hemminber <shemminger@osdl.org>
+ *
+ * Copyright (c) 2003 Josef "Jeff" Sipek <jeffpc@optonline.net>
+ *	- Now using the "New" Networks statistics API
  * 
  */
 
@@ -180,21 +183,21 @@
 
 struct netstat_fs_entry {
 	struct attribute attr;
-	ssize_t (*show)(const struct net_device_stats *, char *);
+	ssize_t (*show)(struct net_device_stats *, char *);
 	ssize_t (*store)(struct net_device_stats *, const char *, size_t);
 };
 
-static ssize_t net_device_stat_show(unsigned long var, char *buf)
+static ssize_t net_device_stat_show(u_int64_t var, char *buf)
 {
-	return sprintf(buf, "%ld\n", var);
+	return sprintf(buf, "%llu\n", var);
 }
 
 /* generate a read-only statistics attribute */
 #define NETDEVICE_STAT(_NAME)						\
-static ssize_t show_stat_##_NAME(const struct net_device_stats *stats,	\
+static ssize_t show_stat_##_NAME(struct net_device_stats *stats,	\
 				 char *buf)				\
 {									\
-	return net_device_stat_show(stats->_NAME, buf);			\
+	return net_device_stat_show(net_stats_get(_NAME,stats), buf);	\
 }									\
 static struct netstat_fs_entry net_stat_##_NAME  = {		   	\
 	.attr = {.name = __stringify(_NAME), .mode = S_IRUGO },		\
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/linux/if_vlan.h linux-2.5.74-nx/include/linux/if_vlan.h
--- linux-2.5.74-vanilla/include/linux/if_vlan.h	2003-07-02 16:42:17.000000000 -0400
+++ linux-2.5.74-nx/include/linux/if_vlan.h	2003-07-03 15:11:00.000000000 -0400
@@ -2,6 +2,7 @@
  * VLAN		An implementation of 802.1Q VLAN tagging.
  *
  * Authors:	Ben Greear <greearb@candelatech.com>
+ *		Josef "Jeff" Sipek <jeffpc@optonline.net>
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -162,8 +163,8 @@
 	skb->dev->last_rx = jiffies;
 
 	stats = vlan_dev_get_stats(skb->dev);
-	stats->rx_packets++;
-	stats->rx_bytes += skb->len;
+	net_stats_inc(rx_packets,stats);
+	net_stats_add(rx_bytes,stats,skb->len);
 
 	skb->priority = vlan_get_ingress_priority(skb->dev, vlan_tag);
 	switch (skb->pkt_type) {
@@ -171,7 +172,7 @@
 		break;
 
 	case PACKET_MULTICAST:
-		stats->multicast++;
+		net_stats_inc(multicast,stats);
 		break;
 
 	case PACKET_OTHERHOST:
diff -X dontdiff -Naur linux-2.5.74-vanilla/include/linux/netdevice.h linux-2.5.74-nx/include/linux/netdevice.h
--- linux-2.5.74-vanilla/include/linux/netdevice.h	2003-07-02 16:56:07.000000000 -0400
+++ linux-2.5.74-nx/include/linux/netdevice.h	2003-07-03 15:11:00.000000000 -0400
@@ -14,6 +14,7 @@
  *		Alan Cox, <Alan.Cox@linux.org>
  *		Bjorn Ekwall. <bj0rn@blox.se>
  *              Pekka Riikonen <priikone@poseidon.pspt.fi>
+ *		Josef "Jeff" Sipek <jeffpc@optonline.net>
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -95,39 +96,75 @@
  *	with byte counters.
  */
  
+#ifdef CONFIG_NETSTATS64
+#define NETSTAT_TYPE u_int64_t
+struct net_device_stats_locks
+{
+	spinlock_t	rx_packets;
+	spinlock_t	tx_packets;
+	spinlock_t	rx_bytes;
+	spinlock_t	tx_bytes;
+	spinlock_t	rx_errors;
+	spinlock_t	tx_errors;
+	spinlock_t	rx_dropped;
+	spinlock_t	tx_dropped;
+	spinlock_t	multicast;
+	spinlock_t	collisions;
+	spinlock_t	rx_length_errors;
+	spinlock_t	rx_over_errors;
+	spinlock_t	rx_crc_errors;
+	spinlock_t	rx_frame_errors;
+	spinlock_t	rx_fifo_errors;
+	spinlock_t	rx_missed_errors;
+	spinlock_t	tx_aborted_errors;
+	spinlock_t	tx_carrier_errors;
+	spinlock_t	tx_fifo_errors;
+	spinlock_t	tx_heartbeat_errors;
+	spinlock_t	tx_window_errors;
+	spinlock_t	rx_compressed;
+	spinlock_t	tx_compressed;
+};
+#else
+#define NETSTAT_TYPE unsigned long
+#endif
+
 struct net_device_stats
 {
-	unsigned long	rx_packets;		/* total packets received	*/
-	unsigned long	tx_packets;		/* total packets transmitted	*/
-	unsigned long	rx_bytes;		/* total bytes received 	*/
-	unsigned long	tx_bytes;		/* total bytes transmitted	*/
-	unsigned long	rx_errors;		/* bad packets received		*/
-	unsigned long	tx_errors;		/* packet transmit problems	*/
-	unsigned long	rx_dropped;		/* no space in linux buffers	*/
-	unsigned long	tx_dropped;		/* no space available in linux	*/
-	unsigned long	multicast;		/* multicast packets received	*/
-	unsigned long	collisions;
+	NETSTAT_TYPE	_rx_packets;		/* total packets received	*/
+	NETSTAT_TYPE	_tx_packets;		/* total packets transmitted	*/
+	NETSTAT_TYPE	_rx_bytes;		/* total bytes received 	*/
+	NETSTAT_TYPE	_tx_bytes;		/* total bytes transmitted	*/
+	NETSTAT_TYPE	_rx_errors;		/* bad packets received		*/
+	NETSTAT_TYPE	_tx_errors;		/* packet transmit problems	*/
+	NETSTAT_TYPE	_rx_dropped;		/* no space in linux buffers	*/
+	NETSTAT_TYPE	_tx_dropped;		/* no space available in linux	*/
+	NETSTAT_TYPE	_multicast;		/* multicast packets received	*/
+	NETSTAT_TYPE	_collisions;
 
 	/* detailed rx_errors: */
-	unsigned long	rx_length_errors;
-	unsigned long	rx_over_errors;		/* receiver ring buff overflow	*/
-	unsigned long	rx_crc_errors;		/* recved pkt with crc error	*/
-	unsigned long	rx_frame_errors;	/* recv'd frame alignment error */
-	unsigned long	rx_fifo_errors;		/* recv'r fifo overrun		*/
-	unsigned long	rx_missed_errors;	/* receiver missed packet	*/
+	NETSTAT_TYPE	_rx_length_errors;
+	NETSTAT_TYPE	_rx_over_errors;	/* receiver ring buff overflow	*/
+	NETSTAT_TYPE	_rx_crc_errors;		/* recved pkt with crc error	*/
+	NETSTAT_TYPE	_rx_frame_errors;	/* recv'd frame alignment error */
+	NETSTAT_TYPE	_rx_fifo_errors;	/* recv'r fifo overrun		*/
+	NETSTAT_TYPE	_rx_missed_errors;	/* receiver missed packet	*/
 
 	/* detailed tx_errors */
-	unsigned long	tx_aborted_errors;
-	unsigned long	tx_carrier_errors;
-	unsigned long	tx_fifo_errors;
-	unsigned long	tx_heartbeat_errors;
-	unsigned long	tx_window_errors;
-	
+	NETSTAT_TYPE	_tx_aborted_errors;
+	NETSTAT_TYPE	_tx_carrier_errors;
+	NETSTAT_TYPE	_tx_fifo_errors;
+	NETSTAT_TYPE	_tx_heartbeat_errors;
+	NETSTAT_TYPE	_tx_window_errors;
+
 	/* for cslip etc */
-	unsigned long	rx_compressed;
-	unsigned long	tx_compressed;
-};
+	NETSTAT_TYPE	_rx_compressed;
+	NETSTAT_TYPE	_tx_compressed;
 
+#ifdef CONFIG_NETSTATS64
+	/* locks */
+	struct net_device_stats_locks locks;
+#endif
+};
 
 /* Media selection options. */
 enum {
@@ -865,6 +902,46 @@
 extern void		dev_clear_fastroute(struct net_device *dev);
 #endif
 
+static inline void net_stats_init(struct net_device_stats* stats)
+{
+#ifdef CONFIG_NETSTATS64
+	spin_lock_init(&stats->locks.rx_packets);
+	spin_lock_init(&stats->locks.tx_packets);
+	spin_lock_init(&stats->locks.rx_bytes);
+	spin_lock_init(&stats->locks.tx_bytes);
+	spin_lock_init(&stats->locks.rx_errors);
+	spin_lock_init(&stats->locks.tx_errors);
+	spin_lock_init(&stats->locks.rx_dropped);
+	spin_lock_init(&stats->locks.tx_dropped);
+	spin_lock_init(&stats->locks.multicast);
+	spin_lock_init(&stats->locks.collisions);
+	spin_lock_init(&stats->locks.rx_length_errors);
+	spin_lock_init(&stats->locks.rx_over_errors);
+	spin_lock_init(&stats->locks.rx_crc_errors);
+	spin_lock_init(&stats->locks.rx_frame_errors);
+	spin_lock_init(&stats->locks.rx_fifo_errors);
+	spin_lock_init(&stats->locks.rx_missed_errors);
+	spin_lock_init(&stats->locks.tx_aborted_errors);
+	spin_lock_init(&stats->locks.tx_carrier_errors);
+	spin_lock_init(&stats->locks.tx_fifo_errors);
+	spin_lock_init(&stats->locks.tx_heartbeat_errors);
+	spin_lock_init(&stats->locks.tx_window_errors);
+	spin_lock_init(&stats->locks.rx_compressed);
+	spin_lock_init(&stats->locks.tx_compressed);
+#endif
+}
+
+#ifdef CONFIG_NETSTATS64
+#define net_stats_add(what,stats,num)		locked_add64(&(stats)->_##what,(u_int64_t) num,&(stats)->locks.what)
+#define net_stats_inc(what,stats)		locked_add64(&(stats)->_##what,1,&(stats)->locks.what)
+#define net_stats_set(what,stats,num)		locked_set64(&(stats)->_##what,(u_int64_t) num,&(stats)->locks.what)
+#define net_stats_get(what,stats)		locked_get64(&(stats)->_##what,&(stats)->locks.what)
+#else
+#define net_stats_add(what,stats,num)		(stats)->_##what += (NETSTAT_TYPE) num
+#define net_stats_inc(what,stats)		((stats)->_##what++)
+#define net_stats_set(what,stats,num)		(stats)->_##what = (NETSTAT_TYPE) num
+#define net_stats_get(what,stats)		((u_int64_t) (stats)->_##what)
+#endif
 
 #endif /* __KERNEL__ */
 

--Boundary_(ID_5+ztBL0+KOSUBUfAD6Oe6Q)--
