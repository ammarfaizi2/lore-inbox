Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTKMDGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 22:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTKMDGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 22:06:46 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:10368
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S261411AbTKMDGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 22:06:44 -0500
Date: Wed, 12 Nov 2003 22:06:27 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jariruusu@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
Message-ID: <20031113030626.GA5143@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@paranoiacs.org>,
	Andrew Morton <akpm@osdl.org>, jariruusu@users.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20031030134137.GD12147@fukurou.paranoiacs.org> <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <20031031005246.GE12147@fukurou.paranoiacs.org> <20031031015500.44a94f88.akpm@osdl.org> <20031031015559.6239a4a4.akpm@osdl.org> <20031031015818.446e4f5a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20031031015818.446e4f5a.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

One more patch --- this fixes a minor bio handling bug in the filebacked
code path. I'd fixed it incidentally in the loop-recycle patch.

I don't think you could actually see damage from this bug unless you
run device mapper on top of loop devices, but still this is the correct
behavior. Please apply.

This should also apply cleanly over 2.6.0-test9-mm2.

-
-Ben


-- 
Ben Slusky                      | I'm amazed that I'm still
sluskyb@paranoiacs.org          | standing and I demand that we
sluskyb@stwing.org              | all blend in
PGP keyID ADA44B3B              |               -Foo Fighters

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-bio-index.diff"

--- linux-2.6.0-test9-akpm/drivers/block/loop.c	2003-11-08 19:28:07.000000000 -0500
+++ linux-2.6.0-test9-sluskyb/drivers/block/loop.c	2003-11-08 19:14:41.000000000 -0500
@@ -264,12 +264,10 @@ fail:
 static int
 lo_send(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
 {
-	unsigned vecnr;
-	int ret = 0;
-
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+	struct bio_vec *bvec;
+	int i, ret = 0;
 
+	bio_for_each_segment(bvec, bio, i) {
 		ret = do_lo_send(lo, bvec, bsize, pos);
 		if (ret < 0)
 			break;
@@ -333,12 +331,10 @@ do_lo_receive(struct loop_device *lo,
 static int
 lo_receive(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
 {
-	unsigned vecnr;
-	int ret = 0;
-
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+	struct bio_vec *bvec;
+	int i, ret = 0;
 
+	bio_for_each_segment(bvec, bio, i) {
 		ret = do_lo_receive(lo, bvec, bsize, pos);
 		if (ret < 0)
 			break;

--7JfCtLOvnd9MIVvH--
