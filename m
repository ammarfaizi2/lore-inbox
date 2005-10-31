Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVJaAfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVJaAfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVJaAfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:35:19 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:53683 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932424AbVJaAfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:35:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Date: Mon, 31 Oct 2005 01:35:41 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200510301637.48842.rjw@sisk.pl> <200510302337.41526.rjw@sisk.pl> <20051030230407.GA1655@elf.ucw.cz>
In-Reply-To: <20051030230407.GA1655@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310135.42190.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 31 of October 2005 00:04, Pavel Machek wrote:
> Hi!
> 
> > > > Please note that the relocating code uses the page flags to mark the allocated
> > > > pages as well as to avoid the pages that should not be used.  In my opinion
> > > > no userspace process should be allowed to fiddle with the page
> > > > flags.
> > > 
> > > Of course, userspace would have to use separate data structure. [Hash table?]
> > 
> > IMO a bitmap could be used.  Anyway in that case the x86-64 arch code
> > would need to have access either to this structure or to the image metadata,
> > because it must figure out which pages are not safe.  I don't see any simple
> > way of making this work ...
> 
> Can you elaborate? resume is certainly going to get list of pbes...

OK
On x86-64 we have to allocate a few safe pages to put the temporary page
tables on them.  In principle I can imagine the following code for this:

do {
	get a page;
	walk the list of pbes to verify that the page is safe;
	if (the page is not safe)
		keep track of it;
} while (the page is not safe)

but I'd rather not like to propose Andi to merge it. ;-)  Currently the x86-64 arch
code uses the same method of marking non-safe pages that is used by
the rest of swsusp for efficiency and I think it should stay this way.

}-- snip --{
> > 
> > Well, you have taken these things out of context.  Namely, the userspace
> > process cannot freeze the other tasks, suspend devices etc., so it
> > has to
> 
> Yes, process freezing probably needs to be separate. Suspending
> devices can well be part of atomic_snapshot operation; userspace does
> not need to care.
> 
> > call the kernel for these purposes anyway.  Of course if something goes
> > wrong it has to call the kernel to revert these steps too.  Similarly it
> > can call the kernel to allocate the image memory and to free it in case
> > something's wrong.  For example, if the userspace initiates the resume:
> > 
> > - if (image not found)
> > 	exit
> > - sys_freeze_processes /* this one will be tricky ;-) */
> 
> Why, I have it implemented? Just do not freeze the process calling you.

"tricky" != "impossible" ;-)

> > - sys_create_pagedir
> 
> Ugly...

Oh, it can be done on-the-fly in
sys_put_this_stuff_where_appropriate(image data) (at the expense of one
redundant check per call).

> > - while (image data) {
> > 	sys_put_this_stuff_where_appropriate(image data);
> > 	/* Here the kernel will do the relocation etc. if necessary */
> > 	if (something's wrong)
> > 		goto Cleanup; }
> > - sys_atomic_restore /* suspend devices, disable IRQs, restore */
> 
> Exactly. I'd like to go a
> 
> > Cleanup: /* certainly something's gone wrong */
> > - sys_destroy_pagedir /* that's it */
> > - sys_resume_devices
> 
> You should not need to do this one. resuming devices is going to be
> integrated in atomic_restore, because suspending devices is there, too.

Yes, but I need to thaw processes anyway, so I can release memory as well.
OTOH, if sys_atomic_restore fails because of the lack of memory, the memory
should be freed _before_ resuming devices, since otherwise subsequent
failures are almost certain to appear (I've seen what happens in that case).
Now, if the memory is allocated by the kernel, I can easily put an
emergency memory-freeing call in sys_atomic_restore (in that case
sys_destroy_pagedir will be redundant, but so what?).

> Here's how it looks... additionaly, I have ioctl for getting one
> usable page. It is true that I did not solve error paths, yet; I'll
> certainly need some way to free memory, too.

IMHO, these are important issues.
 
Greetings,
Rafael

