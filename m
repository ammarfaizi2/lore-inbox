Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTFKCQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTFKCQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:16:14 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:6784
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264037AbTFKCQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:16:09 -0400
Date: Tue, 10 Jun 2003 22:18:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH][2.5] Fix raid0 init failure
Message-ID: <Pine.LNX.4.50.0306102154210.19137-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

create_strip_zone was accessing uninitialised data via 
zone->dev = conf->devlist 

Tested on a 2disk SCSI Raid0

BEFORE:
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdf1
raid0:   comparing sdf1(4193152) with sdf1(4193152)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdc1
raid0:   comparing sdc1(4193152) with sdf1(4193152)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: multiple devices for 1 - aborting!
md: pers->run() failed ...
md :do_md_run() returned -22
md: md0 stopped.
md: unbind<sdf1>
md: export_rdev(sdf1)
md: unbind<sdc1>
md: export_rdev(sdc1)
md: ... autorun DONE.

AFTER:
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdf1
raid0:   comparing sdf1(4193152) with sdf1(4193152)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdc1
raid0:   comparing sdc1(4193152) with sdf1(4193152)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 8386304 blocks.
raid0 : conf->hash_spacing is 8386304 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: ... autorun DONE.

Index: linux-2.5/drivers/md/raid0.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/md/raid0.c,v
retrieving revision 1.32
diff -u -p -B -r1.32 raid0.c
--- linux-2.5/drivers/md/raid0.c	5 Jun 2003 06:30:06 -0000	1.32
+++ linux-2.5/drivers/md/raid0.c	11 Jun 2003 00:51:30 -0000
@@ -90,6 +90,10 @@ static int create_strip_zones (mddev_t *
 
 	memset(conf->strip_zone, 0,sizeof(struct strip_zone)*
 				   conf->nr_strip_zones);
+
+	memset(conf->devlist, 0, sizeof (mdk_rdev_t*)*
+		conf->nr_strip_zones*mddev->raid_disks);
+
 	/* The first zone must contain all devices, so here we check that
 	 * there is a proper alignment of slots to devices and find them all
 	 */
-- 
function.linuxpower.ca
