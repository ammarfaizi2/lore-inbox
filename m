Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSG1WuO>; Sun, 28 Jul 2002 18:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSG1WuI>; Sun, 28 Jul 2002 18:50:08 -0400
Received: from [195.223.140.120] ([195.223.140.120]:6681 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317387AbSG1WuD>; Sun, 28 Jul 2002 18:50:03 -0400
Date: Sat, 27 Jul 2002 03:47:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()]
Message-ID: <20020727014700.GA12738@dualathlon.random>
References: <20020727011906.GA1160@dualathlon.random> <19388.1027733591@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19388.1027733591@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 11:33:11AM +1000, Keith Owens wrote:
> On Sat, 27 Jul 2002 03:19:06 +0200, 
> Andrea Arcangeli <andrea@suse.de> wrote:
> >here an updated patch that moves the bitflag from the dedicated array to
> >the mod->flags per your suggesiton.
> >Oops: 0002
> >2.4.19-rc3aa2 #3 SMP Sat Jul 27 05:06:19 CEST 2002
> 
> Kernel version without any identifying string cannot be picked up by
> ksymoops.  Can you append the kernel version to the die message?  That
> means changing all arch/*/traps.c but it saves a line on the console.
> 
> Oops: 0002 2.4.19-rc3aa2 #3 SMP Sat Jul 27 05:06:19 CEST 2002

ok, it saves one more line (will be in next -aa too, for rc3aa2 it's too
late 8).

diff -urNp z/arch/i386/kernel/traps.c 2.4.19rc3aa2/arch/i386/kernel/traps.c
--- z/arch/i386/kernel/traps.c	Sat Jul 27 03:42:39 2002
+++ 2.4.19rc3aa2/arch/i386/kernel/traps.c	Sat Jul 27 03:41:56 2002
@@ -113,6 +113,7 @@ static inline int kernel_text_address(un
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
 		if (mod_bound(addr, 0, mod)) {
+			module_oops_tracking_mark(mod);
 			retval = 1;
 			break;
 		}
@@ -208,6 +209,8 @@ void show_registers(struct pt_regs *regs
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
 	}
+	module_oops_tracking_init();
+	kernel_text_address(regs->eip);
 	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
 	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
@@ -226,8 +229,9 @@ void show_registers(struct pt_regs *regs
 
 		printk("\nStack: ");
 		show_stack((unsigned long*)esp);
+		module_oops_tracking_print();
 
-		printk("\nCode: ");
+		printk("Code: ");
 		if(regs->eip < PAGE_OFFSET)
 			goto bad;
 
@@ -288,7 +292,8 @@ void die(const char * str, struct pt_reg
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 	handle_BUG(regs);
-	printk("%s: %04lx\n", str, err & 0xffff);
+	printk("%s: %04lx ", str, err & 0xffff);
+	printk(oops_id);
 	show_registers(regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
diff -urNp z/include/linux/kernel.h 2.4.19rc3aa2/include/linux/kernel.h
--- z/include/linux/kernel.h	Sat Jul 27 03:42:39 2002
+++ 2.4.19rc3aa2/include/linux/kernel.h	Sat Jul 27 04:57:04 2002
@@ -109,6 +109,8 @@ extern const char *print_tainted(void);
 
 extern void dump_stack(void);
 
+extern char *oops_id;
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
diff -urNp z/include/linux/module.h 2.4.19rc3aa2/include/linux/module.h
--- z/include/linux/module.h	Sat Jul 27 03:42:39 2002
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
--- z/init/version.c	Sat Jul 27 03:42:39 2002
+++ 2.4.19rc3aa2/init/version.c	Sat Jul 27 05:03:14 2002
@@ -24,3 +24,5 @@ struct new_utsname system_utsname = {
 const char *linux_banner = 
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+
+const char *oops_id = UTS_RELEASE " " UTS_VERSION "\n";
diff -urNp z/kernel/module.c 2.4.19rc3aa2/kernel/module.c
--- z/kernel/module.c	Sat Jul 27 03:42:39 2002
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
