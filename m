Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTE3BrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 21:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTE3BrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 21:47:07 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:40098 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261311AbTE3BrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 21:47:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Fri, 30 May 2003 11:59:30 +1000
Message-ID: <16086.47874.272564.71572@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: pee@erkkila.org, Helge Hafting <helgehaf@aitel.hist.no>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, "" <linux-kernel@vger.kernel.org>,
       "" <linux-mm@kvack.org>
Subject: Re: 2.5.70-mm1 bootcrash, possibly RAID-1
In-Reply-To: message from Zwane Mwaikambo on Thursday May 29
References: <20030408042239.053e1d23.akpm@digeo.com>
	<3ED49A14.2020704@aitel.hist.no>
	<20030528111345.GU8978@holomorphy.com>
	<3ED49EB8.1080506@aitel.hist.no>
	<20030528113544.GV8978@holomorphy.com>
	<20030528225913.GA1103@hh.idb.hist.no>
	<3ED54685.5020706@erkkila.org>
	<16085.23940.164807.702704@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.50.0305290313030.940-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0305290331330.940-100000@montezuma.mastecende.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 29, zwane@linuxpower.ca wrote:
> How does the following patch look for the double free.
> 

Thanks. It is a good start, but there are other problems with freeing
things on error paths.   This patch should fix it all.

NeilBrown

--------------------------------------------
Fix up freeing of kmalloc structures

Some paths free things twice, others free un-initialised values :-(
Not any more.


 ----------- Diffstat output ------------
 ./drivers/md/raid0.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff ./drivers/md/raid0.c~current~ ./drivers/md/raid0.c
--- ./drivers/md/raid0.c~current~	2003-05-30 11:40:06.000000000 +1000
+++ ./drivers/md/raid0.c	2003-05-30 11:47:03.000000000 +1000
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
@@ -235,6 +233,8 @@ static int raid0_run (mddev_t *mddev)
 		goto out;
 	mddev->private = (void *)conf;
  
+	mddev->strip_zone = NULL;
+	mddev->devlist = NULL;
 	if (create_strip_zones (mddev)) 
 		goto out_free_conf;
 
@@ -273,7 +273,7 @@ static int raid0_run (mddev_t *mddev)
 				nb_zone*sizeof(struct strip_zone*));
 	conf->hash_table = kmalloc (sizeof (struct strip_zone *)*nb_zone, GFP_KERNEL);
 	if (!conf->hash_table)
-		goto out_free_zone_conf;
+		goto out_free_conf;
 	size = conf->strip_zone[cur].size;
 
 	for (i=0; i< nb_zone; i++) {
@@ -296,12 +296,11 @@ static int raid0_run (mddev_t *mddev)
 	blk_queue_merge_bvec(&mddev->queue, raid0_mergeable_bvec);
 	return 0;
 
-out_free_zone_conf:
-	kfree(conf->strip_zone);
-	conf->strip_zone = NULL;
-
 out_free_conf:
-	kfree (conf->devlist);
+	if (conf->strip_zone)
+		kfree(conf->strip_zone);
+	if (conf->devlist)
+		kfree (conf->devlist);
 	kfree(conf);
 	mddev->private = NULL;
 out:
