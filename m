Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUBLAHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 19:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266278AbUBLAGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 19:06:46 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:61115 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S266166AbUBLADb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 19:03:31 -0500
Date: Wed, 11 Feb 2004 17:03:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][3/6] A different KGDB stub
Message-ID: <20040212000329.GD19676@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the kgdboe driver for this stub.

 drivers/net/Kconfig    |    9 ++
 drivers/net/Makefile   |    1 
 drivers/net/kgdb_eth.c |  168 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
--- a/drivers/net/Kconfig	Wed Feb 11 15:41:45 2004
+++ b/drivers/net/Kconfig	Wed Feb 11 15:41:45 2004
@@ -187,6 +187,15 @@
 	  Note that the answer to this question won't directly affect the
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about Ethernet network cards. If unsure, say N.
+	
+config KGDB_ETH
+	bool "KGDB: On ethernet"
+	depends on KGDB
+	select NETPOLL
+	select NETPOLL_TRAP
+	select NETPOLL_RX
+	help
+	  Uses ethernet interface for kgdb.
 
 config MII
 	tristate "Generic Media Independent Interface device support"
--- a/drivers/net/Makefile	Wed Feb 11 15:41:45 2004
+++ b/drivers/net/Makefile	Wed Feb 11 15:41:45 2004
@@ -189,3 +189,4 @@
 obj-$(CONFIG_IRDA) += irda/
 
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+obj-$(CONFIG_KGDB_ETH) += kgdb_eth.o
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/net/kgdb_eth.c	Wed Feb 11 15:41:45 2004
@@ -0,0 +1,168 @@
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
+		memset(out_buf, 0, sizeof(out_buf));
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
+	/* Is this gdb trying to attach (!kgdb_connected) or break in
+	 * (msg[0] == 3) ? */
+	if (!netpoll_trap() && (!kgdb_connected || msg[0] == 3))
+		kgdb_schedule_breakpoint();
+
+	for (i = 0; i < len; i++) {
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

-- 
Tom Rini
http://gate.crashing.org/~trini/
