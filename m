Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267793AbTAHJvE>; Wed, 8 Jan 2003 04:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267786AbTAHJvB>; Wed, 8 Jan 2003 04:51:01 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:49938 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267785AbTAHJu2>; Wed, 8 Jan 2003 04:50:28 -0500
Date: Wed, 8 Jan 2003 09:58:39 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/10] dm: printk tgt->error if dm_table_add_target() fails.
Message-ID: <20030108095839.GH2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

printk tgt->error if dm_table_add_target() fails.
--- diff/drivers/md/dm-table.c	2003-01-02 11:26:35.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-01-02 11:26:53.000000000 +0000
@@ -578,9 +578,8 @@
 int dm_table_add_target(struct dm_table *t, const char *type,
 			sector_t start, sector_t len, char *params)
 {
-	int r, argc;
+	int r = -EINVAL, argc;
 	char *argv[32];
-	struct target_type *tt;
 	struct dm_target *tgt;
 
 	if ((r = check_space(t)))
@@ -589,14 +588,13 @@
 	tgt = t->targets + t->num_targets;
 	memset(tgt, 0, sizeof(*tgt));
 
-	tt = dm_get_target_type(type);
-	if (!tt) {
+	tgt->type = dm_get_target_type(type);
+	if (!tgt->type) {
 		tgt->error = "unknown target type";
-		return -EINVAL;
+		goto bad;
 	}
 
 	tgt->table = t;
-	tgt->type = tt;
 	tgt->begin = start;
 	tgt->len = len;
 	tgt->error = "Unknown error";
@@ -605,23 +603,19 @@
 	 * Does this target adjoin the previous one ?
 	 */
 	if (!adjoin(t, tgt)) {
-		DMERR("Gap in table");
-		dm_put_target_type(tt);
-		return -EINVAL;
+		tgt->error = "Gap in table";
+		goto bad;
 	}
 
 	r = split_args(ARRAY_SIZE(argv), &argc, argv, params);
 	if (r) {
 		tgt->error = "couldn't split parameters";
-		dm_put_target_type(tt);
-		return r;
+		goto bad;
 	}
 
-	r = tt->ctr(tgt, argc, argv);
-	if (r) {
-		dm_put_target_type(tt);
-		return r;
-	}
+	r = tgt->type->ctr(tgt, argc, argv);
+	if (r)
+		goto bad;
 
 	t->highs[t->num_targets++] = tgt->begin + tgt->len - 1;
 
@@ -629,6 +623,11 @@
 	 * the merge fn apply the target level restrictions. */
 	combine_restrictions_low(&t->limits, &tgt->limits);
 	return 0;
+
+ bad:
+	printk(KERN_ERR DM_NAME ": %s\n", tgt->error);
+	dm_put_target_type(tgt->type);
+	return r;
 }
 
 static int setup_indexes(struct dm_table *t)
