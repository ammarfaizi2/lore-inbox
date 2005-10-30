Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVJ3V2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVJ3V2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVJ3V2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:28:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35227 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932305AbVJ3V2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:28:50 -0500
Date: Sun, 30 Oct 2005 22:28:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Message-ID: <20051030212832.GB19284@elf.ucw.cz>
References: <200510301637.48842.rjw@sisk.pl> <200510301644.44874.rjw@sisk.pl> <20051030195254.GA1729@openzaurus.ucw.cz> <200510302216.17413.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510302216.17413.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This patch moves the snapshot-handling functions remaining in swsusp.c
> > > to snapshot.c (ie. it moves the code without changing the functionality).
> > >
> > I'm sorry, but I acked this one too quickly. I'd prefer to keep "relocate" code where
> > it is, and define "must not collide" as a part of interface.
> 
> That's doable, but frankly I don't like the idea.
> 
> > That will keep snapshot.c smaller/simpler, and I plan to
> > eventually put responsibility for relocation to userspace.
> 
> Please note that the relocating code uses the page flags to mark the allocated
> pages as well as to avoid the pages that should not be used.  In my opinion
> no userspace process should be allowed to fiddle with the page
> flags.

Of course, userspace would have to use separate data structure. [Hash table?]

> Moreover, get_safe_page() is called directly by the arch code on x86-64,
> so it has to stay in the kernel and hence it should be in snapshot.c.
> OTOH the relocating code is nothing more than "if the page is not safe,
> use get_safe_page() to allocate one" kind of thing, so I don't see a point
> in taking it out of the kernel (in the future) too.

Well... for resume. If userspace does the allocation, it is:

userspace reads image
userspace relocates it
sys_atomic_restore(image)
if something goes wrong, userspace is clearly responsible for freeing
it.

How would you propose kernel<->user interface?

userspace reads pagedir
sys_these_pages_are_forbidden(pagedir)
userspace reads rest
sys_atomic_restore(image)
if something goes wrong, userspace must dealocate pages _and_ clear
forbidden flags?

> > That should simplify error handling at least: data structures
> > needed for relocation can be kept in userspace memory,
> 
> Well, after the patches that are already in -mm we don't use any additional
> data structures for this purpose, so that's not a problem, I
> think. ;-)

Until someone will want to get page flag bits back ;-), ok.

								Pavel
-- 
Thanks, Sharp!
