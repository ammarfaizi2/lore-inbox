Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVFIKw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFIKw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 06:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVFIKw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 06:52:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12763 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261356AbVFIKwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 06:52:19 -0400
Date: Thu, 9 Jun 2005 12:51:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adam Belay <abelay@novell.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, greg@kroah.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050609105152.GE3169@elf.ucw.cz>
References: <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org> <20050607025054.GC3289@neo.rr.com> <20050607105552.GA27496@pingi3.kke.suse.de> <20050607205800.GB8300@neo.rr.com> <1118190373.6850.85.camel@gaston> <1118196980.3245.68.camel@localhost.localdomain> <20050608122320.GC1898@elf.ucw.cz> <1118271605.6850.137.camel@gaston> <20050609000402.GA2694@elf.ucw.cz> <1118277507.29855.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118277507.29855.17.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >         case PM_EVENT_ON:
> > > >                 return PCI_D0;
> > > >         case PM_EVENT_FREEZE:
> > > >         case PM_EVENT_SUSPEND:
> > > >                 return PCI_D3hot;
> > > 
> > > What are these new PM_EVENT_* things ? I though we defined PMSG_* ?
> > 
> > PMSG_* are for struct; you can't case on struct.
> > 
> > > > You passed invalid argument; I see no reason why you should paper over
> > > > it and risk continuing. This happens during system suspend; it is
> > > > quite possible that user will not see your printk when machine powers
> > > > off just after that; and remember that it will not be in syslog after
> > > > resume.
> > > 
> > > Crap. I don't think a BUG() makes any useful help neither in this place,
> > > and when I locally turn PMSG_FREEZE to something sane I suddenly blow up
> > > in there (and I wonder in how many other places).
> > 
> > At least you can see & report that error... That would not be a case
> > for simple printk.
> 
> Well not exactly.  The video device may have already been disabled, so
> the user wouldn't see it anyway.  The reason I don't like BUG() here is
> that it's very unlikely passing an invalid PMSG will have serious
> consequences.  The problems are likely less significant than those
> caused by calling BUG().  Many suspend routines don't set power at all
> yet (e.g. cardbus) and it still works out fine.  Defaulting to the
> current state seems like a very safe behavior.  Then, after resume, we
> can see the messages.  I'd like to see PM just work, and we have to be
> careful during an API change.

Ok, refaulting to current state seems pretty good. But you are not
going to see the messages after the resume; not in swsusp if they
happened after swsusp atomic snapshot. In recent swsusp, I'm carefull
not to blank consoles when I can avoid it, exactly so messages like
this can be seen.

> > Turn pm_message_t into struct, so that it is typechecked properly (and
> > so that we can add flags field in future). This should not go in
> > before 2.6.12.
> 
> What do you have in mind for adding to the structure in the future?

*Maybe* flags telling drivers details of transition will be
needed. And I thought "partial suspend" people will want stuff like
char * "enter state with disk spinning at at most 300 rpm" to be added
there, too.

Now its mostly for typechecking.
								Pavel
