Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317909AbSGPRzY>; Tue, 16 Jul 2002 13:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317910AbSGPRzX>; Tue, 16 Jul 2002 13:55:23 -0400
Received: from mons.uio.no ([129.240.130.14]:45801 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317909AbSGPRzX>;
	Tue, 16 Jul 2002 13:55:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15668.24244.388876.990665@charged.uio.no>
Date: Tue, 16 Jul 2002 19:58:12 +0200
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix bug in xdr_kunmap() (resend)
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  The following patch fixes a bug in xdr_kunmap() that has been known
to deadlock TCP mounts on highmem systems. It also removes an
unnecessary call to flush_page_to_ram().

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.25/net/sunrpc/xdr.c linux-2.5.25-fix_kmap/net/sunrpc/xdr.c
--- linux-2.5.25/net/sunrpc/xdr.c	Thu Jun  6 12:23:23 2002
+++ linux-2.5.25-fix_kmap/net/sunrpc/xdr.c	Tue Jul 16 18:47:07 2002
@@ -242,11 +242,11 @@
 		return;
 	if (base || xdr->page_base) {
 		pglen -= base;
+		base  += xdr->page_base;
 		ppage += base >> PAGE_CACHE_SHIFT;
 	}
 	for (;;) {
 		flush_dcache_page(*ppage);
-		flush_page_to_ram(*ppage);
 		kunmap(*ppage);
 		if (pglen <= PAGE_CACHE_SIZE)
 			break;

