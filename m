Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSFJCso>; Sun, 9 Jun 2002 22:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316232AbSFJCso>; Sun, 9 Jun 2002 22:48:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32529 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316223AbSFJCsn>;
	Sun, 9 Jun 2002 22:48:43 -0400
Date: Mon, 10 Jun 2002 03:48:43 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvald@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Saurabh Desai <sdesai@austin.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/locks.c: Fix posix locking for threaded tasks
Message-ID: <20020610034843.W27186@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Saurabh Desai believes that locks created by threads should not conflict
with each other.  I'm inclined to agree; I don't know why the test for
->fl_pid was added, but the comment suggests that whoever added it wasn't
sure either.

Frankly, I have no clue about the intended semantics for threads, and
SUS v3 does not offer any enlightenment.  But it seems reasonable that
processes which share a files_struct should share locks.  After all,
if one process closes the fd, they'll remove locks belonging to the
other process.

Here's a patch generated against 2.4; it also applies to 2.5.
Please apply.

===== fs/locks.c 1.9 vs edited =====
--- 1.9/fs/locks.c	Mon Jun  3 18:49:43 2002
+++ edited/fs/locks.c	Fri Jun  7 21:24:12 2002
@@ -380,15 +380,12 @@
 }
 
 /*
- * Check whether two locks have the same owner
- * N.B. Do we need the test on PID as well as owner?
- * (Clone tasks should be considered as one "owner".)
+ * Locks are deemed to have the same owner if the tasks share files_struct.
  */
 static inline int
 locks_same_owner(struct file_lock *fl1, struct file_lock *fl2)
 {
-	return (fl1->fl_owner == fl2->fl_owner) &&
-	       (fl1->fl_pid   == fl2->fl_pid);
+	return (fl1->fl_owner == fl2->fl_owner);
 }
 
 /* Remove waiter from blocker's block list.

-- 
Revolutions do not require corporate support.
