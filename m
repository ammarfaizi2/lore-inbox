Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbRGRRHn>; Wed, 18 Jul 2001 13:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267864AbRGRRHe>; Wed, 18 Jul 2001 13:07:34 -0400
Received: from unamed.infotel.bg ([212.39.68.18]:15372 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S267504AbRGRRHb>;
	Wed, 18 Jul 2001 13:07:31 -0400
Date: Wed, 18 Jul 2001 20:08:16 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <200107181510.f6IFAMW03662@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10107181910510.23130-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Wed, 18 Jul 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.10.10107181347030.16710-100000@l> you write:
> >
> >	I don't know whether cpuid_eax (2.4.7pre) should preserve the
> >registers changed from cpuid
>
> It should. It has the proper "this instruction assigned values to these
> registers" stuff, so gcc should know which ones change.
>
> >			 but I have an oops on boot with 2.4.7pre7 in
> >squash_the_stupid_serial_number where cpuid_eax changes ebx and the
> >parameter "c" is loaded with "Genu". The following change fixes the
> >problem:
>
> Interesting. Can you do the following:
>
>  - tell us your compiler version

root@l:~# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
root@l:~# make --version
GNU Make version 3.77, by Richard Stallman and Roland McGrath.
...
root@l:~# ld -v
GNU ld version 2.9.1 (with BFD 2.9.1.0.24)

root@l:~# insmod -V
insmod version 2.4.6

it seems my binutils is older than the recommended 2.9.1.0.25 :(

>  - do a "make arch/i386/kernel/setup.s" both ways, and show what
>    squash_the_stupid_serial_number() looks like.

	Both with "a" and "0" (zero) gcc shows same output in setup.s
(using cpuid_eax):

.Lfe20:
	.size	 deep_magic_nexgen_probe,.Lfe20-deep_magic_nexgen_probe
.section	.rodata
	.align 32
.LC127:
	.string	"<5>CPU serial number disabled.\n"
.section	.text.init
	.align 4
	.type	 squash_the_stupid_serial_number,@function
squash_the_stupid_serial_number:
	pushl %esi
	pushl %ebx
	movl 12(%esp),%ebx
	movl 12(%ebx),%eax
	testl $262144,%eax
	je .L2393
	cmpl $0,disable_x86_serial_nr
	je .L2393
	movl $281,%ecx
#APP
	rdmsr
#NO_APP
	movl %eax,%esi
	orl $2097152,%esi
	movl %esi,%eax
#APP
	wrmsr
#NO_APP
	pushl $.LC127
	call printk
	addl $4,%esp
#APP
	lock ; btrl $18,12(%ebx)
#NO_APP
	xorl %eax,%eax
#APP
	cpuid					<<<-- cpuid_eax
#NO_APP
	movl %eax,8(%ebx)			<<<-- oops
.L2393:
	popl %ebx
	popl %esi
	ret


>  - fix _all_ the "cpuid*()" functions to have
>
> 	:"0" (op)

	does not help in my case, other solutions? And without recompile
anyone can see its vmlinux file too (disassemble squash_the_stupid_serial_number)

	Even by using cpuid(...) replacement the registers are not
preserved but instead of ebx, the arg "c" is in ebp and the oops does not
occur:

0xc029ef94 <squash_the_stupid_serial_number+68>:        xor    %eax,%eax
0xc029ef96 <squash_the_stupid_serial_number+70>:        cpuid
0xc029ef98 <squash_the_stupid_serial_number+72>:        mov    %eax,0x8(%ebp)


	It seems the problem remains in cpuid_XXX funcs.

>    instead of their current incorrect
>
> 	:"a" (op)
>
>    (we're supposed to explicitly tell the compiler that the first input
>    is the same as the first output)
>
>  - see if that makes any difference to the assembler output.
>
> In any case it does sound like a compiler bug, but it would be good to
> have a workaround. But it would also be good to have a more complete
> dump of the oops in question to see more about what is going on..

	After fixing this with cpuid() I can work perfectly with this
kernel on network activity (45K packets/sec), SMP. So, only cpuid_xxx are
suspected for now. I don't preserve the oopses but I can do it if the
attached in another mail setup.s is not enough. This problem does not
occur in 2.4.6 and below, I have tried 2.4.2 - 2.4.7pre7 with the same
gcc, etc. It seems only in squash_XXX the ebx damage was noticed.

Part from .config:

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y


2nd CPU (same as 1st, I don't see problems in the detection):

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 864.004
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1723.59


> 		Thanks,
> 			Linus


Regards

--
Julian Anastasov <ja@ssi.bg>

