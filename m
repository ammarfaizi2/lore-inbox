Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTLOQjG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTLOQjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:39:06 -0500
Received: from fmr99.intel.com ([192.55.52.32]:16017 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263767AbTLOQjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:39:00 -0500
Message-ID: <3FDDE39E.1050300@intel.com>
Date: Mon, 15 Dec 2003 18:38:54 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
CC: Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca> <3FDDD8C6.3080804@intel.com> <3FDDDC68.80209@backtobasicsmgmt.com>
In-Reply-To: <3FDDDC68.80209@backtobasicsmgmt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin,
there is no black magic. Compilation goes .c -> .s -> .o; if assembly 
have nothing added, object have not as well.
To be sure, I did the following:

[tmp]$ gcc -c t.c; objdump -xs t.o

t.o:     file format elf32-i386
t.o
architecture: i386, flags 0x00000010:
HAS_SYMS
start address 0x00000000

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000000  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00000000  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000008  00000000  00000000  00000034  2**2
                  ALLOC
  3 .note.GNU-stack 00000000  00000000  00000000  00000034  2**0
                  CONTENTS, READONLY
  4 .comment      00000033  00000000  00000000  00000034  2**0
                  CONTENTS, READONLY
SYMBOL TABLE:
00000000 l    df *ABS*    00000000 t.c
00000000 l    d  .text    00000000
00000000 l    d  .data    00000000
00000000 l    d  .bss    00000000
00000000 l     O .bss    00000004 a1
00000004 l     O .bss    00000004 a2
00000000 l    d  .note.GNU-stack    00000000
00000000 l    d  .comment    00000000


Contents of section .text:
Contents of section .data:
Contents of section .note.GNU-stack:
Contents of section .comment:
 0000 00474343 3a202847 4e552920 332e332e  .GCC: (GNU) 3.3.
 0010 31203230 30333038 31312028 52656420  1 20030811 (Red
 0020 48617420 4c696e75 7820332e 332e312d  Hat Linux 3.3.1-
 0030 312900                               1).            

Kevin P. Fleming wrote:

> Vladimir Kondratiev wrote:
>
>> To illustrate zero cost, I did the following test:
>> [tmp]$ cat t.c; gcc -S t.c; cat t.s
>> static int a1=0;
>> static int a2;
>> /* EOF */
>>
>>    .file    "t.c"
>>    .local    a1
>>    .comm    a1,4,4
>>    .local    a2
>>    .comm    a2,4,4
>>    .section    .note.GNU-stack,"",@progbits
>>    .ident    "GCC: (GNU) 3.3.1 20030811 (Red Hat Linux 3.3.1-1)"
>>
>> As you can see, assembly code is identical, compiler did this trivial 
>> optimization for me.
>
>
> You've missed the point, though. Initializing a static variable to 
> zero causes space to be consumed in the resulting object file (not 
> instruction code to be generated). This is wasted space, because if 
> you don't initialize to zero the variable will be allocated out of 
> space that is _automatically_ zeroed for you. This reduces the size of 
> the kernel image by not filling it with unnecessary zeroes.
>

