Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283945AbRLAIlH>; Sat, 1 Dec 2001 03:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283946AbRLAIk6>; Sat, 1 Dec 2001 03:40:58 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4848 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283945AbRLAIku>;
	Sat, 1 Dec 2001 03:40:50 -0500
Date: Sat, 1 Dec 2001 01:39:59 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Message-ID: <20011201013959.E27048@lynx.no>
Mail-Followup-To: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <E16A4G6-0003bf-00@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E16A4G6-0003bf-00@libra.cus.cam.ac.uk>; from aia21@cus.cam.ac.uk on Sat, Dec 01, 2001 at 07:08:22AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 01, 2001  07:08 +0000, Anton Altaparmakov wrote:
> Linus,
> Please consider below patch which adds the starting sector and number of
> sectors to /proc/partitions.
> 
> It works fine here and I find having this information output can be very
> useful (especially when the values in the kernel don't match the values
> output by fdisk for example).

Please do not accept as-is.  This breaks the format of /proc/partitions
terribly, and all of the code that looks at it (fsck, mount, etc).  Rather
add the start_sect and nr_sects parameters _after_ the name parameter,
and it will be "mostly" ok.

While we are at it, how about adding the partition type to the output?
This is the only reason that I ever need to re-parse the on-disk crud
from DOS partition tables, and the kernel already handles it when it
is parsing the partition table.  For the "partitions" that don't have
DOS-style partition types, we can either just put a string (like LVM
or MD) which may be useful for a variety of other reasons.

(Purely hand-edited version of Anton's patch changing it to have the
 new fields at the end, may not apply, may not line up strings properly.
 Doesn't include suggested parition type field either).

On a similar note - Linus, will you accept a patch which fixes the block
device naming, to make it a per driver issue, rather than embedding it
into the core code?  I have one sitting around from way back, that has
been itching to get in.

Cheers, Andreas
============================================================================
diff -u -urN linux-2.5.1-pre5-vanilla/drivers/block/genhd.c l251p5/drivers/block/genhd.c
--- linux-2.5.1-pre5-vanilla/drivers/block/genhd.c	Sat Dec  1 06:09:57 2001
+++ l251p5/drivers/block/genhd.c	Sat Dec  1 03:57:57 2001
@@ -149,7 +149,8 @@
 	char buf[64];
 	int len, n;
 
-	len = sprintf(page, "major minor  #blocks  name\n\n");
+	len = sprintf(page, "major minor %9s %-16s %10s %10s\n",
+                     "#blocks", "name", "start_sect", "nr_sects");
 	read_lock(&gendisk_lock);
 	for (gp = gendisk_head; gp; gp = gp->next) {
 		for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
@@ -157,8 +158,10 @@
 				continue;
 
 			len += snprintf(page + len, 63,
-					"%4d  %4d %10d %s\n",
+					"%4d  %4d %10d %-16s %10lu %10lu\n",
 					gp->major, n, gp->sizes[n],
-					disk_name(gp, n, buf));
+					disk_name(gp, n, buf),
+					gp->part[n].start_sect,
+					gp->part[n].nr_sects);
 			if (len < offset)
 				offset -= len, len = 0;
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

