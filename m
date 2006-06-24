Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933186AbWFXCV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933186AbWFXCV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933187AbWFXCV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:21:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:30326 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S933186AbWFXCV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:21:27 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=gPLkpCo2vnjDjSZDcvVcPZN8J3RJQtch7E+X9F3Wsc1Y196fhlq6XjsoLcY0UXjMq
	EOYO95Kadb3Qj+AeIIg6w==
Subject: Re: [RFC, patch] i386: vgetcpu() with NUMA support
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Martin Bligh <mbligh@google.com>
In-Reply-To: <200606230954_MC3-1-C33F-7BD8@compuserve.com>
References: <200606230954_MC3-1-C33F-7BD8@compuserve.com>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 23 Jun 2006 19:18:30 -0700
Message-Id: <1151115510.23432.45.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 09:53 -0400, Chuck Ebbert wrote:
> This is attempt #3 at vgetcpu() support for i386.  It uses a GDT entry
> to hold cpu and node number for fast userspace access.
> 
> changes since #2:
>    added NUMA support (compile tested only, please test)
>    speed improvement
>    proper #define for GDT entry number
>    general cleanup & documentation
> 

I think a consistent interface like vgetcpu(*cpunum, *nodenum) will be
good across architectures.  And then add the packagenum as well.

8bits per field seems okay but may run out of steam.

-rohit



> to-do:
>    CFI annotations
> 
> Test program:
> 
> /* vgetcpu.c: test vgetcpu()
>  * boot kernel with vgetcpu patch first, then build with:
>  *  gcc -O3 -o vgetcpu vgetcpu.c <srcpath>/arch/i386/kernel/vsyscall-int80.so
>  * (don't forget the optimization (-O3))
>  */
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> 
> extern int __vgetcpu(void);
> 
> #define rdtscll(t)	asm("rdtsc" : "=A" (t))
> 
> int main(int argc, char * const argv[])
> {
> 	long long tsc1, tsc2;
> 	int i, iters = 999999;
> 	
> 	i = __vgetcpu();
> 	printf("node: %d, cpu: %d\nBenchmarking...\n", i >> 8, i & 0xff);
> 
> 	rdtscll(tsc1);
> 	for (i = 0; i < iters; i++)
> 		__vgetcpu();
> 	rdtscll(tsc2);
> 
> 	printf("vgetcpu() took %llu clocks per call\n", (tsc2 - tsc1) / iters);
> 
> 	return 0;
> }
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
>  arch/i386/kernel/cpu/common.c        |    3 +++
>  arch/i386/kernel/head.S              |    8 +++++++-
>  arch/i386/kernel/smpboot.c           |    2 ++
>  arch/i386/kernel/vsyscall-getcpu.S   |   26 ++++++++++++++++++++++++++
>  arch/i386/kernel/vsyscall-int80.S    |    2 ++
>  arch/i386/kernel/vsyscall-sysenter.S |    2 ++
>  arch/i386/kernel/vsyscall.lds.S      |    1 +
>  include/asm-i386/segment.h           |    4 +++-
>  8 files changed, 46 insertions(+), 2 deletions(-)
> 
> --- 2.6.17-32.orig/arch/i386/kernel/cpu/common.c
> +++ 2.6.17-32/arch/i386/kernel/cpu/common.c
> @@ -642,6 +642,9 @@ void __cpuinit cpu_init(void)
>  		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
>  		(CPU_16BIT_STACK_SIZE - 1);
>  
> +	/* Set up GDT entry for per-cpu data */
> + 	gdt[GDT_ENTRY_VGETCPU].a |= cpu;
> +
>  	cpu_gdt_descr->size = GDT_SIZE - 1;
>   	cpu_gdt_descr->address = (unsigned long)gdt;
>  
> --- 2.6.17-32.orig/arch/i386/kernel/head.S
> +++ 2.6.17-32/arch/i386/kernel/head.S
> @@ -525,7 +525,13 @@ ENTRY(cpu_gdt_table)
>  	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
>  
>  	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
> -	.quad 0x0000000000000000	/* 0xd8 - unused */
> +
> +	/*
> +	 * Use a GDT entry to store per-cpu data for user space (DPL 3.)
> +	 * 32-bit data segment, byte granularity, base 0, limit set at runtime.
> +	 */
> +	.quad 0x0040f20000000000	/* 0xd8 - for per-cpu user data */
> +
>  	.quad 0x0000000000000000	/* 0xe0 - unused */
>  	.quad 0x0000000000000000	/* 0xe8 - unused */
>  	.quad 0x0000000000000000	/* 0xf0 - unused */
> --- /dev/null
> +++ 2.6.17-32/arch/i386/kernel/vsyscall-getcpu.S
> @@ -0,0 +1,26 @@
> +/*
> + * __vgetcpu()
> + *
> + * This file is #include'd by vsyscall-*.S to place vgetcpu after the
> + * sigreturn code.
> + *
> + * Returns logical CPU number in bits 0-7, node ID in bits 8-15;
> + * -EFAULT on error.
> + */
> +
> +#include <linux/errno.h>
> +#include <asm/segment.h>
> +
> +	.text
> +	.org __kernel_rt_sigreturn+32,0x90
> +	.globl __vgetcpu
> +	.type __vgetcpu,@function
> +__vgetcpu:
> +.LSTART_vgetcpu:
> +	movl $((GDT_ENTRY_VGETCPU<<3)|3),%edx
> +	movl $-EFAULT,%eax
> +	lsll %edx,%eax
> +	ret
> +.LEND_vgetcpu:
> +	.size __vgetcpu,.-.LSTART_vgetcpu
> +
> --- 2.6.17-32.orig/arch/i386/kernel/vsyscall-int80.S
> +++ 2.6.17-32/arch/i386/kernel/vsyscall-int80.S
> @@ -51,3 +51,5 @@ __kernel_vsyscall:
>   * Get the common code for the sigreturn entry points.
>   */
>  #include "vsyscall-sigreturn.S"
> +
> +#include "vsyscall-getcpu.S"
> --- 2.6.17-32.orig/arch/i386/kernel/vsyscall-sysenter.S
> +++ 2.6.17-32/arch/i386/kernel/vsyscall-sysenter.S
> @@ -120,3 +120,5 @@ SYSENTER_RETURN:
>   * Get the common code for the sigreturn entry points.
>   */
>  #include "vsyscall-sigreturn.S"
> +
> +#include "vsyscall-getcpu.S"
> --- 2.6.17-32.orig/arch/i386/kernel/vsyscall.lds.S
> +++ 2.6.17-32/arch/i386/kernel/vsyscall.lds.S
> @@ -57,6 +57,7 @@ VERSION
>      	__kernel_vsyscall;
>      	__kernel_sigreturn;
>      	__kernel_rt_sigreturn;
> +	__vgetcpu;
>  
>      local: *;
>    };
> --- 2.6.17-32.orig/arch/i386/kernel/smpboot.c
> +++ 2.6.17-32/arch/i386/kernel/smpboot.c
> @@ -615,6 +615,7 @@ static inline void map_cpu_to_node(int c
>  	printk("Mapping cpu %d to node %d\n", cpu, node);
>  	cpu_set(cpu, node_2_cpu_mask[node]);
>  	cpu_2_node[cpu] = node;
> + 	get_cpu_gdt_table(cpu)[GDT_ENTRY_VGETCPU].a |= (node & 0xff) << 8;
>  }
>  
>  /* undo a mapping between cpu and node. */
> @@ -626,6 +627,7 @@ static inline void unmap_cpu_to_node(int
>  	for (node = 0; node < MAX_NUMNODES; node ++)
>  		cpu_clear(cpu, node_2_cpu_mask[node]);
>  	cpu_2_node[cpu] = 0;
> + 	get_cpu_gdt_table(cpu)[GDT_ENTRY_VGETCPU].a &= ~(0xff << 8);
>  }
>  #else /* !CONFIG_NUMA */
>  
> --- 2.6.17-32.orig/include/asm-i386/segment.h
> +++ 2.6.17-32/include/asm-i386/segment.h
> @@ -39,7 +39,7 @@
>   *  25 - APM BIOS support 
>   *
>   *  26 - ESPFIX small SS
> - *  27 - unused
> + *  27 - vgetcpu() data
>   *  28 - unused
>   *  29 - unused
>   *  30 - unused
> @@ -74,6 +74,8 @@
>  #define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
>  #define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
>  
> +#define GDT_ENTRY_VGETCPU		(GDT_ENTRY_KERNEL_BASE + 15)
> +
>  #define GDT_ENTRY_DOUBLEFAULT_TSS	31
>  
>  /*

