Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261680AbTCGR1i>; Fri, 7 Mar 2003 12:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261691AbTCGR1i>; Fri, 7 Mar 2003 12:27:38 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261680AbTCGR1g>;
	Fri, 7 Mar 2003 12:27:36 -0500
Date: Fri, 7 Mar 2003 11:14:00 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-Reply-To: <20030305180222.GA2781@zaurus.ucw.cz>
Message-ID: <Pine.LNX.4.33.0303070950030.991-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > All in all, I think the idea of saving state to swap is dangerous for 
> > various reasons. However, I like some of the other concepts of the code, 
> 
> Can you elaborate? I believe writing
> to swap is good for user; and it works.

It does work, but there are uncertainties inherently present when using 
such a solution. Some of them were just the behavior of the current code, 
which I fixed, like:

- Only ever using the first swap partition, regardless of space left. 

- Not resetting swap signature if a resume failed. 

- Almost complete lack of a recovery path if anything failed (i.e. trying 
  to back out of what has happened, instead of calling BUG() or panic()).

- Function names like do_magic() and friends. 

This types of things don't instill any confidence in a user or other
developer looking at the code. It gives the impression that the code is
the result of blind guess work in the dark. After looking at the code, it
was a shock to me that it worked at all.

I understand that getting it to work involves dealing with the 
uncertainties. However, there is no reason to pass them on to other users. 
There were no comments as to what the do_magic*() functions did, let alone 
why they were 'magic', and there were 5 of them. 


There are uncertainties still present in the code, like 

- #warning about waiting for data to reach the disk.

- "Waiting for DMAs to settle down" delay on resume. 

I respect the paranoia. Howver, it's things like these that should be
dealt with before anything else.


The general problems that I see with the solution are:

- It simply won't work if you're low on swap or memory. 

- It won't work if you're swap is not persistant across reboots. 

- It won't work if you don't use swap. 

- It's dependent on the same exact kernel being loaded.

It should only be dependent on the binary format of the written metadata.

It also shouldn't be waiting until all the devices are probed and 
initialized, but that problem is out of your hands.

Another problem I see in the future is initramfs, and when things start 
executing in there. It's currently unpacked by populate_rootfs() in 
init/main.c, long before software_resume() is called. Though it doesn't 
cause any explicit problems ATM, it does introduce more uncertainties. 


I don't want to cast the entire project in a negative light, though. It
does work, and I'm fairly impressed by it. I do not want to take the
feature away. I see it coexisting and sharing code nicely with any 
other solutions. 

I've created a registration mechanism for PM 'drivers', and a way for
users to select which driver they want to use for the different PM states.  
In the patch, swsusp is just another driver. It can coexist with ACPI or
APM (theoretically) just fine, without requiring a kernel rebuild or
reboot.

This also involves a generic framework for doing system-wide power 
management. In this, I've begun extracting bits from swsusp that are 
useful for any PM sequence. My goal is to reduce swsusp to just a small 
layer that writes/reads the saved pages from swap. The rest of the 
sequence, including memory and device handling, happens in generic code. 

> > and will use them in developing a more palatable mechanism of doing STDs 
> 
> What is STD?

Suspend-to-disk.

> > http://ldm.bkbits.net:8080/linux-2.5-power
> >
> 
> Can you post cumulative diff of work-in-progress?
> I am not permitted to use bk. Also please
> make sure that you post the diff before
> you merge it (and please Cc me).

Sure. From the above link, you can view the individual patches. I would 
hope that you could use wget to snarf them, though I don't know if that's 
legally ok (nor do I want to know). 

The cumulative patch is here:

http://kernel.org/pub/linux/kernel/people/mochel/power/pm-2.5.64.diff.gz

If I get a chance in the next few days, I'll post incremental diffs. 
Without them, the gradual changes are not so obvious. 

I understand you may not a rewrite of swsusp (regardless of how much
cleaner the code is), and I respect that. I'm completely willing to leave
kernel/suspend.c intact, and let you work in the integration into the
generic PM model, and/or simply rename the new code something like
swsusp2, swsusp-XP, or swsusp-pat. ;)


	-pat

