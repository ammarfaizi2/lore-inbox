Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTAQLQy>; Fri, 17 Jan 2003 06:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbTAQLQy>; Fri, 17 Jan 2003 06:16:54 -0500
Received: from host217-39-53-31.in-addr.btopenworld.com ([217.39.53.31]:16769
	"EHLO dstc.edu.au") by vger.kernel.org with ESMTP
	id <S267494AbTAQLQx>; Fri, 17 Jan 2003 06:16:53 -0500
Message-Id: <200301171125.LAA13857@tereshkova.dstc.edu.au>
To: linux-kernel@vger.kernel.org
X-face: -[YGaR`*}M3pOPceHtP0Bb{\f!h4e?n{mXfI@DMKL-:8
Subject: [PATCH] 2.5.59 knfsd: bounds checking for NFSv3 readdirplus
Date: Fri, 17 Jan 2003 11:25:48 +0000
From: Ted Phelps <phelps@dstc.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For an NFSv3 readdirplus request, knfsd assumes that the outgoing
buffer will be less than a page in length but never checks to see if
this is true (readdir for both NFSv2 and NFSv3 do).  This can lead to
random pages getting trashed and failing NFS requests.

The patch below adds this check in a way which is consistent with the
way the readdir functions do.

Thanks,
-Ted

---8<---

diff -Naur linux-2.5.58-orig/fs/nfsd/nfs3xdr.c linux-2.5.58/fs/nfsd/nfs3xdr.c
--- linux-2.5.58-orig/fs/nfsd/nfs3xdr.c 2003-01-10 09:41:52.000000000 +0000
+++ linux-2.5.58/fs/nfsd/nfs3xdr.c      2003-01-14 19:57:03.000000000 +0000
@@ -578,6 +578,9 @@
        args->dircount = ntohl(*p++);
        args->count    = ntohl(*p++);
 
+       if (args->count > PAGE_SIZE)
+               args->count = PAGE_SIZE;
+
        svc_take_page(rqstp);
        args->buffer = page_address(rqstp->rq_respages[rqstp->rq_resused-1]);
