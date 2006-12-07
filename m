Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163343AbWLGVGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163343AbWLGVGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163344AbWLGVGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:06:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:7739 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163343AbWLGVGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:06:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gBnGYw9ti9m7fNFN6mvsf4y0e4C6lrTMHvcG31MLVbO5CXywrRiATnV2C0YOrneb+BFYa8+eZknEUqtbL5M7TVIcwYcah5xMlm0kj2nAwIOBfgvPiHkSf67b6ek+vup41/U1129ypvKdKvgY4aJVOq56HzEZlzXn+uJGEpjlli8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Let's get rid of those annoying "VFS is out of sync with lock manager" messages (includes proposed patch)
Date: Thu, 7 Dec 2006 22:08:16 +0100
User-Agent: KMail/1.9.4
Cc: Neil Brown <neilb@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       nfs@lists.sourceforge.net, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612072208.16350.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A while back I reported that I had a bunch of servers that started 
complaining about VFS being out of sync with lock manager - 
the thread title was 
  "[NFS] 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock manager!"
During the course of that thread Neil Brown proposed a patch to resolve the
issue with the following description:

"
 - do_vfs_lock is only called when the filesystem was mounted with
   -o nolock  EXCEPT
 - If a lock request to the server in interrupted (when mounted with
    -o intr) then do_vfs_lock is called to try to get the lock
   locally.  Normally equivalent code will be called inside
   fs/lockd/clntproc.c when the server replies that the lock has been
   gained.  In the case of an interrupt though this doesn't happen
   but the lock may still have happened on the server.  So we record
   locally that the lock was gained, to ensure that it gets unlocked
   when the process exits.

As you don't have '-o nolocks' you must be hitting the second case.
The lock call to the server returns -EINTR or -ERESTARTSYS and
do_vfs_lock is called just-in-case.
As this is a just-in-case call, it is quite possible that the lock is
held by some other process, so getting an error is entirely possible.
So printing the message in this case seems wrong.

On the other hand, printing the message in any other case seems wrong
too, as server locking is not being used, so there is nothing to get
out of sync with.

As a further complication, I don't think that in the just-in-case
situation that it should risk waiting for the lock.
Now maybe we can be sure there is a pending signal which will break
out of any wait (though I'm worried about -ERESTARTSYS - that doesn't
imply a signal does it?), but I would feel more comfortable if
FL_SLEEP were turned off in that path.
"

To which Trond Myklebust replied:

"
Could we instead replace it with a dprintk() that returns the value of
"res"? That will keep it useful for debugging purposes.
"

So I took Neils patch, made the change Trond suggested and the result is 
below.

Comments?  Ok to merge?  


Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/nfs/file.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index cc93865..22572af 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -428,8 +428,8 @@ static int do_vfs_lock(struct file *file
 			BUG();
 	}
 	if (res < 0)
-		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
-				__FUNCTION__);
+		dprintk("%s: VFS is out of sync with lock manager (res = %d)!\n",
+				__FUNCTION__, res);
 	return res;
 }
 
@@ -479,10 +479,13 @@ static int do_setlk(struct file *filp, i
 		 * we clean up any state on the server. We therefore
 		 * record the lock call as having succeeded in order to
 		 * ensure that locks_remove_posix() cleans it out when
-		 * the process exits.
+		 * the process exits. Make sure not to sleep if
+		 * someone else holds the lock.
 		 */
-		if (status == -EINTR || status == -ERESTARTSYS)
+		if (status == -EINTR || status == -ERESTARTSYS) {
+			fl->fl_flags &= ~FL_SLEEP;
 			do_vfs_lock(filp, fl);
+		}
 	} else
 		status = do_vfs_lock(filp, fl);
 	unlock_kernel();


