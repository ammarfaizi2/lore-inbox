Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbTBDKvC>; Tue, 4 Feb 2003 05:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbTBDKvC>; Tue, 4 Feb 2003 05:51:02 -0500
Received: from k101-11.bas1.dbn.dublin.eircom.net ([159.134.101.11]:13 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S267228AbTBDKuu>;
	Tue, 4 Feb 2003 05:50:50 -0500
Message-ID: <3E3F9C82.7000607@Linux.ie>
Date: Tue, 04 Feb 2003 10:57:06 +0000
From: Padraig@Linux.ie
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc 2.95 vs 3.21 performance
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>
Content-Type: multipart/mixed;
 boundary="------------080808040300040906070208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080808040300040906070208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Richard B. Johnson wrote:
> On Mon, 3 Feb 2003, Martin J. Bligh wrote:
> 
>>People keep extolling the virtues of gcc 3.2 to me, which I'm
>>reluctant to switch to, since it compiles so much slower. But
>>it supposedly generates better code, so I thought I'd compile
>>the kernel with both and compare the results. This is gcc 2.95
>>and 3.2.1 from debian unstable on a 16-way NUMA-Q. The kernbench
>>tests still use 2.95 for the compile-time stuff.
>>
> 
> [SNIPPED tests...]
> 
> Don't let this get out, but egcs-2.91.66 compiled FFT code
> works about 50 percent of the speed of whatever M$ uses for
> Visual C++ Version 6.0

Interesting. I just noticed that I get 50% decrease in
the speed of my program if I just insert a printf(). I.E.
my program is like:

printf()
for(;;) {
     do_sorting_loop_test();
}

If I remove the initial printf it doubles in speed?
I assume this is some weird caching thing?
gcc is 3.2.1 (same happens for 2.95..)

<boggle>
Note this is with -O3. If I don't specify -O then
leaving the printf in speeds things up by about 15%
</boggle>

attached is the assembly for the slow and fast
in case anyone's interested.

Pádraig.

--------------080808040300040906070208
Content-Type: text/plain;
 name="slow.s"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slow.s"

	.file	"testfunc.c"
.globl TEST_NUMBER
	.data
	.align 2
	.type	TEST_NUMBER,@object
	.size	TEST_NUMBER,2
TEST_NUMBER:
	.value	256
.globl count
	.align 4
	.type	count,@object
	.size	count,4
count:
	.long	0
.globl exit_flag
	.align 4
	.type	exit_flag,@object
	.size	exit_flag,4
exit_flag:
	.long	0
	.align 4
	.type	throttle_print.0,@object
	.size	throttle_print.0,4
throttle_print.0:
	.long	0
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"\033[H\033[2J"
	.section	.rodata.str1.32,"aMS",@progbits,1
	.align 32
.LC3:
	.string	"\nAdding & dropping random array elements,(from a set of 000..%03u)\n"
	.section	.rodata.str1.1
.LC4:
	.string	"Ctrl C to exit"
	.section	.rodata.str1.32
	.align 32
.LC1:
	.string	"\n%lu array elements randomly dropped and added in %lus"
	.align 32
.LC2:
	.string	" (%lu/s)\n                                                                          \n"
	.text
	.p2align 2,,3
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	andl	$-16, %esp
	cmpl	$1, 8(%ebp)
	movl	$1, %edi
	jle	.L2
	pushl	$0
	pushl	$10
	pushl	$0
	movl	12(%ebp), %eax
	pushl	4(%eax)
	call	__strtol_internal
	addl	$16, %esp
	testl	%eax, %eax
	jle	.L2
	movw	%ax, TEST_NUMBER
.L2:
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	popl	%eax
	pushl	stdout
	call	fflush
	movzwl	TEST_NUMBER, %edx
	sall	$1, %edx
	movl	%edx, (%esp)
	call	malloc
	movl	%eax, %esi
	movl	$0, (%esp)
	call	time
	popl	%ebx
	movl	%eax, start
	popl	%eax
	pushl	$exit_info_sig
	pushl	$2
	call	signal
	xorl	%edx, %edx
	movw	TEST_NUMBER, %cx
	addl	$16, %esp
	cmpw	%cx, %dx
	jae	.L24
.L10:
	movzwl	%dx, %ebx
	movw	%dx, (%esi,%ebx,2)
	incl	%edx
	cmpw	%cx, %dx
	jb	.L10
	.p2align 2,,3
.L24:
	incl	count
	call	rand
	movw	TEST_NUMBER, %bx
	movzwl	%bx, %edx
	movl	%edx, %ecx
	cltd
	idivl	%ecx
	cmpw	%bx, %dx
	movl	%edx, %ecx
	jae	.L27
	.p2align 2,,3
.L18:
	movzwl	%cx, %edx
	incl	%ecx
	movw	(%esi,%edx,2), %ax
	cmpw	%bx, %cx
	movw	%ax, -2(%esi,%edx,2)
	jb	.L18
.L27:
	leal	-1(%ebx), %ecx
	subl	$8, %esp
	movzwl	%cx, %edx
	pushl	%edx
	pushl	%esi
	call	GetLowestValueAvailable
	movzwl	TEST_NUMBER, %edx
	movw	%ax, -2(%esi,%edx,2)
	movl	exit_flag, %eax
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L28
	testl	%edi, %edi
	je	.L24
	subl	$8, %esp
	leal	-1(%edx), %ebx
	pushl	%ebx
	pushl	$.LC3
	call	printf
	xorl	%edi, %edi
	movl	$.LC4, (%esp)
	call	puts
	addl	$16, %esp
	jmp	.L24
.L28:
	subl	$12, %esp
	pushl	$0
	call	time
	movl	%eax, %esi
	addl	$12, %esp
	subl	start, %esi
	pushl	%esi
	pushl	count
	pushl	$.LC1
	call	printf
	popl	%eax
	popl	%edx
	movl	count, %eax
	xorl	%edx, %edx
	divl	%esi
	pushl	%eax
	pushl	$.LC2
	call	printf
	movl	$1, (%esp)
	call	exit
.Lfe1:
	.size	main,.Lfe1-main
	.p2align 2,,3
.globl RemoveNumber
	.type	RemoveNumber,@function
RemoveNumber:
	pushl	%ebp
	movl	%esp, %ebp
	movl	12(%ebp), %ecx
	cmpw	TEST_NUMBER, %cx
	pushl	%ebx
	movl	8(%ebp), %ebx
	jae	.L69
	.p2align 2,,3
.L67:
	movzwl	%cx, %edx
	movw	(%ebx,%edx,2), %ax
	movw	%ax, -2(%ebx,%edx,2)
	incl	%ecx
	cmpw	TEST_NUMBER, %cx
	jb	.L67
.L69:
	popl	%ebx
	leave
	ret
.Lfe2:
	.size	RemoveNumber,.Lfe2-RemoveNumber
	.section	.rodata.str1.1
.LC5:
	.string	"\033[H"
.LC6:
	.string	"%03d "
	.text
	.p2align 2,,3
.globl printArray
	.type	printArray,@function
printArray:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	pushl	$.LC5
	movl	8(%ebp), %esi
	call	printf
	popl	%eax
	pushl	stdout
	xorl	%ebx, %ebx
	call	fflush
	addl	$16, %esp
	cmpw	TEST_NUMBER, %bx
	jb	.L75
.L77:
	leal	-8(%ebp), %esp
	popl	%ebx
	popl	%esi
	leave
	ret
	.p2align 2,,3
.L75:
	movzwl	%bx, %ecx
	subl	$8, %esp
	movzwl	(%esi,%ecx,2), %edx
	pushl	%edx
	pushl	$.LC6
	incl	%ebx
	call	printf
	addl	$16, %esp
	cmpw	TEST_NUMBER, %bx
	jb	.L75
	jmp	.L77
.Lfe3:
	.size	printArray,.Lfe3-printArray
	.p2align 2,,3
.globl exit_info
	.type	exit_info,@function
exit_info:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
	pushl	$0
	call	time
	movl	%eax, %ebx
	addl	$12, %esp
	subl	start, %ebx
	pushl	%ebx
	pushl	count
	pushl	$.LC1
	call	printf
	popl	%eax
	popl	%edx
	movl	count, %eax
	xorl	%edx, %edx
	divl	%ebx
	pushl	%eax
	pushl	$.LC2
	call	printf
	movl	$1, (%esp)
	call	exit
.Lfe4:
	.size	exit_info,.Lfe4-exit_info
	.p2align 2,,3
.globl exit_info_sig
	.type	exit_info_sig,@function
exit_info_sig:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, exit_flag
	leave
	ret
.Lfe5:
	.size	exit_info_sig,.Lfe5-exit_info_sig
	.comm	start,4,4
	.ident	"GCC: (GNU) 3.2.1 20021207 (Red Hat Linux 8.0 3.2.1-2)"

--------------080808040300040906070208
Content-Type: text/plain;
 name="fast.s"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fast.s"

	.file	"testfunc.c"
.globl TEST_NUMBER
	.data
	.align 2
	.type	TEST_NUMBER,@object
	.size	TEST_NUMBER,2
TEST_NUMBER:
	.value	256
.globl count
	.align 4
	.type	count,@object
	.size	count,4
count:
	.long	0
.globl exit_flag
	.align 4
	.type	exit_flag,@object
	.size	exit_flag,4
exit_flag:
	.long	0
	.align 4
	.type	throttle_print.0,@object
	.size	throttle_print.0,4
throttle_print.0:
	.long	0
	.section	.rodata.str1.32,"aMS",@progbits,1
	.align 32
.LC2:
	.string	"\nAdding & dropping random array elements,(from a set of 000..%03u)\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"Ctrl C to exit"
	.section	.rodata.str1.32
	.align 32
.LC0:
	.string	"\n%lu array elements randomly dropped and added in %lus"
	.align 32
.LC1:
	.string	" (%lu/s)\n                                                                          \n"
	.text
	.p2align 2,,3
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	andl	$-16, %esp
	cmpl	$1, 8(%ebp)
	movl	$1, %edi
	jle	.L2
	pushl	$0
	pushl	$10
	pushl	$0
	movl	12(%ebp), %eax
	pushl	4(%eax)
	call	__strtol_internal
	addl	$16, %esp
	testl	%eax, %eax
	jle	.L2
	movw	%ax, TEST_NUMBER
.L2:
	movzwl	TEST_NUMBER, %edx
	subl	$12, %esp
	sall	$1, %edx
	pushl	%edx
	call	malloc
	movl	%eax, %esi
	movl	$0, (%esp)
	call	time
	popl	%ebx
	movl	%eax, start
	popl	%eax
	pushl	$exit_info_sig
	pushl	$2
	call	signal
	xorl	%edx, %edx
	movw	TEST_NUMBER, %cx
	addl	$16, %esp
	cmpw	%cx, %dx
	jae	.L24
.L10:
	movzwl	%dx, %ebx
	movw	%dx, (%esi,%ebx,2)
	incl	%edx
	cmpw	%cx, %dx
	jb	.L10
	.p2align 2,,3
.L24:
	incl	count
	call	rand
	movw	TEST_NUMBER, %bx
	movzwl	%bx, %edx
	movl	%edx, %ecx
	cltd
	idivl	%ecx
	cmpw	%bx, %dx
	movl	%edx, %ecx
	jae	.L27
	.p2align 2,,3
.L18:
	movzwl	%cx, %edx
	incl	%ecx
	movw	(%esi,%edx,2), %ax
	cmpw	%bx, %cx
	movw	%ax, -2(%esi,%edx,2)
	jb	.L18
.L27:
	leal	-1(%ebx), %ecx
	subl	$8, %esp
	movzwl	%cx, %edx
	pushl	%edx
	pushl	%esi
	call	GetLowestValueAvailable
	movzwl	TEST_NUMBER, %edx
	movw	%ax, -2(%esi,%edx,2)
	movl	exit_flag, %eax
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L28
	testl	%edi, %edi
	je	.L24
	subl	$8, %esp
	leal	-1(%edx), %ebx
	pushl	%ebx
	pushl	$.LC2
	call	printf
	xorl	%edi, %edi
	movl	$.LC3, (%esp)
	call	puts
	addl	$16, %esp
	jmp	.L24
.L28:
	subl	$12, %esp
	pushl	$0
	call	time
	movl	%eax, %esi
	addl	$12, %esp
	subl	start, %esi
	pushl	%esi
	pushl	count
	pushl	$.LC0
	call	printf
	popl	%eax
	popl	%edx
	movl	count, %eax
	xorl	%edx, %edx
	divl	%esi
	pushl	%eax
	pushl	$.LC1
	call	printf
	movl	$1, (%esp)
	call	exit
.Lfe1:
	.size	main,.Lfe1-main
	.p2align 2,,3
.globl RemoveNumber
	.type	RemoveNumber,@function
RemoveNumber:
	pushl	%ebp
	movl	%esp, %ebp
	movl	12(%ebp), %ecx
	cmpw	TEST_NUMBER, %cx
	pushl	%ebx
	movl	8(%ebp), %ebx
	jae	.L69
	.p2align 2,,3
.L67:
	movzwl	%cx, %edx
	movw	(%ebx,%edx,2), %ax
	movw	%ax, -2(%ebx,%edx,2)
	incl	%ecx
	cmpw	TEST_NUMBER, %cx
	jb	.L67
.L69:
	popl	%ebx
	leave
	ret
.Lfe2:
	.size	RemoveNumber,.Lfe2-RemoveNumber
	.section	.rodata.str1.1
.LC4:
	.string	"\033[H"
.LC5:
	.string	"%03d "
	.text
	.p2align 2,,3
.globl printArray
	.type	printArray,@function
printArray:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	pushl	$.LC4
	movl	8(%ebp), %esi
	call	printf
	popl	%eax
	pushl	stdout
	xorl	%ebx, %ebx
	call	fflush
	addl	$16, %esp
	cmpw	TEST_NUMBER, %bx
	jb	.L75
.L77:
	leal	-8(%ebp), %esp
	popl	%ebx
	popl	%esi
	leave
	ret
	.p2align 2,,3
.L75:
	movzwl	%bx, %ecx
	subl	$8, %esp
	movzwl	(%esi,%ecx,2), %edx
	pushl	%edx
	pushl	$.LC5
	incl	%ebx
	call	printf
	addl	$16, %esp
	cmpw	TEST_NUMBER, %bx
	jb	.L75
	jmp	.L77
.Lfe3:
	.size	printArray,.Lfe3-printArray
	.p2align 2,,3
.globl exit_info
	.type	exit_info,@function
exit_info:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
	pushl	$0
	call	time
	movl	%eax, %ebx
	addl	$12, %esp
	subl	start, %ebx
	pushl	%ebx
	pushl	count
	pushl	$.LC0
	call	printf
	popl	%eax
	popl	%edx
	movl	count, %eax
	xorl	%edx, %edx
	divl	%ebx
	pushl	%eax
	pushl	$.LC1
	call	printf
	movl	$1, (%esp)
	call	exit
.Lfe4:
	.size	exit_info,.Lfe4-exit_info
	.p2align 2,,3
.globl exit_info_sig
	.type	exit_info_sig,@function
exit_info_sig:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, exit_flag
	leave
	ret
.Lfe5:
	.size	exit_info_sig,.Lfe5-exit_info_sig
	.comm	start,4,4
	.ident	"GCC: (GNU) 3.2.1 20021207 (Red Hat Linux 8.0 3.2.1-2)"

--------------080808040300040906070208--

