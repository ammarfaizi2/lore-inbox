Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbUKDKBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbUKDKBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 05:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUKDKA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 05:00:59 -0500
Received: from sartre.ispvip.biz ([209.118.182.154]:54191 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S262150AbUKDKAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 05:00:11 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
From: "Michael J. Cohen" <mjc@unre.st>
To: "K.R. Foley" <kr@cybsft.com>
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <418988A6.4090902@cybsft.com>
References: <4189108C.2050804@blueyonder.co.uk>
	 <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk>
	 <418988A6.4090902@cybsft.com>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 04:59:54 -0500
Message-Id: <1099562394.9633.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > arch/x86_64/kernel/vsyscall.c: At top level:
> > arch/x86_64/kernel/vsyscall.c:56: error: conflicting types for 
> > `__xtime_lock'
> > include/asm/vsyscall.h:48: error: previous declaration of `__xtime_lock'
> 
> Does the patch below fix the above error?
> 
> > arch/x86_64/kernel/vsyscall.c: In function `do_vgettimeofday':
> > arch/x86_64/kernel/vsyscall.c:92: warning: passing arg 1 of `__readl' 
> > makes pointer from integer without a cast
> > make[1]: *** [arch/x86_64/kernel/vsyscall.o] Error 1
> > make: *** [arch/x86_64/kernel] Error 2
> > Regards
> > id.
> > 
> 
> kr
> 
> 
> plain text document attachment (vsyscall.patch2)
> --- linux-2.6.10-rc1-mm2/arch/x86_64/kernel/vsyscall.c.orig	2004-11-03 19:32:26.847377112 -0600
> +++ linux-2.6.10-rc1-mm2/arch/x86_64/kernel/vsyscall.c	2004-11-03 19:34:48.892102334 -0600
> @@ -53,7 +53,7 @@
>  #define force_inline __attribute__((always_inline)) inline
>  
>  int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
> -seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
> +DECLARE_RAW_SEQLOCK(__section_xtime_lock);
>  
>  #include <asm/unistd.h>
>  

I'll jump in.  No, it doesn't compile like this.
I tried:

linux-2.6.10-rc1-mm2/arch/x86_64/kernel/vsyscall.c.orig	2004-11-03
19:32:26.847377112 -0600
+++ linux-2.6.10-rc1-mm2/arch/x86_64/kernel/vsyscall.c	2004-11-03 19:34:48.892102334 -0600
@@ -53,7 +53,7 @@
 #define force_inline __attribute__((always_inline)) inline
 
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
-seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
+raw_seqlock_t __xtime_lock __section_xtime_lock = RAW_SEQLOCK_UNLOCKED;
 
 #include <asm/unistd.h>




which at least compiled that particular file, then had to insert some
new bits into percpu.h for x86-64, so I stole those from asm-generic:

diff -Nru -X dontdiff
linux-2.6.10-rc1-mm2-RT/include/asm-x86_64/percpu.h
linux-2.6.10-rc1-mm2-RT-take1/include/asm-x86_64/percpu.h
--- linux-2.6.10-rc1-mm2-RT/include/asm-x86_64/percpu.h	2004-11-04
04:16:24.000000000 -0500
+++ linux-2.6.10-rc1-mm2-RT-take1/include/asm-x86_64/percpu.h	2004-11-04
02:39:53.000000000 -0500
@@ -17,11 +17,25 @@
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type)
per_cpu__##name
+#define DEFINE_PER_CPU_LOCKED(type, name) \
+    __attribute__((__section__(".data.percpu"))) spinlock_t
per_cpu_lock__##name##_locked = SPIN_LOCK_UNLOCKED; \
+    __attribute__((__section__(".data.percpu"))) __typeof__(type)
per_cpu__##name##_locked
+
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var,
__per_cpu_offset(cpu)))
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var,
__my_cpu_offset()))
 
+#define per_cpu_lock(var, cpu) \
+       (*RELOC_HIDE(&per_cpu_lock__##var##_locked,
__per_cpu_offset[cpu]))
+#define per_cpu_var_locked(var, cpu) \
+               (*RELOC_HIDE(&per_cpu__##var##_locked,
__per_cpu_offset[cpu]))
+#define __get_cpu_lock(var, cpu) \
+               per_cpu_lock(var, cpu)
+#define __get_cpu_var_locked(var, cpu) \
+               per_cpu_var_locked(var, cpu)
+
+
 /* A macro to avoid #include hell... */
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
@@ -39,8 +53,15 @@
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
 
+#define DEFINE_PER_CPU_LOCKED(type, name) \
+    spinlock_t per_cpu_lock__##name##_locked = SPIN_LOCK_UNLOCKED; \
+    __typeof__(type) per_cpu__##name##_locked
+
 #define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
+#define __get_cpu_lock(var, cpu)
per_cpu_lock__##var##_locked
+#define __get_cpu_var_locked(var, cpu)         per_cpu__##var##_locked
+
 
 #endif	/* SMP */

next up, some asm/rwsem.h copy and pasting:

diff -Nru -X dontdiff linux-2.6.10-rc1-mm2-RT/include/asm-x86_64/rwsem.h
linux-2.6.10-rc1-mm2-RT-take1/include/asm-x86_64/rwsem.h
--- linux-2.6.10-rc1-mm2-RT/include/asm-x86_64/rwsem.h	2004-11-04
04:16:24.000000000 -0500
+++ linux-2.6.10-rc1-mm2-RT-take1/include/asm-x86_64/rwsem.h	2004-11-04
03:11:51.000000000 -0500
@@ -44,10 +44,10 @@
 
 struct rwsem_waiter;
 
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore
*sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore
*sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore
*sem);
+extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct
rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct
rw_semaphore *sem));
+extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore
*));
+extern struct rw_semaphore *FASTCALL(rwsem_downgrade_wake(struct
rw_semaphore *sem));
 
 /*
  * the semaphore definition
@@ -70,15 +70,10 @@
 /*
  * initialisation
  */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
 
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED,
LIST_HEAD_INIT((name).wait_list) \
-	__RWSEM_DEBUG_INIT }
+        { RWSEM_UNLOCKED_VALUE, RAW_SPIN_LOCK_UNLOCKED, \
+          LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)



and from there my attempts to clean things up without any knowledge of
wtf is going on totally bail....

  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.text+0x80d8): In function `sys_mmap':
: undefined reference to `__down_write'
arch/x86_64/kernel/built-in.o(.text+0x8110): In function `sys_mmap':
: undefined reference to `__up_write'

tons of those.


------
Michael Cohen


Someday it will all make sense to me.

