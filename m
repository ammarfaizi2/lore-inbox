Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTJIBwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 21:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTJIBwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 21:52:43 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:53386 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261873AbTJIBwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 21:52:41 -0400
Date: Thu, 9 Oct 2003 02:52:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] set sigio target to current->pid and only if not already set
Message-ID: <20031009015232.GA18112@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch: f_setown-2.6.0-test6.patch

Dear Linus,

Two minor changes:

1. send_sigio() sends to a specific thread, _not_ a process.
   (It can also send to a process group, but that's not relevant here).
   This is useful, and should stay as it is.

   Therefore it makes _no sense_ to call f_setown() with current->tgid.
   Presently the kernel is inconsistent about it, with some places using
   current->pid and some others using current->tgid.

   This patch changes f_setown() calls to use current->pid.

2. In some places, f_setown() is called not at the user's direct request,
   but as a side effect of another function.  Specifically: dnotify and
   file leases.

   It is good to allow a program the flexibility to specify a different
   pid than the default, using F_SETOWN.  Presently they can do this after
   the dnotify or lease call, but there is a small time window when it
   will be temporarily set to current->tgid (which as pointed out above,
   is not always right).

   The window is avoidable if the program can use F_SETOWN prior to the
   dnotify or lease call.  This is exactly what the "force" argument to
   f_setown() is for, and this patch changes it to zero in those callers.

   This change is not likely to affect any existing programs.

Please apply.

-- Jamie

diff -urN --exclude-from=dontdiff orig-2.6.0-test6/fs/dnotify.c f_setown-2.6.0-test6/fs/dnotify.c
--- orig-2.6.0-test6/fs/dnotify.c	2003-09-13 21:21:25.000000000 +0100
+++ f_setown-2.6.0-test6/fs/dnotify.c	2003-10-09 01:49:13.000000000 +0100
@@ -92,7 +92,7 @@
 		prev = &odn->dn_next;
 	}
 
-	error = f_setown(filp, current->tgid, 1);
+	error = f_setown(filp, current->pid, 0);
 	if (error)
 		goto out_free;
 
diff -urN --exclude-from=dontdiff orig-2.6.0-test6/fs/locks.c f_setown-2.6.0-test6/fs/locks.c
--- orig-2.6.0-test6/fs/locks.c	2003-09-30 05:40:50.000000000 +0100
+++ f_setown-2.6.0-test6/fs/locks.c	2003-10-09 01:49:37.000000000 +0100
@@ -1268,7 +1268,7 @@
 
 	locks_insert_lock(before, fl);
 
-	error = f_setown(filp, current->tgid, 1);
+	error = f_setown(filp, current->pid, 0);
 out_unlock:
 	unlock_kernel();
 	return error;
diff -urN --exclude-from=dontdiff orig-2.6.0-test6/kernel/futex.c f_setown-2.6.0-test6/kernel/futex.c
--- orig-2.6.0-test6/kernel/futex.c	2003-09-30 05:41:14.000000000 +0100
+++ f_setown-2.6.0-test6/kernel/futex.c	2003-10-09 01:52:37.000000000 +0100
@@ -500,7 +500,7 @@
 
 	if (signal) {
 		int err;
-		err = f_setown(filp, current->tgid, 1);
+		err = f_setown(filp, current->pid, 1);
 		if (err < 0) {
 			put_unused_fd(ret);
 			put_filp(filp);
