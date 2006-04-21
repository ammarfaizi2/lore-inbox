Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWDUHpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWDUHpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWDUHpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:45:23 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58521 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751300AbWDUHpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:45:22 -0400
Date: Fri, 21 Apr 2006 09:48:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gerd Hoffmann <kraxel@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU
Message-ID: <20060421074858.GA28858@elte.hu>
References: <20060419094630.GA14800@elte.hu> <20060420052954.GA5524@elte.hu> <Pine.LNX.4.64.0604200759400.3701@g5.osdl.org> <20060420152609.GA21993@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20060420152609.GA21993@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > There must be another bug there somewhere. It's not about cache 
> > coherency.
> 
> ok. Maybe it's in one of the patches i have applied. I'll re-check 
> with vanilla.

ok, found the bug after quite some debugging - it seems to be caused by 
a tools bug related to section nesting, which triggered with some valid 
changes to mutex.c i had in my tree, but which changes are not upstream.

to reproduce the bug on vanilla, turn on CONFIG_DEBUG_MUTEXES and apply 
the hack-patch i attached (WARNING: it is a totally broken, 
non-functional patch, it just demonstrates the build bug! This is a 
minimalized version of the effects the locking-correctness prover i'm 
working has on mutex.c)

with that done i get these warnings from the assembler:

  CC      kernel/mutex.o
{standard input}: Assembler messages:
{standard input}:226: Warning: .space or .fill with negative value, ignored
{standard input}:314: Warning: .space or .fill with negative value, ignored
{standard input}:371: Warning: .space or .fill with negative value, ignored
{standard input}:533: Warning: .space or .fill with negative value, ignored
{standard input}:586: Warning: .space or .fill with negative value, ignored

you can also try the mutex.bad.s file i attached:

 $ as mutex.s.bad
 mutex.s.bad: Assembler messages:
 mutex.s.bad:267: Warning: .space or .fill with negative value, ignored
 mutex.s.bad:355: Warning: .space or .fill with negative value, ignored
 mutex.s.bad:412: Warning: .space or .fill with negative value, ignored
 mutex.s.bad:574: Warning: .space or .fill with negative value, ignored
 mutex.s.bad:627: Warning: .space or .fill with negative value, ignored

which is caused by the following, pretty valid assembly code of the 
smp-alternatives feature:

        .fill 662b-661b,1,0x42

this is only a build-time warning, but the .smp_altinstr_replacement 
sections get fatally mis-sized due to this, and this caused the 
cpu-hotplug related crash i reported.

i dont know the precise reason why this is causing problems for the 
assembler - the assembly code is 100% perfect AFAICS, but it's related 
to section nesting: when i move around the first such .fill instance 
within the .s assembly file, it suddenly starts working. In particular, 
moving the first .smp_altinstr_replacement section to within the 
.sched.text section made things work fine. This is true even if 
.smp_altinstr_replacement is an empty section - the assembler gets 
confused. I tried multiple versions of gas:

 GNU assembler 2.16.91.0.3 20050821
 GNU assembler 2.16.91.0.6 20060212

all produce this problem.

This led me to the second patch below: moving mutex_trylock into __sched 
works around the problem.

	Ingo

NOT-Signed-off-by: Ingo Molnar <mingo@elte.hu>
Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -30,6 +30,19 @@
 # include <asm/mutex.h>
 #endif
 
+#undef spin_lock_mutex
+#undef spin_unlock_mutex
+
+#define spin_lock_mutex(lock)				\
+	do {						\
+		__raw_spin_lock(&(lock)->raw_lock);	\
+	} while (0)
+
+#define spin_unlock_mutex(lock)				\
+	do {						\
+		__raw_spin_unlock(&(lock)->raw_lock);	\
+	} while (0)
+
 /***
  * mutex_init - initialize the mutex
  * @lock: the mutex to be initialized

--------------
From: Ingo Molnar <mingo@elte.hu>

work around weird section nesting build bug causing smp-alternatives
failures under certain circumstances.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/mutex.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -306,7 +306,7 @@ static inline int __mutex_trylock_slowpa
  * This function must not be used in interrupt context. The
  * mutex must be released by the same task that acquired it.
  */
-int fastcall mutex_trylock(struct mutex *lock)
+int fastcall __sched mutex_trylock(struct mutex *lock)
 {
 	return __mutex_fastpath_trylock(&lock->count,
 					__mutex_trylock_slowpath);

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mutex.bad.s"

	.file	"mutex.c"
# GNU C version 4.0.2 20051125 (Red Hat 4.0.2-8) (i386-redhat-linux)
#	compiled by GNU C version 4.0.2 20051125 (Red Hat 4.0.2-8).
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  -nostdinc -Iinclude -Iinclude/asm-i386/mach-default
# -D__KERNEL__ -DKBUILD_STR(s)=#s -DKBUILD_BASENAME=KBUILD_STR(mutex)
# -DKBUILD_MODNAME=KBUILD_STR(mutex) -isystem -include -MD -m32
# -msoft-float -mpreferred-stack-boundary=2 -march=i686 -mtune=pentium3
# -auxbase-strip -Os -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
# -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-aliasing
# -fno-common -fno-omit-frame-pointer -fno-optimize-sibling-calls
# -ffreestanding -fverbose-asm
# options enabled:  -falign-loops -fargument-alias -fbranch-count-reg
# -fcaller-saves -fcprop-registers -fcrossjumping -fcse-follow-jumps
# -fcse-skip-blocks -fdefer-pop -fdelete-null-pointer-checks
# -feliminate-unused-debug-types -fexpensive-optimizations -fforce-mem
# -ffunction-cse -fgcse -fgcse-lm -fguess-branch-probability -fident
# -fif-conversion -fif-conversion2 -finline-functions
# -finline-functions-called-once -fivopts -fkeep-static-consts
# -fleading-underscore -floop-optimize -floop-optimize2 -fmath-errno
# -fmerge-constants -foptimize-register-move -fpcc-struct-return -fpeephole
# -fpeephole2 -fregmove -freorder-functions -frerun-cse-after-loop
# -frerun-loop-opt -fsched-interblock -fsched-spec
# -fsched-stalled-insns-dep -fschedule-insns2 -fsplit-ivs-in-unroller
# -fstrength-reduce -fthread-jumps -ftrapping-math -ftree-ccp
# -ftree-copyrename -ftree-dce -ftree-dominator-opts -ftree-dse -ftree-fre
# -ftree-loop-im -ftree-loop-ivcanon -ftree-loop-optimize -ftree-lrs
# -ftree-sra -ftree-ter -funit-at-a-time -fverbose-asm
# -fzero-initialized-in-bss -mieee-fp -mno-fancy-math-387 -mno-red-zone
# -mtls-direct-seg-refs -mtune=pentium3 -march=i686
# -mpreferred-stack-boundary=2

	.section	__ksymtab,"a",@progbits
	.align 4
	.type	__ksymtab_mutex_trylock, @object
	.size	__ksymtab_mutex_trylock, 8
__ksymtab_mutex_trylock:
# value:
	.long	mutex_trylock
# name:
	.long	__kstrtab_mutex_trylock
	.section	__ksymtab_strings,"a",@progbits
	.type	__kstrtab_mutex_trylock, @object
	.size	__kstrtab_mutex_trylock, 14
__kstrtab_mutex_trylock:
	.string	"mutex_trylock"
	.section	__ksymtab
	.align 4
	.type	__ksymtab_mutex_lock_interruptible, @object
	.size	__ksymtab_mutex_lock_interruptible, 8
__ksymtab_mutex_lock_interruptible:
# value:
	.long	mutex_lock_interruptible
# name:
	.long	__kstrtab_mutex_lock_interruptible
	.section	__ksymtab_strings
	.type	__kstrtab_mutex_lock_interruptible, @object
	.size	__kstrtab_mutex_lock_interruptible, 25
__kstrtab_mutex_lock_interruptible:
	.string	"mutex_lock_interruptible"
	.section	__ksymtab
	.align 4
	.type	__ksymtab_mutex_unlock, @object
	.size	__ksymtab_mutex_unlock, 8
__ksymtab_mutex_unlock:
# value:
	.long	mutex_unlock
# name:
	.long	__kstrtab_mutex_unlock
	.section	__ksymtab_strings
	.type	__kstrtab_mutex_unlock, @object
	.size	__kstrtab_mutex_unlock, 13
__kstrtab_mutex_unlock:
	.string	"mutex_unlock"
	.section	__ksymtab
	.align 4
	.type	__ksymtab_mutex_lock, @object
	.size	__ksymtab_mutex_lock, 8
__ksymtab_mutex_lock:
# value:
	.long	mutex_lock
# name:
	.long	__kstrtab_mutex_lock
	.section	__ksymtab_strings
	.type	__kstrtab_mutex_lock, @object
	.size	__kstrtab_mutex_lock, 11
__kstrtab_mutex_lock:
	.string	"mutex_lock"
	.section	__ksymtab
	.align 4
	.type	__ksymtab___mutex_init, @object
	.size	__ksymtab___mutex_init, 8
__ksymtab___mutex_init:
# value:
	.long	__mutex_init
# name:
	.long	__kstrtab___mutex_init
	.section	__ksymtab_strings
	.type	__kstrtab___mutex_init, @object
	.size	__kstrtab___mutex_init, 13
__kstrtab___mutex_init:
	.string	"__mutex_init"
	.text
.globl __mutex_init
	.type	__mutex_init, @function
__mutex_init:
	pushl	%ebp	#
	movl	%esp, %ebp	#,
	pushl	%ecx	#
	movl	$1, (%eax)	#, <variable>.count.counter
	movl	$0, -4(%ebp)	#, SR.124
	movl	$1, -4(%ebp)	#, SR.124
	movl	$0, 8(%eax)	#, <variable>.wait_lock.break_lock
	movl	-4(%ebp), %ecx	# SR.124, SR.124
	movl	%ecx, 4(%eax)	# SR.124, <variable>.wait_lock.raw_lock.slock
	leal	12(%eax), %ecx	#, list
	movl	%ecx, 12(%eax)	# list, <variable>.next
	movl	%ecx, 4(%ecx)	# list, <variable>.prev
	pushl	%edx	# name
	pushl	%eax	# lock
	call	debug_mutex_init	#
	popl	%eax	#
	popl	%edx	#
	leave
	ret
	.size	__mutex_init, .-__mutex_init
.globl mutex_trylock
	.type	mutex_trylock, @function
mutex_trylock:
	pushl	%ebp	#
	movl	%esp, %ebp	#,
	pushl	%esi	#
	pushl	%ebx	#
	movl	%eax, %ebx	# lock, lock
#APP
	661:
	
1:	lock ; decb 4(%eax)	# <variable>.slock
	jns 3f
2:	rep;nop
	cmpb $0,4(%eax)	# <variable>.slock
	jle 2b
	jmp 1b
3:
	
662:
.section .smp_altinstructions,"a"
  .align 4
  .long 661b
  .long 663f
  .byte 0x68
  .byte 662b-661b
  .byte 664f-663f
.previous
.section .smp_altinstr_replacement,"awx"
663:
	
	decb 4(%eax)	# <variable>.slock
664:
	.fill 662b-661b,1,0x42
.previous
#NO_APP
	orl	$-1, %esi	#, x
#APP
	xchgl %esi,(%eax)	# x,* lock
#NO_APP
	cmpl	$1, %esi	#, x
	jne	.L4	#,
	pushl	4(%ebp)	#
	movl	$-4096, %eax	#, tmp70
#APP
	andl %esp,%eax; 	# tmp70
#NO_APP
	pushl	%eax	# tmp70
	pushl	%ebx	# lock
	call	debug_mutex_set_owner	#
	addl	$12, %esp	#,
.L4:
	leal	12(%ebx), %eax	#, head
	cmpl	%eax, 12(%ebx)	# head, <variable>.next
	jne	.L6	#,
	movl	$0, (%ebx)	#, <variable>.count.counter
.L6:
#APP
	movb $1,4(%ebx)	# <variable>.slock
#NO_APP
	xorl	%eax, %eax	# tmp72
	cmpl	$1, %esi	#, x
	sete	%al	#, tmp72
	leal	-8(%ebp), %esp	#,
	popl	%ebx	#
	popl	%esi	#
	popl	%ebp	#
	ret
	.size	mutex_trylock, .-mutex_trylock
	.section	.rodata
	.type	__func__.9091, @object
	.size	__func__.9091, 24
__func__.9091:
	.string	"__mutex_unlock_slowpath"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"kernel/mutex.c"
.LC1:
	.string	"BUG: warning at %s:%d/%s()\n"
	.section	.sched.text,"ax",@progbits
	.type	__mutex_unlock_slowpath, @function
__mutex_unlock_slowpath:
	pushl	%ebp	#
	movl	%esp, %ebp	#,
	pushl	%esi	#
	movl	%eax, %esi	# lock_count, lock
	movl	$-4096, %eax	#, tmp74
#APP
	andl %esp,%eax; 	# tmp74
#NO_APP
	cmpl	%eax, 20(%esi)	# tmp74, <variable>.owner
	pushl	%ebx	#
	je	.L14	#,
	cmpl	$0, debug_mutex_on	#, debug_mutex_on
	je	.L14	#,
	movl	console_printk, %eax	# console_printk, console_printk
	movl	$15, %edx	#, tmp82
	movl	$0, debug_mutex_on	#, debug_mutex_on
	testl	%eax, %eax	# console_printk
	cmove	%eax, %edx	# console_printk,, tmp82
	movb	debug_mutex_lock, %al	#, D.9103
	movl	%edx, console_printk	# tmp82, console_printk
	testb	%al, %al	# D.9103
	jg	.L16	#,
	movl	$debug_mutex_lock, %eax	#,
	call	_spin_unlock	#
.L16:
	pushl	$__func__.9091	#
	pushl	$220	#
	pushl	$.LC0	#
	pushl	$.LC1	#
	call	printk	#
	call	dump_stack	#
	addl	$16, %esp	#,
.L14:
#APP
	661:
	
1:	lock ; decb 4(%esi)	# <variable>.slock
	jns 3f
2:	rep;nop
	cmpb $0,4(%esi)	# <variable>.slock
	jle 2b
	jmp 1b
3:
	
662:
.section .smp_altinstructions,"a"
  .align 4
  .long 661b
  .long 663f
  .byte 0x68
  .byte 662b-661b
  .byte 664f-663f
.previous
.section .smp_altinstr_replacement,"awx"
663:
	
	decb 4(%esi)	# <variable>.slock
664:
	.fill 662b-661b,1,0x42
.previous
#NO_APP
	movl	$1, (%esi)	#, <variable>.count.counter
	pushl	%esi	# lock
	call	debug_mutex_unlock	#
	movl	12(%esi), %ebx	# <variable>.next, D.9228
	leal	12(%esi), %eax	#, D.9105
	cmpl	%eax, %ebx	# D.9105, D.9228
	popl	%edx	#
	je	.L21	#,
	pushl	%ebx	# D.9228
	pushl	%esi	# lock
	call	debug_mutex_wake_waiter	#
	movl	8(%ebx), %eax	# <variable>.task, D.9107
	call	wake_up_process	#
	popl	%ebx	#
	popl	%eax	#
.L21:
	movl	$0, 20(%esi)	#, <variable>.owner
#APP
	movb $1,4(%esi)	# <variable>.slock
#NO_APP
	leal	-8(%ebp), %esp	#,
	popl	%ebx	#
	popl	%esi	#
	popl	%ebp	#
	ret
	.size	__mutex_unlock_slowpath, .-__mutex_unlock_slowpath
.globl mutex_unlock
	.type	mutex_unlock, @function
mutex_unlock:
	pushl	%ebp	#
	movl	%esp, %ebp	#,
	movl	4(%ebp), %edx	#, tmp60
	call	__mutex_unlock_slowpath	#
	popl	%ebp	#
	ret
	.size	mutex_unlock, .-mutex_unlock
	.section	.rodata
	.type	__func__.9044, @object
	.size	__func__.9044, 20
__func__.9044:
	.string	"__mutex_lock_common"
	.section	.sched.text
	.type	__mutex_lock_interruptible_slowpath, @function
__mutex_lock_interruptible_slowpath:
	pushl	%ebp	#
	movl	%esp, %ebp	#,
	pushl	%edi	#
	pushl	%esi	#
	movl	%eax, %esi	# lock_count, lock_count
	pushl	%ebx	#
	movl	$-4096, %eax	#, tmp97
	subl	$24, %esp	#,
	leal	-32(%ebp), %ebx	#, tmp98
	movl	%edx, -36(%ebp)	# ip, ip
#APP
	andl %esp,%eax; 	# tmp97
#NO_APP
	movl	(%eax), %edi	# <variable>.task, tsk
	pushl	%ebx	# tmp98
	call	debug_mutex_init_waiter	#
#APP
	661:
	
1:	lock ; decb 4(%esi)	# <variable>.slock
	jns 3f
2:	rep;nop
	cmpb $0,4(%esi)	# <variable>.slock
	jle 2b
	jmp 1b
3:
	
662:
.section .smp_altinstructions,"a"
  .align 4
  .long 661b
  .long 663f
  .byte 0x68
  .byte 662b-661b
  .byte 664f-663f
.previous
.section .smp_altinstr_replacement,"awx"
663:
	
	decb 4(%esi)	# <variable>.slock
664:
	.fill 662b-661b,1,0x42
.previous
#NO_APP
	pushl	-36(%ebp)	# ip
	pushl	4(%edi)	# <variable>.thread_info
	pushl	%ebx	# tmp98
	pushl	%esi	# lock_count
	call	debug_mutex_add_waiter	#
	leal	12(%esi), %eax	#, next
	movl	4(%eax), %edx	# <variable>.prev, prev
	movl	%eax, -32(%ebp)	# next, waiter.list.next
	movl	%ebx, 4(%eax)	# tmp98, <variable>.prev
	movl	%ebx, (%edx)	# tmp98, <variable>.next
	movl	%edx, -28(%ebp)	# prev, waiter.list.prev
	addl	$20, %esp	#,
	movl	%edi, -24(%ebp)	# tsk, waiter.task
.L29:
	orl	$-1, %eax	#, tmp102
#APP
	xchgl %eax,(%esi)	# tmp102,* lock_count
#NO_APP
	decl	%eax	# tmp102
	movl	4(%edi), %edx	# <variable>.thread_info, <variable>.thread_info
	je	.L30	#,
	movl	8(%edx), %eax	#, D.9357
	testb	$4, %al	#, D.9357
	jne	.L60	#,
	movl	$1, (%edi)	#, <variable>.state
#APP
	movb $1,4(%esi)	# <variable>.slock
#NO_APP
	call	schedule	#
#APP
	661:
	
1:	lock ; decb 4(%esi)	# <variable>.slock
	jns 3f
2:	rep;nop
	cmpb $0,4(%esi)	# <variable>.slock
	jle 2b
	jmp 1b
3:
	
662:
.section .smp_altinstructions,"a"
  .align 4
  .long 661b
  .long 663f
  .byte 0x68
  .byte 662b-661b
  .byte 664f-663f
.previous
.section .smp_altinstr_replacement,"awx"
663:
	
	decb 4(%esi)	# <variable>.slock
664:
	.fill 662b-661b,1,0x42
.previous
#NO_APP
	jmp	.L29	#
.L30:
	pushl	%edx	# <variable>.thread_info
	leal	-32(%ebp), %ebx	#, tmp106
	pushl	%ebx	# tmp106
	pushl	%esi	# lock_count
	call	mutex_remove_waiter	#
	pushl	-36(%ebp)	# ip
	pushl	4(%edi)	# <variable>.thread_info
	pushl	%esi	# lock_count
	call	debug_mutex_set_owner	#
	leal	12(%esi), %eax	#, D.9269
	addl	$24, %esp	#,
	cmpl	%eax, 12(%esi)	# D.9269, <variable>.next
	jne	.L35	#,
	movl	$0, (%esi)	#, <variable>.count.counter
.L35:
#APP
	movb $1,4(%esi)	# <variable>.slock
#NO_APP
	pushl	%ebx	# tmp106
	call	debug_mutex_free_waiter	#
	leal	24(%esi), %eax	#, D.9281
	cmpl	%eax, 24(%esi)	# D.9281, <variable>.next
	popl	%ecx	#
	jne	.L41	#,
	cmpl	$0, debug_mutex_on	#, debug_mutex_on
	je	.L41	#,
	movl	console_printk, %eax	# console_printk, console_printk
	movl	$15, %edx	#, tmp124
	movl	$0, debug_mutex_on	#, debug_mutex_on
	testl	%eax, %eax	# console_printk
	cmove	%eax, %edx	# console_printk,, tmp124
	movb	debug_mutex_lock, %al	#, D.9286
	movl	%edx, console_printk	# tmp124, console_printk
	testb	%al, %al	# D.9286
	jg	.L43	#,
	movl	$debug_mutex_lock, %eax	#,
	call	_spin_unlock	#
.L43:
	pushl	$__func__.9044	#
	pushl	$198	#
	pushl	$.LC0	#
	pushl	$.LC1	#
	call	printk	#
	call	dump_stack	#
	addl	$16, %esp	#,
.L41:
	movl	4(%edi), %eax	# <variable>.thread_info, temp.136
	cmpl	%eax, 20(%esi)	# temp.136, <variable>.owner
	je	.L48	#,
	cmpl	$0, debug_mutex_on	#, debug_mutex_on
	jne	.L64	#,
.L48:
	xorl	%eax, %eax	# D.9130
	jmp	.L34	#
.L60:
	pushl	%edx	# <variable>.thread_info
	leal	-32(%ebp), %ebx	#, tmp104
	pushl	%ebx	# tmp104
	pushl	%esi	# lock_count
	call	mutex_remove_waiter	#
#APP
	movb $1,4(%esi)	# <variable>.slock
#NO_APP
	pushl	%ebx	# tmp104
	call	debug_mutex_free_waiter	#
	movl	$-4, %eax	#, D.9130
	jmp	.L65	#
.L64:
	movl	console_printk, %eax	# console_printk, console_printk
	movl	$15, %edx	#, tmp127
	movl	$0, debug_mutex_on	#, debug_mutex_on
	testl	%eax, %eax	# console_printk
	cmove	%eax, %edx	# console_printk,, tmp127
	movb	debug_mutex_lock, %al	#, D.9291
	movl	%edx, console_printk	# tmp127, console_printk
	testb	%al, %al	# D.9291
	jg	.L54	#,
	movl	$debug_mutex_lock, %eax	#,
	call	_spin_unlock	#
.L54:
	pushl	$__func__.9044	#
	pushl	$199	#
	pushl	$.LC0	#
	pushl	$.LC1	#
	call	printk	#
	call	dump_stack	#
	xorl	%eax, %eax	# D.9130
.L65:
	addl	$16, %esp	#,
.L34:
	leal	-12(%ebp), %esp	#,
	popl	%ebx	#
	popl	%esi	#
	popl	%edi	#
	popl	%ebp	#
	ret
	.size	__mutex_lock_interruptible_slowpath, .-__mutex_lock_interruptible_slowpath
.globl mutex_lock_interruptible
	.type	mutex_lock_interruptible, @function
mutex_lock_interruptible:
	pushl	%ebp	#
	movl	%esp, %ebp	#,
	pushl	%ebx	#
	movl	%eax, %ebx	# lock, lock
	pushl	$270	#
	pushl	$.LC0	#
	call	__might_sleep	#
	movl	4(%ebp), %edx	#, tmp62
	movl	%ebx, %eax	# lock, lock
	call	__mutex_lock_interruptible_slowpath	#
	movl	-4(%ebp), %ebx	#,
	leave
	ret
	.size	mutex_lock_interruptible, .-mutex_lock_interruptible
	.type	__mutex_lock_slowpath, @function
__mutex_lock_slowpath:
	pushl	%ebp	#
	movl	%esp, %ebp	#,
	pushl	%edi	#
	pushl	%esi	#
	movl	%eax, %esi	# lock_count, lock_count
	pushl	%ebx	#
	movl	$-4096, %eax	#, tmp89
	subl	$24, %esp	#,
	leal	-32(%ebp), %ebx	#, tmp90
	movl	%edx, -36(%ebp)	# ip, ip
#APP
	andl %esp,%eax; 	# tmp89
#NO_APP
	movl	(%eax), %edi	# <variable>.task, tsk
	pushl	%ebx	# tmp90
	call	debug_mutex_init_waiter	#
#APP
	661:
	
1:	lock ; decb 4(%esi)	# <variable>.slock
	jns 3f
2:	rep;nop
	cmpb $0,4(%esi)	# <variable>.slock
	jle 2b
	jmp 1b
3:
	
662:
.section .smp_altinstructions,"a"
  .align 4
  .long 661b
  .long 663f
  .byte 0x68
  .byte 662b-661b
  .byte 664f-663f
.previous
.section .smp_altinstr_replacement,"awx"
663:
	
	decb 4(%esi)	# <variable>.slock
664:
	.fill 662b-661b,1,0x42
.previous
#NO_APP
	pushl	-36(%ebp)	# ip
	pushl	4(%edi)	# <variable>.thread_info
	pushl	%ebx	# tmp90
	pushl	%esi	# lock_count
	call	debug_mutex_add_waiter	#
	leal	12(%esi), %eax	#, next
	movl	4(%eax), %edx	# <variable>.prev, prev
	movl	%eax, -32(%ebp)	# next, waiter.list.next
	movl	%ebx, 4(%eax)	# tmp90, <variable>.prev
	movl	%ebx, (%edx)	# tmp90, <variable>.next
	movl	%edx, -28(%ebp)	# prev, waiter.list.prev
	addl	$20, %esp	#,
	movl	%edi, -24(%ebp)	# tsk, waiter.task
.L69:
	orl	$-1, %eax	#, tmp94
#APP
	xchgl %eax,(%esi)	# tmp94,* lock_count
#NO_APP
	decl	%eax	# tmp94
	je	.L70	#,
	movl	$2, (%edi)	#, <variable>.state
#APP
	movb $1,4(%esi)	# <variable>.slock
#NO_APP
	call	schedule	#
#APP
	661:
	
1:	lock ; decb 4(%esi)	# <variable>.slock
	jns 3f
2:	rep;nop
	cmpb $0,4(%esi)	# <variable>.slock
	jle 2b
	jmp 1b
3:
	
662:
.section .smp_altinstructions,"a"
  .align 4
  .long 661b
  .long 663f
  .byte 0x68
  .byte 662b-661b
  .byte 664f-663f
.previous
.section .smp_altinstr_replacement,"awx"
663:
	
	decb 4(%esi)	# <variable>.slock
664:
	.fill 662b-661b,1,0x42
.previous
#NO_APP
	jmp	.L69	#
.L70:
	pushl	4(%edi)	# <variable>.thread_info
	leal	-32(%ebp), %ebx	#, tmp95
	pushl	%ebx	# tmp95
	pushl	%esi	# lock_count
	call	mutex_remove_waiter	#
	pushl	-36(%ebp)	# ip
	pushl	4(%edi)	# <variable>.thread_info
	pushl	%esi	# lock_count
	call	debug_mutex_set_owner	#
	leal	12(%esi), %eax	#, D.9462
	addl	$24, %esp	#,
	cmpl	%eax, 12(%esi)	# D.9462, <variable>.next
	jne	.L72	#,
	movl	$0, (%esi)	#, <variable>.count.counter
.L72:
#APP
	movb $1,4(%esi)	# <variable>.slock
#NO_APP
	pushl	%ebx	# tmp95
	call	debug_mutex_free_waiter	#
	leal	24(%esi), %eax	#, D.9474
	cmpl	%eax, 24(%esi)	# D.9474, <variable>.next
	popl	%ebx	#
	jne	.L78	#,
	cmpl	$0, debug_mutex_on	#, debug_mutex_on
	je	.L78	#,
	movl	console_printk, %eax	# console_printk, console_printk
	movl	$15, %edx	#, tmp111
	movl	$0, debug_mutex_on	#, debug_mutex_on
	testl	%eax, %eax	# console_printk
	cmove	%eax, %edx	# console_printk,, tmp111
	movb	debug_mutex_lock, %al	#, D.9479
	movl	%edx, console_printk	# tmp111, console_printk
	testb	%al, %al	# D.9479
	jg	.L80	#,
	movl	$debug_mutex_lock, %eax	#,
	call	_spin_unlock	#
.L80:
	pushl	$__func__.9044	#
	pushl	$198	#
	pushl	$.LC0	#
	pushl	$.LC1	#
	call	printk	#
	call	dump_stack	#
	addl	$16, %esp	#,
.L78:
	movl	4(%edi), %eax	# <variable>.thread_info, temp.150
	cmpl	%eax, 20(%esi)	# temp.150, <variable>.owner
	je	.L96	#,
	cmpl	$0, debug_mutex_on	#, debug_mutex_on
	je	.L96	#,
	movl	console_printk, %eax	# console_printk, console_printk
	movl	$15, %edx	#, tmp114
	movl	$0, debug_mutex_on	#, debug_mutex_on
	testl	%eax, %eax	# console_printk
	cmove	%eax, %edx	# console_printk,, tmp114
	movb	debug_mutex_lock, %al	#, D.9484
	movl	%edx, console_printk	# tmp114, console_printk
	testb	%al, %al	# D.9484
	jg	.L91	#,
	movl	$debug_mutex_lock, %eax	#,
	call	_spin_unlock	#
.L91:
	pushl	$__func__.9044	#
	pushl	$199	#
	pushl	$.LC0	#
	pushl	$.LC1	#
	call	printk	#
	call	dump_stack	#
	addl	$16, %esp	#,
.L96:
	leal	-12(%ebp), %esp	#,
	popl	%ebx	#
	popl	%esi	#
	popl	%edi	#
	popl	%ebp	#
	ret
	.size	__mutex_lock_slowpath, .-__mutex_lock_slowpath
.globl mutex_lock
	.type	mutex_lock, @function
mutex_lock:
	pushl	%ebp	#
	movl	%esp, %ebp	#,
	pushl	%ebx	#
	movl	%eax, %ebx	# lock, lock
	pushl	$97	#
	pushl	$.LC0	#
	call	__might_sleep	#
	movl	4(%ebp), %edx	#, tmp60
	movl	%ebx, %eax	# lock, lock
	call	__mutex_lock_slowpath	#
	movl	-4(%ebp), %ebx	#,
	popl	%eax	#
	popl	%edx	#
	leave
	ret
	.size	mutex_lock, .-mutex_lock
	.ident	"GCC: (GNU) 4.0.2 20051125 (Red Hat 4.0.2-8)"
	.section	.note.GNU-stack,"",@progbits

--EeQfGwPcQSOJBaQU--
