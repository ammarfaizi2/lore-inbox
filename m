Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTE2VY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTE2VYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:24:55 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:52999 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262884AbTE2VYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:24:53 -0400
Date: Thu, 29 May 2003 14:35:36 -0700
From: Andrew Morton <akpm@digeo.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: Thomas.Downing@ipc.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm2
Message-Id: <20030529143536.438b14a0.akpm@digeo.com>
In-Reply-To: <16086.31229.258838.80234@gargle.gargle.HOWL>
References: <170EBA504C3AD511A3FE00508BB89A920221E5FF@exnanycmbx4.ipc.com>
	<20030529103628.54d1e4a0.akpm@digeo.com>
	<16086.31229.258838.80234@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2003 21:38:11.0385 (UTC) FILETIME=[9A306290:01C3262A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Stoffel" <stoffel@lucent.com> wrote:
>
> 
> Does 2.5.70-mm2 include the RAID1 patch posted by Niel?

No.  It seems that it didn't work right.

Zwane had a different fix, but afaik nobody has tried it out.  Apart from
Zwane of course.  And that was against raid0.


Zwane's RAID0 patch


diff -puN drivers/md/raid0.c~zwane-raid-double-free-fix drivers/md/raid0.c
--- 25/drivers/md/raid0.c~zwane-raid-double-free-fix	Thu May 29 14:32:02 2003
+++ 25-akpm/drivers/md/raid0.c	Thu May 29 14:32:02 2003
@@ -85,10 +85,8 @@ static int create_strip_zones (mddev_t *
 	conf->devlist = kmalloc(sizeof(mdk_rdev_t*)*
 				conf->nr_strip_zones*mddev->raid_disks,
 				GFP_KERNEL);
-	if (!conf->devlist) {
-		kfree(conf);
+	if (!conf->devlist)
 		return 1;
-	}
 
 	memset(conf->strip_zone, 0,sizeof(struct strip_zone)*
 				   conf->nr_strip_zones);
@@ -194,7 +192,6 @@ static int create_strip_zones (mddev_t *
 	return 0;
  abort:
 	kfree(conf->devlist);
-	kfree(conf->strip_zone);
 	return 1;
 }
 


Neil's RAID1 patch

diff -puN drivers/md/raid1.c~neilb-raid1-double-free-fix drivers/md/raid1.c
--- 25/drivers/md/raid1.c~neilb-raid1-double-free-fix	Thu May 29 14:34:23 2003
+++ 25-akpm/drivers/md/raid1.c	Thu May 29 14:34:23 2003
@@ -137,7 +137,7 @@ static void put_all_bios(conf_t *conf, r
 			BUG();
 		bio_put(r1_bio->read_bio);
 		r1_bio->read_bio = NULL;
-	}
+	} else
 	for (i = 0; i < conf->raid_disks; i++) {
 		struct bio **bio = r1_bio->write_bios + i;
 		if (*bio) {



