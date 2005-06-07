Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVFGCcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVFGCcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVFGCaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:30:00 -0400
Received: from mail.ccur.com ([208.248.32.212]:18979 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261469AbVFGC3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:29:17 -0400
Subject: NFS: NFS3 lookup fails if creating a file with O_EXCL & multiple
	mountpoints in pathname
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1118104107.13894.20.camel@lindad>
References: <1112921570.6182.16.camel@lindad>
	 <1112965872.15565.34.camel@lade.trondhjem.org>
	 <1112993686.7459.4.camel@lindad>  <1113009804.7459.9.camel@lindad>
	 <1118104107.13894.20.camel@lindad>
Content-Type: text/plain
Organization: CCUR
Message-Id: <1118111348.13894.29.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 06 Jun 2005 22:29:08 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2005 02:29:08.0602 (UTC) FILETIME=[AEC58DA0:01C56B08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

One of our applications was doing an open on a NFS client with the flags
set for O_WRONLY|O_CREAT|O_EXCL|0x4. There are numerous symlinks in the
pathname for the file that go into two different NFS filesystems. The
file create works properly if the filesystems are mounted as NFS2, but
it fails with NFS3 mounts.
 
In nfs_lookup() there is a check to see if it is an exclusive create.
If it is exclusive, nfs_lookup() bypasses ("optimizes" away) the rest
of the lookup. When the problem occurs, I see it stop the lookup too
early. This only occurs when the basename portion of the pathname is
not currently in the NFS cache from a previous non- O_EXCL pathname lookup.
 
The nfs_is_exclusive_create() was returning TRUE, even when the
search wasn't at the last pathname component. This occurred because
the LOOKUP_CONTINUE flag is reset when it crosses the second
mountpoint into the NFS filesystem.  nfs_is_exclusive_create() was
trying to use this flag to determine if it was at the end point
of the pathname search. Since it was reset when it crossed the
mountpoint boundary, it returned TRUE several pathname levels too
early.
 
I changed the nfs_is_exclusive_create() to use the LOOKUP_PARENT
flag instead of the LOOKUP_CONTINUE flag. I found that LOOKUP_PARENT
stays set until you get to the very last pathname level, which is
the correct point for it to check whether it is an exclusive create.

The following patch for 2.6.12-rc5 fixed the problem.

Regards,
Linda

diff -ura base/fs/nfs/dir.c new/fs/nfs/dir.c
--- base/fs/nfs/dir.c	2005-06-06 20:59:22.000000000 -0400
+++ new/fs/nfs/dir.c	2005-06-06 22:14:24.000000000 -0400
@@ -705,7 +705,7 @@
 {
 	if (NFS_PROTO(dir)->version == 2)
 		return 0;
-	if (!nd || (nd->flags & LOOKUP_CONTINUE) || !(nd->flags & LOOKUP_CREATE))
+	if (!nd || (nd->flags & LOOKUP_PARENT) || !(nd->flags & LOOKUP_CREATE))
 		return 0;
 	return (nd->intent.open.flags & O_EXCL) != 0;
 }


