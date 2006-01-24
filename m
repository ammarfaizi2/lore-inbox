Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWAXD6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWAXD6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWAXD6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:58:51 -0500
Received: from ns2.suse.de ([195.135.220.15]:18870 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964990AbWAXD6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:58:48 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 24 Jan 2006 14:58:42 +1100
Message-Id: <1060124035842.28869@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 5] md: Make sure QUEUE_FLAG_CLUSTER is set properly for md.
References: <20060124145516.28734.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This flag should be set for a virtual device iff it is set
for all underlying devices.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./block/ll_rw_blk.c |    2 ++
 ./drivers/md/md.c   |    1 +
 2 files changed, 3 insertions(+)

diff ./block/ll_rw_blk.c~current~ ./block/ll_rw_blk.c
--- ./block/ll_rw_blk.c~current~	2006-01-24 14:54:19.000000000 +1100
+++ ./block/ll_rw_blk.c	2006-01-24 14:54:19.000000000 +1100
@@ -778,6 +778,8 @@ void blk_queue_stack_limits(request_queu
 	t->max_hw_segments = min(t->max_hw_segments,b->max_hw_segments);
 	t->max_segment_size = min(t->max_segment_size,b->max_segment_size);
 	t->hardsect_size = max(t->hardsect_size,b->hardsect_size);
+	if (!test_bit(QUEUE_FLAG_CLUSTER, &b->queue_flags))
+		clear_bit(QUEUE_FLAG_CLUSTER, &t->queue_flags);
 }
 
 EXPORT_SYMBOL(blk_queue_stack_limits);

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-01-24 14:47:17.000000000 +1100
+++ ./drivers/md/md.c	2006-01-24 14:54:19.000000000 +1100
@@ -264,6 +264,7 @@ static mddev_t * mddev_find(dev_t unit)
 		kfree(new);
 		return NULL;
 	}
+	set_bit(QUEUE_FLAG_CLUSTER, &new->queue->queue_flags);
 
 	blk_queue_make_request(new->queue, md_fail_request);
 
