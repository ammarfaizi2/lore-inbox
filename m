Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbULaD7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbULaD7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 22:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbULaD7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 22:59:14 -0500
Received: from dialin-160-141.tor.primus.ca ([216.254.160.141]:10624 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261855AbULaD7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 22:59:03 -0500
Date: Thu, 30 Dec 2004 22:58:34 -0500
From: William Park <opengeometry@yahoo.ca>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041231035834.GA2421@node1.opengeometry.net>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet> <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 02:45:53AM +0100, Jesper Juhl wrote:
> William Park wrote:
> > On Thu, Dec 30, 2004 at 01:25:32PM -0200, Marcelo Tosatti wrote:
> > > On Tue, Dec 28, 2004 at 07:59:22PM -0500, William Park wrote:
> > > > On Mon, Dec 27, 2004 at 10:23:34PM +0100, Andreas Unterkircher wrote:
> > > > > [1] http://www.xenotime.net/linux/usb/usbboot-2422.patch
...
> > http://linux.bkbits.net:8080/linux-2.4/patch@1.1527.1.20?nav=index.html|ChangeSet@-3w|cset@1.1527.1.20 
> > 
> > Hi Marcelo,
> > 
> > 1.  Actually, my patch above loops every 5s to reduce screen clutter,
> >     whereas the original 2.4 patch (cited by Andreas Unterkircher) loops
> >     every 1s.  Both loops forever.
> > 
> >     But, if a limit of 10 tries is what you want, then here is a patch
> >     for 2.6.10:
> 
> I agree with you that reducing screen clutter is a good thing. How
> about something like this that waits for 10+ seconds so even slow
> devices have a chance to get up but also does some primitive
> ratelimiting on the messages by only printing one every 3 seconds (but
> still attempting to mount every 1 sec) ? 

Hi Jesper,

I prefer countdown with short message.  The 2.4 messages are too long.
Incorporating your use of ssleep() and printk() loglevel, here is
the latest iteration:

--- ./init/do_mounts.c--orig	2004-12-27 17:36:35.000000000 -0500
+++ ./init/do_mounts.c	2004-12-30 22:43:57.000000000 -0500
@@ -6,6 +6,7 @@
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
 #include <linux/security.h>
+#include <linux/delay.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -278,6 +279,7 @@
 	char *fs_names = __getname();
 	char *p;
 	char b[BDEVNAME_SIZE];
+	int tryagain = 20;
 
 	get_fs_names(fs_names);
 retry:
@@ -297,9 +299,13 @@
 		 * and bad superblock on root device.
 		 */
 		__bdevname(ROOT_DEV, b);
-		printk("VFS: Cannot open root device \"%s\" or %s\n",
-				root_device_name, b);
-		printk("Please append a correct \"root=\" boot option\n");
+		if (--tryagain) {
+		    printk (KERN_WARNING "VFS: Waiting %dsec for root device...\n", tryagain);
+		    ssleep (1);
+		    goto retry;
+		}
+		printk (KERN_CRIT "VFS: Cannot open root device \"%s\" or %s\n", root_device_name, b);
+		printk (KERN_CRIT "Please append a correct \"root=\" boot option\n");
 
 		panic("VFS: Unable to mount root fs on %s", b);
 	}
