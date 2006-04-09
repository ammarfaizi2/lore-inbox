Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWDIUhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWDIUhu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 16:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWDIUhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 16:37:50 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:21418 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750703AbWDIUht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 16:37:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: shrink_all_memory tweaks (was: Re: Userland swsusp failure (mm-related))
Date: Sun, 9 Apr 2006 22:36:44 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Fabio Comolli <fabio.comolli@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <200604090047.17372.rjw@sisk.pl> <200604090924.04951.kernel@kolivas.org>
In-Reply-To: <200604090924.04951.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604092236.45768.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

On Sunday 09 April 2006 01:24, Con Kolivas wrote:
> On Sunday 09 April 2006 08:47, Rafael J. Wysocki wrote:
> > On Saturday 08 April 2006 18:15, Pavel Machek wrote:
> > > > > This is my first (and unique) failure since I began testing uswsusp
> > > > > (2.6.17-rc1 version). It happened (I think) because more than 50% of
> > > > > physical memory was occupied at suspend time (about 550 megs out og
> > > > > 1G) and that was what I was trying to test. After freeing some memory
> > > > > suspend worked (there was no need to reboot).
> > > >
> > > > Well, it looks like we didn't free enough RAM for suspend in this case.
> > > > Unfortunately we were below the min watermark for ZONE_NORMAL and
> > > > we tried to allocate with GFP_ATOMIC (Nick, shouldn't we fall back to
> > > > ZONE_DMA in this case?).
> > > >
> > > > I think we can safely ignore the watermarks in swsusp, so probably
> > > > we can set PF_MEMALLOC for the current task temporarily and reset
> > > > it when we have allocated memory.  Pavel, what do you think?
> > >
> > > Seems little hacky but okay to me.
> > >
> > > Should not fixing "how much to free" computation to free a bit more be
> > > enough to handle this?
> >
> > Yes, but in that case we'll leave some memory unused. ;-)
> 
> How's the shrink_all_memory tweaks I sent performing for you Rafael? It may 
> theoretically be prone to the same issue but I tried to make it less likely.

Well, I don't think it would help in this particular case.  The memory got divided
almost ideally in swsusp_shrink_memory() and we were hit by the lowmem
reserve in ZONE_DMA, apparently.

Still I've been doing a crash course in mm internals recently and I can say a
bit more about your patch now. ;-)

First, I agree that using balance_pgdat() for freeing memory by swsusp is
overkill, so the removal of its second argument seems to be a good idea to
me.  However, I'd rather avoid modifying struct scan_control and shrink_zone()
and reimplement the shrink_zone()'s logic directly in shrink_all_memory(),
with some modifications (eg. we can explicitly avoid shrinking of the active
list until we decide it's worth it) -- or we can define a separate function for
this purpose.

Second, there are a couple of details I'd do in a different way.  For example
I think we should call shrink_slab() with the non-zero first argument
(otherwise it'll use SWAP_CLUSTER_MAX) and instead of setting
zone->prev_priority to 0 I'd set vm_swappiness to 100 temporarily
(or maybe l'd left it to the user to set swappiness before suspend?).

Also I think we can try to avoid slab shrinking until we start to shrink the
active zone or IOW until we can't get any more pages from the inactive
list alone.

If you don't mind, I'll try to rework your patch a bit in accordance with
the above remarks in the next couple of days.

Greetings,
Rafael
