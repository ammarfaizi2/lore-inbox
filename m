Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUBVQhm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbUBVQhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:37:42 -0500
Received: from gprs148-229.eurotel.cz ([160.218.148.229]:59776 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261690AbUBVQhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:37:33 -0500
Date: Sun, 22 Feb 2004 17:08:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: 3/3 kgdb over netpoll
Message-ID: <20040222160849.GA9563@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is kgdb-over-ethernet patch. Depends on netpoll, and is somehow
experimental.
								Pavel

Index: linux-2.6.3-kgdb/drivers/net/Kconfig
===================================================================
--- linux-2.6.3-kgdb.orig/drivers/net/Kconfig	2004-02-19 13:35:52.000000000 +0530
+++ linux-2.6.3-kgdb/drivers/net/Kconfig	2004-02-19 14:09:33.854280848 +0530
@@ -187,6 +187,12 @@
 	  Note that the answer to this question won't directly affect the
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about Ethernet network cards. If unsure, say N.
+	
+config KGDB_ETH
+	bool "KGDB: On ethernet"
+	depends on KGDB
+	help
+	  Uses ethernet interface for kgdb.
 
 config MII
 	tristate "Generic Media Independent Interface device support"
Index: linux-2.6.3-kgdb/drivers/net/kgdb_eth.c
===================================================================
--- linux-2.6.3-kgdb.orig/drivers/net/kgdb_eth.c	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.3-kgdb/drivers/net/kgdb_eth.c	2004-02-19 14:09:33.854280848 +0530
@@ -0,0 +1,170 @@
+/*
+ * Network interface GDB stub
+ *
+ * Copyright (C), 2004 Amit S. Kale 
+ *
+ * Written by San Mehat (nettwerk@biodome.org)
+ * Based upon 'gdbserial' by David Grothe (dave@gcom.com)
+ * and Scott Foehner (sfoehner@engr.sgi.com)
+ *
+ * Twiddled for 2.6 by Robert Walsh <rjwalsh@durables.org>
+ * and wangdi <wangdi@clusterfs.com>.
+ *
+ * Restructured for generic a gdb interface 
+ * Reveral changes to make it free of device driver changes.
+ * Added internal buffers for this interface.
+ * 	by Amit S. Kale <amitkale@emsyssoft.com>
+ *
+ * Refactored for netpoll API by Matt Mackall <mpm@selenic.com>
+ *
+ * Some cleanups by Pavel Machek <pavel@suse.cz>
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/config.h>
+#include <linux/major.h>
+#include <linux/string.h>
+#include <linux/fcntl.h>
+#include <linux/termios.h>
+#include <linux/kgdb.h>
+#include <linux/if_ether.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/inet.h>
+#include <linux/notifier.h>
+#include <linux/netpoll.h>
+
+#include <net/tcp.h>
+#include <net/udp.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/segment.h>
+#include <asm/bitops.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+
+#define IN_BUF_SIZE 512 /* power of 2, please */
+#define OUT_BUF_SIZE 30	/* We don't want to send too big of a packet. */
+
+static char in_buf[IN_BUF_SIZE], out_buf[OUT_BUF_SIZE];
+static int in_head, in_tail, out_count;
+static atomic_t in_count;
+int kgdboe = 0; /* Default to tty mode */
+
+extern void breakpoint(void);
+static void rx_hook(struct netpoll *np, int port, char *msg, int len);
+
+static struct netpoll np = {
+	.name = "kgdboe",
+	.dev_name = "eth0",
+	.rx_hook = rx_hook,
+	.local_port = 6443,
+	.remote_port = 6442,
+	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+};
+
+int eth_getDebugChar(void)
+{
+	int chr;
+
+	while (atomic_read(&in_count) == 0)
+		netpoll_poll(&np);
+
+	chr = in_buf[in_tail++];
+	in_tail &= (IN_BUF_SIZE - 1);
+	atomic_dec(&in_count);
+	return chr;
+}
+
+void eth_flushDebugChar(void)
+{
+	if(out_count && np.dev) {
+		netpoll_send_udp(&np, out_buf, out_count);
+		out_count = 0;
+	}
+}
+
+void eth_putDebugChar(int chr)
+{
+	out_buf[out_count++] = chr;
+	if(out_count == OUT_BUF_SIZE)
+		eth_flushDebugChar();
+}
+
+static void rx_hook(struct netpoll *np, int port, char *msg, int len)
+{
+	int i;
+
+	np->remote_port = port;
+
+	/* Is this gdb trying to attach? */
+	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
+		breakpoint();
+
+	for (i = 0; i < len; i++) {
+		if (msg[i] == 3)
+			breakpoint();
+
+		if (atomic_read(&in_count) >= IN_BUF_SIZE) {
+			/* buffer overflow, clear it */
+			in_head = in_tail = 0;
+			atomic_set(&in_count, 0);
+			break;
+		}
+		in_buf[in_head++] = msg[i];
+		in_head &= (IN_BUF_SIZE - 1);
+		atomic_inc(&in_count);
+	}
+}
+
+static int option_setup(char *opt)
+{
+	return netpoll_parse_options(&np, opt);
+}
+
+__setup("kgdboe=", option_setup);
+
+static int hook(void)
+{
+	/* Un-initalized, don't go further. */
+	if (kgdboe != 1)
+		return 1;
+	return 0;
+}
+
+struct kgdb_serial kgdbeth_serial = {
+	.read_char = eth_getDebugChar,
+	.write_char = eth_putDebugChar,
+	.hook = hook,
+	.flush = eth_flushDebugChar,
+};
+
+static int init_kgdboe(void)
+{
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > CONFIG_NO_KGDB_CPUS) {
+		printk("kgdb: too manu cpus. Cannot enable debugger with more than %d cpus\n", CONFIG_NO_KGDB_CPUS);
+		return -1;
+	}
+#endif
+
+	if(!np.remote_ip || netpoll_setup(&np))
+		return 1;
+
+	kgdb_serial = &kgdbeth_serial;
+	kgdboe = 1;
+	printk(KERN_INFO "kgdb: debugging over ethernet enabled\n");
+
+	return 0;
+}
+
+module_init(init_kgdboe);
Index: linux-2.6.3-kgdb/drivers/net/Makefile
===================================================================
--- linux-2.6.3-kgdb.orig/drivers/net/Makefile	2004-02-19 13:35:52.000000000 +0530
+++ linux-2.6.3-kgdb/drivers/net/Makefile	2004-02-19 14:09:33.862279632 +0530
@@ -32,6 +32,8 @@
 
 obj-$(CONFIG_OAKNET) += oaknet.o 8390.o
 
+obj-$(CONFIG_KGDB_ETH) += kgdb_eth.o
+
 obj-$(CONFIG_DGRS) += dgrs.o
 obj-$(CONFIG_RCPCI) += rcpci.o
 obj-$(CONFIG_VORTEX) += 3c59x.o
Index: linux-2.6.3-kgdb/net/core/dev.c
===================================================================
--- linux-2.6.3-kgdb.orig/net/core/dev.c	2004-02-19 13:35:50.000000000 +0530
+++ linux-2.6.3-kgdb/net/core/dev.c	2004-02-19 14:09:33.879277048 +0530
@@ -1547,7 +1547,6 @@
 }
 #endif
 
-
 /**
  *	netif_rx	-	post buffer to the network code
  *	@skb: buffer to post
Index: linux-2.6.3-kgdb/net/core/skbuff.c
===================================================================
--- linux-2.6.3-kgdb.orig/net/core/skbuff.c	2004-02-19 13:35:50.000000000 +0530
+++ linux-2.6.3-kgdb/net/core/skbuff.c	2004-02-19 14:09:33.888275680 +0530
@@ -55,6 +55,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <linux/debugger.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
