Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUFWXnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUFWXnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUFWXnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:43:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:54434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262391AbUFWXm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:42:59 -0400
Subject: [PATCH] retry force umount (was Re: NFS and umount -f)
From: Daniel McNeil <daniel@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andy <genanr@emsphone.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1086710357.3896.11.camel@lade.trondhjem.org>
References: <20040608155414.GA3975@thumper2>
	 <1086710357.3896.11.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1088034175.2319.11.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2004 16:42:55 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 08:59, Trond Myklebust wrote:
> På ty , 08/06/2004 klokka 11:54, skreiv Andy:
> > Why does this NOT do what is should be doing, i.e. umount no matter what?
> > 
> > Sometimes I get 
> > 
> > umount2 : Stale NFS file handle
> > umount : machine/path: Illegal seek
> > 
> > and it does not umount it.
> > 
> > What part of
> >  -f "Force unmount (in case of unreachable NFS system)" (umount man page)
> > 
> > does linux not understand?
> 
> Works for me...
> 

This works for me on 2.6.7 as well.  However, I would get EBUSY back
if processes were hung doing nfs operations to the downed server.
The processes would get unstuck and get EIO, but the umount would
still fail.  Doing a 2nd umount -f with no processes waiting for
the server would succeed.  This patch retries force umounts in
the kernel an extra time after giving them time to wake up and
get out of the kernel.  It doesn't seem quite right to fail
a bunch of nfs operations and leave the file system mounted.

Daniel

diff -urp linux-2.6.7.orig/fs/namespace.c linux-2.6.7/fs/namespace.c
--- linux-2.6.7.orig/fs/namespace.c	2004-06-22 16:41:15.000000000 -0700
+++ linux-2.6.7/fs/namespace.c	2004-06-23 16:28:12.986370695 -0700
@@ -363,6 +363,7 @@ static int do_umount(struct vfsmount *mn
 {
 	struct super_block * sb = mnt->mnt_sb;
 	int retval;
+	int force_retry_count = 1;
 
 	retval = security_sb_umount(mnt, flags);
 	if (retval)
@@ -376,8 +377,11 @@ static int do_umount(struct vfsmount *mn
 	 * might fail to complete on the first run through as other tasks
 	 * must return, and the like. Thats for the mount program to worry
 	 * about for the moment.
+	 * Retry FORCE umount to give processes a chance to wakeup
+	 * and get out of the file system.
 	 */
 
+retry_force_umount:
 	lock_kernel();
 	if( (flags&MNT_FORCE) && sb->s_op->umount_begin)
 		sb->s_op->umount_begin(sb);
@@ -427,6 +431,18 @@ static int do_umount(struct vfsmount *mn
 		retval = 0;
 	}
 	spin_unlock(&vfsmount_lock);
+
+	if (flags & MNT_FORCE && retval && force_retry_count-- > 0) {
+		up_write(&current->namespace->sem);
+		/*
+		 * give processes a chance to wakeup from force umount
+		 */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(10);
+		goto retry_force_umount;
+		
+	}
+
 	if (retval)
 		security_sb_umount_busy(mnt);
 	up_write(&current->namespace->sem);



