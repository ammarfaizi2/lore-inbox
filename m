Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268262AbUHFTrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268262AbUHFTrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUHFTqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:46:35 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:43648 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268262AbUHFToL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:44:11 -0400
Date: Fri, 6 Aug 2004 21:43:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [0/25] Merge pmdisk and swsusp
Message-ID: <20040806194352.GK3048@elf.ucw.cz>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net> <20040720164640.GH10921@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.50.0408012220160.8159-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408012220160.8159-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * if machine halt fails, it is very dangerous to continue.
> >
> > diff -ur linux.middle/kernel/power/disk.c linux/kernel/power/disk.c
> > --- linux.middle/kernel/power/disk.c	2004-07-19 08:58:08.000000000 -0700
> > +++ linux/kernel/power/disk.c	2004-07-19 15:00:16.000000000 -0700
> > @@ -63,6 +63,9 @@
> >  		break;
> >  	}
> >  	machine_halt();
> > +	/* Valid image is on the disk, if we continue we risk serious data corruption
> > +	   after resume. */
> > +	while(1);
> >  	device_power_up();
> >  	local_irq_restore(flags);
> >  	return 0;
> 
> This is nasty. We have to fail gracefully, ideally without expecting user
> input.
> 
> Adding 'while(1)' will cause the CPU to enter a busy loop, artificially
> increasing the power consumption of the system, which would be counter-
> productive in a system that was configured to suspend when the battery was
> low.

> We need to at least print a message specifying what happened and
> instructing them to reboot. It's dorky, but over time, all every system
> should eventually be fixed to either enter a low-power mode or shut down
> properly.

Ok, it was a "too hot hotfix". Your solution is better (but see below).

> Perhaps we could also fill in machine_halt(), which the patch below also
> does.

Good.

> > * copy_page() is dangerous. This is actually my fault.
> 
> Why is copy_page() dangerous? Shouldn't it be fixed if that is the
> case?

copy_page sometimes changes struct task_struct, does copy, changes it
back. That makes it bad choice for copying task_structs,
unfortunately. Do you want me to retransmit the patch?

> ===== kernel/power/disk.c 1.16 vs edited =====
> --- 1.16/kernel/power/disk.c	2004-08-01 20:36:39 -07:00
> +++ edited/kernel/power/disk.c	2004-08-01 22:38:19 -07:00
> @@ -59,6 +59,7 @@
>  		machine_restart(NULL);
>  		break;
>  	}
> +	printk(KERN_EMERG "Suspend-to-disk succeeded, but power-down failed. Please reboot.\n");
>  	machine_halt();
>  	device_power_up();
>  	local_irq_restore(flags);

If i386 got it wrong, it is possible that other architectures get it
wrong, too. Fixing i386 is good, but we should not risk continuing
machine with valid image on disk.

I guess "device_power_up / local_irq_restore" should be replaced with
BUG() or while(1)?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
