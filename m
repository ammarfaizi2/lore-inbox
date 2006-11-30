Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967804AbWK3Bql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967804AbWK3Bql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967806AbWK3Bql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:46:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:23475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967804AbWK3Bqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:46:40 -0500
Date: Wed, 29 Nov 2006 17:45:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: mingo@redhat.com, lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH -mm] x86_64 UP needs smp_call_function_single
Message-Id: <20061129174558.3dfd13df.akpm@osdl.org>
In-Reply-To: <20061129170111.a0ffb3f4.randy.dunlap@oracle.com>
References: <20061129170111.a0ffb3f4.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 17:01:11 -0800
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> smp_call_function_single() needs to be visible in non-SMP builds, to fix:
> 
> arch/x86_64/kernel/vsyscall.c:283: warning: implicit declaration of function 'smp_call_function_single'
> 
> The (other/trivial) fix (instead of this one) is to add:
> #include <asm/smp.h>
> to linux-2.6.19-rc6-mm2/arch/x86_64/kernel/vsyscall.c
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  include/asm-x86_64/smp.h |    7 -------
>  include/linux/smp.h      |    7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.19-rc6-mm2.orig/include/asm-x86_64/smp.h
> +++ linux-2.6.19-rc6-mm2/include/asm-x86_64/smp.h
> @@ -113,13 +113,6 @@ static __inline int logical_smp_processo
>  #define cpu_physical_id(cpu)		x86_cpu_to_apicid[cpu]
>  #else
>  #define cpu_physical_id(cpu)		boot_cpu_id
> -static inline int smp_call_function_single(int cpuid, void (*func) (void *info),
> -				void *info, int retry, int wait)
> -{
> -	/* Disable interrupts here? */
> -	func(info);
> -	return 0;
> -}
>  #endif /* !CONFIG_SMP */
>  #endif
>  
> --- linux-2.6.19-rc6-mm2.orig/include/linux/smp.h
> +++ linux-2.6.19-rc6-mm2/include/linux/smp.h
> @@ -99,6 +99,13 @@ static inline int up_smp_call_function(v
>  static inline void smp_send_reschedule(int cpu) { }
>  #define num_booting_cpus()			1
>  #define smp_prepare_boot_cpu()			do {} while (0)
> +static inline int smp_call_function_single(int cpuid, void (*func) (void *info),
> +				void *info, int retry, int wait)
> +{
> +	/* Disable interrupts here? */
> +	func(info);
> +	return 0;
> +}
>  
>  #endif /* !SMP */
>  

No, I think this patch is right - the declaration of the CONFIG_SMP
smp_call_function_single() is in linux/smp.h so the !CONFIG_SMP declaration
or definition should be there too.

It's still buggy though.  It should disable local interrupts around the
call to match the SMP version.  I'll fix that separately.

