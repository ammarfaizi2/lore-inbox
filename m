Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269679AbUICR1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269679AbUICR1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269669AbUICR1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:27:44 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:13749 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S269527AbUICRWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:22:34 -0400
Date: Fri, 03 Sep 2004 13:22:29 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH 2.6] 64network: 64-bit network statistics
In-reply-to: <200409031307.01240.jeffpc@optonline.net>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Message-id: <200409031322.29981.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <200409031307.01240.jeffpc@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon registration of a network device, all the statistics variables are
registered with watch64. Additionally, a new proc file is
created /proc/net/dev64 displays the 64-bit values as supposed
to /proc/net/dev which is left to display the original 32-bit variables for
backward compatibility. The sysfs interface
(/sys/class/net/<interface>/statistics/*) displays the 64-bit values only. On
64-bit systems, all is optimized away through watch64.

Requires: watch64

The following patch can be also pulled from http://jeffpc.bkbits.net/64network-2.6 (includes watch64)

Josef "Jeff" Sipek

Signed-off-by: Josef "Jeff" Sipek <jeffpc@optonline.net>


diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
--- a/include/linux/netdevice.h 2004-09-03 12:22:08 -04:00
+++ b/include/linux/netdevice.h 2004-09-03 12:22:08 -04:00
@@ -14,6 +14,7 @@
  *  Alan Cox, <Alan.Cox@linux.org>
  *  Bjorn Ekwall. <bj0rn@blox.se>
  *              Pekka Riikonen <priikone@poseidon.pspt.fi>
+ *  Josef "Jeff" Sipek <jeffpc@optonline.net>
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -945,6 +946,10 @@
 #ifdef CONFIG_SYSCTL
 extern char *net_sysctl_strdup(const char *s);
 #endif
+
+/* Register/unregister all the members of struct net_device_stats with watch64 */
+inline void  net_register_stats64(struct net_device_stats* stats);
+inline void  net_unregister_stats64(struct net_device_stats* stats);
 
 #endif /* __KERNEL__ */
 
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c 2004-09-03 12:22:08 -04:00
+++ b/net/core/dev.c 2004-09-03 12:22:08 -04:00
@@ -18,6 +18,7 @@
  *  Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
  *  Adam Sulmicki <adam@cfar.umd.edu>
  *              Pekka Riikonen <priikone@poesidon.pspt.fi>
+ *  Josef "Jeff" Sipek <jeffpc@optonline.net>
  *
  * Changes:
  *              D.J. Barrow     :       Fixed bug where dev->refcnt gets set
@@ -70,6 +71,7 @@
  *                 indefinitely on dev->refcnt
  *   J Hadi Salim : - Backlog queue sampling
  *            - netif_rx() feedback
+ * Josef "Jeff" Sipek : Added watch64 calls for network statistics
  */
 
 #include <asm/uaccess.h>
@@ -108,6 +110,7 @@
 #include <linux/kallsyms.h>
 #include <linux/netpoll.h>
 #include <linux/rcupdate.h>
+#include <linux/watch64.h>
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>  /* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
@@ -2110,6 +2113,49 @@
   seq_printf(seq, "%6s: No statistics available.\n", dev->name);
 }
 
+static void dev_seq_printf_stats64(struct seq_file *seq, struct net_device *dev)
+{
+ if (dev->get_stats) {
+  struct net_device_stats *stats = dev->get_stats(dev);
+
+  seq_printf(seq, "%6s:%8llu %7llu %4llu %4llu %4llu %5llu %10llu %9llu "
+    "%8llu %7llu %4llu %4llu %4llu %5llu %7llu %10llu\n",
+      dev->name, watch64_getval(&stats->rx_bytes,NULL),
+      watch64_getval(&stats->rx_packets,NULL),
+      watch64_getval(&stats->rx_errors,NULL),
+      watch64_getval(&stats->rx_dropped,NULL) +
+        watch64_getval(&stats->rx_missed_errors,NULL),
+      watch64_getval(&stats->rx_fifo_errors,NULL),
+      watch64_getval(&stats->rx_length_errors,NULL) + 
+        watch64_getval(&stats->rx_over_errors,NULL) +
+        watch64_getval(&stats->rx_crc_errors,NULL) +
+        watch64_getval(&stats->rx_frame_errors,NULL),
+      watch64_getval(&stats->rx_compressed,NULL),
+      watch64_getval(&stats->multicast,NULL),
+      watch64_getval(&stats->tx_bytes,NULL),
+      watch64_getval(&stats->tx_packets,NULL),
+      watch64_getval(&stats->tx_errors,NULL),
+      watch64_getval(&stats->tx_dropped,NULL),
+      watch64_getval(&stats->tx_fifo_errors,NULL),
+      watch64_getval(&stats->collisions,NULL),
+      watch64_getval(&stats->tx_carrier_errors,NULL) +
+        watch64_getval(&stats->tx_aborted_errors,NULL) +
+        watch64_getval(&stats->tx_window_errors,NULL) +
+        watch64_getval(&stats->tx_heartbeat_errors,NULL),
+      watch64_getval(&stats->tx_compressed,NULL));
+ } else
+  seq_printf(seq, "%6s: No statistics available.\n", dev->name);
+}
+
+static void dev_seq_show_header(struct seq_file *seq)
+{
+ seq_puts(seq, "Inter-|   Receive                            "
+        "                    |  Transmit\n"
+        " face |bytes    packets errs drop fifo frame "
+        "compressed multicast|bytes    packets errs "
+        "drop fifo colls carrier compressed\n");
+}
+
 /*
  * Called from the PROCfs module. This now uses the new arbitrary sized
  * /proc/net interface to create /proc/net/dev
@@ -2117,16 +2163,21 @@
 static int dev_seq_show(struct seq_file *seq, void *v)
 {
  if (v == SEQ_START_TOKEN)
-  seq_puts(seq, "Inter-|   Receive                            "
-         "                    |  Transmit\n"
-         " face |bytes    packets errs drop fifo frame "
-         "compressed multicast|bytes    packets errs "
-         "drop fifo colls carrier compressed\n");
+  dev_seq_show_header(seq);
  else
   dev_seq_printf_stats(seq, v);
  return 0;
 }
 
+static int dev_seq_show64(struct seq_file *seq, void *v)
+{
+ if (v == SEQ_START_TOKEN)
+  dev_seq_show_header(seq);
+ else
+  dev_seq_printf_stats64(seq, v);
+ return 0;
+}
+
 static struct netif_rx_stats *softnet_get_online(loff_t *pos)
 {
  struct netif_rx_stats *rc = NULL;
@@ -2179,11 +2230,23 @@
  .show  = dev_seq_show,
 };
 
+static struct seq_operations dev_seq_ops64 = {
+ .start = dev_seq_start,
+ .next  = dev_seq_next,
+ .stop  = dev_seq_stop,
+ .show  = dev_seq_show64,
+};
+
 static int dev_seq_open(struct inode *inode, struct file *file)
 {
  return seq_open(file, &dev_seq_ops);
 }
 
+static int dev_seq_open64(struct inode *inode, struct file *file)
+{
+ return seq_open(file, &dev_seq_ops64);
+}
+
 static struct file_operations dev_seq_fops = {
  .owner  = THIS_MODULE,
  .open    = dev_seq_open,
@@ -2192,6 +2255,14 @@
  .release = seq_release,
 };
 
+static struct file_operations dev_seq_fops64 = {
+ .owner  = THIS_MODULE,
+ .open    = dev_seq_open64,
+ .read    = seq_read,
+ .llseek  = seq_lseek,
+ .release = seq_release,
+};
+
 static struct seq_operations softnet_seq_ops = {
  .start = softnet_seq_start,
  .next  = softnet_seq_next,
@@ -2224,8 +2295,10 @@
 
  if (!proc_net_fops_create("dev", S_IRUGO, &dev_seq_fops))
   goto out;
- if (!proc_net_fops_create("softnet_stat", S_IRUGO, &softnet_seq_fops))
+ if (!proc_net_fops_create("dev64", S_IRUGO, &dev_seq_fops64))
   goto out_dev;
+ if (!proc_net_fops_create("softnet_stat", S_IRUGO, &softnet_seq_fops))
+  goto out_dev64;
  if (wireless_proc_init())
   goto out_softnet;
  rc = 0;
@@ -2233,6 +2306,8 @@
  return rc;
 out_softnet:
  proc_net_remove("softnet_stat");
+out_dev64:
+ proc_net_remove("dev64");
 out_dev:
  proc_net_remove("dev");
  goto out;
@@ -2910,6 +2985,9 @@
   * device is present.
   */
 
+ if (dev->get_stats)
+  net_register_stats64(dev->get_stats(dev));
+ 
  set_bit(__LINK_STATE_PRESENT, &dev->state);
 
  dev->next = NULL;
@@ -2922,7 +3000,7 @@
  dev_hold(dev);
  dev->reg_state = NETREG_REGISTERING;
  write_unlock_bh(&dev_base_lock);
-
+ 
  /* Notify protocols, that a new device appeared. */
  notifier_call_chain(&netdev_chain, NETDEV_REGISTER, dev);
 
@@ -3145,6 +3223,9 @@
  /* If device is running, close it first. */
  if (dev->flags & IFF_UP)
   dev_close(dev);
+  
+ if (dev->get_stats)
+  net_unregister_stats64(dev->get_stats(dev));
 
  /* And unlink it from device chain. */
  for (dp = &dev_base; (d = *dp) != NULL; dp = &d->next) {
@@ -3246,6 +3327,98 @@
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+/*
+ * Register all the members of the net_device_stats structure
+ *
+ */
+ 
+inline void net_register_stats64(struct net_device_stats* stats)
+{
+ if (!stats)
+  return;
+
+ watch64_register(&stats->tx_packets,0);
+ watch64_enable  (&stats->tx_packets,NULL);
+ watch64_register(&stats->rx_packets,0);
+ watch64_enable  (&stats->rx_packets,NULL);
+ watch64_register(&stats->tx_bytes,0);
+ watch64_enable  (&stats->tx_bytes,NULL);
+ watch64_register(&stats->rx_bytes,0);
+ watch64_enable  (&stats->rx_bytes,NULL);
+ watch64_register(&stats->tx_errors,0);
+ watch64_enable  (&stats->tx_errors,NULL);
+ watch64_register(&stats->rx_errors,0);
+ watch64_enable  (&stats->rx_errors,NULL);
+ watch64_register(&stats->tx_dropped,0);
+ watch64_enable  (&stats->tx_dropped,NULL);
+ watch64_register(&stats->rx_dropped,0);
+ watch64_enable  (&stats->rx_dropped,NULL);
+ watch64_register(&stats->multicast,0);
+ watch64_enable  (&stats->multicast,NULL);
+ watch64_register(&stats->collisions,0);
+ watch64_enable  (&stats->collisions,NULL);
+ watch64_register(&stats->rx_length_errors,0);
+ watch64_enable  (&stats->rx_length_errors,NULL);
+ watch64_register(&stats->rx_over_errors,0);
+ watch64_enable  (&stats->rx_over_errors,NULL);
+ watch64_register(&stats->rx_crc_errors,0);
+ watch64_enable  (&stats->rx_crc_errors,NULL);
+ watch64_register(&stats->rx_frame_errors,0);
+ watch64_enable  (&stats->rx_frame_errors,NULL);
+ watch64_register(&stats->rx_fifo_errors,0);
+ watch64_enable  (&stats->rx_fifo_errors,NULL);
+ watch64_register(&stats->rx_missed_errors,0);
+ watch64_enable  (&stats->rx_missed_errors,NULL);
+ watch64_register(&stats->tx_aborted_errors,0);
+ watch64_enable  (&stats->tx_aborted_errors,NULL);
+ watch64_register(&stats->tx_carrier_errors,0);
+ watch64_enable  (&stats->tx_carrier_errors,NULL);
+ watch64_register(&stats->tx_fifo_errors,0);
+ watch64_enable  (&stats->tx_fifo_errors,NULL);
+ watch64_register(&stats->tx_heartbeat_errors,0);
+ watch64_enable  (&stats->tx_heartbeat_errors,NULL);
+ watch64_register(&stats->tx_window_errors,0);
+ watch64_enable  (&stats->tx_window_errors,NULL);
+ watch64_register(&stats->rx_compressed,0);
+ watch64_enable  (&stats->rx_compressed,NULL);
+ watch64_register(&stats->tx_compressed,0);
+ watch64_enable  (&stats->tx_compressed,NULL);
+}
+
+/*
+ * Unregister all the members of the net_device_stats structure
+ *
+ */
+ 
+inline void net_unregister_stats64(struct net_device_stats* stats)
+{
+ if (!stats)
+  return;
+
+ watch64_unregister(&stats->tx_packets,0);
+ watch64_unregister(&stats->rx_packets,0);
+ watch64_unregister(&stats->tx_bytes,0);
+ watch64_unregister(&stats->rx_bytes,0);
+ watch64_unregister(&stats->tx_errors,0);
+ watch64_unregister(&stats->rx_errors,0);
+ watch64_unregister(&stats->tx_dropped,0);
+ watch64_unregister(&stats->rx_dropped,0);
+ watch64_unregister(&stats->multicast,0);
+ watch64_unregister(&stats->collisions,0);
+ watch64_unregister(&stats->rx_length_errors,0);
+ watch64_unregister(&stats->rx_over_errors,0);
+ watch64_unregister(&stats->rx_crc_errors,0);
+ watch64_unregister(&stats->rx_frame_errors,0);
+ watch64_unregister(&stats->rx_fifo_errors,0);
+ watch64_unregister(&stats->rx_missed_errors,0);
+ watch64_unregister(&stats->tx_aborted_errors,0);
+ watch64_unregister(&stats->tx_carrier_errors,0);
+ watch64_unregister(&stats->tx_fifo_errors,0);
+ watch64_unregister(&stats->tx_heartbeat_errors,0);
+ watch64_unregister(&stats->tx_window_errors,0);
+ watch64_unregister(&stats->rx_compressed,0);
+ watch64_unregister(&stats->tx_compressed,0);
+}
 
 /*
  * Initialize the DEV module. At boot time this walks the device list and
diff -Nru a/net/core/net-sysfs.c b/net/core/net-sysfs.c
--- a/net/core/net-sysfs.c 2004-09-03 12:22:08 -04:00
+++ b/net/core/net-sysfs.c 2004-09-03 12:22:08 -04:00
@@ -16,6 +16,7 @@
 #include <net/sock.h>
 #include <linux/rtnetlink.h>
 #include <linux/wireless.h>
+#include <linux/watch64.h>
 
 #define to_class_dev(obj) container_of(obj,struct class_device,kobj)
 #define to_net_dev(class) container_of(class, struct net_device, class_dev)
@@ -23,6 +24,7 @@
 static const char fmt_hex[] = "%#x\n";
 static const char fmt_dec[] = "%d\n";
 static const char fmt_ulong[] = "%lu\n";
+static const char fmt_ullong[] = "%llu\n";
 
 static inline int dev_isalive(const struct net_device *dev) 
 {
@@ -204,8 +206,8 @@
  read_lock(&dev_base_lock);
  if (dev_isalive(dev) && dev->get_stats &&
      (stats = (*dev->get_stats)(dev))) 
-  ret = sprintf(buf, fmt_ulong,
-         *(unsigned long *)(((u8 *) stats) + offset));
+  ret = sprintf(buf, fmt_ullong,
+         watch64_getval((unsigned long *)(((u8 *) stats) + offset),NULL));
 
  read_unlock(&dev_base_lock);
  return ret;
