Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263111AbTCYR3l>; Tue, 25 Mar 2003 12:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbTCYR2m>; Tue, 25 Mar 2003 12:28:42 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64379 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263124AbTCYR2b>; Tue, 25 Mar 2003 12:28:31 -0500
Date: Tue, 25 Mar 2003 17:39:40 GMT
Message-Id: <200303251739.h2PHdefs006912@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 6/8] 2.4: Fix jbd assert failure on IO error.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer_uptodate flag gets cleared on IO failure, and this can panic
jbd when it tries to write such a buffer.  Relax the panic to be just a
warning.

--- linux-2.4-ext3push/fs/jbd/transaction.c.=K0005=.orig	2003-03-25 10:59:15.000000000 +0000
+++ linux-2.4-ext3push/fs/jbd/transaction.c	2003-03-25 10:59:15.000000000 +0000
@@ -739,7 +739,8 @@ done_locked:
 		int offset;
 		char *source;
 
-		J_ASSERT_JH(jh, buffer_uptodate(jh2bh(jh)));
+		J_EXPECT_JH(jh, buffer_uptodate(jh2bh(jh)),
+			    "Possible IO failure.\n");
 		page = jh2bh(jh)->b_page;
 		offset = ((unsigned long) jh2bh(jh)->b_data) & ~PAGE_MASK;
 		source = kmap(page);
