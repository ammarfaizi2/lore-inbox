Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVAWFGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVAWFGN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 00:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVAWFGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 00:06:13 -0500
Received: from ozlabs.org ([203.10.76.45]:17566 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261226AbVAWFGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 00:06:05 -0500
Date: Sun, 23 Jan 2005 16:01:02 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, tony.luck@intel.com, ak@suse.de, matthew@wil.cx,
       ralf@linux-mips.org, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Problems disabling SYSCTL
Message-ID: <20050123050102.GD5920@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Create a cond_syscall for sys32_sysctl and make all architectures use
it. Also fix the architectures that dont wrap their 32bit compat sysctl
code.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ia64/ia32/sys_ia32.c~sysctl_fixup2 arch/ia64/ia32/sys_ia32.c
--- foobar2/arch/ia64/ia32/sys_ia32.c~sysctl_fixup2	2005-01-13 10:40:35.995198406 +1100
+++ foobar2-anton/arch/ia64/ia32/sys_ia32.c	2005-01-13 10:40:36.058193579 +1100
@@ -1973,10 +1973,10 @@ struct sysctl32 {
 	unsigned int	__unused[4];
 };
 
+#ifdef CONFIG_SYSCTL
 asmlinkage long
 sys32_sysctl (struct sysctl32 __user *args)
 {
-#ifdef CONFIG_SYSCTL
 	struct sysctl32 a32;
 	mm_segment_t old_fs = get_fs ();
 	void __user *oldvalp, *newvalp;
@@ -2015,10 +2015,8 @@ sys32_sysctl (struct sysctl32 __user *ar
 		return -EFAULT;
 
 	return ret;
-#else
-	return -ENOSYS;
-#endif
 }
+#endif
 
 asmlinkage long
 sys32_newuname (struct new_utsname __user *name)
diff -puN arch/mips/kernel/linux32.c~sysctl_fixup2 arch/mips/kernel/linux32.c
--- foobar2/arch/mips/kernel/linux32.c~sysctl_fixup2	2005-01-13 10:40:36.000198023 +1100
+++ foobar2-anton/arch/mips/kernel/linux32.c	2005-01-13 10:40:36.051194115 +1100
@@ -1194,13 +1194,6 @@ asmlinkage long sys32_sysctl(struct sysc
 	return error;
 }
 
-#else /* CONFIG_SYSCTL */
-
-asmlinkage long sys32_sysctl(struct sysctl_args32 *args)
-{
-	return -ENOSYS;
-}
-
 #endif /* CONFIG_SYSCTL */
 
 asmlinkage long sys32_newuname(struct new_utsname * name)
diff -puN arch/parisc/kernel/sys_parisc32.c~sysctl_fixup2 arch/parisc/kernel/sys_parisc32.c
--- foobar2/arch/parisc/kernel/sys_parisc32.c~sysctl_fixup2	2005-01-13 10:40:36.005197640 +1100
+++ foobar2-anton/arch/parisc/kernel/sys_parisc32.c	2005-01-13 10:40:36.060193425 +1100
@@ -165,12 +165,6 @@ asmlinkage long sys32_sysctl(struct __sy
 	return error;
 }
 
-#else /* CONFIG_SYSCTL */
-
-asmlinkage long sys32_sysctl(struct __sysctl_args *args)
-{
-	return -ENOSYS;
-}
 #endif /* CONFIG_SYSCTL */
 
 asmlinkage long sys32_sched_rr_get_interval(pid_t pid,
diff -puN arch/ppc64/kernel/sys_ppc32.c~sysctl_fixup2 arch/ppc64/kernel/sys_ppc32.c
--- foobar2/arch/ppc64/kernel/sys_ppc32.c~sysctl_fixup2	2005-01-13 10:40:36.011197180 +1100
+++ foobar2-anton/arch/ppc64/kernel/sys_ppc32.c	2005-01-13 10:40:36.046194498 +1100
@@ -1106,6 +1106,7 @@ asmlinkage long sys32_umask(u32 mask)
 	return sys_umask((int)mask);
 }
 
+#ifdef CONFIG_SYSCTL
 struct __sysctl_args32 {
 	u32 name;
 	int nlen;
@@ -1155,6 +1156,7 @@ asmlinkage long sys32_sysctl(struct __sy
 	}
 	return error;
 }
+#endif
 
 asmlinkage int sys32_olduname(struct oldold_utsname __user * name)
 {
diff -puN arch/s390/kernel/compat_linux.c~sysctl_fixup2 arch/s390/kernel/compat_linux.c
--- foobar2/arch/s390/kernel/compat_linux.c~sysctl_fixup2	2005-01-13 10:40:36.016196797 +1100
+++ foobar2-anton/arch/s390/kernel/compat_linux.c	2005-01-13 10:40:36.063193195 +1100
@@ -906,6 +906,7 @@ asmlinkage long sys32_adjtimex(struct ti
 	return ret;
 }
 
+#ifdef CONFIG_SYSCTL
 struct __sysctl_args32 {
 	u32 name;
 	int nlen;
@@ -953,6 +954,7 @@ asmlinkage long sys32_sysctl(struct __sy
 	}
 	return error;
 }
+#endif
 
 struct stat64_emu31 {
 	unsigned long long  st_dev;
diff -puN arch/x86_64/ia32/sys_ia32.c~sysctl_fixup2 arch/x86_64/ia32/sys_ia32.c
--- foobar2/arch/x86_64/ia32/sys_ia32.c~sysctl_fixup2	2005-01-13 10:40:36.021196414 +1100
+++ foobar2-anton/arch/x86_64/ia32/sys_ia32.c	2005-01-13 10:40:36.066192966 +1100
@@ -653,6 +653,7 @@ sys32_pause(void)
 }
 
 
+#ifdef CONFIG_SYSCTL
 struct sysctl_ia32 {
 	unsigned int	name;
 	int		nlen;
@@ -667,9 +668,6 @@ struct sysctl_ia32 {
 asmlinkage long
 sys32_sysctl(struct sysctl_ia32 __user *args32)
 {
-#ifndef CONFIG_SYSCTL
-	return -ENOSYS; 
-#else
 	struct sysctl_ia32 a32;
 	mm_segment_t old_fs = get_fs ();
 	void *oldvalp, *newvalp;
@@ -710,8 +708,8 @@ sys32_sysctl(struct sysctl_ia32 __user *
 		return -EFAULT;
 
 	return ret;
-#endif
 }
+#endif
 
 /* warning: next two assume little endian */ 
 asmlinkage long
diff -puN kernel/sys_ni.c~sysctl_fixup2 kernel/sys_ni.c
--- foobar2/kernel/sys_ni.c~sysctl_fixup2	2005-01-13 10:40:36.026196031 +1100
+++ foobar2-anton/kernel/sys_ni.c	2005-01-13 10:40:36.047194422 +1100
@@ -82,3 +82,4 @@ cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
 cond_syscall(sys_pciconfig_iobase)
 cond_syscall(sys32_ipc)
+cond_syscall(sys32_sysctl)
_
