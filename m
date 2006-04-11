Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWDKWLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWDKWLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWDKWLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:11:14 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:61148 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751143AbWDKWLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:11:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Userland swsusp failure (mm-related)
Date: Wed, 12 Apr 2006 00:10:09 +0200
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Fabio Comolli <fabio.comolli@gmail.com>, linux-kernel@vger.kernel.org
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <200604112333.22677.rjw@sisk.pl> <20060411213659.GA9548@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060411213659.GA9548@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604120010.09848.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 11 April 2006 23:36, Pavel Machek wrote:
> > > Rafael J. Wysocki wrote:
> > > >>>Well, it looks like we didn't free enough RAM for suspend in this case.
> > > >>>Unfortunately we were below the min watermark for ZONE_NORMAL and
> > > >>>we tried to allocate with GFP_ATOMIC (Nick, shouldn't we fall back to
> > > >>>ZONE_DMA in this case?).
> > > >>>
> > > >>>I think we can safely ignore the watermarks in swsusp, so probably
> > > >>>we can set PF_MEMALLOC for the current task temporarily and reset
> > > >>>it when we have allocated memory.  Pavel, what do you think?
> > > >>
> > > >>Seems little hacky but okay to me.
> > > >>
> > > >>Should not fixing "how much to free" computation to free a bit more be
> > > >>enough to handle this?
> > > > 
> > > > 
> > > > Yes, but in that case we'll leave some memory unused. ;-)
> > > > 
> > > 
> > > Probably doesn't fall back to ZONE_DMA because of lowmem reserve.
> > > Yes, PF_MEMALLOC sounds like it might do what you want. A little
> > > hackish perhaps, but better than putting swsusp special cases
> > > into page_alloc.c.
> > 
> > The appended patch contains the changes I'd like to make.  Pavel, is that
> > acceptable?
> 
> Why is PF_MEMALLOC only neccessary for pagedir allocations, and not
> for normal page allocations, too?

Right, we'll need it untli we finally free the image, so I think it should be
set/reset in disk.c:pm_suspend_disk().

However, there's a problem with this approach wrt the userland suspend, because
we'd have to keep PF_MEMALLOC set accross ioctls and I wouldn't like to do
this.

Well, the alternative solution would be to take the ZONE_DMA's lowmem reserve
into account in our free memory computations.

Greetings,
Rafael
