Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTICQXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbTICQWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:22:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2492 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263896AbTICQVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:21:19 -0400
Date: Wed, 3 Sep 2003 18:21:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030903162115.GF30629@atrey.karlin.mff.cuni.cz>
References: <20030902094701.GD145@elf.ucw.cz> <Pine.LNX.4.44.0309020825280.5614-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309020825280.5614-100000@cherise>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -extern long sys_sync(void);
> > -
> > -unsigned char software_suspend_enabled = 0;
> > +unsigned char software_suspend_enabled = 1;
> > 
> >  #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
> > 
> > ...by this you enable suspend even before system is booted. That's bad
> > idea. It could hurt in the past (when we had sysrq-D so swsusp), and
> > it may hurt again in future when battery goes low during boot.
> 
> Does it or does it not cause a problem? 

It does not cause a problem just now.

> > -               if (PageHighMem(page))
> > -                       panic("Swsusp not supported on highmem
> > -               boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again
> > -               ;-).");
> > 
> > Great, lets kill the messenger. Notice that when swsusp goes wrong it
> > tends to do bad data corruption, so some defensive programming is good
> > idea and this should be at least BUG_ON(). Gcc should optimize it
> > anyway.
> 
> First, look at the snippet that you pasted just before this, then explain 
> how we could have a HIGHMEM page if we unconditionally error when HIGHMEM 
> is enabled. 

Maybe it could not have happened, I'm not sure about exact
CONFIG_HIMEM semantics.
 
...
> > You killed code to mark swap as normal swap space and replaced it with
> > simple return -EFAULT. This is extremely dangerous; now swap is marked
> > as containing valid suspend image. On next reboot, user code resume,
> > but disk already has changed state. There will be silent data
> > corruption going on, and filesystem may be marked as clean at the
> > end. Great way to loose all your data. Really.
> 
> Snide comments not appreicated. 
> 
> The resetting of the swapfiles happened in swsusp_free(). Please read the 
> entire patch. That is, until the latest round of patches, in which the 
> resetting happened immediately after the header was read. Again, please 
> read the entire set of patches. 

Okay, my point was that the patch was not exactly obvious. You said
that you have not changed any core functionality, and you may even be
right, but it broke somewhere in the middle of pretty non-obvious
changes.

> > User has suspended, but he does not want to resume. Code was there to
> > restore swap space to "normal" state so it can be swapon-ed. This will
> > not kill data, only puzzled user.
> 
> Read your own code: 
...
> Now explain to me why killing that part of code was unnecessary. You've 
> already forced them to use mkswap(1) to restore the partition. Let's juts 
> make it official. 

...and remove any chance that someone fixes that #if 0 hunk of code.

> > -       if (!is_problem) {
> > -               kernel_fpu_end();       /* save_processor_state() does
> > -       kernel_fpu_begin, and we need to revert it in order to p\ass
> > -       in_atomic() checks */
> > -               BUG_ON(in_atomic());
> > -               suspend_save_image();
> > -               suspend_power_down();   /* FIXME: if
> > -       suspend_power_down is commented out, console is lost after few
> > -       suspends ?!\ */
> > -       }
> > -
> > +       if (!is_problem)
> > +               return suspend_save_image();
> > 
> > You've killed kernel_fpu_end(), that might be part of problem. Also
> > you killed BUG_ON(in_atomic()) which would actually catch that error.
> 
> Again, you've exhibiting gross unfamiliarity with your own code. 
> kernel_fpu_end() is called from do_fpu_end() which is called from 
> restore_processor_state(), which is called from do_magic() (now
> swsusp_arch_suspend()). 

No, at this point you are wrong. restore_processor_state() is only
run at resume. But you need to end atomic section during suspend,
too, so you don't sleep in it (causing so much warnings at console
that it takes forever to suspend).

> As for the BUG_ON(in_atomic()), that's laziness, and just poor style. A 
> nicer check would have been 
> 
> int software_suspend(void)
> {
> 	if (in_atomic() || in_interrupt())
> 		return -EPERM;
> 	...
> }
> 
> But, we can all take the moral way out and just make sure that our callers 
> are calling us in the right context. 

Callers are under your control, and I don't want to trace your code
*that* closely. [This is my choice. if () return -EPERM; is not that
much different, but I prefer this one.] 

> > > Have you confirmed that x86-64 is broken, or are you simply trying to 
> > > raise more accusations? If it is broken, please tell exactly what the 
> > > problem is and I will fix it. 
> > 
> > How do you expect void do_magic() -> int do_magic() to work without
> > changing actuall do_magic implementation?
> 
> Return is in %eax. We propogate the error from the C functions
> (swsusp_suspend() and swsusp_restore()) to the caller of
> swsusp_arch_suspend() (nee do_magic()).

Okay, this is nice trick and it might work. I've checked assembly on
both i386 and x86-64 and it looks okay.

> > > panic() is not a valid replacement for sane error handling. Every single 
> > > panic() in swsusp can be replaced by proper error handling. You should 
> > > have done that a long time ago. Calling panic() is just lazy.
> > 
> > And every untested error handler means severe data corruption. I might
> > be lazy, but you are dangerous to the user data.
> 
> My point was that I'm actually trying to fix the error handling so we can 
> gracefully back out of where we were. I.e. take the non-lazy
> approach. 

Trying to fix error handling is good and welcome, but please test it
first. It already ate 3 different filesystems here (like "so damaged
fsck can't fix it", had to mke2fs), and I do not want it to take some
user filesystem.

> Once again, I'm trying to make it better, against all odds. Against a 
> multitude of kernel developers scoffing at the notion of swsusp ever 
> working reliably. Against nearly everyone that has seen kernel code 
> expressing sorrow for having to read and understand the code. And against 
> you, who has no gratitude for someone trying to make marked improvements 
> to the structure and reliability of the code.

Again, if that patch came by email and not ftp, you'd probably get
some gratitude.

> > You've seen the reports before:
> > 
> > * ide problems (some user even posted decoded backtrace)
> > 
> > * UHCI leads to dead usb and machine 20x slower than it should be
> 
> I don't get this. Someone else reports an error -- admist you flaming me 
> -- and then you get up and flame me about that, too? I saw the

I've reported you ide problem using irc at Aug27, and reported you
UHCI problem to you, too. I've not seen email with a patch. You said
driver model has no problems, these are two examples I know of. [Where
do I find that ide fix? I'll need it for testing].

> In short, who the fuck do you think you are that you can constantly berate
> me, and with problems that aren't even yours? You've wasted a lot of
> my
....
> patches yourself. I will not touch that POS any more, for better or
> worse. 

Why does every email from you have to end with a flame?
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
