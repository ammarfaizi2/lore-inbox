Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWINVqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWINVqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWINVqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:46:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751194AbWINVqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:46:32 -0400
Date: Thu, 14 Sep 2006 22:46:24 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 13/25] dm mpath: tidy ctr
Message-ID: <20060914214624.GU3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

After initialising m->ti, there's no need to pass it in subsequent calls
to static functions used for parsing parameters.

Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-mpath.c	2006-09-14 20:20:55.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-mpath.c	2006-09-14 20:54:49.000000000 +0100
@@ -168,7 +168,7 @@ static void free_priority_group(struct p
 	kfree(pg);
 }
 
-static struct multipath *alloc_multipath(void)
+static struct multipath *alloc_multipath(struct dm_target *ti)
 {
 	struct multipath *m;
 
@@ -185,6 +185,8 @@ static struct multipath *alloc_multipath
 			kfree(m);
 			return NULL;
 		}
+		m->ti = ti;
+		ti->private = m;
 	}
 
 	return m;
@@ -557,8 +559,7 @@ static struct pgpath *parse_path(struct 
 }
 
 static struct priority_group *parse_priority_group(struct arg_set *as,
-						   struct multipath *m,
-						   struct dm_target *ti)
+						   struct multipath *m)
 {
 	static struct param _params[] = {
 		{1, 1024, "invalid number of paths"},
@@ -568,6 +569,7 @@ static struct priority_group *parse_prio
 	int r;
 	unsigned i, nr_selector_args, nr_params;
 	struct priority_group *pg;
+	struct dm_target *ti = m->ti;
 
 	if (as->argc < 2) {
 		as->argc = 0;
@@ -624,12 +626,12 @@ static struct priority_group *parse_prio
 	return NULL;
 }
 
-static int parse_hw_handler(struct arg_set *as, struct multipath *m,
-			    struct dm_target *ti)
+static int parse_hw_handler(struct arg_set *as, struct multipath *m)
 {
 	int r;
 	struct hw_handler_type *hwht;
 	unsigned hw_argc;
+	struct dm_target *ti = m->ti;
 
 	static struct param _params[] = {
 		{0, 1024, "invalid number of hardware handler args"},
@@ -661,11 +663,11 @@ static int parse_hw_handler(struct arg_s
 	return 0;
 }
 
-static int parse_features(struct arg_set *as, struct multipath *m,
-			  struct dm_target *ti)
+static int parse_features(struct arg_set *as, struct multipath *m)
 {
 	int r;
 	unsigned argc;
+	struct dm_target *ti = m->ti;
 
 	static struct param _params[] = {
 		{0, 1, "invalid number of feature args"},
@@ -704,19 +706,17 @@ static int multipath_ctr(struct dm_targe
 	as.argc = argc;
 	as.argv = argv;
 
-	m = alloc_multipath();
+	m = alloc_multipath(ti);
 	if (!m) {
 		ti->error = "can't allocate multipath";
 		return -EINVAL;
 	}
 
-	m->ti = ti;
-
-	r = parse_features(&as, m, ti);
+	r = parse_features(&as, m);
 	if (r)
 		goto bad;
 
-	r = parse_hw_handler(&as, m, ti);
+	r = parse_hw_handler(&as, m);
 	if (r)
 		goto bad;
 
@@ -732,7 +732,7 @@ static int multipath_ctr(struct dm_targe
 	while (as.argc) {
 		struct priority_group *pg;
 
-		pg = parse_priority_group(&as, m, ti);
+		pg = parse_priority_group(&as, m);
 		if (!pg) {
 			r = -EINVAL;
 			goto bad;
@@ -752,8 +752,6 @@ static int multipath_ctr(struct dm_targe
 		goto bad;
 	}
 
-	ti->private = m;
-
 	return 0;
 
  bad:
