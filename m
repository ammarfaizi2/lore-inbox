Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTAVURs>; Wed, 22 Jan 2003 15:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTAVURs>; Wed, 22 Jan 2003 15:17:48 -0500
Received: from tsv.sws.net.au ([203.36.46.2]:42503 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S262807AbTAVURr>;
	Wed, 22 Jan 2003 15:17:47 -0500
Date: Wed, 22 Jan 2003 21:26:40 +0100
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: patch for open file handles with initrd in 2.4.20
Message-ID: <20030122202640.GA17661@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: russell@coker.com.au (Russell Coker)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch was back-ported from 2.5.x by Stephen Smalley to fix a
problem where the file handle of the root of the initrd is inherited by init
and other processes.

The bug was discovered when running SE Linux on 2.4.20 systems with a policy
that denied such inheriting of file handles and logged the operations it
denied.

This patch has been well tested, please include it in 2.4.21.


--- linux-2.4.20.lsm-old/init/do_mounts.c	2002-12-13 19:33:23.000000000 +0100
+++ linux-2.4.20.lsm/init/do_mounts.c	2002-12-13 19:36:48.000000000 +0100
@@ -812,6 +812,8 @@
 	/* switch root and cwd back to / of rootfs */
 	sys_fchdir(root_fd);
 	sys_chroot(".");
+	close(old_fd);
+	close(root_fd);
 	sys_umount("/old/dev", 0);
 
 	if (real_root_dev == ram0) {
