Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbVI0V20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVI0V20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVI0V20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:28:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35712 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965154AbVI0V2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:28:25 -0400
Date: Tue, 27 Sep 2005 23:08:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][Fix] Fix Bug #4959 (take 2)
Message-ID: <20050927210821.GF2040@elf.ucw.cz>
References: <200509241936.12214.rjw@sisk.pl> <200509271007.03865.rjw@sisk.pl> <20050927133218.GB9484@openzaurus.ucw.cz> <200509272300.37197.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509272300.37197.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do not really like new exports from swsusp.c, but I'm afraid
> > there's no way around.
> 
> Well, there is one, if we use a static buffer, as you propose, since
> in that case we will not need get_usable_pages() etc. outside of
> swsusp.c.  The drawback of this, however, is that we will limit the
> size of RAM for which it is possible to suspend (we need at least 1 page
> for the PGD, 1 page for a PUD plus as many pages as there are GBs of
> RAM for PMDs).  If we want to cover the huge-RAM cases, the buffer will
> be too large for the average case, but otherwise some boxes will not
> be able to suspend.

1GB per 4K seems pretty much okay.

> > > The following patch fixes Bug #4959.  For this purpose it creates temporary
> > > page translation tables including the kernel mapping (reused) and the direct
> > > mapping (created from scratch) and makes swsusp switch to these tables
> > > right before the image is restored.
> > 
> > Why do you need *two* mappings? Should not just kernel mapping be enough?
> 
> The kernel mapping is for the kernel text.  The direct mapping maps the physical
> RAM linearly to the set of virtual addresses starting at
> PAGE_OFFSET.

Could not you just add phys_to_virt at some strategic place? 

> > Why? Reserve ten pages for them... static char resume_page_tables[10*PAGE_SIZE] does not
> > sound that bad.
> 
> That will allow us to suspend if there's no more that 8GB of RAM in the box.
> Is it acceptable?

I'd say so.

> > > Moreover, such a code would have to be executed on every boot and the
> > > temporary page tables would always be present in memory.
> > 
> > Yep, but I do not see that as a big problem.
> 
> OK
> 
> I can reserve the static buffer (10 pages) in suspend.c and mark it as nosave.
> The code that creates the mappings can stay in suspend.c either except it
> won't need to call get_usable_page() and free_eaten_memory() any more
> (__next_page() can be changed to get pages from the static buffer instead
> of allocating them).  The code can also be simplified a bit, as we assume that
> there will be only one PGD entry in the direct mapping.
> 
> If that sounds good to you, please confirm.

8GB limit seems good to me -- as long as it makes code significantly
simpler. It would be nice if it was <20 lines.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
