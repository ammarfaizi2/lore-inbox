Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTE2Hbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 03:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTE2Hbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 03:31:32 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:43648
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261985AbTE2Hb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 03:31:29 -0400
Date: Thu, 29 May 2003 03:32:15 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: pee@erkkila.org, Helge Hafting <helgehaf@aitel.hist.no>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, "" <linux-kernel@vger.kernel.org>,
       "" <linux-mm@kvack.org>
Subject: Re: 2.5.70-mm1 bootcrash, possibly RAID-1
In-Reply-To: <Pine.LNX.4.50.0305290313030.940-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0305290331330.940-100000@montezuma.mastecende.com>
References: <20030408042239.053e1d23.akpm@digeo.com> <3ED49A14.2020704@aitel.hist.no>
 <20030528111345.GU8978@holomorphy.com> <3ED49EB8.1080506@aitel.hist.no>
 <20030528113544.GV8978@holomorphy.com> <20030528225913.GA1103@hh.idb.hist.no>
 <3ED54685.5020706@erkkila.org> <16085.23940.164807.702704@notabene.cse.unsw.edu.au>
 <Pine.LNX.4.50.0305290313030.940-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does the following patch look for the double free.

On Thu, 29 May 2003, Zwane Mwaikambo wrote:

> slab error in cache_free_debugcheck(): cache `size-32': double free, or memory before object was overwritten
> Call Trace:
>  [<c0148da3>] kfree+0xf3/0x2e0
>  [<c0366a64>] raid0_run+0x234/0x250
>  [<c0366a64>] raid0_run+0x234/0x250
>  [<c012529a>] printk+0x1ca/0x280
>  [<c0371fa4>] do_md_run+0x2f4/0x560
>  [<c0371fbb>] do_md_run+0x30b/0x560
>  [<c012529a>] printk+0x1ca/0x280
>  [<c03724f2>] autorun_array+0x82/0xa0
>  [<c012529a>] printk+0x1ca/0x280
>  [<c03726ff>] autorun_devices+0x1ef/0x230
>  [<c0375569>] autostart_arrays+0x29/0xba
>  [<c036f8f6>] mddev_put+0x16/0xb0
>  [<c0250728>] capable+0x18/0x40
>  [<c03737de>] md_ioctl+0x56e/0x5a0
>  [<c0169759>] blkdev_open+0x29/0x30
>  [<c015f0dc>] dentry_open+0x14c/0x230
>  [<c0148c2a>] kmem_cache_free+0x1ca/0x250
>  [<c02a2f0b>] blkdev_ioctl+0x8b/0x3b1
>  [<c01747d6>] sys_ioctl+0x156/0x310
>  [<c056f6b7>] md_run_setup+0x57/0x80
>  [<c056ef28>] prepare_namespace+0x8/0xa0
>  [<c01050fb>] init+0x5b/0x210
>  [<c01050a0>] init+0x0/0x210
>  [<c01070e5>] kernel_thread_helper+0x5/0x10

Index: linux-2.5/drivers/md/raid0.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/md/raid0.c,v
retrieving revision 1.31
diff -u -p -B -r1.31 raid0.c
--- linux-2.5/drivers/md/raid0.c	27 May 2003 04:06:15 -0000	1.31
+++ linux-2.5/drivers/md/raid0.c	29 May 2003 06:35:17 -0000
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
 
-- 
function.linuxpower.ca
