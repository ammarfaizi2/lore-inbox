Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbUKINrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbUKINrj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 08:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbUKINrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 08:47:39 -0500
Received: from alog0093.analogic.com ([208.224.220.108]:18304 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261381AbUKINrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 08:47:24 -0500
Date: Tue, 9 Nov 2004 08:43:21 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Adrian Bunk <bunk@stusta.de>
cc: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] kill IN_STRING_C
In-Reply-To: <Pine.LNX.4.61.0411090742530.11563@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0411090836550.11825@chaos.analogic.com>
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de>
 <20041108163101.GA13234@stusta.de> <200411081904.13969.pluto@pld-linux.org>
 <20041108183120.GB15077@stusta.de> <Pine.LNX.4.61.0411081410560.6407@chaos.analogic.com>
 <20041108212713.GH15077@stusta.de> <Pine.LNX.4.61.0411081640320.8258@chaos.analogic.com>
 <20041108222952.GJ15077@stusta.de> <Pine.LNX.4.61.0411081751500.8711@chaos.analogic.com>
 <20041108230859.GL15077@stusta.de> <Pine.LNX.4.61.0411090742530.11563@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, linux-os wrote:

> On Tue, 9 Nov 2004, Adrian Bunk wrote:
>
>> On Mon, Nov 08, 2004 at 05:57:12PM -0500, linux-os wrote:
>>> ...
>>> 	call	strcpy
>>> ...
>>> strcpy:
>>> 	subl	$8, %esp
>>> ...
>>> It clearly invents strcpy, having never been referenced in the
>>> source.
>> 
>> The asm code you sent does _not_ call a global strcpy function.
>> It calls an asm procedure named "strcpy" it ships itself.
>> 
>> BTW: You are the second person in this thread I have to explain this to...
>> 
>>> Cheers,
>>> Dick Johnson
>> 
>> cu
>> Adrian
>
> Explain WHAT? There is NO strcpy in the code. No such procedure
> should have been called. Period. The generated code is defective.
>

Here is more information showing the defective code generation.

Output of `nm`

00000000 r hello
          U printk
00000039 t strcpy
00000000 T xxx

Clearly shows a strcpy symbol when strcpy() was never referenced
in the 'C' code.

Output of objdump

xxx.o:     file format elf32-i386

Disassembly of section .text:

00000000 <xxx>:
    0:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
    6:	89 9c 24 08 01 00 00 	mov    %ebx,0x108(%esp)
    d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
   14:	00
   15:	8d 5c 24 08          	lea    0x8(%esp),%ebx
   19:	89 1c 24             	mov    %ebx,(%esp)
   1c:	e8 18 00 00 00       	call   39 <strcpy>
   21:	89 1c 24             	mov    %ebx,(%esp)
   24:	e8 fc ff ff ff       	call   25 <xxx+0x25>
   29:	8b 9c 24 08 01 00 00 	mov    0x108(%esp),%ebx
   30:	31 c0                	xor    %eax,%eax
   32:	81 c4 0c 01 00 00    	add    $0x10c,%esp
   38:	c3                   	ret

00000039 <strcpy>:
   39:	83 ec 08             	sub    $0x8,%esp
   3c:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
   40:	89 34 24             	mov    %esi,(%esp)
   43:	89 7c 24 04          	mov    %edi,0x4(%esp)
   47:	8b 74 24 10          	mov    0x10(%esp),%esi
   4b:	89 cf                	mov    %ecx,%edi
   4d:	ac                   	lods   %ds:(%esi),%al
   4e:	aa                   	stos   %al,%es:(%edi)
   4f:	84 c0                	test   %al,%al
   51:	75 fa                	jne    4d <strcpy+0x14>
   53:	89 c8                	mov    %ecx,%eax
   55:	8b 34 24             	mov    (%esp),%esi
   58:	8b 7c 24 04          	mov    0x4(%esp),%edi
   5c:	83 c4 08             	add    $0x8,%esp
   5f:	c3                   	ret

[SNIPPED...]

Clearly shows a GLOBAL procedure called strcpy when
no such procedure was ever referenced in the code.

Now I will show that the strcpy() procedure is NOT local.
It's global and can screw up anything:

Another program....


char printk;				// Just quiet the reference
 					// ... just a label, never called.
extern int puts(const char *);			// No header funnies
extern char *strcpy(char *, const char *);
int main(){
    char buf[0x100];
    strcpy(buf, "WTF?");				// Going to call it!
    puts(buf);
    return 0;
}

Show code generation.

$ gcc -S -o aaa zzz.c

 	.file	"zzz.c"
 	.section	.rodata
.LC0:
 	.string	"WTF?"
 	.text
.globl main
 	.type	main, @function
main:
 	pushl	%ebp
 	movl	%esp, %ebp
 	subl	$264, %esp
 	andl	$-16, %esp
 	movl	$0, %eax
 	subl	%eax, %esp
 	subl	$8, %esp
 	pushl	$.LC0
 	leal	-264(%ebp), %eax
 	pushl	%eax
 	call	strcpy			# Clearly calls it.
 	addl	$16, %esp
 	subl	$12, %esp
 	leal	-264(%ebp), %eax
 	pushl	%eax
 	call	puts
 	addl	$16, %esp
 	movl	$0, %eax
 	leave
 	ret
 	.size	main, .-main
 	.comm	printk,1,1
 	.section	.note.GNU-stack,"",@progbits
 	.ident	"GCC: (GNU) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)"

Now compile and link with the file containing ROGUE strcpy().

$ gcc -o zzz zzz.c xxx.o

$ ./zzz
WTF?

Executes, calling a ROGUE function that MUST NOT exist.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
