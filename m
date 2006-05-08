Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWEHDel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWEHDel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 23:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWEHDel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 23:34:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932274AbWEHDek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 23:34:40 -0400
Date: Sun, 7 May 2006 20:34:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Hokka Zakrisson <daniel@hozac.com>
cc: linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0605072033530.3718@g5.osdl.org>
References: <445E80DD.9090507@hozac.com> <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1656112386-1147059272=:3718"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1656112386-1147059272=:3718
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sun, 7 May 2006, Linus Torvalds wrote:
> 
> Trond wrote an alternate patch for the actual problem which I sent 
> separately, but it would probably be good to have more safety in the slab 
> layer by default regardless.

And here's Trond's suggested locks.c fix.

		Linus

---
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: fs/locks.c: Fix lease_init
Date: Sun, 07 May 2006 23:02:42 -0400

It is insane to be giving lease_init() the task of freeing the lock it is
supposed to initialise, given that the lock is not guaranteed to be
allocated on the stack. This causes lockups in fcntl_setlease().
Problem diagnosed by Daniel Hokka Zakrisson <daniel@hozac.com>

Also fix a slab leak in __setlease() due to an uninitialised return value.
Problem diagnosed by Björn Steinbrink.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/locks.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index abd9448..64b96b1 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -446,15 +446,14 @@ static struct lock_manager_operations le
  */
 static int lease_init(struct file *filp, int type, struct file_lock *fl)
  {
+	if (assign_type(fl, type) != 0)
+		return -EINVAL;
+
 	fl->fl_owner = current->files;
 	fl->fl_pid = current->tgid;
 
 	fl->fl_file = filp;
 	fl->fl_flags = FL_LEASE;
-	if (assign_type(fl, type) != 0) {
-		locks_free_lock(fl);
-		return -EINVAL;
-	}
 	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_ops = NULL;
@@ -466,16 +465,19 @@ static int lease_init(struct file *filp,
 static int lease_alloc(struct file *filp, int type, struct file_lock **flp)
 {
 	struct file_lock *fl = locks_alloc_lock();
-	int error;
+	int error = -ENOMEM;
 
 	if (fl == NULL)
-		return -ENOMEM;
+		goto out;
 
 	error = lease_init(filp, type, fl);
-	if (error)
-		return error;
+	if (error) {
+		locks_free_lock(fl);
+		fl = NULL;
+	}
+out:
 	*flp = fl;
-	return 0;
+	return error;
 }
 
 /* Check if two locks overlap each other.
@@ -1391,6 +1393,7 @@ static int __setlease(struct file *filp,
 		goto out;
 
 	if (my_before != NULL) {
+		*flp = *my_before;
 		error = lease->fl_lmops->fl_change(my_before, arg);
 		goto out;
 	}

--21872808-1656112386-1147059272=:3718--
