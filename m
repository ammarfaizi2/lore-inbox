Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbTLKKGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 05:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbTLKKGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 05:06:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20901 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264594AbTLKKG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 05:06:29 -0500
Date: Thu, 11 Dec 2003 10:06:27 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hannu Savolainen <hannu@opensound.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Driver API (was Re: Linux GPL and binary module exception clause?)
Message-ID: <20031211100627.GJ4176@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com> <Pine.LNX.4.58.0312100852210.29676@home.osdl.org> <20031210175614.GH6896@work.bitmover.com> <Pine.LNX.4.58.0312100959180.29676@home.osdl.org> <20031210180822.GI6896@work.bitmover.com> <Pine.LNX.4.58.0312101016010.29676@home.osdl.org> <20031210183833.GJ6896@work.bitmover.com> <Pine.LNX.4.58.0312101108150.29676@home.osdl.org> <Pine.LNX.4.58.0312102256520.3787@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312102256520.3787@zeus.compusonic.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 02:50:20AM +0200, Hannu Savolainen wrote:
 
> Even better would be a proper device driver ABI for "loosely integrated"
> device drivers. It's possible to hide differences between kernel releases
> so that the same driver can work with wide range of kernel versions).
> There are some performance penalties but they are not significant. And the
> drivers included in the kernel source tree don't need to use this
> interface so I don't see there any _technical_ reasons against this idea.
> I can volunteer to implement this interface if it's OK. Some motivation
> for the ABI as well as some technical ideas will be at the end of this
> message.

It doesn't work.  Let me give you an example: right now we have a way to get
from struct inode to struct block device - inode->i_bdev.  You can wrap it
into helper functions, whatever - it won't live to 2.8.

	Why?  Because if we want to handle device removal in a sane way, that
association will have to go.  We will still have a need (and a way) to get
from opened struct file of block device to its struct block_device.  And _that_
association will remain stable through the entire life of struct file.  Even
when the mapping from inode to block device gets changed.

	And it means that arguments of block device ->open(), ->release() and
->ioctl() will change - instead of struct inode we will pass the struct
block_device directly.  It's OK - callers have a way to get the thing and
methods themselves... right now the first thing they do is
	struct block_device *bdev = inode->i_bdev;
and either don't use inode afterwards at all or (very few) use it in a way
that can be replaced with use of bdev (e.g. inode->i_rdev -> bdev->bd_dev,
etc.).  The sole exception (floppy.c) still can get what it wants from the
second argument of ->open() (struct file *).

	The rest of the tree also can deal - I've done that and patches are
in -mm right now.  Most of them are easily mergable in 2.6, BTW.

	See what it means?  No fscking way to deal with that in wrappers.
Simply because the old assumption (inode->block_device remains stable)
is flat out wrong with new kernel.  Note that "just add a new API and leave
the old one for old drivers" would *NOT* work here.

	And yes, it's an interface change.  Caused by the fact that old
interface is Wrong(tm) (BTW, large part of that one is my fault - design
mistake in 2.3 that hadn't become obvious until 2.5.late).  Sure, we can
declare the new variant a part of ABI and have the glue for 2.4 and 2.6
wrap the new ->open()/->ioctl()/->release() with boilerplate that will
produce old-style ones.  _That_ direction is easy.  But that won't help
you with ABI - it allows to put new driver into old kernel, not the other
way round.  Which, come to think of it, is hardly a surprise - hindsight
is always 20/20 and all such.

	There is a good measure of interface quality - the less boilerplate
code you need to use it, the better.  It's not a trivial observation and
not just a matter of aesthetics.  It also means that there's less chance
of non-trivial breakage.  Note that you can wrap a good interface into bad
one - and that can usually be done in a uniform way (i.e. by _adding_ that
boilerplate code).  You can't go the other way round.  Case above is a good
example of that effect.

	See the problem now?  We can keep the same payload code if it uses
a good interface and we add wrappers to make it work with kernels that give
worse interfaces.  So if we design a really good one, we can say "that's our
ABI" and... what, exactly?  As long as new kernels have interfaces that are
not better than our, we are OK.  But it simply means that
	a) we should just use that good interface (and no glue) as kernel one.
	b) as soon as we have a need to improve the kernel interface, no amount
of glue is going to save that "ABI".
	c) in case if we decide to make kernel interface *WORSE*, our ABI will
really shine - then we will simply add glue to deal with degraded kernel.

	Which leaves only one question - why in damnation name would we ever
go for the case (c)?

	In other words, the nature of interface changes is such that usually
you can do glue between old interface and new driver and not the other way
round.  Which kills ABI idea - either you get a particular interface 100%
right and no glue is needed (then interface never changes simply because it's
Right(tm) and needs no changes) or you do not and no glue will save you as
soon as change becomes necessary.

	I'm a fairly arrogant bastard, but I do *not* claim that I can do
all interfaces right at once and avoid design mistakes.  Do you?  And if
yes, where can I get the drugs you are on?
