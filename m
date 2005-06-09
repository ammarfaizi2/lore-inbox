Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVFIVdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVFIVdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVFIVdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:33:23 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:64674 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262477AbVFIV3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:29:00 -0400
Date: Thu, 9 Jun 2005 23:28:53 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Milan Svoboda <milan.svoboda@centrum.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in Real-Time Preemption
In-Reply-To: <200506091545.24011@centrum.cz>
Message-Id: <Pine.OSF.4.05.10506092053470.14071-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to your program: I couldn't make it fail under PREEMPT_RT. No
matter what the termination value for the while loop in the priority 10
thread I put in the priority 50 thread printed the same "Dif:".
I also put in a global variable, thread_done, which I set in the priority
10 thread after the loop and printed it out along with "Dif:". It was not
set. I also tried to add exit(1) at the end of the priority 10 thread...

I see no odd behaviour.

Esben

On Thu, 9 Jun 2005, Milan Svoboda wrote:

> Hello all,
> 
> I have a test program which creates one thread with SCHED_RR and priority 50. This
> thread creates another thread witch SCHED_RR and priority 10 and then waits some time
> until it exits. Thread with priority of 10 only counts, it should be a cpu-hog and calls sched_yield.
> 
> Problem is that the parent thread (with priority 50) sleeps as long as the thread with priority 10 is
> runnig when runnig on realtime-preempt-2.6.12-rc6-V0.7.48-01 with full preemption enabled.
> 
> I tested this program on 2.4.21-xxx and on 2.6.12-rc6 with realtime-preempt-2.6.12-rc6-V0.7.48-01 with RT preemption
> disabled and results were as expected - parent thread sleeps shorter time then counting thread so program is
> terminated before counting thread could finished it's work.
> 
> #include <pthread.h>
> #include <unistd.h>
> #include <sys/time.h>
> 
> void* thread(void *thread) {
> 	int i;
> 
> 	while (i < 10000) {
> 		sched_yield();
> 		i++;
> 	}
> }
> 
> void* thread_main(void *arg) {
>     pthread_attr_t attr;
> 	pthread_t p;
>     struct sched_param sch;
> 	struct timeval tv1, tv2;
> 	unsigned int dif;
> 
> 	pthread_attr_init(&attr);
> 	pthread_attr_setschedpolicy(&attr, SCHED_RR);
> 
> 	sch.sched_priority = 10;
> 	pthread_attr_setschedparam(&attr, &sch);
> 	pthread_create(&p, &attr, thread, NULL);
> 	pthread_attr_destroy(&attr);
> 
> 	gettimeofday(&tv1, NULL);
> 	usleep(10000);
> 	gettimeofday(&tv2, NULL);
> 
> 	dif = (tv2.tv_sec - tv1.tv_sec) * 1000000 + tv2.tv_usec - tv1.tv_usec;
> 	printf("Dif: %d\n", dif);
> 
> 	exit(0);
> }
> 
> int main(int argc, char** argv) {
>     pthread_attr_t attr;
> 	pthread_t p;
>     struct sched_param sch;
> 
> 	pthread_attr_init(&attr);
> 	pthread_attr_setschedpolicy(&attr, SCHED_RR);
> 
> 	sch.sched_priority = 50;
> 	pthread_attr_setschedparam(&attr, &sch);
> 	pthread_create(&p, &attr, thread_main, NULL);
> 	pthread_attr_destroy(&attr);
> 
> 	while (1) {
> 		sleep(500);
> 	}
> 
> 	return 0;
> }
> 
> Follows important parts from .config:
> 
> .config with RT preemption disabled
> 
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_HOTPLUG=y
> CONFIG_KOBJECT_UEVENT=y
> # CONFIG_IKCONFIG is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SHMEM=y
> CONFIG_CC_ALIGN_FUNCTIONS=0
> CONFIG_CC_ALIGN_LABELS=0
> CONFIG_CC_ALIGN_LOOPS=0
> CONFIG_CC_ALIGN_JUMPS=0
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=0
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> CONFIG_M686=y
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_X86_GENERIC=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=7
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_X86_PPRO_FENCE=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> # CONFIG_SMP is not set
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT_DESKTOP is not set
> # CONFIG_PREEMPT_RT is not set
> # CONFIG_PREEMPT_SOFTIRQS is not set
> # CONFIG_PREEMPT_HARDIRQS is not set
> # CONFIG_PREEMPT_BKL is not set
> CONFIG_ASM_SEMAPHORES=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_NONFATAL is not set
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_X86_REBOOTFIXUPS is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> CONFIG_X86_CPUID=m
> 
> #
> # Profiling support
> #
> CONFIG_PROFILING=y
> CONFIG_OPROFILE=y
> 
> #
> # Kernel hacking
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_LOG_BUF_SHIFT=15
> CONFIG_SCHEDSTATS=y
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> CONFIG_WAKEUP_TIMING=y
> CONFIG_CRITICAL_IRQSOFF_TIMING=y
> CONFIG_CRITICAL_TIMING=y
> CONFIG_LATENCY_TIMING=y
> CONFIG_LATENCY_TRACE=y
> CONFIG_MCOUNT=y
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_FS is not set
> CONFIG_FRAME_POINTER=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_KPROBES=y
> CONFIG_DEBUG_STACK_USAGE=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_4KSTACKS is not set
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
> 
> .config with RT preemption enabled
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_HOTPLUG=y
> CONFIG_KOBJECT_UEVENT=y
> # CONFIG_IKCONFIG is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_PRINTK=y
> CONFIG_BUG=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_SHMEM=y
> CONFIG_CC_ALIGN_FUNCTIONS=0
> CONFIG_CC_ALIGN_LABELS=0
> CONFIG_CC_ALIGN_LOOPS=0
> CONFIG_CC_ALIGN_JUMPS=0
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=0
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> CONFIG_M686=y
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_X86_GENERIC=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=7
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_X86_PPRO_FENCE=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> # CONFIG_SMP is not set
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT_DESKTOP is not set
> CONFIG_PREEMPT_RT=y
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_SOFTIRQS=y
> CONFIG_PREEMPT_HARDIRQS=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_PREEMPT_BKL=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_ASM_SEMAPHORES=y
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_NONFATAL is not set
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_X86_REBOOTFIXUPS is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> CONFIG_X86_CPUID=m
> 
> #
> # Profiling support
> #
> CONFIG_PROFILING=y
> CONFIG_OPROFILE=y
> 
> #
> # Kernel hacking
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_LOG_BUF_SHIFT=15
> CONFIG_SCHEDSTATS=y
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_WAKEUP_TIMING=y
> CONFIG_PREEMPT_TRACE=y
> CONFIG_CRITICAL_PREEMPT_TIMING=y
> CONFIG_CRITICAL_IRQSOFF_TIMING=y
> CONFIG_CRITICAL_TIMING=y
> CONFIG_LATENCY_TIMING=y
> CONFIG_LATENCY_TRACE=y
> CONFIG_MCOUNT=y
> CONFIG_RT_DEADLOCK_DETECT=y
> CONFIG_DEBUG_RT_LOCKING_MODE=y
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_FS is not set
> CONFIG_FRAME_POINTER=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_KPROBES=y
> CONFIG_DEBUG_STACK_USAGE=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_X86_MPPARSE=y
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

