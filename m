Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311757AbSCTIF7>; Wed, 20 Mar 2002 03:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311753AbSCTIFr>; Wed, 20 Mar 2002 03:05:47 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:63364 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S311752AbSCTIF2>; Wed, 20 Mar 2002 03:05:28 -0500
Date: Wed, 20 Mar 2002 17:04:08 +0900
From: hirao <hirao@estartu.open.nm.fujitsu.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] enhance kernel profiling to loadable modules
Cc: hirao@estartu.open.nm.fujitsu.co.jp
Message-Id: <20020320165324.E98F.HIRAO@estartu.open.nm.fujitsu.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

These are a kernel patch I wrote to enhance kernel profiling to loadable modules and
a patch which adds a new command READPROFILE to util-linux.
The kernel patch is for v2.4.18, and the command patch is for util-linux-2.11o.


===============================================================================
Installation
===============================================================================

1. Kernel

1.1) Apply kernel patch.

  $ patch -p1 -d linux < moduleprofile-v0.3-v2.4.18.patch

1.2) Enable module profile.

     Set Menu [Kernel Hacking][Module profiling support] to Y.

1.3) Set kernel boot option.

   When you use LILO for the boot loader, add append="profile=N" just same
 as original profiler.

2. Command

2.1) Apply util-linux patch.

  $ patch -p1 -d util-linux < readprofile2-v0.2-v2.11o.patch

===============================================================================
Retrieving profile
===============================================================================

The kernel profile is retrieved by a new command READPROFILE.

When the system map of the kernel is /usr/src/linux/System.map, execute command

  $ READPROFILE

or specify mapfile

  $ READPROFILE -m mapfile

Excerpt of execution example.
---------------------------------------------------------------------->
     4 rest_init                                            0.0476
…
    13 [jbd]start_this_handle                               0.0361
…
     3 [ext3]ext3_get_group_desc                            0.0234
…

total:
  1326 kernel                                               0.0012
   673 jbd                                                  0.0246
   396 ext3                                                 0.0091
<----------------------------------------------------------------------

begin of moduleprofile-v0.3-v2.4.18.patch --->

diff -Naur linux-2.4.18/arch/i386/config.in
linux-2.4.18new/arch/i386/config.in
--- linux-2.4.18/arch/i386/config.in	Tue Feb 26 04:37:52 2002
+++ linux-2.4.18new/arch/i386/config.in	Mon Mar 18 11:31:24 2002
@@ -422,6 +422,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
+   bool '  module profiling support' CONFIG_MODULE_PROFILE
 fi
 
 endmenu
diff -Naur linux-2.4.18/fs/proc/proc_misc.c linux-2.4.18new/fs/proc/proc_misc.c
--- linux-2.4.18/fs/proc/proc_misc.c	Wed Nov 21 14:29:09 2001
+++ linux-2.4.18new/fs/proc/proc_misc.c	Mon Mar 18 11:31:24 2002
@@ -410,69 +410,6 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-/*
- * This function accesses profiling information. The returned data is
- * binary: the sampling step and the actual contents of the profile
- * buffer. Use of the program readprofile is recommended in order to
- * get meaningful info out of these data.
- */
-static ssize_t read_profile(struct file *file, char *buf,
-			    size_t count, loff_t *ppos)
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
-	copy_to_user(buf,(void *)pnt,count);
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
-static ssize_t write_profile(struct file * file, const char * buf,
-			     size_t count, loff_t *ppos)
-{
-#ifdef CONFIG_SMP
-	extern int setup_profiling_timer (unsigned int multiplier);
-
-	if (count==sizeof(int)) {
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
-	read:		read_profile,
-	write:		write_profile,
-};
-
 extern struct seq_operations mounts_op;
 static int mounts_open(struct inode *inode, struct file *file)
 {
@@ -487,6 +424,10 @@
 
 struct proc_dir_entry *proc_root_kcore;
 
+#ifdef CONFIG_MODULE_PROFILE	
+struct proc_dir_entry *proc_root_mprof;
+#endif
+
 static void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
 {
 	struct proc_dir_entry *entry;
@@ -547,11 +488,15 @@
 				(size_t)high_memory - PAGE_OFFSET + PAGE_SIZE;
 	}
 	if (prof_shift) {
+		extern struct file_operations proc_profile_operations;
 		entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL);
 		if (entry) {
 			entry->proc_fops = &proc_profile_operations;
 			entry->size = (1+prof_len) * sizeof(unsigned int);
 		}
+#ifdef CONFIG_MODULE_PROFILE	
+		proc_root_mprof = proc_mkdir("mprof",0);
+#endif
 	}
 #ifdef CONFIG_PPC32
 	{
diff -Naur linux-2.4.18/include/asm-i386/hw_irq.h linux-2.4.18new/include/asm-i386/hw_irq.h
--- linux-2.4.18/include/asm-i386/hw_irq.h	Fri Nov 23 04:46:18 2001
+++ linux-2.4.18new/include/asm-i386/hw_irq.h	Mon Mar 18 11:31:24 2002
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
+#include <linux/profile.h>
 
 /*
  * IDT vectors usable for external interrupt sources start
@@ -180,17 +181,16 @@
 	"pushl $"#nr"-256\n\t" \
 	"jmp common_interrupt");
 
-extern unsigned long prof_cpu_mask;
-extern unsigned int * prof_buffer;
-extern unsigned long prof_len;
-extern unsigned long prof_shift;
-
 /*
  * x86 profiling function, SMP safe. We might want to do this in
  * assembly totally?
  */
 static inline void x86_do_profile (unsigned long eip)
 {
+#ifdef CONFIG_MODULE_PROFILE
+	unsigned int * targ_prof_buffer;
+	unsigned long idx;
+#endif
 	if (!prof_buffer)
 		return;
 
@@ -201,16 +201,27 @@
 	if (!((1<<smp_processor_id()) & prof_cpu_mask))
 		return;
 
-	eip -= (unsigned long) &_stext;
-	eip >>= prof_shift;
+#ifdef CONFIG_MODULE_PROFILE
 	/*
-	 * Don't ignore out-of-bounds EIP values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
+	 * get profiling buffer address and offset
+	 * @pc	: program counter
+	 * @idx	: profiling buffer offset
 	 */
-	if (eip > prof_len-1)
-		eip = prof_len-1;
-	atomic_inc((atomic_t *)&prof_buffer[eip]);
+	targ_prof_buffer = srch_prof_buffer(eip,&idx);
+
+	atomic_inc((atomic_t *)&targ_prof_buffer[idx]);
+#else
+        eip -= (unsigned long) &_stext;
+        eip >>= prof_shift;
+        /*
+         * Don't ignore out-of-bounds EIP values silently,
+         * put them into the last histogram slot, so if
+         * present, they will show up as a sharp peak.
+         */
+        if (eip > prof_len-1)
+                eip = prof_len-1;
+        atomic_inc((atomic_t *)&prof_buffer[eip]);
+#endif
 }
 
 #ifdef CONFIG_SMP /*more of this file should probably be ifdefed SMP */
diff -Naur linux-2.4.18/include/linux/proc_fs.h linux-2.4.18new/include/linux/proc_fs.h
--- linux-2.4.18/include/linux/proc_fs.h	Fri Nov 23 04:46:23 2001
+++ linux-2.4.18new/include/linux/proc_fs.h	Mon Mar 18 11:31:24 2002
@@ -82,6 +82,7 @@
 extern struct proc_dir_entry *proc_bus;
 extern struct proc_dir_entry *proc_root_driver;
 extern struct proc_dir_entry *proc_root_kcore;
+extern struct proc_dir_entry *proc_root_mprof;
 
 extern void proc_root_init(void);
 extern void proc_misc_init(void);
@@ -113,6 +114,7 @@
 extern struct file_operations proc_kcore_operations;
 extern struct file_operations proc_kmsg_operations;
 extern struct file_operations ppc_htab_operations;
+extern struct file_operations proc_mprof_operations;
 
 /*
  * proc_tty.c
diff -Naur linux-2.4.18/include/linux/profile.h linux-2.4.18new/include/linux/profile.h
--- linux-2.4.18/include/linux/profile.h	Thu Jan  1 09:00:00 1970
+++ linux-2.4.18new/include/linux/profile.h	Mon Mar 18 11:31:24 2002
@@ -0,0 +1,100 @@
+/*
+ * kernel and module profile.
+ */
+
+#ifndef _LINUX_PROFILE_H
+#define _LINUX_PROFILE_H
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+
+extern char _stext, _etext;
+extern unsigned long prof_cpu_mask;
+extern unsigned int * prof_buffer;
+extern unsigned long prof_len;
+extern unsigned long prof_shift;
+
+
+struct module_profile
+{
+        char *proc_name;
+        struct list_head list;
+        unsigned long prof_len;
+        unsigned long start_text;
+        unsigned long end_text;
+        unsigned int *prof_buffer;
+        struct module *module;
+};
+
+/* module profile root infomation */
+struct mprof_info
+{
+	rwlock_t rwlock;
+        struct list_head mprof_head;
+};
+
+char *get_profile_name(struct module *mod);
+int create_module_profile(struct module *mod);
+void delete_module_profile(struct module *mod);
+
+extern struct mprof_info *module_profile_info;
+
+
+/*
+ * called by profiling functions
+ */
+static inline unsigned int *
+srch_module_prof_buffer(unsigned long pc, unsigned long *idx)
+{
+        struct list_head *tmp;
+	struct module_profile *mprof;
+
+        /*
+         * look for module_profile_buffer address with PC
+         * into module_profile list chains
+         */
+        list_for_each(tmp, &module_profile_info->mprof_head) {
+                mprof = list_entry(tmp, struct module_profile, list);
+
+                if(mprof->start_text <= pc && pc < mprof->end_text){
+                        /* hit */
+                        pc -= mprof->start_text;
+                        *idx = (pc >> prof_shift);
+                        return (mprof->prof_buffer);
+                }
+        }
+
+	/* mprof==NULL: no module profiling buffer */
+	*idx = prof_len-2;
+	return (prof_buffer);
+}
+
+static inline unsigned int *
+srch_prof_buffer(unsigned long pc, unsigned long *idx)
+{
+        unsigned int *targ_prof_buffer = prof_buffer;
+
+	/*
+	 * Don't ignore out-of-bounds PC values silently,
+	 * put them into the last histogram slot, so if
+	 * present, they will show up as a sharp peak.
+	 */
+	if(pc < (unsigned long)&_stext){
+		/* out of kernel .text, and out of module .text */
+		*idx = prof_len-1;
+        }else if(pc < (unsigned long)&_etext){
+                /* kernel profile */
+                pc -= (unsigned long) &_stext;
+                pc >>= prof_shift;
+                *idx = pc;
+        }else{
+                targ_prof_buffer = srch_module_prof_buffer(pc,idx);
+        }
+        return targ_prof_buffer;
+}
+
+#endif /* _LINUX_PROFILE_H */
+
diff -Naur linux-2.4.18/kernel/Makefile linux-2.4.18new/kernel/Makefile
--- linux-2.4.18/kernel/Makefile	Mon Sep 17 13:22:40 2001
+++ linux-2.4.18new/kernel/Makefile	Mon Mar 18 11:31:24 2002
@@ -14,7 +14,7 @@
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o profile.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -Naur linux-2.4.18/kernel/module.c linux-2.4.18new/kernel/module.c
--- linux-2.4.18/kernel/module.c	Mon Nov 12 04:23:14 2001
+++ linux-2.4.18new/kernel/module.c	Mon Mar 18 11:31:24 2002
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/seq_file.h>
+#include <linux/profile.h>
 
 /*
  * Originally by Anonymous (as far as I know...)
@@ -530,6 +531,13 @@
 		}
 	}
 
+#ifdef CONFIG_MODULE_PROFILE
+	if (create_module_profile(mod)) {
+		printk(KERN_WARNING "init_module: creation of module "
+			"profiling buffer failed for module(%s).\n", mod->name);
+	}
+#endif
+
 	/* Update module references.  */
 	for (i = 0, dep = mod->deps; i < mod->ndeps; ++i, ++dep) {
 		struct module *d = dep->dep;
@@ -618,6 +626,9 @@
 
 		spin_lock(&unload_lock);
 		if (!__MOD_IN_USE(mod)) {
+#ifdef CONFIG_MODULE_PROFILE
+			delete_module_profile(mod);
+#endif
 			mod->flags |= MOD_DELETED;
 			spin_unlock(&unload_lock);
 			free_module(mod, 0);
@@ -646,6 +657,9 @@
 				spin_unlock(&unload_lock);
 				mod->flags &= ~MOD_VISITED;
 			} else {
+#ifdef CONFIG_MODULE_PROFILE
+				delete_module_profile(mod);
+#endif
 				mod->flags |= MOD_DELETED;
 				spin_unlock(&unload_lock);
 				free_module(mod, 1);
diff -Naur linux-2.4.18/kernel/profile.c linux-2.4.18new/kernel/profile.c
--- linux-2.4.18/kernel/profile.c	Thu Jan  1 09:00:00 1970
+++ linux-2.4.18new/kernel/profile.c	Mon Mar 18 11:31:24 2002
@@ -0,0 +1,412 @@
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+#include <linux/vmalloc.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+#include <linux/profile.h>
+
+
+static spinlock_t module_profile_lock = SPIN_LOCK_UNLOCKED;
+
+static struct mprof_info mprof_info = {
+	rwlock:	RW_LOCK_UNLOCKED,
+        mprof_head: LIST_HEAD_INIT(mprof_info.mprof_head),
+};
+struct mprof_info *module_profile_info = &mprof_info;
+
+
+#ifdef CONFIG_MODULE_PROFILE
+/*
+ * determine profile name by given module,
+ * alloc memoey for profile name, and set profile name
+ */
+char *get_profile_name(struct module *mod)
+{
+	char *proc_name;
+        int l;
+
+        /* construct module-profile-name */
+        l = strlen(mod->name)+  /* module name */
+            8;                  /* "_profile" */
+	proc_name = kmalloc(l + 1, GFP_KERNEL);
+        if (proc_name) {
+        	snprintf(proc_name, l+1, "%s_profile", mod->name);
+        }
+	return proc_name;
+}
+
+/*
+ * create module profile for specified module
+ */
+int create_module_profile(struct module *mod)
+{
+        struct module_symbol *sym;
+        char *name_prefix;
+        int i, l;
+        struct list_head *mprof_head, *tmp;
+        struct module_profile *new_mprof, *mprof;
+        struct proc_dir_entry *entry;
+        long error = 0;
+        unsigned long flags, buffer_size;
+	const char symprefix[] = "__insmod_";
+
+        if (proc_root_mprof == NULL) {
+		/* profile maybe not specified on boot option */
+                goto err0;
+	}
+
+        /* get memory for struct module_profile */
+        new_mprof = kmalloc(sizeof(struct module_profile), GFP_KERNEL);
+        if (new_mprof == NULL) {
+                error = -ENOMEM;
+                goto err0;
+        }
+        memset(new_mprof, 0, sizeof(*new_mprof));
+
+        /*
+         * research .text start address and .text size in ksym,
+         * set module profiling information for this module in module_profile.
+         */
+        l = sizeof(symprefix) -1 +  /* "__insmod_" (have NULL) */
+            strlen(mod->name)+  /* module name */
+            2+                  /* "_S" */
+            5+                  /* section name".text" */
+            2;                  /* "_L" */
+        name_prefix = kmalloc(l + 1, GFP_KERNEL);
+        if (name_prefix == NULL) {
+                error = -ENOMEM;
+                goto err1;
+        }
+        snprintf(name_prefix, l+1, "%s%s_S.text_L", symprefix, mod->name);
+
+        for (i = mod->nsyms, sym = mod->syms; i > 0; --i, ++sym) {
+
+                if (strncmp(sym->name, name_prefix, l) == 0) {
+                        unsigned long text_size;
+
+                        text_size = simple_strtoul(sym->name + l, NULL, 10);
+
+                        /* check .text size in ksym */
+                        if (text_size > mod->size) {
+                                /* bug? */
+                                printk(KERN_ERR
+					"create_mprofile: Invalid .text size in ksyms '%s'.\n",
+                                        name_prefix);
+        			kfree(name_prefix); /* temporary field */
+                                error = -EINVAL;
+                                goto err1;
+                        }
+
+                        /* set .text start address, .text size */
+                        new_mprof->start_text = sym->value;
+                        new_mprof->end_text = sym->value + text_size;
+
+                        break;
+                }
+        }
+
+        /* if symbol "%s%s_S.text_L%d" is not registed in ksym,
+           look on whole module as .text */
+	if (new_mprof->start_text == 0) {
+                new_mprof->start_text = *((unsigned long *)&mod);
+                new_mprof->end_text = *((unsigned long *)&mod) + 
+					mod->size - mod->size_of_struct;
+        }
+        /* determine module profile buffer size */
+        new_mprof->prof_len =
+                ((new_mprof->end_text - new_mprof->start_text) >> prof_shift);
+        new_mprof->module = mod;
+        kfree(name_prefix); /* temporary field */
+	buffer_size = new_mprof->prof_len * sizeof(unsigned int);
+
+        /*
+         * alloc memory for module_profiling buffer
+         */
+        new_mprof->prof_buffer = vmalloc(buffer_size);
+        if (new_mprof->prof_buffer == NULL) {
+                error = -ENOMEM;
+                goto err1;
+        }
+        memset(new_mprof->prof_buffer, 0, buffer_size);
+
+
+        /*
+         * create /proc/mprof/$(mod->name)_profile
+         */
+        new_mprof->proc_name = get_profile_name(mod);
+        if (new_mprof->proc_name == NULL) {
+                error = -ENOMEM;
+                goto err2;
+        }
+
+        /* create proc-entry /proc/mprof/$(mod->name)_profile */
+        entry = create_proc_entry(new_mprof->proc_name, S_IWUSR|S_IRUGO,
+				  proc_root_mprof);
+        if (entry) {
+		entry->proc_fops = &proc_mprof_operations;
+                entry->size = buffer_size;
+        } else {
+                error = -ENOMEM;
+                /* in other cause, incorrect parameter */
+                goto err3;
+        }
+
+
+        /*
+         * insert new module_profile into module_profile chains
+         */
+	mprof_head = &module_profile_info->mprof_head;
+        write_lock(&module_profile_info->rwlock);
+
+        list_for_each(tmp, mprof_head) {
+                mprof = list_entry(tmp, struct module_profile, list);
+
+                if (new_mprof->end_text < mprof->end_text) {
+
+                        /* insert previous module_profile */
+        		spin_lock_irqsave(&module_profile_lock, flags);
+			list_add(&new_mprof->list, &mprof->list);
+        		spin_unlock_irqrestore(&module_profile_lock, flags);
+                        break;
+                }
+        }
+        if (tmp == mprof_head) {
+                /* if not hit, place new_prof at tail of chain */
+       		spin_lock_irqsave(&module_profile_lock, flags);
+		list_add_tail(&new_mprof->list, mprof_head);
+        	spin_unlock_irqrestore(&module_profile_lock, flags);
+        }
+
+        write_unlock(&module_profile_info->rwlock);
+
+        /* normal end */
+        goto err0;
+
+err3:
+        kfree(new_mprof->proc_name);
+err2:
+        vfree(new_mprof->prof_buffer);
+err1:
+        kfree(new_mprof);
+err0:
+        return error;
+}
+
+/*
+ * delete module profiling buffer
+ */
+void delete_module_profile(struct module *mod)
+{
+        struct list_head *mprof_head, *tmp;
+        struct module_profile *mprof = NULL;
+        unsigned long flags;
+	size_t name_len;
+
+        if (proc_root_mprof == NULL) {
+		/* profile maybe not specified on boot option */
+		return;
+	}
+
+	name_len = strlen(mod->name);
+
+	/* check module profile */
+	mprof_head = &module_profile_info->mprof_head;
+        read_lock(&module_profile_info->rwlock);
+
+        list_for_each(tmp, mprof_head) {
+                mprof = list_entry(tmp, struct module_profile, list);
+                if (strncmp(mprof->proc_name, mod->name, name_len) == 0 &&
+		    strcmp(mprof->proc_name + name_len, "_profile") == 0)  {
+
+			/* find module profiling buffer ! */
+			break;
+		}
+	}
+
+        read_unlock(&module_profile_info->rwlock);
+
+	/* no module profiling buffer */
+        if (tmp == mprof_head) {
+                printk(KERN_WARNING "delete_module_profile: "
+                        "no profiling buffer for module(%s).\n", mod->name);
+		return;
+	}
+
+        /* remove proc-file */
+        remove_proc_entry(mprof->proc_name, proc_root_mprof);
+
+        /* unchain module_profile */
+        write_lock(&module_profile_info->rwlock);
+        spin_lock_irqsave(&module_profile_lock, flags);
+
+	list_del(&mprof->list);
+
+        spin_unlock_irqrestore(&module_profile_lock, flags);
+        write_unlock(&module_profile_info->rwlock);
+
+        /* free memory */
+        kfree(mprof->proc_name);
+        vfree(mprof->prof_buffer);
+        kfree(mprof);
+
+        return;
+}
+
+/*
+ * Caller must lock rwlock field into module_profile_info,
+ * for read or write operation.
+ */
+static struct module_profile *search_module_profile(char *profile_name)
+{
+        struct list_head *mprof_head, *tmp;
+        struct module_profile *mprof = NULL;
+
+        mprof_head = &module_profile_info->mprof_head;
+        list_for_each(tmp, mprof_head) {
+                mprof = list_entry(tmp, struct module_profile, list);
+
+                if(strcmp(mprof->proc_name,profile_name) == 0){
+                        break;
+                }
+        }
+        if (tmp == mprof_head) {
+                mprof = NULL;
+        }
+        return mprof;
+}
+
+/*
+ * This function accesses module profiling information. The returned data is
+ * binary: the actual contents of the profile buffer.
+ * Use of the program readprofile is recommended in order to
+ * get meaningful info out of these data.
+ */
+static ssize_t read_module_profile(struct file *file, char *buf,
+                            size_t count, loff_t *ppos)
+{
+        unsigned long p = *ppos;
+        struct module_profile *mprof;
+
+        read_lock(&module_profile_info->rwlock);
+
+        /* search module profiling buffer */
+        mprof = search_module_profile((char *)file->f_dentry->d_name.name);
+        if (!mprof){
+                /* module profile is already removed ? */
+                read_unlock(&module_profile_info->rwlock);
+                return -ENXIO;
+        }
+
+        /* check file offset */
+        if (p >= (mprof->prof_len * sizeof(unsigned int))){
+                read_unlock(&module_profile_info->rwlock);
+                return 0;
+        }
+
+        /* copy profiling contents */
+        if (count > (mprof->prof_len * sizeof(unsigned int) - p))
+                count = mprof->prof_len * sizeof(unsigned int) - p;
+
+        copy_to_user(buf, (char *)mprof->prof_buffer + p, count);
+
+        read_unlock(&module_profile_info->rwlock);
+
+        *ppos += count;
+        return count;
+}
+
+static void reset_module_profiles(void)
+{
+        struct module_profile *mprof;
+        struct list_head *mprof_head, *tmp;
+
+        mprof_head = &module_profile_info->mprof_head;
+
+        write_lock(&module_profile_info->rwlock);
+
+        list_for_each(tmp, mprof_head) {
+                mprof = list_entry(tmp, struct module_profile, list);
+
+	        /* zero-clear module profiling buffer */
+	        memset(mprof->prof_buffer, 0,
+		       mprof->prof_len * sizeof(*mprof->prof_buffer));
+        }
+
+        write_unlock(&module_profile_info->rwlock);
+
+        return;
+}
+
+struct file_operations proc_mprof_operations = {
+        read:           read_module_profile,
+};
+#endif
+
+/*
+ * This function accesses profiling information. The returned data is
+ * binary: the sampling step and the actual contents of the profile
+ * buffer. Use of the program readprofile is recommended in order to
+ * get meaningful info out of these data.
+ */
+ssize_t read_profile(struct file *file, char *buf,
+		     size_t count, loff_t *ppos)
+{
+        unsigned long p = *ppos;
+        ssize_t read;
+        char * pnt;
+        unsigned int sample_step = 1 << prof_shift;
+
+        if (p >= (prof_len+1)*sizeof(unsigned int))
+                return 0;
+        if (count > (prof_len+1)*sizeof(unsigned int) - p)
+                count = (prof_len+1)*sizeof(unsigned int) - p;
+        read = 0;
+
+        while (p < sizeof(unsigned int) && count > 0) {
+                put_user(*((char *)(&sample_step)+p),buf);
+                buf++; p++; count--; read++;
+        }
+        pnt = (char *)prof_buffer + p - sizeof(unsigned int);
+        copy_to_user(buf,(void *)pnt,count);
+        read += count;
+        *ppos += read;
+        return read;
+}
+
+/*
+ * Writing to /proc/profile resets the counters
+ *
+ * Writing a 'profiling multiplier' value into it also re-sets the profiling
+ * interrupt frequency, on architectures that support this.
+ */
+ssize_t write_profile(struct file * file, const char * buf,
+		      size_t count, loff_t *ppos)
+{
+#ifdef CONFIG_SMP
+        extern int setup_profiling_timer (unsigned int multiplier);
+
+        if (count==sizeof(int)) {
+                unsigned int multiplier;
+
+                if (copy_from_user(&multiplier, buf, sizeof(int)))
+                        return -EFAULT;
+
+                if (setup_profiling_timer(multiplier))
+                        return -EINVAL;
+        }
+#endif
+
+        memset(prof_buffer, 0, prof_len * sizeof(*prof_buffer));
+
+#ifdef CONFIG_MODULE_PROFILE
+	reset_module_profiles();
+#endif
+        return count;
+}
+
+struct file_operations proc_profile_operations = {
+        read:           read_profile,
+        write:          write_profile,
+};

<-- end of moduleprofile-v0.3-v2.4.18.patch

begin of readprofile2-v0.2-v2.11o.patch --->

diff -Naur util-linux-2.11o/sys-utils/Makefile
util-linux-2.11onew/sys-utils/Makefile
--- util-linux-2.11o/sys-utils/Makefile	Sat Nov 10 02:13:50 2001
+++ util-linux-2.11onew/sys-utils/Makefile	Fri Mar 15 19:21:45 2002
@@ -21,7 +21,7 @@
 
 USRBIN=		cytune ipcrm ipcs renice setsid
 
-USRSBIN=	readprofile tunelp
+USRSBIN=	readprofile readprofile2 READPROFILE tunelp
 
 SBIN= 		ctrlaltdel
 
@@ -64,6 +64,10 @@
 nosln:
 	@echo sln not made since static compilation fails here
 
+%: %.sh
+	cp $@.sh $@
+	chmod 755 $@
+
 # Rules for everything else
 
 arch: arch.o
@@ -75,6 +79,7 @@
 rdev: rdev.o
 renice: renice.o
 readprofile: readprofile.o
+readprofile2: readprofile2.o
 setsid: setsid.o
 
 ipc.info: ipc.texi
diff -Naur util-linux-2.11o/sys-utils/READPROFILE.sh util-linux-2.11onew/sys-utils/READPROFILE.sh
--- util-linux-2.11o/sys-utils/READPROFILE.sh	Thu Jan  1 09:00:00 1970
+++ util-linux-2.11onew/sys-utils/READPROFILE.sh	Fri Mar 15 19:21:45 2002
@@ -0,0 +1,41 @@
+#!/bin/bash
+
+USRSBIN=/usr/sbin
+DEFAULTMAP="/usr/src/linux/System.map"
+NEWMAP="/tmp/System_incmod.map"
+
+map_cnv=yes
+while getopts ":m:p:M:ivarVt" opt; do
+	case $opt in
+		m )	old_map=$OPTARG
+			map_cnt=$(($map_cnt + 1))
+			new_args="$new_args -m $NEWMAP" ;;
+		p )	new_args="$new_args -$opt $OPTARG" ;;
+		v | a )	new_args="$new_args -$opt" ;;
+		M )	new_args="$new_args -$opt $OPTARG"
+			map_cnv=no ;;
+		* )	new_args="$new_args -$opt"
+			map_cnv=no ;;
+	esac
+done
+
+if [ $map_cnv = yes ]; then
+	if [ -z $old_map ]; then
+		if [ -f $DEFAULTMAP ]; then
+			ksymoops -s $NEWMAP -m $DEFAULTMAP < /dev/null &> /dev/null
+			new_args="$* -m $NEWMAP"
+		else
+			new_args=$*
+		fi
+	else
+		if [ $map_cnt = 1 ] && [ -f $old_map ]; then
+			ksymoops -s $NEWMAP -m $old_map < /dev/null &> /dev/null
+		else
+			new_args=$*
+		fi
+	fi
+else
+	new_args=$*
+fi
+
+readprofile2 $new_args
diff -Naur util-linux-2.11o/sys-utils/readprofile2.c util-linux-2.11onew/sys-utils/readprofile2.c
--- util-linux-2.11o/sys-utils/readprofile2.c	Thu Jan  1 09:00:00 1970
+++ util-linux-2.11onew/sys-utils/readprofile2.c	Fri Mar 15 19:21:45 2002
@@ -0,0 +1,651 @@
+/*
+ *  readprofile2.c - used to read /proc/profile
+ * 			 and /proc/mprof=/${module_name}_profile
+ *
+ *  Copyright (C) 1994,1996 Alessandro Rubini (rubini@ipvvis.unipv.it)
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * 1999-02-22 Arkadiusz Miカ・ewicz <misiek@pld.ORG.PL>
+ * - added Native Language Support
+ * 1999-09-01 Stephane Eranian <eranian@cello.hpl.hp.com>
+ * - 64bit clean patch
+ * 3Feb2001 Andrew Morton <andrewm@uow.edu.au>
+ * - -M option to write profile multiplier.
+ * 2102-01-20 Yoshinori Hirao <hirao@estaru.open.nm.fujitsu.co.jp>
+ * - added Module Profiling Support
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include "nls.h"
+
+#define RELEASE "2.0, May 1996"
+
+#define S_LEN 128
+
+#define TEST
+
+static char *prgname;
+
+/* These are the defaults */
+static char defaultmap[]="/usr/src/linux/System.map";
+static char defaultpro[]="/proc/profile";
+static char mprof_procdir[]="/proc/mprof";
+static char optstring[]="M:m:p:itvarV";
+
+struct profile_list
+{
+        struct profile_list *nxt;
+        struct profile_list *prv;
+        char *mod_name;
+        char *profile_name;
+        unsigned long len;
+        unsigned int *buf;
+        unsigned long start_text;
+        unsigned long cnt_total;
+        unsigned long cdsz_total;
+};
+
+static void
+usage(void) {
+  fprintf(stderr,
+		  _("%s: Usage: \"%s [options]\n"
+		  "\t -m <mapfile>  (default = \"%s\")\n"
+		  "\t -p <pro-file> (default = \"%s\")\n"
+		  "\t -M <mult>     set the profiling multiplier to <mult>\n"
+		  "\t -i            print only info about the sampling step\n"
+		  "\t -v            print verbose data\n"
+		  "\t -a            print all symbols, even if count is 0\n"
+		  "\t -r            reset all the counters (root only)\n"
+                  "\t -V            print version and exit\n")
+		  ,prgname,prgname,defaultmap,defaultpro);
+  exit(1);
+}
+
+static void *
+xmalloc (size_t size) {
+	void *t;
+
+	if (size == 0)
+		return NULL;
+
+	t = malloc (size);
+	if (t == NULL) {
+		fprintf(stderr, _("out of memory"));
+		exit(1);
+	}
+
+	return t;
+}
+
+static FILE *
+myopen(char *name, char *mode, int *flag) {
+	int len = strlen(name);
+
+	if (!strcmp(name+len-3,".gz")) {
+		FILE *res;
+		char *cmdline = xmalloc(len+6);
+		sprintf(cmdline, "zcat %s", name);
+		res = popen(cmdline,mode);
+		free(cmdline);
+		*flag = 1;
+		return res;
+	}
+	*flag = 0;
+	return fopen(name,mode);
+}
+
+struct profile_list *proList = NULL;
+struct profile_list *doneList = NULL;
+
+static struct profile_list *
+create_profile_list(void)
+{
+	DIR *dir;
+	struct dirent *ent;
+	int proFd;
+	struct profile_list *profl = NULL, *list = NULL, *list_tail = NULL;
+	char *prgname ="create_profile_list";
+
+
+	dir = opendir(mprof_procdir);
+	if (!dir) {
+		/* module-profile is not invalid */
+		proList = list;
+		return list;
+	}
+
+	while ((ent = readdir(dir)) != NULL) {
+
+		/* skip directory */
+		if (strcmp(ent->d_name, ".") == 0 ||
+		    strcmp(ent->d_name, "..") == 0) {
+			continue;
+		}
+
+		/* 
+		 * alloc memory for profile_list, chain by dir-entory order
+		 */
+		profl = xmalloc(sizeof(struct profile_list));
+		memset(profl, 0, sizeof(struct profile_list));
+		if(list){
+			profl->prv = list_tail;
+			list_tail->nxt = profl;
+		}else{
+			list = profl;
+			list_tail = profl;
+		}
+		list_tail = profl;
+
+		/* profile_name */
+		profl->profile_name = xmalloc(sizeof(mprof_procdir) + 1 + 
+					      strlen(ent->d_name));
+		sprintf(profl->profile_name,"%s/%s", mprof_procdir,ent->d_name);
+
+		if ( ((proFd=open(profl->profile_name,O_RDONLY)) < 0)
+		     || ((int)(profl->len=lseek(proFd,0,SEEK_END)) < 0)
+		     || (lseek(proFd,0,SEEK_SET)<0) ) {
+			fprintf(stderr,"%s: %s: %s\n",
+				prgname,profl->profile_name,strerror(errno));
+	                exit(1);
+	        }
+
+		/* alloc memory for read buffer */
+	        if (!(profl->buf = malloc(profl->len)) ) {
+			fprintf(stderr,"%s: malloc(): %s\n",
+				prgname, strerror(errno));
+                	exit(1);
+       	 	}
+		memset(profl->buf, 0, profl->len);
+ 
+		/* read profiling buffer */
+		if (read(proFd,profl->buf,profl->len) != profl->len) {
+			fprintf(stderr,"%s: %s: %s\n", prgname,
+				profl->profile_name,strerror(errno));
+			exit(1);
+		}
+
+		/* change pointer to profile,
+		 * to search for these in main routine */
+		profl->profile_name += sizeof(mprof_procdir);
+
+		close(proFd);
+
+	}
+
+	closedir (dir);
+	proList = list;
+	return list;
+}
+
+static struct profile_list *
+rechain_profile_list(struct profile_list *profl)
+{
+	struct profile_list *c_prof;
+
+	/* unchain proList */	
+	if (profl->prv){
+		profl->prv->nxt = profl->nxt;
+	}
+	if (profl->nxt){
+		profl->nxt->prv = profl->prv;
+	}
+	if (profl == proList){
+		proList = profl->nxt;
+	}
+
+	/* chain tail of doneList */
+	if (doneList) { 
+		for (c_prof = doneList; c_prof->nxt != NULL;
+		     c_prof = c_prof->nxt) {
+			;
+		}
+		profl->prv = c_prof;
+		c_prof->nxt = profl;
+	} else {
+		profl->prv = NULL;
+		doneList = profl;
+	}
+	profl->nxt = NULL;
+
+	return proList;
+}
+
+int
+main (int argc, char **argv) {
+	FILE *map;
+	int proFd;
+	char *mapFile, *proFile, *mult=0;
+	unsigned long len=0, add0=0, indx=0;
+	unsigned int step;
+	unsigned int *buf, total, fn_len;
+	unsigned long fn_add, next_add;          /* current and next address */
+	char fn_name[S_LEN], next_name[S_LEN];   /* current and next name */
+	char module[S_LEN], last_module[S_LEN], m_fn_name[S_LEN];
+	char mode[8];
+	int c, i;
+	int optAll=0, optInfo=0, optReset=0, optVerbose=0;
+	char mapline[S_LEN];
+	int maplineno=0;
+	int popenMap;   /* flag to tell if popen() has been used */
+	int modulemap_end;
+	struct profile_list *profl;
+#ifdef TEST
+	int optTest=0;
+#endif
+
+#define next (current^1)
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	prgname=argv[0];
+	proFile=defaultpro;
+	mapFile=defaultmap;
+
+	while ((c = getopt(argc,argv,optstring)) != -1) {
+		switch(c) {
+		case 'm': mapFile=optarg; break;
+		case 'p': proFile=optarg; break;
+		case 'a': optAll++;       break;
+		case 'i': optInfo++;      break;
+		case 'M': mult=optarg;    break;
+		case 'r': optReset++;     break;
+		case 'v': optVerbose++;   break;
+		case 'V': printf(_("%s Version %s\n"),prgname,RELEASE);
+			exit(0);
+#ifdef TEST
+		case 't': optTest++;   break;
+#endif
+		default: usage();
+		}
+	}
+
+	if (optReset || mult) {
+		int multiplier, fd, to_write;
+
+		/*
+		 * When writing the multiplier, if the length of the write is
+		 * not sizeof(int), the multiplier is not changed
+		 */
+		if (mult) {
+			multiplier = strtoul(mult, 0, 10);
+			to_write = sizeof(int);
+		} else {
+			multiplier = 0;
+			to_write = 1;	/* sth different from sizeof(int) */
+		}
+		/* try to become root, just in case */
+		setuid(0);
+		fd = open(defaultpro,O_WRONLY);
+		if (fd < 0) {
+			perror(defaultpro);
+			exit(1);
+		}
+		if (write(fd, &multiplier, to_write) != to_write) {
+			fprintf(stderr, "readprofile: error writing %s: %s\n",
+				defaultpro, strerror(errno));
+			exit(1);
+		}
+		close(fd);
+		exit(0);
+	}
+
+	/*
+	 * Use an fd for the profiling buffer, to skip stdio overhead
+	 */
+	if ( ((proFd=open(proFile,O_RDONLY)) < 0)
+	     || ((int)(len=lseek(proFd,0,SEEK_END)) < 0)
+	     || (lseek(proFd,0,SEEK_SET)<0) ) {
+		fprintf(stderr,"%s: %s: %s\n",prgname,proFile,strerror(errno));
+		exit(1);
+	}
+
+	if ( !(buf=malloc(len)) ) {
+		fprintf(stderr,"%s: malloc(): %s\n",prgname, strerror(errno));
+		exit(1);
+	}
+
+	if (read(proFd,buf,len) != len) {
+		fprintf(stderr,"%s: %s: %s\n",prgname,proFile,strerror(errno));
+		exit(1);
+	}
+	close(proFd);
+
+	step=buf[0];
+	if (optInfo) {
+		printf(_("Sampling_step: %i\n"),step);
+		exit(0);
+	} 
+
+
+	/*
+	 * create profiling buffer list
+	 */
+	/* create kernel profililng buffer list */
+	profl = xmalloc(sizeof(struct profile_list));
+	memset(profl, 0, sizeof(struct profile_list));
+	profl->buf = buf;
+	profl->len = len;
+
+	/* create module profiling buffer list */
+	proList = create_profile_list();
+	if(proList){
+		/* link head of profiling buffer list chain */
+		profl->nxt = proList;
+	}
+	proList = profl;
+
+
+	if (!(map=myopen(mapFile,"r",&popenMap))) {
+		fprintf(stderr,"%s: ",prgname);perror(mapFile);
+		exit(1);
+	}
+
+	/*
+	 * skip first line, because ksymoops make mapfile
+	 * that set first line "00000001   Using_Versions"
+	 */   
+	fgets(mapline,S_LEN,map);
+	maplineno++;
+
+	while(fgets(mapline,S_LEN,map)) {
+		maplineno++;
+		if (sscanf(mapline,"%lx %s %s",&fn_add,mode,fn_name)!=3) {
+			fprintf(stderr,_("%s: %s(%i): wrong map line\n"),
+				prgname,mapFile, maplineno);
+			exit(1);
+		}
+		if (!strcmp(fn_name,"_stext")) /* only elf works like this */ {
+			add0=fn_add;
+			break;
+		}
+	}
+
+	if (!add0) {
+		fprintf(stderr,_("%s: can't find \"_stext\" in %s\n"),
+			prgname, mapFile);
+		exit(1);
+	}
+
+        /*
+         * Main loop for reading kernel profiling.
+         */
+        total=0;
+        profl = proList;
+        while(fgets(mapline,S_LEN,map)) {
+                unsigned int this=0;
+
+		maplineno++;
+                if (sscanf(mapline,"%lx %s %s",&next_add,mode,next_name)!=3) {
+                        fprintf(stderr,_("%s: %s(%i): wrong map line\n"),
+                                prgname,mapFile, maplineno);
+                        exit(1);
+                }
+
+                /* ignore any LEADING (before a '[tT]' symbol is found)
+                   Absolute symbols */
+                if (*mode == 'A' && total == 0) continue;
+                if (*mode!='T' && *mode!='t') break;/* only text is profiled */
+
+                if (indx >= profl->len / sizeof(*profl->buf)) {
+			fprintf(stderr, _("%s: profile address out of range. "
+				  "Wrong map file?(%i)\n"), prgname,maplineno);
+                        exit(1);
+                }
+
+                while (indx < (next_add-add0)/step)
+                        this += profl->buf[indx++];
+                total += this;
+
+                fn_len = next_add-fn_add;
+                if (fn_len && (this || optAll)) {
+                        if (optVerbose)
+#ifdef TEST
+				if (optTest) {
+                                printf("%08lx %4.4x %-50s %6i %8.4f\n",
+					fn_add,fn_len,
+                                       fn_name,this,this/(double)fn_len);
+				} else {
+                                printf("%08lx %-50s %6i %8.4f\n", fn_add,
+                                       fn_name,this,this/(double)fn_len);
+				}
+#else
+                                printf("%08lx %-50s %6i %8.4f\n", fn_add,
+                                       fn_name,this,this/(double)fn_len);
+#endif
+                        else
+                                printf("%6i %-50s %8.4f\n",
+                                       this,fn_name,this/(double)fn_len);
+                }
+                fn_add=next_add; strcpy(fn_name,next_name);
+        }
+
+        profl->cnt_total = total;
+        profl->cdsz_total = (fn_add-add0);
+	proList = rechain_profile_list(profl);
+	/* set module name "kernel" */
+	profl->mod_name = xmalloc(sizeof("kernel"));
+	strcpy(profl->mod_name, "kernel");
+        if (!proList){
+		/* no module profiling buffer */ 
+                goto trailer;
+        }
+
+	/*
+	 * skip remain part in kernel map
+	 */
+	while(fgets(mapline,S_LEN,map)) {
+		maplineno++;
+
+		if (sscanf(mapline,"%lx %s %s %s",
+				&fn_add,mode,fn_name,module)!=3) {
+			/* kernel map end mark "_end" is not found */
+			fprintf(stderr,_("%s: %s(%i): wrong map line\n"),
+				prgname,mapFile, maplineno);
+			exit(1);
+		}
+		if (!strcmp(fn_name,"_end")) {
+			break;
+		}
+	}
+
+
+	/*
+         * Main loop for reading module profiling.
+	 */
+	modulemap_end = 0;
+        indx = 0;
+	total=0;
+	add0 = 0;
+	profl = proList;
+	memset(module, 0, sizeof(module)); 
+	memset(last_module, 0, sizeof(last_module)); 
+	while(fgets(mapline,S_LEN,map)) {
+		unsigned int this=0;
+
+		maplineno++;
+		if (sscanf(mapline,"%lx %s %s %s",
+				&next_add,mode,next_name,module)!=4) {
+			fprintf(stderr,_("%s: %s(%i): wrong map line\n"),
+				prgname,mapFile, maplineno);
+			exit(1);
+		}
+
+		/*
+		 * if module-name is not diffrent from last_module-name,
+		 * then change profiling buffer.
+		 */
+		if (strcmp(module, last_module)){
+			char *p;
+			int mod_name_len = 0;
+
+			/* module-name is put between '[' and ']' */
+			for (p = module+1; *p != ']'; p++){
+				mod_name_len++;
+			}
+
+			/* determine proc file name */
+			p = xmalloc(mod_name_len + sizeof("_profile"));
+			memcpy(p, module + 1, mod_name_len);
+			strcpy(p + mod_name_len, "_profile");
+
+			/* search profiling buffer for this module */
+			for (profl = proList; profl != NULL;
+			     profl = profl->nxt){
+
+				if (strncmp(p, profl->profile_name,
+				    strlen(p)+1) == 0){
+					break;
+				}
+			}
+			strcpy(last_module, module);
+			if (!profl){
+				/* no profiling buffer */
+				continue;
+			}
+
+			/* if profiling buffer for this module is found,
+			 * then set module name in profile_list */
+			profl->mod_name = xmalloc(mod_name_len + 1);
+			memset(profl->mod_name, 0, mod_name_len + 1);
+			memcpy(profl->mod_name, module + 1, mod_name_len);
+		}
+
+		/*
+		 * skip invalid lines on any mode[tTg...]
+		 */
+		if (profl && !add0) {
+			modulemap_end = 0;
+		}
+
+		/* ignore any LEADING (before a '[tT]' symbol is found)
+		   Absolute symbols */
+		if (*mode!='T' && *mode!='t'){
+			if (strcmp(next_name, ".text.end") == 0){
+				modulemap_end = 1;
+			} else if (strcmp(next_name, ".text.start") == 0){
+				add0 = next_add;
+				if (fn_add == next_add) {
+					continue; 
+				}
+			} else {
+				continue; 
+			}
+		}
+ 
+		/* skip line, because .text start address is not found 
+		   or function name is not found */
+		if (!add0 ||
+		    (strcmp(fn_name, "_end") == 0) ||
+		    (strcmp(fn_name, ".text.end") == 0)) {
+			fn_add = next_add;
+			strcpy(fn_name, next_name);
+			continue; 
+		}
+
+		if (!profl) {
+			fprintf(stderr,_("%s: %s(%i): wrong map line\n"),
+				prgname,mapFile, maplineno);
+			exit(1);
+		}
+
+		if (indx >= profl->len / sizeof(*profl->buf)) {
+			fprintf(stderr, _("%s: profile address out of range. "
+				  "Wrong map file?(%i)\n"), prgname,maplineno);
+			exit(1);
+		}
+
+		while (indx < (next_add-add0)/step) {
+			this += profl->buf[indx++];
+		}
+		total += this;
+
+		fn_len = next_add-fn_add;
+		if (fn_len && (this || optAll)) {
+			sprintf(m_fn_name,"%s%s", module,fn_name);
+			if (optVerbose)
+#ifdef TEST
+				if (optTest) {
+				printf("%08lx %4.4x %-50s %6i %8.4f\n",
+					fn_add,fn_len,
+					m_fn_name,this,this/(double)fn_len);
+				} else {
+				printf("%08lx %-50s %6i %8.4f\n", fn_add,
+					m_fn_name,this,this/(double)fn_len);
+				}
+#else
+				printf("%08lx %-50s %6i %8.4f\n", fn_add,
+					m_fn_name,this,this/(double)fn_len);
+#endif
+			else
+				printf("%6i %-50s %8.4f\n",
+				       this,m_fn_name,this/(double)fn_len);
+		}
+
+		fn_add=next_add; strcpy(fn_name,next_name);
+		strcpy(last_module, module);
+
+		/*
+		 * if rearch end of a module, save profiling count total
+		 * function total code size, and initialize variables
+		 */
+		if (modulemap_end) {
+
+			profl->cnt_total = total;
+			profl->cdsz_total = (fn_add-add0);
+			proList = rechain_profile_list(profl);
+
+			if (proList){
+				indx = 0;
+				total = 0;
+				add0 = 0;
+			}
+			profl = NULL;
+		}
+	}
+
+trailer:
+	/* trailer */
+	i = 0;
+	printf("\ntotal:\n");
+	for (profl = doneList; profl != NULL; profl = profl->nxt){
+		if (profl->cnt_total || optAll) {
+			if (optVerbose)
+				printf("%8d %-50s %6i %8.4f\n",
+				  ++i,profl->mod_name,(int)profl->cnt_total,
+				  profl->cnt_total/(double)profl->cdsz_total);
+			else
+				printf("%6i %-50s %8.4f\n",
+				  (int)profl->cnt_total,profl->mod_name,
+				  profl->cnt_total/(double)profl->cdsz_total);
+
+		}
+	}
+	
+	popenMap ? pclose(map) : fclose(map);
+	exit(0);
+}

<-- end of readprofile2-v0.2-v2.11o.patch

-- 
hirao <hirao@estartu.open.nm.fujitsu.co.jp>

