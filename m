Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVJEAHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVJEAHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 20:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVJEAHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 20:07:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20927 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965045AbVJEAHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 20:07:22 -0400
Date: Wed, 5 Oct 2005 02:06:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Message-ID: <20051005000658.GJ18481@elf.ucw.cz>
References: <20051002231332.GA2769@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz> <200510050047.45697.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510050047.45697.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, same cleanup can be done after the split, just as easily.
> > 
> > > 3) some cleanups are due before the splitting (eg. function names, the removal
> > > of prepare_suspend_image() etc.),
> > 
> > Split does not prevent you from doing the cleanups.
> 
> No, it doesn't, but the flow of changes would be easier to follow if the
> cleanups were made first (ie. cleanup -> smaller and simpler code ->
> split).

I wanted to have a "this changes nothing" patch first. Cleanups in
front would be trickier to do because period of "settle down" is
needed before split. We now had quite a long "settle down" period, so
I've seen opportunity to do the split now.

> > No. It needs to be controlled by storage-handling parts, so that
> > snapshot-handling parts become nice library.
> 
> You are right, I have confused the sides.  I should have said like that:
> The snapshot-handling part makes some functions available to the
...
> part need not care for what happens to the pages of data send to the
> storage-handling parts as long as it can receive them back in the same
> order in which they have been sent.

Nicely said.

> > That is ugly. snapshot needs to be called from storage handling parts,
> > and then interface can become much simpler:
> > 
> > struct pbe *sys_snapshot();
> > 
> > snapshots a system, then you can save it in any way you want. And
> > 
> > void sys_restore(struct pbe *);
> > 
> > . Simple, eh?
> 
> Well, aren't there any problems with handling kernel addresses from the user
> space and vice versa?

Nothing we could not handle. Kernel needs to use get_user, while
userspace needs to seek/read/write on /dev/kmem (when accessing "the
other" addresses).

> Anyway, I think on resume we should send data from the user space to the
> kernel and let the kernel arrange them in memory instead of placing them in
> memory directly from the used space.  By symmetry, on suspend we should send
> data from the kernel to the user space instead of allowing the users space
> to read memory at will.  IMO the arrangement of the data in memory should
> not be visible to the user space at all.

I thought about that -- user/kernel interface would certainly be nicer
-- but I do not think it is feasible without writing a lot of code. 

[I agree that assymetry I have in there is ugly, but I don't see a way
to do alloc_pagedir() in userspace, and I'd like to keep page
relocation in userspace.]

> Still I'm afraid in the future we'll be moving some functions between
> snapshot.c and swsusp.c back and forth ...

We may have to move function or two, but I think nothing too dramatic
will happen.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
