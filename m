Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVF2HD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVF2HD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVF2HDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:03:25 -0400
Received: from verein.lst.de ([213.95.11.210]:6315 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262451AbVF2HDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:03:22 -0400
Date: Wed, 29 Jun 2005 09:03:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, zkambarov@coverity.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix Coverity braindamage in UDF
Message-ID: <20050629070309.GA18901@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please don't blindly apply Coverity patches.  While the checker
is smart at finding inconsistencies, that "obvious" fix is wrong most of
the item.  As in this unreviewed UDF patch that got in:
udf_find_entry can never be called with a NULL argument, so we shouldn't
check for it instead of adding more assignments behind the check.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/fs/udf/namei.c
===================================================================
--- linux-2.6.orig/fs/udf/namei.c	2005-06-29 08:56:02.000000000 +0200
+++ linux-2.6/fs/udf/namei.c	2005-06-29 08:59:25.000000000 +0200
@@ -153,24 +153,17 @@
 	struct fileIdentDesc *cfi)
 {
 	struct fileIdentDesc *fi=NULL;
-	loff_t f_pos;
+	loff_t f_pos = (udf_ext0_offset(dir) >> 2);
 	int block, flen;
 	char fname[UDF_NAME_LEN];
 	char *nameptr;
 	uint8_t lfi;
 	uint16_t liu;
-	loff_t size;
+	loff_t size = (udf_ext0_offset(dir) + dir->i_size) >> 2;
 	kernel_lb_addr bloc, eloc;
 	uint32_t extoffset, elen, offset;
 	struct buffer_head *bh = NULL;
 
-	if (!dir)
-		return NULL;
-
-	size = (udf_ext0_offset(dir) + dir->i_size) >> 2;
-
-	f_pos = (udf_ext0_offset(dir) >> 2);
-
 	fibh->soffset = fibh->eoffset = (f_pos & ((dir->i_sb->s_blocksize - 1) >> 2)) << 2;
 	if (UDF_I_ALLOCTYPE(dir) == ICBTAG_FLAG_AD_IN_ICB)
 		fibh->sbh = fibh->ebh = NULL;
