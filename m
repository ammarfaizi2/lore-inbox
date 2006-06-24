Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWFXPiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWFXPiW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWFXPiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:38:22 -0400
Received: from smtp-out.google.com ([216.239.45.12]:46325 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750836AbWFXPiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:38:21 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=tSM1XZA/oDXbMzOI48Aay9kC0qpq8syzjnPwlv/wSWAT3bEdGYX7fMhs25ocI7ntm
	CkpSxHSXENPZW54W0sH2w==
Message-ID: <449D5C21.5060600@google.com>
Date: Sat, 24 Jun 2006 08:37:05 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohitseth@google.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC, patch] i386: vgetcpu() for NUMA, take 2
References: <200606240426_MC3-1-C354-E4BC@compuserve.com>
In-Reply-To: <200606240426_MC3-1-C354-E4BC@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> This is attempt #2 at vgetcpu() NUMA support for i386.  It uses a
> GDT entry to hold cpu and node number for fast userspace access.
> 
> changes since #1:
>    proper function prototype (same as x86_64)
>    changed alignment of vsyscall functions to 16 bytes
>         (sigreturn needs to stay fixed, others can move)
> 
> to-do:
>    CFI annotations
>    test NUMA on real NUMA hardware (someone please test)

What was the point of returning wrong info to userspace really quickly?
;-) (ie you could have migrated CPUs, so it's totally unreliable)

Is this just for some statistical monitoring thing?

M.

> Test program:
> 
> /* vgetcpu.c: test how fast vgetcpu runs
>  * boot kernel with vgetcpu patch first, then:
>  *  gcc -O3 -o vgetcpu vgetcpu.c <srcpath>/arch/i386/kernel/vsyscall-int80.so
>  * (don't forget the optimization (-O3))
>  */
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> 
> extern int __attribute__ ((regparm(2))) __vgetcpu(int *cpu, int *node);
> 
> #define rdtscll(t)	asm("rdtsc" : "=A" (t))
> 
> int main(int argc, char * const argv[])
> {
> 	long long tsc1, tsc2;
> 	int i, cpu = 999, node = 999, iters = 99999;
> 	
> 	if (__vgetcpu(&cpu, &node) || node == 999 || cpu == 999) {
> 		printf("vgetcpu failed!\n");
> 		_exit(1);
> 	}
> 	printf("node: %d, cpu: %d\n", node, cpu);
> 
> 	rdtscll(tsc1);
> 	for (i = 0; i < iters; i++)
> 		__vgetcpu(&cpu, &node);
> 	rdtscll(tsc2);
> 
> 	printf("vgetcpu took %llu clocks per call\n", (tsc2 - tsc1) / iters);
> 
> 	return 0;
> }
> 
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
>  arch/i386/kernel/cpu/common.c         |    3 ++
>  arch/i386/kernel/head.S               |   11 +++++++-
>  arch/i386/kernel/smpboot.c            |    2 +
>  arch/i386/kernel/vsyscall-getcpu.S    |   42 ++++++++++++++++++++++++++++++++++
>  arch/i386/kernel/vsyscall-int80.S     |    2 +
>  arch/i386/kernel/vsyscall-sigreturn.S |    3 --
>  arch/i386/kernel/vsyscall-sysenter.S  |    2 +
>  arch/i386/kernel/vsyscall.lds.S       |    1 
>  include/asm-i386/segment.h            |    4 ++-
>  9 files changed, 65 insertions(+), 5 deletions(-)
> 
> --- 2.6.17-32.orig/arch/i386/kernel/cpu/common.c
> +++ 2.6.17-32/arch/i386/kernel/cpu/common.c
> @@ -642,6 +642,9 @@ void __cpuinit cpu_init(void)
>  		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
>  		(CPU_16BIT_STACK_SIZE - 1);
>  
> +	/* Set up GDT entry for per-cpu data */
> + 	gdt[GDT_ENTRY_VGETCPU].a |= cpu & 0xff;
> +
>  	cpu_gdt_descr->size = GDT_SIZE - 1;
>   	cpu_gdt_descr->address = (unsigned long)gdt;
>  
> --- 2.6.17-32.orig/arch/i386/kernel/head.S
> +++ 2.6.17-32/arch/i386/kernel/head.S
> @@ -480,7 +480,7 @@ ENTRY(boot_gdt_table)
>  	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
>  
>  /*
> - * The Global Descriptor Table contains 28 quadwords, per-CPU.
> + * The Global Descriptor Table contains 32 quadwords, per-CPU.
>   */
>  	.align L1_CACHE_BYTES
>  ENTRY(cpu_gdt_table)
> @@ -525,7 +525,14 @@ ENTRY(cpu_gdt_table)
>  	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
>  
>  	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
> -	.quad 0x0000000000000000	/* 0xd8 - unused */
> +
> +	/*
> +	 * Use GDT entries to store per-cpu data for user space (DPL 3.)
> +	 * 32-bit data segment, byte granularity, base 0, limit set at runtime.
> +	 * Userspace will use LSL to access this data, stored in the limit field.
> +	 */
> +	.quad 0x0040f20000000000	/* 0xd8 - nodeid and logical CPU number */
> +
>  	.quad 0x0000000000000000	/* 0xe0 - unused */
>  	.quad 0x0000000000000000	/* 0xe8 - unused */
>  	.quad 0x0000000000000000	/* 0xf0 - unused */
> --- /dev/null
> +++ 2.6.17-32/arch/i386/kernel/vsyscall-getcpu.S
> @@ -0,0 +1,42 @@
> +/*
> + * fastcall int __vgetcpu(int *cpu, int *node)
> + *
> + * This file is #include'd by vsyscall-*.S to place vgetcpu after the
> + * sigreturn code.
> + *
> + * Puts logical CPU number in *cpu, node ID in *node;
> + * returns 0 for success and -EFAULT on error.
> + *
> + * CPU number and node ID are 8 bits each, with 4 total bits available
> + * for future growth of either field.
> + */
> +
> +#include <linux/errno.h>
> +#include <asm/segment.h>
> +
> +	.text
> +	.balign 16
> +	.globl __vgetcpu
> +	.type __vgetcpu,@function
> +__vgetcpu:
> +.LSTART_vgetcpu:
> +	mov $((GDT_ENTRY_VGETCPU<<3)|3),%cx
> +	lsl %ecx,%ecx
> +	jnz 1f
> +	push %ecx
> +	and $0xff,%ecx		/* 8-bit cpu number */
> +	mov %ecx,(%eax)
> +	pop %ecx
> +	xor %eax,%eax
> +	shr $8,%ecx		/* assume top 4 bits are zero */
> +	mov %ecx,(%edx)
> +	ret
> +1:
> +	push $-EFAULT		/* saves 2 bytes of .text */
> +	pop %eax
> +	ret
> +.LEND_vgetcpu:
> +	.size __vgetcpu,.-.LSTART_vgetcpu
> +	.previous
> +
> +/* ZZZ: need CFI annotations here */
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
> --- 2.6.17-32.orig/arch/i386/kernel/vsyscall-sigreturn.S
> +++ 2.6.17-32/arch/i386/kernel/vsyscall-sigreturn.S
> @@ -26,7 +26,7 @@ __kernel_sigreturn:
>  .LEND_sigreturn:
>  	.size __kernel_sigreturn,.-.LSTART_sigreturn
>  
> -	.balign 32
> +	.balign 16
>  	.globl __kernel_rt_sigreturn
>  	.type __kernel_rt_sigreturn,@function
>  __kernel_rt_sigreturn:
> @@ -35,7 +35,6 @@ __kernel_rt_sigreturn:
>  	int $0x80
>  .LEND_rt_sigreturn:
>  	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
> -	.balign 32
>  	.previous
>  
>  	.section .eh_frame,"a",@progbits

