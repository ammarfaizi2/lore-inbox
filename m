Return-Path: <linux-kernel-owner+w=401wt.eu-S1762663AbWLKKwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762663AbWLKKwm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762697AbWLKKwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:52:42 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:45113 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762663AbWLKKwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:52:42 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] get rid of ARCH_HAVE_XTIME_LOCK
Date: Mon, 11 Dec 2006 11:52:56 +0100
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <20061211100301.GD4587@ftp.linux.org.uk> <20061211021718.a6954106.akpm@osdl.org>
In-Reply-To: <20061211021718.a6954106.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IiTfFJH79Q0lCAJ"
Message-Id: <200612111152.56945.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_IiTfFJH79Q0lCAJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As suggested by Andrew, we can use __attribute__((weak)) to get rid of 
ARCH_HAVE_XTIME_LOCK

Please note I compiled, and boot tested on ia32 this patch, and it seems OK.
I compiled on x86_64 and got same resulting vmlinux image.

But I suspect some tools might have problems because vmlinux have its 
first 'weak data symbol' defined. AFAIK __attribute__((weak)) was only used 
on text symbols.

# nm vmlinux | grep ' V '
c03b01c0 V xtime_lock

[PATCH] get rid of ARCH_HAVE_XTIME_LOCK

ARCH_HAVE_XTIME_LOCK is used by x86_64 arch . This arch needs to place a read 
only copy of xtime_lock into vsyscall page. This read only copy is named 
__xtime_lock, and xtime_lock is defined in arch/x86_64/kernel/vmlinux.lds.S 
as an alias. So the declaration of xtime_lock in kernel/timer.c was guarded 
by ARCH_HAVE_XTIME_LOCK define, defined to true on x86_64.

We can get same result with _attribute__((weak)) in the declaration. linker 
should do the job.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_IiTfFJH79Q0lCAJ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ARCH_HAVE_XTIME_LOCK.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ARCH_HAVE_XTIME_LOCK.patch"

--- linux-2.6.19/kernel/timer.c	2006-12-11 11:25:50.000000000 +0100
+++ linux-2.6.19-ed/kernel/timer.c	2006-12-11 11:31:30.000000000 +0100
@@ -1020,11 +1020,9 @@ static inline void calc_load(unsigned lo
  * This read-write spinlock protects us from races in SMP while
  * playing with xtime and avenrun.
  */
-#ifndef ARCH_HAVE_XTIME_LOCK
-__cacheline_aligned_in_smp DEFINE_SEQLOCK(xtime_lock);
+__attribute__((weak)) __cacheline_aligned_in_smp DEFINE_SEQLOCK(xtime_lock);
 
 EXPORT_SYMBOL(xtime_lock);
-#endif
 
 /*
  * This function runs timers and the timer-tq in bottom half context.
--- linux-2.6.19/include/linux/time.h	2006-12-11 11:34:54.000000000 +0100
+++ linux-2.6.19-ed/include/linux/time.h	2006-12-11 11:34:54.000000000 +0100
@@ -90,7 +90,7 @@ static inline struct timespec timespec_s
 
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
-extern seqlock_t xtime_lock;
+extern seqlock_t xtime_lock __attribute__((weak));
 
 void timekeeping_init(void);
 
--- linux-2.6.19/include/asm-x86_64/vsyscall.h	2006-12-11 11:34:54.000000000 +0100
+++ linux-2.6.19-ed/include/asm-x86_64/vsyscall.h	2006-12-11 11:34:54.000000000 +0100
@@ -55,11 +55,6 @@ extern struct vxtime_data vxtime;
 extern int vgetcpu_mode;
 extern struct timezone sys_tz;
 extern int sysctl_vsyscall;
-extern seqlock_t xtime_lock;
-
-extern int sysctl_vsyscall;
-
-#define ARCH_HAVE_XTIME_LOCK 1
 
 #endif /* __KERNEL__ */
 

--Boundary-00=_IiTfFJH79Q0lCAJ--
