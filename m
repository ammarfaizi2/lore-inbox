Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbRLWQHh>; Sun, 23 Dec 2001 11:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281787AbRLWQH1>; Sun, 23 Dec 2001 11:07:27 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:5325 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S281772AbRLWQHP>;
	Sun, 23 Dec 2001 11:07:15 -0500
Date: Sun, 23 Dec 2001 17:07:14 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: geoffeg@sin.sloth.org, <linux-kernel@vger.kernel.org>
Subject: Re: Using USB floppy drive for root floppy
In-Reply-To: <200112230834.fBN8YHl15225@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.43.0112231702260.31001-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Dec 2001, Pete Zaitcev wrote:
> There must be a delay before an attempt to mount is made.
> Insert schedule_timeout(5*HZ) there (mdelay won't work because
> it locks out khubd).

I made the patch below for this kind of thing. With this I can mount
the root fs on a USB harddisk.

Eric

--- linux-2.4.14-pre8-ext3/fs/super.c.orig	Fri Nov 16 00:59:18 2001
+++ linux-2.4.14-pre8-ext3/fs/super.c	Fri Nov 16 01:07:26 2001
@@ -1009,11 +1009,13 @@
 		 * Allow the user to distinguish between failed open
 		 * and bad superblock on root device.
 		 */
-		printk ("VFS: Cannot open root device \"%s\" or %s\n",
+		printk ("VFS: Cannot open root device \"%s\" or %s, retrying in 1s.\n",
 			root_device_name, kdevname (ROOT_DEV));
-		printk ("Please append a correct \"root=\" boot option\n");
-		panic("VFS: Unable to mount root fs on %s",
-			kdevname(ROOT_DEV));
+
+		/* wait 1 second and try again */
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ);
+		goto retry;
 	}

 	check_disk_change(ROOT_DEV);


