Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270562AbTGNICQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 04:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270563AbTGNICP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 04:02:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15514 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S270562AbTGNICL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 04:02:11 -0400
Date: Mon, 14 Jul 2003 13:40:01 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test1] vfsmount_lock-fix
Message-ID: <20030714081001.GD1214@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please apply this patch for replacing dcache_lock with vfsmount_lock in 
put_namespace(). This was one obvious thing for which I felt very bad to miss.
Tested with CLONE_NEWNS flag also.

Thanks
Maneesh


- fix put_namespace() in namespace.h (replace dcache_lock with vfsmount_lock)


 include/linux/namespace.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN include/linux/namespace.h~vfsmount_lock-fix include/linux/namespace.h
--- linux-2.6.0-test1/include/linux/namespace.h~vfsmount_lock-fix	2003-07-14 12:24:33.000000000 +0530
+++ linux-2.6.0-test1-maneesh/include/linux/namespace.h	2003-07-14 12:24:33.000000000 +0530
@@ -2,7 +2,7 @@
 #define _NAMESPACE_H_
 #ifdef __KERNEL__
 
-#include <linux/dcache.h>
+#include <linux/mount.h>
 #include <linux/sched.h>
 
 struct namespace {
@@ -19,9 +19,9 @@ static inline void put_namespace(struct 
 {
 	if (atomic_dec_and_test(&namespace->count)) {
 		down_write(&namespace->sem);
-		spin_lock(&dcache_lock);
+		spin_lock(&vfsmount_lock);
 		umount_tree(namespace->root);
-		spin_unlock(&dcache_lock);
+		spin_unlock(&vfsmount_lock);
 		up_write(&namespace->sem);
 		kfree(namespace);
 	}

_
-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
