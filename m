Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVJEITN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVJEITN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 04:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVJEITN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 04:19:13 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:27017 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932569AbVJEITN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 04:19:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Date: Wed, 5 Oct 2005 10:20:15 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
References: <20051002231332.GA2769@elf.ucw.cz> <200510050047.45697.rjw@sisk.pl> <20051005000658.GJ18481@elf.ucw.cz>
In-Reply-To: <20051005000658.GJ18481@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510051020.15400.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 5 of October 2005 02:06, Pavel Machek wrote:
> Hi!
> 
> > > Well, same cleanup can be done after the split, just as easily.
> > > 
> > > > 3) some cleanups are due before the splitting (eg. function names, the removal
> > > > of prepare_suspend_image() etc.),
> > > 
> > > Split does not prevent you from doing the cleanups.
> > 
> > No, it doesn't, but the flow of changes would be easier to follow if the
> > cleanups were made first (ie. cleanup -> smaller and simpler code ->
> > split).
> 
> I wanted to have a "this changes nothing" patch first. Cleanups in
> front would be trickier to do because period of "settle down" is
> needed before split. We now had quite a long "settle down" period, so
> I've seen opportunity to do the split now.

OK, but if we decide to move some functions from one file to another,
we'll have to wait for another "settle down" period, I think.

> > > No. It needs to be controlled by storage-handling parts, so that
> > > snapshot-handling parts become nice library.
> > 
> > You are right, I have confused the sides.  I should have said like that:
> > The snapshot-handling part makes some functions available to the
> ...
> > part need not care for what happens to the pages of data send to the
> > storage-handling parts as long as it can receive them back in the same
> > order in which they have been sent.
> 
> Nicely said.

Thanks, and I belive it can be made that way.

> > > That is ugly. snapshot needs to be called from storage handling parts,
> > > and then interface can become much simpler:
> > > 
> > > struct pbe *sys_snapshot();
> > > 
> > > snapshots a system, then you can save it in any way you want. And
> > > 
> > > void sys_restore(struct pbe *);
> > > 
> > > . Simple, eh?
> > 
> > Well, aren't there any problems with handling kernel addresses from the user
> > space and vice versa?
> 
> Nothing we could not handle. Kernel needs to use get_user, while
> userspace needs to seek/read/write on /dev/kmem (when accessing "the
> other" addresses).

Shouldn't we avoid using /dev/kmem?  Especially that some people wanted it
to go already.

> > Anyway, I think on resume we should send data from the user space to the
> > kernel and let the kernel arrange them in memory instead of placing them in
> > memory directly from the used space.  By symmetry, on suspend we should send
> > data from the kernel to the user space instead of allowing the users space
> > to read memory at will.  IMO the arrangement of the data in memory should
> > not be visible to the user space at all.
> 
> I thought about that -- user/kernel interface would certainly be nicer
> -- but I do not think it is feasible without writing a lot of code. 

I thought of two in-kernel subsystems with a well defined interface
between them first, such that one of them could be replaced with a
user space implementation (partially or as a whole) in the future.

I think I can come up with a proof-of-concept patch if that helps.

> [I agree that assymetry I have in there is ugly, but I don't see a way
> to do alloc_pagedir() in userspace, and I'd like to keep page
> relocation in userspace.]

I'd think the page relocation is easier in the kernel, as we have access to
zones and we can use swsusp_free() to clean things up if something goes
wrong (of course that's after some changes).

Greetings,
Rafael
