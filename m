Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317854AbSG0BOx>; Fri, 26 Jul 2002 21:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318667AbSG0BOx>; Fri, 26 Jul 2002 21:14:53 -0400
Received: from [195.223.140.120] ([195.223.140.120]:32626 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317854AbSG0BOv>; Fri, 26 Jul 2002 21:14:51 -0400
Date: Sat, 27 Jul 2002 03:19:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()]
Message-ID: <20020727011906.GA1160@dualathlon.random>
References: <20020726223750.GA1151@dualathlon.random> <18391.1027729171@ocs3.intra.ocs.com.au> <20020727003121.GC1177@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020727003121.GC1177@dualathlon.random>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 02:31:21AM +0200, Andrea Arcangeli wrote:
> On Sat, Jul 27, 2002 at 10:19:31AM +1000, Keith Owens wrote:
> > On Sat, 27 Jul 2002 00:37:50 +0200, 
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >I implemented what I need to track down oopses with modules. ksymoops
> > >should learn about it too. This will also allow us to recognize
> > >immediatly the kernel image used.
> > >+#define MODULE_OOPS_TRACKING_NR_LONGS 10
> > >+#define MODULE_OOPS_TRACKING_NR_BITS (BITS_PER_LONG * MODULE_OOPS_TRACKING_NR_LONGS)
> > >+static unsigned long module_oops_tracking[MODULE_OOPS_TRACKING_NR_LONGS];
> > >+void module_oops_tracking_mark(int nr)
> > >+{
> > >+	if (nr < MODULE_OOPS_TRACKING_NR_BITS)
> > >+		set_bit(nr, module_oops_tracking);
> > >+}
> > >+
> > >+static void __module_oops_tracking_print(int nr)
> > >+{
> > >+	struct module *mod;
> > >+
> > >+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
> > >+		if (!nr--)
> > >+			printk("	[(%s:<%p>:<%p>)]\n",
> > >+			       mod->name,
> > >+			       (char *) mod + mod->size_of_struct,
> > >+			       (char *) mod + mod->size);
> > >+	}
> > >+	
> > >+}
> > 
> > Instead of adding a separate bit map and scanning the module chain to
> > convert a bit number to a module entry, add a new entry to mod->flags.
> > 
> >   #define MOD_OOPS_PRINTED 128
> > 
> > That simplifies the code and reduces the number of times you have to
> > scan the module list.
> 
> ok, the prepare stage will be a bit more complicated but it seems
> a worthwhile change, thanks.

here an updated patch that moves the bitflag from the dedicated array to
the mod->flags per your suggesiton.

The output now looks like this (I also compressed the oops_id info so
that it doesn't overflow 80 cols, given I saved 1 suprios return this
overall only adds an overhead of 1 line to the oops when there are
modules and zero overhead of no module is involved). The new provided
information is invaluable in may situations and it can be easily parsed
by ksymoops in a reliable manner.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c39d906e
*pde = 00000000
Oops: 0002
2.4.19-rc3aa2 #3 SMP Sat Jul 27 05:06:19 CEST 2002
CPU:    0
EIP:    0010:[<c39d906e>]    Tainted: P 
EFLAGS: 00010246
eax: c39d9060   ebx: ffffffea   ecx: c034b350   edx: c10ad8a0
esi: 00000000   edi: 00000000   ebp: c39d9000   esp: c39dbf10
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 929, stackpage=c39db000)
Stack: 00000000 00000000 ffffffea c011f917 c39d9060 080862d0 000000e0 00000000 
       08086335 000000c5 00000060 00000060 00000004 c22caa40 c39d8000 c39dc000 
       00000060 c2260000 c39d9060 00000140 00000000 00000000 00000000 00000000 
Call Trace:    [<c011f917>] [<c39d9060>] [<c39d9060>] [<c01090e7>]
Modules: [(oops:<c39d9060>:<c39d9140>)]
Code: c7 05 00 00 00 00 00 00 00 00 83 0d 14 90 9d c3 08 e8 4c 1e 

diff -urNp z/arch/i386/kernel/traps.c 2.4.19rc3aa2/arch/i386/kernel/traps.c
--- z/arch/i386/kernel/traps.c	Sat Jul 27 03:13:07 2002
+++ 2.4.19rc3aa2/arch/i386/kernel/traps.c	Sat Jul 27 03:14:30 2002
@@ -113,6 +113,7 @@ static inline int kernel_text_address(un
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
 		if (mod_bound(addr, 0, mod)) {
+			module_oops_tracking_mark(mod);
 			retval = 1;
 			break;
 		}
@@ -201,6 +202,8 @@ void show_registers(struct pt_regs *regs
 	unsigned long esp;
 	unsigned short ss;
 
+	printk(oops_id);
+
 	esp = (unsigned long) (&regs->esp);
 	ss = __KERNEL_DS;
 	if (regs->xcs & 3) {
@@ -208,6 +211,8 @@ void show_registers(struct pt_regs *regs
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
 	}
+	module_oops_tracking_init();
+	kernel_text_address(regs->eip);
 	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
 	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
@@ -226,8 +231,9 @@ void show_registers(struct pt_regs *regs
 
 		printk("\nStack: ");
 		show_stack((unsigned long*)esp);
+		module_oops_tracking_print();
 
-		printk("\nCode: ");
+		printk("Code: ");
 		if(regs->eip < PAGE_OFFSET)
 			goto bad;
 
diff -urNp z/include/linux/kernel.h 2.4.19rc3aa2/include/linux/kernel.h
--- z/include/linux/kernel.h	Sat Jul 27 03:13:07 2002
+++ 2.4.19rc3aa2/include/linux/kernel.h	Sat Jul 27 04:57:04 2002
@@ -109,6 +109,8 @@ extern const char *print_tainted(void);
 
 extern void dump_stack(void);
 
+extern char *oops_id;
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
diff -urNp z/include/linux/module.h 2.4.19rc3aa2/include/linux/module.h
--- z/include/linux/module.h	Sat Jul 27 03:13:07 2002
+++ 2.4.19rc3aa2/include/linux/module.h	Sat Jul 27 04:57:40 2002
@@ -110,6 +110,7 @@ struct module_info
 #define MOD_USED_ONCE		16
 #define MOD_JUST_FREED		32
 #define MOD_INITIALIZING	64
+#define MOD_OOPS_PRINT		128
 
 /* Values for query_module's which.  */
 
@@ -411,4 +412,14 @@ __attribute__((section("__ksymtab"))) =	
 #define SET_MODULE_OWNER(some_struct) do { } while (0)
 #endif
 
+#ifdef CONFIG_MODULES
+extern void module_oops_tracking_init(void);
+extern void module_oops_tracking_mark(struct module *);
+extern void module_oops_tracking_print(void);
+#else
+#define module_oops_tracking_init() do { } while (0)
+#define module_oops_tracking_mark(x) do { } while (0)
+#define module_oops_tracking_print() do { } while (0)
+#endif
+
 #endif /* _LINUX_MODULE_H */
diff -urNp z/init/version.c 2.4.19rc3aa2/init/version.c
--- z/init/version.c	Tue Jan 22 18:56:00 2002
+++ 2.4.19rc3aa2/init/version.c	Sat Jul 27 05:03:14 2002
@@ -24,3 +24,5 @@ struct new_utsname system_utsname = {
 const char *linux_banner = 
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+
+const char *oops_id = UTS_RELEASE " " UTS_VERSION "\n";
diff -urNp z/kernel/module.c 2.4.19rc3aa2/kernel/module.c
--- z/kernel/module.c	Sat Jul 27 03:13:07 2002
+++ 2.4.19rc3aa2/kernel/module.c	Sat Jul 27 02:38:24 2002
@@ -1242,6 +1242,50 @@ struct seq_operations ksyms_op = {
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
+void module_oops_tracking_init(void)
+{
+	struct module * mod;
+
+	for (mod = module_list; mod != &kernel_module; mod = mod->next)
+		mod->flags &= MOD_OOPS_PRINT;
+}
+
+void module_oops_tracking_mark(struct module * mod)
+{
+	mod->flags |= MOD_OOPS_PRINT;
+}
+
+void module_oops_tracking_print(void)
+{
+	struct module *mod;
+	int i = 0;
+
+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+		if (!(mod->flags & MOD_OOPS_PRINT))
+			continue;
+		if (!i)
+			printk("Modules:");
+		if (i && !(i % 2))
+			printk("\n        ");
+		i++;
+
+		printk(" [(%s:<%p>:<%p>)]",
+		       mod->name,
+		       (char *) mod + mod->size_of_struct,
+		       (char *) mod + mod->size);
+	}
+	if (i)
+		printk("\n");
+}
+
 #else		/* CONFIG_MODULES */
 
 /* Dummy syscalls for people who don't want modules */

Andrea
