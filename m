Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSDDTLF>; Thu, 4 Apr 2002 14:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293347AbSDDTKz>; Thu, 4 Apr 2002 14:10:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20022 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S293337AbSDDTKu>; Thu, 4 Apr 2002 14:10:50 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>
	<a8flgc$ms2$1@cesium.transmeta.com>
	<m1lmc3qtaz.fsf@frodo.biederman.org> <3CAC9BD4.5050500@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2002 12:04:16 -0700
Message-ID: <m1hemrqo9b.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:

> No, that's not how that works in reality.  In practice, the boot loader picks
> the lowest address it can practically use, in order to minimize the conventional
> memory ceiling.  

A very sane thing to do.  Which makes the requirements/assumptions
in misc.c broken.

> For example, PXELINUX always loads at 0x50000, simply because
> odds that you have a PXE stack and can use 0x90000 is about zero to
> none.

O.k.  Than PXELINUX does what I would expect, instead of what seems to
be requested by the boot.txt

>  In
> fact, these days there are enough BIOSes that load stuff in the high part of
> memory that using 0x90000 is actively dangerous and **needs to be avoided**.
> Theoretically, you're right; it adds a  very small amount of memory to the
> decompression.  If that matters, there is actually a very easy way to deal with
> it: for any boot loader there is a Lowest Usable Address (conventional memory
> ceiling).  You can use INT 12h and adjust the load address all the way up to
> 0x90000 if the conventional memory ceiling permits; this usually is something
> like five lines of assembly.

Unless the fact is only recorded in the e820 memory map...

> > I'd like to change the way we do this, so I'm going to stare at this
> > problem a little bit more.  Changing the default load address and
> > still being able to compute how much memory the kernel is going
> > to use is a challenge.
> 
> There can't be a "default load address".  0x90000 is actively dangerous and
> trying to encourage it for anything than legacy kernels is WRONG. If you can't
> handle this, then you need to go back to the drawing board.

I agree.  But I do think being able to hard code the load address is a
very good thing.

After digesting the requirements I plan on having setup.S call int 12h
(so the information is available), and then having misc.c relocate the
real mode code, and the command line, out of the way, of it's
decompression buffer.  This removes the need for bootloaders to
make a tradeoff between memory use efficiency and reliability.

This should give me about 630KB on machines designed to run DOS, where
this matters.   Better than the current best of 572KB, with the real
mode code @ 0x90000. 

And when your total size is 1-4MB.  +-640KB is a significant change.

Eric
