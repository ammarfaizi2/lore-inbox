Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUHFVrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUHFVrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUHFVrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:47:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:27622 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266115AbUHFVrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:47:00 -0400
Subject: [PATCH] mpage_readpage unable to handle bigger requests
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ItlhabnZGiZx94LakW9S"
Organization: 
Message-Id: <1091828941.3641.404.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Aug 2004 17:49:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ItlhabnZGiZx94LakW9S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

I remember fixing this long time ago when we are playing we large
readhead testing. But I don't see the fix making into the tree.

The problem is, if we increase our readhead size arbitrarily 
(say 2M), we call mpage_readpages() with 2M and when it tries 
allocated bio enough to fit 2M it fails, then we kick it back
to "confused" code - which does 4K at a time.

Fix is to, ask for the maxium driver can handle.

Please include this patch.


Thanks,
Badari 



--=-ItlhabnZGiZx94LakW9S
Content-Disposition: attachment; filename=mpage_bio.patch
Content-Type: text/plain; name=mpage_bio.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux.org/fs/mpage.c	2004-08-07 02:15:12.962350304 -0700
+++ linux/fs/mpage.c	2004-08-07 02:17:55.765600448 -0700
@@ -290,7 +290,7 @@ do_mpage_readpage(struct bio *bio, struc
 alloc_new:
 	if (bio == NULL) {
 		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-					nr_pages, GFP_KERNEL);
+			  min(nr_pages, bio_get_nr_vecs(bdev)), GFP_KERNEL);
 		if (bio == NULL)
 			goto confused;
 	}

--=-ItlhabnZGiZx94LakW9S--

