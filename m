Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUEMA6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUEMA6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 20:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUEMA6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 20:58:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:41609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261378AbUEMA6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 20:58:12 -0400
Date: Wed, 12 May 2004 17:49:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: hirao@estartu.open.nm.fujitsu.co.jp
Subject: [patch] kernel modules profile support (2.6.6)
Message-Id: <20040512174936.3e567f68.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch (below) is an update of a 2.4.18 kernel patch that
supports module profiling in the in-kernel profiler.

Originally from:  hirao (hirao@estartu.open.nm.fujitsu.co.jp)


'readprofile2' changes to util-linux-2.12pre (as well as the
kernel patch) are available at:
  http://developer.osdl.org/rddunlap/modprofile/

Usage info:
  http://developer.osdl.org/rddunlap/modprofile/profile_modules.txt

--
~Randy



 arch/i386/Kconfig         |    6 
 fs/proc/proc_misc.c       |   72 --------
 include/asm-i386/hw_irq.h |   30 ++-
 include/linux/proc_fs.h   |    2 
 include/linux/profile.h   |   84 +++++++++
 kernel/Makefile           |    2 
 kernel/kallsyms.c         |   15 +
 kernel/module.c           |   13 +
 kernel/profile.c          |  410 +++++++++++++++++++++++++++++++++++++++++++++-
 scripts/kallsyms.c        |    8 
 10 files changed, 559 insertions(+), 83 deletions(-)


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/arch/i386/Kconfig linux-266-modprof/arch/i386/Kconfig
--- linux-266-pv/arch/i386/Kconfig	2004-05-09 19:32:01.000000000 -0700
+++ linux-266-modprof/arch/i386/Kconfig	2004-05-10 12:35:07.000000000 -0700
@@ -1294,6 +1294,12 @@ config X86_MPPARSE
 	depends on X86_LOCAL_APIC && !X86_VISWS
 	default y
 
+config MODULE_PROFILE
+	bool "Module profiling support"
+	select PROFILING
+	help
+	  This enables profiling of kernel loadable modules.
+
 endmenu
 
 source "security/Kconfig"
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/fs/proc/proc_misc.c linux-266-modprof/fs/proc/proc_misc.c
--- linux-266-pv/fs/proc/proc_misc.c	2004-05-09 19:32:01.000000000 -0700
+++ linux-266-modprof/fs/proc/proc_misc.c	2004-05-10 12:35:07.000000000 -0700
@@ -555,70 +555,6 @@ static int execdomains_read_proc(char *p
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-/*
- * This function accesses profiling information. The returned data is
- * binary: the sampling step and the actual contents of the profile
- * buffer. Use of the program readprofile is recommended in order to
- * get meaningful info out of these data.
- */
-static ssize_t
-read_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
-{
-	unsigned long p = *ppos;
-	ssize_t read;
-	char * pnt;
-	unsigned int sample_step = 1 << prof_shift;
-
-	if (p >= (prof_len+1)*sizeof(unsigned int))
-		return 0;
-	if (count > (prof_len+1)*sizeof(unsigned int) - p)
-		count = (prof_len+1)*sizeof(unsigned int) - p;
-	read = 0;
-
-	while (p < sizeof(unsigned int) && count > 0) {
-		put_user(*((char *)(&sample_step)+p),buf);
-		buf++; p++; count--; read++;
-	}
-	pnt = (char *)prof_buffer + p - sizeof(unsigned int);
-	if (copy_to_user(buf,(void *)pnt,count))
-		return -EFAULT;
-	read += count;
-	*ppos += read;
-	return read;
-}
-
-/*
- * Writing to /proc/profile resets the counters
- *
- * Writing a 'profiling multiplier' value into it also re-sets the profiling
- * interrupt frequency, on architectures that support this.
- */
-static ssize_t write_profile(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
-{
-#ifdef CONFIG_SMP
-	extern int setup_profiling_timer (unsigned int multiplier);
-
-	if (count == sizeof(int)) {
-		unsigned int multiplier;
-
-		if (copy_from_user(&multiplier, buf, sizeof(int)))
-			return -EFAULT;
-
-		if (setup_profiling_timer(multiplier))
-			return -EINVAL;
-	}
-#endif
-
-	memset(prof_buffer, 0, prof_len * sizeof(*prof_buffer));
-	return count;
-}
-
-static struct file_operations proc_profile_operations = {
-	.read		= read_profile,
-	.write		= write_profile,
-};
-
 #ifdef CONFIG_MAGIC_SYSRQ
 /*
  * writing 'C' to /proc/sysrq-trigger is like sysrq-C
@@ -643,6 +579,10 @@ static struct file_operations proc_sysrq
 
 struct proc_dir_entry *proc_root_kcore;
 
+#ifdef CONFIG_MODULE_PROFILE	
+struct proc_dir_entry *proc_root_mprof;
+#endif
+
 static void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
 {
 	struct proc_dir_entry *entry;
@@ -707,11 +647,15 @@ void __init proc_misc_init(void)
 	}
 #endif
 	if (prof_on) {
+		extern struct file_operations proc_profile_operations;
 		entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL);
 		if (entry) {
 			entry->proc_fops = &proc_profile_operations;
 			entry->size = (1+prof_len) * sizeof(unsigned int);
 		}
+#ifdef CONFIG_MODULE_PROFILE	
+		proc_root_mprof = proc_mkdir("mprof", 0);
+#endif
 	}
 #ifdef CONFIG_MAGIC_SYSRQ
 	entry = create_proc_entry("sysrq-trigger", S_IWUSR, NULL);
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/include/asm-i386/hw_irq.h linux-266-modprof/include/asm-i386/hw_irq.h
--- linux-266-pv/include/asm-i386/hw_irq.h	2004-05-09 19:33:21.000000000 -0700
+++ linux-266-modprof/include/asm-i386/hw_irq.h	2004-05-10 12:35:07.000000000 -0700
@@ -77,15 +77,20 @@ extern atomic_t irq_mis_count;
 static inline void x86_do_profile(struct pt_regs * regs)
 {
 	unsigned long eip;
-	extern unsigned long prof_cpu_mask;
+#ifdef CONFIG_MODULE_PROFILE
+	unsigned int * targ_prof_buffer;
+	unsigned long idx;
+#endif
  
 	profile_hook(regs);
  
-	if (user_mode(regs))
+	if (user_mode(regs)) {
 		return;
+	}
  
-	if (!prof_buffer)
+	if (!prof_buffer) {
 		return;
+	}
 
 	eip = regs->eip;
  
@@ -93,19 +98,30 @@ static inline void x86_do_profile(struct
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
 	 */
-	if (!((1<<smp_processor_id()) & prof_cpu_mask))
+	if (!((1<<smp_processor_id()) & prof_cpu_mask)) {
 		return;
+	}
 
-	eip -= (unsigned long)_stext;
+#ifdef CONFIG_MODULE_PROFILE
+	/*
+	 * get profiling buffer address and offset
+	 * @pc	: program counter
+	 * @idx	: profiling buffer offset
+	 */
+	targ_prof_buffer = srch_prof_buffer(eip, &idx);
+	atomic_inc((atomic_t *)&targ_prof_buffer[idx]);
+#else
+	eip -= (unsigned long) &_stext;
 	eip >>= prof_shift;
 	/*
 	 * Don't ignore out-of-bounds EIP values silently,
 	 * put them into the last histogram slot, so if
 	 * present, they will show up as a sharp peak.
 	 */
-	if (eip > prof_len-1)
-		eip = prof_len-1;
+	if (eip > prof_len - 1)
+		eip = prof_len - 1;
 	atomic_inc((atomic_t *)&prof_buffer[eip]);
+#endif
 }
  
 #if defined(CONFIG_X86_IO_APIC)
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/include/linux/proc_fs.h linux-266-modprof/include/linux/proc_fs.h
--- linux-266-pv/include/linux/proc_fs.h	2004-05-09 19:33:22.000000000 -0700
+++ linux-266-modprof/include/linux/proc_fs.h	2004-05-10 12:35:07.000000000 -0700
@@ -82,6 +82,7 @@ extern struct proc_dir_entry *proc_net;
 extern struct proc_dir_entry *proc_bus;
 extern struct proc_dir_entry *proc_root_driver;
 extern struct proc_dir_entry *proc_root_kcore;
+extern struct proc_dir_entry *proc_root_mprof;
 
 extern void proc_root_init(void);
 extern void proc_misc_init(void);
@@ -114,6 +115,7 @@ extern struct dentry *proc_lookup(struct
 extern struct file_operations proc_kcore_operations;
 extern struct file_operations proc_kmsg_operations;
 extern struct file_operations ppc_htab_operations;
+extern struct file_operations proc_mprof_operations;
 
 /*
  * proc_tty.c
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/include/linux/profile.h linux-266-modprof/include/linux/profile.h
--- linux-266-pv/include/linux/profile.h	2004-05-09 19:32:29.000000000 -0700
+++ linux-266-modprof/include/linux/profile.h	2004-05-12 15:53:36.000000000 -0700
@@ -6,7 +6,11 @@
 #include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+///#include <linux/stddef.h>
 #include <asm/errno.h>
+#include <asm-generic/sections.h>
 
 /* parse command line */
 int __init profile_setup(char * str);
@@ -18,7 +22,7 @@ extern unsigned int * prof_buffer;
 extern unsigned long prof_len;
 extern unsigned long prof_shift;
 extern int prof_on;
-
+extern unsigned long prof_cpu_mask;
 
 enum profile_type {
 	EXIT_TASK,
@@ -32,6 +36,28 @@ struct notifier_block;
 struct task_struct;
 struct mm_struct;
 
+struct module_profile {
+	char *proc_name;
+	struct list_head list;
+	unsigned long prof_len;
+	unsigned long start_text;
+	unsigned long end_text;
+	unsigned int *prof_buffer;
+	struct module *module;
+};
+
+/* module profile root information */
+struct mprof_info {
+	rwlock_t rwlock;
+	struct list_head mprof_head;
+};
+
+extern struct mprof_info *module_profile_info;
+
+char *get_profile_name(struct module *mod);
+int create_module_profile(struct module *mod);
+void delete_module_profile(struct module *mod);
+
 /* task is in do_exit() */
 void profile_exit_task(struct task_struct * task);
 
@@ -53,6 +79,62 @@ struct pt_regs;
 /* profiling hook activated on each timer interrupt */
 void profile_hook(struct pt_regs * regs);
 
+/*
+ * called by profiling functions
+ */
+static inline unsigned int *
+srch_module_prof_buffer(unsigned long pc, unsigned long *idx)
+{
+	struct list_head *tmp;
+	struct module_profile *mprof;
+
+	/*
+	 * look for module_profile_buffer address with PC
+	 * into module_profile list chains
+	 */
+	list_for_each(tmp, &module_profile_info->mprof_head) {
+		mprof = list_entry(tmp, struct module_profile, list);
+
+		if (mprof->start_text <= pc && pc < mprof->end_text) { /* hit */
+			unsigned long rel_pc = pc - mprof->start_text;
+			*idx = rel_pc >> prof_shift;
+			return mprof->prof_buffer;
+		}
+	}
+
+	/* mprof == NULL: no module profiling buffer */
+	*idx = prof_len - 2;
+	return prof_buffer;
+}
+
+static inline unsigned int *
+srch_prof_buffer(unsigned long pc, unsigned long *idx)
+{
+	unsigned int *targ_prof_buffer = prof_buffer;
+
+	/*
+	 * Don't ignore out-of-bounds PC values silently,
+	 * put them into the last histogram slot, so if
+	 * present, they will show up as a sharp peak.
+	 */
+	if (pc < (unsigned long)&_stext) {
+		/* before kernel .text, could be in a module */
+		targ_prof_buffer = srch_module_prof_buffer(pc, idx);
+	}
+	else if (pc < (unsigned long)&_etext) { /* kernel profile */
+		unsigned long rel_pc = pc - (unsigned long)&_stext;
+		*idx = rel_pc >> prof_shift;
+	}
+	else if (pc < (unsigned long)&__init_end) { /* kernel init/exit code */
+		/* out of kernel .text, and out of module .text */
+		*idx = prof_len - 1;
+	}
+	else {
+		targ_prof_buffer = srch_module_prof_buffer(pc, idx);
+	}
+	return targ_prof_buffer;
+}
+
 #else
 
 static inline int profile_event_register(enum profile_type t, struct notifier_block * n)
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/kernel/kallsyms.c linux-266-modprof/kernel/kallsyms.c
--- linux-266-pv/kernel/kallsyms.c	2004-05-09 19:33:21.000000000 -0700
+++ linux-266-modprof/kernel/kallsyms.c	2004-05-10 12:35:07.000000000 -0700
@@ -171,21 +171,23 @@ static int get_ksymbol_mod(struct kallsy
 	return 1;
 }
 
-static void get_ksymbol_core(struct kallsym_iter *iter)
+/* Returns space to next name. */
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
 {
-	unsigned stemlen;
+	unsigned stemlen, off = iter->nameoff;
 
 	/* First char of each symbol name indicates prefix length
 	   shared with previous name (stem compression). */
-	stemlen = kallsyms_names[iter->nameoff++];
+	stemlen = kallsyms_names[off++];
 
-	strlcpy(iter->name+stemlen, kallsyms_names+iter->nameoff, 128-stemlen);
-	iter->nameoff += strlen(kallsyms_names + iter->nameoff) + 1;
+	strlcpy(iter->name+stemlen, kallsyms_names + off, 128-stemlen);
+	off += strlen(kallsyms_names + off) + 1;
 	iter->owner = NULL;
 	iter->value = kallsyms_addresses[iter->pos];
 	iter->type = 't';
 
 	upcase_if_global(iter);
+	return off - iter->nameoff;
 }
 
 static void reset_iter(struct kallsym_iter *iter)
@@ -210,9 +212,10 @@ static int update_iter(struct kallsym_it
 
 	/* We need to iterate through the previous symbols: can be slow */
 	for (; iter->pos != pos; iter->pos++) {
-		get_ksymbol_core(iter);
+		iter->nameoff += get_ksymbol_core(iter);
 		cond_resched();
 	}
+	get_ksymbol_core(iter);
 	return 1;
 }
 
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/kernel/Makefile linux-266-modprof/kernel/Makefile
--- linux-266-pv/kernel/Makefile	2004-05-09 19:32:02.000000000 -0700
+++ linux-266-modprof/kernel/Makefile	2004-05-10 12:35:07.000000000 -0700
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o profile.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/kernel/module.c linux-266-modprof/kernel/module.c
--- linux-266-pv/kernel/module.c	2004-05-09 19:32:54.000000000 -0700
+++ linux-266-modprof/kernel/module.c	2004-05-10 12:35:07.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/err.h>
 #include <linux/vermagic.h>
 #include <linux/notifier.h>
+#include <linux/profile.h>
 #include <linux/stop_machine.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -947,6 +948,10 @@ static unsigned long resolve_symbol(Elf_
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
+#ifdef CONFIG_MODULE_PROFILE
+	delete_module_profile(mod);
+#endif
+
 	/* Delete from various lists */
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->list);
@@ -1559,6 +1564,14 @@ static struct module *load_module(void _
 	if (err < 0)
 		goto arch_cleanup;
 
+#ifdef CONFIG_MODULE_PROFILE
+	if (create_module_profile(mod)) {
+		printk(KERN_WARNING "%s: creation of module "
+			"profiling buffer failed for module(%s).\n",
+			__FUNCTION__, mod->name);
+	}
+#endif
+
 	/* Get rid of temporary copy */
 	vfree(hdr);
 
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/kernel/profile.c linux-266-modprof/kernel/profile.c
--- linux-266-pv/kernel/profile.c	2004-05-09 19:33:20.000000000 -0700
+++ linux-266-modprof/kernel/profile.c	2004-05-10 12:35:07.000000000 -0700
@@ -8,7 +8,13 @@
 #include <linux/bootmem.h>
 #include <linux/notifier.h>
 #include <linux/mm.h>
+///#include <linux/slab.h>
+///#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
 #include <asm/sections.h>
+#include <asm/uaccess.h>
 
 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -91,10 +97,8 @@ int profile_event_register(enum profile_
 	}
  
 	up_write(&profile_rwsem);
- 
 	return err;
 }
-
  
 int profile_event_unregister(enum profile_type type, struct notifier_block * n)
 {
@@ -151,6 +155,408 @@ void profile_hook(struct pt_regs * regs)
 EXPORT_SYMBOL_GPL(register_profile_notifier);
 EXPORT_SYMBOL_GPL(unregister_profile_notifier);
 
+#ifdef CONFIG_MODULE_PROFILE
+
+static spinlock_t module_profile_lock = SPIN_LOCK_UNLOCKED;
+
+static struct mprof_info mprof_info = {
+	.rwlock =	RW_LOCK_UNLOCKED,
+	.mprof_head =	LIST_HEAD_INIT(mprof_info.mprof_head),
+};
+struct mprof_info *module_profile_info = &mprof_info;
+
+/*
+ * determine profile name by given module,
+ * alloc memory for profile name, and set profile name
+ */
+char *get_profile_name(struct module *mod)
+{
+	char *proc_name;
+	int l;
+
+	/* construct module-profile-name */
+	l = strlen(mod->name)	/* module name */
+		+ 8;		/* "_profile" */
+	proc_name = kmalloc(l + 1, GFP_KERNEL);
+	if (proc_name)
+		snprintf(proc_name, l+1, "%s_profile", mod->name);
+	return proc_name;
+}
+
+/*
+ * create module profile for specified module
+ */
+int create_module_profile(struct module *mod)
+{
+	const struct kernel_symbol *sym;
+	char *name_prefix;
+	int i, l;
+	struct list_head *mprof_head, *tmp;
+	struct module_profile *new_mprof, *mprof;
+	struct proc_dir_entry *entry;
+	long error = 0;
+	unsigned long flags, buffer_size;
+	const char symprefix[] = "__insmod_";
+
+	if (proc_root_mprof == NULL) {
+		/* profile maybe not specified on boot option */
+		goto err0;
+	}
+
+	/* get memory for struct module_profile */
+	new_mprof = kmalloc(sizeof(struct module_profile), GFP_KERNEL);
+	if (new_mprof == NULL) {
+		error = -ENOMEM;
+		goto err0;
+	}
+	memset(new_mprof, 0, sizeof(*new_mprof));
+
+	/*
+	 * research .text start address and .text size in ksym,
+	 * set module profiling information for this module in module_profile.
+	 */
+	l = sizeof(symprefix) - 1	/* "__insmod_" (have NULL) */
+		+ strlen(mod->name)	/* module name */
+		+ 2			/* "_S" */
+		+ 5			/* section name".text" */
+		+ 2;			/* "_L" */
+	name_prefix = kmalloc(l + 1, GFP_KERNEL);
+	if (name_prefix == NULL) {
+		error = -ENOMEM;
+		goto err1;
+	}
+	snprintf(name_prefix, l+1, "%s%s_S.text_L", symprefix, mod->name);
+
+	for (i = mod->num_syms, sym = mod->syms; i > 0; --i, ++sym) {
+
+		if (strncmp(sym->name, name_prefix, l) == 0) {
+			unsigned long text_size;
+
+			text_size = simple_strtoul(sym->name + l, NULL, 10);
+
+			/* check .text size in ksym */
+			if (text_size > mod->core_size) { /* bug? */
+				printk(KERN_ERR
+					"%s: Invalid .text size in ksyms '%s'.\n",
+					__FUNCTION__, name_prefix);
+				kfree(name_prefix); /* temporary field */
+				error = -EINVAL;
+				goto err1;
+			}
+
+			/* set .text start address, .text size */
+			new_mprof->start_text = sym->value;
+			new_mprof->end_text = sym->value + text_size;
+			break;
+		}
+	}
+
+	/* if symbol "%s%s_S.text_L%d" is not registed in ksym,
+	   look on whole module as .text */
+	if (new_mprof->start_text == 0) {
+		printk(KERN_DEBUG "modprof: defaulting to entire module as .text:\n");
+#if 0
+		new_mprof->start_text = *((unsigned long *)&mod);
+		new_mprof->end_text = *((unsigned long *)&mod)
+					+ mod->core_size
+					/*- sizeof(struct module)*/;
+#endif
+#if 1
+		new_mprof->start_text = (unsigned long)mod->module_core;
+		new_mprof->end_text = (unsigned long)mod->module_core
+					+ mod->core_size
+					/*- sizeof(struct module)*/;
+#endif
+	}
+	/* determine module profile buffer size */
+	new_mprof->prof_len =
+		((new_mprof->end_text - new_mprof->start_text) >> prof_shift);
+	new_mprof->module = mod;
+	kfree(name_prefix);	/* temporary field */
+	buffer_size = new_mprof->prof_len * sizeof(unsigned int);
+
+	/*
+	 * alloc memory for module_profiling buffer
+	 */
+	new_mprof->prof_buffer = vmalloc(buffer_size);
+	if (new_mprof->prof_buffer == NULL) {
+		error = -ENOMEM;
+		goto err1;
+	}
+	memset(new_mprof->prof_buffer, 0, buffer_size);
+
+	/*
+	 * create /proc/mprof/$(mod->name)_profile
+	*/
+	new_mprof->proc_name = get_profile_name(mod);
+	if (new_mprof->proc_name == NULL) {
+		error = -ENOMEM;
+		goto err2;
+	}
+
+	/* create proc-entry /proc/mprof/$(mod->name)_profile */
+	entry = create_proc_entry(new_mprof->proc_name, S_IWUSR|S_IRUGO,
+					proc_root_mprof);
+	if (entry) {
+		entry->proc_fops = &proc_mprof_operations;
+		entry->size = buffer_size;
+	} else {
+		error = -ENOMEM;
+		/* in other cause, incorrect parameter */
+		goto err3;
+	}
+
+	/*
+	 * insert new module_profile into module_profile chains
+	 */
+	mprof_head = &module_profile_info->mprof_head;
+	write_lock(&module_profile_info->rwlock);
+
+	list_for_each(tmp, mprof_head) {
+		mprof = list_entry(tmp, struct module_profile, list);
+
+		if (new_mprof->end_text < mprof->end_text) {
+			/* insert previous module_profile */
+			spin_lock_irqsave(&module_profile_lock, flags);
+			list_add(&new_mprof->list, &mprof->list);
+			spin_unlock_irqrestore(&module_profile_lock, flags);
+			break;
+		}
+	}
+	if (tmp == mprof_head) {
+		/* if not hit, place new_prof at tail of chain */
+		spin_lock_irqsave(&module_profile_lock, flags);
+		list_add_tail(&new_mprof->list, mprof_head);
+		spin_unlock_irqrestore(&module_profile_lock, flags);
+	}
+
+	write_unlock(&module_profile_info->rwlock);
+
+	/* normal end */
+	goto err0;
+
+err3:
+	kfree(new_mprof->proc_name);
+err2:
+	vfree(new_mprof->prof_buffer);
+err1:
+	kfree(new_mprof);
+err0:
+	return error;
+}
+
+/*
+ * delete module profiling buffer
+ */
+void delete_module_profile(struct module *mod)
+{
+	struct list_head *mprof_head, *tmp;
+	struct module_profile *mprof = NULL;
+	unsigned long flags;
+	size_t name_len;
+
+	if (proc_root_mprof == NULL) {
+		/* profile maybe not specified on boot option */
+		return;
+	}
+
+	name_len = strlen(mod->name);
+
+	/* check module profile */
+	mprof_head = &module_profile_info->mprof_head;
+	read_lock(&module_profile_info->rwlock);
+
+	list_for_each(tmp, mprof_head) {
+		mprof = list_entry(tmp, struct module_profile, list);
+		if (strncmp(mprof->proc_name, mod->name, name_len) == 0 &&
+		    strcmp(mprof->proc_name + name_len, "_profile") == 0) {
+			/* find module profiling buffer ! */
+			break;
+		}
+	}
+
+	read_unlock(&module_profile_info->rwlock);
+
+	/* no module profiling buffer */
+	if (tmp == mprof_head) {
+		printk(KERN_WARNING "delete_module_profile: "
+			"no profiling buffer for module(%s).\n", mod->name);
+		return;
+	}
+
+	/* remove proc-file */
+	remove_proc_entry(mprof->proc_name, proc_root_mprof);
+
+	/* unchain module_profile */
+	write_lock(&module_profile_info->rwlock);
+	spin_lock_irqsave(&module_profile_lock, flags);
+
+	list_del(&mprof->list);
+
+	spin_unlock_irqrestore(&module_profile_lock, flags);
+	write_unlock(&module_profile_info->rwlock);
+
+	/* free memory */
+	kfree(mprof->proc_name);
+	vfree(mprof->prof_buffer);
+	kfree(mprof);
+}
+
+/*
+ * Caller must lock rwlock field into module_profile_info,
+ * for read or write operation.
+ */
+static struct module_profile *search_module_profile(char *profile_name)
+{
+	struct list_head *mprof_head, *tmp;
+	struct module_profile *mprof = NULL;
+
+	mprof_head = &module_profile_info->mprof_head;
+	list_for_each(tmp, mprof_head) {
+		mprof = list_entry(tmp, struct module_profile, list);
+
+		if (strcmp(mprof->proc_name, profile_name) == 0)
+			break;
+	}
+	if (tmp == mprof_head)
+		mprof = NULL;
+	return mprof;
+}
+
+/*
+ * This function accesses module profiling information. The returned data
+ * is binary: the actual contents of the profile buffer.
+ * Use of the program readprofile is recommended in order to
+ * get meaningful info out of these data.
+ */
+static ssize_t read_module_profile(struct file *file, char *buf,
+					size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	struct module_profile *mprof;
+
+	read_lock(&module_profile_info->rwlock);
+
+	/* search module profiling buffer */
+	mprof = search_module_profile((char *)file->f_dentry->d_name.name);
+	if (!mprof) {
+		printk(KERN_DEBUG "read_module_profile: search_module_profile failed\n");
+		/* module profile is already removed ? */
+		read_unlock(&module_profile_info->rwlock);
+		return -ENXIO;
+	}
+
+	/* check file offset */
+	if (p >= (mprof->prof_len * sizeof(unsigned int))) {
+		read_unlock(&module_profile_info->rwlock);
+		return 0;
+	}
+
+	/* copy profiling contents */
+	if (count > (mprof->prof_len * sizeof(unsigned int) - p))
+		count = mprof->prof_len * sizeof(unsigned int) - p;
+
+	copy_to_user(buf, (char *)mprof->prof_buffer + p, count);
+
+	read_unlock(&module_profile_info->rwlock);
+
+	*ppos += count;
+	return count;
+}
+
+static void reset_module_profiles(void)
+{
+	struct module_profile *mprof;
+	struct list_head *mprof_head, *tmp;
+
+	mprof_head = &module_profile_info->mprof_head;
+
+	write_lock(&module_profile_info->rwlock);
+
+	list_for_each(tmp, mprof_head) {
+		mprof = list_entry(tmp, struct module_profile, list);
+
+		/* zero-clear module profiling buffer */
+		memset(mprof->prof_buffer, 0,
+			mprof->prof_len * sizeof(*mprof->prof_buffer));
+	}
+
+	write_unlock(&module_profile_info->rwlock);
+}
+
+struct file_operations proc_mprof_operations = {
+	.read =		read_module_profile,
+};
+
+#endif	/* CONFIG_MODULE_PROFILE */
+
+/*
+ * This function accesses profiling information. The returned data is
+ * binary: the sampling step and the actual contents of the profile
+ * buffer. Use of the program readprofile is recommended in order to
+ * get meaningful info out of these data.
+ */
+ssize_t read_profile(struct file *file, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	ssize_t read;
+	char * pnt;
+	unsigned int sample_step = 1 << prof_shift;
+
+	if (p >= (prof_len + 1) * sizeof(unsigned int))
+		return 0;
+	if (count > (prof_len + 1) * sizeof(unsigned int) - p)
+		count = (prof_len + 1) * sizeof(unsigned int) - p;
+	read = 0;
+
+	while (p < sizeof(unsigned int) && count > 0) {
+		put_user(*((char *)(&sample_step) + p), buf);
+		buf++; p++; count--; read++;
+	}
+	pnt = (char *)prof_buffer + p - sizeof(unsigned int);
+	copy_to_user(buf,(void *)pnt, count);
+	read += count;
+	*ppos += read;
+	return read;
+}
+
+/*
+ * Writing to /proc/profile resets the counters
+ *
+ * Writing a 'profiling multiplier' value into it also re-sets the profiling
+ * interrupt frequency, on architectures that support this.
+ */
+ssize_t write_profile(struct file * file, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+#ifdef CONFIG_SMP
+	extern int setup_profiling_timer (unsigned int multiplier);
+
+	if (count == sizeof(int)) {
+		unsigned int multiplier;
+
+		if (copy_from_user(&multiplier, buf, sizeof(int)))
+			return -EFAULT;
+
+		if (setup_profiling_timer(multiplier))
+			return -EINVAL;
+	}
+#endif
+
+	memset(prof_buffer, 0, prof_len * sizeof(*prof_buffer));
+
+#ifdef CONFIG_MODULE_PROFILE
+	reset_module_profiles();
+#endif
+	return count;
+}
+
+struct file_operations proc_profile_operations = {
+	.read =		read_profile,
+	.write =	write_profile,
+};
+
 #endif /* CONFIG_PROFILING */
 
 EXPORT_SYMBOL_GPL(profile_event_register);
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-pv/scripts/kallsyms.c linux-266-modprof/scripts/kallsyms.c
--- linux-266-pv/scripts/kallsyms.c	2004-05-09 19:33:21.000000000 -0700
+++ linux-266-modprof/scripts/kallsyms.c	2004-05-10 16:01:02.000000000 -0700
@@ -115,7 +115,10 @@ write_src(void)
 		if (!symbol_valid(&table[i]))
 			continue;
 		
-		if (table[i].addr == last_addr)
+		if (table[i].addr == last_addr &&
+		    last_addr != _etext)
+			/* don't duplicate addresses, except always
+			 * make sure that _etext is in kallsyms */
 			continue;
 
 		printf("\tPTR\t%#llx\n", table[i].addr);
@@ -140,7 +143,8 @@ write_src(void)
 		if (!symbol_valid(&table[i]))
 			continue;
 		
-		if (table[i].addr == last_addr)
+		if (table[i].addr == last_addr &&
+		    last_addr != _etext)
 			continue;
 
 		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
