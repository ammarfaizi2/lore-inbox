Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbTHVVxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbTHVVxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:53:34 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:36228 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263716AbTHVVx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:53:28 -0400
Date: Fri, 22 Aug 2003 23:53:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030822215315.GD2306@elf.ucw.cz>
References: <20030822210800.GA4403@elf.ucw.cz> <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On top of that, the way it was implemented was broken. You could not 
> actually enter a low-power state (S4) if you used swsusp. You had to 
> shutdown the system

This is stable series, and /proc/acpi/sleep was fine for at least
entering S3 and swsusp. Anyway, if you killed sleep, you should kill
alarm as well. Its only usefull for sleeping, and IIRC it never worked
properly, anyway.

> > Great. This way we are going to have stable PM code... in 2056.
> 
> Yes, but we should also have it a lot sooner than that. 
> 
> Note that we have never had stable PM code; we've had crap. It is a lot 
> more stable now, based solely on the fact that someone has actually taken 
> the time to look at it, clean it up, and start fixing it. 
> 
> What is your idea of stability? The point when all the people that report
> bugs to you, and you reply 'Fix it yourself' actually buckle down and fix 
> all the problems? Or, when someone steps up and tries to make it work 
> reliably for a majority of users? 

I already tried to make it reliable for users, and you moving chunks
of code back and forth while changing semantics of device_suspend() is
not really helpfull.

If you want to help, take a look at drivers/pci/power.c. That file
should not need to exist, but if I kill it bad stuff happens after
resume. Killing pm_register() and friends would be nice.

> My intent is to do that, and to do it soon. And, with a minimal amount of 
> pain during the transitions. 

Try to post patches to the lists, then, and avoid moving code just
because you can.

> > +enum {
> > +	PM_SUSPEND_ON,
> > +	PM_SUSPEND_STANDBY,
> > +	PM_SUSPEND_MEM,
> > +	PM_SUSPEND_DISK,
> > +	PM_SUSPEND_MAX,
> > +};
> > +
> > +extern int (*pm_power_down)(u32 state);
> > 
> > If you defined enum, you should also use it. 
> 
> As a typedef parameter to the function? 

what about enum action { }; extern int (*pm_power_down)(enum action
state)?

> >  static int __init resume_setup(char *str)
> >  {
> > -	strncpy( resume_file, str, 255 );
> > +	if (strlen(str))
> > +		strncpy(resume_file, str, 255);
> >  	return 1;
> >  }
> > 
> > Why are you obfuscating the code?
> 
> Eh? First, why would you want to copy a NULL string? 
> 
> Secondly, you can actually remove the second command line parameter 
> ("noresume") by simply specifying a NULL partition to this parameter. It 
> requires about a 5-line change, and makes things simpler. 

You'd better not. You are expected to have one "resume=/foo/bar"
specified as append in lilo. You want to able to say noresume and do
one boot without resuming. Turning resume with
"resume=/dev/nonexistent" would be playing roulete with command line
argument order.

> > +Some devices are broken and will inevitably have problems powering
> > +down or disabling themselves with interrupts enabled. For these
> > +special cases, they may return -EAGAIN. This will put the device on a
> > +list to be taken care of later. When interrupts are disabled, before
> > +we enter the low-power state, their drivers are called again to put
> > +their device to sleep. 
> > 
> > Returning EAGAIN to be called with interrupts disabled is extremely
> > ugly hack. We were passing suspend level before. Why did you have to
> > break it?
> 
> Because you can power down most devices with interrupts enabled, and you
> really want to. Especially for devices that support runtime power
> management, which by definition, requires interrupts to always be enabled. 
> 
> -EAGAIN allows the drivers/devices that really need special care to 
> specify it. Otherwise, we'll end up calling ->suspend() twice for power 
> down for each device (those that can do w/ interrupts enabled and those 
> that need interrupts disabled), which also requires every single driver to 
> check whether or not interrupts are enabled, instead of just those that 
> need it. 

No, you should have simply let it alone and pass "level" parameter
telling driver if interrupts were disabled or not. No need to
constantly change API while trying to stabilise the code.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
