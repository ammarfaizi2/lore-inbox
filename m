Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759056AbWK3HyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759056AbWK3HyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759058AbWK3HyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:54:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759056AbWK3HyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:54:21 -0500
Date: Wed, 29 Nov 2006 23:54:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH -mm] x86_64 UP needs smp_call_function_single
Message-Id: <20061129235407.7295c31d.akpm@osdl.org>
In-Reply-To: <1164870000.11036.23.camel@earth>
References: <20061129170111.a0ffb3f4.randy.dunlap@oracle.com>
	<20061129174558.3dfd13df.akpm@osdl.org>
	<1164870000.11036.23.camel@earth>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 08:00:00 +0100
Ingo Molnar <mingo@redhat.com> wrote:

> On Wed, 2006-11-29 at 17:45 -0800, Andrew Morton wrote:
> > No, I think this patch is right - the declaration of the CONFIG_SMP
> > smp_call_function_single() is in linux/smp.h so the !CONFIG_SMP
> > declaration
> > or definition should be there too.
> > 
> > It's still buggy though.  It should disable local interrupts around
> > the
> > call to match the SMP version.  I'll fix that separately. 
> 
> hm, didnt i send an updated patch for that already? See the patch below,
> from many days ago. I sent it after the tsc-sync-rewrite patch.
> 

Might have got lost.

> --------------->
> Subject: x86_64: build fixes
> From: Ingo Molnar <mingo@elte.hu>
> 
> x86_64 does not build cleanly on UP:
> 
> arch/x86_64/kernel/vsyscall.c: In function 'cpu_vsyscall_notifier':
> arch/x86_64/kernel/vsyscall.c:282: warning: implicit declaration of
> function 'smp_call_function_single'
> arch/x86_64/kernel/vsyscall.c: At top level:
> arch/x86_64/kernel/vsyscall.c:279: warning: 'cpu_vsyscall_notifier'
> defined but not used
> 
> this patch fixes it by making smp_call_function_single() globally
> available.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  include/asm-x86_64/smp.h |   11 ++---------
>  include/linux/smp.h      |   10 +++++++---
>  kernel/sched.c           |   19 +++++++++++++++++++
>  3 files changed, 28 insertions(+), 12 deletions(-)
> 
> Index: linux/include/asm-x86_64/smp.h
> ===================================================================
> --- linux.orig/include/asm-x86_64/smp.h
> +++ linux/include/asm-x86_64/smp.h
> @@ -115,16 +115,9 @@ static __inline int logical_smp_processo
>  }
>  
>  #ifdef CONFIG_SMP
> -#define cpu_physical_id(cpu)		x86_cpu_to_apicid[cpu]
> +# define cpu_physical_id(cpu)		x86_cpu_to_apicid[cpu]
>  #else
> -#define cpu_physical_id(cpu)		boot_cpu_id
> -static inline int smp_call_function_single(int cpuid, void (*func)
> (void *info),

congratulations-your-first-wordwrapped-patch ;)

> --- linux.orig/kernel/sched.c
> +++ linux/kernel/sched.c
> @@ -1110,6 +1110,25 @@ repeat:
>  	task_rq_unlock(rq, &flags);
>  }
>  
> +#ifndef CONFIG_SMP
> +/*
> + * Call a function on a specific CPU (on UP the function gets executed
> + * on the current CPU, immediately):
> + */
> +int smp_call_function_single(int cpuid, void (*func) (void *info), void
> *info,
> +			     int retry, int wait)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	func(info);
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}

yes, but a) calling the SMP version with local interrupts disabled is a
bug, so we can use bare local_irq_disable() here and b) only two
archictures call or use this function, so all the others don't want a copy
of it.

So I did:

--- a/include/linux/smp.h~up-smp_call_function_single-should-disable-interrupts
+++ a/include/linux/smp.h
@@ -15,6 +15,7 @@ extern void cpu_idle(void);
 #include <linux/kernel.h>
 #include <linux/compiler.h>
 #include <linux/thread_info.h>
+#include <linux/irqflags.h>
 #include <asm/smp.h>
 
 /*
@@ -102,8 +103,9 @@ static inline void smp_send_reschedule(i
 static inline int smp_call_function_single(int cpuid, void (*func) (void *info),
 				void *info, int retry, int wait)
 {
-	/* Disable interrupts here? */
+	local_irq_disable();	/* Match the SMP call environment */
 	func(info);
+	local_irq_enable();
 	return 0;
 }
 
_

which is somewhat unpleasant.  I added a WARN_ON(irqs_disabled()) to the
out-of-line SMP version.


btw, does anyone know why the SMP versions of this function use
spin_lock_bh(&call_lock)?

