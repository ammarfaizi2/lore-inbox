Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbTCGUSL>; Fri, 7 Mar 2003 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261764AbTCGUSK>; Fri, 7 Mar 2003 15:18:10 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261762AbTCGUSG>;
	Fri, 7 Mar 2003 15:18:06 -0500
Date: Fri, 7 Mar 2003 21:27:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
Message-ID: <20030307202759.GA2447@elf.ucw.cz>
References: <20030305180222.GA2781@zaurus.ucw.cz> <Pine.LNX.4.33.0303070950030.991-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303070950030.991-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > All in all, I think the idea of saving state to swap is dangerous for 
> > > various reasons. However, I like some of the other concepts of the code, 
> > 
> > Can you elaborate? I believe writing
> > to swap is good for user; and it works.
> 
> It does work, but there are uncertainties inherently present when using 
> such a solution. Some of them were just the behavior of the current code, 
> which I fixed, like:
> 
> - Only ever using the first swap partition, regardless of space
> left. 

But your solution would also only support *one* suspend partition,
right? (And patches for using more than one swap partition are
available for 2.4.X; I don't like them due to added complexity).

> - Not resetting swap signature if a resume failed. 

Can be fixed in userland. Add option -s that for mkswap that fixes
signature only if it was overwritten by suspend, and add mkswap -s
/swap/partiton in your init scripts.

> - Almost complete lack of a recovery path if anything failed (i.e. trying 
>   to back out of what has happened, instead of calling BUG() or
> panic()).

Those BUGs / panics should be impossible to trigger. [And this has
nothing to do with fact we suspend-to-swap].

> - Function names like do_magic() and friends. 

It is pretty magical operation, so you are at least warned. [And this has
nothing to do with fact we suspend-to-swap].

> This types of things don't instill any confidence in a user or other
> developer looking at the code. It gives the impression that the code is
> the result of blind guess work in the dark. After looking at the code, it
> was a shock to me that it worked at all.
> 
> I understand that getting it to work involves dealing with the 
> uncertainties. However, there is no reason to pass them on to other users. 
> There were no comments as to what the do_magic*() functions did, let alone 
> why they were 'magic', and there were 5 of them. 

do_magic() replaces one kernel with another. That seems magical enough
to me. [It is in 5 functions so that the real hard part can be in
assembly].

> There are uncertainties still present in the code, like 
> 
> - #warning about waiting for data to reach the disk.
> 
> - "Waiting for DMAs to settle down" delay on resume. 
> 
> I respect the paranoia. Howver, it's things like these that should be
> dealt with before anything else.

Feel free to fix them. [I believe both warning and waiting for DMA can
be safely killed, but...]

> The general problems that I see with the solution are:
> 
> - It simply won't work if you're low on swap or memory. 

Your solution will not work with too small suspend partition
too. Being low on memory... You'd have to have > 50% of your memory
allocated by kernel for swsusp to fail. I do not think it can be
sanely done other way. [Having separate disk drivers just for suspend
is *not* sane.]

> - It won't work if you're swap is not persistant across reboots. 

Your solution will not work if your suspend partition is not
persistant across reboots. AND WHAT?

> - It won't work if you don't use swap. 

Your solution will not work if your suspend partition is not there.

> - It's dependent on the same exact kernel being loaded.
>
> It should only be dependent on the binary format of the written metadata.

...which leads to simpler design and few megabytes less transfered to
/ from disk. I do not think there's easy way to do it with different
kernels. State of devices before switching to new kernel is important...

> It also shouldn't be waiting until all the devices are probed and 
> initialized, but that problem is out of your hands.
> 
> Another problem I see in the future is initramfs, and when things start 
> executing in there. It's currently unpacked by populate_rootfs() in 
> init/main.c, long before software_resume() is called. Though it doesn't 
> cause any explicit problems ATM, it does introduce more
> uncertainties. 

Oops, I have not seen that one. Yep that may turn nasty in
future. software_resume() should really be done before userland starts.

> I don't want to cast the entire project in a negative light, though. It
> does work, and I'm fairly impressed by it. 

Thanx.

> I've created a registration mechanism for PM 'drivers', and a way for
> users to select which driver they want to use for the different PM states.  
> In the patch, swsusp is just another driver. It can coexist with ACPI or
> APM (theoretically) just fine, without requiring a kernel rebuild or
> reboot.

I believe it can coexist with ACPI and APM already just okay. You can
echo 4b to /proc/acpi/sleep to trigger S4bios.

> This also involves a generic framework for doing system-wide power 
> management. In this, I've begun extracting bits from swsusp that are 
> useful for any PM sequence. My goal is to reduce swsusp to just a small 
> layer that writes/reads the saved pages from swap. The rest of the 
> sequence, including memory and device handling, happens in generic
> code. 

So you don't really want to create separate "suspend partition"? Good.

More sharing between S3 and S4 is certainly good (but I do not think
much more can be shared).

> > > http://ldm.bkbits.net:8080/linux-2.5-power
> > >
> > 
> > Can you post cumulative diff of work-in-progress?
> > I am not permitted to use bk. Also please
> > make sure that you post the diff before
> > you merge it (and please Cc me).
> 
> Sure. From the above link, you can view the individual patches. I would 
> hope that you could use wget to snarf them, though I don't know if that's 
> legally ok (nor do I want to know). 
> 
> The cumulative patch is here:
> 
> > >http://kernel.org/pub/linux/kernel/people/mochel/power/pm-2.5.64.diff.gz

THenx.

> If I get a chance in the next few days, I'll post incremental diffs. 
> Without them, the gradual changes are not so obvious. 
> 
> I understand you may not a rewrite of swsusp (regardless of how much
> cleaner the code is), and I respect that. I'm completely willing to leave
> kernel/suspend.c intact, and let you work in the integration into the
> generic PM model, and/or simply rename the new code something like
> swsusp2, swsusp-XP, or swsusp-pat. ;)

So you want to develop swsusp-pat that will suspend to partition,
allow another kernel version, and you think you can suspend when 90%
of your memory is kmalloc()-ed? Do you agree that separate disk
drivers for suspend is bad idea?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
