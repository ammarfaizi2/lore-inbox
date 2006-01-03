Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWACMoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWACMoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 07:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWACMoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 07:44:12 -0500
Received: from ns2.suse.de ([195.135.220.15]:11728 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751383AbWACMoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 07:44:12 -0500
Date: Tue, 3 Jan 2006 13:44:01 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20060103124401.GA23700@suse.de>
References: <20051209140559.GA23868@suse.de> <20051209152530.GE15372@harddisk-recovery.com> <20051209170841.GB31708@flint.arm.linux.org.uk> <20051212100318.GA10040@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051212100318.GA10040@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Dec 12, Olaf Hering wrote:

Russell,
are you ok with the arch specific approach? 



a POWER4 system in 'full-system-partition' mode has the console device
on ttyS0. But the user interface to the Linux system console may still
be on the hardware management console (HMC). If this is the case, there
is no way to send a break to trigger a sysrq.
Other setups do already use 'ctrl o' to trigger sysrq. This includes iSeries
virtual console on tty1, and pSeries LPAR console on hvc0 or hvsi0.

To limit the 'ctrl o' only to the affected systems, query the model property
in the device-tree. The patch makes the serial console not-eight-bit-clean.
Booting with 'console=ttyS0' will disable 'ctrl o', it is only enabled
with console autodetection.

'ctrl o' is currently mapped to 'flush output', see 'stty -a'


Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/setup-common.c |   45 +++++++++++++++++++++++++++++++++++++
 drivers/serial/8250.c              |    4 +++
 include/asm-powerpc/serial.h       |    6 ++++
 3 files changed, 55 insertions(+)

Index: linux-2.6.15-rc6-olh/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6.15-rc6-olh.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6.15-rc6-olh/arch/powerpc/kernel/setup-common.c
@@ -295,6 +295,48 @@ struct seq_operations cpuinfo_op = {
 };
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
+#if defined(CONFIG_PPC_PSERIES) && defined(CONFIG_SERIAL_8250_CONSOLE)
+/*
+ * Handle the SysRq ^O Hack also via ttyS0 on POWER4 systems
+ * but only on the system console, see asm/serial.h
+ * If they run in FullSystemPartition mode, the firmware console comes in via ttyS0
+ * But BREAK does not work via the HMC, to trigger sysrq.
+ * Affected Models:
+ * p690 7040-681
+ * p670 7040-671
+ * p655 7039-651
+ * p650 7038-6M2
+ * p630 7028-6E4 tower
+ * p630 7028-6C4 rack
+ * p615 7029-6E3 tower
+ * p615 7029-6C3 rack
+ */
+int power4_sysrq_via_ctrl_o;
+
+static void detect_power4_console(void)
+{
+	struct device_node *root;
+	char *model;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		model = get_property(root, "model", NULL);
+		if (model) {
+			if(!strcmp(model, "IBM,7040-681") ||
+			   !strcmp(model, "IBM,7040-671") ||
+			   !strcmp(model, "IBM,7039-651") ||
+			   !strcmp(model, "IBM,7038-6M2") ||
+			   !strcmp(model, "IBM,7028-6E4") ||
+			   !strcmp(model, "IBM,7028-6C4") ||
+			   !strcmp(model, "IBM,7029-6E3") ||
+			   !strcmp(model, "IBM,7029-6C3"))
+				power4_sysrq_via_ctrl_o = 1;
+		}
+		of_node_put(root);
+	}
+}
+#endif
+
 static int __init set_preferred_console(void)
 {
 	struct device_node *prom_stdout = NULL;
@@ -359,6 +401,9 @@ static int __init set_preferred_console(
 					/* We dont recognise the serial port */
 					goto not_found;
 			}
+#ifdef CONFIG_PPC_PSERIES
+			detect_power4_console();
+#endif /* CONFIG_PPC_PSERIES */
 		}
 	}
 #endif /* CONFIG_SERIAL_8250_CONSOLE */
Index: linux-2.6.15-rc6-olh/drivers/serial/8250.c
===================================================================
--- linux-2.6.15-rc6-olh.orig/drivers/serial/8250.c
+++ linux-2.6.15-rc6-olh/drivers/serial/8250.c
@@ -85,6 +85,8 @@ static unsigned int share_irqs = SERIAL8
 #define CONFIG_SERIAL_MANY_PORTS 1
 #endif
 
+#define arch_8250_sysrq_via_ctrl_o(x) (0)
+
 /*
  * HUB6 is always on.  This will be removed once the header
  * files have been cleaned.
@@ -1154,6 +1156,8 @@ receive_chars(struct uart_8250_port *up,
 			 */
 		}
 		ch = serial_inp(up, UART_RX);
+		if (arch_8250_sysrq_via_ctrl_o(ch, &up->port))
+			goto ignore_char;
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
Index: linux-2.6.15-rc6-olh/include/asm-powerpc/serial.h
===================================================================
--- linux-2.6.15-rc6-olh.orig/include/asm-powerpc/serial.h
+++ linux-2.6.15-rc6-olh/include/asm-powerpc/serial.h
@@ -15,4 +15,10 @@
 /* Default baud base if not found in device-tree */
 #define BASE_BAUD ( 1843200 / 16 )
 
+#if defined(SUPPORT_SYSRQ) && defined(CONFIG_PPC_PSERIES)
+#undef arch_8250_sysrq_via_ctrl_o
+extern int power4_sysrq_via_ctrl_o;
+#define arch_8250_sysrq_via_ctrl_o(ch, port) ((ch) == '\x0f' && power4_sysrq_via_ctrl_o && uart_handle_break((port)))
+#endif
+
 #endif /* _PPC64_SERIAL_H */

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
