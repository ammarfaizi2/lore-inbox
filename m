Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVBATGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVBATGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 14:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVBATGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 14:06:09 -0500
Received: from alog0273.analogic.com ([208.224.222.49]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262093AbVBATEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 14:04:30 -0500
Date: Tue, 1 Feb 2005 14:04:15 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andreas Gruenbacher <agruen@suse.de>
cc: Paulo Marques <pmarques@grupopie.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
In-Reply-To: <Pine.LNX.4.61.0502011303350.7089@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0502011355140.7990@chaos.analogic.com>
References: <2.416337461@selenic.com>  <1107191783.21706.124.camel@winden.suse.de>
 <41FE6B42.7010807@grupopie.com> <1107280438.12050.118.camel@winden.suse.de>
 <Pine.LNX.4.61.0502011303350.7089@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, linux-os wrote:

> On Tue, 1 Feb 2005, Andreas Gruenbacher wrote:
>
>> On Mon, 2005-01-31 at 18:30, Paulo Marques wrote:
>>> Andreas Gruenbacher wrote:
>>>> [...]
>>>> 
>>>> static inline void swap(void *a, void *b, int size)
>>>> {
>>>>         if (size % sizeof(long)) {
>>>>                 char t;
>>>>                 do {
>>>>                         t = *(char *)a;
>>>>                         *(char *)a++ = *(char *)b;
>>>>                         *(char *)b++ = t;
>>>>                 } while (--size > 0);
>>>>         } else {
>>>>                 long t;
>>>>                 do {
>>>>                         t = *(long *)a;
>>>>                         *(long *)a = *(long *)b;
>>>>                         *(long *)b = t;
>>>>                         size -= sizeof(long);
>>>>                 } while (size > sizeof(long));
>>> 
>>> You forgot to increment a and b, and this should be "while (size);", no?
>> 
>> Correct, yes.
>> 
>>> Or better yet,
>>> 
>>> static inline void swap(void *a, void *b, int size)
>>> {
>>> 	long tl;
>>>          char t;
>>> 
>>> 	while (size >= sizeof(long)) {
>>>                  tl = *(long *)a;
>>>                  *(long *)a = *(long *)b;
>>>                  *(long *)b = tl;
>>> 		a += sizeof(long);
>>> 		b += sizeof(long);
>>>                  size -= sizeof(long);
>>> 	}
>>> 	while (size) {
>>>                  t = *(char *)a;
>>>                  *(char *)a++ = *(char *)b;
>>>                  *(char *)b++ = t;
>>> 		size--;
>>>          }
>>> }
>>> 
>>> This works better if the size is not a multiple of sizeof(long), but is
>>> bigger than a long.
>> 
>> In case size is not a multiple of sizeof(long) here, you'll have
>> unaligned memory accesses most of the time anyway, so it probably
>> doesn't really matter.
>> 
>> Thanks,
>> -- 
>> Andreas Gruenbacher <agruen@suse.de>
>> SUSE Labs, SUSE LINUX GMBH
>
> This uses an GNU-ISM where you are doing pointer arithmetic
> on a pointer-to-void. NotGood(tm) this is an example of
> where there is absolutely no rationale whatsoever for
> writing such code.
>

Here is swap with no games. Plus it handles the case where
sizeof(long) is not the same as sizeof(int).


void swap(void *a, void *b, size_t len)
{
     while(len >= sizeof(long))
     {
         long one, two;
         long *p0 = a;
         long *p1 = b;
         one = *p0;
         two = *p1;
         *p1++ = one;
         *p0++ = two;
         len -= sizeof(long);
     }
     while(len >= sizeof(int))	// Compiler may even ignore
     {
         int one, two;
         int *p0 = a;
         int *p1 = b;
         one = *p0;
         two = *p1;
         *p1++ = one;
         *p0++ = two;
         len -= sizeof(int);
     }
     while(len--)
     {
         char one, two;
         char *p0 = a;
         char *p1 = b;
         one = *p0;
         two = *p1;
         *p1++ = one;
         *p0++ = two;
     }
}

//----------------------------------------------


And here is the output. You can make it in-line of you want,
but you really need to make in ANSI first.


 	.file	"xxx.c"
 	.text
 	.p2align 2,,3
.globl swap
 	.type	swap, @function
swap:
 	pushl	%ebp
 	movl	%esp, %ebp
 	movl	16(%ebp), %ecx
 	pushl	%esi
 	cmpl	$3, %ecx
 	pushl	%ebx
 	movl	8(%ebp), %esi
 	movl	12(%ebp), %ebx
 	jbe	.L17
 	.p2align 2,,3
.L5:
 	subl	$4, %ecx
 	movl	(%esi), %eax
 	movl	(%ebx), %edx
 	cmpl	$3, %ecx
 	movl	%eax, (%ebx)
 	movl	%edx, (%esi)
 	ja	.L5
.L17:
 	decl	%ecx
 	cmpl	$-1, %ecx
 	je	.L19
 	.p2align 2,,3
.L13:
 	decl	%ecx
 	movb	(%esi), %al
 	movb	(%ebx), %dl
 	cmpl	$-1, %ecx
 	movb	%al, (%ebx)
 	movb	%dl, (%esi)
 	jne	.L13
.L19:
 	popl	%ebx
 	popl	%esi
 	leave
 	ret
 	.size	swap, .-swap
 	.section	.note.GNU-stack,"",@progbits
 	.ident	"GCC: (GNU) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)"

A lot of folks don't realilize that adding a new program-unit
after a conditional expression doesn't necessarily add any code.
In this case, it simply tells the compiler what we want to do.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
