Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUJNS7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUJNS7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUJNS4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:56:06 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:11301 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S267352AbUJNSyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:54:19 -0400
Date: Thu, 14 Oct 2004 14:54:18 -0400
From: Jeffrey Mahoney <jeffm@csh.rit.edu>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Hans Reiser <reiser@namesys.com>
Subject: [PATCH 1/2] reiserfs: support for REISERFS_UNSUPPORTED_OPT notation
Message-ID: <20041014185418.GB9619@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.108-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a REISERFS_UNSUPPORTED_OPT flag to denote when a mount option
is allowable, but is unsupported in the running configuration. This allows
the potential for the set of mount options to be consistent, regardless of
what features the kernel is compiled with.

Rather than failing the mount, a warning is issued and the mount succeeds.

Signed-off-by: Jeff Mahoney <jeffm@novell.com>

diff -ruPX dontdiff linux-2.6.8/fs/reiserfs/super.c linux-2.6.8.fix/fs/reiserfs/super.c
--- linux-2.6.8/fs/reiserfs/super.c	2004-10-08 16:46:09.070660248 -0400
+++ linux-2.6.8.fix/fs/reiserfs/super.c	2004-10-08 16:42:59.896419104 -0400
@@ -659,8 +659,14 @@
     for (opt = opts; opt->option_name; opt ++) {
 	if (!strncmp (p, opt->option_name, strlen (opt->option_name))) {
 	    if (bit_flags) {
-		*bit_flags &= ~opt->clrmask;
-		*bit_flags |= opt->setmask;
+                if (opt->clrmask == (1 << REISERFS_UNSUPPORTED_OPT))
+                    reiserfs_warning (s, "%s not supported.", p);
+                else
+                    *bit_flags &= ~opt->clrmask;
+                if (opt->setmask == (1 << REISERFS_UNSUPPORTED_OPT))
+                    reiserfs_warning (s, "%s not supported.", p);
+                else
+                    *bit_flags |= opt->setmask;
 	    }
 	    break;
 	}
diff -ruPX dontdiff linux-2.6.8/include/linux/reiserfs_fs_sb.h linux-2.6.8.fix/include/linux/reiserfs_fs_sb.h
--- linux-2.6.8/include/linux/reiserfs_fs_sb.h	2004-10-08 16:46:04.541348808 -0400
+++ linux-2.6.8.fix/include/linux/reiserfs_fs_sb.h	2004-10-08 16:31:50.641161368 -0400
@@ -467,6 +467,7 @@
     REISERFS_TEST2,
     REISERFS_TEST3,
     REISERFS_TEST4,
+    REISERFS_UNSUPPORTED_OPT,
 };
 
 #define reiserfs_r5_hash(s) (REISERFS_SB(s)->s_mount_opt & (1 << FORCE_R5_HASH))
