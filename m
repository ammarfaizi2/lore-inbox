Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUBTPm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUBTPle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:41:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10667 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261296AbUBTPgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:36:52 -0500
Date: Fri, 20 Feb 2004 15:39:57 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 4/6] dm: default queue limits
Message-ID: <20040220153957.GU27549@reti>
References: <20040220153145.GN27549@reti> <20040220153615.GR27549@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220153615.GR27549@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fill in missing queue limitations when table is complete instead of
enforcing the "default" limits on every dm device.
Problem noticed by Mike Christie.

[Christophe Saout]
--- diff/drivers/md/dm-table.c	2004-02-18 15:38:06.000000000 +0000
+++ source/drivers/md/dm-table.c	2004-02-18 15:40:07.000000000 +0000
@@ -629,14 +629,20 @@ static int split_args(int *argc, char **
 	return 0;
 }
 
-static void set_default_limits(struct io_restrictions *rs)
+static void check_for_valid_limits(struct io_restrictions *rs)
 {
-	rs->max_sectors = MAX_SECTORS;
-	rs->max_phys_segments = MAX_PHYS_SEGMENTS;
-	rs->max_hw_segments = MAX_HW_SEGMENTS;
-	rs->hardsect_size = 1 << SECTOR_SHIFT;
-	rs->max_segment_size = MAX_SEGMENT_SIZE;
-	rs->seg_boundary_mask = -1;
+	if (!rs->max_sectors)
+		rs->max_sectors = MAX_SECTORS;
+	if (!rs->max_phys_segments)
+		rs->max_phys_segments = MAX_PHYS_SEGMENTS;
+	if (!rs->max_hw_segments)
+		rs->max_hw_segments = MAX_HW_SEGMENTS;
+	if (!rs->hardsect_size)
+		rs->hardsect_size = 1 << SECTOR_SHIFT;
+	if (!rs->max_segment_size)
+		rs->max_segment_size = MAX_SEGMENT_SIZE;
+	if (!rs->seg_boundary_mask)
+		rs->seg_boundary_mask = -1;
 }
 
 int dm_table_add_target(struct dm_table *t, const char *type,
@@ -651,7 +657,6 @@ int dm_table_add_target(struct dm_table 
 
 	tgt = t->targets + t->num_targets;
 	memset(tgt, 0, sizeof(*tgt));
-	set_default_limits(&tgt->limits);
 
 	if (!len) {
 		tgt->error = "zero-length target";
@@ -736,6 +741,8 @@ int dm_table_complete(struct dm_table *t
 	int r = 0;
 	unsigned int leaf_nodes;
 
+	check_for_valid_limits(&t->limits);
+
 	/* how many indexes will the btree have ? */
 	leaf_nodes = dm_div_up(t->num_targets, KEYS_PER_NODE);
 	t->depth = 1 + int_log(leaf_nodes, CHILDREN_PER_NODE);
