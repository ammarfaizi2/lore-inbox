Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTDVBg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 21:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTDVBg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 21:36:57 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:48644 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262776AbTDVBgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 21:36:55 -0400
Message-Id: <200304220151.h3M1pt2u024353@pasta.boston.redhat.com>
To: Andrew Morton <akpm@digeo.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Stephen Tweedie <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1 fs/ext3/super.c fix for orphan recovery error path
In-Reply-To: Your message of "Mon, 21 Apr 2003 15:08:09 PDT."
Date: Mon, 21 Apr 2003 21:51:55 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 21-Apr-2003 at 15:8 PDT, Andrew Morton wrote:

> Ernie Petrides <petrides@redhat.com> wrote:
>
> > Stephen/Andrew, please consider applying this patch to reverse the order
> > of checks in ext3_orphan_cleanup() for read-only mounts and prior errors.
> >
> > The problem resolved by this patch is that if a root file system has an
> > error recorded from a previous mount, and then (when rebooting) the orphan
> > recovery procedure is initiated, the recovery is correctly skipped but the
> > file system is incorrectly left in a writable state.
> >
> > This causes the subsequent fsck to fail due to the root file system
> > being dirty, and then requires manual intervention to get the system
> > fully booted.
> >
> > Thanks in advance.  -ernie
>
> Thanks, that is definitely needed.  We should do this in 2.4 as well.

Andrew, thank you for reviewing and supporting this patch.

Marcelo, on Andrew's recommendation, I have included a 2.4-based patch
below for your convenience.

Cheers.  -ernie



diff -urpN linux-2.4.21-rc1/fs/ext3/super.c{.orig,}
--- linux-2.4.21-rc1/fs/ext3/super.c.orig	2003-04-21 21:12:43.000000000 -0400
+++ linux-2.4.21-rc1/fs/ext3/super.c	2003-04-21 21:16:23.000000000 -0400
@@ -820,12 +820,6 @@ static void ext3_orphan_cleanup (struct 
 		return;
 	}
 
-	if (s_flags & MS_RDONLY) {
-		printk(KERN_INFO "EXT3-fs: %s: orphan cleanup on readonly fs\n",
-		       bdevname(sb->s_dev));
-		sb->s_flags &= ~MS_RDONLY;
-	}
-
 	if (sb->u.ext3_sb.s_mount_state & EXT3_ERROR_FS) {
 		if (es->s_last_orphan)
 			jbd_debug(1, "Errors on filesystem, "
@@ -835,6 +829,12 @@ static void ext3_orphan_cleanup (struct 
 		return;
 	}
 
+	if (s_flags & MS_RDONLY) {
+		printk(KERN_INFO "EXT3-fs: %s: orphan cleanup on readonly fs\n",
+		       bdevname(sb->s_dev));
+		sb->s_flags &= ~MS_RDONLY;
+	}
+
 	while (es->s_last_orphan) {
 		struct inode *inode;
 
