Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281392AbRKPNVf>; Fri, 16 Nov 2001 08:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281391AbRKPNVZ>; Fri, 16 Nov 2001 08:21:25 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:4573 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S281383AbRKPNVG>;
	Fri, 16 Nov 2001 08:21:06 -0500
Date: Fri, 16 Nov 2001 14:21:04 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: josn@josn.myip.org, Greg KH <greg@kroah.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: rootfs on USB storage device
In-Reply-To: <200111160306.fAG36ZW05331@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.40.0111161403001.991-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Nov 2001, Pete Zaitcev wrote:
> I think khubd needs to run to complete whole process and mdelay()
> locks it out. You need something that calls schedule() for USB
> detection to work. Try to use schedule_timeout() instead of mdelay().

This patch works for me.

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

