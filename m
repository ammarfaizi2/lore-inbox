Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUD0R7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUD0R7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbUD0R7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:59:30 -0400
Received: from imap.gmx.net ([213.165.64.20]:51604 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264247AbUD0R5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:57:24 -0400
X-Authenticated: #1226656
Date: Tue, 27 Apr 2004 19:57:21 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Eric Sandeen <sandeen@sgi.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-xfs@oss.sgi.com,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: status of Linux on Alpha?
Message-Id: <20040427195721.10931425@vaio.gigerstyle.ch>
In-Reply-To: <1083086601.14273.45.camel@stout.americas.sgi.com>
References: <yw1xsmftnons.fsf@ford.guide>
	<20040328201719.A14868@jurassic.park.msu.ru>
	<yw1xoeqhndvl.fsf@ford.guide>
	<20040328204308.C14868@jurassic.park.msu.ru>
	<20040328221806.7fa20502@vaio.gigerstyle.ch>
	<yw1xr7vcn1z2.fsf@ford.guide>
	<20040329205233.5b7905aa@vaio.gigerstyle.ch>
	<20040404121032.7bb42b35@vaio.gigerstyle.ch>
	<20040409134534.67805dfd@vaio.gigerstyle.ch>
	<20040409134828.0e2984e5@vaio.gigerstyle.ch>
	<20040409230651.A727@den.park.msu.ru>
	<20040413194907.7ce8ceb7@vaio.gigerstyle.ch>
	<20040427185124.134073cd@vaio.gigerstyle.ch>
	<1083086601.14273.45.camel@stout.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 27 Apr 2004 12:23:22 -0500
Eric Sandeen <sandeen@sgi.com> wrote:

> Marc, do you have a patch associated with the changeset you found to
> be the culprit?
> 
> I don't know how to get from that changeset number to a diff.

Yep, you will find all changesets and the belonging patches on
http://linux.bkbits.net:8080/linux-2.5

Reverting the following patch and all is fine...

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/27 18:17:12+11:00 nathans@sgi.com 
#   [XFS] Implement mrlocks on top of rwsems, instead of using our own
mrlock code.#   
#   SGI Modid: xfs-linux:xfs-kern:167181a
# 
# BitKeeper/deleted/.del-mrlock.c~4fd914a7832bd60d
#   2004/02/27 18:16:18+11:00 nathans@sgi.com +0 -0
#   Delete: fs/xfs/linux/mrlock.c
# 
# fs/xfs/Makefile
#   2004/02/27 18:16:53+11:00 nathans@sgi.com +0 -1
#   [XFS] Implement mrlocks on top of rwsems, instead of using our own
mrlock code.# 
# fs/xfs/linux/mrlock.h
#   2004/02/27 18:16:53+11:00 nathans@sgi.com +62 -45
#   [XFS] Implement mrlocks on top of rwsems, instead of using our own
mrlock code.# 
diff -Nru a/fs/xfs/Makefile b/fs/xfs/Makefile
--- a/fs/xfs/Makefile	Mon Apr 12 08:43:27 2004
+++ b/fs/xfs/Makefile	Mon Apr 12 08:43:27 2004
@@ -130,7 +130,6 @@
 
 # Objects in linux/
 xfs-y				+= $(addprefix linux/, \
-				   mrlock.o \
 				   xfs_aops.o \
 				   xfs_buf.o \
 				   xfs_file.o \
diff -Nru a/fs/xfs/linux/mrlock.c b/fs/xfs/linux/mrlock.c
--- a/fs/xfs/linux/mrlock.c	Mon Apr 12 08:43:27 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,274 +0,0 @@
-/*
- * Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
it- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
is- * free of the rightful claim of any third person regarding
infringement- * or the like.  Any license provided herein, whether
implied or- * otherwise, applies only to this software file.  Patent
licenses, if- * any, provided herein do not apply to combinations of
this program with- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
along- * with this program; if not, write the Free Software Foundation,
Inc., 59- * Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/
- */
-
-#include <linux/time.h>
-#include <linux/sched.h>
-#include <asm/system.h>
-#include <linux/interrupt.h>
-#include <asm/current.h>
-
-#include "mrlock.h"
-
-
-#if USE_RW_WAIT_QUEUE_SPINLOCK
-# define wq_write_lock	write_lock
-#else
-# define wq_write_lock	spin_lock
-#endif
-
-/*
- * We don't seem to need lock_type (only one supported), name, or
- * sequence. But, XFS will pass it so let's leave them here for now.
- */
-/* ARGSUSED */
-void
-mrlock_init(mrlock_t *mrp, int lock_type, char *name, long sequence)
-{
-	mrp->mr_count = 0;
-	mrp->mr_reads_waiting = 0;
-	mrp->mr_writes_waiting = 0;
-	init_waitqueue_head(&mrp->mr_readerq);
-	init_waitqueue_head(&mrp->mr_writerq);
-	mrp->mr_lock = SPIN_LOCK_UNLOCKED;
-}
-
-/*
- * Macros to lock/unlock the mrlock_t.
- */
-
-#define MRLOCK(m)		spin_lock(&(m)->mr_lock);
-#define MRUNLOCK(m)		spin_unlock(&(m)->mr_lock);
-
-
-/*
- * lock_wait should never be called in an interrupt thread.
- *
- * mrlocks can sleep (i.e. call schedule) and so they can't ever
- * be called from an interrupt thread.
- *
- * threads that wake-up should also never be invoked from interrupt
threads.- *
- * But, waitqueue_lock is locked from interrupt threads - and we are
- * called with interrupts disabled, so it is all OK.
- */
-
-/* ARGSUSED */
-void
-lock_wait(wait_queue_head_t *q, spinlock_t *lock, int rw)
-{
-	DECLARE_WAITQUEUE( wait, current );
-
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-
-	spin_lock(&q->lock);
-	if (rw) {
-		__add_wait_queue_tail(q, &wait);
-	} else {
-		__add_wait_queue(q, &wait);
-	}
-
-	spin_unlock(&q->lock);
-	spin_unlock(lock);
-
-	schedule();
-
-	spin_lock(&q->lock);
-	__remove_wait_queue(q, &wait);
-	spin_unlock(&q->lock);
-
-	spin_lock(lock);
-
-	/* return with lock held */
-}
-
-/* ARGSUSED */
-void
-mrfree(mrlock_t *mrp)
-{
-}
-
-/* ARGSUSED */
-void
-mrlock(mrlock_t *mrp, int type, int flags)
-{
-	if (type == MR_ACCESS)
-		mraccess(mrp);
-	else
-		mrupdate(mrp);
-}
-
-/* ARGSUSED */
-void
-mraccessf(mrlock_t *mrp, int flags)
-{
-	MRLOCK(mrp);
-	if(mrp->mr_writes_waiting > 0) {
-		mrp->mr_reads_waiting++;
-		lock_wait(&mrp->mr_readerq, &mrp->mr_lock, 0);
-		mrp->mr_reads_waiting--;
-	}
-	while (mrp->mr_count < 0) {
-		mrp->mr_reads_waiting++;
-		lock_wait(&mrp->mr_readerq, &mrp->mr_lock, 0);
-		mrp->mr_reads_waiting--;
-	}
-	mrp->mr_count++;
-	MRUNLOCK(mrp);
-}
-
-/* ARGSUSED */
-void
-mrupdatef(mrlock_t *mrp, int flags)
-{
-	MRLOCK(mrp);
-	while(mrp->mr_count) {
-		mrp->mr_writes_waiting++;
-		lock_wait(&mrp->mr_writerq, &mrp->mr_lock, 1);
-		mrp->mr_writes_waiting--;
-	}
-
-	mrp->mr_count = -1; /* writer on it */
-	MRUNLOCK(mrp);
-}
-
-int
-mrtryaccess(mrlock_t *mrp)
-{
-	MRLOCK(mrp);
-	/*
-	 * If anyone is waiting for update access or the lock is held for
update-	 * fail the request.
-	 */
-	if(mrp->mr_writes_waiting > 0 || mrp->mr_count < 0) {
-		MRUNLOCK(mrp);
-		return 0;
-	}
-	mrp->mr_count++;
-	MRUNLOCK(mrp);
-	return 1;
-}
-
-int
-mrtrypromote(mrlock_t *mrp)
-{
-	MRLOCK(mrp);
-
-	if(mrp->mr_count == 1) { /* We are the only thread with the lock */
-		mrp->mr_count = -1; /* writer on it */
-		MRUNLOCK(mrp);
-		return 1;
-	}
-
-	MRUNLOCK(mrp);
-	return 0;
-}
-
-int
-mrtryupdate(mrlock_t *mrp)
-{
-	MRLOCK(mrp);
-
-	if(mrp->mr_count) {
-		MRUNLOCK(mrp);
-		return 0;
-	}
-
-	mrp->mr_count = -1; /* writer on it */
-	MRUNLOCK(mrp);
-	return 1;
-}
-
-static __inline__ void mrwake(mrlock_t *mrp)
-{
-	/*
-	 * First, if the count is now 0, we need to wake-up anyone waiting.
-	 */
-	if (!mrp->mr_count) {
-		if (mrp->mr_writes_waiting) {	/* Wake-up first writer waiting
*/-			wake_up(&mrp->mr_writerq);
-		} else if (mrp->mr_reads_waiting) {	/* Wakeup any readers
waiting */-			wake_up(&mrp->mr_readerq);
-		}
-	}
-}
-
-void
-mraccunlock(mrlock_t *mrp)
-{
-	MRLOCK(mrp);
-	mrp->mr_count--;
-	mrwake(mrp);
-	MRUNLOCK(mrp);
-}
-
-void
-mrunlock(mrlock_t *mrp)
-{
-	MRLOCK(mrp);
-	if (mrp->mr_count < 0) {
-		mrp->mr_count = 0;
-	} else {
-		mrp->mr_count--;
-	}
-	mrwake(mrp);
-	MRUNLOCK(mrp);
-}
-
-int
-ismrlocked(mrlock_t *mrp, int type)	/* No need to lock since info can change
*/-{
-	if (type == MR_ACCESS)
-		return (mrp->mr_count > 0); /* Read lock */
-	else if (type == MR_UPDATE)
-		return (mrp->mr_count < 0); /* Write lock */
-	else if (type == (MR_UPDATE | MR_ACCESS))
-		return (mrp->mr_count);	/* Any type of lock held */
-	else /* Any waiters */
-		return (mrp->mr_reads_waiting | mrp->mr_writes_waiting);
-}
-
-/*
- * Demote from update to access. We better be the only thread with the
- * lock in update mode so it should be easy to set to 1.
- * Wake-up any readers waiting.
- */
-
-void
-mrdemote(mrlock_t *mrp)
-{
-	MRLOCK(mrp);
-	mrp->mr_count = 1;
-	if (mrp->mr_reads_waiting) {	/* Wakeup all readers waiting */
-		wake_up(&mrp->mr_readerq);
-	}
-	MRUNLOCK(mrp);
-}
diff -Nru a/fs/xfs/linux/mrlock.h b/fs/xfs/linux/mrlock.h
--- a/fs/xfs/linux/mrlock.h	Mon Apr 12 08:43:27 2004
+++ b/fs/xfs/linux/mrlock.h	Mon Apr 12 08:43:27 2004
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
it  * under the terms of version 2 of the GNU General Public License as
@@ -32,56 +32,73 @@
 #ifndef __XFS_SUPPORT_MRLOCK_H__
 #define __XFS_SUPPORT_MRLOCK_H__
 
-#include <linux/time.h>
-#include <linux/wait.h>
-#include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/rwsem.h>
 
-/*
- * Implement mrlocks on Linux that work for XFS.
- *
- * These are sleep locks and not spinlocks. If one wants read/write
spinlocks,- * use read_lock, write_lock, ... see spinlock.h.
- */
+enum { MR_NONE, MR_ACCESS, MR_UPDATE };
 
-typedef struct mrlock_s {
-	int			mr_count;
-	unsigned short		mr_reads_waiting;
-	unsigned short		mr_writes_waiting;
-	wait_queue_head_t	mr_readerq;
-	wait_queue_head_t	mr_writerq;
-	spinlock_t		mr_lock;
+typedef struct {
+	struct rw_semaphore	mr_lock;
+	int			mr_writer;
 } mrlock_t;
 
-#define MR_ACCESS	1
-#define MR_UPDATE	2
-
-#define MRLOCK_BARRIER		0x1
-#define MRLOCK_ALLOW_EQUAL_PRI	0x8
+#define mrinit(mrp, name)	\
+	( (mrp)->mr_writer = 0, init_rwsem(&(mrp)->mr_lock) )
+#define mrlock_init(mrp, t,n,s)	mrinit(mrp, n)
+#define mrfree(mrp)		do { } while (0)
+#define mraccess(mrp)		mraccessf(mrp, 0)
+#define mrupdate(mrp)		mrupdatef(mrp, 0)
+
+static inline void mraccessf(mrlock_t *mrp, int flags)
+{
+	down_read(&mrp->mr_lock);
+}
+
+static inline void mrupdatef(mrlock_t *mrp, int flags)
+{
+	down_write(&mrp->mr_lock);
+	mrp->mr_writer = 1;
+}
+
+static inline int mrtryaccess(mrlock_t *mrp)
+{
+	return down_read_trylock(&mrp->mr_lock);
+}
+
+static inline int mrtryupdate(mrlock_t *mrp)
+{
+	if (!down_write_trylock(&mrp->mr_lock))
+		return 0;
+	mrp->mr_writer = 1;
+	return 1;
+}
+
+static inline void mrunlock(mrlock_t *mrp)
+{
+	if (mrp->mr_writer) {
+		mrp->mr_writer = 0;
+		up_write(&mrp->mr_lock);
+	} else {
+		up_read(&mrp->mr_lock);
+	}
+}
+
+static inline void mrdemote(mrlock_t *mrp)
+{
+	mrp->mr_writer = 0;
+	downgrade_write(&mrp->mr_lock);
+}
 
 /*
- * mraccessf/mrupdatef take flags to be passed in while sleeping;
- * only PLTWAIT is currently supported.
+ * Debug-only routine, without some platform-specific asm code, we can
+ * now only answer requests regarding whether we hold the lock for
write+ * (reader state is outside our visibility, we only track writer
state).+ * Note: means !ismrlocked would give false positivies, so don't
do that.  */
-
-extern void	mraccessf(mrlock_t *, int);
-extern void	mrupdatef(mrlock_t *, int);
-extern void     mrlock(mrlock_t *, int, int);
-extern void     mrunlock(mrlock_t *);
-extern void     mraccunlock(mrlock_t *);
-extern int      mrtryupdate(mrlock_t *);
-extern int      mrtryaccess(mrlock_t *);
-extern int	mrtrypromote(mrlock_t *);
-extern void     mrdemote(mrlock_t *);
-
-extern int	ismrlocked(mrlock_t *, int);
-extern void     mrlock_init(mrlock_t *, int type, char *name, long
sequence);-extern void     mrfree(mrlock_t *);
-
-#define mrinit(mrp, name)	mrlock_init(mrp, MRLOCK_BARRIER, name, -1)
-#define mraccess(mrp)		mraccessf(mrp, 0) /* grab for READ/ACCESS */
-#define mrupdate(mrp)		mrupdatef(mrp, 0) /* grab for WRITE/UPDATE */
-#define mrislocked_access(mrp)	((mrp)->mr_count > 0)
-#define mrislocked_update(mrp)	((mrp)->mr_count < 0)
+static inline int ismrlocked(mrlock_t *mrp, int type)
+{
+	if (type == MR_UPDATE)
+		return mrp->mr_writer;
+	return 1;
+}
 
 #endif /* __XFS_SUPPORT_MRLOCK_H__ */
