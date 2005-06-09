Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVFIBDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVFIBDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 21:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVFIBDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 21:03:54 -0400
Received: from peabody.ximian.com ([130.57.169.10]:28346 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262129AbVFIAmQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:42:16 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Adam Belay <abelay@novell.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, greg@kroah.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>
In-Reply-To: <20050609000402.GA2694@elf.ucw.cz>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
	 <20050607025054.GC3289@neo.rr.com>
	 <20050607105552.GA27496@pingi3.kke.suse.de>
	 <20050607205800.GB8300@neo.rr.com> <1118190373.6850.85.camel@gaston>
	 <1118196980.3245.68.camel@localhost.localdomain>
	 <20050608122320.GC1898@elf.ucw.cz> <1118271605.6850.137.camel@gaston>
	 <20050609000402.GA2694@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 20:38:27 -0400
Message-Id: <1118277507.29855.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 02:04 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > I think we should also use the pm_message_t defines.  We will need to
> > > > add PMSG_FREEZE eventually.  I decided to default to the current state
> > > > rather than panic.  Does this patch look ok?
> > > 
> > > No.
> > 
> > Hrm... I don't follow you anymore here ...
> > 
> > >         case PM_EVENT_ON:
> > >                 return PCI_D0;
> > >         case PM_EVENT_FREEZE:
> > >         case PM_EVENT_SUSPEND:
> > >                 return PCI_D3hot;
> > 
> > What are these new PM_EVENT_* things ? I though we defined PMSG_* ?
> 
> PMSG_* are for struct; you can't case on struct.
> 
> > > You passed invalid argument; I see no reason why you should paper over
> > > it and risk continuing. This happens during system suspend; it is
> > > quite possible that user will not see your printk when machine powers
> > > off just after that; and remember that it will not be in syslog after
> > > resume.
> > 
> > Crap. I don't think a BUG() makes any useful help neither in this place,
> > and when I locally turn PMSG_FREEZE to something sane I suddenly blow up
> > in there (and I wonder in how many other places).
> 
> At least you can see & report that error... That would not be a case
> for simple printk.

Well not exactly.  The video device may have already been disabled, so
the user wouldn't see it anyway.  The reason I don't like BUG() here is
that it's very unlikely passing an invalid PMSG will have serious
consequences.  The problems are likely less significant than those
caused by calling BUG().  Many suspend routines don't set power at all
yet (e.g. cardbus) and it still works out fine.  Defaulting to the
current state seems like a very safe behavior.  Then, after resume, we
can see the messages.  I'd like to see PM just work, and we have to be
careful during an API change.

> 
> This is the patch I'd like to go in. I hope it makes it
> clear... Please base your development on top of this one...

Yeah, I wasn't sure where those flags were coming from...

Thanks,
Adam


> 									Pavel
> 
> ---
> 
> Turn pm_message_t into struct, so that it is typechecked properly (and
> so that we can add flags field in future). This should not go in
> before 2.6.12.

What do you have in mind for adding to the structure in the future?


