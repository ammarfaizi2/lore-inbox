Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVJaV7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVJaV7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVJaV7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:59:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49316 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964856AbVJaV7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:59:50 -0500
Date: Mon, 31 Oct 2005 22:59:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Message-ID: <20051031215938.GB14877@elf.ucw.cz>
References: <200510301637.48842.rjw@sisk.pl> <200510302337.41526.rjw@sisk.pl> <20051030230407.GA1655@elf.ucw.cz> <200510310135.42190.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510310135.42190.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you elaborate? resume is certainly going to get list of pbes...
> 
> OK
> On x86-64 we have to allocate a few safe pages to put the temporary page
> tables on them.  In principle I can imagine the following code for this:
> 
> do {
> 	get a page;
> 	walk the list of pbes to verify that the page is safe;
> 	if (the page is not safe)
> 		keep track of it;
> } while (the page is not safe)
> 
> but I'd rather not like to propose Andi to merge it. ;-)  Currently the x86-64 arch
> code uses the same method of marking non-safe pages that is used by
> the rest of swsusp for efficiency and I think it should stay this
> way.

Ok, I see.

> > > - sys_create_pagedir
> > 
> > Ugly...
> 
> Oh, it can be done on-the-fly in
> sys_put_this_stuff_where_appropriate(image data) (at the expense of one
> redundant check per call).

Yes, but it is still ugly, as you keep some context across the
syscalls.

> > > Cleanup: /* certainly something's gone wrong */
> > > - sys_destroy_pagedir /* that's it */
> > > - sys_resume_devices
> > 
> > You should not need to do this one. resuming devices is going to be
> > integrated in atomic_restore, because suspending devices is there, too.
> 
> Yes, but I need to thaw processes anyway, so I can release memory as well.
> OTOH, if sys_atomic_restore fails because of the lack of memory, the memory
> should be freed _before_ resuming devices, since otherwise subsequent
> failures are almost certain to appear (I've seen what happens in that case).
> Now, if the memory is allocated by the kernel, I can easily put an
> emergency memory-freeing call in sys_atomic_restore (in that case
> sys_destroy_pagedir will be redundant, but so what?).

Ugh, I'd say "don't care about this one too much". If resume is
failing, we have bad problems anyway.

> > Here's how it looks... additionaly, I have ioctl for getting one
> > usable page. It is true that I did not solve error paths, yet; I'll
> > certainly need some way to free memory, too.
> 
> IMHO, these are important issues.

Yes, but I do not expect any problems while actually coding that...

								Pavel
-- 
Thanks, Sharp!
