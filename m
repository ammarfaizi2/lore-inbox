Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWGEBvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWGEBvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 21:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWGEBvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 21:51:42 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:36839 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932398AbWGEBvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 21:51:42 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Linux 2.4.33-rc2
Date: Wed, 05 Jul 2006 11:51:35 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <0e6ma2961ro2evtrnacgmla7j52j738q76@4ax.com>
References: <20060621192756.GB13559@dmt> <20060703220736.GA272@1wt.eu>
In-Reply-To: <20060703220736.GA272@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006 00:07:36 +0200, Willy Tarreau <w@1wt.eu> wrote:

>On Wed, Jun 21, 2006 at 04:27:56PM -0300, Marcelo Tosatti wrote:
> 
>> Willy Tarreau:
>>       Fix vfs_unlink/NFS NULL pointer dereference
>
>Marcelo, I'm not sure this one is perfect yet. Today, while packaging
>a lot of files for our distro at work, I came up with a problem where
>deleting a file on NFS, and later simply accessing (read/write/create)
>a file on the NFS file system did block. However, I could kill all the
>offending processes. This was after a full day of mkdir/create/open/
>unlink... (tens of thoudands of those), so it is not much reproduceable.
>
>I could not unmount the NFS anymore, while other users had no problem.
>Rebooting the client solved the problem. I caught an RPC trace (attached),
>not sure if it can help. I must say that I'm also running Trond's NFS
>patches which I suspected first, but with which I never encountered a
>single problem for years.
>
>The fact that the problem appeared during an rm -rf made me think about
>the vfs_unlink() patch. I went to read it again an I'm wondering if we
>have not inserted a new problem (please forgive my ignorance here) :
>
>in 2.4.32, we had the following sequence :
>        down(&dir->i_zombie);
>        if (may_delete(dir, dentry, 0) != 0) return;
>        lock_kernel();
>        error = dir->i_op->unlink(dir, dentry);
>        unlock_kernel();
>        if (!error)
>              d_delete(dentry);
>        up(&dir->i_zombie);
>        if (!error)
>                inode_dir_notify(dir, DN_DELETE);
>
>
>int 2.4.33-rc2, we have :
>        if (may_delete(dir, dentry, 0) != 0) return;
>        inode = dentry->d_inode;
>
>        atomic_inc(&inode->i_count);
>        double_down(&dir->i_zombie, &inode->i_zombie);
> 
>        lock_kernel();
>        error = dir->i_op->unlink(dir, dentry);
>        unlock_kernel();
>
>        double_up(&dir->i_zombie, &inode->i_zombie);
>        iput(inode);
>
>        if (!error) {
>                d_delete(dentry);
>                inode_dir_notify(dir, DN_DELETE);
>        }
>
>What I notice is that in 2.4.32, d_delete(dentry) was performed
>between down(&dir->i_zombie) and up(&dir->i_zombie), while now
>it's completely outside. I wonder if this can cause race conditions
>or not, but at least, I'm sure that we have changed the locking
>sequence, which might have some impact.
>
>Do you think I'm searching in the wrong direction ? I worry a
>bit, because getting a deadlock after only one day, it's a bit
>early :-/
>
Assuming you mean something like the patch below?  Doesn't cause any 
problems (yet, still testing) like eat files or segfault here as 
reported for -rc1 +/- various patches ;)

Cheers,
Grant.
--- linux-2.4.33-rc2/fs/namei.c	2006-06-22 07:27:47.000000000 +1000
+++ linux-2.4.33-rc2b/fs/namei.c	2006-07-05 11:43:19.000000000 +1000
@@ -1497,13 +1497,14 @@
 			lock_kernel();
 			error = dir->i_op->unlink(dir, dentry);
 			unlock_kernel();
+			if (!error)
+				d_delete(dentry);
 		}
 	}
 	double_up(&dir->i_zombie, &inode->i_zombie);
 	iput(inode);
 
 	if (!error) {
-		d_delete(dentry);
 		inode_dir_notify(dir, DN_DELETE);
 	}
 	return error;
