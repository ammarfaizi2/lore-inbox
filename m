Return-Path: <linux-kernel-owner+w=401wt.eu-S1161010AbXAEMSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbXAEMSo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbXAEMSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:18:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:56672 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965101AbXAEMSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:18:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=oRLoNdlMO8LFSfz1hNQniCP2W8j6OdlPo0PEFmeGFIcBFEAhQsiIILh1EuunAGt8IHnMiSP6CDARwwGrI9IO5vbsKUTrSvQlotXyra6qOFzsigjWYe9IqJ/tlfXmp5RPLqYQ/NorHoH5/ICQ4QnUVlS6MpOI2pKLeaeZjzOBTQM=
Date: Fri, 5 Jan 2007 12:16:43 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, maneesh@in.ibm.com,
       oliver@neukum.name
Subject: [-mm patch] lockdep: possible deadlock in sysfs
Message-ID: <20070105121643.GE17863@slug>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104220200.ae4e9a46.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 10:02:00PM -0800, Andrew Morton wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
> 
Hi,

Lockdep issues the following warning:
[    9.064000] =============================================
[    9.064000] [ INFO: possible recursive locking detected ]
[    9.064000] 2.6.20-rc3-mm1 #3
[    9.064000] ---------------------------------------------
[    9.064000] init/1 is trying to acquire lock:
[    9.064000]  (&sysfs_inode_imutex_key){--..}, at: [<c03e6afc>] mutex_lock+0x1c/0x1f
[    9.064000]
[    9.064000] but task is already holding lock:
[    9.064000]  (&sysfs_inode_imutex_key){--..}, at: [<c03e6afc>] mutex_lock+0x1c/0x1f
[    9.065000]
[    9.065000] other info that might help us debug this:
[    9.065000] 2 locks held by init/1:
[    9.065000]  #0:  (tty_mutex){--..}, at: [<c03e6afc>] mutex_lock+0x1c/0x1f
[    9.065000]  #1:  (&sysfs_inode_imutex_key){--..}, at: [<c03e6afc>] mutex_lock+0x1c/0x1f
[    9.065000]
[    9.065000] stack backtrace:
[    9.065000]  [<c010390d>] show_trace_log_lvl+0x1a/0x30
[    9.066000]  [<c0103935>] show_trace+0x12/0x14
[    9.066000]  [<c0103a2f>] dump_stack+0x16/0x18
[    9.066000]  [<c0138cb8>] print_deadlock_bug+0xb9/0xc3
[    9.066000]  [<c0138d17>] check_deadlock+0x55/0x5a
[    9.066000]  [<c013a953>] __lock_acquire+0x371/0xbf0
[    9.066000]  [<c013b7a9>] lock_acquire+0x69/0x83
[    9.066000]  [<c03e6b7e>] __mutex_lock_slowpath+0x75/0x2d1
[    9.066000]  [<c03e6afc>] mutex_lock+0x1c/0x1f
[    9.066000]  [<c01b249c>] sysfs_drop_dentry+0xb1/0x133
[    9.066000]  [<c01b25d1>] sysfs_hash_and_remove+0xb3/0x142
[    9.066000]  [<c01b30ed>] sysfs_remove_file+0xd/0x10
[    9.067000]  [<c02849e0>] device_remove_file+0x23/0x2e
[    9.067000]  [<c02850b2>] device_del+0x188/0x1e6
[    9.067000]  [<c028511b>] device_unregister+0xb/0x15
[    9.067000]  [<c0285318>] device_destroy+0x9c/0xa9
[    9.067000]  [<c0261431>] vcs_remove_sysfs+0x1c/0x3b
[    9.067000]  [<c0267a08>] con_close+0x5e/0x6b
[    9.067000]  [<c02598f2>] release_dev+0x4c4/0x6e5
[    9.067000]  [<c0259faa>] tty_release+0x12/0x1c
[    9.067000]  [<c0174872>] __fput+0x177/0x1a0
[    9.067000]  [<c01746f5>] fput+0x3b/0x41
[    9.068000]  [<c0172ee1>] filp_close+0x36/0x65
[    9.068000]  [<c0172f73>] sys_close+0x63/0xa4
[    9.068000]  [<c0102a96>] sysenter_past_esp+0x5f/0x99
[    9.068000]  =======================

This is due to sysfs_hash_and_remove() holding dir->d_inode->i_mutex
before calling sysfs_drop_dentry() which calls orphan_all_buffers()
which in turn takes node->i_mutex.
The following patch solves the problem by defering the buffers orphaning
after the dir->d_inode->imutex is released. Not sure it's the best
solution though, better wait for feedback from Maneesh and Oliver.

(This is mostly a resend of the patch that I sent for 2.6.20-rc2-mm1 [1], but
it adds the initialisation of inode in sysfs_hash_and_remove)

Regards,
Frederik 

[1]
http://groups.google.com/group/linux.kernel/msg/5164f76c31958e0b?dmode=source

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 8c533cb..bcf6bc0 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -230,10 +230,10 @@ static inline void orphan_all_buffers(struct inode *node)
  * Unhashes the dentry corresponding to given sysfs_dirent
  * Called with parent inode's i_mutex held.
  */
-void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
+struct inode *sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
 {
 	struct dentry * dentry = sd->s_dentry;
-	struct inode *inode;
+	struct inode *inode = NULL;
 
 	if (dentry) {
 		spin_lock(&dcache_lock);
@@ -248,19 +248,19 @@ void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
 			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			simple_unlink(parent->d_inode, dentry);
-			orphan_all_buffers(inode);
-			iput(inode);
 		} else {
 			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 		}
 	}
+	return inode;
 }
 
 int sysfs_hash_and_remove(struct dentry * dir, const char * name)
 {
 	struct sysfs_dirent * sd;
 	struct sysfs_dirent * parent_sd;
+	struct inode *inode = NULL;
 	int found = 0;
 
 	if (!dir)
@@ -277,7 +277,7 @@ int sysfs_hash_and_remove(struct dentry * dir, const char * name)
 			continue;
 		if (!strcmp(sysfs_get_name(sd), name)) {
 			list_del_init(&sd->s_sibling);
-			sysfs_drop_dentry(sd, dir);
+			inode = sysfs_drop_dentry(sd, dir);
 			sysfs_put(sd);
 			found = 1;
 			break;
@@ -285,5 +285,10 @@ int sysfs_hash_and_remove(struct dentry * dir, const char * name)
 	}
 	mutex_unlock(&dir->d_inode->i_mutex);
 
+	if (found && inode) {
+		orphan_all_buffers(inode);
+		iput(inode);
+	}
+
 	return found ? 0 : -ENOENT;
 }
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 5100a12..ef9d217 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -17,7 +17,7 @@ extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **)
 extern void sysfs_remove_subdir(struct dentry *);
 
 extern const unsigned char * sysfs_get_name(struct sysfs_dirent *sd);
-extern void sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
+extern struct inode * sysfs_drop_dentry(struct sysfs_dirent *sd, struct dentry *parent);
 extern int sysfs_setattr(struct dentry *dentry, struct iattr *iattr);
 
 extern struct rw_semaphore sysfs_rename_sem;
