Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274675AbSITDEF>; Thu, 19 Sep 2002 23:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274684AbSITDEF>; Thu, 19 Sep 2002 23:04:05 -0400
Received: from franka.aracnet.com ([216.99.193.44]:16778 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S274675AbSITDED>; Thu, 19 Sep 2002 23:04:03 -0400
Date: Thu, 19 Sep 2002 20:07:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] x86_udelay_tsc not honoring notsc
Message-ID: <463074285.1032466006@[10.10.2.3]>
In-Reply-To: <20020920001001.GQ28202@holomorphy.com>
References: <20020920001001.GQ28202@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this help (on top of John's TSC patch in rollup 0)?

diff -urN -X /home/fletch/.diff.exclude virgin/include/asm-i386/cpufeature.h cpu_has_tsc/include/asm-i386/cpufeature.h
--- virgin/include/asm-i386/cpufeature.h	Mon Sep  9 10:35:04 2002
+++ cpu_has_tsc/include/asm-i386/cpufeature.h	Thu Sep 19 20:07:11 2002
@@ -70,7 +70,11 @@
 #define cpu_has_vme		boot_cpu_has(X86_FEATURE_VME)
 #define cpu_has_de		boot_cpu_has(X86_FEATURE_DE)
 #define cpu_has_pse		boot_cpu_has(X86_FEATURE_PSE)
-#define cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
+#ifdef CONFIG_X86_TSC
+#define cpu_has_tsc             boot_cpu_has(X86_FEATURE_TSC)
+#else
+#define cpu_has_tsc             (0)
+#endif
 #define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
 #define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
 #define cpu_has_apic
	boot_cpu_has(X86_FEATURE_APIC)


--On Thursday, September 19, 2002 5:10 PM -0700 William Lee Irwin III <wli@holomorphy.com> wrote:

> Even though I booted with notsc, rdtsc happens here and appears to
> generate #GP or some such nonsense:
> 
> Restoring NMI vector
> Booting processor 14/52 eip 2000
> Initializing CPU#14
> masked ExtINT on CPU#14
> Leaving ESR disabled.
> Calibrating delay loop...
> Program received signal SIGEMT, Emulation trap.
> __rdtsc_delay (loops=69700) at delay.c:40
> 40      delay.c: No such file or directory.
>         in delay.c
> (gdb) bt
># 0  __rdtsc_delay (loops=69700) at delay.c:40
># 1  0xc019f31d in __delay (loops=69700) at delay.c:63
># 2  0xc019f384 in __const_udelay (xloops=429400) at delay.c:74
># 3  0xc02c1709 in do_boot_cpu (apicid=52) at smpboot.c:865
># 4  0xc02c1a4e in smp_boot_cpus (max_cpus=4294967295) at smpboot.c:1095
># 5  0xc02c1c70 in smp_prepare_cpus (max_cpus=4294967295) at smpboot.c:1199
># 6  0xc01050d7 in init (unused=0x0) at main.c:547
> (gdb) p $eip       
> $3 = (void *) 0xc019f2d4
> (gdb) disassemble $eip
> Dump of assembler code for function __rdtsc_delay:
> 0xc019f2c0 <__rdtsc_delay>:     push   %ebp
> 0xc019f2c1 <__rdtsc_delay+1>:   mov    %esp,%ebp
> 0xc019f2c3 <__rdtsc_delay+3>:   push   %ebx
> 0xc019f2c4 <__rdtsc_delay+4>:   mov    0x8(%ebp),%ebx
> 0xc019f2c7 <__rdtsc_delay+7>:   rdtsc  
> 0xc019f2c9 <__rdtsc_delay+9>:   mov    %eax,%ecx
> 0xc019f2cb <__rdtsc_delay+11>:  nop    
> 0xc019f2cc <__rdtsc_delay+12>:  lea    0x0(%esi,1),%esi
> 0xc019f2d0 <__rdtsc_delay+16>:  repz nop 
> 0xc019f2d2 <__rdtsc_delay+18>:  rdtsc  
> 0xc019f2d4 <__rdtsc_delay+20>:  sub    %ecx,%eax
> 0xc019f2d6 <__rdtsc_delay+22>:  cmp    %ebx,%eax
> 0xc019f2d8 <__rdtsc_delay+24>:  jb     0xc019f2d0 <__rdtsc_delay+16>
> 0xc019f2da <__rdtsc_delay+26>:  pop    %ebx
> 0xc019f2db <__rdtsc_delay+27>:  mov    %ebp,%esp
> 0xc019f2dd <__rdtsc_delay+29>:  pop    %ebp
> 0xc019f2de <__rdtsc_delay+30>:  ret    
> End of assembler dump.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


