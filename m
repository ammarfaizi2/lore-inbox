Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSGZWdw>; Fri, 26 Jul 2002 18:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318591AbSGZWdw>; Fri, 26 Jul 2002 18:33:52 -0400
Received: from [195.223.140.120] ([195.223.140.120]:25186 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318602AbSGZWds>; Fri, 26 Jul 2002 18:33:48 -0400
Date: Sat, 27 Jul 2002 00:37:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, Lars Marowsky-Bree <lmb@suse.de>
Subject: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()]
Message-ID: <20020726223750.GA1151@dualathlon.random>
References: <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random> <20020725150525.Q2276@host110.fsmlabs.com> <20020725220643.GT1180@dualathlon.random> <20020725160559.X2276@host110.fsmlabs.com> <20020725225613.GW1180@dualathlon.random> <20020725170113.F5326@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725170113.F5326@host110.fsmlabs.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I implemented what I need to track down oopses with modules. ksymoops
should learn about it too. This will also allow us to recognize
immediatly the kernel image used.

here an example of oops in a module with the patch applied (only 1
module is affected so only 1 module is listed). I checked that
0xca40306e-0xca403060 gives the exact offset to lookup in the objdump -d
of the module object.

this patch will solve all the issues in being able to track down module
oopses and kernel image without introducing any waste of ram (nitpick:
except 40 bytes of ram). For user compiled kernels, if the user isn't
capable of saving System.map and vmlinux kksymoops remains a viable
alternative, but I don't feel it needed for pre-compiled kernel images
provided a compile-time database exists (also considering kksymoops
doesn't obviate the need of the vmlinux, really one can dump the asm off
the bzImage or even more simply from /dev/ram but saving vmlinux is
simpler than to ask the user to do that).

last thing: this will work well till 320 modules simultaneously loaded
on 32bit archs, or 640 for 64bit archs. More modules won't hurt but they
may not showup in the trace, elarging the limit is trivial, it will only
waste some more byte. I also considered another implementation that
basically used an array of "module idx" rather than the bitmap of all
the modules. That had the advantage of requiring ram only in function of
the modules present in the trace, but I didn't like to make too much
assumption on the number of modules in the trace, and with 1 module in
the trace I can track 32 real modules with the below implementation. So
there was not an huge saving, possibly using char instead of ints would
been viable but the below looks simpler too.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
ca40306e
*pde = 00000000
Oops: 0002
Linux version 2.4.19-rc3aa2 (andrea@dualathlon) (gcc version 3.1.1 20020618 (prerelease)) #17 SMP Fri Jul 26 23:25:11 CEST 2002
CPU:    1
EIP:    0010:[<ca40306e>]    Tainted: P
EFLAGS: 00010246
eax: ca403060   ebx: ffffffea   ecx: c0493d10   edx: c11ec080
esi: 00000000   edi: 00000000   ebp: ca403000   esp: ca433f10
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 1134, stackpage=ca433000)
Stack: 00000000 00000000 ffffffea c0120817 ca403060 08086ab0 000000e0 00000000
       08086b15 000000c5 00000060 00000060 00000004 c4359440 ca402000 ca438000
       00000060 c0492600 ca403060 00000140 00000000 00000000 00000000 00000000
Call Trace:    [<c0120817>] [<ca403060>] [<ca403060>] [<c01090e7>]
Module Oops Tracking:
        [(oops:<ca403060>:<ca403140>)]
Code: c7 05 00 00 00 00 00 00 00 00 83 0d 14 30 40 ca 08 e8 4c 7e

And here it is the patch:

diff -urNp ref/arch/i386/kernel/traps.c oops-x/arch/i386/kernel/traps.c
--- ref/arch/i386/kernel/traps.c	Fri Jul 26 23:01:38 2002
+++ oops-x/arch/i386/kernel/traps.c	Fri Jul 26 23:06:35 2002
@@ -103,16 +103,18 @@ static inline int kernel_text_address(un
 {
 	int retval = 0;
 	struct module *mod;
+	int nr;
 
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+	for (nr = 0, mod = module_list; mod != &kernel_module; nr++, mod = mod->next) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
 		if (mod_bound(addr, 0, mod)) {
+			module_oops_tracking_mark(nr);
 			retval = 1;
 			break;
 		}
@@ -201,6 +203,8 @@ void show_registers(struct pt_regs *regs
 	unsigned long esp;
 	unsigned short ss;
 
+	printk(linux_banner);
+
 	esp = (unsigned long) (&regs->esp);
 	ss = __KERNEL_DS;
 	if (regs->xcs & 3) {
@@ -208,6 +212,8 @@ void show_registers(struct pt_regs *regs
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
 	}
+	module_oops_tracking_init();
+	kernel_text_address(regs->eip);
 	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
 	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
@@ -226,8 +232,9 @@ void show_registers(struct pt_regs *regs
 
 		printk("\nStack: ");
 		show_stack((unsigned long*)esp);
+		module_oops_tracking_print();
 
-		printk("\nCode: ");
+		printk("Code: ");
 		if(regs->eip < PAGE_OFFSET)
 			goto bad;
 
diff -urNp ref/include/linux/kernel.h oops-x/include/linux/kernel.h
--- ref/include/linux/kernel.h	Fri Jul 26 23:01:52 2002
+++ oops-x/include/linux/kernel.h	Fri Jul 26 23:18:37 2002
@@ -109,6 +109,8 @@ extern const char *print_tainted(void);
 
 extern void dump_stack(void);
 
+extern char *linux_banner;
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
diff -urNp ref/include/linux/module.h oops-x/include/linux/module.h
--- ref/include/linux/module.h	Wed Jul 24 21:52:27 2002
+++ oops-x/include/linux/module.h	Fri Jul 26 23:25:12 2002
@@ -411,4 +411,14 @@ __attribute__((section("__ksymtab"))) =	
 #define SET_MODULE_OWNER(some_struct) do { } while (0)
 #endif
 
+#ifdef CONFIG_MODULES
+extern void module_oops_tracking_init(void);
+extern void module_oops_tracking_mark(int);
+extern void module_oops_tracking_print(void);
+#else
+#define module_oops_tracking_init() do { } while (0)
+#define module_oops_tracking_mark(x) do { } while (0)
+#define module_oops_tracking_print() do { } while (0)
+#endif
+
 #endif /* _LINUX_MODULE_H */
diff -urNp ref/init/main.c oops-x/init/main.c
--- ref/init/main.c	Fri Jul 26 23:01:52 2002
+++ oops-x/init/main.c	Fri Jul 26 23:18:34 2002
@@ -81,7 +81,6 @@ extern int irda_device_init(void);
 #endif
 
 extern char _stext, _etext;
-extern char *linux_banner;
 
 static int init(void *);
 
diff -urNp ref/kernel/module.c oops-x/kernel/module.c
--- ref/kernel/module.c	Fri Jul 26 23:01:29 2002
+++ oops-x/kernel/module.c	Fri Jul 26 22:50:22 2002
@@ -1242,6 +1242,57 @@ struct seq_operations ksyms_op = {
 	show:	s_show
 };
 
+/*
+ * The module tracking logic assumes the module list doesn't
+ * change under the oops. In case of a race we could get not
+ * the exact information about the affected modules, but it's
+ * almost impossible to trigger and it's a not interesting case.
+ * This code runs protected by the die_lock spinlock, the arch/
+ * caller takes care of it.
+ */
+#define MODULE_OOPS_TRACKING_NR_LONGS 10
+#define MODULE_OOPS_TRACKING_NR_BITS (BITS_PER_LONG * MODULE_OOPS_TRACKING_NR_LONGS)
+static unsigned long module_oops_tracking[MODULE_OOPS_TRACKING_NR_LONGS];
+
+void module_oops_tracking_init(void)
+{
+	memset(module_oops_tracking, 0, sizeof(module_oops_tracking));
+}
+
+void module_oops_tracking_mark(int nr)
+{
+	if (nr < MODULE_OOPS_TRACKING_NR_BITS)
+		set_bit(nr, module_oops_tracking);
+}
+
+static void __module_oops_tracking_print(int nr)
+{
+	struct module *mod;
+
+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+		if (!nr--)
+			printk("	[(%s:<%p>:<%p>)]\n",
+			       mod->name,
+			       (char *) mod + mod->size_of_struct,
+			       (char *) mod + mod->size);
+	}
+	
+}
+
+void module_oops_tracking_print(void)
+{
+	int nr;
+
+	printk("Module Oops Tracking:\n");
+	nr = find_first_bit(module_oops_tracking, MODULE_OOPS_TRACKING_NR_BITS);
+	for (;;) {
+		if (nr == MODULE_OOPS_TRACKING_NR_BITS)
+			return;
+		__module_oops_tracking_print(nr);
+		nr = find_next_bit(module_oops_tracking, MODULE_OOPS_TRACKING_NR_BITS, nr+1);
+	}
+}
+
 #else		/* CONFIG_MODULES */
 
 /* Dummy syscalls for people who don't want modules */

Andrea
