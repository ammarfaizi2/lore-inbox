Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129081AbQKAMFy>; Wed, 1 Nov 2000 07:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbQKAMFf>; Wed, 1 Nov 2000 07:05:35 -0500
Received: from mons.uio.no ([129.240.130.14]:31155 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129081AbQKAMFQ>;
	Wed, 1 Nov 2000 07:05:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14848.1767.586244.448799@charged.uio.no>
Date: Wed, 1 Nov 2000 13:04:55 +0100 (CET)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.0-pre10: svclock: missing unlock_kernel()
X-Mailer: VM 6.71 under 21.1 (patch 3) "Acadia" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

  I missed a conditional return in nlmsvc_notify_blocked() when we
should be releasing the BKL. Thanks to Jim Castleberry for pointing it 
out.

  Please note, however, that there remain serious bugs in 2.4.0-pre10
fs/locks.c w.r.t. notification of the filesystem/lockd that need to be
fixed before the 2.4.0 release.

Cheers,
  Trond


--- fs/lockd/svclock.c.orig	Tue Oct 31 00:31:49 2000
+++ fs/lockd/svclock.c	Wed Nov  1 12:57:25 2000
@@ -473,6 +473,7 @@
 		if (nlm_compare_locks(&block->b_call.a_args.lock.fl, fl)) {
 			nlmsvc_insert_block(block, 0);
 			svc_wake_up(block->b_daemon);
+			unlock_kernel();
 			return;
 		}
 	}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
