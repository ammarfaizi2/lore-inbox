Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWJQOUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWJQOUH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWJQOUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:20:06 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:18333 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751080AbWJQOUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:20:05 -0400
Subject: [PATCH] lockdep: annotate nfsd4 recover code
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, Steve Dickson <SteveD@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 16:20:28 +0200
Message-Id: <1161094828.3036.53.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.18-1.2724.lockdepPAE #1
> ---------------------------------------------
> nfsd/6884 is trying to acquire lock:
>  (&inode->i_mutex){--..}, at: [<c04811e5>] vfs_rmdir+0x73/0xf4
> 
> but task is already holding lock:
>  (&inode->i_mutex){--..}, at: [<f8dfa621>]
> nfsd4_clear_clid_dir+0x1f/0x3d [nfsd]
> 
> other info that might help us debug this:
> 3 locks held by nfsd/6884:
>  #0:  (hash_sem){----}, at: [<f8de05eb>] nfsd+0x181/0x2ea [nfsd]
>  #1:  (client_mutex){--..}, at: [<f8df6d19>]
> nfsd4_setclientid_confirm+0x3b/0x2cf [nfsd]
>  #2:  (&inode->i_mutex){--..}, at: [<f8dfa621>]
> nfsd4_clear_clid_dir+0x1f/0x3d [nfsd]
> 
> stack backtrace:
>  [<c040524d>] dump_trace+0x69/0x1af
>  [<c04053ab>] show_trace_log_lvl+0x18/0x2c
>  [<c040595f>] show_trace+0xf/0x11
>  [<c0405a53>] dump_stack+0x15/0x17
>  [<c043ca7a>] __lock_acquire+0x110/0x9b6
>  [<c043d91e>] lock_acquire+0x5c/0x7a
>  [<c061a41b>] __mutex_lock_slowpath+0xde/0x234
>  [<c04811e5>] vfs_rmdir+0x73/0xf4
>  [<f8dfa62b>] nfsd4_clear_clid_dir+0x29/0x3d [nfsd]
>  [<f8dfa733>] nfsd4_remove_clid_dir+0xb8/0xf8 [nfsd]
>  [<f8df6e90>] nfsd4_setclientid_confirm+0x1b2/0x2cf [nfsd]
>  [<f8def19a>] nfsd4_proc_compound+0x137a/0x166c [nfsd]
>  [<f8de00d5>] nfsd_dispatch+0xc5/0x180 [nfsd]
>  [<f8d09d83>] svc_process+0x3bd/0x631 [sunrpc]
>  [<f8de0604>] nfsd+0x19a/0x2ea [nfsd]
>  [<c0404e27>] kernel_thread_helper+0x7/0x10
> DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> Leftover inexact backtrace:
>  =======================

Some nesting annotation to the nfsd4 recovery code.
The vfs operations called will take dentry->d_inode->i_mutex.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/nfsd/nfs4recover.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18.noarch/fs/nfsd/nfs4recover.c
===================================================================
--- linux-2.6.18.noarch.orig/fs/nfsd/nfs4recover.c
+++ linux-2.6.18.noarch/fs/nfsd/nfs4recover.c
@@ -258,7 +258,7 @@ nfsd4_remove_clid_file(struct dentry *di
 		printk("nfsd4: non-file found in client recovery directory\n");
 		return -EINVAL;
 	}
-	mutex_lock(&dir->d_inode->i_mutex);
+	mutex_lock_nested(&dir->d_inode->i_mutex, I_MUTEX_PARENT);
 	status = vfs_unlink(dir->d_inode, dentry);
 	mutex_unlock(&dir->d_inode->i_mutex);
 	return status;
@@ -273,7 +273,7 @@ nfsd4_clear_clid_dir(struct dentry *dir,
 	 * any regular files anyway, just in case the directory was created by
 	 * a kernel from the future.... */
 	nfsd4_list_rec_dir(dentry, nfsd4_remove_clid_file);
-	mutex_lock(&dir->d_inode->i_mutex);
+	mutex_lock_nested(&dir->d_inode->i_mutex, I_MUTEX_PARENT);
 	status = vfs_rmdir(dir->d_inode, dentry);
 	mutex_unlock(&dir->d_inode->i_mutex);
 	return status;


