Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264316AbTKMP4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTKMP4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:56:07 -0500
Received: from ns.suse.de ([195.135.220.2]:54487 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264316AbTKMPzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:55:22 -0500
Subject: [PATCH] fs/ext[23]/xattr.c pointer arithmetic fix
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-qtAmwGO2E7mKcsWefnfs"
Organization: SuSE Labs, SuSE Linux AG
Message-Id: <1068738920.7227.43.camel@E136.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 13 Nov 2003 16:55:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qtAmwGO2E7mKcsWefnfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

we just found a 64-bit pointer arithmetic bug in the ext2 and ext3
extended attributes code. The fix is attached; could you please apply...


Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SuSE Labs, SuSE Linux AG <http://www.suse.de/>

--=-qtAmwGO2E7mKcsWefnfs
Content-Disposition: attachment; filename=xattr-pointer-arith
Content-Type: text/plain; name=xattr-pointer-arith; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

64-bit pointer arithmetic bug in xattr code

The int offset is not enought to hold the difference between
arbitraty pointers on 64-bit machines. Compute the offset of
here and last inside HDR(bh) instead.

Index: linux-2.6.0-test9/fs/ext2/xattr.c
===================================================================
--- linux-2.6.0-test9.orig/fs/ext2/xattr.c	2003-10-25 20:43:58.000000000 +0200
+++ linux-2.6.0-test9/fs/ext2/xattr.c	2003-11-13 14:31:02.649956273 +0100
@@ -617,9 +617,11 @@ bad_block:		ext2_error(sb, "ext2_xattr_s
 				goto cleanup;
 			memcpy(header, HDR(bh), bh->b_size);
 			header->h_refcount = cpu_to_le32(1);
-			offset = (char *)header - bh->b_data;
-			here = ENTRY((char *)here + offset);
-			last = ENTRY((char *)last + offset);
+
+			offset = (char *)here - bh->b_data;
+			here = ENTRY((char *)header + offset);
+			offset = (char *)last - bh->b_data;
+			last = ENTRY((char *)header + offset);
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */
Index: linux-2.6.0-test9/fs/ext3/xattr.c
===================================================================
--- linux-2.6.0-test9.orig/fs/ext3/xattr.c	2003-10-25 20:43:50.000000000 +0200
+++ linux-2.6.0-test9/fs/ext3/xattr.c	2003-11-13 14:31:23.932352979 +0100
@@ -629,9 +629,10 @@ bad_block:		ext3_error(sb, "ext3_xattr_s
 				goto cleanup;
 			memcpy(header, HDR(bh), bh->b_size);
 			header->h_refcount = cpu_to_le32(1);
-			offset = (char *)header - bh->b_data;
-			here = ENTRY((char *)here + offset);
-			last = ENTRY((char *)last + offset);
+			offset = (char *)here - bh->b_data;
+			here = ENTRY((char *)header + offset);
+			offset = (char *)last - bh->b_data;
+			last = ENTRY((char *)header + offset);
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */

--=-qtAmwGO2E7mKcsWefnfs--

