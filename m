Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbUL3XeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUL3XeV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUL3XeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:34:21 -0500
Received: from mail.dif.dk ([193.138.115.101]:49603 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261751AbUL3XeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:34:08 -0500
Date: Fri, 31 Dec 2004 00:45:16 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, William Park <opengeometry@yahoo.ca>,
       Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>
Subject: Re: waiting 10s before mounting root filesystem?
In-Reply-To: <20041230152531.GB5058@logos.cnet>
Message-ID: <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost>
References: <20041227195645.GA2282@node1.opengeometry.net>
 <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at>
 <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004, Marcelo Tosatti wrote:

> On Tue, Dec 28, 2004 at 07:59:22PM -0500, William Park wrote:
> > On Mon, Dec 27, 2004 at 10:23:34PM +0100, Andreas Unterkircher wrote:
> > > >>How do I make the kernel to wait about 10s before attempting to
> > > >>mount root filesystem?  Is there obscure kernel parameter?
> > > >>
> > > >>I can load the kernel from /dev/fd0, then mount /dev/hda2 as root
> > > >>filesystem.  But, I can't seem to mount /dev/sda1 (USB key drive) as
> > > >>root filesystem.  All relevant USB and SCSI modules are compiled
> > > >>into the kernel.  I think kernel is too fast in panicking.  I would
> > > >>like the kernel to wait about 10s until 'usb-storage' and 'sd_mod'
> > > >>work out all the details.
> > > >
> > > >This is really suited to the task of an initrd, then you can spin
> > > >until the usb storage device comes up in a bash script or something
> > > >similar.
> > >
> > > Or you could try a patch from Randy Dunlap & Eric Lammerts [1] which 
> > > loops around in do_mounts.c
> > > until the root filesystem can be mounted.... not that beautiful - but it 
> > > works :)
> > > 
> > > [1] http://www.xenotime.net/linux/usb/usbboot-2422.patch
> > > 
> > > Cheers,
> > > Andreas
> > > 
> > > PS: In the same manner you can do it with 2.6
> > 
> > Thanks Andreas.  I can now boot from my el-cheapo USB key drive (256MB
> > SanDisk Cruzer Mini).  Since mine takes about 5sec to show up, I decided
> > to wait 5sec instead of 1sec.  Here is diff for 2.6.10:
> > 
> > --- ./init/do_mounts.c--orig	2004-12-27 17:36:35.000000000 -0500
> > +++ ./init/do_mounts.c	2004-12-28 17:27:26.000000000 -0500
> > @@ -301,7 +301,14 @@ retry:
> >  				root_device_name, b);
> >  		printk("Please append a correct \"root=\" boot option\n");
> >  
> > +#if 0	/* original code */
> >  		panic("VFS: Unable to mount root fs on %s", b);
> > +#else
> > +		printk ("Waiting 5 seconds to try again...\n");
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		schedule_timeout(5 * HZ);
> > +		goto retry;
> > +#endif
> >  	}
> >  	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
> >  out:
> 
> William,
> 
> Solar version which is now merged in v2.4 looks better (5s sleep is too long and only one try) IMO.
> 
> It sleeps 1s each time, 10 times. More reliable and faster.
> 
> http://linux.bkbits.net:8080/linux-2.4/patch@1.1527.1.20?nav=index.html|ChangeSet@-3w|cset@1.1527.1.20 

That's a nice patch. Why not make the same change in 2.6?
I forward ported the patch linked above with a few minor changes - my 
version differs from the original in these ways : 
 - use ssleep() instead of schedule_timeout.
 - rename tries to retries and actually retry the specified nr of times 
   ( if (retries--) {...} instead of  if (--tries) {...} ).
 - use a short instead of int to hold the retry count.
 - change the text outputted a little bit.
 - retry a few more times (15 instead of 9) since if we fail here we are 
   going to panic() we might as well try hard, and who knows how slow some 
   devices can be?

Andrew, would you consider including the patch below in 2.6 ?


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk2-orig/init/do_mounts.c linux-2.6.10-bk2/init/do_mounts.c
--- linux-2.6.10-bk2-orig/init/do_mounts.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.10-bk2/init/do_mounts.c	2004-12-31 00:00:37.000000000 +0100
@@ -6,6 +6,7 @@
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
 #include <linux/security.h>
+#include <linux/delay.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -278,6 +279,7 @@ void __init mount_block_root(char *name,
 	char *fs_names = __getname();
 	char *p;
 	char b[BDEVNAME_SIZE];
+	short retries = 15;
 
 	get_fs_names(fs_names);
 retry:
@@ -297,9 +299,16 @@ retry:
 		 * and bad superblock on root device.
 		 */
 		__bdevname(ROOT_DEV, b);
-		printk("VFS: Cannot open root device \"%s\" or %s\n",
+		if (retries--) {
+			printk(KERN_WARNING "VFS: Cannot open root device "
+				"\"%s\" or %s, retrying in 1s.\n",
 				root_device_name, b);
-		printk("Please append a correct \"root=\" boot option\n");
+			ssleep(1);
+			goto retry;
+		}
+		printk(KERN_CRIT "VFS: Cannot open root device \"%s\" or %s, giving up.\n",
+				root_device_name, b);
+		printk(KERN_CRIT "Please append a correct \"root=\" boot option\n");
 
 		panic("VFS: Unable to mount root fs on %s", b);
 	}


