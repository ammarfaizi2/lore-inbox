Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUGGLVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUGGLVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUGGLVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:21:16 -0400
Received: from 142.13.111.219.st.bbexcite.jp ([219.111.13.142]:4023 "EHLO
	tiger.gg3.net") by vger.kernel.org with ESMTP id S265055AbUGGLVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 07:21:13 -0400
Date: Wed, 7 Jul 2004 20:21:10 +0900
From: Georgi Georgiev <chutz@gg3.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: partitionable md devices and partition detection
Message-ID: <20040707112109.GC2051@ols-dell.iic.hokudai.ac.jp>
References: <20040707045939.GA20516@ols-dell.iic.hokudai.ac.jp> <16619.35060.821865.570842@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16619.35060.821865.570842@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maillog: 07/07/2004-15:24:04(+1000): Neil Brown types
> On Wednesday July 7, chutz@gg3.net wrote:
> > What is the proper way to detect the partitions on a md device during kernel
> > initialization?
> 
> Hmm... I guess there isn't.
> I remember having a lot of trouble getting partitions to be recognised
> when an array is first assembled, and deciding it was just easier to
> leave it to user-space.  However that isn't an option when booting
> without an initrd.
> 
> The following patch should make it work for the
>   md=d0,....
> case.  The "raid=part" case is a bit harder....
> 
> NeilBrown
> 
> 
> diff ./init/do_mounts_md.c~current~ ./init/do_mounts_md.c
> --- ./init/do_mounts_md.c~current~	2004-07-07 15:20:05.000000000 +1000
> +++ ./init/do_mounts_md.c	2004-07-07 15:20:57.000000000 +1000
> @@ -232,6 +232,8 @@ static void __init md_setup_drive(void)
>  			err = sys_ioctl(fd, RUN_ARRAY, 0);
>  		if (err)
>  			printk(KERN_WARNING "md: starting md%d failed\n", minor);
> +		else
> +			sys_ioctl(fd, BLKRRPART, 0);
>  		sys_close(fd);
>  	}
>  }

Shouldn't something, similar to the patch above, added to ./drivers/md/md.c do
the trick for the raid=part case?

I am way out of my league here, but looking at the above patch, wouldn't
something like the thing below do it (plus adding the appropriate header)?

I'll try the above suggestion when I get home.

--- /usr/src/linux/drivers/md/md.c.orig	2004-07-07 20:03:23.529156642 +0900
+++ /usr/src/linux/drivers/md/md.c	2004-07-07 20:18:50.845059260 +0900
@@ -1856,6 +1856,22 @@
 					export_rdev(rdev);
 			}
 			autorun_array(mddev);
+			if (part) {
+				int fd;
+				char name[16];
+
+				sprintf(name, "/dev/%s", mdname(mddev));
+				fd = sys_open(name, 0, 0);
+				if (fd < 0) {
+					printk(KERN_ERR 
+						"md: open failed - cannot"
+						"detect partitions on %s\n",
+						name);
+				} else {
+					sys_ioctl(fd, BLKRRPART, 0);
+					sys_close(fd);
+				}
+			}
 			mddev_unlock(mddev);
 		}
 		/* on success, candidates will be empty, on error

-- 
|    Georgi Georgiev   |  The surest sign that a man is in love is     |
|     chutz@gg3.net    |  when he divorces his wife.                   |
|   +81(90)6266-1163   |                                               |
