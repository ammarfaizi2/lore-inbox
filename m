Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTLIFhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 00:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTLIFhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 00:37:50 -0500
Received: from terminus.zytor.com ([63.209.29.3]:28891 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263060AbTLIFhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 00:37:48 -0500
Message-ID: <3FD55F9D.9070203@zytor.com>
Date: Mon, 08 Dec 2003 21:37:33 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Nikita Danilov <Nikita@Namesys.COM>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
References: <200312081646.42191.arnd@arndb.de> <3FD4B9E6.9090902@zytor.com> <16340.49791.585097.389128@laputa.namesys.com> <3FD4C375.2060803@zytor.com> <20031209025952.GA26439@mail.shareable.org> <3FD53FC6.5080103@zytor.com> <20031209034935.GA26987@mail.shareable.org>
In-Reply-To: <20031209034935.GA26987@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> H. Peter Anvin wrote:
> 
>>>It would be nice to have a way to declare an asm like "pure" not
>>>"const", so that it's allowed to read memory but multiple calls can be
>>>eliminated; I don't know of a way to express that.
>>
>>Just specify memory input operands.
> 
> 
> Thanks.  That's even more useful than "pure" because it implies the
> asm only reads the explicitly passed memory operands.
> 
> Memory input operands don't work if you want the asm to read arbitrary
> memory not mentioned in the inputs (like "pure" allows) or traverse
> linked lists.
> 
> (A long time ago there was a question about whether GCC could ever
> copy the value associated with an "m" operand to a stack slot, and
> pass the address of the stack slot.  After all, GCC _will_ copy the
> value if the operand is an "r", and presumably gives mixed results
> with "rm".  We seem to have concluded that it never will).
> 

Sure it will:


int foo(int x)
{
   int y, z;

   asm("movl %1,%0" : "=r" (y) : "r" (x));
   asm("movl %1,%0" : "=r" (z) : "m" (y));

   return z;
}

: smyrno 21 ; gcc -O2 -c testme.c
: smyrno 22 ; objdump -dr testme.o

testme.o:     file format elf32-i386

Disassembly of section .text:

00000000 <foo>:
    0:   55                      push   %ebp			; Make stack frame
    1:   89 e5                   mov    %esp,%ebp		; d:o
    3:   50                      push   %eax			; Allocate stack slot
    4:   8b 45 08                mov    0x8(%ebp),%eax		; Copy to register
    7:   89 c0                   mov    %eax,%eax		; First asm()
    9:   89 45 fc                mov    %eax,0xfffffffc(%ebp) 	; Copy to stack slot
    c:   8b 45 fc                mov    0xfffffffc(%ebp),%eax	; Second asm()
    f:   c9                      leave				; Destroy stack frame
   10:   c3                      ret


