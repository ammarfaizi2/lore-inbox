Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSAPUn7>; Wed, 16 Jan 2002 15:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287478AbSAPUnt>; Wed, 16 Jan 2002 15:43:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41601 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S287475AbSAPUnc>; Wed, 16 Jan 2002 15:43:32 -0500
Date: Wed, 16 Jan 2002 15:44:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Swiedler <ceswiedler@mindspring.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hex addresses in setup.S
In-Reply-To: <BJEJJDPJOCEPDBLPFDKJCEACCCAA.ceswiedler@mindspring.com>
Message-ID: <Pine.LNX.3.95.1020116151831.14774A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Chris Swiedler wrote:

> Why does setup.S define the default system load address as 0x1000, and the
> comment on the line explain this to be 0x10000(and gives the decimal
> translation of 65536, so it's not a typo)? This seems to be true for several
> addresss (0x9000 = 0x90000, etc). I'm sure there's something simple I'm
> missing...what is it?
> 
> TIA,
> chris

In Intel real mode, an address is represented as SEGMENT:OFFSET.
The segment is a 16-byte chunk called a 'paragraph'. There are
many ways of representing an address in real mode. Just take
the absolute memory location and divide it by 16. The quotent
is the segment and the remainder is the offset. This will
give you the lowest possible offset.  However, a maximum-value
address can be represented (65536 / 16) -1 = 4095 different ways!

If the segment has been set to 0x9000 as in setup.S, then the
absolute address is 0x9000 * 0x10 = 0x90000. This means that
0x9000:0000 points to 0x00090000 absolute, while 0x9000:0001
would point to 0x00090001 absolute.

The segment-part of the address goes into a segment register
such as CS, DS, ES, or SS, and your addressing then becomes
relative to that segment register. For instance, if you did:

	destination <--- source
	mov	ax,1000h
	mov	ds,ax
	mov	bx, 2
	mov	ax,[bx]

... the result will be whatever 16-bit word was at absolute location
0x100002 in your ax register.

The complication of real-mode starts to make itself known when the
registers are set to their maximum values:

	0xffff:0xffff

This gives you (65535 * 16) + 65535 = 1114095 ... the 1 megabyte
                ^^^^^^^^^^    ^^^^^
                max segment   max offset
"barrier". That's why 32-bit Operating Systems were developed for
Intel machines. The next barrier was 0xffffffff, but by playing
with the same kind of page-register schemes that worked in real-mode,
we can now access physical memory that exists at a greater offset
than 0xffffffff, however, the maximum virtual offset per process will
remain at 0xffffffff as long as we have 32-bit addressing.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


