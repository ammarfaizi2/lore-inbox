Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbTAOWpj>; Wed, 15 Jan 2003 17:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbTAOWpj>; Wed, 15 Jan 2003 17:45:39 -0500
Received: from host217-35-54-97.in-addr.btopenworld.com ([217.35.54.97]:62848
	"EHLO dstc.edu.au") by vger.kernel.org with ESMTP
	id <S267370AbTAOWpi>; Wed, 15 Jan 2003 17:45:38 -0500
Message-Id: <200301152254.WAA19810@tereshkova.dstc.edu.au>
To: linux-kernel@vger.kernel.org
X-face: -[YGaR`*}M3pOPceHtP0Bb{\f!h4e?n{mXfI@DMKL-:8
Subject: [PATCH] counting bug in svc_tcp_recvfrom causes panic for TCP NFS
Date: Wed, 15 Jan 2003 22:54:32 +0000
From: Ted Phelps <phelps@dstc.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When svc_tcp_recvfrom() builds up its iovec to receive a packet, it
invokes page_address() with an argument which refers to
rqstp->rq_argused++.  For some memory layouts (eg not HIMEM and
not WANT_PAGE_VIRTUAL), page_address() is a macro which evalutes its
argument three times.  This results in a kernel panic when an TCP NFS
client sends a packet longer than about 1/3 of the maximum size.

The patch below causes the increment to be performed outside of the
call to page_address(), which avoids the kernel panic.  Perhaps a
better solution would be to change page_address() to be consistently
be a function for all memory layouts.

Thanks,
-Ted

--- ./linux-2.5.58-ORIG/net/sunrpc/svcsock.c	2003-01-13 22:30:06.000000000 +0000
+++ ./linux-2.5.58/net/sunrpc/svcsock.c	2003-01-15 22:42:03.000000000 +0000
@@ -924,8 +924,9 @@
 	vlen = PAGE_SIZE;
 	pnum = 1;
 	while (vlen < len) {
-		vec[pnum].iov_base = page_address(rqstp->rq_argpages[rqstp->rq_argused++]);
+		vec[pnum].iov_base = page_address(rqstp->rq_argpages[rqstp->rq_argused]);
 		vec[pnum].iov_len = PAGE_SIZE;
+		rqstp->rq_argused++;
 		pnum++;
 		vlen += PAGE_SIZE;
 	}
