Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263947AbTH1MGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 08:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263949AbTH1MGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 08:06:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:37760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263947AbTH1MGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 08:06:51 -0400
Date: Thu, 28 Aug 2003 08:08:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Timo Sirainen <tss@iki.fi>, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
In-Reply-To: <20030828000321.GC3759@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0308280746400.2211@chaos>
References: <1061987837.1455.107.camel@hurina> <200308271442.48672.martin.konold@erfrakon.de>
 <1061988729.1457.115.camel@hurina> <Pine.LNX.4.53.0308270925550.278@chaos>
 <20030828000321.GC3759@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003, Jamie Lokier wrote:

> Richard B. Johnson wrote:
> > Let's see if it is possible for the middle byte of
> > a 3-byte sequence to not be written when both
> > other bytes are written:
>
> > Even in machines that do load/store operations where individual
> > components of those stores happen in groups, access to/from
> > a buffer of such data is controlled (by hardware) so a write
> > will complete before a read occurs.
>
> I don't understand what you mean by this.
>
> Do you mean that the writes are forced to appear on a different CPU in
> the same order that they were written?  That isn't true on x86, for
> two reasons: 1. writes aren't always in processor order (see
> CONFIG_X86_OOSTORE and CONFIG_X86_PPRO_FENCE); 2. reads on the other
> processor are out of order anyway.
>

I never said, nor even implied any such thing.

> > With hardware that can perform byte-access (ix86), the only
> > byte-access that is going to happen is at the end(s) of buffers.
>
> Not true.  Take a look at __copy_user() in arch/i386/lib/usercopy.c.
> The first few bytes are copied using "rep;movsb", which is not
> guaranteed to use a word write for the aligned pair, nor is it
> guaranteed a particular timing (there could be an interrupt between
> each byte).
>

Of course it's true. The implimentation detail of trimming the
start or finish of a copy procedure trims the ends. That's,
in fact, why it is impossible, yes, __impossible__ for the byte-sequence
0xABC to have both 0xA and 0xC copied without the 0xB being copied also.
There are no combinations of byte/word/long writes that will allow
this to happen.

It doesn't make any difference about the endian either as I
have previously shown.

Whether or not there's an interrupt between each byte means nothing
also. In the byte copy described, an interruopt at any time will
simply leave:

XXX
XXC
XBC
ABC

Clearly, if both A and C were copied, B was copied also.
You can screw around with endian and use words and longwords
as well. It just isn't possible for, in any 3-byte sequence
for the middle byte to be missing.


If 0x0A, 0x,0B, 0x0c, exist in memory as a word (longword),
with Intel, the lowest byte is in the lowest memory location.
Therefore, we have a word of 0xXCBA or 0xCBAX, depending upon
whether the high nibble or the low nibble becomes part of the
short. Notice that the 'B' is always between 'A' and 'C'?
Therefore if A and C got copied, B must have also been copied.

> Other architectures are similar.
>
> -- Jamie
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


