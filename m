Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWGJWjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWGJWjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWGJWjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:39:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38886 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964859AbWGJWji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:39:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
CC: <linux-kernel@vger.kernel.org>
Date: Mon, 10 Jul 2006 16:38:59 -0600
Message-ID: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since sys_sysctl is deprecated start allow it to be compiled out.
This should catch any remaining user space code that cares,
and paves the way for further sysctl cleanups.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/ia32/sys_ia32.c         |    2 -
 arch/mips/kernel/linux32.c        |    4 +
 arch/powerpc/kernel/sys_ppc32.c   |    2 -
 arch/s390/kernel/compat_linux.c   |    2 -
 arch/sparc64/kernel/sys_sparc32.c |    2 -
 arch/x86_64/ia32/sys_ia32.c       |    2 -
 fs/Kconfig                        |   19 +++++++
 init/Kconfig                      |   31 ++++++-----
 kernel/sysctl.c                   |  101 ++++++++++---------------------------
 9 files changed, 71 insertions(+), 94 deletions(-)

diff --git a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
index 6aa3c51..bddbd22 100644
--- a/arch/ia64/ia32/sys_ia32.c
+++ b/arch/ia64/ia32/sys_ia32.c
@@ -1942,7 +1942,7 @@ struct sysctl32 {
 	unsigned int	__unused[4];
 };
 
-#ifdef CONFIG_SYSCTL
+#ifdef CONFIG_SYSCTL_SYSCALL
 asmlinkage long
 sys32_sysctl (struct sysctl32 __user *args)
 {
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 814cb38..02eb78d 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -991,7 +991,7 @@ struct sysctl_args32
 	unsigned int __unused[4];
 };
 
-#ifdef CONFIG_SYSCTL
+#ifdef CONFIG_SYSCTL_SYSCALL
 
 asmlinkage long sys32_sysctl(struct sysctl_args32 __user *args)
 {
@@ -1032,7 +1032,7 @@ asmlinkage long sys32_sysctl(struct sysc
 	return error;
 }
 
-#endif /* CONFIG_SYSCTL */
+#endif /* CONFIG_SYSCTL_SYSCALL */
 
 asmlinkage long sys32_newuname(struct new_utsname __user * name)
 {
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 2e29286..5e391fc 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -740,7 +740,7 @@ asmlinkage long compat_sys_umask(u32 mas
 	return sys_umask((int)mask);
 }
 
-#ifdef CONFIG_SYSCTL
+#ifdef CONFIG_SYSCTL_SYSCALL
 struct __sysctl_args32 {
 	u32 name;
 	int nlen;
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index cabb4ff..4feadc4 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -703,7 +703,7 @@ asmlinkage long sys32_sendfile64(int out
 	return ret;
 }
 
-#ifdef CONFIG_SYSCTL
+#ifdef CONFIG_SYSCTL_SYSCALL
 struct __sysctl_args32 {
 	u32 name;
 	int nlen;
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index c88ae23..69444f2 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -1016,7 +1016,7 @@ struct __sysctl_args32 {
 
 asmlinkage long sys32_sysctl(struct __sysctl_args32 __user *args)
 {
-#ifndef CONFIG_SYSCTL
+#ifndef CONFIG_SYSCTL_SYSCALL
 	return -ENOSYS;
 #else
 	struct __sysctl_args32 tmp;
diff --git a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
index b8424eb..ebd7873 100644
--- a/arch/x86_64/ia32/sys_ia32.c
+++ b/arch/x86_64/ia32/sys_ia32.c
@@ -645,7 +645,7 @@ sys32_pause(void)
 }
 
 
-#ifdef CONFIG_SYSCTL
+#ifdef CONFIG_SYSCTL_SYSCALL
 struct sysctl_ia32 {
 	unsigned int	name;
 	int		nlen;
diff --git a/fs/Kconfig b/fs/Kconfig
index 7532f00..b75cc54 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -829,6 +829,25 @@ config PROC_VMCORE
         help
         Exports the dump image of crashed kernel in ELF format.
 
+config PROC_SYSCTL
+	bool "Sysctl support (/proc/sys)" if EMBEDDED
+	depends on PROC_FS 
+	select SYSCTL
+	default y
+	---help---
+	  The sysctl interface provides a means of dynamically changing
+	  certain kernel parameters and variables on the fly without requiring
+	  a recompile of the kernel or reboot of the system.  The primary
+	  interface is through /proc/sys.  If you say Y here a tree of
+	  modifiable sysctl entries will be generated beneath the
+          /proc/sys directory. They are explained in the files 
+	  in <file:Documentation/sysctl/>.  Note that enabling this 
+	  option will enlarge the kernel by at least 8 KB.
+
+	  As it is generally a good thing, you should say Y here unless
+	  building a kernel for install/rescue disks or your system is very
+	  limited in memory.
+
 config SYSFS
 	bool "sysfs file system support" if EMBEDDED
 	default y
diff --git a/init/Kconfig b/init/Kconfig
index a1d7cc5..5949efb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -213,21 +213,24 @@ config TASK_DELAY_ACCT
 	  Say N if unsure.
 
 config SYSCTL
-	bool "Sysctl support" if EMBEDDED
-	default y
+	bool 
+
+config SYSCTL_SYSCALL
+	bool "Sysctl syscall support"
+	default n
+	select SYSCTL
 	---help---
-	  The sysctl interface provides a means of dynamically changing
-	  certain kernel parameters and variables on the fly without requiring
-	  a recompile of the kernel or reboot of the system.  The primary
-	  interface consists of a system call, but if you say Y to "/proc
-	  file system support", a tree of modifiable sysctl entries will be
-	  generated beneath the /proc/sys directory. They are explained in the
-	  files in <file:Documentation/sysctl/>.  Note that enabling this
-	  option will enlarge the kernel by at least 8 KB.
-
-	  As it is generally a good thing, you should say Y here unless
-	  building a kernel for install/rescue disks or your system is very
-	  limited in memory.
+	  Enable the deprecated sysctl system call.  sys_sysctl uses
+	  binary paths that have been found to be a major pain to maintain
+	  and use.  The interface in /proc/sys is now the primary and what
+	  everyone uses.
+
+	  Nothing has been using the binary sysctl interface for some time
+	  time now so nothing should break if you disable sysctl syscall
+	  support, and you kernel will get marginally smaller.
+
+	  Unless you have an application that uses the sys_syscall interface
+ 	  you should probably say N here.  
 
 config UTS_NS
 	bool "UTS Namespaces"
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5c4d19d..42610e6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -140,8 +140,11 @@ #ifdef CONFIG_RT_MUTEXES
 extern int max_lock_depth;
 #endif
 
+#ifdef CONFIG_SYSCTL_SYSCALL
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
+#endif
+
 #ifndef CONFIG_UTS_NS
 static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
@@ -173,7 +176,7 @@ #endif
 
 /* /proc declarations: */
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_PROC_SYSCTL
 
 static ssize_t proc_readsys(struct file *, char __user *, size_t, loff_t *);
 static ssize_t proc_writesys(struct file *, const char __user *, size_t, loff_t *);
@@ -1252,12 +1255,13 @@ static void start_unregistering(struct c
 
 void __init sysctl_init(void)
 {
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_PROC_SYSCTL
 	register_proc_table(root_table, proc_sys_root, &root_table_header);
 	init_irq_proc();
 #endif
 }
 
+#ifdef CONFIG_SYSCTL_SYSCALL
 int do_sysctl(int __user *name, int nlen, void __user *oldval, size_t __user *oldlenp,
 	       void __user *newval, size_t newlen)
 {
@@ -1311,6 +1315,7 @@ asmlinkage long sys_sysctl(struct __sysc
 	unlock_kernel();
 	return error;
 }
+#endif /* CONFIG_SYSCTL_SYSCALL */
 
 /*
  * ctl_perm does NOT grant the superuser all rights automatically, because
@@ -1337,6 +1342,7 @@ static inline int ctl_perm(ctl_table *ta
 	return test_perm(table->mode, op);
 }
 
+#ifdef CONFIG_SYSCTL_SYSCALL
 static int parse_table(int __user *name, int nlen,
 		       void __user *oldval, size_t __user *oldlenp,
 		       void __user *newval, size_t newlen,
@@ -1426,6 +1432,7 @@ int do_sysctl_strategy (ctl_table *table
 	}
 	return 0;
 }
+#endif /* CONFIG_SYSCTL_SYSCALL */
 
 /**
  * register_sysctl_table - register a sysctl hierarchy
@@ -1513,7 +1520,7 @@ struct ctl_table_header *register_sysctl
 	else
 		list_add_tail(&tmp->ctl_entry, &root_table_header.ctl_entry);
 	spin_unlock(&sysctl_lock);
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_PROC_SYSCTL
 	register_proc_table(table, proc_sys_root, tmp);
 #endif
 	return tmp;
@@ -1531,18 +1538,31 @@ void unregister_sysctl_table(struct ctl_
 	might_sleep();
 	spin_lock(&sysctl_lock);
 	start_unregistering(header);
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_PROC_SYSCTL
 	unregister_proc_table(header->ctl_table, proc_sys_root);
 #endif
 	spin_unlock(&sysctl_lock);
 	kfree(header);
 }
 
+#else /* !CONFIG_SYSCTL */
+struct ctl_table_header * register_sysctl_table(ctl_table * table, 
+						int insert_at_head)
+{
+	return NULL;
+}
+
+void unregister_sysctl_table(struct ctl_table_header * table)
+{
+}
+
+#endif /* CONFIG_SYSCTL */
+
 /*
  * /proc/sys support
  */
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_PROC_SYSCTL
 
 /* Scan the sysctl entries in table and add them all into /proc */
 static void register_proc_table(ctl_table * table, struct proc_dir_entry *root, void *set)
@@ -2520,6 +2540,7 @@ int proc_doulongvec_ms_jiffies_minmax(ct
 #endif /* CONFIG_PROC_FS */
 
 
+#ifdef CONFIG_SYSCTL_SYSCALL
 /*
  * General sysctl support routines 
  */
@@ -2662,7 +2683,7 @@ int sysctl_ms_jiffies(ctl_table *table, 
 	return 1;
 }
 
-#else /* CONFIG_SYSCTL */
+#else /* CONFIG_SYSCTL_SYSCALL */
 
 
 asmlinkage long sys_sysctl(struct __sysctl_args __user *args)
@@ -2698,73 +2719,7 @@ int sysctl_ms_jiffies(ctl_table *table, 
 	return -ENOSYS;
 }
 
-int proc_dostring(ctl_table *table, int write, struct file *filp,
-		  void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_dointvec(ctl_table *table, int write, struct file *filp,
-		  void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_dointvec_bset(ctl_table *table, int write, struct file *filp,
-			void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_dointvec_minmax(ctl_table *table, int write, struct file *filp,
-		    void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_dointvec_jiffies(ctl_table *table, int write, struct file *filp,
-			  void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_dointvec_userhz_jiffies(ctl_table *table, int write, struct file *filp,
-			  void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_dointvec_ms_jiffies(ctl_table *table, int write, struct file *filp,
-			     void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_doulongvec_minmax(ctl_table *table, int write, struct file *filp,
-		    void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int write,
-				      struct file *filp,
-				      void __user *buffer,
-				      size_t *lenp, loff_t *ppos)
-{
-    return -ENOSYS;
-}
-
-struct ctl_table_header * register_sysctl_table(ctl_table * table, 
-						int insert_at_head)
-{
-	return NULL;
-}
-
-void unregister_sysctl_table(struct ctl_table_header * table)
-{
-}
-
-#endif /* CONFIG_SYSCTL */
+#endif /* CONFIG_SYSCTL_SYSCALL */
 
 /*
  * No sense putting this after each symbol definition, twice,
-- 
1.4.1.gac83a

