Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTKFTyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTKFTyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:54:49 -0500
Received: from relay.pair.com ([209.68.1.20]:22789 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S263809AbTKFTy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:54:27 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <3FAAAA3B.1000707@kegel.com>
Date: Thu, 06 Nov 2003 12:08:27 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Smarter stack traces using the frame pointer
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth, on ppc I've made stack traces
slightly smarter, too.  I think the ppc stack dump
code always used the frame
pointer, but it still output a bunch of garbage at the
end of the stack dump.  As a byproduct of porting the
module tracking patch to ppc, I had to check each
address printed out by the stack dumper, and fairly
often they're not legal text addresses.  I print a ? after
the questionable ones now.  No big deal, but it is
*slightly* smarter.  Here's the bit in question:

--- patch-backup/arch/ppc/kernel/process.c	Mon Oct 13 17:32:04 2003
+++ arch/ppc/kernel/process.c	Tue Oct 14 00:05:29 2003
@@ -514,7 +564,11 @@
  			break;
  		if (cnt++ % 7 == 0)
  			printk("\n");
-		printk("%08lX ", i);
+		if (kernel_text_address(i)) {	/* mostly just want to mark modules */
+			printk("%08lX ", i);
+		} else {			/* FIXME: should we ignore fishy adrs like x86? */
+			printk("%08lX? ", i);	/* Or append a '?' (ksymoops doesn't mind) */
+		}
  		if (cnt > 32) break;
  		if (__get_user(sp, (unsigned long **)sp))
  			break;


And here's the whole module tracking patch, including my port of it to ppc
(the paths have the first component removed, sorry):

# Purpose: add module info to oops log
# Source http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa3/90_module-oops-tracking-3
# See also http://marc.theaimsgroup.com/?l=linux-kernel&m=102772338115172&w=2
# ppc port added by dank@kegel.com Oct 2003

diff -urNp z/arch/i386/kernel/traps.c 2.4.19rc3aa2/arch/i386/kernel/traps.c
--- arch/i386/kernel/traps.c	Sat Jul 27 03:42:39 2002
+++ arch/i386/kernel/traps.c	Sat Jul 27 03:41:56 2002
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
--- include/linux/kernel.h	Sat Jul 27 03:42:39 2002
+++ include/linux/kernel.h	Sat Jul 27 04:57:04 2002
@@ -109,6 +109,8 @@ extern const char *print_tainted(void);

  extern void dump_stack(void);

+extern char *oops_id;
+
  #if DEBUG
  #define pr_debug(fmt,arg...) \
  	printk(KERN_DEBUG fmt,##arg)
diff -urNp z/include/linux/module.h 2.4.19rc3aa2/include/linux/module.h
--- include/linux/module.h	Sat Jul 27 03:42:39 2002
+++ include/linux/module.h	Sat Jul 27 04:57:40 2002
@@ -110,6 +110,7 @@ struct module_info
  #define MOD_USED_ONCE		16
  #define MOD_JUST_FREED		32
  #define MOD_INITIALIZING	64
+#define MOD_OOPS_PRINT		128UL

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
--- init/version.c	Sat Jul 27 03:42:39 2002
+++ init/version.c	Sat Jul 27 05:03:14 2002
@@ -24,3 +24,5 @@ struct new_utsname system_utsname = {
  const char *linux_banner =
  	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
  	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+
+const char *oops_id = UTS_RELEASE " " UTS_VERSION "\n";
diff -urNp z/kernel/module.c 2.4.19rc3aa2/kernel/module.c
--- kernel/module.c	Sat Jul 27 03:42:39 2002
+++ kernel/module.c	Sat Jul 27 02:38:24 2002
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
+		mod->flags &= ~MOD_OOPS_PRINT;
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
--- patch-backup/arch/ppc/kernel/process.c	Mon Oct 13 17:32:04 2003
+++ arch/ppc/kernel/process.c	Tue Oct 14 00:05:29 2003
@@ -60,6 +60,53 @@
  #undef SHOW_TASK_SWITCHES
  #undef CHECK_STACK

+/*
+ * If the address is either in the .text section of the
+ * kernel, or in the vmalloc'ed module regions, it *may*
+ * be the address of a calling routine
+ */
+
+extern char _etext[], _stext[];
+
+#ifdef CONFIG_MODULES
+#include <linux/module.h>
+
+extern struct module *module_list;
+extern struct module kernel_module;
+
+static inline int kernel_text_address(unsigned long addr)
+{
+	int retval = 0;
+	struct module *mod;
+
+	if (addr >= (unsigned long) &_stext &&
+	    addr <= (unsigned long) &_etext)
+		return 1;
+
+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+		/* mod_bound tests for addr being inside the vmalloc'ed
+		 * module area. Of course it'd be better to test only
+		 * for the .text subset... */
+		if (mod_bound(addr, 0, mod)) {
+			module_oops_tracking_mark(mod);
+			retval = 1;
+			break;
+		}
+	}
+
+	return retval;
+}
+
+#else
+
+static inline int kernel_text_address(unsigned long addr)
+{
+	return (addr >= (unsigned long) &_stext &&
+		addr <= (unsigned long) &_etext);
+}
+
+#endif
+
  #if defined(CHECK_STACK)
  unsigned long
  kernel_stack_top(struct task_struct *tsk)
@@ -243,6 +290,8 @@
  {
  	int i;

+	module_oops_tracking_init();
+	kernel_text_address(regs->nip);
  	printk("NIP: %08lX XER: %08lX LR: %08lX SP: %08lX REGS: %p TRAP: %04lx    %s\n",
  	       regs->nip, regs->xer, regs->link, regs->gpr[1], regs,regs->trap, print_tainted());
  	printk("MSR: %08lx EE: %01x PR: %01x FP: %01x ME: %01x IR/DR: %01x%01x\n",
@@ -303,6 +352,7 @@
  	}
  out:
  	print_backtrace((unsigned long *)regs->gpr[1]);
+	module_oops_tracking_print();
  }

  void exit_thread(void)
@@ -514,7 +564,11 @@
  			break;
  		if (cnt++ % 7 == 0)
  			printk("\n");
-		printk("%08lX ", i);
+		if (kernel_text_address(i)) {	/* mostly just want to mark modules */
+			printk("%08lX ", i);
+		} else {			/* FIXME: should we ignore fishy adrs like x86? */
+			printk("%08lX? ", i);	/* Or append a '?' (ksymoops doesn't mind) */
+		}
  		if (cnt > 32) break;
  		if (__get_user(sp, (unsigned long **)sp))
  			break;
--- arch/ppc/kernel/traps.c.old	Mon Oct 13 17:23:40 2003
+++ arch/ppc/kernel/traps.c	Mon Oct 13 17:25:27 2003
@@ -97,7 +97,8 @@
  	set_backlight_enable(1);
  	set_backlight_level(BACKLIGHT_MAX);
  #endif
-	printk("Oops: %s, sig: %ld\n", str, err);
+	printk("Oops: %s, sig: %ld ", str, err);
+	printk(oops_id);
  	show_regs(fp);
  #ifdef CONFIG_BOOTX_TEXT
  	force_printk_to_btext = 0;

