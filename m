Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263608AbTCUNEW>; Fri, 21 Mar 2003 08:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263610AbTCUNEW>; Fri, 21 Mar 2003 08:04:22 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:36289 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263608AbTCUNEU>; Fri, 21 Mar 2003 08:04:20 -0500
Date: Fri, 21 Mar 2003 14:15:12 +0000
From: norbert_wolff@t-online.de (Norbert Wolff)
To: linux-kernel@vger.kernel.org
Subject: Some Warning from gcc-3.4-cvs for 2.5.65
Message-Id: <20030321141512.25497721.norbert_wolff@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Here are some Warning got when compiling Linux 2.6.65 (devfs not configured)
with the latest gcc-3.4 CVS :

include/linux/devfs_fs_kernel.h: In function `devfs_remove':
include/linux/devfs_fs_kernel.h:101: warning: varargs function cannot be
		inline

Possible Fix :

	Replace inline-func with macro

--- devfs_fs_kernel.h.orig	2003-03-21 13:28:24.000000000 +0000
+++ devfs_fs_kernel.h	2003-03-21 13:30:28.000000000 +0000
@@ -97,9 +97,9 @@
 {
     return NULL;
 }
-static inline void devfs_remove(const char *fmt, ...)
-{
-}
+
+#define devfs_remove(x, ...) do { ; } while (0) 
+
 static inline int devfs_generate_path (devfs_handle_t de, char *path,
 				       int buflen)
 {

---

include/linux/kallsyms.h: In function `__check_printsym_format':
include/linux/kallsyms.h:38: warning: varargs function cannot be inline

> /* This macro allows us to keep printk typechecking */
> static void __check_printsym_format(const char *fmt, ...)
>__attribute__((format(printf,1,2)));
> static inline void __check_printsym_format(const char *fmt, ...)
> {
> }

I think the inline-attribute should be simply removed to quiet this Warning.

---

arch/i386/kernel/ptrace.c: In function `sys_ptrace': 
warning: `__pu_err' might be used uninitialized in this function

This comes from include/asm-i386

> #define __put_user_nocheck(x,ptr,size)				\
> ({								\
>	long __pu_err;						\
>	__put_user_size((x),(ptr),(size),__pu_err,-EFAULT);	\
>	__pu_err;						\
> })

__pu_err is shurely not initialized, but migth this be intentionally ?

---

kernel/fork.c: In function `copy_fs':
kernel/fork.c:569: warning: function cannot be inline 
kernel/fork.c: In function `copy_process':
kernel/fork.c:569: warning: can't inline call to `copy_fs'
kernel/fork.c:882: warning: called from here 

	I dont understand WHY copy_fs cannont be inlined ...

kernel/posix-timers.c: In function `unlock_timer':
kernel/posix-timers.c:564: warning: function cannot be inline 

	ditto
---

kernel/suspend.c: In function `freeze_processes':
kernel/suspend.c:228: warning: comparison of distinct pointer types lacks a
	cast

---

drivers/char/vt.c:2457: warning: `return' with a value, in function 
	returning void
drivers/char/vt.c:2497: warning: initialization from incompatible pointer
	type 

I think these Warnings appear as con_init is declared as
	static void __init con_init(void);
but typedef int (*initcall_t)(void); 
suggests that it migth better be static int __init con_init(void) ??


Regards,

	Norbert
