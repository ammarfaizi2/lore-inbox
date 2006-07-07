Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWGGGdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWGGGdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 02:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWGGGdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 02:33:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17293 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751192AbWGGGdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 02:33:24 -0400
Subject: Re: Linux v2.6.18-rc1/reiserfs INFO: possible recursive locking
	detected
From: Arjan van de Ven <arjan@infradead.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <44AD9F82.7050006@imap.cc>
References: <6vtF8-99-7@gated-at.bofh.it>  <44AD9F82.7050006@imap.cc>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 08:33:19 +0200
Message-Id: <1152253999.3111.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

,On Fri, 2006-07-07 at 01:40 +0200, Tilman Schmidt wrote:
> Found this in my syslog:
> 
> > Jul  7 00:05:53 gx110 kernel: [  131.691049]
> > Jul  7 00:05:53 gx110 kernel: [  131.691055] =============================================
> > Jul  7 00:05:53 gx110 kernel: [  131.691074] [ INFO: possible recursive locking detected ]
> > Jul  7 00:05:53 gx110 kernel: [  131.691083] ---------------------------------------------
> > Jul  7 00:05:53 gx110 kernel: [  131.691092] udevd/3729 is trying to acquire lock:
> > Jul  7 00:05:53 gx110 kernel: [  131.691101]  (&inode->i_mutex){--..}, at: [<c033c72a>] mutex_lock+0x1c/0x1f
> > Jul  7 00:05:53 gx110 kernel: [  131.691148]
> > Jul  7 00:05:53 gx110 kernel: [  131.691150] but task is already holding lock:
> > Jul  7 00:05:53 gx110 kernel: [  131.691158]  (&inode->i_mutex){--..}, at: [<c033c72a>] mutex_lock+0x1c/0x1f
> > Jul  7 00:05:53 gx110 kernel: [  131.691177]
> > Jul  7 00:05:53 gx110 kernel: [  131.691179] other info that might help us debug this:
> > Jul  7 00:05:53 gx110 kernel: [  131.691189] 1 lock held by udevd/3729:
> > Jul  7 00:05:53 gx110 kernel: [  131.691195]  #0:  (&inode->i_mutex){--..}, at: [<c033c72a>] mutex_lock+0x1c/0x1f
> > Jul  7 00:05:54 gx110 kernel: [  131.691215]
> > Jul  7 00:05:54 gx110 kernel: [  131.691217] stack backtrace:
> > Jul  7 00:05:54 gx110 kernel: [  131.691940]  [<c0103f4d>] show_trace_log_lvl+0x54/0xfd
> > Jul  7 00:05:54 gx110 kernel: [  131.691997]  [<c010504d>] show_trace+0xd/0x10
> > Jul  7 00:05:54 gx110 kernel: [  131.692044]  [<c0105067>] dump_stack+0x17/0x1c
> > Jul  7 00:05:54 gx110 kernel: [  131.692090]  [<c012e3fa>] __lock_acquire+0x758/0x9bf
> > Jul  7 00:05:54 gx110 kernel: [  131.692336]  [<c012e93e>] lock_acquire+0x5e/0x80
> > Jul  7 00:05:54 gx110 kernel: [  131.692572]  [<c033c5a7>] __mutex_lock_slowpath+0xa7/0x20e
> > Jul  7 00:05:54 gx110 kernel: [  131.692796]  [<c033c72a>] mutex_lock+0x1c/0x1f
> > Jul  7 00:05:54 gx110 kernel: [  131.693017]  [<c01ba730>] xattr_readdir+0x50/0x456
> > Jul  7 00:05:54 gx110 kernel: [  131.694269]  [<c01bb304>] reiserfs_chown_xattrs+0xdd/0x112
> > Jul  7 00:05:54 gx110 kernel: [  131.694875]  [<c019dca6>] reiserfs_setattr+0x113/0x250
> > Jul  7 00:05:54 gx110 kernel: [  131.695516]  [<c0174619>] notify_change+0x135/0x2c0
> > Jul  7 00:05:54 gx110 kernel: [  131.695991]  [<c015b328>] chown_common+0x93/0xab
> > Jul  7 00:05:54 gx110 kernel: [  131.696388]  [<c015b373>] sys_chown+0x33/0x45
> > Jul  7 00:05:54 gx110 kernel: [  131.696770]  [<c0102cbd>] sysenter_past_esp+0x56/0x8d
> > Jul  7 00:05:54 gx110 kernel: [  132.094621] IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>


hmm interesting; reiserfs seems to have another locking level layer for
the i_mutex due to the xattrs-are-a-directory thing.

Can you try this patch below and see if that fixes it?

---
 fs/reiserfs/xattr.c |    2 +-
 include/linux/fs.h  |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.17-mm6/fs/reiserfs/xattr.c
===================================================================
--- linux-2.6.17-mm6.orig/fs/reiserfs/xattr.c
+++ linux-2.6.17-mm6/fs/reiserfs/xattr.c
@@ -424,7 +424,7 @@ int xattr_readdir(struct file *file, fil
 	int res = -ENOTDIR;
 	if (!file->f_op || !file->f_op->readdir)
 		goto out;
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_XATTR);
 //        down(&inode->i_zombie);
 	res = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
Index: linux-2.6.17-mm6/include/linux/fs.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/fs.h
+++ linux-2.6.17-mm6/include/linux/fs.h
@@ -564,13 +564,14 @@ struct inode {
  * 3: quota file
  *
  * The locking order between these classes is
- * parent -> child -> normal -> quota
+ * parent -> child -> normal -> xattr -> quota
  */
 enum inode_i_mutex_lock_class
 {
 	I_MUTEX_NORMAL,
 	I_MUTEX_PARENT,
 	I_MUTEX_CHILD,
+	I_MUTEX_XATTR,
 	I_MUTEX_QUOTA
 };
 


