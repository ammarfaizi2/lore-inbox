Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266649AbUBQWTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266711AbUBQWTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:19:05 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:2294 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id S266649AbUBQWDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:03:46 -0500
Date: Tue, 17 Feb 2004 15:03:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][3/6] A different KGDB stub
Message-ID: <20040217220345.GD16881@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the kgdboe driver for this stub.

 Makefile   |    2 
 kgdb_eth.c |  160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)
--- linux-2.6.3-rc4/drivers/net/Makefile	2004-02-17 10:06:33.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/drivers/net/Makefile	2004-02-17 11:33:54.693744569 -0700
@@ -188,4 +188,6 @@ obj-$(CONFIG_NET_TULIP) += tulip/
 obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
 
+# Netpoll users must be last.
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+obj-$(CONFIG_KGDB_ETH) += kgdb_eth.o
--- linux-2.6.3-rc4/drivers/net/kgdb_eth.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/drivers/net/kgdb_eth.c	2004-02-17 11:34:07.216902332 -0700
@@ -0,0 +1,162 @@
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
+int kgdb_get_debug_char(void)
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
+void kgdb_flush_io(void)
+{
+	if(out_count && np.dev) {
+		netpoll_send_udp(&np, out_buf, out_count);
+		out_count = 0;
+		memset(out_buf, 0, sizeof(out_buf));
+	}
+}
+
+void kgdb_put_debug_char(int chr)
+{
+	out_buf[out_count++] = chr;
+	if(out_count == OUT_BUF_SIZE)
+		kgdb_flush_io();
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
+	if (!netpoll_trap() && (!kgdb_connected || msg[0] == 3)) {
+		netpoll_set_trap(0);
+		kgdb_schedule_breakpoint();
+	}
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
+int kgdb_hook_io(void)
+{
+	/* Un-initalized, don't go further. */
+	if (kgdboe != 1)
+		return 1;
+	return 0;
+}
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
