Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSLQLKg>; Tue, 17 Dec 2002 06:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSLQLKg>; Tue, 17 Dec 2002 06:10:36 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:56219 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S264919AbSLQLKf>; Tue, 17 Dec 2002 06:10:35 -0500
Message-ID: <000b01c2a5bd$ebb6e870$760010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Ulrich Drepper" <drepper@redhat.com>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Dave Jones" <davej@codemonkey.org.uk>, "Ingo Molnar" <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
References: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com> <3DFF023E.6030401@redhat.com>
Subject: Re: Intel P6 vs P7 system call performance
Date: Tue, 17 Dec 2002 12:17:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For the libc DSO I had to play some dirty tricks.  The x86 CPU has no
> absolute call.  The variant with an immediate parameter is a relative
> jump.  Only when jumping through a register or memory location is it
> possible to jump to an absolute address.  To be clear, if I have
>
>     call 0xfffff000
>
> in a DSO which is loaded at address 0x80000000 the jumps ends at
> 0x7fffffff.  The problem is that the static linker doesn't know the load
> address.  We could of course have the dynamic linker fix up the
> addresses but this is plain stupid.  It would mean fixing up a lot of
> places and making of those pages covered non-sharable.
>

You could have only one routine that would need a relocation / patch at
dynamic linking stage :

absolute_syscall:
    jmp  0xfffff000

Then all syscalls routine could use :

getpid:
    ...
    call absolute_syscall
    ...
instead of "call 0xfffff000"


If the kernel doesnt support the 0xfffff000 page, you could patch
absolute_syscall (if it resides in .data section) with :
    absolute_syscall:
            int 0x80
            ret
(3 bytes instead of 5 bytes)

See you

