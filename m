Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933230AbWFZXbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230AbWFZXbF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933252AbWFZXbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:31:02 -0400
Received: from dh134.citi.umich.edu ([141.211.133.134]:444 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S933187AbWFZXaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:30:04 -0400
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH 1/5] VFS: Allow caller to determine if BSD or posix locks were actually freed
Date: Mon, 26 Jun 2006 19:30:04 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20060626233004.6059.27511.stgit@lade.trondhjem.org>
In-Reply-To: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
References: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

Change posix_lock_file_conf(), and flock_lock_file() so that if called
with an F_UNLCK argument, and the FL_EXISTS flag they will indicate
whether or not any locks were actually freed by returning 0 or -ENOENT.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/locks.c         |   18 ++++++++++++++++--
 include/linux/fs.h |    1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1ad29c9..50cb0a2 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -725,6 +725,10 @@ next_task:
 /* Try to create a FLOCK lock on filp. We always insert new FLOCK locks
  * at the head of the list, but that's secret knowledge known only to
  * flock_lock_file and posix_lock_file.
+ *
+ * Note that if called with an FL_EXISTS argument, the caller may determine
+ * whether or not a lock was successfully freed by testing the return
+ * value for -ENOENT.
  */
 static int flock_lock_file(struct file *filp, struct file_lock *request)
 {
@@ -750,8 +754,11 @@ static int flock_lock_file(struct file *
 		break;
 	}
 
-	if (request->fl_type == F_UNLCK)
+	if (request->fl_type == F_UNLCK) {
+		if ((request->fl_flags & FL_EXISTS) && !found)
+			error = -ENOENT;
 		goto out;
+	}
 
 	error = -ENOMEM;
 	new_fl = locks_alloc_lock();
@@ -948,8 +955,11 @@ static int __posix_lock_file_conf(struct
 
 	error = 0;
 	if (!added) {
-		if (request->fl_type == F_UNLCK)
+		if (request->fl_type == F_UNLCK) {
+			if (request->fl_flags & FL_EXISTS)
+				error = -ENOENT;
 			goto out;
+		}
 
 		if (!new_fl) {
 			error = -ENOLCK;
@@ -996,6 +1006,10 @@ static int __posix_lock_file_conf(struct
  * Add a POSIX style lock to a file.
  * We merge adjacent & overlapping locks whenever possible.
  * POSIX locks are sorted by owner task, then by starting address
+ *
+ * Note that if called with an FL_EXISTS argument, the caller may determine
+ * whether or not a lock was successfully freed by testing the return
+ * value for -ENOENT.
  */
 int posix_lock_file(struct file *filp, struct file_lock *fl)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2d8b348..31b1f6f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -682,6 +682,7 @@ #endif
 #define FL_POSIX	1
 #define FL_FLOCK	2
 #define FL_ACCESS	8	/* not trying to lock, just looking */
+#define FL_EXISTS	16	/* when unlocking, test for existence */
 #define FL_LEASE	32	/* lease held on this file */
 #define FL_CLOSE	64	/* unlock on close */
 #define FL_SLEEP	128	/* A blocking lock */
