Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSEFNSN>; Mon, 6 May 2002 09:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314439AbSEFNSM>; Mon, 6 May 2002 09:18:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32263 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314433AbSEFNSL>;
	Mon, 6 May 2002 09:18:11 -0400
Date: Mon, 6 May 2002 15:18:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: tcq problem details Re: vanilla 2.5.13 severe file system corruption experienced follozing e2fsck ...
Message-ID: <20020506131805.GA18817@suse.de>
In-Reply-To: <5.1.0.14.2.20020506093027.00aca720@pop.cus.cam.ac.uk> <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk> <20020505183451.98763.qmail@web14102.mail.yahoo.com> <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk> <5.1.0.14.2.20020506093027.00aca720@pop.cus.cam.ac.uk> <5.1.0.14.2.20020506105723.04138980@pop.cus.cam.ac.uk> <20020506121042.GP820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06 2002, Jens Axboe wrote:
> Agrh, that's a silly bug in blk_queue_init_tags(). Could you replace the
> memset() of tags->tag_index in there with something ala:

Brown paper bag time, this should make it work. Linus, please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.549   -> 1.550  
#	drivers/block/ll_rw_blk.c	1.64    -> 1.65   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/06	axboe@burns.home.kernel.dk	1.550
# Transposed the last two arguments to memset, causing a slab poisoned
# kernel not to use tagging correctly... Brown paper bag stuff.
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Mon May  6 15:17:09 2002
+++ b/drivers/block/ll_rw_blk.c	Mon May  6 15:17:09 2002
@@ -358,8 +358,8 @@
 	if (!tags->tag_map)
 		goto fail_map;
 
-	memset(tags->tag_index, depth * sizeof(struct request *), 0);
-	memset(tags->tag_map, bits * sizeof(unsigned long), 0);
+	memset(tags->tag_index, 0, depth * sizeof(struct request *));
+	memset(tags->tag_map, 0, bits * sizeof(unsigned long));
 	INIT_LIST_HEAD(&tags->busy_list);
 	tags->busy = 0;
 	tags->max_depth = depth;

-- 
Jens Axboe

