Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWCYEbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWCYEbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWCYEbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:31:34 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:64956
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750843AbWCYE2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:28:01 -0500
Date: Fri, 24 Mar 2006 20:27:38 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, abhishekgupt@gmail.com,
       danms@us.ibm.com, agk@redhat.com, Chris Wright <chrisw@sous-sol.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/20] dm: bio split bvec fix
Message-ID: <20060325042738.GO21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-bio-split-bvec-fix.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Alasdair G Kergon <agk@redhat.com>

The code that handles bios that span table target boundaries by breaking
them up into smaller bios will not split an individual struct bio_vec into
more than two pieces.  Sometimes more than that are required.

This patch adds a loop to break the second piece up into as many pieces as
are necessary.

Cc: "Abhishek Gupta" <abhishekgupt@gmail.com>
Cc: Dan Smith <danms@us.ibm.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/md/dm.c |   45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

--- linux-2.6.16.orig/drivers/md/dm.c
+++ linux-2.6.16/drivers/md/dm.c
@@ -533,30 +533,35 @@ static void __clone_and_map(struct clone
 
 	} else {
 		/*
-		 * Create two copy bios to deal with io that has
-		 * been split across a target.
+		 * Handle a bvec that must be split between two or more targets.
 		 */
 		struct bio_vec *bv = bio->bi_io_vec + ci->idx;
+		sector_t remaining = to_sector(bv->bv_len);
+		unsigned int offset = 0;
 
-		clone = split_bvec(bio, ci->sector, ci->idx,
-				   bv->bv_offset, max);
-		__map_bio(ti, clone, tio);
-
-		ci->sector += max;
-		ci->sector_count -= max;
-		ti = dm_table_find_target(ci->map, ci->sector);
-
-		len = to_sector(bv->bv_len) - max;
-		clone = split_bvec(bio, ci->sector, ci->idx,
-				   bv->bv_offset + to_bytes(max), len);
-		tio = alloc_tio(ci->md);
-		tio->io = ci->io;
-		tio->ti = ti;
-		memset(&tio->info, 0, sizeof(tio->info));
-		__map_bio(ti, clone, tio);
+		do {
+			if (offset) {
+				ti = dm_table_find_target(ci->map, ci->sector);
+				max = max_io_len(ci->md, ci->sector, ti);
+
+				tio = alloc_tio(ci->md);
+				tio->io = ci->io;
+				tio->ti = ti;
+				memset(&tio->info, 0, sizeof(tio->info));
+			}
+
+			len = min(remaining, max);
+
+			clone = split_bvec(bio, ci->sector, ci->idx,
+					   bv->bv_offset + offset, len);
+
+			__map_bio(ti, clone, tio);
+
+			ci->sector += len;
+			ci->sector_count -= len;
+			offset += to_bytes(len);
+		} while (remaining -= len);
 
-		ci->sector += len;
-		ci->sector_count -= len;
 		ci->idx++;
 	}
 }

--
