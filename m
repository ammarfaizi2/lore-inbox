Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTICXUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTICXUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:20:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:51138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264449AbTICXUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:20:07 -0400
Date: Wed, 3 Sep 2003 16:17:33 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
In-Reply-To: <20030903162115.GF30629@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0309031554410.944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > -unsigned char software_suspend_enabled = 0;
> > > +unsigned char software_suspend_enabled = 1;
> > > 
> > >  #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
> > > 
> > > ...by this you enable suspend even before system is booted. That's bad
> > > idea. It could hurt in the past (when we had sysrq-D so swsusp), and
> > > it may hurt again in future when battery goes low during boot.
> > 
> > Does it or does it not cause a problem? 
> 
> It does not cause a problem just now.

But, we don't support suspend-on-low-battery. 

> Okay, my point was that the patch was not exactly obvious. You said
> that you have not changed any core functionality, and you may even be
> right, but it broke somewhere in the middle of pretty non-obvious
> changes.

Your point may now be that I untintentionally broke swsusp functionality 
through several large patches. However, that didn't seem the case as you 
were screaming at me. If you had taken the few minutes to send this email 
in the first place, we could be over this already. 

> > Now explain to me why killing that part of code was unnecessary. You've 
> > already forced them to use mkswap(1) to restore the partition. Let's juts 
> > make it official. 
> 
> ...and remove any chance that someone fixes that #if 0 hunk of code.

It's been #ifdef'd out since it was merged into Linus's tree on 15 July 
2002. I think if someone really wants to fix it up, they'll figure out how 
to add it back. 

> > kernel_fpu_end() is called from do_fpu_end() which is called from 
> > restore_processor_state(), which is called from do_magic() (now
> > swsusp_arch_suspend()). 
> 
> No, at this point you are wrong. restore_processor_state() is only
> run at resume. But you need to end atomic section during suspend,
> too, so you don't sleep in it (causing so much warnings at console
> that it takes forever to suspend).

Hey, even I'm wrong sometimes. I just posted a patch for this. 

> > As for the BUG_ON(in_atomic()), that's laziness, and just poor style. A 
> > nicer check would have been 
> > 
> > int software_suspend(void)
> > {
> > 	if (in_atomic() || in_interrupt())
> > 		return -EPERM;
> > 	...
> > }
> > 
> > But, we can all take the moral way out and just make sure that our callers 
> > are calling us in the right context. 
> 
> Callers are under your control, and I don't want to trace your code
> *that* closely. [This is my choice. if () return -EPERM; is not that
> much different, but I prefer this one.] 

You don't have to debug the callers, as you wouldn't anyway if you just 
BUG()d or panic()d. It is nice to provide a backtrace, but you don't have 
to kill the system to do so: 

	if (bad_context) {
		dump_stack();
		return -EPERM;
	}

> > Return is in %eax. We propogate the error from the C functions
> > (swsusp_suspend() and swsusp_restore()) to the caller of
> > swsusp_arch_suspend() (nee do_magic()).
> 
> Okay, this is nice trick and it might work. I've checked assembly on
> both i386 and x86-64 and it looks okay.

It's not a trick, it's the calling convention. 

> Trying to fix error handling is good and welcome, but please test it
> first. It already ate 3 different filesystems here (like "so damaged
> fsck can't fix it", had to mke2fs), and I do not want it to take some
> user filesystem.

What took 3 filesystems? The changes I made? Where are the bug reports? 

BTW, except for one time that I mounted / as ext2, I've been using ext3
with absolulely no problems. 

> I've reported you ide problem using irc at Aug27, and reported you
> UHCI problem to you, too. I've not seen email with a patch. You said
> driver model has no problems, these are two examples I know of. [Where
> do I find that ide fix? I'll need it for testing].

I gave you a work around for the bug, and told you that I knew about it. 
I appreciate the fact that you took the time to report it, but continuing 
to bite my head off about known bugs that are being worked on is 
completely unreasonable. 

The fix was posted to lkml a couple of days ago. It should also be in the
-test4-mm5 kernel.


	Pat

