Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTDDTvF (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTDDTvF (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:51:05 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:25273 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S261296AbTDDTuz (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 14:50:55 -0500
Date: Sat, 05 Apr 2003 08:00:01 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: New Software Suspend Patch for testing.
In-reply-to: <20030404133037.GA1333@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>
Message-id: <1049486400.3512.12.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1049454721.2418.33.camel@laptop-linux.cunninghams>
 <20030404133037.GA1333@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2003-04-05 at 01:30, Pavel Machek wrote:
> diff -ruN linux-2.5.66-original/arch/i386/kernel/cpu/mtrr/main.c linux-2.5.66-04/arch/i386/kernel/cpu/mtrr/main.c
> --- linux-2.5.66-original/arch/i386/kernel/cpu/mtrr/main.c	2003-01-15 17:00:38.000000000 +1300
> +++ linux-2.5.66-04/arch/i386/kernel/cpu/mtrr/main.c	2003-03-26 09:00:29.000000000 +1200
> @@ -35,6 +35,7 @@
> ...
> 
> Please convert this to driver model and submit to mtrr maintainer.

Okee doke.

> diff -ruN linux-2.5.66-original/drivers/char/vt.c linux-2.5.66-04/drivers/char/vt.c
> --- linux-2.5.66-original/drivers/char/vt.c	2003-03-26 08:56:47.000000000 +1200
> +++ linux-2.5.66-04/drivers/char/vt.c	2003-03-26 09:00:29.000000000 +1200

> This is ugly as night. Is not there any public function (sys_write?)
> you could use instead?

I didn't know about sys_write. I'll take a look at it.

> diff -ruN linux-2.5.66-original/drivers/ide/ide-disk.c linux-2.5.66-04/drivers/ide/ide-disk.c
> --- linux-2.5.66-original/drivers/ide/ide-disk.c	2003-03-26 08:56:49.000000000 +1200
> +++ linux-2.5.66-04/drivers/ide/ide-disk.c	2003-04-04 20:22:09.000000000 +1200
> Please submitt this to alan, as soon as possible.

Okay.

> 
> @@ -1804,7 +1801,8 @@
>  	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
>  		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
>  			drive->name, drive->head);
> -		if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
> +		if (((drive->id->cfs_enable_2 & 0x3000) && drive->wcache) ||
> +		    ((drive->id->command_set_1 & 0x20) && drive->id->cfs_enable_1 & 0x20))
>  			if (do_idedisk_flushcache(drive))
>  				printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
>  					drive->name);
> 
> Is this swsusp related?

Yes. Under 2.4, some people found that if the writeback cache isn't
flushed before we powerdown, the image isn't completely saved. This was
the fix (the first test is the original one, the second is based upon
hdparm's tests for writeback cache).

> diff -ruN linux-2.5.66-original/include/linux/pagemap.h linux-2.5.66-04/include/linux/pagemap.h
> --- linux-2.5.66-original/include/linux/pagemap.h	2003-03-26 08:57:06.000000000 +1200
> +++ linux-2.5.66-04/include/linux/pagemap.h	2003-03-26 09:00:29.000000000 +1200
> Do not use #ifdefs around includes.

Okay.

> diff -ruN linux-2.5.66-original/include/linux/suspend-debug.h linux-2.5.66-04/include/linux/suspend-debug.h
> --- linux-2.5.66-original/include/linux/suspend-debug.h	1970-01-01 12:00:00.000000000 +1200
> +++ linux-2.5.66-04/include/linux/suspend-debug.h	2003-04-04 19:37:44.000000000 +1200
> This is ugly. Are you trying to make it hard to read on purpose?

Nope. Just cut and paste from what was already in. I didn't like it much
either, but haven't changed it (this isn't _all_ my work).

> diff -ruN linux-2.5.66-original/include/linux/sysctl.h linux-2.5.66-04/include/linux/sysctl.h
> --- linux-2.5.66-original/include/linux/sysctl.h	2003-03-01 15:10:38.000000000 +1300
> +++ linux-2.5.66-04/include/linux/sysctl.h	2003-03-26 09:00:29.000000000 +1200
> Is sysctl being used besides debugging?

Yes. The main non-debugging thing that occurs to me right now is that
you can specify the image size you would like swsusp to aim for.

>  
>  unsigned char software_suspend_enabled = 0;
> +unsigned int suspend_task = 0;
> +/*
> + * Poll the swsusp state every second
> + */
> +#define SWSUSP_CHECK_TIMEOUT	(HZ)
> 
> What is this?

Used in the 2.4 version for kswsusp daemon. It provides another way to
start the process. I agree with you that we probably don't want to
implement this in 2.5 - I just forgot about removing it (I'm not
claiming that this code is perfectly cleaned up!)

> Please kill 2.4 stuff from 2.5 patch.

Yes, I will.

> -	if (mode == MARK_SWAP_RESUME) {
> -	  	if (!memcmp("S1",cur->swh.magic.magic,2))
> -		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
> -		else if (!memcmp("S2",cur->swh.magic.magic,2))
> -			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
> -		else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
> -		      	name_resume, cur->swh.magic.magic);
> -	} else {
> -	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
> -		  	memcpy(cur->swh.magic.magic,"S1SUSP....",10);
> -		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
> -			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
> -		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
> -		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
> -		/* link.next lies *no more* in last 4/8 bytes of magic */
> +	switch(mode) {
> +	case MARK_SWAP_RESUME:
> +		if (!memcmp("1R",cur.pointer->swh.magic.magic,2))
> +			memcpy(cur.pointer->swh.magic.magic,"SWAP-SPACE",10);
> +		else if (!memcmp("2R",cur.pointer->swh.magic.magic,2))
> +			memcpy(cur.pointer->swh.magic.magic,"SWAPSPACE2",10);
> +		else printk(name_resume "Unable to find suspended-data signature (%.10s - misspelled?\n", 
> +			    cur.pointer->swh.magic.magic);
> +		break;
> 
> I guess this is nicer than previous code, good.

This is Florent's, I believe. I actually think the header stuff is still
ugly, but haven't gotten around to cleaning it up yet.

Thanks for the suggestions on how to do a better job. I know I'm not
finished - I just wanted to get it tested to start with.

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

