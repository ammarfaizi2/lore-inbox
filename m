Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTKZAgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 19:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTKZAgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 19:36:07 -0500
Received: from pat.uio.no ([129.240.130.16]:61421 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263765AbTKZAgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 19:36:04 -0500
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.4] NFS unlocking operation accesses invalid file struct
References: <200311252000.32094.mita@miraclelinux.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 25 Nov 2003 19:35:55 -0500
In-Reply-To: <200311252000.32094.mita@miraclelinux.com>
Message-ID: <shs1xrwvudw.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Akinobu Mita <mita@miraclelinux.com> writes:


     > Does anyone have a idea of how to fix it ?

Yes. I posted a patch about a week or 2 ago. The original patch can be
found on

  http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-rc1/linux-2.4.23-01-posix_race.dif

However, I now believe the real problem here is that
locks_remove_posix() should also be checking the pid (as is done in
all the other POSIX locking checks by calling locks_same_owner()).

It is wrong for locks_remove_posix() to be deleting locks that don't
belong to this pid... Note: this bug exists in 2.6.x. too, although
there it does not cause an Oops...

Cheers,
  Trond

--- linux-2.4.23-rc1/fs/locks.c.orig	2003-11-16 19:30:53.000000000 -0500
+++ linux-2.4.23-rc1/fs/locks.c	2003-11-25 19:34:02.000000000 -0500
@@ -1746,7 +1746,8 @@
 	lock_kernel();
 	before = &inode->i_flock;
 	while ((fl = *before) != NULL) {
-		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
+		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner &&
+				fl->fl_pid == current->pid) {
 			locks_unlock_delete(before);
 			before = &inode->i_flock;
 			continue;
