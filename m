Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbUL2A7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbUL2A7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 19:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbUL2A7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 19:59:32 -0500
Received: from dsl-209-183-20-58.tor.primus.ca ([209.183.20.58]:11648 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261211AbUL2A70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 19:59:26 -0500
Date: Tue, 28 Dec 2004 19:59:22 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041229005922.GA2520@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D07D56.7020702@netshadow.at>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 10:23:34PM +0100, Andreas Unterkircher wrote:
> >>How do I make the kernel to wait about 10s before attempting to
> >>mount root filesystem?  Is there obscure kernel parameter?
> >>
> >>I can load the kernel from /dev/fd0, then mount /dev/hda2 as root
> >>filesystem.  But, I can't seem to mount /dev/sda1 (USB key drive) as
> >>root filesystem.  All relevant USB and SCSI modules are compiled
> >>into the kernel.  I think kernel is too fast in panicking.  I would
> >>like the kernel to wait about 10s until 'usb-storage' and 'sd_mod'
> >>work out all the details.
> >
> >This is really suited to the task of an initrd, then you can spin
> >until the usb storage device comes up in a bash script or something
> >similar.
>
> Or you could try a patch from Randy Dunlap & Eric Lammerts [1] which 
> loops around in do_mounts.c
> until the root filesystem can be mounted.... not that beautiful - but it 
> works :)
> 
> [1] http://www.xenotime.net/linux/usb/usbboot-2422.patch
> 
> Cheers,
> Andreas
> 
> PS: In the same manner you can do it with 2.6

Thanks Andreas.  I can now boot from my el-cheapo USB key drive (256MB
SanDisk Cruzer Mini).  Since mine takes about 5sec to show up, I decided
to wait 5sec instead of 1sec.  Here is diff for 2.6.10:

--- ./init/do_mounts.c--orig	2004-12-27 17:36:35.000000000 -0500
+++ ./init/do_mounts.c	2004-12-28 17:27:26.000000000 -0500
@@ -301,7 +301,14 @@ retry:
 				root_device_name, b);
 		printk("Please append a correct \"root=\" boot option\n");
 
+#if 0	/* original code */
 		panic("VFS: Unable to mount root fs on %s", b);
+#else
+		printk ("Waiting 5 seconds to try again...\n");
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(5 * HZ);
+		goto retry;
+#endif
 	}
 	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
 out:

-- 
William Park <opengeometry@yahoo.ca>
Open Geometry Consulting, Toronto, Canada
Linux solution for data processing. 
