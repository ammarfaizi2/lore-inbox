Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbTANUkY>; Tue, 14 Jan 2003 15:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbTANUkY>; Tue, 14 Jan 2003 15:40:24 -0500
Received: from host217-35-54-97.in-addr.btopenworld.com ([217.35.54.97]:3968
	"EHLO dstc.edu.au") by vger.kernel.org with ESMTP
	id <S265270AbTANUkX>; Tue, 14 Jan 2003 15:40:23 -0500
Message-Id: <200301142049.UAA08659@tereshkova.dstc.edu.au>
To: linux-kernel@vger.kernel.org
X-face: -[YGaR`*}M3pOPceHtP0Bb{\f!h4e?n{mXfI@DMKL-:8
Subject: [PATCH] bounds checking for NFSv3 readdirplus
Date: Tue, 14 Jan 2003 20:49:12 +0000
From: Ted Phelps <phelps@dstc.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The NFSv3 readdirplus path doesn't check to see if maxcount is less
than the size of a page before it fills it up, possibly overwriting
random bits of memory.  At least, it makes my Solaris NFSv3 client
work.

The attached patch, against 2.5.58, adds this check in a way which is
consistent with the way readdir does under both NFSv2 andNFSv3.

Thanks,
-Ted

---8<---

diff -Naur linux-2.5.58-orig/fs/nfsd/nfs3xdr.c linux-2.5.58/fs/nfsd/nfs3xdr.c
--- linux-2.5.58-orig/fs/nfsd/nfs3xdr.c	2003-01-10 09:41:52.000000000 +0000
+++ linux-2.5.58/fs/nfsd/nfs3xdr.c	2003-01-14 19:57:03.000000000 +0000
@@ -578,6 +578,9 @@
 	args->dircount = ntohl(*p++);
 	args->count    = ntohl(*p++);
 
+	if (args->count > PAGE_SIZE)
+		args->count = PAGE_SIZE;
+
 	svc_take_page(rqstp);
 	args->buffer = page_address(rqstp->rq_respages[rqstp->rq_resused-1]);
 
