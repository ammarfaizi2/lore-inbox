Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbREXXC1>; Thu, 24 May 2001 19:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbREXXCR>; Thu, 24 May 2001 19:02:17 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:5304 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262485AbREXXCA>;
	Thu, 24 May 2001 19:02:00 -0400
Date: Fri, 25 May 2001 01:01:48 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200105242301.BAA05771@harpo.it.uu.se>
To: engler@csl.Stanford.EDU
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        macro@ds2.pg.gda.pl, mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001 14:10:00 -0700 (PDT), Dawson Engler wrote:

>[BUG]
>/u2/engler/mc/oses/linux/2.4.4-ac8/arch/i386/kernel/nmi.c:47:check_nmi_watchdog: ERROR:VAR:47:47: suspicious var 'tmp' = 1024 bytes:47 [nbytes=1024]
>#define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
>#define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
>
>int __init check_nmi_watchdog (void)
>{
>
>Error --->
>	irq_cpustat_t tmp[NR_CPUS];

Nice work, but I think this is a false positive.

check_nmi_watchdog() is __init and we know exactly when it's called.
The interesting cases (SMP kernel, since for UP NR_CPUS==1) are:

start_kernel -> smp_init -> smp_boot_cpus -> APIC_init_uniprocessor
-> check_nmi_watchdog

and

start_kernel -> smp_init -> smp_boot_cpus -> setup_IO_APIC ->
check_timer -> check_nmi_watchdog

In neither case is the stack large enough that the 1KB blob in
check_nmi_watchdog should pose a problem, I think. (Don't we have
something like 8KB-sizeof(struct task_struct) stack to play with?)

IMHO the checker tool should take call paths into consideration
when trying to detect stack overflow problems. Does it do that?
(I.e. is it polyvariant or monovariant?)

I could write a patch to make 'tmp' __initdata instead, which would
silence the checker tool, but I don't really want to do that unless
someone can convince me that there is a real problem here.

/Mikael
