Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbULaAWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbULaAWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 19:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbULaAWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 19:22:35 -0500
Received: from dialin-157-254.tor.primus.ca ([216.254.157.254]:4224 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261790AbULaAW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 19:22:27 -0500
Date: Thu, 30 Dec 2004 19:22:10 -0500
From: William Park <opengeometry@yahoo.ca>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041231002210.GA2418@node1.opengeometry.net>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230152531.GB5058@logos.cnet>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 01:25:32PM -0200, Marcelo Tosatti wrote:
> On Tue, Dec 28, 2004 at 07:59:22PM -0500, William Park wrote:
> > On Mon, Dec 27, 2004 at 10:23:34PM +0100, Andreas Unterkircher wrote:
> > > [1] http://www.xenotime.net/linux/usb/usbboot-2422.patch
> > 
> > Thanks Andreas.  I can now boot from my el-cheapo USB key drive
> > (256MB SanDisk Cruzer Mini).  Since mine takes about 5sec to show
> > up, I decided to wait 5sec instead of 1sec.  Here is diff for
> > 2.6.10:
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
> Solar version which is now merged in v2.4 looks better (5s sleep is
> too long and only one try) IMO.
> 
> It sleeps 1s each time, 10 times. More reliable and faster.
> 
> http://linux.bkbits.net:8080/linux-2.4/patch@1.1527.1.20?nav=index.html|ChangeSet@-3w|cset@1.1527.1.20 

Hi Marcelo,

1.  Actually, my patch above loops every 5s to reduce screen clutter,
    whereas the original 2.4 patch (cited by Andreas Unterkircher) loops
    every 1s.  Both loops forever.

    But, if a limit of 10 tries is what you want, then here is a patch
    for 2.6.10:
====================

--- ./init/do_mounts.c--orig	2004-12-27 17:36:35.000000000 -0500
+++ ./init/do_mounts.c	2004-12-30 18:57:46.000000000 -0500
@@ -278,6 +278,7 @@
 	char *fs_names = __getname();
 	char *p;
 	char b[BDEVNAME_SIZE];
+	int tryagain = 10;
 
 	get_fs_names(fs_names);
 retry:
@@ -297,11 +298,16 @@
 		 * and bad superblock on root device.
 		 */
 		__bdevname(ROOT_DEV, b);
+		if (--tryagain) {
+		    printk ("VFS: Waiting %dsec for root device...\n", tryagain);
+		    set_current_state (TASK_INTERRUPTIBLE);
+		    schedule_timeout (HZ);
+		    goto retry;
+		}
 		printk("VFS: Cannot open root device \"%s\" or %s\n",
 				root_device_name, b);
 		printk("Please append a correct \"root=\" boot option\n");
-
-		panic("VFS: Unable to mount root fs on %s", b);
+		break;
 	}
 	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
 out:

====================

    The only difference are
	- using 'tryagain' instead of 'tries' as counter
	- printing countdown of seconds like
	    VFS: Waiting 9sec for root device...
	    VFS: Waiting 8sec for root device...
	    ...
	    VFS: Waiting 1sec for root device...
	  before printing the final error.


2.  I sincerely hope that this patch get included in the main kernel.
    USB boot is very important feature, and will become the standard way
    of booting Linux thin-client as well as other Linux system, embedded
    or not.  It will make Netboot, Etherboot, PXE boot, CF-to-IDE
    adapter, and initrd all obsolete.

-- 
William Park <opengeometry@yahoo.ca>
Open Geometry Consulting, Toronto, Canada
Linux solution for data processing. 
