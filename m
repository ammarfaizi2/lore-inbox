Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVFLTVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVFLTVq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVFLTVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:21:21 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:44168 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262641AbVFLQoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 12:44:39 -0400
Date: Sun, 12 Jun 2005 18:44:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <willy@w.ods.org>
cc: DJ.CnX@phreaker.net, linux-kernel@vger.kernel.org
Subject: Re: ld bug
In-Reply-To: <20050612160450.GB8907@alpha.home.local>
Message-ID: <Pine.LNX.4.61.0506121838270.6693@yvahk01.tjqt.qr>
References: <20050612171050.529d5be8.DJ.CnX@phreaker.net>
 <20050612160450.GB8907@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Although this is not the right list for this, it seems that the start
>pointer in your program is 0, and since this page is not mapped, you
>get a segfault. How to fix this I don't know, but this definitely is
>not a kernel bug.

"ld" usually wants a .start symbol (or something...) - and it looks like
nasm does not put some into the object file.

>> compilation command:
>> sh# nasm -f elf -o new.o new.asm
>> sh# ld -e main -o new new.o
>> sh# strace ./new
>> execve("./new", ["./new"], [/* 78 vars */]) = 0
>> --- SIGSEGV (Segmentation fault) @ 0 (0) ---
>> +++ killed by SIGSEGV +++
>> i compiled the whole shit with gcc and it worked... .-/

Well, I did the same with GCC (GNU AS):

.intel_syntax noprefix;
.section .rodata;
.L_LC0:
	.string "och bin";
.text;
	pusha;
	mov eax, 4;
	mov ebx, 1;
	mov ecx, offset flat:.L_LC0;
	mov edx, 8;
	int 0x80;

18:43 eax:../hxtools/examples # cc x.S -c
18:43 eax:../hxtools/examples # ld x.o -o x.aout
ld: warning: cannot find entry symbol _start; defaulting to 0000000008048074
18:43 eax:../hxtools/examples # ./x.aout 
och binSegmentation fault

- The segfault is due to the abrupt end after int 0x80,
  so let's not consider it.

- "och bin" is printed

- As you can see, there is said _start symbol which I presume NASM
  fails to generate.



Jan Engelhardt                                                               
--                                                                            
| Gesellschaft fuer Wissenschaftliche Datenverarbeitung Goettingen,
| Am Fassberg, 37077 Goettingen, www.gwdg.de
