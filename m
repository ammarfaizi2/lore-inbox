Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTEaQBA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTEaQBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:01:00 -0400
Received: from services.erkkila.org ([24.97.94.217]:43730 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id S264368AbTEaQA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:00:56 -0400
Message-ID: <3ED8D4A7.3080607@erkkila.org>
Date: Sat, 31 May 2003 16:13:27 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030520
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm1 bootcrash, possibly RAID-1
References: <20030408042239.053e1d23.akpm@digeo.com>	<3ED49A14.2020704@aitel.hist.no>	<20030528111345.GU8978@holomorphy.com>	<3ED49EB8.1080506@aitel.hist.no>	<20030528113544.GV8978@holomorphy.com>	<20030528225913.GA1103@hh.idb.hist.no>	<3ED54685.5020706@erkkila.org>	<16085.23940.164807.702704@notabene.cse.unsw.edu.au>	<Pine.LNX.4.50.0305290313030.940-100000@montezuma.mastecende.com>	<Pine.LNX.4.50.0305290331330.940-100000@montezuma.mastecende.com> <16086.47874.272564.71572@notabene.cse.unsw.edu.au>
In-Reply-To: <16086.47874.272564.71572@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With patch applied to lastest BK I get this on bootup.
(manual copy)

blk_queue_segment_boundary: set to minimum fff
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
---------------[ cut here ] -------------
kernbel BUG at drivers/md/raid1.c:145!
invalid operand: 000 [#1]
CPU:   0
EIP:   0060:[<c025d7df>]   Not tainted
EFLAGS: 00010097
EIP is at put_all_bios+0x59/0x85
eax: 00000000 ebx: 00000001 exc: 00000010 edx: f7ffb800
esi: f7d5ddb4 edi: 00000003 ebp: c036bdf8 esp: c036bde8
ds: 007 es: 007b ss:0068
Process swapper (pid: 0, threadinfo=c036a000 task=c02f3000)
Stack: f7fcf900 f7d80480 00000046 f7d5dd80 c036be18 c025d8fc f7d80480 
f7d4dd80
       00000000 f7d5dd80 00000001 0000000c c036be18 c025da43 f7d5dd80 
f7f9f880
       00000003 00000000 00000001 00000004 00000000 c18f5ch4 f7d6fce0 
0000000c

Call Trace:
[<c025d8fc>] raid_end_bio_io+0x55/0x92
[<c025da43>] raid1_end_request+0x10a/0x196
[<c013042c>] mempool_free+0x32/0x65
[<c014a420>] bio_endio+0x55/0x7a
[<c01ef559>] __end_that_request_first+0x1f1/0x20d
[<c023c0a4>] ide_end_request+0x58/0x118
[<c024f3cb>] ide_dma_intr+0x9d/0xba
[<c023d43f>] ide_intr+0xb9/0x12e
[<c024f34e>] ide_dma_intr+0x0/0xba
[<c010c279>] handle_IRQ_event+0x3c/0xfd
[<c010c48f>] do_IRQ+0x80/0xd6
[<c0108be9>] default_idle+0x0/0x2c
[<c0108be9>] default_idle+0x0/0x2c
[<c010acd4>] common_interrupt+0x18/0x20
[<c0108be9>] default_idle+0x0/0x2c
[<c0108be9>] default_idle+0x0/0x2c
[<c0108c10>] default_idle+0x27/0x2c
[<c0108c81>] cpu_idle+0x31/0x3a
[<c0105000>] _stext+0x0/0x2a
[<c036c678>] start_kernel+0x152/0x177
[<c036c401>] unknown_bootoption+0x0/0xfa

Code: 0f 0b 91 00 85 96 2d c0 89 14 24 e8 7e c2 ee ff c7 06 00 00
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing




















Neil Brown wrote:

>On Thursday May 29, zwane@linuxpower.ca wrote:
>  
>
>>How does the following patch look for the double free.
>>
>>    
>>
>
>Thanks. It is a good start, but there are other problems with freeing
>things on error paths.   This patch should fix it all.
>
>NeilBrown
>
>--------------------------------------------
>Fix up freeing of kmalloc structures
>
>Some paths free things twice, others free un-initialised values :-(
>Not any more.
>
>
> ----------- Diffstat output ------------
> ./drivers/md/raid0.c |   17 ++++++++---------
> 1 files changed, 8 insertions(+), 9 deletions(-)
>
>diff ./drivers/md/raid0.c~current~ ./drivers/md/raid0.c
>--- ./drivers/md/raid0.c~current~	2003-05-30 11:40:06.000000000 +1000
>+++ ./drivers/md/raid0.c	2003-05-30 11:47:03.000000000 +1000
>@@ -85,10 +85,8 @@ static int create_strip_zones (mddev_t *
> 	conf->devlist = kmalloc(sizeof(mdk_rdev_t*)*
> 				conf->nr_strip_zones*mddev->raid_disks,
> 				GFP_KERNEL);
>-	if (!conf->devlist) {
>-		kfree(conf);
>+	if (!conf->devlist)
> 		return 1;
>-	}
> 
> 	memset(conf->strip_zone, 0,sizeof(struct strip_zone)*
> 				   conf->nr_strip_zones);
>@@ -235,6 +233,8 @@ static int raid0_run (mddev_t *mddev)
> 		goto out;
> 	mddev->private = (void *)conf;
>  
>+	mddev->strip_zone = NULL;
>+	mddev->devlist = NULL;
> 	if (create_strip_zones (mddev)) 
> 		goto out_free_conf;
> 
>@@ -273,7 +273,7 @@ static int raid0_run (mddev_t *mddev)
> 				nb_zone*sizeof(struct strip_zone*));
> 	conf->hash_table = kmalloc (sizeof (struct strip_zone *)*nb_zone, GFP_KERNEL);
> 	if (!conf->hash_table)
>-		goto out_free_zone_conf;
>+		goto out_free_conf;
> 	size = conf->strip_zone[cur].size;
> 
> 	for (i=0; i< nb_zone; i++) {
>@@ -296,12 +296,11 @@ static int raid0_run (mddev_t *mddev)
> 	blk_queue_merge_bvec(&mddev->queue, raid0_mergeable_bvec);
> 	return 0;
> 
>-out_free_zone_conf:
>-	kfree(conf->strip_zone);
>-	conf->strip_zone = NULL;
>-
> out_free_conf:
>-	kfree (conf->devlist);
>+	if (conf->strip_zone)
>+		kfree(conf->strip_zone);
>+	if (conf->devlist)
>+		kfree (conf->devlist);
> 	kfree(conf);
> 	mddev->private = NULL;
> out:
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

