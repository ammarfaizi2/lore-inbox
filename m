Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316944AbSE1VRz>; Tue, 28 May 2002 17:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316938AbSE1VRy>; Tue, 28 May 2002 17:17:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9737 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316942AbSE1VRw>; Tue, 28 May 2002 17:17:52 -0400
Date: Tue, 28 May 2002 23:17:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: fchabaud@free.fr
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp in 2.4.19-pre8-ac5
Message-ID: <20020528211755.GC28189@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020528195546.GC189@elf.ucw.cz> <200205282109.g4SL9on02339@colombe.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 
> >  			INTERESTING(p);
> >  			if (p->flags & PF_FROZEN)
> >  				continue;
> > -
> > +			if (p->state == TASK_STOPPED) {	/* this task is a stopped but not frozen one */
> > +				p->flags |= PF_IOTHREAD;
> > +				_printk("+");
> > +				continue;
> > +			}
> >  			/* FIXME: smp problem here: we may not access other process' flags
> >  			   without locking */
> >  			p->flags |= PF_FREEZE;
> > 
> > Are you sure this is correct? What if someone wakes it just after you
> > given it PF_IOTHREAD?
> 
> Good point. I need to be more precise.

Yup.

> > 
> > What's the point of all those PRINTS -> __prints changes? I do not
> > like additional abstractions on the top of printk(). Are they really
> > neccessary?
> 
> Actually I tried to make the process prettier using a dedicated console.
> The PRINT are for debugging, _print for the dedicated console (can be
> deactivated using SUSPEND_CONSOLE) and __print are always written
> (errors messages). The PRINTS PRINTR macros were used to separate
> suspend and resume machine. It's not necessary but isn't that nicer when
> you suspend ?

Are not "Suspend : " and "Resume : " superfluous if you have dedicated
console, anyway?

Why don't you use generic printk() for messages that are printed, always?

> > @@ -1207,11 +1263,12 @@
> >  	pagedir_order = get_bitmask_order(nr_pgdir_pages);
> >  
> >  	error = -ENOMEM;
> > +	free_page((unsigned long)cur);
> >  	pagedir_nosave = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
> >  	if(!pagedir_nosave)
> >  		goto resume_read_error;
> >  
> > -	PRINTR( "%sReading pagedir, ", name_resume );
> > +	PRINTR( "Reading pagedir\n" );
> >  
> >  	/* We get pages in reverse order of saving! */
> >  	error=-EIO;
> > 
> > Why freeing it? This system is going to be overwritten, anyway.
> 
> I don't like the idea not to free the page as soon as we don't need it
> any more. Maybe we'll have an error later and try to recover a normal
> boot in a future version.

Okay, applied.

> What about the CONFIG_SMP restriction ? Is it still pertinent ?

Yes, I'm afraid. If someone wants to donate me SMP pentium, I might
try to debug that ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
