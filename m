Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUECB2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUECB2y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 21:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUECB2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 21:28:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:25229 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263413AbUECB2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 21:28:48 -0400
Date: Sun, 2 May 2004 18:27:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Bill Catlan" <wcatlan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible to delay boot process to boot from USB subsystem?
Message-Id: <20040502182731.1e1cced6.rddunlap@osdl.org>
In-Reply-To: <003201c4309c$fd93cd90$0202a8c0@boxa>
References: <003201c4309c$fd93cd90$0202a8c0@boxa>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 May 2004 19:27:08 -0400 "Bill Catlan" <wcatlan@yahoo.com> wrote:

| Hello,
| 
| The below message appeared on linux-kernel in June 2002.  The patch allows
| booting from a USB harddrive and was designed for the 2.4.14-pre8-ext3 kernel,
| but I was able to manually apply it to a Debian 2.4.18 kernel.
| 
| I am now trying to upgrade to a 2.4.26 kernel, and I am unable to create the
| same "boot from floppy with rootfs on a USB drive" scenario that I created with
| the modified 2.4.18 kernel.  I believe my current issue with the 2.4.26 kernel
| is the same race condition as on the 2.4.18 kernel since I get the "Initializing
| USB Mass Storage driver..." notice, but then i get "Kernel panic: No init found.
| Try passing init= option to kernel."  Given time, I suspect that the USB storage
| subsystem would come online and the kernel would be able to mount the rootfs on
| it.
| 
| fs/super.c has change dramatically and the below patch now seems obsolete.
| 
| Is there a similar patch for newer kernels - or any other way to cause the boot
| process to pause between loading the kernel and modules and running /sbin/init?
| 
| TIA.
| 
| Bill
| 
| On Sun, Jun 02, 2002 at 10:13:22PM +0200, Paul Stoeber wrote:
| > It simply sleeps 10 seconds before mount_block_root().
| >
| > I get an 'Unable to mount root' panic if I don't apply it,
| > because the attached device rolls in too late.
| 
| A while ago I made the patch below. I retries every second until the root
| device appears. Advantages:
| - no delay when the device is already there
| - it also works if it takes longer than 10s to find the harddisk
|   (for example, if you plug it in later)
| 
| I don't know if it applies cleanly to current kernels.
| 
| Eric
| 
| --- linux-2.4.14-pre8-ext3/fs/super.c.orig	Fri Nov 16 00:59:18 2001
| +++ linux-2.4.14-pre8-ext3/fs/super.c	Fri Nov 16 01:07:26 2001
| @@ -1009,11 +1009,13 @@
|  		 * Allow the user to distinguish between failed open
|  		 * and bad superblock on root device.
|  		 */
| -		printk ("VFS: Cannot open root device \"%s\" or %s\n",
| +		printk ("VFS: Cannot open root device \"%s\" or %s, retrying in 1s.\n",
|  			root_device_name, kdevname (ROOT_DEV));
| -		printk ("Please append a correct \"root=\" boot option\n");
| -		panic("VFS: Unable to mount root fs on %s",
| -			kdevname(ROOT_DEV));
| +
| +		/* wait 1 second and try again */
| +		current->state = TASK_INTERRUPTIBLE;
| +		schedule_timeout(HZ);
| +		goto retry;
|  	}
| 
|  	check_disk_change(ROOT_DEV);
| -

I updated that patch to 2.4.22 but haven't checked it since then.
I can't test it... if you can, that would be great.
If it doesn't apply cleanly to 2.4.26, let me know and I'll work
on it.

Patch is here:
  http://www.xenotime.net/linux/usb/usbboot-2422.patch

--
~Randy
