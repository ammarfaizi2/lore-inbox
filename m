Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270487AbTHOWGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271025AbTHOWGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:06:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39439
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270487AbTHOWFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:05:20 -0400
Date: Fri, 15 Aug 2003 15:05:19 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ed L Cashin <ecashin@uga.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] do_wp_page: BUG on invalid pfn
Message-ID: <20030815220519.GS1027@matchmail.com>
Mail-Followup-To: Ed L Cashin <ecashin@uga.edu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20030815184720.A4D482CE79@lists.samba.org> <877k5e8vwe.fsf@uga.edu> <20030815212244.GQ1027@matchmail.com> <87k79e7fna.fsf@uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k79e7fna.fsf@uga.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:52:09PM -0400, Ed L Cashin wrote:
> Mike Fedyk <mfedyk@matchmail.com> writes:
> 
> > On Fri, Aug 15, 2003 at 05:15:45PM -0400, Ed L Cashin wrote:
> >> Rusty Russell <rusty@rustcorp.com.au> writes:
> >> 
> >> > In message <87d6fixvpm.fsf@uga.edu> you write:
> >> >> This patch just does what the comment says should be done.
> >> >
> >> > Hi Ed!
> >> >
> >> > 	Not trivial I'm afraid.  Send to Linus and lkml.
> >> 
> >> 
> >> This patch just does what the comment says should be done.  I thought
> >> it was a trivial patch, but Rusty Russell has informed me otherwise.
> >> (Thanks, RR).
> >> 
> >> 
> >> --- linux-2.6.0-test2/mm/memory.c.orig	Sun Jul 27 13:01:24 2003
> >> +++ linux-2.6.0-test2/mm/memory.c	Wed Aug  6 18:30:55 2003
> >> @@ -990,15 +990,10 @@
> >>  	int ret;
> >>  
> >>  	if (unlikely(!pfn_valid(pfn))) {
> >> -		/*
> >> -		 * This should really halt the system so it can be debugged or
> >> -		 * at least the kernel stops what it's doing before it corrupts
> >> -		 * data, but for the moment just pretend this is OOM.
> >> -		 */
> >> -		pte_unmap(page_table);
> >>  		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
> >>  				address);
> >> -		goto oom;
> >> +		dump_stack();
> >> +		BUG();
> >
> > You're not unmapping the pte I guess to not interfere with the dump_stack,
> 
> This patch changes the logic from "pretend it's out of memory" to
> "announce something's very wrong and bail out right away."  Unmapping
> the pte seems like a precursor to carrying on business as usual, but
> there must be some subtleties here that I am unaware of, or Rusty
> Russell wouldn't have called this patch non-trivial.

So does show_stack() halt the kernel?  If not, then you probably want the
pte_unmap since you'll have a working/semi-working system after the bug()
call.

And if show_stack() does halt the kernel, what's the point of bug() then?
