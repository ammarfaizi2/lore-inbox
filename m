Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUI1WXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUI1WXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268090AbUI1WWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:22:19 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:37604 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268074AbUI1WTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:19:49 -0400
Date: Wed, 29 Sep 2004 00:19:33 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040928221933.GG4084@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random> <1096272553.6572.3.camel@laptop.fenrus.com> <20040927130919.GE28865@dualathlon.random> <20040928194351.GC5037@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928194351.GC5037@devserv.devel.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 09:43:51PM +0200, Arjan van de Ven wrote:
> On Mon, Sep 27, 2004 at 03:09:19PM +0200, Andrea Arcangeli wrote:
> > > which "those apps" ?
> > 
> > those apps that wants to allocate as close as possible to the stack.
> > They're already using /proc/self/mapped_base, the gap of topdown isn't
> > configurable.
> 
> /proc/self/mmaped_base doesn't exist...

it does with this patch that should be included in mainline too. This
follows the redhat API that oracle requires (you invented it, didn't
you?) so you should be fine with it.

with mapped base people is free to allocate as much memory as the
hardware can, with topdown not.

Index: linux-2.6.8/fs/proc/base.c
===================================================================
--- linux-2.6.8.orig/fs/proc/base.c
+++ linux-2.6.8/fs/proc/base.c
@@ -59,8 +59,9 @@ enum pid_directory_inos {
 	PROC_TGID_STATM,
 	PROC_TGID_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
+	PROC_TGID_MAPBASE,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
 #ifdef CONFIG_SECURITY
@@ -122,8 +123,11 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+#ifdef __HAS_ARCH_PROC_MAPPED_BASE
+   	E(PROC_TGID_MAPBASE,	"mapped_base",	S_IFREG|S_IRUSR|S_IWUSR),
+#endif
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
 #ifdef CONFIG_KALLSYMS
@@ -696,8 +700,57 @@ static struct file_operations proc_mem_o
 	.write		= mem_write,
 	.open		= mem_open,
 };
 
+#ifdef __HAS_ARCH_PROC_MAPPED_BASE
+static ssize_t mapbase_read(struct file * file, char * buf,
+			size_t count, loff_t *ppos)
+{
+	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	char buffer[64];
+	size_t len;
+
+	len = sprintf(buffer, "%li\n", task->map_base) + 1;
+	if (*ppos >= len)
+		return 0;
+	if (count > len-*ppos)
+		count = len-*ppos;
+	if (copy_to_user(buf, buffer + *ppos, count)) 
+		return -EFAULT;
+	*ppos += count;
+	return count;
+}
+
+static ssize_t mapbase_write(struct file * file, const char * buf,
+			 size_t count, loff_t *ppos)
+{
+	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	char buffer[64], *end;
+	unsigned long newbase;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	memset(buffer, 0, 64);	
+	if (count > 62)
+		count = 62;
+	if (copy_from_user(buffer, buf, count)) 
+		return -EFAULT;
+	newbase = simple_strtoul(buffer, &end, 0);
+	if (*end == '\n')
+		end++;
+	if (newbase > 0)
+		task->map_base = newbase;
+	if (end - buffer == 0) 
+		return -EIO;
+	return end - buffer;
+}
+
+static struct file_operations proc_mapbase_operations = {
+	read:		mapbase_read,
+	write:		mapbase_write,
+};
+#endif /* __HAS_ARCH_PROC_MAPPED_BASE */
+
 static struct inode_operations proc_mem_inode_operations = {
 	.permission	= proc_permission,
 };
 
@@ -1332,8 +1385,13 @@ static struct dentry *proc_pident_lookup
 		case PROC_TID_MAPS:
 		case PROC_TGID_MAPS:
 			inode->i_fop = &proc_maps_operations;
 			break;
+#ifdef __HAS_ARCH_PROC_MAPPED_BASE
+ 		case PROC_TGID_MAPBASE:
+ 			inode->i_fop = &proc_mapbase_operations;
+ 			break;
+#endif
 		case PROC_TID_MEM:
 		case PROC_TGID_MEM:
 			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
Index: linux-2.6.8/include/linux/sched.h
===================================================================
--- linux-2.6.8.orig/include/linux/sched.h
+++ linux-2.6.8/include/linux/sched.h
@@ -583,8 +583,11 @@ struct task_struct {
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
 #endif
+
+/* TASK_UNMAPPED_BASE */
+	unsigned long map_base;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
 {
@@ -596,8 +599,14 @@ extern void __put_task_struct(struct tas
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 #define put_task_struct(tsk) \
 do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
 
+#ifndef __TASK_UNMAPPED_BASE
+#define __TASK_UNMAPPED_BASE 0UL
+#else
+#define __HAS_ARCH_PROC_MAPPED_BASE
+#endif
+
 /*
  * Per process flags
  */
 #define PF_ALIGNWARN	0x00000001	/* Print alignment warning msgs */
Index: linux-2.6.8/include/linux/init_task.h
===================================================================
--- linux-2.6.8.orig/include/linux/init_task.h
+++ linux-2.6.8/include/linux/init_task.h
@@ -111,8 +111,9 @@ extern struct group_info init_groups;
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+ 	.map_base	= __TASK_UNMAPPED_BASE,				\
 }
 
 
 
Index: linux-2.6.8/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6.8.orig/include/asm-um/processor-generic.h
+++ linux-2.6.8/include/asm-um/processor-generic.h
@@ -115,9 +115,10 @@ extern unsigned long task_size;
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	(0x40000000)
+#define __TASK_UNMAPPED_BASE	(0x40000000)
+#define TASK_UNMAPPED_BASE	(current->map_base)
 
 extern void start_thread(struct pt_regs *regs, unsigned long entry, 
 			 unsigned long stack);
 
Index: linux-2.6.8/include/asm-x86_64/processor.h
===================================================================
--- linux-2.6.8.orig/include/asm-x86_64/processor.h
+++ linux-2.6.8/include/asm-x86_64/processor.h
@@ -171,11 +171,16 @@ static inline void clear_in_cr4 (unsigne
 #define TASK_SIZE	(0x0000007fc0000000UL)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
+ *
+ * /proc/pid/unmap_base is only supported for 32bit processes without
+ * 3GB personality for now.
  */
 #define IA32_PAGE_OFFSET ((current->personality & ADDR_LIMIT_3GB) ? 0xc0000000 : 0xFFFFe000)
-#define TASK_UNMAPPED_32 PAGE_ALIGN(IA32_PAGE_OFFSET/3)
+#define __TASK_UNMAPPED_BASE (PAGE_ALIGN(0xffffe000 / 3))
+#define TASK_UNMAPPED_32 ((current->personality & ADDR_LIMIT_3GB) ? \
+	PAGE_ALIGN(0xc0000000 / 3) : PAGE_ALIGN(current->map_base))
 #define TASK_UNMAPPED_64 PAGE_ALIGN(TASK_SIZE/3) 
 #define TASK_UNMAPPED_BASE	\
 	(test_thread_flag(TIF_IA32) ? TASK_UNMAPPED_32 : TASK_UNMAPPED_64)  
 
Index: linux-2.6.8/include/asm-ppc64/processor.h
===================================================================
--- linux-2.6.8.orig/include/asm-ppc64/processor.h
+++ linux-2.6.8/include/asm-ppc64/processor.h
@@ -516,10 +516,13 @@ extern struct task_struct *last_task_use
 		TASK_SIZE_USER32 : TASK_SIZE_USER64)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
+ *
+ * /proc/pid/unmap_base is only supported for 32bit processes for now.
  */
-#define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(STACK_TOP_USER32 / 4))
+#define __TASK_UNMAPPED_BASE (PAGE_ALIGN(STACK_TOP_USER32 / 4))
+#define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(current->map_base))
 #define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(STACK_TOP_USER64 / 4))
 
 #define TASK_UNMAPPED_BASE ((test_thread_flag(TIF_32BIT)||(ppcdebugset(PPCDBG_BINFMT_32ADDR))) ? \
 		TASK_UNMAPPED_BASE_USER32 : TASK_UNMAPPED_BASE_USER64 )
Index: linux-2.6.8/include/asm-i386/processor.h
===================================================================
--- linux-2.6.8.orig/include/asm-i386/processor.h
+++ linux-2.6.8/include/asm-i386/processor.h
@@ -294,9 +294,10 @@ extern unsigned int mca_pentium_flag;
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
+#define TASK_UNMAPPED_BASE	(current->map_base)
+#define __TASK_UNMAPPED_BASE PAGE_ALIGN(TASK_SIZE/3)
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
 /*
Index: linux-2.6.8/include/asm-s390/processor.h
===================================================================
--- linux-2.6.8.orig/include/asm-s390/processor.h
+++ linux-2.6.8/include/asm-s390/processor.h
@@ -61,9 +61,10 @@ extern struct task_struct *last_task_use
  */
 #ifndef __s390x__
 
 # define TASK_SIZE		(0x80000000UL)
-# define TASK_UNMAPPED_BASE	(TASK_SIZE / 2)
+# define TASK_UNMAPPED_BASE (current->map_base)
+# define __TASK_UNMAPPED_BASE	(TASK_SIZE / 2)
 # define DEFAULT_TASK_SIZE	(0x80000000UL)
 
 #else /* __s390x__ */
 

> > Also topdown may screwup some MAP_FIXED usage below the 1G mark, no?
> 
> no
> 
> map_fixed is map_fixed... if you give a hint the kernel will try that of
> course.

Yeah, map fix is map fixed and when you execute map fixed on a existing
mapping becaue topdown moved below the 1G mark (a place where there
could never have been a "hinted" mapping before), the existing mapping
will be destroyed and the application will behave randomly.

isn't the whole point of topdown to gain ~1G more of RAM. A 1G area that
couldn't possibly be used before, and where people today can use
MAP_FIXED without colliding with dynamically allocated heap like for
mallocs. topdown breaks that assumption and can break random apps in
random ways.

Or did I misunderstood something? If topdown still forbids you to use
the first 1G of address space, then what's the point?!?
