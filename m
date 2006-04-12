Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWDLFab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWDLFab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWDLFab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:30:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:49374 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750802AbWDLFaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:30:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Userland swsusp failure (mm-related)
Date: Wed, 12 Apr 2006 07:29:23 +0200
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Fabio Comolli <fabio.comolli@gmail.com>, linux-kernel@vger.kernel.org
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <20060411213659.GA9548@atrey.karlin.mff.cuni.cz> <200604120010.09848.rjw@sisk.pl>
In-Reply-To: <200604120010.09848.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604120729.24489.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 12 April 2006 00:10, Rafael J. Wysocki wrote:
> On Tuesday 11 April 2006 23:36, Pavel Machek wrote:
> > > > Rafael J. Wysocki wrote:
> > > > >>>Well, it looks like we didn't free enough RAM for suspend in this case.
> > > > >>>Unfortunately we were below the min watermark for ZONE_NORMAL and
> > > > >>>we tried to allocate with GFP_ATOMIC (Nick, shouldn't we fall back to
> > > > >>>ZONE_DMA in this case?).
> > > > >>>
> > > > >>>I think we can safely ignore the watermarks in swsusp, so probably
> > > > >>>we can set PF_MEMALLOC for the current task temporarily and reset
> > > > >>>it when we have allocated memory.  Pavel, what do you think?
> > > > >>
> > > > >>Seems little hacky but okay to me.
> > > > >>
> > > > >>Should not fixing "how much to free" computation to free a bit more be
> > > > >>enough to handle this?
> > > > > 
> > > > > 
> > > > > Yes, but in that case we'll leave some memory unused. ;-)
> > > > > 
> > > > 
> > > > Probably doesn't fall back to ZONE_DMA because of lowmem reserve.
> > > > Yes, PF_MEMALLOC sounds like it might do what you want. A little
> > > > hackish perhaps, but better than putting swsusp special cases
> > > > into page_alloc.c.
> > > 
> > > The appended patch contains the changes I'd like to make.  Pavel, is that
> > > acceptable?
> > 
> > Why is PF_MEMALLOC only neccessary for pagedir allocations, and not
> > for normal page allocations, too?
> 
> Right, we'll need it untli we finally free the image, so I think it should be
> set/reset in disk.c:pm_suspend_disk().
> 
> However, there's a problem with this approach wrt the userland suspend, because
> we'd have to keep PF_MEMALLOC set accross ioctls and I wouldn't like to do
> this.
> 
> Well, the alternative solution would be to take the ZONE_DMA's lowmem reserve
> into account in our free memory computations.

OK, the appended patch subtracts each zone's lowmem reserve for ZONE_NORMAL
from the number of free pages because we are going to allocate from the normal
zone and won't be able to use the lowmem reserves.

Please have a look.

Greetings,
Rafael

---
 kernel/power/swsusp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/kernel/power/swsusp.c	2006-04-12 07:09:20.000000000 +0200
+++ linux-2.6.17-rc1-mm2/kernel/power/swsusp.c	2006-04-12 07:11:09.000000000 +0200
@@ -192,8 +192,10 @@ int swsusp_shrink_memory(void)
 			PAGES_FOR_IO;
 		tmp = size;
 		for_each_zone (zone)
-			if (!is_highmem(zone))
+			if (!is_highmem(zone) && zone->present_pages > 0) {
 				tmp -= zone->free_pages;
+				tmp += zone->lowmem_reserve[ZONE_NORMAL];
+			}
 		if (tmp > 0) {
 			tmp = shrink_all_memory(SHRINK_BITE);
 			if (!tmp)
