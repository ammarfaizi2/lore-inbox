Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVH2QMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVH2QMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVH2QLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:11:55 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:26060 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751287AbVH2QLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:11:22 -0400
Subject: [patch 12/16] KGDBoE I/O driver
Date: Mon, 29 Aug 2005 09:11:21 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.12.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.11.2982005.trini@kernel.crashing.org>
References: <resend.11.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the simple KGDB over Ethernet I/O driver that uses netpoll for all of
the heavy lifting.  At one point this was very similar to the version Matt
Mackall wrote and is currently in Andrew's tree.  Since then it has been
reworked to fit into our model.

---

 linux-2.6.13-trini/drivers/net/Makefile |    1 
 linux-2.6.13-trini/drivers/net/kgdboe.c |  208 ++++++++++++++++++++++++++++
 linux-2.6.13-trini/lib/Kconfig.debug    |   24 +++
 3 files changed, 233 insertions(+)

diff -puN /dev/null drivers/net/kgdboe.c
--- /dev/null	2005-08-08 08:07:04.272443000 -0700
+++ linux-2.6.13-trini/drivers/net/kgdboe.c	2005-08-08 19:16:03.000000000 -0700
@@ -0,0 +1,208 @@
+/*
+ * drivers/net/kgdboe.c
+ *
+ * A network interface for GDB.
+ * Based upon 'gdbserial' by David Grothe <dave@gcom.com>
+ * and Scott Foehner <sfoehner@engr.sgi.com>
+ *
+ * Maintainers: Amit S. Kale <amitkale@linsyssoft.com> and
+ * 		Tom Rini <trini@kernel.crashing.org>
+ *
+ * 2004 (c) Amit S. Kale <amitkale@linsyssoft.com>
+ * 2004-2005 (c) MontaVista Software, Inc.
+ * 2005 (c) Wind River Systems, Inc.
+ *
+ * Other folks:
+ * San Mehat <nettwerk@biodome.org>
+ * Robert Walsh <rjwalsh@durables.org>
+ * wangdi <wangdi@clusterfs.com>.
+ * Matt Mackall <mpm@selenic.com>
+ * Pavel Machek <pavel@suse.cz>
+ * Jason Wessel <jason.wessel@windriver.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Changes:
+ * 3/10/05 - Jason Wessel <jason.wessel@windriver.com>
+ * - Added ability to compile/load as module
+ *
+ * Known problems:
+ * - There is no way to deny the unloading of the module
+ *   if KGDB is connected, but an attempt is made to handle it
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+#include <linux/kgdb.h>
+#include <linux/netpoll.h>
+#include <linux/init.h>
+
+#include <asm/atomic.h>
+
+#define IN_BUF_SIZE 512		/* power of 2, please */
+#define OUT_BUF_SIZE 30		/* We don't want to send too big of a packet. */
+
+static char in_buf[IN_BUF_SIZE], out_buf[OUT_BUF_SIZE];
+static int in_head, in_tail, out_count;
+static atomic_t in_count;
+/* 0 = unconfigured, 1 = netpoll options parsed, 2 = fully configured. */
+static int configured;
+
+static void rx_hook(struct netpoll *np, int port, char *msg, int len);
+static void eth_pre_exception_handler(void);
+static void eth_post_exception_handler(void);
+static int eth_get_char(void);
+static void eth_flush_buf(void);
+static void eth_put_char(int chr);
+int init_kgdboe(void);
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
+MODULE_DESCRIPTION("KGDB driver for network interfaces");
+MODULE_LICENSE("GPL");
+static char config[256];
+module_param_string(kgdboe, config, 256, 0);
+MODULE_PARM_DESC(kgdboe, " kgdboe=[src-port]@[src-ip]/[dev],"
+		 "[tgt-port]@<tgt-ip>/<tgt-macaddr>\n");
+
+static struct kgdb_io local_kgdb_io_ops = {
+	.read_char = eth_get_char,
+	.write_char = eth_put_char,
+	.init = init_kgdboe,
+	.flush = eth_flush_buf,
+	.pre_exception = eth_pre_exception_handler,
+	.post_exception = eth_post_exception_handler
+};
+
+static void eth_pre_exception_handler(void)
+{
+	netpoll_set_trap(1);
+}
+
+static void eth_post_exception_handler(void)
+{
+	netpoll_set_trap(0);
+}
+
+static int eth_get_char(void)
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
+static void eth_flush_buf(void)
+{
+	if (out_count && np.dev) {
+		netpoll_send_udp(&np, out_buf, out_count);
+		memset(out_buf, 0, sizeof(out_buf));
+		out_count = 0;
+	}
+}
+
+static void eth_put_char(int chr)
+{
+	out_buf[out_count++] = chr;
+	if (out_count == OUT_BUF_SIZE)
+		eth_flush_buf();
+}
+
+static void rx_hook(struct netpoll *np, int port, char *msg, int len)
+{
+	int i;
+
+	np->remote_port = port;
+
+	/*
+	 * This could be GDB trying to attach.  But it could also be GDB
+	 * finishing up a session, with kgdb_connected=0 but GDB sending
+	 * an ACK for the final packet.  To make sure we don't try and
+	 * make a breakpoint when GDB is leaving, make sure that if
+	 * !kgdb_connected the only len == 1 packet we allow is ^C.
+	 */
+	if (!kgdb_connected && (len != 1 || msg[0] == 3) &&
+	    !atomic_read(&kgdb_setting_breakpoint))
+		tasklet_schedule(&kgdb_tasklet_breakpoint);
+
+	for (i = 0; i < len; i++) {
+		if (msg[i] == 3)
+			tasklet_schedule(&kgdb_tasklet_breakpoint);
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
+	configured = !netpoll_parse_options(&np, opt);
+	return 0;
+}
+
+__setup("kgdboe=", option_setup);
+
+int init_kgdboe(void)
+{
+	/* Already done? */
+	if (configured == 2)
+		return 0;
+
+	if (strlen(config))
+		option_setup(config);
+
+	if (!configured) {
+		printk("kgdboe: configuration incorrect - kgdboe not "
+		       "loaded.\n");
+		printk("  Usage: kgdboe=[src-port]@[src-ip]/[dev],[tgt-port]"
+		       "@<tgt-ip>/[tgt-macaddr]\n");
+		return -EINVAL;
+	}
+
+	if (netpoll_setup(&np)) {
+		printk("kgdboe: netpoll_setup failed kgdboe failed\n");
+		return -EINVAL;
+	}
+
+	if (kgdb_register_io_module(&local_kgdb_io_ops))
+		return -EINVAL;
+
+	printk(KERN_INFO "kgdboe: debugging over ethernet enabled\n");
+
+	configured = 2;
+
+	return 0;
+}
+
+static void cleanup_kgdboe(void)
+{
+	netpoll_cleanup(&np);
+	configured = 0;
+
+	kgdb_unregister_io_module(&local_kgdb_io_ops);
+}
+
+module_init(init_kgdboe);
+module_exit(cleanup_kgdboe);
diff -puN drivers/net/Makefile~eth drivers/net/Makefile
--- linux-2.6.13/drivers/net/Makefile~eth	2005-08-08 19:16:03.000000000 -0700
+++ linux-2.6.13-trini/drivers/net/Makefile	2005-08-08 19:16:03.000000000 -0700
@@ -195,3 +195,4 @@ obj-$(CONFIG_IRDA) += irda/
 obj-$(CONFIG_ETRAX_ETHERNET) += cris/
 
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+obj-$(CONFIG_KGDBOE) += kgdboe.o
diff -puN lib/Kconfig.debug~eth lib/Kconfig.debug
--- linux-2.6.13/lib/Kconfig.debug~eth	2005-08-08 19:16:03.000000000 -0700
+++ linux-2.6.13-trini/lib/Kconfig.debug	2005-08-08 19:16:03.000000000 -0700
@@ -217,6 +217,18 @@ config KGDB_8250_NOMODULE
 	  GDB.  This is independent of the normal (SERIAL_8250) driver
 	  for this chipset.
 
+config KGDBOE_NOMODULE
+	bool "KGDB: On ethernet - in kernel"
+	select KGDBOE
+	select NETPOLL
+	select NETPOLL_TRAP
+	select NETPOLL_RX
+	help
+	  Uses the NETPOLL API to communicate with the host GDB via UDP.
+	  In order for this to work, the ethernet interface specified must
+	  support the NETPOLL API, and this must be initialized at boot.
+	  See the documentation for syntax.
+
 config KGDB_MPSC
 	bool "KGDB on MV64x60 MPSC"
 	depends on SERIAL_MPSC
@@ -247,6 +259,18 @@ config KGDB_SH_SCI
 
 endchoice
 
+config KGDBOE
+	tristate "KGDB: On ethernet" if !KGDBOE_NOMODULE
+	depends on m && KGDB_ONLY_MODULES
+	select NETPOLL
+	select NETPOLL_TRAP
+	select NETPOLL_RX
+	help
+	  Uses the NETPOLL API to communicate with the host GDB via UDP.
+	  In order for this to work, the ethernet interface specified must
+	  support the NETPOLL API, and this must be initialized at boot.
+	  See the documentation for syntax.
+
 config KGDB_8250
 	tristate "KGDB: On generic serial port (8250)" if !KGDB_8250_NOMODULE
 	depends on m && KGDB_ONLY_MODULES
_
