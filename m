Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280502AbRKELxe>; Mon, 5 Nov 2001 06:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280503AbRKELxZ>; Mon, 5 Nov 2001 06:53:25 -0500
Received: from thor.bi.teuto.net ([212.8.197.25]:33288 "HELO thor.bi.teuto.net")
	by vger.kernel.org with SMTP id <S280502AbRKELxM>;
	Mon, 5 Nov 2001 06:53:12 -0500
Date: Mon, 5 Nov 2001 12:52:31 +0100
From: Jan-Benedict Glaw <jbglaw@microdata-pos.de>
To: linux-kernel@vger.kernel.org
Subject: Limited RAM - how to save it?
Message-ID: <20011105125231.A3783@microdata-pos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm working on a 4MB linux system (for a customer) which has quite
limited resources at all:

	- 4MB RAM
	- 386 or 486 like processor (9..16 BogoMIPS)
	- < 100MB HDD
	- Quite a lot user space running:-(

For me, 4MB seems to be a problem. I've stripped diwn the applications
quite a lot, but 4MB behaves very slow and unresponsible. Adding only
one more MB solves any performance problem! I've made a small patch
practically removing printk() from kernel which helps a lot (patch
attached below). Basically, the running kernel is ~160KB smaller!
Are there further methods of saving space? I've already done some
other things, but these don't help that much:

	- A maximum of 64 concurrent processes
	- Only 32 PTYs

If you've got further ideas on getting the kernel a bit smaller,
would be nice to get a mail dropped...

MfG, JBG


diff -Nur linux-2.2.19/Documentation/Configure.help linux-CUSTOM-2.2.19/Documentation/Configure.help
--- linux-2.2.19/Documentation/Configure.help	Sun Mar 25 18:37:29 2001
+++ linux-CUSTOM-2.2.19/Documentation/Configure.help	Mon Nov  5 11:30:47 2001
@@ -4942,6 +4942,14 @@
   important data. This is primarily of use to people trying to debug
   the middle and upper layers of the SCSI subsystem. If unsure, say N.
 
+Smaller kernel by omitting most messages
+CONFIG_NO_PRINTK
+  Enabling this option will result in a smaller kernel by removing
+  most text strings. This is only useful for emdedded systems where
+  you've got to live with <= 4MB of RAM. I386-only for now...
+
+  If unsure, say no.
+
 Fibre Channel support
 CONFIG_FC4
   This is an experimental support for storage arrays connected to
diff -Nur linux-2.2.19/arch/i386/config.in linux-CUSTOM-2.2.19/arch/i386/config.in
--- linux-2.2.19/arch/i386/config.in	Sun Mar 25 18:37:29 2001
+++ linux-CUSTOM-2.2.19/arch/i386/config.in	Mon Nov  5 11:01:28 2001
@@ -210,5 +221,6 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Eleminate *most* printk()s' CONFIG_NO_PRINTK
 endmenu
 
diff -Nur linux-2.2.19/arch/i386/kernel/head.S linux-CUSTOM-2.2.19/arch/i386/kernel/head.S
--- linux-2.2.19/arch/i386/kernel/head.S	Sun Mar 25 18:31:45 2001
+++ linux-CUSTOM-2.2.19/arch/i386/kernel/head.S	Fri Nov  2 11:21:42 2001
@@ -315,7 +315,7 @@
 	movl %ax,%ds
 	movl %ax,%es
 	pushl $int_msg
-	call SYMBOL_NAME(printk)
+	call SYMBOL_NAME(real_printk)
 	popl %eax
 	popl %ds
 	popl %es
diff -Nur linux-2.2.19/arch/i386/kernel/traps.c linux-CUSTOM-2.2.19/arch/i386/kernel/traps.c
--- linux-2.2.19/arch/i386/kernel/traps.c	Sun Mar 25 18:37:30 2001
+++ linux-CUSTOM-2.2.19/arch/i386/kernel/traps.c	Fri Nov  2 11:53:32 2001
@@ -135,16 +135,16 @@
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
 	}
-	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]\nEFLAGS: %08lx\n",
+	oops_printk("CPU:    %d\nEIP:    %04x:[<%08lx>]\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, regs->eflags);
-	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
+	oops_printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
-	printk("esi: %08lx   edi: %08lx   ebp: %08lx   esp: %08lx\n",
+	oops_printk("esi: %08lx   edi: %08lx   ebp: %08lx   esp: %08lx\n",
 		regs->esi, regs->edi, regs->ebp, esp);
-	printk("ds: %04x   es: %04x   ss: %04x\n",
+	oops_printk("ds: %04x   es: %04x   ss: %04x\n",
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	store_TR(i);
-	printk("Process %s (pid: %d, process nr: %d, stackpage=%08lx)",
+	oops_printk("Process %s (pid: %d, process nr: %d, stackpage=%08lx)",
 		current->comm, current->pid, 0xffff & i, 4096+(unsigned long)current);
 
 	/*
@@ -152,18 +152,18 @@
 	 * time of the fault..
 	 */
 	if (in_kernel) {
-		printk("\nStack: ");
+		oops_printk("\nStack: ");
 		stack = (unsigned long *) esp;
 		for(i=0; i < kstack_depth_to_print; i++) {
 			if (((long) stack & 8191) == 0)
 				break;
 			if (i && ((i % 8) == 0))
-				printk("\n       ");
-			printk("%08lx ", *stack++);
+				oops_printk("\n       ");
+			oops_printk("%08lx ", *stack++);
 		}
-		printk("\nCall Trace: ");
+		oops_printk("\nCall Trace: ");
 		if (!esp || (esp & 3))
-			printk("Bad ESP value.");
+			oops_printk("Bad ESP value.");
 		else {
 			stack = (unsigned long *) esp;
 			i = 1;
@@ -184,21 +184,21 @@
 				     (addr <= (unsigned long) &_etext)) ||
 				    ((addr >= module_start) && (addr <= module_end))) {
 					if (i && ((i % 8) == 0))
-						printk("\n       ");
-					printk("[<%08lx>] ", addr);
+						oops_printk("\n       ");
+					oops_printk("[<%08lx>] ", addr);
 					i++;
 				}
 			}
 		}
-		printk("\nCode: ");
+		oops_printk("\nCode: ");
 		if (!regs->eip || regs->eip==-1)
-			printk("Bad EIP value.");
+			oops_printk("Bad EIP value.");
 		else {
 			for(i=0;i<20;i++)
-			printk("%02x ", ((unsigned char *)regs->eip)[i]);
+			oops_printk("%02x ", ((unsigned char *)regs->eip)[i]);
 		}
 	}
-	printk("\n");
+	oops_printk("\n");
 }	
 
 spinlock_t die_lock;
@@ -207,7 +207,7 @@
 {
 	console_verbose();
 	spin_lock_irq(&die_lock);
-	printk("%s: %04lx\n", str, err & 0xffff);
+	oops_printk("%s: %04lx\n", str, err & 0xffff);
 	show_registers(regs);
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
diff -Nur linux-2.2.19/include/linux/kernel.h linux-CUSTOM-2.2.19/include/linux/kernel.h
--- linux-2.2.19/include/linux/kernel.h	Sun Mar 25 18:31:03 2001
+++ linux-CUSTOM-2.2.19/include/linux/kernel.h	Mon Nov  5 12:19:04 2001
@@ -9,6 +9,7 @@
 
 #include <stdarg.h>
 #include <linux/linkage.h>
+#include <linux/config.h>
 
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
@@ -54,8 +55,16 @@
 
 extern int session_of_pgrp(int pgrp);
 
-asmlinkage int printk(const char * fmt, ...)
+asmlinkage int real_printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+
+#ifdef CONFIG_NO_PRINTK
+#	define printk(format, arg...) do {} while(0)
+#else
+#	define printk(format, arg...) real_printk(format, ## arg)
+#endif /* CONFIG_NO_PRINTK */
+
+#define oops_printk(format, arg...) real_printk(format, ## arg)
 
 #if DEBUG
 #define pr_debug(fmt,arg...) \
diff -Nur linux-2.2.19/kernel/ksyms.c linux-CUSTOM-2.2.19/kernel/ksyms.c
--- linux-2.2.19/kernel/ksyms.c	Sun Mar 25 18:31:02 2001
+++ linux-CUSTOM-2.2.19/kernel/ksyms.c	Fri Nov  2 11:07:04 2001
@@ -357,7 +357,7 @@
 
 /* misc */
 EXPORT_SYMBOL(panic);
-EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(real_printk);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(vsprintf);
 EXPORT_SYMBOL(kdevname);
diff -Nur linux-2.2.19/kernel/printk.c linux-CUSTOM-2.2.19/kernel/printk.c
--- linux-2.2.19/kernel/printk.c	Sun Mar 25 18:31:02 2001
+++ linux-CUSTOM-2.2.19/kernel/printk.c	Fri Nov  2 11:01:21 2001
@@ -249,7 +249,7 @@
 	return do_syslog(type, buf, len);
 }
 
-asmlinkage int printk(const char *fmt, ...)
+asmlinkage int real_printk(const char *fmt, ...)
 {
 	va_list args;
 	int i;
