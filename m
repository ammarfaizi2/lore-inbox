Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313925AbSDZMc1>; Fri, 26 Apr 2002 08:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313930AbSDZMc0>; Fri, 26 Apr 2002 08:32:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15745 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313925AbSDZMcZ>; Fri, 26 Apr 2002 08:32:25 -0400
Date: Fri, 26 Apr 2002 08:34:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gabriel Paubert <paubert@iram.es>
cc: Mark Zealey <mark@zealos.org>, linux-kernel@vger.kernel.org
Subject: Re: Assembly question
In-Reply-To: <3CC93C0A.1030500@iram.es>
Message-ID: <Pine.LNX.3.95.1020426081723.8083A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002, Gabriel Paubert wrote:

> Mark Zealey wrote:
> 
>  > On Thu, Apr 25, 2002 at 10:32:25AM +0200, Szekeres Istvan wrote:
>  >
>  >
>  >> void p_memset_dword( void *d, int b, int l ) { __asm__ ("rep\n\t" 
> "stosl\n\t"
>  >>
> 
>  >> : : "D" (d), "a" (b), "c" (l) : "memory","edi", "eax", "ecx"
>  >>
>  >
>  > An input or output operand is implicitly clobbered, so it should be
>       ^^^^^
> I had expected gcc specialists to jump on that one: if you don't
> explicitly tell gcc that an input is clobbered, it may reuse it later if
> it needs the same value. So the clobbers are necessary...

    : : "D" (d), "a" (b), "c" (l) : "memory","edi", "eax", "ecx"
... is correct. Registers EDI, EAX, and ECX are altered and memory
is changed. Nothing having to do with the 'input' is altered in
any meaningful sense. You alter an 'input' by doing something like:

	pushl	%ebx
	..... code
	popl	%eax	; Input value of ebx is destroyed

Passed parameters are (usually) passed on the stack. They are
local and disappear when the call returns, i.e.,

	pushl	string		; 4 - byte address
	call	puts		; call function
	addl	$4, esp		; Level stack

GCC may optimize in-line and not bother to push a value that is
readily accessible to the in-line function. That value is not
clobbered in any way. The in-line function doesn't have to
'return' since it's in-line. Therefore the return address isn't
on the stack either. When setting up 'clobbers', you have
observe the registers that are used and declare whether or
not memory is altered. That's all. For instance, we see EAX as
a clobbered register. GCC may decide that it is a scratch-register
so it doesn't bother to save/restore its value. On the other hand,
if you didn't tell GCC that you destroyed EAX, it's a bug and a
hard-to-find bug because most of the time, the code will work.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

