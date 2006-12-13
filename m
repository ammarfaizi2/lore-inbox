Return-Path: <linux-kernel-owner+w=401wt.eu-S932606AbWLMHij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWLMHij (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 02:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWLMHij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 02:38:39 -0500
Received: from mailx.hitachi.co.jp ([133.145.228.49]:64056 "EHLO
	mailx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbWLMHih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 02:38:37 -0500
X-Greylist: delayed 1395 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 02:38:37 EST
Message-ID: <457FA840.5000107@hitachi.com>
Date: Wed, 13 Dec 2006 16:14:08 +0900
From: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) 
    Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH] binfmt_elf: core dump masking support
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch provides a feature which enables you to specify the memory
segment types you don't want to dump into a core file. You can specify
them per process via /proc/<pid>/coremask file. This file represents
the bitmask of memory segment types which are not written out when the
<pid> process is dumped. Currently, bit 0 is only available. This
means anonymous shared memory, which includes IPC shared memory and
some of mmap(2)'ed memory.

This patch can be applied against 2.6.19-rc6-mm2, and tested on i386,
x86_64, and ia64 platforms.

Here is the background. Some software programs share huge memory among
hundreds of processes. If a failure occurs on one of these processes,
they can be signaled by a monitoring process to generate core files
and restart the service. However, it can develop into a system-wide
failure such as system slow down for a long time and disk space
shortage because the total size of the core files is very huge!

To avoid the above situation we can limit the core file size by
setrlimit(2) or ulimit(1). But this method can lose important data
such as stack because core dumping is done from lower address to
higher address and terminated halfway.
So I suggest keeping shared memory segments from being dumped for
particular processes. Because the shared memory attached to processes
is common in them, we don't need to dump the shared memory every time.

If you don't want to dump all shared memory segments attached to
pid 1234, set the bit 0 of the process's coremask to 1:

  $ echo 1 > /proc/1234/coremask

Additionally, you can check its hexadecimal value by reading the file:

  $ cat /proc/1234/coremask
  00000001

When a new process is created, the process inherits the coremask
setting from its parent. It is useful to set the coremask before
the program runs. For example:

  $ echo 1 > /proc/self/coremask
  $ ./some_program

Thanks,

Hidehiro Kawai
Hitachi, Ltd., Systems Development Laboratory

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
---
 Documentation/filesystems/proc.txt |   36 ++++++++++
 fs/binfmt_elf.c                    |   10 +-
 fs/proc/base.c                     |   96 +++++++++++++++++++++++++++
 include/linux/binfmts.h            |    3 
 include/linux/sched.h              |    1 
 kernel/fork.c                      |    1 
 6 files changed, 144 insertions(+), 3 deletions(-)

Index: linux-2.6.19-rc6-mm2/fs/binfmt_elf.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/fs/binfmt_elf.c
+++ linux-2.6.19-rc6-mm2/fs/binfmt_elf.c
@@ -1189,9 +1189,13 @@
 	if (vma->vm_flags & (VM_IO | VM_RESERVED))
 		return 0;
 
-	/* Dump shared memory only if mapped from an anonymous file. */
-	if (vma->vm_flags & VM_SHARED)
-		return vma->vm_file->f_path.dentry->d_inode->i_nlink == 0;
+	/* Dump shared memory which mapped from an anonymous file and
+	 * not masked.  */
+	if (vma->vm_flags & VM_SHARED) {
+		if (vma->vm_file->f_dentry->d_inode->i_nlink)
+			return 0;
+		return (vma->vm_mm->core_mask & CORE_MASK_ANONSHM) == 0;
+	}
 
 	/* If it hasn't been written to, don't write it out */
 	if (!vma->anon_vma)
Index: linux-2.6.19-rc6-mm2/fs/proc/base.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/fs/proc/base.c
+++ linux-2.6.19-rc6-mm2/fs/proc/base.c
@@ -73,6 +73,7 @@
 #include <linux/poll.h>
 #include <linux/nsproxy.h>
 #include <linux/oom.h>
+#include <linux/elf.h>
 #include "internal.h"
 
 /* NOTE:
@@ -912,6 +913,95 @@
 };
 #endif
 
+#if defined(USE_ELF_CORE_DUMP) && defined(CONFIG_ELF_CORE)
+static ssize_t proc_coremask_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
+	struct mm_struct *mm;
+	char buffer[PROC_NUMBUF];
+	size_t len;
+	unsigned int coremask;
+	loff_t __ppos = *ppos;
+	int ret;
+
+	ret = -ESRCH;
+	if (!task)
+		goto out_no_task;
+
+	ret = 0;
+	mm = get_task_mm(task);
+	if (!mm)
+		goto out_no_mm;
+	coremask = mm->core_mask;
+
+	len = snprintf(buffer, sizeof(buffer), "%08x\n", coremask);
+	if (__ppos >= len)
+		goto out;
+	if (count > len - __ppos)
+		count = len - __ppos;
+
+	ret = -EFAULT;
+	if (copy_to_user(buf, buffer + __ppos, count))
+		goto out;
+
+	ret = count;
+	*ppos = __ppos + count;
+
+ out:
+	mmput(mm);
+ out_no_mm:
+	put_task_struct(task);
+ out_no_task:
+	return ret;
+}
+
+static ssize_t proc_coremask_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct task_struct *task;
+	struct mm_struct *mm;
+	char buffer[PROC_NUMBUF], *end;
+	unsigned int coremask;
+	int ret;
+
+	ret = -EFAULT;
+	memset(buffer, 0, sizeof(buffer));
+	if (count > sizeof(buffer) - 1)
+		count = sizeof(buffer) - 1;
+	if (copy_from_user(buffer, buf, count))
+		goto out_no_task;
+
+	ret = -EINVAL;
+	coremask = (unsigned int)simple_strtoul(buffer, &end, 0);
+	if (*end == '\n')
+		end++;
+	if (end - buffer == 0)
+		goto out_no_task;
+
+	ret = -ESRCH;
+	task = get_proc_task(file->f_dentry->d_inode);
+	if (!task)
+		goto out_no_task;
+
+	ret = end - buffer;
+	mm = get_task_mm(task);
+	if (mm) {
+		mm->core_mask = coremask;
+		mmput(mm);
+	}
+
+	put_task_struct(task);
+ out_no_task:
+	return ret;
+}
+
+static struct file_operations proc_coremask_operations = {
+	.read		= proc_coremask_read,
+	.write		= proc_coremask_write,
+};
+#endif
+
 static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1879,6 +1969,9 @@
 #ifdef CONFIG_FAULT_INJECTION
 	REG("make-it-fail", S_IRUGO|S_IWUSR, fault_inject),
 #endif
+#if defined(USE_ELF_CORE_DUMP) && defined(CONFIG_ELF_CORE)
+	REG("coremask",   S_IRUGO|S_IWUSR, coremask),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file * filp,
@@ -2157,6 +2250,9 @@
 #ifdef CONFIG_FAULT_INJECTION
 	REG("make-it-fail", S_IRUGO|S_IWUSR, fault_inject),
 #endif
+#if defined(USE_ELF_CORE_DUMP) && defined(CONFIG_ELF_CORE)
+	REG("coremask",  S_IRUGO|S_IWUSR, coremask),
+#endif
 };
 
 static int proc_tid_base_readdir(struct file * filp,
Index: linux-2.6.19-rc6-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/linux/sched.h
+++ linux-2.6.19-rc6-mm2/include/linux/sched.h
@@ -369,6 +369,7 @@
 	/* coredumping support */
 	int core_waiters;
 	struct completion *core_startup_done, core_done;
+	unsigned int core_mask;
 
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
Index: linux-2.6.19-rc6-mm2/kernel/fork.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/kernel/fork.c
+++ linux-2.6.19-rc6-mm2/kernel/fork.c
@@ -332,6 +332,7 @@
 	init_rwsem(&mm->mmap_sem);
 	INIT_LIST_HEAD(&mm->mmlist);
 	mm->core_waiters = 0;
+	mm->core_mask = (current->mm) ? current->mm->core_mask : 0;
 	mm->nr_ptes = 0;
 	set_mm_counter(mm, file_rss, 0);
 	set_mm_counter(mm, anon_rss, 0);
Index: linux-2.6.19-rc6-mm2/include/linux/binfmts.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/linux/binfmts.h
+++ linux-2.6.19-rc6-mm2/include/linux/binfmts.h
@@ -79,6 +79,9 @@
 #define EXSTACK_DISABLE_X 1	/* Disable executable stacks */
 #define EXSTACK_ENABLE_X  2	/* Enable executable stacks */
 
+/* core dump masking */
+#define CORE_MASK_ANONSHM 0x1  /* Don't dump shared memory.  */
+
 extern int setup_arg_pages(struct linux_binprm * bprm,
 			   unsigned long stack_top,
 			   int executable_stack);
Index: linux-2.6.19-rc6-mm2/Documentation/filesystems/proc.txt
===================================================================
--- linux-2.6.19-rc6-mm2.orig/Documentation/filesystems/proc.txt
+++ linux-2.6.19-rc6-mm2/Documentation/filesystems/proc.txt
@@ -41,6 +41,7 @@
   2.11	/proc/sys/fs/mqueue - POSIX message queues filesystem
   2.12	/proc/<pid>/oom_adj - Adjust the oom-killer score
   2.13	/proc/<pid>/oom_score - Display current oom-killer score
+  2.14	/proc/<pid>/coremask - Core dump setting for segment types
 
 ------------------------------------------------------------------------------
 Preface
@@ -1981,6 +1982,41 @@
 any given <pid>. Use it together with /proc/<pid>/oom_adj to tune which
 process should be killed in an out-of-memory situation.
 
+2.14 /proc/<pid>/coremask - Core dump setting for segment types
+---------------------------------------------------------------------
+The /proc/<pid>/coremask file controls the core dump routine. Its content is
+bitmask of segment types you don't want to dump. When the <pid> process is
+dumped, the core dump routine decides whether a given memory segment should be
+dumped into a core file or not, based on the type of the memory segment and
+bitmask.
+
+Currently, only valid bit is bit 0, which means anonymous shared memory
+segment. There are three types of anonymous shared memory:
+
+  - IPC shared memory
+  - the memory created by mmap(2) with MAP_ANONYMOUS and MAP_SHARED flags
+  - the memory where an already unlinked file is mapped with MAP_SHARED flag
+
+Because current core dump routine doesn't distinguish these segments, you can
+only choose either dumping all anonymous shared memory segments or not.
+
+If you don't want to dump all shared memory segments attached to pid 1234, set
+the bit 0 of the process's coremask to 1:
+
+  $ echo 1 > /proc/1234/coremask
+
+Additionally, you can check its hexadecimal value by reading the file:
+
+  $ cat /proc/1234/coremask
+  00000001
+
+When a new process is created, the process inherits the coremask setting from
+its parent. It is useful to set the coremask before the program runs. For
+example:
+
+  $ echo 1 > /proc/self/coremask
+  $ ./some_program
+
 ------------------------------------------------------------------------------
 Summary
 ------------------------------------------------------------------------------




