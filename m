Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTK3S4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTK3S4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:56:13 -0500
Received: from witte.sonytel.be ([80.88.33.193]:56987 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262765AbTK3S4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:56:03 -0500
Date: Sun, 30 Nov 2003 19:55:48 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.4.23 and CONFIG_PROC_FS=n
Message-ID: <Pine.GSO.4.21.0311301949180.23461-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling 2.4.23 with CONFIG_PROC_FS disabled, I found a few
network-related files that don't compile:
  1. net/atm/br2684.c 
  2. net/core/pktgen.c
  3. net/ipv4/netfilter/ipt_recent.c

The patch below fixes 1 and 3. Note that 3 still generates a compiler warning
(`ip_list_perms' defined but not used).

The packet generator is a bit trickier, since its functionality seems to
depend completely on the proc file system.

--- linux-2.4.23/net/atm/br2684.c.orig	2003-10-01 20:49:26.000000000 +0200
+++ linux-2.4.23/net/atm/br2684.c	2003-11-30 12:06:32.000000000 +0100
@@ -678,6 +678,7 @@
 	return -ENOIOCTLCMD;
 }
 
+#ifdef CONFIG_PROC_FS
 /* Never put more than 256 bytes in at once */
 static int br2684_proc_engine(loff_t pos, char *buf)
 {
@@ -770,16 +771,19 @@
 };
 
 extern struct proc_dir_entry *atm_proc_root;	/* from proc.c */
+#endif /* CONFIG_PROC_FS */
 
 /* the following avoids some spurious warnings from the compiler */
 #define UNUSED __attribute__((unused))
 
 static int __init UNUSED br2684_init(void)
 {
+#ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *p;
 	if ((p = create_proc_entry("br2684", 0, atm_proc_root)) == NULL)
 		return -ENOMEM;
 	p->proc_fops = &br2684_proc_operations;
+#endif /* CONFIG_PROC_FS */
 	br2684_ioctl_set(br2684_ioctl);
 	return 0;
 }
@@ -788,7 +792,9 @@
 {
 	struct br2684_dev *brdev;
 	br2684_ioctl_set(NULL);
+#ifdef CONFIG_PROC_FS
 	remove_proc_entry("br2684", atm_proc_root);
+#endif /* CONFIG_PROC_FS */
 	while (!list_empty(&br2684_devs)) {
 		brdev = list_entry_brdev(br2684_devs.next);
 		unregister_netdev(&brdev->net_dev);
--- linux-2.4.23/net/ipv4/netfilter/ipt_recent.c.orig	2003-07-08 13:31:59.000000000 +0200
+++ linux-2.4.23/net/ipv4/netfilter/ipt_recent.c	2003-11-30 19:24:09.000000000 +0100
@@ -91,9 +91,6 @@
  */
 static spinlock_t recent_lock = SPIN_LOCK_UNLOCKED;
 
-/* Our /proc/net/ipt_recent entry */
-static struct proc_dir_entry *proc_net_ipt_recent = NULL;
-
 /* Function declaration for later. */
 static int
 match(const struct sk_buff *skb,
@@ -123,6 +120,9 @@
 }
 
 #ifdef CONFIG_PROC_FS
+/* Our /proc/net/ipt_recent entry */
+static struct proc_dir_entry *proc_net_ipt_recent = NULL;
+
 /* This is the function which produces the output for our /proc output
  * interface which lists each IP address, the last seen time and the 
  * other recent times the address was seen.
@@ -963,8 +963,10 @@
 	int count;
 
 	printk(version);
+#ifdef CONFIG_PROC_FS
 	proc_net_ipt_recent = proc_mkdir("ipt_recent",proc_net);
 	if(!proc_net_ipt_recent) return -ENOMEM;
+#endif /* CONFIG_PROC_FS */
 
 	if(ip_list_hash_size && ip_list_hash_size <= ip_list_tot) {
 	  printk(KERN_WARNING RECENT_NAME ": ip_list_hash_size too small, resetting to default.\n");
@@ -990,7 +992,9 @@
 {
 	ipt_unregister_match(&recent_match);
 
+#ifdef CONFIG_PROC_FS
 	remove_proc_entry("ipt_recent",proc_net);
+#endif /* CONFIG_PROC_FS */
 }
 
 /* Register our module with the kernel. */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

