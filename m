Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbRETTea>; Sun, 20 May 2001 15:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262172AbRETTeT>; Sun, 20 May 2001 15:34:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64269 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262168AbRETTeP>; Sun, 20 May 2001 15:34:15 -0400
Date: Sun, 20 May 2001 12:34:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Matthew Wilcox <matthew@wil.cx>, David Woodhouse <dwmw2@infradead.org>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <Pine.GSO.4.21.0105201523370.8940-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105201228270.7759-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 May 2001, Alexander Viro wrote:
> 
> On Sun, 20 May 2001, Matthew Wilcox wrote:
> 
> > On Sun, May 20, 2001 at 03:11:53PM -0400, Alexander Viro wrote:
> > > Pheeew... Could you spell "about megabyte of stuff in ioctl.c"?
> > 
> > No.
> > 
> > $ ls -l arch/*/kernel/ioctl32*.c
> > -rw-r--r--    1 willy    willy       22479 Jan 24 16:59 arch/mips64/kernel/ioctl32.c
> > -rw-r--r--    1 willy    willy      109475 May 18 16:39 arch/parisc/kernel/ioctl32.c
> > -rw-r--r--    1 willy    willy      117605 Feb  1 20:35 arch/sparc64/kernel/ioctl32.c
> > 
> > only about 100k.
> 
> You are missing all x86-only drivers.

Now, the point is that it _is_ doable, and by doing it in one standard
place (instead of letting each architecture fight it on its own) we'd
expose the problem better, and maybe get rid of some of those
architecture-specific ones.

For example, right now the fact that part of the work _has_ been done by
things like Sparc64 has not actually had any advantages: the sparc64 work
has not allowed people to say "let's try to merge this work", because it
has not been globally relevant, and a sparc64-only file has not been a
single point of contact that could be used to clean up things.

In contrast, a generic file has the possibility of creating new VFS or
device-level interfaces. You can catch block device ioctl's and turn them
into proper block device requests - and send them down the right request
queue. Suddenly a block device driver doesn't just get READ/WRITE
requests, it gets EJECT/SERIALIZE requests too. Without having to add
magic ioctl's that are specific to just one device driver. 

So by having a common point of access, you can actually encourage _fixing_
some of the problems. Historically, sparc64 etc have not been able to do
that - they can only try to convert different ioctl's into another format
and then re-submitting it..

		Linus

