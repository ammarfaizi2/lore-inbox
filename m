Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281718AbRKQJI2>; Sat, 17 Nov 2001 04:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281715AbRKQJIT>; Sat, 17 Nov 2001 04:08:19 -0500
Received: from 20dyn241.com21.casema.net ([213.17.90.241]:46980 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S281721AbRKQJIC>; Sat, 17 Nov 2001 04:08:02 -0500
Message-Id: <200111170907.KAA24566@cave.bitwizard.nl>
Subject: Re: mmap not working?
In-Reply-To: <3BF623B7.1050607@zytor.com> from "H. Peter Anvin" at "Nov 17, 2001
 00:45:43 am"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Sat, 17 Nov 2001 10:07:57 +0100 (MET)
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Rogier Wolff wrote:
> 
> > 
> > I know about TLBs. I know how they work, and I think I've explained it
> > well enough that rereading my message should allow you to understand
> > what I'm saying. Still, let me try to picture it... 
> > 
> > Situation A:
> > 
> > physical map. XX is the interesting part, | is a page boundary, = is 
> > "uninteresting stuff".  
> > 
> > 	|========|XX======|========|========|========|
> > 
> > virtual map: 
> > 
> > 	|--------|XX======|--------|--------|--------|
> >                   ^
> >                   | This is the pointer that mmap returns. 
> > 
> > - is "unmapped". 
> > 
> > 
> > Situation B: 
> > 
> > 	|========|======XX|========|========|========|
> > 
> > virtual map: 
> > 
> > 	|--------|======XX|--------|--------|--------|
> >                         ^
> >                         | This is the pointer that mmap returns. 
> > 
> > In Situation A I get the 1K mapped that I wanted and 3 more because
> > the MMU can't NOT give me access to that.  Situation B is exactly the
> > same, except that I get those extra 3K in front of the pointer
> > that I get returned by mmap. 
> > 
> 
> 
> Just make the adjustment in userspace, if your application really can 
> handle it.  This is never going to fly generically (and therefore not 
> get integrated into anything), because the PCI BIOS will typically map 
> multiple things into that 4K chunk, and thus you have opened up your 
> system to messing with a completely "innocent" device.
> 
> Since the only way is to avoid this involves moving your device to its 
> own 4K chunk of I/O space anyway, you don't really have a choice.

There is this application that was written in '91-93 that works in
situation A and not in situation B. It follows the ruls from "mmap"(*), 
but the kernel just doesn't do the obvious thing. 

If I address something before my 1k window, in situation A, I'll get a
segfault. If I address something beyond my 1k window in situation B
I'll get a segfault.

If I address something after my 1k window in situation A, I'll access
an innocent other device. Same if I address something before my window
in situation B.

Now in practise, I agree that it is more likely in situation B that
something is actually mapped there.

I'm not sure wether the kernel has been wrong all the time or if
something changed recently. I posted the "workaround" the first time
through, which also works from userspace. I can change my application. 
I can modify my libc. 

However, I'd rather have "mmap" fixed, as that fixes it for all other
applications too. Not just for mine on my system. 

The SGI manpage says: 

     All implementations interpret an addr value of
     zero as granting the system complete freedom in selecting pa, subject to
     constraints described below.  A non-zero value of addr is taken to be a
     suggestion of a process address near which the mapping should be placed.

which hints at a possible non-alignment. It also mentions that
"offset" should be page-aligned, which I disagree with here:
everything has been set up to "do the right thing" when the mapping is
possible with an unaligned offset.

		Roger. 


(*) Allow mmap to chose the address, to allow mmap the maximum
flexibilty of mapping your object. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
