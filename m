Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269036AbUHYAcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269036AbUHYAcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269115AbUHYAcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:32:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44173 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269036AbUHYAci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:32:38 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix sysrq support in sn_console.c
Date: Tue, 24 Aug 2004 17:32:04 -0700
User-Agent: KMail/1.6.2
Cc: Pat Gefre <pfg@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_E49KBy0xeWjX5UV"
Message-Id: <200408241732.04770.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_E49KBy0xeWjX5UV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In porting the sn_console driver to the serial core, we lost sysrq support.  
This patch fixes it and removes a few unncessary #ifdefs.  Can you please 
send it on to Linus asap?  sysrq is a *really* nice thing to have.

Pat, please shoot Andrew a mail if you have a problem with this, I'm sending 
it out now because I'm going to be gone for a few days and didn't want to 
wait.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_E49KBy0xeWjX5UV
Content-Type: text/plain;
  charset="us-ascii";
  name="sn-console-sysrq-fix-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sn-console-sysrq-fix-2.patch"

===== drivers/serial/Kconfig 1.42 vs edited =====
--- 1.42/drivers/serial/Kconfig	2004-08-23 01:15:21 -07:00
+++ edited/drivers/serial/Kconfig	2004-08-24 15:50:05 -07:00
@@ -682,6 +682,7 @@
 	bool "SGI Altix L1 serial console support"
 	depends on IA64_GENERIC || IA64_SGI_SN2
 	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
 	help
 		If you have an SGI Altix and you would like to use the system
 		controller serial port as your console (you want this!),
===== drivers/serial/sn_console.c 1.4 vs edited =====
--- 1.4/drivers/serial/sn_console.c	2004-08-24 02:08:49 -07:00
+++ edited/drivers/serial/sn_console.c	2004-08-24 16:01:50 -07:00
@@ -81,6 +81,12 @@
 #define DEVICE_MAJOR 204
 #define DEVICE_MINOR 40
 
+#ifdef CONFIG_MAGIC_SYSRQ
+static char sysrq_serial_str[] = "\eSYS";
+static char *sysrq_serial_ptr = sysrq_serial_str;
+static unsigned long sysrq_requested;
+#endif /* CONFIG_MAGIC_SYSRQ */
+
 /*
  * Port definition - this kinda drives it all
  */
@@ -533,13 +539,15 @@
  * sn_receive_chars - Grab characters, pass them to tty layer
  * @port: Port to operate on
  * @regs: Saved registers (needed by uart_handle_sysrq_char)
+ * @flags: irq flags
  *
  * Note: If we're not registered with the serial core infrastructure yet,
  * we don't try to send characters to it...
  *
  */
 static void
-sn_receive_chars(struct sn_cons_port *port, struct pt_regs *regs)
+sn_receive_chars(struct sn_cons_port *port, struct pt_regs *regs,
+		 unsigned long flags)
 {
 	int ch;
 	struct tty_struct *tty;
@@ -570,10 +578,29 @@
 			       "obtaining data from the console (0x%0x)\n", ch);
 			break;
 		}
-#if defined(CONFIG_SERIAL_SGI_L1_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-		if (uart_handle_sysrq_char(&port->sc_port, ch, regs))
-			continue;
-#endif				/* CONFIG_SERIAL_SGI_L1_CONSOLE && CONFIG_MAGIC_SYSRQ */
+#ifdef CONFIG_MAGIC_SYSRQ
+                if (sysrq_requested) {
+                        unsigned long sysrq_timeout = sysrq_requested + HZ*5;
+
+                        sysrq_requested = 0;
+                        if (ch && time_before(jiffies, sysrq_timeout)) {
+                                spin_unlock_irqrestore(&port->sc_port.lock, flags);
+                                handle_sysrq(ch, regs, NULL);
+                                spin_lock_irqsave(&port->sc_port.lock, flags);
+                                /* ignore actual sysrq command char */
+                                continue;
+                        }
+                }
+                if (ch == *sysrq_serial_ptr) {
+                        if (!(*++sysrq_serial_ptr)) {
+                                sysrq_requested = jiffies;
+                                sysrq_serial_ptr = sysrq_serial_str;
+                        }
+			continue; /* ignore the whole sysrq string */
+                }
+                else
+                        sysrq_serial_ptr = sysrq_serial_str;
+#endif /* CONFIG_MAGIC_SYSRQ */
 
 		/* record the character to pass up to the tty layer */
 		if (tty) {
@@ -696,7 +723,7 @@
 
 	spin_lock_irqsave(&port->sc_port.lock, flags);
 	if (status & SAL_CONSOLE_INTR_RECV) {
-		sn_receive_chars(port, regs);
+		sn_receive_chars(port, regs, flags);
 	}
 	if (status & SAL_CONSOLE_INTR_XMIT) {
 		sn_transmit_chars(port, TRANSMIT_BUFFERED);
@@ -745,7 +772,7 @@
 
 	if (!port->sc_port.irq) {
 		spin_lock_irqsave(&port->sc_port.lock, flags);
-		sn_receive_chars(port, NULL);
+		sn_receive_chars(port, NULL, flags);
 		sn_transmit_chars(port, TRANSMIT_RAW);
 		spin_unlock_irqrestore(&port->sc_port.lock, flags);
 		mod_timer(&port->sc_timer,
@@ -853,7 +880,6 @@
  * Kernel console definitions
  */
 
-#ifdef CONFIG_SERIAL_SGI_L1_CONSOLE
 static void sn_sal_console_write(struct console *, const char *, unsigned);
 static int __init sn_sal_console_setup(struct console *, char *);
 extern struct uart_driver sal_console_uart;
@@ -869,9 +895,6 @@
 };
 
 #define SAL_CONSOLE	&sal_console
-#else
-#define SAL_CONSOLE	0
-#endif				/* CONFIG_SERIAL_SGI_L1_CONSOLE */
 
 static struct uart_driver sal_console_uart = {
 	.owner = THIS_MODULE,
@@ -971,8 +994,6 @@
 module_init(sn_sal_module_init);
 module_exit(sn_sal_module_exit);
 
-#ifdef CONFIG_SERIAL_SGI_L1_CONSOLE
-
 /**
  * puts_raw_fixed - sn_sal_console_write helper for adding \r's as required
  * @puts_raw : puts function to do the writing
@@ -1194,5 +1215,3 @@
 }
 
 console_initcall(sn_sal_serial_console_init);
-
-#endif				/* CONFIG_SERIAL_SGI_L1_CONSOLE */

--Boundary-00=_E49KBy0xeWjX5UV--
