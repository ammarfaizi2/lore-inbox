Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266571AbUBQUMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266568AbUBQUMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:12:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:56224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266580AbUBQUKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:10:31 -0500
Date: Tue, 17 Feb 2004 12:10:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: tridge@samba.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <20040217194414.GP8858@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0402171153460.2154@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
 <16433.47753.192288.493315@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
 <Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
 <20040217194414.GP8858@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> What will protect your generation counts during the operation itself?
> ->i_sem?

Yes. You have to take it anyway, so why not?

> If anything, I'd suggest doing it as
> 	cretinous_rename(dir_fd, name1, name2)
> with the following semantics:
> 
> 	* if directory had been changed since open() that gave us dir_fd -
>   -EFOAD
> 	* otherwise, rename name1 to name2 (no cross-directory renames here).

Sure, that works.

> No need to expose generation counts to userland - we can just compare the
> count at open() time with that at operation time.  The rest can be done
> in userland (including creation of files).

Note that I'm not sure we would expose generation counts at all to user 
space: we might keep all of this inside the "crapola windows behaviour" 
module, and user space could actually see some easier highlevel interface. 
Something like yours, but I suspect we'd want to see what the whole 
user-level loop would look like to know what the architecture should be 
like.

I do believe we'd need to have some way to "refresh" the fd in your
example, without restarting the whole lookup. So that when the user gets 
EFOAD, it can do

	refresh(fd);
	readdir(fd);
	/* Check that nothing clashes */
	goto try_again;

or similar. So the generation count _semantics_ would be exposed, even if 
the numbers themselves would be hidden inside the kernel.

> We _definitely_ don't want to put "UTF-8 case-insensitive comparison" anywhere
> near the kernel - it's insane.  If samba wants it, they get to pay the price,
> both in performance and keeping butt-ugly code (after all, the goal of project
> is to imitate butt-ugly system for butt-ugly clients).  The same goes for Wine.

I agree. We'd need to let user space do the equality comparisons, I just 
don't see how to sanely do it in kernel land.

> And we really don't want to encourage those who port Windows userland in
> not fixing the idiotic semantics.  As for Lindows... let's just say that
> I can't find any way to describe what I really think of those clowns, their
> intellect and their morals that wouldn't lead to a lawsuit from them.

Heh.

I suspect most people don't care that much, but I also suspect that 
projects like samba have to have a "anal mode" where they really act like 
Windows, even when it's "wrong". People can then choose to say "screw that 
idiocy", but by just _having_ a very compatible mode you deflect a lot of 
criticism. Regardless of whether people want the anal mode or not in real 
life.

Backwards compatibility is King. It's _hugely_ important. It's one of the
most important things to me in the kernel, and by the same logic I do see
that it is important to others as well - even when the backwards
compatibility ends up being inherited from a broken Windows setup. So
while I hate case-insensitive names, I do understand that people want to
have some way to emulate the braindamage for some _really_ "ass-backwards"
compatibility reasons.

So I think it's worth some pain, as long as we keep that compatibility 
from starting to encrust the _good_ stuff.

		Linus
