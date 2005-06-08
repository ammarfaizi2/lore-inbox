Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVFHL7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVFHL7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVFHL7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:59:50 -0400
Received: from ozlabs.org ([203.10.76.45]:43740 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262085AbVFHL7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:59:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
Date: Wed, 8 Jun 2005 21:59:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: anton@samba.org, linux-kernel@vger.kernel.org, jk@blackdown.de
Subject: [PATCH] ppc64: Fix PER_LINUX32 behaviour
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some bugs in the ppc64 PER_LINUX32 implementation,
noted by Juergen Kreileder:

* uname(2) doesn't respect PER_LINUX32, it returns 'ppc64' instead of 'ppc'
* Child processes of a PER_LINUX32 process don't inherit PER_LINUX32

Along the way I took the opportunity to move things around so that
sys_ppc32.c only has 32-bit syscall emulation functions and to remove
the obsolete "fakeppc" command line option.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff -urN linux-2.6/arch/ppc64/kernel/misc.S g5-ppc64/arch/ppc64/kernel/misc.S
--- linux-2.6/arch/ppc64/kernel/misc.S	2005-05-06 17:05:41.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/misc.S	2005-06-08 21:56:19.000000000 +1000
@@ -792,7 +792,7 @@
 	.llong .compat_sys_newstat
 	.llong .compat_sys_newlstat
 	.llong .compat_sys_newfstat
-	.llong .sys_uname
+	.llong .sys32_uname
 	.llong .sys_ni_syscall		/* 110 old iopl syscall */
 	.llong .sys_vhangup
 	.llong .sys_ni_syscall		/* old idle syscall */
diff -urN linux-2.6/arch/ppc64/kernel/sys_ppc32.c g5-ppc64/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.6/arch/ppc64/kernel/sys_ppc32.c	2005-04-26 15:37:55.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/sys_ppc32.c	2005-06-08 21:56:19.000000000 +1000
@@ -791,31 +791,6 @@
 }
 
 
-asmlinkage int ppc64_newuname(struct new_utsname __user * name)
-{
-	int errno = sys_newuname(name);
-
-	if (current->personality == PER_LINUX32 && !errno) {
-		if(copy_to_user(name->machine, "ppc\0\0", 8)) {
-			errno = -EFAULT;
-		}
-	}
-	return errno;
-}
-
-asmlinkage int ppc64_personality(unsigned long personality)
-{
-	int ret;
-	if (current->personality == PER_LINUX32 && personality == PER_LINUX)
-		personality = PER_LINUX32;
-	ret = sys_personality(personality);
-	if (ret == PER_LINUX32)
-		ret = PER_LINUX;
-	return ret;
-}
-
-
-
 /* Note: it is necessary to treat mode as an unsigned int,
  * with the corresponding cast to a signed int to insure that the 
  * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
@@ -1158,26 +1133,47 @@
 }
 #endif
 
+asmlinkage int sys32_uname(struct old_utsname __user * name)
+{
+	int err = 0;
+	
+	down_read(&uts_sem);
+	if (copy_to_user(name, &system_utsname, sizeof(*name)))
+		err = -EFAULT;
+	up_read(&uts_sem);
+	if (!err && personality(current->personality) == PER_LINUX32) {
+		/* change "ppc64" to "ppc" */
+		if (__put_user(0, name->machine + 3)
+		    || __put_user(0, name->machine + 4))
+			err = -EFAULT;
+	}
+	return err;
+}
+
 asmlinkage int sys32_olduname(struct oldold_utsname __user * name)
 {
 	int error;
-	
-	if (!name)
-		return -EFAULT;
+
 	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
 		return -EFAULT;
   
 	down_read(&uts_sem);
 	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
-	error -= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
-	error -= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
-	error -= __put_user(0,name->release+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
-	error -= __put_user(0,name->version+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->machine,&system_utsname.machine,__OLD_UTS_LEN);
-	error = __put_user(0,name->machine+__OLD_UTS_LEN);
+	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
+	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
+	error |= __put_user(0,name->release+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
+	error |= __put_user(0,name->version+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->machine,&system_utsname.machine,__OLD_UTS_LEN);
+	error |= __put_user(0,name->machine+__OLD_UTS_LEN);
+	if (personality(current->personality) == PER_LINUX32) {
+		/* change "ppc64" to "ppc" */
+		error |= __put_user(0, name->machine + 3);
+		error |= __put_user(0, name->machine + 4);
+	}
+	
 	up_read(&uts_sem);
 
 	error = error ? -EFAULT : 0;
diff -urN linux-2.6/arch/ppc64/kernel/syscalls.c g5-ppc64/arch/ppc64/kernel/syscalls.c
--- linux-2.6/arch/ppc64/kernel/syscalls.c	2005-04-26 15:37:55.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/syscalls.c	2005-06-07 22:33:43.000000000 +1000
@@ -199,24 +199,33 @@
 	return ret;
 }
 
-static int __init set_fakeppc(char *str)
+long ppc64_personality(unsigned long personality)
 {
-	if (*str)
-		return 0;
-	init_task.personality = PER_LINUX32;
-	return 1;
+	long ret;
+
+	if (personality(current->personality) == PER_LINUX32
+	    && personality == PER_LINUX)
+		personality = PER_LINUX32;
+	ret = sys_personality(personality);
+	if (ret == PER_LINUX32)
+		ret = PER_LINUX;
+	return ret;
 }
-__setup("fakeppc", set_fakeppc);
 
-asmlinkage int sys_uname(struct old_utsname __user * name)
+long ppc64_newuname(struct new_utsname __user * name)
 {
-	int err = -EFAULT;
-	
+	int err = 0;
+
 	down_read(&uts_sem);
-	if (name && !copy_to_user(name, &system_utsname, sizeof (*name)))
-		err = 0;
+	if (copy_to_user(name, &system_utsname, sizeof(*name)))
+		err = -EFAULT;
 	up_read(&uts_sem);
-	
+	if (!err && personality(current->personality) == PER_LINUX32) {
+		/* change ppc64 to ppc */
+		if (__put_user(0, name->machine + 3)
+		    || __put_user(0, name->machine + 4))
+			err = -EFAULT;
+	}
 	return err;
 }
 
diff -urN linux-2.6/include/asm-ppc64/elf.h g5-ppc64/include/asm-ppc64/elf.h
--- linux-2.6/include/asm-ppc64/elf.h	2005-05-02 08:29:41.000000000 +1000
+++ g5-ppc64/include/asm-ppc64/elf.h	2005-05-18 16:16:34.000000000 +1000
@@ -221,9 +221,7 @@
 		set_thread_flag(TIF_ABI_PENDING);		\
 	else							\
 		clear_thread_flag(TIF_ABI_PENDING);		\
-	if (ibcs2)						\
-		set_personality(PER_SVR4);			\
-	else if (current->personality != PER_LINUX32)		\
+	if (personality(current->personality) != PER_LINUX32)	\
 		set_personality(PER_LINUX);			\
 } while (0)
 
