Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSKXUc6>; Sun, 24 Nov 2002 15:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSKXUc6>; Sun, 24 Nov 2002 15:32:58 -0500
Received: from 5-005.ctame701-2.telepar.net.br ([200.181.169.5]:46602 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261644AbSKXUcw>; Sun, 24 Nov 2002 15:32:52 -0500
Date: Sun, 24 Nov 2002 18:39:57 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/core/dev.c: convert /proc/net/dev to seq_file
Message-ID: <20021124203957.GL31074@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Please pull from:

master.kernel.org:/home/acme/BK/net-2.5

	Now there are three outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.860, 2002-11-24 12:44:43-02:00, acme@conectiva.com.br
  o net/core/dev.c: convert /proc/net/dev to seq_file


 dev.c |  175 ++++++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 102 insertions(+), 73 deletions(-)


diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Sun Nov 24 12:45:07 2002
+++ b/net/core/dev.c	Sun Nov 24 12:45:07 2002
@@ -94,6 +94,7 @@
 #include <net/sock.h>
 #include <linux/rtnetlink.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/if_bridge.h>
 #include <linux/divert.h>
@@ -114,6 +115,7 @@
 extern int plip_init(void);
 #endif
 
+#include <asm/current.h>
 
 /* This define, if set, will randomly drop a packet when congestion
  * is more than moderate.  It helps fairness in the multi-interface
@@ -1719,85 +1721,79 @@
 	return copy_to_user(arg, &ifc, sizeof(struct ifconf)) ? -EFAULT : 0;
 }
 
+#ifdef CONFIG_PROC_FS
 /*
  *	This is invoked by the /proc filesystem handler to display a device
  *	in detail.
  */
+static __inline__ struct net_device *dev_get_idx(struct seq_file *seq,
+						 loff_t pos)
+{
+	struct net_device *dev;
+	loff_t i;
 
-#ifdef CONFIG_PROC_FS
+	for (i = 0, dev = dev_base; dev && i < pos; dev = dev->next);
+
+	return i == pos ? dev : NULL;
+}
+
+static void *dev_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	read_lock(&dev_base_lock);
+	return *pos ? dev_get_idx(seq, *pos) : (void *)1;
+}
 
-static int sprintf_stats(char *buffer, struct net_device *dev)
+static void *dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return v == (void *)1 ? dev_base : ((struct net_device *)v)->next;
+}
+
+static void dev_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock(&dev_base_lock);
+}
+
+static void dev_seq_printf_stats(struct seq_file *seq, struct net_device *dev)
 {
 	struct net_device_stats *stats = dev->get_stats ? dev->get_stats(dev) :
 							  NULL;
-	int size;
-
 	if (stats)
-		size = sprintf(buffer, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu "
-				       "%10lu %9lu %8lu %7lu %4lu %4lu %4lu "
-				       "%5lu %7lu %10lu\n",
- 		   dev->name,
-		   stats->rx_bytes,
-		   stats->rx_packets, stats->rx_errors,
-		   stats->rx_dropped + stats->rx_missed_errors,
-		   stats->rx_fifo_errors,
-		   stats->rx_length_errors + stats->rx_over_errors +
-		   	stats->rx_crc_errors + stats->rx_frame_errors,
-		   stats->rx_compressed, stats->multicast,
-		   stats->tx_bytes,
-		   stats->tx_packets, stats->tx_errors, stats->tx_dropped,
-		   stats->tx_fifo_errors, stats->collisions,
-		   stats->tx_carrier_errors + stats->tx_aborted_errors +
-		   	stats->tx_window_errors + stats->tx_heartbeat_errors,
-		   stats->tx_compressed);
+		seq_printf(seq, "%6s:%8lu %7lu %4lu %4lu %4lu %5lu %10lu %9lu "
+				"%8lu %7lu %4lu %4lu %4lu %5lu %7lu %10lu\n",
+			   dev->name, stats->rx_bytes, stats->rx_packets,
+			   stats->rx_errors,
+			   stats->rx_dropped + stats->rx_missed_errors,
+			   stats->rx_fifo_errors,
+			   stats->rx_length_errors + stats->rx_over_errors +
+			     stats->rx_crc_errors + stats->rx_frame_errors,
+			   stats->rx_compressed, stats->multicast,
+			   stats->tx_bytes, stats->tx_packets,
+			   stats->tx_errors, stats->tx_dropped,
+			   stats->tx_fifo_errors, stats->collisions,
+			   stats->tx_carrier_errors +
+			     stats->tx_aborted_errors +
+			     stats->tx_window_errors +
+			     stats->tx_heartbeat_errors,
+			   stats->tx_compressed);
 	else
-		size = sprintf(buffer, "%6s: No statistics available.\n",
-			       dev->name);
-
-	return size;
+		seq_printf(seq, "%6s: No statistics available.\n", dev->name);
 }
 
 /*
  *	Called from the PROCfs module. This now uses the new arbitrary sized
  *	/proc/net interface to create /proc/net/dev
  */
-static int dev_get_info(char *buffer, char **start, off_t offset, int length)
+static int dev_seq_show(struct seq_file *seq, void *v)
 {
-	int len = 0;
-	off_t begin = 0;
-	off_t pos = 0;
-	int size;
-	struct net_device *dev;
-
-	size = sprintf(buffer,
-		"Inter-|   Receive                                                |  Transmit\n"
-		" face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed\n");
-
-	pos += size;
-	len += size;
-
-	read_lock(&dev_base_lock);
-	for (dev = dev_base; dev; dev = dev->next) {
-		size = sprintf_stats(buffer+len, dev);
-		len += size;
-		pos = begin + len;
-
-		if (pos < offset) {
-			len = 0;
-			begin = pos;
-		}
-		if (pos > offset + length)
-			break;
-	}
-	read_unlock(&dev_base_lock);
-
-	*start = buffer + (offset - begin);	/* Start of wanted data */
-	len -= offset - begin;			/* Start slop */
-	if (len > length)
-		len = length;			/* Ending slop */
-	if (len < 0)
-		len = 0;
-	return len;
+	if (v == (void *)1)
+		seq_printf(seq, "Inter-|   Receive                            "
+				"                    |  Transmit\n"
+				" face |bytes    packets errs drop fifo frame "
+				"compressed multicast|bytes    packets errs "
+				"drop fifo colls carrier compressed\n");
+	else
+		dev_seq_printf_stats(seq, v);
+	return 0;
 }
 
 static int dev_proc_stats(char *buffer, char **start, off_t offset,
@@ -1841,6 +1837,44 @@
 	return len;
 }
 
+static struct seq_operations dev_seq_ops = {
+	.start = dev_seq_start,
+	.next  = dev_seq_next,
+	.stop  = dev_seq_stop,
+	.show  = dev_seq_show,
+};
+
+static int dev_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &dev_seq_ops);
+}
+
+static struct file_operations dev_seq_fops = {
+	.open    = dev_seq_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static int __init dev_proc_init(void)
+{
+	struct proc_dir_entry *p;
+	int rc = -ENOMEM;
+
+	p = create_proc_entry("dev", S_IRUGO, proc_net);
+	if (!p)
+		goto out;
+	p->proc_fops = &dev_seq_fops;
+	create_proc_read_entry("net/softnet_stat", 0, 0, dev_proc_stats, NULL);
+#ifdef WIRELESS_EXT
+	proc_net_create("wireless", 0, dev_get_wireless_info);
+#endif
+	rc = 0;
+out:
+	return rc;
+}
+#else
+#define dev_proc_init() 0
 #endif	/* CONFIG_PROC_FS */
 
 
@@ -2680,10 +2714,13 @@
 static int __init net_dev_init(void)
 {
 	struct net_device *dev, **dp;
-	int i;
+	int i, rc = -ENOMEM;
 
 	BUG_ON(!dev_boot_phase);
 
+	if (dev_proc_init())
+		goto out;
+
 #ifdef CONFIG_NET_DIVERT
 	dv_init();
 #endif /* CONFIG_NET_DIVERT */
@@ -2787,15 +2824,6 @@
 		}
 	}
 
-#ifdef CONFIG_PROC_FS
-	proc_net_create("dev", 0, dev_get_info);
-	create_proc_read_entry("net/softnet_stat", 0, 0, dev_proc_stats, NULL);
-#ifdef WIRELESS_EXT
-	/* Available in net/core/wireless.c */
-	proc_net_create("wireless", 0, dev_get_wireless_info);
-#endif	/* WIRELESS_EXT */
-#endif	/* CONFIG_PROC_FS */
-
 	dev_boot_phase = 0;
 
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action, NULL);
@@ -2812,8 +2840,9 @@
 	 */
 
 	net_device_init();
-
-	return 0;
+	rc = 0;
+out:
+	return rc;
 }
 
 subsys_initcall(net_dev_init);

===================================================================


This BitKeeper patch contains the following changesets:
1.860
## Wrapped with gzip_uu ##


begin 664 bkpatch10474
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
#$```
`
end
