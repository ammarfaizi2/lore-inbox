Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272948AbTHEXr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 19:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272956AbTHEXr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 19:47:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:28819 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272948AbTHEXr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 19:47:28 -0400
Date: Tue, 5 Aug 2003 16:49:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: dick.streefland@xs4all.nl (Dick Streefland)
Cc: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] autofs4 doesn't expire
Message-Id: <20030805164904.36b5d2cc.akpm@osdl.org>
In-Reply-To: <4b0c.3f302ca5.93873@altium.nl>
References: <4b0c.3f302ca5.93873@altium.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spam@streefland.xs4all.nl (Dick Streefland) wrote:
>
> In linux-2.6.0-test1, lookup_mnt() was changed to increment the ref
> count of the returned vfsmount struct. This breaks expiration of
> autofs4 mounts, because lookup_mnt() is called in check_vfsmnt()
> without decrementing the ref count afterwards. The following patch
> fixes this:
> 

Neat, thanks.

Probably we should hold onto that ref because we play with the vfsmount
later on.  So something like this?


diff -puN fs/autofs4/expire.c~autofs4-expiry-fix fs/autofs4/expire.c
--- 25/fs/autofs4/expire.c~autofs4-expiry-fix	2003-08-05 16:44:41.000000000 -0700
+++ 25-akpm/fs/autofs4/expire.c	2003-08-05 16:48:20.000000000 -0700
@@ -25,7 +25,7 @@ static inline int is_vfsmnt_tree_busy(st
 	struct list_head *next;
 	int count;
 
-	count = atomic_read(&mnt->mnt_count) - 1;
+	count = atomic_read(&mnt->mnt_count) - 1 - 1;
 
 repeat:
 	next = this_parent->mnt_mounts.next;
@@ -70,8 +70,11 @@ static int check_vfsmnt(struct vfsmount 
 	int ret = dentry->d_mounted;
 	struct vfsmount *vfs = lookup_mnt(mnt, dentry);
 
-	if (vfs && is_vfsmnt_tree_busy(vfs))
-		ret--;
+	if (vfs) {
+		if (is_vfsmnt_tree_busy(vfs))
+			ret = 0;
+		mntput(vfs);
+	}
 	DPRINTK(("check_vfsmnt: ret=%d\n", ret));
 	return ret;
 }

_

