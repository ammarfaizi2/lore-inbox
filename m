Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTGFSrn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 14:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTGFSrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 14:47:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7348 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263205AbTGFSrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 14:47:41 -0400
Date: Sun, 6 Jul 2003 12:03:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, devfs@oss.sgi.com
Subject: Re: [PATCH][2.5.73] stack corruption in devfs_lookup
Message-Id: <20030706120315.261732bb.akpm@osdl.org>
In-Reply-To: <200307062058.40797.arvidjaar@mail.ru>
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru>
	<Pine.LNX.4.55.0304231157560.1309@marabou.research.att.com>
	<Pine.LNX.4.55.0305050005230.1278@marabou.research.att.com>
	<200307062058.40797.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
> When devfs_lookup needs to call devfsd it arranges for other lookups for the 
>  same name to wait. It is using local variable as wait queue head. After 
>  devfsd returns devfs_lookup wakes up all waiters and returns. Unfortunately 
>  there is no garantee all waiters will actually get chance to run and clean up 
>  before devfs_lookup returns. so some of them attempt to access already freed 
>  storage on stack.

OK, but I think there is a simpler fix.  We can rely on the side-effects of
prepare_to_wait() and finish_wait().

The wakeup() will remove all wait_queue_t's from the wait_queue_head, and
so when the waiters wake up and call finish_wait(), they will never touch
the now-out-of-scope waitqueue head.

It is a little faster than the currentcode, too.

Could you please test this?



diff -puN fs/devfs/base.c~devfs-oops-fix-2 fs/devfs/base.c
--- 25/fs/devfs/base.c~devfs-oops-fix-2	2003-07-06 11:55:38.000000000 -0700
+++ 25-akpm/fs/devfs/base.c	2003-07-06 11:59:23.000000000 -0700
@@ -2218,7 +2218,6 @@ static int devfs_d_revalidate_wait (stru
     struct fs_info *fs_info = dir->i_sb->s_fs_info;
     devfs_handle_t parent = get_devfs_entry_from_vfs_inode (dir);
     struct devfs_lookup_struct *lookup_info = dentry->d_fsdata;
-    DECLARE_WAITQUEUE (wait, current);
 
     if ( is_devfsd_or_child (fs_info) )
     {
@@ -2252,11 +2251,12 @@ static int devfs_d_revalidate_wait (stru
     read_lock (&parent->u.dir.lock);
     if (dentry->d_fsdata)
     {
-	set_current_state (TASK_UNINTERRUPTIBLE);
-	add_wait_queue (&lookup_info->wait_queue, &wait);
-	read_unlock (&parent->u.dir.lock);
-	schedule ();
-	remove_wait_queue (&lookup_info->wait_queue, &wait);
+	DEFINE_WAIT(wait);
+
+	prepare_to_wait(&lookup_info->wait_queue, &wait, TASK_UNINTERRUPTIBLE);
+	read_unlock(&parent->u.dir.lock);
+	schedule();
+	finish_wait(&lookup_info->wait_queue, &wait);
     }
     else read_unlock (&parent->u.dir.lock);
     return 1;
@@ -2336,6 +2336,12 @@ out:
     dentry->d_op = &devfs_dops;
     dentry->d_fsdata = NULL;
     write_lock (&parent->u.dir.lock);
+    /*
+     * This wakeup will remove all waiters' wait_queue_t's from the waitqueue
+     * head, because the waiters use prepare_to_wait()/finished_wait().
+     * Hence it is OK that the waitqueue_head goes out of scope immediately
+     * after the wakeup is delivered
+     */
     wake_up (&lookup_info.wait_queue);
     write_unlock (&parent->u.dir.lock);
     devfs_put (de);

_

