Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030535AbVLWOio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbVLWOio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 09:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030537AbVLWOio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 09:38:44 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:55724 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030535AbVLWOin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 09:38:43 -0500
Date: Fri, 23 Dec 2005 23:38:39 +0900 (JST)
Message-Id: <20051223.233839.846934653.masano@tnes.nec.co.jp>
To: trond.myklebust@fys.uio.no, matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fix posix lock on NFS, #2
From: ASANO Masahiro <masano@tnes.nec.co.jp>
X-Mailer: Mew version 3.3 on XEmacs 21.4.11 (Native Windows TTY Support)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is another problem report on posix lock.

The nfsd may handle the lock information incorrectly if new lock is
contiguous to old one.  I think both 2.6 and 2.4 kernel have this bug.

The following is a sample program to produce the circumstance.
        fd = open("file_on_nfs_2", O_RDWR | O_CREAT, 0644);
        memset(&lck, 0, sizeof(lck));
        lck.l_type = F_WRLCK;
        switch (child = fork()) {
        case 0:
                lck.l_start = 0; lck.l_len = 1; fcntl(fd, F_SETLK, &lck);
                sleep(1);
                lck.l_start = 1; lck.l_len = 1; fcntl(fd, F_SETLKW, &lck);
                _exit(0);
        default:
                lck.l_start = 1; lck.l_len = 1; fcntl(fd, F_SETLK, &lck);
                sleep(2); close(fd);
                printf("waiting...\n");
                // sleep(1); kill(chiled, SIGINT);
                wait(NULL);
                break;
        }

All version of linux requires time to grant the lock, but on older
kernel the lock is leaked if it is signaled while waiting the grant.

I think it is caused by a miss-calling of posix_lock_file() in nfsd.
posix_lock_file() updates the second argument `request' as you know,
but it seems that nfsd gives no care about that.

Here is a patch.  It changes nfsd to keep the range of file_lock for
later use.  Any comments and feedback are welcome.

Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>

--- linux-2.6.15-rc6/fs/lockd/svclock.c.orig	2005-12-23 20:16:33.000000000 +0900
+++ linux-2.6.15-rc6/fs/lockd/svclock.c	2005-12-23 20:24:13.000000000 +0900
@@ -510,6 +510,7 @@ nlmsvc_grant_blocked(struct nlm_block *b
 	struct nlm_file		*file = block->b_file;
 	struct nlm_lock		*lock = &block->b_call.a_args.lock;
 	struct file_lock	*conflock;
+	struct file_lock	tmplck;
 	int			error;
 
 	dprintk("lockd: grant blocked lock %p\n", block);
@@ -542,7 +543,8 @@ nlmsvc_grant_blocked(struct nlm_block *b
 	 * following yields an error, this is most probably due to low
 	 * memory. Retry the lock in a few seconds.
 	 */
-	if ((error = posix_lock_file(file->f_file, &lock->fl)) < 0) {
+	tmplck = lock->fl;	/* keep the range for later use */
+	if ((error = posix_lock_file(file->f_file, &tmplck)) < 0) {
 		printk(KERN_WARNING "lockd: unexpected error %d in %s!\n",
 				-error, __FUNCTION__);
 		nlmsvc_insert_block(block, 10 * HZ);

