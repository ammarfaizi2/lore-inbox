Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTHTMaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 08:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTHTMaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 08:30:22 -0400
Received: from main.gmane.org ([80.91.224.249]:61915 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261901AbTHTMaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 08:30:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: how to turn off, or to clear read cache?
Date: Wed, 20 Aug 2003 14:30:18 +0200
Message-ID: <yw1xlltocy05.fsf@users.sourceforge.net>
References: <3F4360F0.209@gamic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:xOnIc4Nj7iY9qVMVb3PRswa7lNI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Spiridonov <spiridonov@gamic.com> writes:

> I need to make some performance tests. I need to switch off or to
> clear read cache, so that consequent reading of the same file will
> take the same amount of time.
>
> Is there an easy way to do it, without rebuilding the kernel?

I never found one, so I made this little patch.  It adds a mount
option to the ext3 filesystem that makes it drop the cache when a file
is closed.  Diff is against 2.4.21.  It's just a quick hack that
accomplishes what I needed.  I'm sure there's a better, more generic,
way.

Index: include/linux/ext3_fs.h
===================================================================
RCS file: /home/cvs/linux-2.4/include/linux/ext3_fs.h,v
retrieving revision 1.8
diff -u -r1.8 ext3_fs.h
--- include/linux/ext3_fs.h	1 Apr 2003 21:09:23 -0000	1.8
+++ include/linux/ext3_fs.h	17 Jun 2003 09:10:56 -0000
@@ -339,6 +339,7 @@
   #define EXT3_MOUNT_WRITEBACK_DATA	0x0C00	/* No data ordering */
 #define EXT3_MOUNT_UPDATE_JOURNAL	0x1000	/* Update the journal format */
 #define EXT3_MOUNT_NO_UID32		0x2000  /* Disable 32-bit UIDs */
+#define EXT3_MOUNT_NOCACHE		0x4000  /* Free cached blocks on close */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H
Index: fs/ext3/file.c
===================================================================
RCS file: /home/cvs/linux-2.4/fs/ext3/file.c,v
retrieving revision 1.4
diff -u -r1.4 file.c
--- fs/ext3/file.c	28 Aug 2002 21:11:16 -0000	1.4
+++ fs/ext3/file.c	17 Jun 2003 09:10:57 -0000
@@ -35,6 +35,10 @@
 {
 	if (filp->f_mode & FMODE_WRITE)
 		ext3_discard_prealloc (inode);
+	if (inode->i_sb->u.ext3_sb.s_mount_opt & EXT3_MOUNT_NOCACHE){
+		write_inode_now(inode, 1);
+		invalidate_inode_pages(inode);
+	}
 	return 0;
 }
 
Index: fs/ext3/super.c
===================================================================
RCS file: /home/cvs/linux-2.4/fs/ext3/super.c,v
retrieving revision 1.10
diff -u -r1.10 super.c
--- fs/ext3/super.c	28 Apr 2003 21:14:51 -0000	1.10
+++ fs/ext3/super.c	17 Jun 2003 09:10:59 -0000
@@ -654,6 +654,8 @@
 			if (want_numeric(value, "commit", &v))
 				return 0;
 			sbi->s_commit_interval = (HZ * v);
+		} else if (!strcmp (this_char, "nocache")){
+			set_opt (*mount_options, NOCACHE);
 		} else {
 			printk (KERN_ERR 
 				"EXT3-fs: Unrecognized mount option %s\n",


-- 
Måns Rullgård
mru@users.sf.net

