Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWBTQco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWBTQco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWBTQcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:32:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63628 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161009AbWBTQcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:32:42 -0500
Date: Mon, 20 Feb 2006 13:49:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: suspend2 review [was Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)]
Message-ID: <20060220124937.GB16165@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219234212.GA1762@elf.ucw.cz> <200602201210.58362.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602201210.58362.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[Most fundamental stuff is at the end].

> > > > > The only con I see is the complexity of the code, but then again,
> > > > > Nigel
> > > >
> > > > ..but thats a big con.
> > >
> > > It's fud. Hopefully as I post more suspend2 patches to LKML, people will
> > > see that Suspend2 is simpler than what you are planning.
> >
> > Well, good luck with that. But since you claimed I'm spreading FUD, I
> > think I'll have to go through your patch.
> >
> > Ouch, it is 500KB, 19K lines. How can you claim it is not complex?!
> 
> Size != complexity. Not necessarily.

Well, it is complex in this particular case.

> > Unrelated to suspend2; either push it or drop it. [There are more such
> > changes, even for architectures you do not support suspend on... or do
> > you support suspend on h8300?]
> 
> This is because you got 2.2 instead of the latest-devel patch. It (and some 
> changes mentioned below) are got now (2.2.0.1).

I could not see 2.2.0.1 on the web page...

> > diff -ruN linux-2.6.15-1/arch/x86_64/kernel/e820.c
> > build-2.6.15.1/arch/x86_64/kernel/e820.c diff -ruN
> > linux-2.6.15-1/arch/x86_64/kernel/signal.c
> > build-2.6.15.1/arch/x86_64/kernel/signal.c
> >
> > diff -ruN linux-2.6.15-1/arch/x86_64/kernel/suspend.c
> > build-2.6.15.1/arch/x86_64/kernel/suspend.c
> >
> > With uswsusp, you are using existing code...
> 
> If I could use your existing code, I would. Unfortunately I'm using a more 
> compact method of storing the data (bitmaps), and I reckon I have zero chance 
> of getting you to switch.

And what chance do I have in getting _you_ to switch? Mainline code
was fixed _long_ ago not to need higher order allocations, and rafael
made it pretty compact lately, IIRC.

Please either switch to kernel code, or explain me that bitmaps have
serious-enough advantage that I want to switch.

> > diff -ruN linux-2.6.15-1/Documentation/kernel-parameters.txt
> > build-2.6.15.1/Documentation/kernel-parameters.txt ---
> > linux-2.6.15-1/Documentation/kernel-parameters.txt	2006-01-03
> > 15:08:24.000000000 +1000 +++
> > build-2.6.15.1/Documentation/kernel-parameters.txt	2006-01-23
> > 21:38:28.000000000 +1000 @@ -71,6 +71,7 @@
> >  	SERIAL	Serial support is enabled.
> >  	SMP	The kernel is an SMP kernel.
> >  	SPARC	Sparc architecture is enabled.
> > +	SUSPEND2 Suspend2 is enabled.
> >  	SWSUSP	Software suspend is enabled.
> >  	TS	Appropriate touchscreen support is enabled.
> >  	USB	USB support is enabled.
> > @@ -966,6 +967,8 @@
> >  	noresume	[SWSUSP] Disables resume and restores original swap
> >  			space.
> >
> > +	noresume2	[SUSPEND2] Disables resuming and restores original swap
> > signature. +
> >  	no-scroll	[VGA] Disables scrollback.
> >  			This is required for the Braillex ib80-piezo Braille
> >  			reader made by F.H. Papenmeier (Germany).
> >
> > ...and kernel parameters do not need to change...
> 
> This is only because I'm deliberately not stomping on your code at the moment.

I would actually like you to stomp on my code. Anything else can't
lead to swsusp->suspend2 evolution...
> > -91,7 +91,7 @@
> >  		       "Access to PCI configuration space unavailable\n");
> >  		return AE_NULL_ENTRY;
> >  	}
> > -	kacpid_wq = create_singlethread_workqueue("kacpid");
> > +	kacpid_wq = create_nofreeze_singlethread_workqueue("kacpid");
> >  	BUG_ON(!kacpid_wq);
> >
> >  	return AE_OK;
> >
> > Big search and replace all over the tree. Changes the default to
> > unsafe one. Do you ever listen to comments?
> 
> "Changes the default to unsafe one"? It makes the default to be freezing 
> kernel threads, which should be safer since they then won't unexpectedly do 
> (random action).

Well, you have just declared kacpid "NOFREEZE" here. I think Rafael
explained to you why these are bad idea. If not, convince me they are
good idea, but search&replace all over the tree is bad idea. (And
current patches seem to work just fine).

> > Same here. You should be able to use mainline's snapshot
> > functionality. That's common piece between swsusp and suspend2, and
> > having your own copy helps noone.
> 
> As mentioned above, I use a different method of storing the meta data 
> (bitmaps). It's more space efficient, but I expect you won't want it because 
> it will make your asm longer.

Metadata are very small part of data being saved. How much space does
it save in kernel image? It adds quite a lot of complexity....

> > Why do you need to modify printf-like functions?!
> 
> It's not modified, but a new one. IIRC, the closest one to what I was after 
> didn't return the info I needed.

Can you modify the caller? Noone else in kernel needs this printf-like
variant, you should probably modify your code not to need it, too.

> > Why can't you just use existing code for atomic copy?
> >
> > (~400 lines of duplicated code skipped)
> 
> As mentioned above, different data structures; the code isn't duplicated.

Switch to in-kernel data structures, then...

> > So you have your own disk operations... Nothing like that is needed
> > with uswsusp.
> 
> They're just the routines shared by the writers (which shoudl really be called 
> something different now that I've moved all the real work to this file :>). I 
> think I could further clean this up, removing the header specific routines. 
> And the point to it all is doing the async I/O and readahead, given just 
> lists of blocks on devices and (via these routines) the pages to write. If 
> uswsusp supported swapfiles and ordinary files, it would have something like 
> this.

Maybe it would have something like this *in userspace*. Certainly not
in kernel.

> > Snipped 600 lines of code that can happily live in userspace.
> 
> You can use cryptoapi from userspace?

No, but I can link to liblzf/libssl just fine. And I think it is even
possible to ask kernel to do crypto for you, not sure.

> > +/*
> > + * kernel/power/suspend2_core/encryption.c
> > + *
> > + * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend2.net>
> > + *
> > + * This file is released under the GPLv2.
> > + *
> > + * This file contains data encryption routines for suspend,
> > + * using cryptoapi transforms.
> > + *
> > + * ToDo:
> > + * - Apply min/max_keysize the cipher changes.
> > + * - Test.
> > + */
> >
> > Snipped 550 lines of code that can happily live in userspace.
> 
> (if cryptoapi can be used from there).

You don't need to use cryptoapi. Take a look at ssh, does it use
cryptoapi? No. Is it broken? No.


> > diff -ruN linux-2.6.15-1/kernel/power/extent.c
> > build-2.6.15.1/kernel/power/extent.c ---
> > linux-2.6.15-1/kernel/power/extent.c	1970-01-01 10:00:00.000000000 +1000
> > +++ build-2.6.15.1/kernel/power/extent.c	2006-01-23 21:38:28.000000000
> > +1000 @@ -0,0 +1,247 @@
> > +/* kernel/power/suspend2_core/extent.c
> > + *
> > + * (C) 2003-2005 Nigel Cunningham <nigel@suspend2.net>
> > + *
> > + * Distributed under GPLv2.
> > + *
> > + * These functions encapsulate the manipulation of storage metadata. For
> > + * pageflags, we use dynamically allocated bitmaps.
> > + */
> > +
> >
> > I do not know why you want to use extents; existing code seems to work
> > well enough. Do you get .01% speedup or what?
> 
> They're used for storing the lists of blocks on each dev in which we store the 
> image. It has nothing to do with a speedup, but rather efficient storage of 
> the metadata.

So... this is some code that is needed for swapfiles/normal files but
not for swap partitions?

> > +static int suspend2_nl_gen_rcv_msg(struct user_helper_data *uhd,
> > +		struct sk_buff *skb, struct nlmsghdr *nlh)
> > +{
> > +	int type;
> > +	int *data;
> > +	int err;
> > +
> > +	/* Let the more specific handler go first. It returns
> > +	 * 1 for valid messages that it doesn't know. */
> > +	if ((err = uhd->rcv_msg(skb, nlh)) != 1)
> > +		return err;
> >
> >
> > ...some of them pretty cryptic.
> 
> True. Will add to to do list :)

No need to clean it up, just switch to Rafael's solution ;-).

> > +static int launch_userpace_program(struct user_helper_da
> > +	sprintf(channel, "-c%d", uhd->netlink_id);
> > +	argv[arg] = channel;
> > +
> > +	retval = call_usermodehelper(argv[0], argv, envp, 0);
> >
> > It is really better if userspace calls you...
> 
> Well, this way, we don't care if userspace doesn't come to the party. We can 
> still suspend and resume without it.

Well, that should not be a big problem. We can get distros to ship
swsusp, and they use initrd-s, anyway.

> > +void suspend_power_down(void)
> > +{
> > +	if (test_action_state(SUSPEND_REBOOT)) {
> > +		suspend2_prepare_status(DONT_CLEAR_BAR, "Ready to reboot.");
> > +		kernel_restart(NULL);
> > +	}
> >
> > And we do not want UI code in kernel.
> 
> This is telling the UI what to do (as opposed to userspace telling the kernel 
> what to do ;-)).

Yes, and it is why userspace telling kernel what to do is
superior. You'd need to internationalize this etc.
> > +1000 +++ build-2.6.15.1/kernel/power/prepare_image.c	2006-01-23
> > 21:38:28.000000000 +1000 @@ -0,0 +1,753 @@
> > +/*
> > + * kernel/power/prepare_image.c
> > + *
> > + * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend.net>
> > + *
> > + * This file is released under the GPLv2.
> > + *
> > + * We need to eat memory until we can:
> > + * 1. Perform the save without changing anything (RAM_NEEDED < max_pfn)
> > + * 2. Fit it all in available space (active_writer->available_space() >=
> > + *    storage_needed())
> > + * 3. Reload the pagedir and pageset1 to places that don't collide with
> > their + *    final destinations, not knowing to what extent the resumed
> > kernel will + *    overlap with the one loaded at boot time. I think the
> > resumed kernel + *    should overlap completely, but I don't want to rely
> > on this as it is + *    an unproven assumption. We therefore assume there
> > will be no overlap at + *    all (worse case).
> > + * 4. Meet the user's requested limit (if any) on the size of the image.
> > + *    The limit is in MB, so pages/256 (assuming 4K pages).
> > + *
> > + */
> >
> > There's existing code in kernel to do this, no?
> 
> No. It doesn't support letting the user configure the limit they want (without 
> requiring a recompile) and it doesn't support storing a full image of memory. 
> It is cleaner and simpler, but I'm not sure it would work as reliably under 
> stress. I know I have cleanups to do here. There are surely still leftovers 
> from when we used that memory pool and I know I currently have a bug to chase 
> down.

Can you start the other way? Try kernel method, and if you can break
it, fix it; rather than replacing it with completely new code?

> > Well, we probably do not want more junk in /proc. And this would not
> > be neccessary if (surprise) userspace controlled suspend. 300 lines
> > unneeeded, and 70 lines in header.
> 
> :) But you would need more ioctls.

:-).

> > --- linux-2.6.15-1/kernel/power/storage.c	1970-01-01 10:00:00.000000000
> > +1000 +++ build-2.6.15.1/kernel/power/storage.c	2006-01-23
> > 21:38:28.000000000 +1000 @@ -0,0 +1,323 @@
> > +/*
> > + * kernel/power/storage.c
> > + *
> > + * Copyright (C) 2005 Nigel Cunningham <nigel@suspend2.net>
> > + *
> > + * This file is released under the GPLv2.
> > + *
> > + * Routines for talking to a userspace program that manages storage.
> > + *
> > + * The kernel side:
> > + * - starts the userspace program;
> > + * - sends messages telling it when to open and close the connection;
> > + * - tells it when to quit;
> > + *
> > + * The user space side:
> > + * - passes messages regarding status;
> >
> > Yep, if you do it all in userspace, this vanishes. 340 lines down.
> 
> And you gain? Let's try not to be too biased :).

I gain 340 less lines to review. For me to review, for akpm to review,
and for Linus to review. That's important.

> > + * Copyright 2004-2005 Nigel Cunningham <nigel@suspend2.net>
> > + *
> > + * Distributed under GPLv2.
> > + *
> > + * This file contains block io functions for suspend2. These are
> > + * used by the swapwriter and it is planned that they will also
> > + * be used by the NFSwriter.
> > + *
> > + */
> >
> > 1080 lines that are not neccessary in uswsusp case, because we can
> > simply use existing read/write routines.
> 
> But only if you stick to only supporting writing to a single swap parttiion.

I don't see this, why?

userland parts of swsusp code still have access to normal read/write
syscalls. I can write to normal (not swap) partition very easily, and
in fact first version of uswsusp done that.

> > Can happily live in userspace (using bmap), 1070 lines down.
> 
> How would you do the I/O once you'd bmapped? I thought you rejected bios.

Plain read/write syscalls on partition are safe.

> > +char suspend_wait_for_keypress(int timeout)
> > +{
> > +	int fd;
> > +	char key = '\0';
> > +	struct termios t, t_backup;
> > +
> > +	if (ui_helper_data.pid != -1) {
> > +		wait_for_key_via_userui();
> > +		key = ' ';
> > +		goto out;
> > +	}
> > +
> > +	/* We should be guaranteed /dev/console exists after populate_rootfs() in
> > +	 * init/main.c
> > +	 */
> > +	if ((fd = sys_open("/dev/console", O_RDONLY, 0)) < 0) {
> > +		printk("Couldn't open /dev/console.\n");
> > +		goto out;
> > +	}
> >
> > ...and you still do user interface in kernel, despite having userland
> > helper.
> 
> printks, yes. You don't do any printks?

I don't need to open files in kernel, that's quite a big "no-no".

> > +		say("BIG FAT WARNING!!\n\n");
> > +		say("You have tried to resume from this image before.\n");
> > +		say("If it failed once, it may well fail again.\n");
> > +		say("Would you like to remove the image and boot normally?\n");
> > +		say("This will be equivalent to entering noresume2 on the\n");
> > +		say("kernel command line.\n\n");
> > +		say("Press SPACE to remove the image or C to continue resuming.\n\n");
> > +		say("Default action if you don't select one in %d seconds is: %s.\n",
> > +			message_timeout,
> > +			!!default_answer ?
> > +			"continue resuming" : "remove the image");
> > +	}
> >
> > Wonderful. Did not we agree that this has no place in kernel?
> 
> No, we didn't agree. You said it, and I rejected your assertion. I believe I'm 
> allowed to listen and disagree.

And I'm allowed to NAK your patches, if you want to take it to this
level. Piece above is enough to NAK whole series. How do you
internationalize it, for example?

> > So... I'm spreading FUD and suspend2 is not intrusive? I'd not say so.
> 
> Look at the diffstat for 2.2.0.1 and re-evaluate this assertion. Look again in 
> the next release (when I've applied more cleanups).

You can clean it up any way you want to, but half of your code should
not be in kernel in the first place.

> > And you claimed that uswsusp can not solve anything? With above
> > analysis, at least 8040 lines can be moved into userspace. That's more
> > than half of your patch...
> 
> Remember though that you're making this assertion without actually having done 
> any of that work. You don't know how much you'll have to add to userspace or 
> kernel space to make this work. When you've actually done it, and we can 
> compare apples with apples, then I'll listen to comparisons of lines added 
> and removed.

I'm pretty sure I don't have anything in kernel to add...

> > Do we do anything really fundamental in userspace? No. Do you do
> > anything fundamental in those 8040 lines? No. => userspace, please.
> 
> Writing the image isn't fundamental?

Actually, no, writing the image isn't fundamental. You can send it
over network, or do something like that...

> > Now, suspend2 is quite a lot of old code, that does not properly use
> > existing kernel infrastructure. Rather than trying to prove suspend2
> > is not intrusive (*)... can you just start using Rafael's existing
> > code, and put that code into userspace?
> 
> I'm not going to waste my time. I have a working implementation today, and if 
> I were to waste my time porting it to userspace, you'd reject it anyway. If 
> and when you decide that you want to work on a userspace port, feel free.

You are missing few things:

*) you are wasting your time, anyway, by cleaning code that does not
belong into kernel in the first place.

*) I'd probably not reject your patches to userspace parts. My biggest
complain about your code is that it lives in kernel space while it
should live in userland.

*) I can't really reject userspace patches. I'm not distribution
maintainer, and only a distribution can do that.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
