Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbULaBev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbULaBev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 20:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbULaBev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 20:34:51 -0500
Received: from mail.dif.dk ([193.138.115.101]:8394 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261804AbULaBeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 20:34:44 -0500
Date: Fri, 31 Dec 2004 02:45:53 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: William Park <opengeometry@yahoo.ca>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: waiting 10s before mounting root filesystem?
In-Reply-To: <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost>
References: <20041227195645.GA2282@node1.opengeometry.net>
 <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at>
 <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet>
 <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Park wrote:
> On Thu, Dec 30, 2004 at 01:25:32PM -0200, Marcelo Tosatti wrote:
> > On Tue, Dec 28, 2004 at 07:59:22PM -0500, William Park wrote:
> > > On Mon, Dec 27, 2004 at 10:23:34PM +0100, Andreas Unterkircher wrote:
> > > > [1] http://www.xenotime.net/linux/usb/usbboot-2422.patch
> > > 
> > > Thanks Andreas.  I can now boot from my el-cheapo USB key drive
> > > (256MB SanDisk Cruzer Mini).  Since mine takes about 5sec to show
> > > up, I decided to wait 5sec instead of 1sec.  Here is diff for
> > > 2.6.10:
> > > 
> > > --- ./init/do_mounts.c--orig	2004-12-27 17:36:35.000000000 -0500
> > > +++ ./init/do_mounts.c	2004-12-28 17:27:26.000000000 -0500
> > > @@ -301,7 +301,14 @@ retry:
> > >  				root_device_name, b);
> > >  		printk("Please append a correct \"root=\" boot option\n");
> > > 
> > > +#if 0	/* original code */
> > >  		panic("VFS: Unable to mount root fs on %s", b);
> > > +#else
> > > +		printk ("Waiting 5 seconds to try again...\n");
> > > +		set_current_state(TASK_INTERRUPTIBLE);
> > > +		schedule_timeout(5 * HZ);
> > > +		goto retry;
> > > +#endif
> > >  	}
> > >  	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
> > >  out:
> > 
> > William,
> > 
> > Solar version which is now merged in v2.4 looks better (5s sleep is
> > too long and only one try) IMO.
> > 
> > It sleeps 1s each time, 10 times. More reliable and faster.
> > 
> > 
> http://linux.bkbits.net:8080/linux-2.4/patch@1.1527.1.20?nav=index.html|ChangeSet@-3w|cset@1.1527.1.20 
> 
> Hi Marcelo,
> 
> 1.  Actually, my patch above loops every 5s to reduce screen clutter,
>     whereas the original 2.4 patch (cited by Andreas Unterkircher) loops
>     every 1s.  Both loops forever.
> 
>     But, if a limit of 10 tries is what you want, then here is a patch
>     for 2.6.10:

I agree with you that reducing screen clutter is a good thing. How about 
something like this that waits for 10+ seconds so even slow devices have a 
chance to get up but also does some primitive ratelimiting on the messages 
by only printing one every 3 seconds (but still attempting to mount every 
1 sec) ? 

This is a small variation on the patch I posted a little while ago.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk2-orig/init/do_mounts.c linux-2.6.10-bk2/init/do_mounts.c
--- linux-2.6.10-bk2-orig/init/do_mounts.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.10-bk2/init/do_mounts.c	2004-12-31 02:44:13.000000000 +0100
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
@@ -297,9 +299,17 @@ retry:
 		 * and bad superblock on root device.
 		 */
 		__bdevname(ROOT_DEV, b);
-		printk("VFS: Cannot open root device \"%s\" or %s\n",
+		if (retries--) {
+			if (retries % 3 == 0)
+				printk(KERN_WARNING "VFS: Cannot open root device "
+					"\"%s\" or %s, retrying in 1s.\n",
+					root_device_name, b);
+			ssleep(1);
+			goto retry;
+		}
+		printk(KERN_CRIT "VFS: Cannot open root device \"%s\" or %s, giving up.\n",
 				root_device_name, b);
-		printk("Please append a correct \"root=\" boot option\n");
+		printk(KERN_CRIT "Please append a correct \"root=\" boot option\n");
 
 		panic("VFS: Unable to mount root fs on %s", b);
 	}



> 
> 2.  I sincerely hope that this patch get included in the main kernel.
>     USB boot is very important feature, and will become the standard way
>     of booting Linux thin-client as well as other Linux system, embedded
>     or not.  It will make Netboot, Etherboot, PXE boot, CF-to-IDE
>     adapter, and initrd all obsolete.
> 
I agree, some version of this should go into 2.6. If we can successfully 
get the system up and running by retrying the root fs mount a few times 
then that's a lot better than panicking :)


-- 
Jesper Juhl


PS. Sorry if I messed up the thread a bit, but I had some mailserver 
trouble and lost a few LKML mails so I couldn't reply directly to the 
proper mail.
