Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbUL2B1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUL2B1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 20:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbUL2B1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 20:27:31 -0500
Received: from mail.dif.dk ([193.138.115.101]:7105 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261271AbUL2B1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 20:27:23 -0500
Date: Wed, 29 Dec 2004 02:38:25 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: William Park <opengeometry@yahoo.ca>
Cc: linux-kernel@vger.kernel.org, Andreas Unterkircher <unki@netshadow.at>
Subject: Re: waiting 10s before mounting root filesystem?
In-Reply-To: <20041229005922.GA2520@node1.opengeometry.net>
Message-ID: <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost>
References: <20041227195645.GA2282@node1.opengeometry.net>
 <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at>
 <20041229005922.GA2520@node1.opengeometry.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004, William Park wrote:

> On Mon, Dec 27, 2004 at 10:23:34PM +0100, Andreas Unterkircher wrote:
> > >>How do I make the kernel to wait about 10s before attempting to
> > >>mount root filesystem?  Is there obscure kernel parameter?
> > >>
> > >>I can load the kernel from /dev/fd0, then mount /dev/hda2 as root
> > >>filesystem.  But, I can't seem to mount /dev/sda1 (USB key drive) as
> > >>root filesystem.  All relevant USB and SCSI modules are compiled
> > >>into the kernel.  I think kernel is too fast in panicking.  I would
> > >>like the kernel to wait about 10s until 'usb-storage' and 'sd_mod'
> > >>work out all the details.
> > >
> > >This is really suited to the task of an initrd, then you can spin
> > >until the usb storage device comes up in a bash script or something
> > >similar.
> >
> > Or you could try a patch from Randy Dunlap & Eric Lammerts [1] which 
> > loops around in do_mounts.c
> > until the root filesystem can be mounted.... not that beautiful - but it 
> > works :)
> > 
> > [1] http://www.xenotime.net/linux/usb/usbboot-2422.patch
> > 
> > Cheers,
> > Andreas
> > 
> > PS: In the same manner you can do it with 2.6
> 
> Thanks Andreas.  I can now boot from my el-cheapo USB key drive (256MB
> SanDisk Cruzer Mini).  Since mine takes about 5sec to show up, I decided
> to wait 5sec instead of 1sec.  Here is diff for 2.6.10:
> 
> --- ./init/do_mounts.c--orig	2004-12-27 17:36:35.000000000 -0500
> +++ ./init/do_mounts.c	2004-12-28 17:27:26.000000000 -0500
> @@ -301,7 +301,14 @@ retry:
>  				root_device_name, b);
>  		printk("Please append a correct \"root=\" boot option\n");
>  
How about adding a loglevel to this printk() while you are at it?  like 
this for instance:
	printk(KERN_ERR "Please append a correct \"root=\" boot option\n");

or maybe that should be KERN_CRIT ...


> +#if 0	/* original code */
>  		panic("VFS: Unable to mount root fs on %s", b);
> +#else
> +		printk ("Waiting 5 seconds to try again...\n");

^^^ And here I think a loglevel of KERN_INFO would be resonable :
	printk (KERN_INFO "Waiting 5 seconds to try mounting root fs again...\n");


> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(5 * HZ);

I could be mistaken, but I would have said that msleep would have been 
better here.???


> +		goto retry;
> +#endif
>  	}
>  	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));

^^^ and this one : 
	panic(KERN_CRIT "VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));


-- 
Jesper Juhl

