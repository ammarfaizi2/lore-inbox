Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVC3ToI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVC3ToI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVC3ToH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:44:07 -0500
Received: from salmon.maths.tcd.ie ([134.226.81.11]:6921 "HELO
	salmon.maths.tcd.ie") by vger.kernel.org with SMTP id S262411AbVC3Tno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:43:44 -0500
To: linux-xfs@oss.sgi.com
cc: linux-kernel@vger.kernel.org
Subject: Directory link count wrapping on Linux/XFS/i386?
Date: Wed, 30 Mar 2005 20:43:36 +0100
From: David Malone <dwmalone@maths.tcd.ie>
Message-ID: <200503302043.aa27223@salmon.maths.tcd.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking around to see how Linux handles directories with a
high link count (ie. when they have many subdirectories) and I think
I have stumbled across a bug in the Linux xfs glue.

It seems that internally xfs uses a 32 bit field for the link count,
and the stat64 syscalls use a 32 bit field. These fields are copied
via the vattr structure in xfs_vnode.h, which uses a nlink_t for
the link count. However, in the kernel, I think this field is
actually of type __kernel_nlink_t which seems to be 16 bits on many
platforms.

I've tested this on an i386 2.6.11 kernel and it seems that the
link count presented to userland wraps after 65536 subdirectories.
This naturally doesn't let you screw up the filesystem or anything,
but it does let you can hide files from find/fts, as demonstrated
below.

I guess to fix it you'd change the type of nlink in struct vattr
so that it is the same type (unsigned int) as the type in struct
kstat. I've included the obvious patch, but I don't have a machine
that I can test it on right now.

	David.

turing 2% mkdir testdir
turing 3% cd testdir
turing 4% ls -ld .
drwxr-xr-x  2 dwmalone dwmalone 6 Mar 30 12:18 .
turing 5% perl ../mk65536dirs.pl
turing 6% ls -ld .
drwxr-xr-x  2 dwmalone dwmalone 1056768 Mar 30 12:19 .
turing 7% mkdir .hidden
turing 8% touch .hidden/secret
turing 9% find . -name secret -print


--- /usr/src/linux-2.6.11/fs/xfs/linux-2.6/xfs_vnode.h	2005-03-02 07:38:33.000000000 +0000
+++ /tmp/xfs_vnode.h	2005-03-30 18:49:22.000000000 +0100
@@ -409,7 +409,7 @@
 	int		va_mask;	/* bit-mask of attributes present */
 	enum vtype	va_type;	/* vnode type (for create) */
 	mode_t		va_mode;	/* file access mode and type */
-	nlink_t		va_nlink;	/* number of references to file */
+	unsigned int	va_nlink;	/* number of references to file */
 	uid_t		va_uid;		/* owner user id */
 	gid_t		va_gid;		/* owner group id */
 	xfs_ino_t	va_nodeid;	/* file id */
