Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTFIUfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTFIUfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:35:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:9351 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261936AbTFIUes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:34:48 -0400
Subject: [RFC] early printk for x86
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, dwmw2@infradead.org,
       akpm@zip.com.au
Content-Type: multipart/mixed; boundary="=-g8gUmDlbRz7V0RG5Hq3j"
Organization: 
Message-Id: <1055191572.25708.18.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Jun 2003 13:46:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g8gUmDlbRz7V0RG5Hq3j
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Most architectures have some way of doing printk()'s before
console_init().  x86 doesn't.  x86_64 has a self-contained serial and
vga driver that do the trick.  This could easily be a multiple
architecture thing, but I didn't want to clutter up generic code with
things that no one else is ever going to use.  

The ugly part here is the de-static'ing of the console init functions,
and trying to keep the serial init function from running twice.  The
other part that I don't like is getting the console= part at config
time.  But, getting arguments parsed this early requires some invasive
surgery in early boot.

Although it _is_ ugly, it's also pretty small.  Martin Bligh has
promised to add vga support too.
-- 
Dave Hansen
haveblue@us.ibm.com

--=-g8gUmDlbRz7V0RG5Hq3j
Content-Disposition: attachment; filename=config_early_printk-2.5.70-0.patch
Content-Type: text/x-patch; name=config_early_printk-2.5.70-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -pru linux-2.5.70-clean/arch/i386/Kconfig linux-2.5.70-early_printk/arch/i386/Kconfig
--- linux-2.5.70-clean/arch/i386/Kconfig	Mon May 26 18:00:24 2003
+++ linux-2.5.70-early_printk/arch/i386/Kconfig	Mon Jun  9 12:28:28 2003
@@ -1535,6 +1535,37 @@ config FRAME_POINTER
 	  and slower, but it will give very useful debugging information.
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
+choice
+	prompt "Early printk support"
+	default DEBUG_EARLY_PRINTK_OFF
+	depends on DEBUG_KERNEL
+
+config DEBUG_EARLY_PRINTK_OFF
+	bool "off"
+
+config DEBUG_EP_SERIAL
+	bool "serial"
+	depends on SERIAL_8250_CONSOLE && SERIAL_CORE_CONSOLE
+
+config DEBUG_EP_VGA
+	bool "vga"
+
+endchoice
+
+config DEBUG_EARLY_PRINTK
+	bool
+	depends on !DEBUG_EARLY_PRINTK_OFF
+	default y
+
+config DEBUG_SERIAL_OPTIONS
+	string "serial port options"
+	default "ttyS0,57600"
+	depends on DEBUG_EP_SERIAL
+	help
+	  This should be the same thing that you would put on the kernel
+	  command line for the serial console, minus the 'console=' part.
+	  This will override whatever you put on the command line, so 
+	  be sure to get it right.
 
 config X86_EXTRA_IRQS
 	bool
diff -pru linux-2.5.70-clean/arch/i386/kernel/setup.c linux-2.5.70-early_printk/arch/i386/kernel/setup.c
--- linux-2.5.70-clean/arch/i386/kernel/setup.c	Mon May 26 18:00:39 2003
+++ linux-2.5.70-early_printk/arch/i386/kernel/setup.c	Mon Jun  9 12:31:52 2003
@@ -903,6 +903,29 @@ static int __init noreplacement_setup(ch
 
 __setup("noreplacement", noreplacement_setup); 
 
+#ifdef CONFIG_DEBUG_EARLY_PRINTK
+extern int __init console_setup(char *);
+extern int __init serial8250_console_init(void);
+void setup_early_printk(void)
+{
+	/* 
+	 * printk currently checks cpu_online_map to make sure that
+	 * we don't try to printk from a CPU which hasn't had resources
+	 * allocated for it yet.  Make sure that whatever consoles you
+	 * enable here don't require per-cpu resources.
+	 */
+	set_bit(smp_processor_id(), &cpu_online_map);
+#ifdef CONFIG_DEBUG_EP_SERIAL
+	console_setup(CONFIG_DEBUG_SERIAL_OPTIONS);
+	serial8250_console_init();
+	printk("early serial console support registered\n");
+#endif
+#ifdef DEBUG_EARLY_PRINTK_VGA
+	// blah blah
+#endif
+}
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long max_low_pfn;
diff -pru linux-2.5.70-clean/drivers/serial/8250.c linux-2.5.70-early_printk/drivers/serial/8250.c
--- linux-2.5.70-clean/drivers/serial/8250.c	Mon May 26 18:00:21 2003
+++ linux-2.5.70-early_printk/drivers/serial/8250.c	Mon Jun  9 12:13:53 2003
@@ -1983,10 +1983,15 @@ static struct console serial8250_console
 	.data		= &serial8250_reg,
 };
 
-static int __init serial8250_console_init(void)
+int __init serial8250_console_init(void)
 {
+	static int initialized = 0;
+	if (initialized)
+		return 0;
+
 	serial8250_isa_init_ports();
 	register_console(&serial8250_console);
+	initialized = 1;
 	return 0;
 }
 console_initcall(serial8250_console_init);
diff -pru linux-2.5.70-clean/include/linux/kernel.h linux-2.5.70-early_printk/include/linux/kernel.h
--- linux-2.5.70-clean/include/linux/kernel.h	Mon May 26 18:00:20 2003
+++ linux-2.5.70-early_printk/include/linux/kernel.h	Mon Jun  9 12:11:34 2003
@@ -47,6 +47,12 @@ extern int console_printk[];
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
+#ifdef CONFIG_DEBUG_EARLY_PRINTK
+extern void setup_early_printk(void);
+#else
+#define setup_early_printk() do {} while (0)
+#endif
+
 struct completion;
 
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
diff -pru linux-2.5.70-clean/init/main.c linux-2.5.70-early_printk/init/main.c
--- linux-2.5.70-clean/init/main.c	Mon May 26 18:00:25 2003
+++ linux-2.5.70-early_printk/init/main.c	Mon Jun  9 12:26:19 2003
@@ -386,6 +386,7 @@ asmlinkage void __init start_kernel(void
  * enable them
  */
 	lock_kernel();
+	setup_early_printk();
 	printk(linux_banner);
 	setup_arch(&command_line);
 	setup_per_cpu_areas();
diff -pru linux-2.5.70-clean/kernel/printk.c linux-2.5.70-early_printk/kernel/printk.c
--- linux-2.5.70-clean/kernel/printk.c	Mon May 26 18:01:01 2003
+++ linux-2.5.70-early_printk/kernel/printk.c	Mon Jun  9 12:12:56 2003
@@ -89,7 +89,7 @@ static int console_may_schedule;
 /*
  *	Setup a list of consoles. Called from init/main.c
  */
-static int __init console_setup(char *str)
+int __init console_setup(char *str)
 {
 	struct console_cmdline *c;
 	char name[sizeof(c->name)];

--=-g8gUmDlbRz7V0RG5Hq3j--

