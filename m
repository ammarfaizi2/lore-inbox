Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBVAxt>; Wed, 21 Feb 2001 19:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbRBVAxj>; Wed, 21 Feb 2001 19:53:39 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:36044 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129170AbRBVAx1>; Wed, 21 Feb 2001 19:53:27 -0500
Message-ID: <3A94634E.E25F3758@erols.com>
Date: Wed, 21 Feb 2001 19:54:38 -0500
From: Alex Davis <letmein@erols.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: Patch for file fs/partitions/check.c
In-Reply-To: <UTC200102202301.AAA209334.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> > Are you the person I send the patch to?
> 
> Send it to aeb@cwi.nl and to linux-kernel@vger.kernel.org .
> 
> Andries

Here's my patch to perform a media-change check and, if necessary,
a disk revalidate whenever /proc/partitions is accessed.

--- check.c.save	Wed Feb 21 17:50:54 2001
+++ check.c	Wed Feb 21 19:49:20 2001
@@ -9,6 +9,10 @@
  *  contained.
  *
  *  Added needed MAJORS for new pairs, {hdi,hdj}, {hdk,hdl}
+ *
+ *  Alex Davis <letmein@erols.com>
+ *	Added code to keep /proc/partitions in sync with
+ *  removable media.
  */
 
 #include <linux/config.h>
@@ -242,11 +246,25 @@
 int get_partition_list(char *page, char **start, off_t offset, int
count)
 {
 	struct gendisk *dsk;
+	kdev_t dev;
 	int len;
 
 	len = sprintf(page, "major minor  #blocks  name\n\n");
 	for (dsk = gendisk_head; dsk; dsk = dsk->next) {
 		int n;
+		int i;
+
+		if ( dsk->fops->check_media_change &&
+			 dsk->fops->revalidate ) {
+			for ( i = 0; i < dsk->nr_real; ++i ) {
+				dev = MKDEV(dsk->major, i << dsk->minor_shift);
+				if ( dsk->flags[i] & GENHD_FL_REMOVABLE &&
+					 dsk->fops->check_media_change(dev) ) {
+//printk(KERN_INFO "revalidating drive %d:%d\n", dsk->major, i);
+					dsk->fops->revalidate(dev);
+				}
+			}
+		}
 
 		for (n = 0; n < (dsk->nr_real << dsk->minor_shift); n++)
 			if (dsk->part[n].nr_sects) {
