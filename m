Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbUJ2TWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUJ2TWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUJ2TWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:22:53 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54251 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S263494AbUJ2See (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:34:34 -0400
Subject: [patch 8/8] KGDB over ethernet driver
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, jgarzik@pobox.com,
       mpm@selenic.com
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <8.29102004.trini@kernel.crashing.org>
In-Reply-To: <7.29102004.trini@kernel.crashing.org>
References: <7.29102004.trini@kernel.crashing.org> <1.29102004.trini@kernel.crashing.org>
Date: Fri, 29 Oct 2004 11:34:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: Jeff Garzik <jgarzik@pobox.com>, Matt Mackall <mpm@selenic.com>
This adds a KGDB over ethernet driver that makes use of the netpoll API to
function.

---

 linux-2.6.10-rc1-trini/drivers/net/Makefile   |    1 
 linux-2.6.10-rc1-trini/drivers/net/kgdb_eth.c |  132 ++++++++++++++++++++++++++
 linux-2.6.10-rc1-trini/kernel/kgdb.c          |    9 +
 linux-2.6.10-rc1-trini/lib/Kconfig.debug      |    8 +
 4 files changed, 150 insertions(+)

diff -puN drivers/net/Makefile~eth drivers/net/Makefile
--- linux-2.6.10-rc1/drivers/net/Makefile~eth	2004-10-29 11:26:45.949099534 -0700
+++ linux-2.6.10-rc1-trini/drivers/net/Makefile	2004-10-29 11:26:45.958097421 -0700
@@ -196,3 +196,4 @@ obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
 
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+obj-$(CONFIG_KGDB_ETH) += kgdb_eth.o
diff -puN /dev/null drivers/net/kgdb_eth.c
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/drivers/net/kgdb_eth.c	2004-10-29 11:26:45.958097421 -0700
@@ -0,0 +1,132 @@
+/*
+ * drivers/net/kgdb_eth.c
+ *
+ * A network interface for GDB.
+ * Based upon 'gdbserial' by David Grothe <dave@gcom.com>
+ * and Scott Foehner <sfoehner@engr.sgi.com>
+ *
+ * Maintainers: Amit S. Kale <amitkale@emsyssoft.com> and
+ * 		Tom Rini <trini@kernel.crashing.org>
+ *
+ * 2004 (c) Amit S. Kale <amitkale@emsyssoft.com>
+ * 2004 (c) MontaVista Software, Inc.
+ *
+ * Other folks:
+ * San Mehat <nettwerk@biodome.org>
+ * Robert Walsh <rjwalsh@durables.org>
+ * wangdi <wangdi@clusterfs.com>.
+ * Matt Mackall <mpm@selenic.com>
+ * Pavel Machek <pavel@suse.cz>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
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
+static int configured;
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
+static int eth_getDebugChar(void)
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
+static void eth_flushDebugChar(void)
+{
+	if (out_count && np.dev) {
+		netpoll_send_udp(&np, out_buf, out_count);
+		memset(out_buf, 0, sizeof(out_buf));
+		out_count = 0;
+	}
+}
+
+static void eth_putDebugChar(int chr)
+{
+	out_buf[out_count++] = chr;
+	if (out_count == OUT_BUF_SIZE)
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
+	if (!kgdb_connected)
+		kgdb_schedule_breakpoint();
+
+	for (i = 0; i < len; i++) {
+		if (msg[i] == 3)
+			kgdb_schedule_breakpoint();
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
+/* We must be passed configuration options. */
+static int option_setup(char *opt)
+{
+	configured = !netpoll_parse_options(&np, opt);
+	return 0;
+}
+__setup("kgdboe=", option_setup);
+
+int init_kgdboe(void)
+{
+	if (!configured || netpoll_setup(&np))
+		return 1;
+
+	printk(KERN_INFO "kgdb: debugging over ethernet enabled\n");
+
+	return 0;
+}
+
+struct kgdb_io kgdb_io_ops = {
+	.read_char = eth_getDebugChar,
+	.write_char = eth_putDebugChar,
+	.init = init_kgdboe,
+	.flush = eth_flushDebugChar,
+};
diff -puN kernel/kgdb.c~eth kernel/kgdb.c
--- linux-2.6.10-rc1/kernel/kgdb.c~eth	2004-10-29 11:26:45.952098830 -0700
+++ linux-2.6.10-rc1-trini/kernel/kgdb.c	2004-10-29 11:26:45.959097187 -0700
@@ -52,6 +52,7 @@
 #include <asm/cacheflush.h>
 #include <linux/init.h>
 #include <linux/sysrq.h>
+#include <linux/netpoll.h>
 
 extern int pid_max;
 extern int pidhash_init_done;
@@ -730,6 +731,10 @@ int kgdb_handle_exception(int exVector, 
 
 acquirelock:
 
+#ifdef CONFIG_KGDB_ETH
+	netpoll_set_trap(1);
+#endif
+
 	/*
 	 * Interrupts will be restored by the 'trap return' code, except when
 	 * single stepping.
@@ -1144,6 +1149,10 @@ acquirelock:
 	}
 
       kgdb_exit:
+#ifdef CONFIG_KGDB_ETH
+	netpoll_set_trap(0);
+#endif
+
 	kgdb_info[processor].debuggerinfo = NULL;
 	kgdb_info[processor].task = NULL;
 	procindebug[smp_processor_id()] = 0;
diff -puN lib/Kconfig.debug~eth lib/Kconfig.debug
--- linux-2.6.10-rc1/lib/Kconfig.debug~eth	2004-10-29 11:26:45.954098360 -0700
+++ linux-2.6.10-rc1-trini/lib/Kconfig.debug	2004-10-29 11:26:45.960096952 -0700
@@ -145,6 +145,14 @@ config KGDB_SIBYTE
 	bool "KGDB: On the Broadcom SWARM serial port"
 	depends on MIPS && SIBYTE_SB1xxx_SOC
 
+config KGDB_ETH
+	bool "KGDB: On ethernet"
+	select NETPOLL
+	select NETPOLL_TRAP
+	select NETPOLL_RX
+	help
+	  Uses ethernet interface for kgdb.
+
 endchoice
 
 config KGDB_SIMPLE_SERIAL
_
