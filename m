Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbTKSTPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 14:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTKSTPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 14:15:40 -0500
Received: from pat.uio.no ([129.240.130.16]:5072 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263961AbTKSTPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 14:15:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16315.49493.365534.444814@charged.uio.no>
Date: Wed, 19 Nov 2003 14:15:33 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Fix Oopsable condition in sys_close() w/ POSIX locks
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo,

  If 2 processes that have been created using CLONE_FILES so that they
share the same POSIX locks both call sys_close() on descriptors that
point to the same inode (but have different struct file *), they can
end up racing in the function locks_remove_posix().

  This race may cause fl->fl_file to disappear while we are flushing
out pending writes in the nfs_lock() function, and so causes Oopses
when we get to nlmclnt_call() & co.

Cheers,
  Trond

--- linux-2.4.22-up/fs/locks.c.orig	2002-05-30 14:07:49.000000000 -0400
+++ linux-2.4.22-up/fs/locks.c	2003-11-15 01:12:16.000000000 -0500
@@ -1747,7 +1747,14 @@
 	before = &inode->i_flock;
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
+			struct file *filp = fl->fl_file;
+			/* Note: locks_unlock_delete() can sleep, and
+			 * so we may race with the call to sys_close()
+			 * by the thread that actually owns this filp.
+			 */
+			get_file(filp);
 			locks_unlock_delete(before);
+			fput(filp);
 			before = &inode->i_flock;
 			continue;
 		}
