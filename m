Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbSJHVgq>; Tue, 8 Oct 2002 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJHVgp>; Tue, 8 Oct 2002 17:36:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:241 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261438AbSJHVgn>;
	Tue, 8 Oct 2002 17:36:43 -0400
Date: Tue, 8 Oct 2002 17:42:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Patrick Mochel <mochel@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210081425430.1457-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210081735370.5897-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Oct 2002, Linus Torvalds wrote:

> 
> On Tue, 8 Oct 2002, Alexander Viro wrote:
> > 
> > Its reference counts mean squat if they are not seen by the code that
> > allocates/frees the object struct device is embedded into.
> 
> But Al, that's the whole _point_ of having the callback.
> 
> Allow the refcounts to be in an embedded entity, and then anybody who gets 
> the entity (_or_ the embedded thing) will increment the same count.
> 
> When the count goes to zero, the embedded thing needs to call the 
> _embedders_ release function - because the embedded thing doesn't even 
> know how it got allocated. 
> 
> Al, this time you're wrong, and the code you're unhappy about going about 
> it the right way. The reference count _has_ to be held by the lowest-level 
> thing (because that's the only generic part), yet the actual allocation 
> and de-allocation is done by the higher levels. Which is why the lower 
> levels need to know which freeing function to call.

That would be nice, if it worked that way.  As it is we have

driver allocates foo
driver grabs a reference to foo->dev
....
somebody else grabs/drops temporary references to foo->dev
....
driver call put_device(&foo->dev)
driver frees structures refered from foo.
driver frees foo.

_IF_ the last two steps were done by ->release(), your arguments would
work.  Actually they are done by driver right after the put_device() call.

If you are willing to change that (== move all destruction into ->release()) -
yeah, then embedded struct device will work.  It's a hell of a work though.

Comments?

