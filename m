Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWJ2Xaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWJ2Xaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 18:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWJ2Xaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 18:30:46 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:4496 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030438AbWJ2Xap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 18:30:45 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Mon, 30 Oct 2006 00:29:24 +0100
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com, Christoph Hellwig <hch@infradead.org>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <20061027013802.GQ8394166@melbourne.sgi.com> <20061029173537.GA3022@elf.ucw.cz>
In-Reply-To: <20061029173537.GA3022@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610300029.25555.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 29 October 2006 18:35, Pavel Machek wrote:
> Hi!
> 
> > > > > As you have them at the moment, the threads seem to be freezing fine.
> > > > > The issue I've seen in the past related not to threads but to timer
> > > > > based activity. Admittedly it was 2.6.14 when I last looked at it, but
> > > > > there used to be a possibility for XFS to submit I/O from a timer when
> > > > > the threads are frozen but the bdev isn't frozen. Has that changed?
> > > > 
> > > > I didn't think we've ever done that - periodic or delayed operations
> > > > are passed off to the kernel threads to execute. A stack trace
> > > > (if you still have it) would be really help here.
> > > > 
> > > > Hmmm - we have a couple of per-cpu work queues as well that are
> > > > used on I/O completion and that can, in some circumstances,
> > > > trigger new transactions. If we are only flush metadata, then
> > > > I don't think that any more I/o will be issued, but I could be
> > > > wrong (maze of twisty passages).
> > > 
> > > Well, I think this exactly is the problem, because worker_threads run with
> > > PF_NOFREEZE set (as I've just said in another message).
> > 
> > Ok, so freezing the filesystem is the only way you can prevent
> > this as the workqueues are flushed as part of quiescing the filesystem.
> 
> Well, alternative is to teach XFS to sense that we are being frozen
> and stop disk writes in such case.
> 
> OTOH freeze_bdevs is perhaps not that bad solution... 

Okay, appended is a patch that implements the freezing of bdevs in a slightly
different way than the Nigel's patch did it.

As Christoph suggested, I have put freeze_filesystems() and thaw_filesystems()
into fs/buffer.c and indroduced the MS_FROZEN flag to mark frozen
filesystems.

It seems to work fine, except I get the following trace from lockdep during
the suspend on a regular basis (not 100% reproducible, though):

Stopping tasks...
=============================================
[ INFO: possible recursive locking detected ]
2.6.19-rc2-mm2 #15
---------------------------------------------
s2disk/5564 is trying to acquire lock:
 (&bdev->bd_mount_mutex){--..}, at: [<ffffffff80475e79>] mutex_lock+0x9/0x10

but task is already holding lock:
 (&bdev->bd_mount_mutex){--..}, at: [<ffffffff80475e79>] mutex_lock+0x9/0x10

other info that might help us debug this:
3 locks held by s2disk/5564:
 #0:  (&bdev->bd_mount_mutex){--..}, at: [<ffffffff80475e79>] mutex_lock+0x9/0x10
 #1:  (&type->s_umount_key#16){----}, at: [<ffffffff80291647>] get_super+0x67/0xc0
 #2:  (&journal->j_barrier){--..}, at: [<ffffffff80475e79>] mutex_lock+0x9/0x10

stack backtrace:

Call Trace:
 [<ffffffff8020af79>] dump_trace+0xb9/0x430
 [<ffffffff8020b333>] show_trace+0x43/0x60
 [<ffffffff8020b635>] dump_stack+0x15/0x20
 [<ffffffff8024a1d1>] __lock_acquire+0x881/0xc60
 [<ffffffff8024a94d>] lock_acquire+0x8d/0xc0
 [<ffffffff80475cd4>] __mutex_lock_slowpath+0xd4/0x270
 [<ffffffff80475e79>] mutex_lock+0x9/0x10
 [<ffffffff802b2bb6>] freeze_bdev+0x16/0x80
 [<ffffffff802b3105>] freeze_filesystems+0x55/0x80
 [<ffffffff80255942>] freeze_processes+0x1e2/0x360
 [<ffffffff802592a3>] snapshot_ioctl+0x163/0x610
 [<ffffffff8029cf0b>] do_ioctl+0x6b/0xa0
 [<ffffffff8029d1eb>] vfs_ioctl+0x2ab/0x2d0
 [<ffffffff8029d27a>] sys_ioctl+0x6a/0xa0
 [<ffffffff80209c2e>] system_call+0x7e/0x83
 [<00002afb13a4d8a9>]

done.
Shrinking memory... done (19126 pages freed)

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 fs/buffer.c                 |   38 +++++++++++++++++++++++++++++++++
 include/linux/buffer_head.h |    2 +
 include/linux/fs.h          |    1 
 kernel/power/process.c      |   50 +++++++++++++++++++++++++++++---------------
 4 files changed, 74 insertions(+), 17 deletions(-)

Index: linux-2.6.19-rc2-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/power/process.c
+++ linux-2.6.19-rc2-mm2/kernel/power/process.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
+#include <linux/buffer_head.h>
 
 /* 
  * Timeout for stopping processes
@@ -119,7 +120,7 @@ int freeze_processes(void)
 		read_unlock(&tasklist_lock);
 		todo += nr_user;
 		if (!user_frozen && !nr_user) {
-			sys_sync();
+			freeze_filesystems();
 			start_time = jiffies;
 		}
 		user_frozen = !nr_user;
@@ -156,28 +157,43 @@ int freeze_processes(void)
 void thaw_some_processes(int all)
 {
 	struct task_struct *g, *p;
-	int pass = 0; /* Pass 0 = Kernel space, 1 = Userspace */
 
 	printk("Restarting tasks... ");
 	read_lock(&tasklist_lock);
-	do {
-		do_each_thread(g, p) {
-			/*
-			 * is_user = 0 if kernel thread or borrowed mm,
-			 * 1 otherwise.
-			 */
-			int is_user = !!(p->mm && !(p->flags & PF_BORROWED_MM));
-			if (!freezeable(p) || (is_user != pass))
-				continue;
-			if (!thaw_process(p))
-				printk(KERN_INFO
-					"Strange, %s not stopped\n", p->comm);
-		} while_each_thread(g, p);
 
-		pass++;
-	} while (pass < 2 && all);
+	do_each_thread(g, p) {
+		if (!freezeable(p))
+			continue;
+
+		/* Don't thaw userland processes, for now */
+		if (p->mm && !(p->flags & PF_BORROWED_MM))
+			continue;
+
+		if (!thaw_process(p))
+			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+	} while_each_thread(g, p);
+
+	read_unlock(&tasklist_lock);
+	if (!all)
+		goto Exit;
+
+	thaw_filesystems();
+	read_lock(&tasklist_lock);
+
+	do_each_thread(g, p) {
+		if (!freezeable(p))
+			continue;
+
+		/* Kernel threads should have been thawed already */
+		if (!p->mm || (p->flags & PF_BORROWED_MM))
+			continue;
+
+		if (!thaw_process(p))
+			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+Exit:
 	schedule();
 	printk("done.\n");
 }
Index: linux-2.6.19-rc2-mm2/include/linux/buffer_head.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/linux/buffer_head.h
+++ linux-2.6.19-rc2-mm2/include/linux/buffer_head.h
@@ -170,6 +170,8 @@ wait_queue_head_t *bh_waitq_head(struct 
 int fsync_bdev(struct block_device *);
 struct super_block *freeze_bdev(struct block_device *);
 void thaw_bdev(struct block_device *, struct super_block *);
+void freeze_filesystems(void);
+void thaw_filesystems(void);
 int fsync_super(struct super_block *);
 int fsync_no_super(struct block_device *);
 struct buffer_head *__find_get_block(struct block_device *, sector_t, int);
Index: linux-2.6.19-rc2-mm2/include/linux/fs.h
===================================================================
--- linux-2.6.19-rc2-mm2.orig/include/linux/fs.h
+++ linux-2.6.19-rc2-mm2/include/linux/fs.h
@@ -120,6 +120,7 @@ extern int dir_notify_enable;
 #define MS_PRIVATE	(1<<18)	/* change to private */
 #define MS_SLAVE	(1<<19)	/* change to slave */
 #define MS_SHARED	(1<<20)	/* change to shared */
+#define MS_FROZEN	(1<<21)	/* Frozen by freeze_filesystems() */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
Index: linux-2.6.19-rc2-mm2/fs/buffer.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/fs/buffer.c
+++ linux-2.6.19-rc2-mm2/fs/buffer.c
@@ -244,6 +244,44 @@ void thaw_bdev(struct block_device *bdev
 }
 EXPORT_SYMBOL(thaw_bdev);
 
+/**
+ * freeze_filesystems - lock all filesystems and force them into a consistent
+ * state
+ */
+void freeze_filesystems(void)
+{
+	struct super_block *sb;
+
+	/*
+	 * Freeze in reverse order so filesystems dependant upon others are
+	 * frozen in the right order (eg. loopback on ext3).
+	 */
+	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
+		if (!sb->s_root || !sb->s_bdev ||
+		    (sb->s_frozen == SB_FREEZE_TRANS) ||
+		    (sb->s_flags & MS_RDONLY) ||
+		    (sb->s_flags & MS_FROZEN))
+			continue;
+
+		freeze_bdev(sb->s_bdev);
+		sb->s_flags |= MS_FROZEN;
+	}
+}
+
+/**
+ * thaw_filesystems - unlock all filesystems
+ */
+void thaw_filesystems(void)
+{
+	struct super_block *sb;
+
+	list_for_each_entry(sb, &super_blocks, s_list)
+		if (sb->s_flags & MS_FROZEN) {
+			sb->s_flags &= ~MS_FROZEN;
+			thaw_bdev(sb->s_bdev, sb);
+		}
+}
+
 /*
  * Various filesystems appear to want __find_get_block to be non-blocking.
  * But it's the page lock which protects the buffers.  To get around this,
