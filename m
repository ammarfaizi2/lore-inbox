Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSIZSnA>; Thu, 26 Sep 2002 14:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261444AbSIZSnA>; Thu, 26 Sep 2002 14:43:00 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:40175 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261442AbSIZSm5>; Thu, 26 Sep 2002 14:42:57 -0400
Message-ID: <3D935665.9EC43A6D@austin.ibm.com>
Date: Thu, 26 Sep 2002 13:48:05 -0500
From: Saurabh Desai <sdesai@austin.ibm.com>
Organization: IBM Corporation
X-Mailer: Mozilla 4.7 [en] (X11; U; AIX 4.3)
X-Accept-Language: en-US,en-GB
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-flock-2.5.38-A3
References: <Pine.LNX.4.44.0209251030170.5122-100000@localhost.localdomain>
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> Ulrich found another small detail wrt. POSIX requirements for threads -
> this time it's the recursion features (read-held lock being write-locked
> means an upgrade if the same 'process' is the owner, means a deadlock if a
> different 'process').
> 
 
I had submitted same patch on May,31st and got the following
response from Matthew Wilcox. Removing the pid check from the
locks_same_owner() will fix this problem.

==================== Matthew Wilcox's response ====================
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
--- 1.9/fs/locks.c      Mon Jun  3 18:49:43 2002
+++ edited/fs/locks.c   Fri Jun  7 21:24:12 2002
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
-       return (fl1->fl_owner == fl2->fl_owner) &&
-              (fl1->fl_pid   == fl2->fl_pid);
+       return (fl1->fl_owner == fl2->fl_owner);
 }
 
 /* Remove waiter from blocker's block list.
