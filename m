Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUBFXDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbUBFXDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:03:37 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:17100 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S265783AbUBFXCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:02:55 -0500
Date: Fri, 6 Feb 2004 16:02:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       Andi Kleen <ak@suse.de>, jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040206230254.GE5219@smtp.west.cox.net>
References: <20040127184029.GI32525@stop.crashing.org> <20040128165104.GC1200@elf.ucw.cz> <20040128170520.GI6577@stop.crashing.org> <20040128174402.GI340@elf.ucw.cz> <20040128175646.GJ6577@stop.crashing.org> <20040206223517.GD5219@smtp.west.cox.net> <20040206225535.GB539@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206225535.GB539@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 11:55:35PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > It's against 2.6 + -netpoll + Amit's patch.
> > > 
> > > But doesn't -mm have a kgdb over enet driver that does work?  It's just
> > > not been ported to Amit's bits, right?
> > 
> > OK.  Based on this, and some other fixes, I've pushed my first cut of
> > KGDB over ethernet.  It's not quite as robust as I'd like right now (I'm
> > still getting it just-right for connecting live), and I've got some not
> > quite finished improvements still locally, but it does work.
> 
> Is there way to get plain diff (against -mm or against Amit or
> something?)

I'll post a diff against -mm next week when I'm a bit happier with it,
but the following is against Amit's version + your patch to port it to
netpoll:
--- a/arch/ppc/kernel/ppc-stub.c	Fri Feb  6 16:01:20 2004
+++ b/arch/ppc/kernel/ppc-stub.c	Fri Feb  6 16:01:20 2004
@@ -252,9 +252,6 @@
 	return -1;
 }
 
-/* We can either use this driver, which relies on other hooks, or
- * provide on some boards make use of kgdb_8250 */
-#ifndef CONFIG_KGDB_8250
 static void
 kgdbppc_write_char(int chr)
 {
@@ -275,12 +272,11 @@
 	return 0;
 }
 
-struct kgdb_serial kgdb_serial_driver = {
+struct kgdb_serial kgdbppc_serial = {
 	.read_char = kgdbppc_read_char,
 	.write_char = kgdbppc_write_char,
 	.hook = kgdbppc_hook
 };
-#endif
 
 int
 kgdb_arch_init(void)
@@ -291,7 +287,18 @@
 	debugger_iabr_match = kgdb_iabr_match;
 	debugger_dabr_match = kgdb_dabr_match;
 
+        /* If we have the bigger 8250 serial driver, set that to be
+	 * the output now. */
+#ifdef CONFIG_KGDB_8250
+        extern struct kgdb_serial kgdb8250_serial_driver;
+        kgdb_serial = &kgdb8250_serial_driver;
+#else
+	/* Take our serial driver. */
+	kgdb_serial = &kgdbppc_serial;
+#endif
+
 	return 0;
+
 }
 
 /*
--- a/drivers/net/Makefile	Fri Feb  6 16:01:20 2004
+++ b/drivers/net/Makefile	Fri Feb  6 16:01:20 2004
@@ -31,8 +31,6 @@
 
 obj-$(CONFIG_OAKNET) += oaknet.o 8390.o
 
-obj-$(CONFIG_KGDB_ETH) += kgdb_eth.o
-
 obj-$(CONFIG_DGRS) += dgrs.o
 obj-$(CONFIG_RCPCI) += rcpci.o
 obj-$(CONFIG_VORTEX) += 3c59x.o
@@ -190,4 +188,6 @@
 obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
 
+# Netpoll users must be last.
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+obj-$(CONFIG_KGDB_ETH) += kgdb_eth.o
--- a/drivers/net/kgdb_eth.c	Fri Feb  6 16:01:20 2004
+++ b/drivers/net/kgdb_eth.c	Fri Feb  6 16:01:20 2004
@@ -53,7 +53,7 @@
 #include <asm/atomic.h>
 
 #define IN_BUF_SIZE 512 /* power of 2, please */
-#define OUT_BUF_SIZE 256
+#define OUT_BUF_SIZE 30	/* We don't want to send too big of a packet. */
 
 static char in_buf[IN_BUF_SIZE], out_buf[OUT_BUF_SIZE];
 static int in_head, in_tail, out_count;
@@ -109,13 +109,11 @@
 
 	/* Is this gdb trying to attach? */
 	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
-		printk(KERN_CRIT "Someone is trying to attach\n");
-//		kgdb_schedule_breakpoint();
+		breakpoint();
 
 	for (i = 0; i < len; i++) {
-		if (msg[i] == 3)	/* Check for ^C? */
-			printk(KERN_CRIT "Someone is trying to ^C?\n");
-//			kgdb_schedule_breakpoint();
+		if (msg[i] == 3)
+			breakpoint();
 
 		if (atomic_read(&in_count) >= IN_BUF_SIZE) {
 			/* buffer overflow, clear it */
@@ -136,6 +134,21 @@
 
 __setup("kgdboe=", option_setup);
 
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
 static int init_kgdboe(void)
 {
 #ifdef CONFIG_SMP
@@ -144,29 +157,15 @@
 		return -1;
 	}
 #endif
-//	set_debug_traps();
 
 	if(!np.remote_ip || netpoll_setup(&np))
 		return 1;
 
+	kgdb_serial = &kgdbeth_serial;
 	kgdboe = 1;
 	printk(KERN_INFO "kgdb: debugging over ethernet enabled\n");
 
 	return 0;
 }
 
-static int hook(void) { printk("Hook called\n"); return 0; }
-static int begin(void) { printk("Begin called\n"); return 0; }
-static int end(void) { printk("End called\n"); return 0; }
-
 module_init(init_kgdboe);
-
-struct kgdb_serial kgdbeth_serial = {
-	.chunksize = 1,
-	.read_char = eth_getDebugChar,
-	.write_char = eth_putDebugChar,
-	.hook = hook,
-	.flush = eth_flushDebugChar,
-	.begin_session = begin,
-	.end_session = end,
-};
--- a/drivers/serial/kgdb_8250.c	Fri Feb  6 16:01:20 2004
+++ b/drivers/serial/kgdb_8250.c	Fri Feb  6 16:01:20 2004
@@ -489,7 +489,7 @@
 	serial_from_rs_table = 1;
 }
 
-struct kgdb_serial kgdb_serial_driver = {
+struct kgdb_serial kgdb8250_serial_driver = {
 	.read_char = kgdb8250_read_char,
 	.write_char = kgdb8250_write_char,
 	.hook = kgdb8250_hook
--- a/include/linux/kgdb.h	Fri Feb  6 16:01:20 2004
+++ b/include/linux/kgdb.h	Fri Feb  6 16:01:20 2004
@@ -93,16 +93,13 @@
 typedef unsigned char threadref[8];
 
 struct kgdb_serial {
-	int chunksize;
 	int (*read_char)(void);
 	void (*write_char)(int);
 	void (*flush)(void);
 	int (*hook)(void);
-	void (*begin_session)(void);
-	void (*end_session)(void);
 };
 
-extern struct kgdb_serial kgdb_serial_driver;
+extern struct kgdb_serial *kgdb_serial;
 extern struct kgdb_arch arch_kgdb_ops;
 extern int kgdb_initialized;
 
--- a/kernel/kgdbstub.c	Fri Feb  6 16:01:20 2004
+++ b/kernel/kgdbstub.c	Fri Feb  6 16:01:20 2004
@@ -59,9 +59,22 @@
  * The following are the stub functions for code which is arch specific
  * and can be omitted on some arches
  */
+
+/*
+ * This function will handle the initalization of any architecture specific
+ * hooks.  If there is a suitable early output driver, kgdb_serial
+ * can be pointed at it now.
+ */
 int __attribute__ ((weak))
 kgdb_arch_init(void)
 {
+	/* If we have the default serial driver, set that to be the
+	 * output now. */
+#ifdef CONFIG_KGDB_8250
+	extern struct kgdb_serial kgdb8250_serial_driver;
+	kgdb_serial = &kgdb8250_serial_driver;
+#endif
+
 	return 0;
 }
 
@@ -145,7 +158,7 @@
 gdb_breakpoint_t kgdb_break[MAX_BREAKPOINTS];
 extern int pid_max;
 
-struct kgdb_serial *kgdb_serial = &kgdb_serial_driver;
+struct kgdb_serial *kgdb_serial;
 
 int kgdb_initialized = 0;
 int kgdb_enter = 0;
@@ -279,12 +292,6 @@
 		send_count = 0;
 
 		while ((ch = buffer[count])) {
-			if (kgdb_serial->chunksize &&
-			    send_count >= kgdb_serial->chunksize) {
-				if (kgdb_serial->flush)
-					kgdb_serial->flush();
-				send_count = 0;
-			}
 			kgdb_serial->write_char(ch);
 			checksum += ch;
 			count ++;
@@ -666,10 +673,6 @@
 		return 0;
 	}
 
-	/* Grab interface locks first */
-	if (kgdb_serial->begin_session)
-		kgdb_serial->begin_session();
-
 	/* 
 	 * Interrupts will be restored by the 'trap return' code, except when
 	 * single stepping.
@@ -1089,10 +1092,6 @@
 	atomic_set(&debugger_active, 0);
 	local_irq_restore(flags);
 
-	/* Release interface locks */
-	if (kgdb_serial->end_session)
-		kgdb_serial->end_session();
-	
 	return ret;
 }
 
@@ -1151,13 +1150,16 @@
 
 void breakpoint(void)
 {
-	if (kgdb_initialized) {
-		atomic_set(&kgdb_setting_breakpoint, 1);
-		wmb();
-		BREAKPOINT();
-		wmb();
-		atomic_set(&kgdb_setting_breakpoint, 0);
+	if (!kgdb_initialized) {
+		printk("calling set_debug_traps\n");
+		set_debug_traps();
 	}
+
+	atomic_set(&kgdb_setting_breakpoint, 1);
+	wmb();
+	BREAKPOINT();
+	wmb();
+	atomic_set(&kgdb_setting_breakpoint, 0);
 }
 
 void kgdb_nmihook(int cpu, void *regs)
@@ -1179,7 +1181,8 @@
 		return;
 	}
 
-	/* Let the arch do any initalization it needs to */
+	/* Let the arch do any initalization it needs to, including
+	 * pointing to a suitable early output device. */
 	kgdb_arch_init();
 
 	if (!kgdb_serial) {
@@ -1199,11 +1202,11 @@
 
 	/*
 	 * Call the breakpoint() routine in GDB to start the debugging
-	 * session.
+	 * session
 	 */
 	printk(KERN_CRIT "Waiting for connection from remote gdb... ");
 	breakpoint() ;
-	printk(KERN_CRIT "Connected.\n");
+	printk("Connected.\n");
 }
 
 #ifdef CONFIG_KGDB_CONSOLE

-- 
Tom Rini
http://gate.crashing.org/~trini/
