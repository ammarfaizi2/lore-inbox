Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268057AbTBRWLg>; Tue, 18 Feb 2003 17:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268066AbTBRWLg>; Tue, 18 Feb 2003 17:11:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31249 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268057AbTBRWLb>; Tue, 18 Feb 2003 17:11:31 -0500
Date: Tue, 18 Feb 2003 23:21:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Toshiba keyboard workaroun
Message-ID: <20030218222132.GF21974@atrey.karlin.mff.cuni.cz>
References: <mailman.1045603384.24857.linux-kernel2news@redhat.com> <200302182213.h1IMDKX31357@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302182213.h1IMDKX31357@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > --- clean/drivers/char/keyboard.c	2003-02-15 18:51:18.000000000 +0100
> > +++ linux/drivers/char/keyboard.c	2003-02-15 19:19:45.000000000 +0100
> > @@ -1020,6 +1041,23 @@
> >  	struct tty_struct *tty;
> >  	int shift_final;
> >  
> > +        /*
> > +         * Fix for Toshiba Satellites. Toshiba's like to repeat 
> > +	 * "key down" event for A in combinations like shift-A.
> > +	 * Thanx to Andrei Pitis <pink@roedu.net>.
> > +         */
> > +        static int prev_scancode = 0;
> > +        static int stop_jiffies = 0;
> > +
> > +        /* new scancode, trigger delay */
> > +        if (keycode != prev_scancode) 	       stop_jiffies = jiffies;
> > +        else if (jiffies - stop_jiffies >= 10) stop_jiffies = 0;
> > +        else {
> > +	    printk( "Keyboard glitch detected, ignoring keypress\n" );
> > +            return;
> > +	}
> > +        prev_scancode = keycode;
> > +
> >  	if (down != 2)
> >  		add_keyboard_randomness((keycode << 1) ^ down);
> 
> This is incredibly broken, on many layers.
> 
> First, formatting does not respect the original code. Pavel, please,
> I do not care what crap you write in softsuspend, but this is a
> generic piece of code. Be kind to those who come next.

Its not originally mine, I should have reformated it. Sorry.

> Second, no HZ or other way to specify a wall clock interval.
> What if I run with HZ=4000? How do you protect against a
> jiffies wraparound?
> 
> Third, I do not see how this is supposed to work at all.
> What if I hit two letters like in a word "Fool"? The up event
> is filtered already by this time, so, won't this code eat
> the second 'o'?

The up event is not filtered, AFAICS. Parameter down carries that.

							Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
