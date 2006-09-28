Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWI1Bki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWI1Bki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031168AbWI1Bki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:40:38 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:46695 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965177AbWI1Bkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:40:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=1fpEbM5rePlYESJdpX/MIDl+/Hgpg4DSX4er1SK1uWM2CvINLq/aRj09rqxVpSuFPQ85SDAI5at3Iju50u9Q2W6/nrZfrg1aw9TTeb77CiqD9244c+8+vJAdrZdgOV2QAfAzRTgD3V5eVNWPGFdpJv2EdE8F+feZcCwHaFDcRXc=  ;
From: David Brownell <david-b@pacbell.net>
To: tglx@linutronix.de
Subject: Re: [Bulk] Re: [Bulk] Re: [patch 2.6.18] genirq: remove oops with fasteoi irq_chip descriptors
Date: Wed, 27 Sep 2006 18:40:32 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com
References: <200609220641.58938.david-b@pacbell.net> <200609271739.10215.david-b@pacbell.net> <1159406299.9326.644.camel@localhost.localdomain>
In-Reply-To: <1159406299.9326.644.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271840.32874.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wednesday 27 September 2006 6:18 pm, Thomas Gleixner wrote:
> Dave,
> 
> On Wed, 2006-09-27 at 17:39 -0700, David Brownell wrote:
> >  - It wouldn't use chip->mask_ack() when that exists and those
> >    other two routines don't, even though mask_ack_irq() is a
> >    conveniently defined inline.
> 
> So why not replace it by mask_ack_irq() ?

It'd still oops on chips with just enable(), disable(), and eoi().

Which, on my brief scan of the codebase, appears to be one of the
accepted ways to craft a fasteoi irq_chip.


> >  - Umm, how could it ever be correct to leave the IRQ active
> >    without a dispatcher?  ISTR the rationale for that delayed
> >    disable was not purely to be a PITA for all driver writers,
> >    but was to address some issue with edge triggering.  In that
> >    path, triggering was no longer to be allowed ...
> 
> Your patch would result in default_disable() when no shutdown function
> is provided. default_disable() does the delayed disable thing, while you
> remove the handler. The next event on that line will cause a spurious
> IRQ.

That may be an argument that the default shutdown() should not be the
same as the default disable().  Unless shutdown() is going away??

I still dislike that delayed disable() mechanism.  Every time I've
seen ("tripped over") it in action it's been the cause of bugs.

 
> >  - Plus ack()ing the IRQ there just seemed pretty dubious.  It's
> >    not like there would be anything preventing that signal line
> >    from being lowered (or raised, etc) immediately after the ack(),
> >    which in some hardware would latch the IRQ until later unmask().
> >
> > Leaving the question:  what's the point of it??  The overall
> > system has to behave sanely with or without the ack(); just
> > clearing a latch doesn't mean it couldn't get set later.
> 
> Fair enough.
> 
> > > > So what's the correct fix then ... use enable() and disable()?
> > > > Oopsing isn't OK... 
> > > 
> > > True, but we can not unconditionally change the semantics. 
> > 
> > Some current semantics are "it oopses".  That's a good definition
> > of semantics that _must_ be changed.  We're not Microsoft.  ;)
> 
> Agreed, it just depends on how they get fixed.

I thought maybe submitting a reasonably sane patch would be the
best way to start that discussion.  :)

The only issue appears to be how that rarely-used "get rid of
the handler" code path should work.

 
> > > Does it break existing or new code ?
> > 
> > Could any code relying on those previous semantics have been
> > correct in the first place, though?  Seemed to me it couldn't
> > have been.
> > 
> > Plus, unregistering IRQ dispatchers is a strange notion.  I've
> > never seen it done in practice ... normally, they get set up once
> > during chip/board setup then never changed.  Bugs in code paths
> > like that have been known to last for decades unfixed.
> 
> Agreed. Nothing is using this currently.

Aha!  So if it's "nothing" then that rarely/not-used path can change
without negative impact...


> > > Sorry, I did not think about the defaults in the first place. The
> > > conditionals in manage,c are probably superflous leftovers from one of
> > > the evolvement.
> > 
> > And that's how I was taking that particular mask() then ack() too,
> > especially given it never used mask_ack() when it should have, and
> > since that logic oopsed in various cases with fasteoi handlers.
> 
> The remaining question is whether mask_ack_irq() or shutdown() is the
> correct approach. Your patch would make it mandatory to implement
> shutdown at least for such removable stuff.

Well, an implementation of shutdown() _is_ always provided.  At least
now; I don't have time to track your MM patches.


> I'm not sure about that right now as I'm too tired.

I expect that after you sleep on this, something will come to mind.  ;)

- Dave


