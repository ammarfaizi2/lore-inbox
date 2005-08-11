Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVHKW6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVHKW6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVHKW6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:58:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23172 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932525AbVHKW6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:58:24 -0400
Message-Id: <20050811225633.103369000@localhost.localdomain>
References: <20050811225445.404816000@localhost.localdomain>
Date: Thu, 11 Aug 2005 15:54:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Tim Yamin <plasmaroo@gentoo.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "H. Peter Anvin" <hpa@zytor.com>, Chris Wright <chrisw@osdl.org>
Subject: [patch 5/8] Check input buffer size in zisofs
Content-Disposition: inline; filename=zisofs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------


It's not the real deflateBound() in newer zlib libraries, partly because
the upcoming usage of it won't have the "stream" available, so we can't
have the same interfaces anyway.

This uses the new deflateBound() thing to sanity-check the input to the
zlib decompressor before we even bother to start reading in the blocks.

Problem noted by Tim Yamin <plasmaroo@gentoo.org>

Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 fs/isofs/compress.c  |    6 ++++++
 include/linux/zlib.h |    5 +++++
 2 files changed, 11 insertions(+)

Index: linux-2.6.12.y/include/linux/zlib.h
===================================================================
--- linux-2.6.12.y.orig/include/linux/zlib.h
+++ linux-2.6.12.y/include/linux/zlib.h
@@ -506,6 +506,11 @@ extern int zlib_deflateReset (z_streamp 
    stream state was inconsistent (such as zalloc or state being NULL).
 */
 
+static inline unsigned long deflateBound(unsigned long s)
+{
+	return s + ((s + 7) >> 3) + ((s + 63) >> 6) + 11;
+}
+
 extern int zlib_deflateParams (z_streamp strm, int level, int strategy);
 /*
      Dynamically update the compression level and compression strategy.  The
Index: linux-2.6.12.y/fs/isofs/compress.c
===================================================================
--- linux-2.6.12.y.orig/fs/isofs/compress.c
+++ linux-2.6.12.y/fs/isofs/compress.c
@@ -129,8 +129,14 @@ static int zisofs_readpage(struct file *
 	cend = le32_to_cpu(*(__le32 *)(bh->b_data + (blockendptr & bufmask)));
 	brelse(bh);
 
+	if (cstart > cend)
+		goto eio;
+		
 	csize = cend-cstart;
 
+	if (csize > deflateBound(1UL << zisofs_block_shift))
+		goto eio;
+
 	/* Now page[] contains an array of pages, any of which can be NULL,
 	   and the locks on which we hold.  We should now read the data and
 	   release the pages.  If the pages are NULL the decompressed data

--
