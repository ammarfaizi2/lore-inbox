Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTBWLT0>; Sun, 23 Feb 2003 06:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTBWLT0>; Sun, 23 Feb 2003 06:19:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28687 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267033AbTBWLTZ>; Sun, 23 Feb 2003 06:19:25 -0500
Date: Sun, 23 Feb 2003 12:29:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, alan@redhat.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Toshiba keyboard workaroun
Message-ID: <20030223112935.GB5473@atrey.karlin.mff.cuni.cz>
References: <20030218211940.GA1048@elf.ucw.cz> <20030223091936.B31359@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223091936.B31359@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You said that you'll submit toshiba keyboard fix for 2.4 to
> > marcelo... Here goes 2.5 version, will you submit it to Linus? ;-).
> 
> This belongs into drivers/input/keyboard/atkbd.c, not here!
> 
> Subsequent keypresses are already ignored - autorepeat is done in
> software, however if you get a very quick press-release-press of the

No, it did not do releases.

Guess I should really try 2.5. without that patch, because vojtech's
patches might have had fixed that as a side effect. Alan, please don't
push this patch to Linus until this is fixed. [2.4 version is still
neccessary, through].
								Pavel

> same key that means the keyboard controller didn't do proper debouncing
> and you probably can ignore the later release and press. But you must
> ignore the release as well. Further - comparing to 10 jiffies isn't a
> good idea - jiffies speed is different on different archs.



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

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
