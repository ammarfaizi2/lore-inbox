Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933952AbWKWUzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933952AbWKWUzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933951AbWKWUzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:55:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:19393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933952AbWKWUzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:55:03 -0500
Date: Thu, 23 Nov 2006 12:54:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: ego@in.ibm.com
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       torvalds@osdl.org, dipankar@in.ibm.com
Subject: Re: [PATCH] Handle per-subsystem mutexes for CONFIG_HOTPLUG_CPU not
 set.
Message-Id: <20061123125446.3cd9ff0f.akpm@osdl.org>
In-Reply-To: <20061123131852.GA20313@in.ibm.com>
References: <20061123131852.GA20313@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 18:48:52 +0530
Gautham R Shenoy <ego@in.ibm.com> wrote:

> When CONFIG_HOTPLUG_CPU is not set, lock_cpu_hotplug() and 
> unlock_cpu_hotplug() default to no-ops.
> 
> However, in case of the proposed per-subsystem hotcpu mutex scheme, 
> the hotcpu mutexes will be taken/released, even when
> CONFIG_HOTPLUG_CPU is not set. This is an unnecessary overhead
> both w.r.t space and time ;-)

hm.

> This patch
> 
> * Provides a common interface for all the subsystems to lock and
> unlock their per-subsystem hotcpu mutexes.
> When CONFIG_HOTPLUG_CPU is not set, these operations would be no-ops.
> 
> Usage:
> a) Each hotcpu aware subsystem defines the hotcpu_mutex as follows
> #ifdef CONFIG_HOTPLUG_CPU
> DEFINE_MUTEX(my_hotcpu_mutex);
> #endif
> 
> b) The hotcpu aware subsystem uses
> cpuhotplug_mutex_lock(&my_hotcpu_mutex)
> and 
> cpuhotplug_mutex_unlock(&my_hotcpu_mutex) 
> instead of the usual mutex_lock/mutex_unlock.
> 
> Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
> 
> ---
>  include/linux/cpu.h |   15 +++++++++++++++
>  1 files changed, 15 insertions(+)
> 
> Index: hotplug/include/linux/cpu.h
> ===================================================================
> --- hotplug.orig/include/linux/cpu.h
> +++ hotplug/include/linux/cpu.h
> @@ -24,6 +24,7 @@
>  #include <linux/compiler.h>
>  #include <linux/cpumask.h>
>  #include <asm/semaphore.h>
> +#include <linux/mutex.h>
>  
>  struct cpu {
>  	int node_id;		/* The node which contains the CPU */
> @@ -74,6 +75,17 @@ extern struct sysdev_class cpu_sysdev_cl
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  /* Stop CPUs going up and down. */
> +
> +static inline void cpuhotplug_mutex_lock(struct mutex *cpu_hp_mutex)
> +{
> +	mutex_lock(cpu_hp_mutex);
> +}
> +
> +static inline void cpuhotplug_mutex_unlock(struct mutex *cpu_hp_mutex)
> +{
> +	mutex_unlock(cpu_hp_mutex);
> +}
> +
>  extern void lock_cpu_hotplug(void);
>  extern void unlock_cpu_hotplug(void);
>  #define hotcpu_notifier(fn, pri) {				\
> @@ -86,6 +98,9 @@ extern void unlock_cpu_hotplug(void);
>  int cpu_down(unsigned int cpu);
>  #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
>  #else
> +#define cpuhotplug_mutex_lock(m)	do { } while (0)
> +#define cpuhotplug_mutex_unlock(m)	do { } while (0)
> +

But what to do about the now-unneeded mutex?

We can just leave it there if CONFIG_HOTPLUG_CPU=n but then we'll get
unused variable warnings for statically-defined mutexes.

To fix that would require either

#ifdef CONFIG_HOTPLUG_CPU
#define DEFINE_MUTEX_HOTPLUG_CPU(m) DEFINE_MUTEX(m)
#else
#define DEFINE_MUTEX_HOTPLUG_CPU(m)
#endif

or

#define cpuhotplug_mutex_lock(m)	do { (void)(m); } while (0)


Given that the former won't work, I'd suggest the latter ;)


