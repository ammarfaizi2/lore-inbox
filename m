Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWHLJDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWHLJDK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 05:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWHLJDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 05:03:10 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:14736 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932134AbWHLJDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 05:03:09 -0400
Date: Sat, 12 Aug 2006 04:58:49 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock
  manager!
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "Grant Coady" <gcoady.lk@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Message-ID: <200608120502_MC3-1-C7DD-FF7F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <9a8748490608101537y4c377fb3xcd8babbdbc29cee2@mail.gmail.com>

On Fri, 11 Aug 2006 00:37:35 +0200, Jesper Juhl wrote:

> > > >I have some webservers that have recently started reporting the
> > > >following message in their logs :
> > > >
> > > >  do_vfs_lock: VFS is out of sync with lock manager!

What does this (not even compile tested) patch print?

--- 2.6.17.8-nb/fs/lockd/clntproc.c	2006-06-10 17:39:21.000000000 -0400
+++ 2.6.17.8-nb/fs/lockd/clntproc.c.new	2006-08-12 04:43:45.000000000 -0400
@@ -458,7 +458,9 @@ static void nlmclnt_locks_init_private(s
 static void do_vfs_lock(struct file_lock *fl)
 {
 	int res = 0;
-	switch (fl->fl_flags & (FL_POSIX|FL_FLOCK)) {
+	unsigned char flags = fl->fl_flags & (FL_POSIX|FL_FLOCK);
+
+	switch (flags) {
 		case FL_POSIX:
 			res = posix_lock_file_wait(fl->fl_file, fl);
 			break;
@@ -469,8 +471,8 @@ static void do_vfs_lock(struct file_lock
 			BUG();
 	}
 	if (res < 0)
-		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
-				__FUNCTION__);
+		printk(KERN_WARNING "%s: VFS is out of sync with lock manager! -- %s: %d\n",
+				__FUNCTION__, flags == FL_POSIX ? "POSIX" : "FLOCK", res);
 }
 
 /*
-- 
Chuck
