Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317944AbSFSRTm>; Wed, 19 Jun 2002 13:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSFSRTl>; Wed, 19 Jun 2002 13:19:41 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:3456
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S317944AbSFSRTk>; Wed, 19 Jun 2002 13:19:40 -0400
From: Wayne Whitney <whitney@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Message-Id: <200206191718.g5JHIrK01977@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Dave Jones <davej@suse.de>, Anders Gustafsson <andersg@0x63.nu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: /proc/partitions broken in 2.5.23
In-Reply-To: <20020619113233.GA15730@win.tue.nl>
References: <20020619090248.GA8681@suse.de> <20020619090248.GA8681@suse.de> <20020619113233.GA15730@win.tue.nl>
Reply-To: whitney@math.berkeley.edu
Date: Wed, 19 Jun 2002 10:18:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> I changed something here a few weeks ago. The idea was to avoid
> listing partitions of size 0 but do list full devices, regardless of
> size. Especially in case of removable media that is useful.

I traced the change to the part of mainline ChangeSet 1.496 given
below (warning: cut and pasted).  It seems to cause every possible
device that a driver could provide to show up in /proc/partitions.
For LVM, that's a zillion devices, and /proc/partitions overflows,
showing some random pages from memory.  Reverting the patch below
makes /proc/partitions and LVM happy again.

Cheers,
Wayne


--- a/drivers/block/genhd.c	Wed May  8 09:53:06 2002
+++ b/drivers/block/genhd.c	Sun Jun  9 18:58:36 2002
@@ -177,9 +177,10 @@
 	if (sgp == gendisk_head)
 		seq_puts(part, "major minor  #blocks  name\n\n");
 
-	/* show all non-0 size partitions of this disk */
+	/* show the full disk and all non-0 size partitions of it */
 	for (n = 0; n < (sgp->nr_real << sgp->minor_shift); n++) {
-		if (sgp->part[n].nr_sects == 0)
+		int minormask = (1<<sgp->minor_shift) - 1;
+		if ((n & minormask) && sgp->part[n].nr_sects == 0)
 			continue;
 		seq_printf(part, "%4d  %4d %10d %s\n",
 			sgp->major, n, sgp->sizes[n],
