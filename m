Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSHOOyc>; Thu, 15 Aug 2002 10:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSHOOyc>; Thu, 15 Aug 2002 10:54:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44556 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317066AbSHOOyb>;
	Thu, 15 Aug 2002 10:54:31 -0400
Date: Thu, 15 Aug 2002 15:58:26 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH] lockd shouldn't call posix_unblock_lock here
Message-ID: <20020815155826.A29958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nlmsvc_notify_blocked() is only called via the fl_notify() pointer which
is only called immediately after we already did a locks_delete_block(),
so calling posix_unblock_lock() here is always a NOP.  Please apply.

diff -urpNX dontdiff linux-2.5.31/fs/lockd/svclock.c linux-2.5.31-willy/fs/lockd/svclock.c
--- linux-2.5.31/fs/lockd/svclock.c	2002-08-01 14:16:16.000000000 -0700
+++ linux-2.5.31-willy/fs/lockd/svclock.c	2002-08-15 07:32:19.000000000 -0700
@@ -472,7 +472,6 @@ nlmsvc_notify_blocked(struct file_lock *
 	struct nlm_block	**bp, *block;
 
 	dprintk("lockd: VFS unblock notification for block %p\n", fl);
-	posix_unblock_lock(fl);
 	for (bp = &nlm_blocked; (block = *bp); bp = &block->b_next) {
 		if (nlm_compare_locks(&block->b_call.a_args.lock.fl, fl)) {
 			nlmsvc_insert_block(block, 0);

-- 
Revolutions do not require corporate support.
