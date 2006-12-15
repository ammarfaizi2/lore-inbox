Return-Path: <linux-kernel-owner+w=401wt.eu-S1752141AbWLONvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbWLONvJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 08:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbWLONvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 08:51:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:8295 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbWLONvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 08:51:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:date:user-agent:cc:mime-version:content-disposition:subject:content-type:content-transfer-encoding:message-id;
        b=gvvF2kW2AONuoUvAF1lAs/TGXjVAYXpsNiv9a0lJKq7CK50kazPHA8+IrIGu6Piq9h9Rst3gmYW8o8nYsqapjNj0JWYUkIoQB9hC6cZyPOkpQNgUxxA5rz8Yh0wcNYrGnTFG9xtYGzS2A8Eza7NSgkxP/jUpJxR8ibjCX6/5JVI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 15 Dec 2006 14:50:52 +0100
User-Agent: KMail/1.9.5
Cc: Neil Brown <neilb@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       nfs@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [PATCH] VFS: turn off FL_SLEEP when calling do_vfs_lock() just in case and get rid of "VFS is out of sync with lock manager" messages
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200612151450.53029.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert "VFS is out of sync with lock manager!" printk() in
do_vfs_lock() to dprintk() since the message is useless in normal use
but could possibly be useful as a debugging aid.
Also turn off FL_SLEEP when calling do_vfs_lock() just in case, after
getting -EINTR or -ERESTARTSYS.

Patch has been tested on a production webserver and works just fine.


Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/nfs/file.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 0dd6be3..4cf4166 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -434,8 +434,8 @@ static int do_vfs_lock(struct file *file
 			BUG();
 	}
 	if (res < 0)
-		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
-				__FUNCTION__);
+		dprintk("%s: VFS is out of sync with lock manager (res = %d)!\n",
+				__FUNCTION__, res);
 	return res;
 }
 
@@ -485,10 +485,13 @@ static int do_setlk(struct file *filp, i
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


