Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbUBZQkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUBZQkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:40:47 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:52126 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262826AbUBZQke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:40:34 -0500
Date: Thu, 26 Feb 2004 17:40:30 +0100
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2/2] dm-crypt end_io bv_offset fix
Message-ID: <20040226164029.GB12597@leto.cs.pocnet.net>
References: <20040226162324.GA12597@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226162324.GA12597@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should copy the bvec array for read requests so that we still
have the unmodified bvec array to decrypt the data afterwards.

(as discussed earlier this day for highmem bounces)

--- linux.orig/drivers/md/dm-crypt.c	2004-02-26 16:54:08.068578768 +0100
+++ linux/drivers/md/dm-crypt.c	2004-02-26 16:59:35.780758944 +0100
@@ -593,8 +593,21 @@
 				return NULL;
 			}
 		}
-	} else
-		clone = bio_clone(bio, GFP_NOIO);
+	} else {
+		/*
+		 * The block layer might modify the bvec array, so always
+		 * copy the required bvecs because we need the original
+		 * one in order to decrypt the whole bio data *afterwards*.
+		 */
+		clone = bio_alloc(GFP_NOIO, bio_segments(bio));
+		if (clone) {
+			clone->bi_idx = 0;
+			clone->bi_vcnt = bio_segments(bio);
+			clone->bi_size = bio->bi_size;
+			memcpy(clone->bi_io_vec, bio_iovec(bio),
+			       sizeof(struct bio_vec) * clone->bi_vcnt);
+		}
+	}
 
 	if (!clone)
 		return NULL;
