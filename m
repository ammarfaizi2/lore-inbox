Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUFGUnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUFGUnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 16:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbUFGUnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 16:43:40 -0400
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:13197 "EHLO
	rtp-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S265048AbUFGUnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 16:43:32 -0400
X-BrightmailFiltered: true
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>, James Morris <jmorris@redhat.com>
Subject: [PATCH] Fix Crypto digest.c kmapping sg entries > page in length
References: <Xine.LNX.4.44.0406041921180.14838-100000@thoron.boston.redhat.com>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Date: Mon, 07 Jun 2004 15:43:27 -0500
In-Reply-To: <Xine.LNX.4.44.0406041921180.14838-100000@thoron.boston.redhat.com>
	(James Morris's message of "Fri, 4 Jun 2004 19:21:30 -0400 (EDT)")
Message-ID: <yqujwu2jm74g.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the patch, against 2.6.7-rc2, to fix crypto/digest.c to do
multiple kmap()/kunmap() for scatterlist entries which have a size
greater than a single page, originally found and fixed by
N.C.Krishna Murthy <krmurthy@cisco.com>.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
"We're serious about this campaign now!  The training wheels are coming off!"
   - a high White Horse Souse

Signed-off-by: Clay Haapala <chaapala@cisco.com>

diff -uNr --exclude=SCCS --exclude '*.mod.c' --exclude='*.o' --exclude='*.ko' --exclude '.*' linux-2.6.6-bk.orig/crypto/digest.c linux-2.6.6-bk/crypto/digest.c
--- linux-2.6.6-bk.orig/crypto/digest.c	2004-06-07 10:58:36.000000000 -0500
+++ linux-2.6.6-bk/crypto/digest.c	2004-06-07 15:21:05.000000000 -0500
@@ -27,13 +27,28 @@
                    struct scatterlist *sg, unsigned int nsg)
 {
 	unsigned int i;
-	
+
 	for (i = 0; i < nsg; i++) {
-		char *p = crypto_kmap(sg[i].page, 0) + sg[i].offset;
-		tfm->__crt_alg->cra_digest.dia_update(crypto_tfm_ctx(tfm),
-		                                      p, sg[i].length);
-		crypto_kunmap(p, 0);
-		crypto_yield(tfm);
+
+		struct page *pg = sg[i].page;
+		unsigned int offset = sg[i].offset;
+		unsigned int l = sg[i].length;
+
+		do {
+			unsigned int bytes_from_page = min(l, ((unsigned int)
+							   (PAGE_SIZE)) - 
+							   offset);
+			char *p = crypto_kmap(pg, 0) + offset;
+
+			tfm->__crt_alg->cra_digest.dia_update
+					(crypto_tfm_ctx(tfm), p,
+					 bytes_from_page);
+			crypto_kunmap(p, 0);
+			crypto_yield(tfm);
+			offset = 0;
+			pg++;
+			l -= bytes_from_page;
+		} while (l > 0);
 	}
 }
 

