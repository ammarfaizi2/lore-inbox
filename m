Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267014AbTGGNvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 09:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267016AbTGGNvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 09:51:22 -0400
Received: from port-212-202-52-167.reverse.qsc.de ([212.202.52.167]:18053 "EHLO
	gw.localnet") by vger.kernel.org with ESMTP id S267014AbTGGNvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 09:51:15 -0400
Message-ID: <3F097E4D.1080707@trash.net>
Date: Mon, 07 Jul 2003 16:06:05 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: netdev@oss.sgi.com
Subject: RFC: another approach for 64-bit network stats
Content-Type: multipart/mixed;
 boundary="------------050706090100050808080106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050706090100050808080106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch implements a lockless aproach for 64-bit netstatistics with 
only a very rare
racecondition. On 64 bit system, nothing is changed. On 32 bit system 
the (32bit) counter
is checked periodically for overflows. The overflows are saved in 
counter_high. To detect
overflows, we need to save the counter value when last checked 
(counter_last), so there is
a 4byte overhead per 64bit counter. The 32-bit values can be accessed as 
before through
stats->counter, the 64bit values are accessed through a macro 
NETSTAT64(stats, counter).
Accessing the 64bit values contains the before mentioned race-condition, 
when the counters
are synced while they are read and an overflow occured the value could 
be of 4gb. However
the next read will return the correct value and with gigabit speed we 
only need to sync every ~30s,
so thats much better than racing on every counter update (using 64bit 
counters directly) and
potentially damaging the counter permanently. The race could be avoided 
by locking syncs and
reads (not normal counter updates). The patch only breaks binary 
interfaces, all in-kernel users
can continue to use the 32bit values until they have been changed, 
userspace software just
needs recompilation, device drivers don't need any changes at all.

Comments ?

Bye,
Patrick

--------------050706090100050808080106
Content-Type: text/plain;
 name="netstats64.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netstats64.diff"

===== include/linux/netdevice.h 1.45 vs edited =====
--- 1.45/include/linux/netdevice.h	Wed Jul  2 09:20:08 2003
+++ edited/include/linux/netdevice.h	Mon Jul  7 15:09:05 2003
@@ -91,41 +91,83 @@
 #endif
 
 /*
+ *   Macros for lockless 64 bit netdevice statistics. On 32-bit arches
+ *   the counter is checked periodically for overflows. The overflows
+ *   are carried in name_high. The updates are not atomic, there is a
+ *   race between updating and reading the counters, however this is a 
+ *   very rare condition.
+ */
+
+#if (BITS_PER_LONG == 64)
+	
+#define DECLARE_NETSTAT64(name)						\
+	unsigned long name
+#define NETSTAT64(stats, name)						\
+	((unsigned long long)(stats)->name)
+	
+#else
+
+#define DECLARE_NETSTAT64(name)						\
+	unsigned long name;						\
+	unsigned long name##_high;					\
+	unsigned long name##_last
+
+#define NETSTAT64(stats, name)						  \
+({									  \
+ 	unsigned long cnt = (stats)->name;				  \
+	int carry = (stats)->name##_last > cnt;				  \
+	((unsigned long long)((stats)->name##_high + carry) << 32 | cnt); \
+})
+
+#define NETSTAT64_SYNC(stats, name)					\
+do {									\
+	unsigned long cnt = (stats)->name;				\
+	if ((stats)->name##_last > cnt)					\
+		(stats)->name##_high++;					\
+	(stats)->name##_last = cnt;					\
+} while(0)
+
+/* 32bit overflow about every 34s at full gigabit speed */
+#define NETSTATS64_SYNC_INTERVAL	30
+
+#endif
+
+/*
  *	Network device statistics. Akin to the 2.0 ether stats but
  *	with byte counters.
  */
  
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
+	DECLARE_NETSTAT64(rx_packets);		/* total packets received	*/
+	DECLARE_NETSTAT64(tx_packets);		/* total packets transmitted	*/
+	DECLARE_NETSTAT64(rx_bytes);		/* total bytes received 	*/
+	DECLARE_NETSTAT64(tx_bytes);		/* total bytes transmitted	*/
+	DECLARE_NETSTAT64(rx_errors);		/* bad packets received		*/
+	DECLARE_NETSTAT64(tx_errors);		/* packet transmit problems	*/
+	DECLARE_NETSTAT64(rx_dropped);		/* no space in linux buffers	*/
+	DECLARE_NETSTAT64(tx_dropped);		/* no space available in linux	*/
+	DECLARE_NETSTAT64(multicast);		/* multicast packets received	*/
+	DECLARE_NETSTAT64(collisions);
 
 	/* detailed rx_errors: */
-	unsigned long	rx_length_errors;
-	unsigned long	rx_over_errors;		/* receiver ring buff overflow	*/
-	unsigned long	rx_crc_errors;		/* recved pkt with crc error	*/
-	unsigned long	rx_frame_errors;	/* recv'd frame alignment error */
-	unsigned long	rx_fifo_errors;		/* recv'r fifo overrun		*/
-	unsigned long	rx_missed_errors;	/* receiver missed packet	*/
+	DECLARE_NETSTAT64(rx_length_errors);
+	DECLARE_NETSTAT64(rx_over_errors);	/* receiver ring buff overflow	*/
+	DECLARE_NETSTAT64(rx_crc_errors);	/* recved pkt with crc error	*/
+	DECLARE_NETSTAT64(rx_frame_errors);	/* recv'd frame alignment error */
+	DECLARE_NETSTAT64(rx_fifo_errors);	/* recv'r fifo overrun		*/
+	DECLARE_NETSTAT64(rx_missed_errors);	/* receiver missed packet	*/
 
 	/* detailed tx_errors */
-	unsigned long	tx_aborted_errors;
-	unsigned long	tx_carrier_errors;
-	unsigned long	tx_fifo_errors;
-	unsigned long	tx_heartbeat_errors;
-	unsigned long	tx_window_errors;
+	DECLARE_NETSTAT64(tx_aborted_errors);
+	DECLARE_NETSTAT64(tx_carrier_errors);
+	DECLARE_NETSTAT64(tx_fifo_errors);
+	DECLARE_NETSTAT64(tx_heartbeat_errors);
+	DECLARE_NETSTAT64(tx_window_errors);
 	
 	/* for cslip etc */
-	unsigned long	rx_compressed;
-	unsigned long	tx_compressed;
+	DECLARE_NETSTAT64(rx_compressed);
+	DECLARE_NETSTAT64(tx_compressed);
 };
 
 
===== net/core/dev.c 1.89 vs edited =====
--- 1.89/net/core/dev.c	Thu Jul  3 09:32:44 2003
+++ edited/net/core/dev.c	Mon Jul  7 13:53:38 2003
@@ -1869,23 +1870,33 @@
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
+		seq_printf(seq, "%6s:%8llu %7llu %4llu %4llu %4llu %5llu "
+		                "%10llu %9llu %8llu %7llu %4llu %4llu %4llu "
+		                "%5llu %7llu %10llu\n",
+		           dev->name,
+		           NETSTAT64(stats, rx_bytes),
+		           NETSTAT64(stats, rx_packets),
+		           NETSTAT64(stats, rx_errors),
+		           NETSTAT64(stats, rx_dropped) +
+		             NETSTAT64(stats, rx_missed_errors),
+		           NETSTAT64(stats, rx_fifo_errors),
+		           NETSTAT64(stats, rx_length_errors) +
+		             NETSTAT64(stats, rx_over_errors) +
+		             NETSTAT64(stats, rx_crc_errors) +
+		             NETSTAT64(stats, rx_frame_errors),
+		           NETSTAT64(stats, rx_compressed),
+		           NETSTAT64(stats, multicast),
+		           NETSTAT64(stats, tx_bytes),
+		           NETSTAT64(stats, tx_packets),
+		           NETSTAT64(stats, tx_errors),
+		           NETSTAT64(stats, tx_dropped),
+		           NETSTAT64(stats, tx_fifo_errors),
+		           NETSTAT64(stats, collisions),
+		           NETSTAT64(stats, tx_carrier_errors) +
+		           NETSTAT64(stats, tx_aborted_errors) +
+		           NETSTAT64(stats, tx_window_errors) +
+		             NETSTAT64(stats, tx_heartbeat_errors),
+		           NETSTAT64(stats, tx_compressed));
 	else
 		seq_printf(seq, "%6s: No statistics available.\n", dev->name);
 }
@@ -2943,6 +2954,56 @@
 	return 0;
 }
 
+#if (BITS_PER_LONG != 64)
+static void netstats64_sync_work(void *);
+static DECLARE_WORK(netstats64_work, netstats64_sync_work, NULL);
+
+static inline void netstats64_schedule_work(void)
+{
+	schedule_delayed_work(&netstats64_work, NETSTATS64_SYNC_INTERVAL * HZ);
+}
+
+static void netstats64_sync_work(void *data)
+{
+	struct net_device *dev;
+	struct net_device_stats *stats;
+
+	read_lock_bh(&dev_base_lock);
+	for (dev = dev_base; dev; dev = dev->next) {
+		stats = dev->get_stats ? dev->get_stats(dev) : NULL;
+		if (!stats)
+			continue;
+		NETSTAT64_SYNC(stats, rx_packets);
+		NETSTAT64_SYNC(stats, tx_packets);
+		NETSTAT64_SYNC(stats, rx_bytes);
+		NETSTAT64_SYNC(stats, tx_bytes);
+		NETSTAT64_SYNC(stats, rx_errors);
+		NETSTAT64_SYNC(stats, tx_errors);
+		NETSTAT64_SYNC(stats, rx_dropped);
+		NETSTAT64_SYNC(stats, tx_dropped);
+		NETSTAT64_SYNC(stats, multicast);
+		NETSTAT64_SYNC(stats, collisions);
+
+		NETSTAT64_SYNC(stats, rx_length_errors);
+		NETSTAT64_SYNC(stats, rx_over_errors);
+		NETSTAT64_SYNC(stats, rx_crc_errors);
+		NETSTAT64_SYNC(stats, rx_frame_errors);
+		NETSTAT64_SYNC(stats, rx_fifo_errors);
+		NETSTAT64_SYNC(stats, rx_missed_errors);
+		
+		NETSTAT64_SYNC(stats, tx_aborted_errors);
+		NETSTAT64_SYNC(stats, tx_carrier_errors);
+		NETSTAT64_SYNC(stats, tx_fifo_errors);
+		NETSTAT64_SYNC(stats, tx_heartbeat_errors);
+		NETSTAT64_SYNC(stats, tx_window_errors);
+
+		NETSTAT64_SYNC(stats, rx_compressed);
+		NETSTAT64_SYNC(stats, tx_compressed);
+	}
+	read_unlock_bh(&dev_base_lock);
+	netstats64_schedule_work();
+}
+#endif
 
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
@@ -3082,6 +3143,9 @@
 
 #ifdef CONFIG_NET_SCHED
 	pktsched_init();
+#endif
+#if (BITS_PER_LONG != 64)
+	netstats64_schedule_work();
 #endif
 	rc = 0;
 out:
===== net/core/net-sysfs.c 1.7 vs edited =====
--- 1.7/net/core/net-sysfs.c	Sun Jun 15 10:21:46 2003
+++ edited/net/core/net-sysfs.c	Mon Jul  7 13:57:11 2003
@@ -184,9 +184,9 @@
 	ssize_t (*store)(struct net_device_stats *, const char *, size_t);
 };
 
-static ssize_t net_device_stat_show(unsigned long var, char *buf)
+static ssize_t net_device_stat_show(unsigned long long var, char *buf)
 {
-	return sprintf(buf, "%ld\n", var);
+	return sprintf(buf, "%lld\n", var);
 }
 
 /* generate a read-only statistics attribute */
@@ -194,7 +194,7 @@
 static ssize_t show_stat_##_NAME(const struct net_device_stats *stats,	\
 				 char *buf)				\
 {									\
-	return net_device_stat_show(stats->_NAME, buf);			\
+	return net_device_stat_show(NETSTAT64(stats, _NAME), buf);	\
 }									\
 static struct netstat_fs_entry net_stat_##_NAME  = {		   	\
 	.attr = {.name = __stringify(_NAME), .mode = S_IRUGO },		\

--------------050706090100050808080106--

