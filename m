Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317394AbSFCPF6>; Mon, 3 Jun 2002 11:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSFCPF5>; Mon, 3 Jun 2002 11:05:57 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:39634 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S317394AbSFCPFx>;
	Mon, 3 Jun 2002 11:05:53 -0400
Date: Mon, 3 Jun 2002 17:05:52 +0200
From: Eric Lammerts <eric@lammerts.org>
To: Paul Stoeber <paul.stoeber@stud.tu-ilmenau.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to have root fs on USB device (please CC)
Message-ID: <20020603150552.GA28494@ally.lammerts.org>
In-Reply-To: <20020602201322.GA85820@gogh.RZ.TU-Ilmenau.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jun 02, 2002 at 10:13:22PM +0200, Paul Stoeber wrote:
> It simply sleeps 10 seconds before mount_block_root().
> 
> I get an 'Unable to mount root' panic if I don't apply it,
> because the attached device rolls in too late.

A while ago I made the patch below. I retries every second until the root
device appears. Advantages:
- no delay when the device is already there
- it also works if it takes longer than 10s to find the harddisk
  (for example, if you plug it in later)

I don't know if it applies cleanly to current kernels.

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
