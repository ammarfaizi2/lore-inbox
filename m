Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276047AbRI1NjN>; Fri, 28 Sep 2001 09:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276051AbRI1NjC>; Fri, 28 Sep 2001 09:39:02 -0400
Received: from ns.caldera.de ([212.34.180.1]:6569 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276050AbRI1Nil>;
	Fri, 28 Sep 2001 09:38:41 -0400
Date: Fri, 28 Sep 2001 15:39:01 +0200
Message-Id: <200109281339.f8SDd1A08841@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: joachim_weller@hsgmed.com (Joachim Weller)
Cc: JoachimWeller@web.de, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: BUG: cat /proc/partitions endless loop
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <200109281315.f8SDFpA01669@bmdipc2c.germany.agilent.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200109281315.f8SDFpA01669@bmdipc2c.germany.agilent.com> you wrote:
>  I traced the problem down to drivers/block/genhd.c, 
> where the function get_partition_list() outer loop does not 
> terminate due to the last element in the structured list starting 
> with gendisk_head is not initialized to NULL, by whatever reason.
> My fix does not cure the pointered endless loop, but prevents
> from looping when stepping thru the pointered list.

I think the fix could be simpler.  What about:

--- ../master/linux-2.4.10/drivers/block/genhd.c	Sun Sep 23 21:20:52 2001
+++ linux-2.4.10/drivers/block/genhd.c	Fri Sep 28 15:34:14 2001
@@ -115,7 +115,7 @@
 
 	len = sprintf(page, "major minor  #blocks  name\n\n");
 	read_lock(&gendisk_lock);
-	for (gp = gendisk_head; gp; gp = gp->next) {
+	for (gp = gendisk_head; gp != gendisk_head; gp = gp->next) {
 		for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
 			if (gp->part[n].nr_sects == 0)
 				continue;


