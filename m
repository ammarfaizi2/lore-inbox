Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSLSPBN>; Thu, 19 Dec 2002 10:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSLSPBN>; Thu, 19 Dec 2002 10:01:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59276 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265578AbSLSPBM>; Thu, 19 Dec 2002 10:01:12 -0500
Date: Thu, 19 Dec 2002 10:11:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: billyrose@billyrose.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <1040308834.3e01da62a8761@209.51.155.18>
Message-ID: <Pine.LNX.3.95.1021219095836.4206A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002 billyrose@billyrose.net wrote:

> Richard B. Johnson wrote:
> 
> > The target, i.e., the label 'goto' would be the reserved page for the
> > system call. The whole purpose was to minimize the number of CPU cycles
> > necessary to call 0xfffff000 and return. The system call does not have
> > issue a 'far' return, it can do anything it requires. The page at
> > 0xfffff000 is mapped into every process and is in that process CS space
> > already.
> 
> that being the case, why push %cs and reload it without reason as the
> code is mapped into every process?
> 
> therefore, would it not suffice to use:
> 
>         ...
>         long_call(); //call to $0xfffff000 via near ret
>         //code at $0xfffff000 returns directly here when a ret is issued
>         ...
> 
> long_call:
>         pushl $0xfffff000
>         ret
> 

Because the number pushed onto the stack is a displacement, not
an address, i.e., -4095. To have the address act as an address,
you need to load a full-pointer, i.e. SEG:OFFSET (like the old
16-bit days). The offset is 32-bits and the segment is whatever
the kernel has set up for __USER_CS (0x23). All the 'near' calls
are calls to a signed displacement, same for jumps.

It would be nice if you could just do 	call	$0xfffff000,
the problem is that the 'call' expects a displacement, usually
determined (fixed-up) by the linker. So, in this case, you
end up calling some code that exists 4095 bytes before the
call instruction NotGood(tm).

So the whole idea of this exercise is to do the same thing as
	call far ptr 0x23:0xfffff000 (Intel syntax), without
reguiring a fixup, but minimizing the instructions and disruption
due to reloading a segment.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


