Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030648AbWJKGJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030648AbWJKGJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWJKGJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:09:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:8650 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030648AbWJKGJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:09:33 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 11 Oct 2006 16:09:27 +1000
Message-Id: <1061011060927.12508@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 004 of 4] Avoid lockdep warning in md.
References: <20061011155522.7915.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


md_open takes ->reconfig_mutex which causes lockdep to complain.
This (normally) doesn't have deadlock potential as the possible
conflict is with a reconfig_mutex in a different device.

I say "normally" because if a loop were created in the array->member
hierarchy a deadlock could happen.  However that causes bigger
problems than a deadlock and should be fixed independently.

So we flag the lock in md_open as a nested lock.  This requires
defining mutex_lock_interruptible_nested.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c       |    2 +-
 ./include/linux/mutex.h |    2 ++
 ./kernel/mutex.c        |    9 +++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-10-11 15:53:48.000000000 +1000
+++ ./drivers/md/md.c	2006-10-11 15:42:09.000000000 +1000
@@ -4422,7 +4422,7 @@ static int md_open(struct inode *inode, 
 	mddev_t *mddev = inode->i_bdev->bd_disk->private_data;
 	int err;
 
-	if ((err = mddev_lock(mddev)))
+	if ((err = mutex_lock_interruptible_nested(&mddev->reconfig_mutex, 1)))
 		goto out;
 
 	err = 0;

diff .prev/include/linux/mutex.h ./include/linux/mutex.h
--- .prev/include/linux/mutex.h	2006-10-11 15:53:48.000000000 +1000
+++ ./include/linux/mutex.h	2006-10-11 15:43:22.000000000 +1000
@@ -125,8 +125,10 @@ extern int fastcall mutex_lock_interrupt
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
+extern int mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass);
 #else
 # define mutex_lock_nested(lock, subclass) mutex_lock(lock)
+# define mutex_lock_interruptible_nested(lock, subclass) mutex_lock_interruptible(lock)
 #endif
 
 /*

diff .prev/kernel/mutex.c ./kernel/mutex.c
--- .prev/kernel/mutex.c	2006-10-11 15:53:48.000000000 +1000
+++ ./kernel/mutex.c	2006-10-11 15:45:08.000000000 +1000
@@ -206,6 +206,15 @@ mutex_lock_nested(struct mutex *lock, un
 }
 
 EXPORT_SYMBOL_GPL(mutex_lock_nested);
+
+int __sched
+mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass)
+{
+	might_sleep();
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, subclass);
+}
+
+EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
 #endif
 
 /*
