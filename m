Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTJCBsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 21:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbTJCBsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 21:48:40 -0400
Received: from waste.org ([209.173.204.2]:16840 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263580AbTJCBsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 21:48:33 -0400
Date: Thu, 2 Oct 2003 20:48:28 -0500
From: Matt Mackall <mpm@selenic.com>
To: netdev@oss.sgi.co, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: [RFC] [PATCH 3/3] netconsole using netpoll
Message-ID: <20031003014828.GT1897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the netpoll API to transmit kernel printks over UDP


 ml-mpm/Documentation/networking/netconsole.txt |   57 +++++++++++
 ml-mpm/drivers/net/Kconfig                     |    7 +
 ml-mpm/drivers/net/Makefile                    |    1 
 ml-mpm/drivers/net/netconsole.c                |  129 +++++++++++++++++++++++++
 ml-mpm/net/Kconfig                             |    5 
 5 files changed, 196 insertions(+), 3 deletions(-)

diff -puN -L net/core/netconsole.c /dev/null /dev/null
diff -puN net/core/Makefile~netconsole net/core/Makefile
diff -puN net/Kconfig~netconsole net/Kconfig
--- ml/net/Kconfig~netconsole	2003-10-02 17:56:34.000000000 -0500
+++ ml-mpm/net/Kconfig	2003-10-02 17:56:34.000000000 -0500
@@ -671,11 +671,10 @@ source "net/irda/Kconfig"
 source "net/bluetooth/Kconfig"
 
 config NETPOLL
-	bool "Netpoll API"
+	def_bool NETCONSOLE
 
 config NETPOLL_RX
-	bool "Netpoll receive hooks"
-	depends on NETPOLL
+	def_bool NETCONSOLE
 
 config NETPOLL_TRAP
 	bool "Netpoll traffic trapping"
diff -puN /dev/null Documentation/networking/netconsole.txt
--- /dev/null	2003-09-12 12:14:37.000000000 -0500
+++ ml-mpm/Documentation/networking/netconsole.txt	2003-10-02 17:56:34.000000000 -0500
@@ -0,0 +1,57 @@
+
+started by Ingo Molnar <mingo@redhat.com>, 2001.09.17
+2.6 port and netpoll api by Matt Mackall <mpm@selenic.com>, Sep 9 2003
+
+Please send bug reports to Matt Mackall <mpm@selenic.com>
+
+This module logs kernel printk messages over UDP allowing debugging of
+problem where disk logging fails and serial consoles are impractical.
+
+It can be used either built-in or as a module. As a built-in,
+netconsole initializes immediately after NIC cards and will bring up
+the specified interface as soon as possible. While this doesn't allow
+capture of early kernel panics, it does capture most of the boot
+process.
+
+It takes a string configuration parameter "netconsole" in the
+following format:
+
+ netconsole=[src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
+
+   where
+        src-port      source for UDP packets (defaults to 6665)
+        src-ip        source IP to use (interface address)
+        dev           network interface (eth0)
+        tgt-port      port for logging agent (6666)
+        tgt-ip        IP address for logging agent
+        tgt-macaddr   ethernet MAC address for logging agent (broadcast)
+
+Examples:
+
+ linux netconsole=4444@10.0.0.1/eth1,9353@10.0.0.2/12:34:56:78:9a:bc
+
+  or
+
+ insmod netconsole netconsole=@/,@10.0.0.2/
+
+Built-in netconsole starts immediately after the TCP stack is
+initialized and attempts to bring up the supplied dev at the supplied
+address.
+
+The remote host can run either 'netcat -u -l -p <port>' or syslogd.
+
+WARNING: the default target ethernet setting uses the broadcast
+ethernet address to send packets, which can cause increased load on
+other systems on the same ethernet segment.
+
+NOTE: the network device (eth1 in the above case) can run any kind
+of other network traffic, netconsole is not intrusive. Netconsole
+might cause slight delays in other traffic if the volume of kernel
+messages is high, but should have no other impact.
+
+Netconsole was designed to be as instantaneous as possible, to
+enable the logging of even the most critical kernel bugs. It works
+from IRQ contexts as well, and does not enable interrupts while
+sending packets. Due to these unique needs, configuration can not
+be more automatic, and some fundamental limitations will remain:
+only IP networks, UDP packets and ethernet devices are supported.
diff -puN drivers/net/Makefile~netconsole drivers/net/Makefile
--- ml/drivers/net/Makefile~netconsole	2003-10-02 17:56:34.000000000 -0500
+++ ml-mpm/drivers/net/Makefile	2003-10-02 17:57:25.000000000 -0500
@@ -188,3 +188,4 @@ obj-$(CONFIG_NET_TULIP) += tulip/
 obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
 
+obj-$(CONFIG_NETCONSOLE) += netconsole.o
diff -puN drivers/net/Kconfig~netconsole drivers/net/Kconfig
--- ml/drivers/net/Kconfig~netconsole	2003-10-02 17:56:34.000000000 -0500
+++ ml-mpm/drivers/net/Kconfig	2003-10-02 17:56:34.000000000 -0500
@@ -2455,6 +2455,13 @@ config SHAPER
 	  To compile this driver as a module, choose M here: the module
 	  will be called shaper.  If unsure, say N.
 
+config NETCONSOLE
+	tristate "Network console logging support"
+	depends on NETDEVICES
+	---help---
+	If you want to log kernel messages over the network, enable this.
+	See Documentation/networking/netconsole.txt for details.
+
 source "drivers/net/wan/Kconfig"
 
 source "drivers/net/pcmcia/Kconfig"
diff -puN /dev/null drivers/net/netconsole.c
--- /dev/null	2003-09-12 12:14:37.000000000 -0500
+++ ml-mpm/drivers/net/netconsole.c	2003-10-02 17:56:34.000000000 -0500
@@ -0,0 +1,129 @@
+/*
+ *  linux/drivers/net/netconsole.c
+ *
+ *  Copyright (C) 2001  Ingo Molnar <mingo@redhat.com>
+ *
+ *  This file contains the implementation of an IRQ-safe, crash-safe
+ *  kernel console implementation that outputs kernel messages to the
+ *  network.
+ *
+ * Modification history:
+ *
+ * 2001-09-17    started by Ingo Molnar.
+ * 2003-08-11    2.6 port by Matt Mackall
+ *               simplified options
+ *               generic card hooks
+ *               works non-modular
+ * 2003-09-07    rewritten with netpoll api
+ */
+
+/****************************************************************
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation; either version 2, or (at your option)
+ *      any later version.
+ *
+ *      This program is distributed in the hope that it will be useful,
+ *      but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *      GNU General Public License for more details.
+ *
+ *      You should have received a copy of the GNU General Public License
+ *      along with this program; if not, write to the Free Software
+ *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ ****************************************************************/
+
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/console.h>
+#include <linux/tty_driver.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/string.h>
+#include <linux/sysrq.h>
+#include <linux/smp.h>
+#include <linux/netpoll.h>
+
+MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
+MODULE_DESCRIPTION("Console driver for network interfaces");
+MODULE_LICENSE("GPL");
+
+static char config[256];
+module_param_string(netconsole, config, 256, 0);
+MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]\n");
+
+static void rx_hook(struct netpoll *np, int port, char *msg, int len);
+
+static struct netpoll np = {
+	.name = "netconsole",
+	.dev_name = "eth0",
+	.rx_hook = rx_hook,
+	.local_port = 6665,
+	.remote_port = 6666,
+	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+};
+
+#define MAX_PRINT_CHUNK 1000
+
+static void write_msg(struct console *con, const char *msg, unsigned int len)
+{
+	int frag, left;
+	unsigned long flags;
+
+	if (!np.dev)
+		return;
+
+	local_irq_save(flags);
+
+	for(left = len; left; ) {
+		frag = min(left, MAX_PRINT_CHUNK);
+		netpoll_send_udp(&np, msg, frag);
+		msg += frag;
+		left -= frag;
+	}
+
+	local_irq_restore(flags);
+}
+
+static void rx_hook(struct netpoll *np, int port, char *msg, int len)
+{
+	/* add sysrq support */
+	printk("netconsole: no sysrq yet\n");
+}
+
+static struct console netconsole = {
+	.flags = CON_ENABLED | CON_PRINTBUFFER,
+	.write = write_msg
+};
+
+static int option_setup(char *opt)
+{
+	return netpoll_parse_options(&np, opt);
+}
+
+__setup("netconsole=", option_setup);
+
+static int init_netconsole(void)
+{
+	if(strlen(config) && option_setup(config))
+		return 1;
+
+	if(!np.remote_ip || netpoll_setup(&np))
+		return 1;
+
+	register_console(&netconsole);
+	printk(KERN_INFO "netconsole: network logging started\n");
+	return 0;
+}
+
+static void cleanup_netconsole(void)
+{
+	unregister_console(&netconsole);
+	netpoll_cleanup(&np);
+}
+
+module_init(init_netconsole);
+module_exit(cleanup_netconsole);

_


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
