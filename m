Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbTLVRmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 12:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTLVRmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 12:42:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:57035 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264457AbTLVRmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 12:42:38 -0500
Subject: [PATCH] Another dm and bio problem with 2.6.0
From: Mark Haverkamp <markh@osdl.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1072114957.15546.23.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 22 Dec 2003 09:42:37 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a problem similar to the patch I submitted on 11/20

http://marc.theaimsgroup.com/?l=linux-kernel&m=106936439707962&w=2

In this case, though, the result is an:

"Incorrect number of segments after building list" message.

The macro __BVEC_START assumes a bi_idx of zero when the dm code can
submit a bio with a non-zero bi_idx.  
The code has been tested on an 8 way / 8gb OSDL STP machine with a 197G
lvm volume running dbt2 test.

===== include/linux/bio.h 1.34 vs edited =====
--- 1.34/include/linux/bio.h	Sun Sep 21 14:50:33 2003
+++ edited/include/linux/bio.h	Wed Dec 17 07:17:53 2003
@@ -162,7 +162,7 @@
  */
 
 #define __BVEC_END(bio)		bio_iovec_idx((bio), (bio)->bi_vcnt - 1)
-#define __BVEC_START(bio)	bio_iovec_idx((bio), 0)
+#define __BVEC_START(bio)	bio_iovec_idx((bio), (bio)->bi_idx)
 #define BIOVEC_PHYS_MERGEABLE(vec1, vec2)	\
 	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
 #define BIOVEC_VIRT_MERGEABLE(vec1, vec2)	\
 
-- 
Mark Haverkamp <markh@osdl.org>

