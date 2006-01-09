Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWAICuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWAICuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWAICuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:50:25 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:20299 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750711AbWAICuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:50:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=NIttoZ2BD7kBBU7wvlr1rPkDrymr3UPzB/Ygv7tcsLCn3etw0BHROlZYvU4OBSmoP1i/Sx41lYHUnUG1JLi04HM7aehTlefCkK9ygL4f9VuY/2qBlCuh4Gr0oWNhDnoU0/Kl5miBDrkpXiUilrpCa2xzMkyeyWXaL1uQv/0berA=
Message-ID: <43C1CE74.4000302@gmail.com>
Date: Sun, 08 Jan 2006 21:46:12 -0500
From: Segin <segin2005@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051202)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Minix 3 filesystem support
Content-Type: multipart/mixed;
 boundary="------------030502080202090202000403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030502080202090202000403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached email contains diffs for making the Minix version 3 
filesystem work with Linux.

Please note that I do not subscribe to the mailing list.

Also, please send all replies about this patch which would normally be 
emailed to me to the newsgroup comp.os.minix. I did not write this 
patch, I am just making it available to the Linux kernel mailing list.

The patch author's email address is <danarag@gmail.com>

--------------030502080202090202000403
Content-Type: message/rfc822;
 name="Re: Anyone successfully mounted the Minix3 filesystem from Linux?"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: Anyone successfully mounted the Minix3 filesystem from Linux?"

Path: news-wrt-01.tampabay.rr.com!be1.texas.rr.com!cyclone.austin.rr.com!news.rr.com!border2.nntp.dca.giganews.com!border1.nntp.dca.giganews.com!nntp.giganews.com!postnews.google.com!f14g2000cwb.googlegroups.com!not-for-mail
From: "Daniel" <danarag@gmail.com>
Newsgroups: comp.os.minix
Subject: Re: Anyone successfully mounted the Minix3 filesystem from Linux?
Date: 5 Jan 2006 06:29:24 -0800
Organization: http://groups.google.com
Message-ID: <1136471364.571771.90670@f14g2000cwb.googlegroups.com>
References: <0D0vf.73$oD4.17791@news.uswest.net>
   <Ym5vf.518$2i3.392@tornado.tampabay.rr.com>
NNTP-Posting-Host: 62.57.76.12
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
X-Trace: posting.google.com 1136471369 23380 127.0.0.1 (5 Jan 2006 14:29:29 GMT)
X-Complaints-To: groups-abuse@google.com
NNTP-Posting-Date: Thu, 5 Jan 2006 14:29:29 +0000 (UTC)
User-Agent: G2/0.2
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Win 9x 4.90; es-ES; rv:1.7.12) Gecko/20050919 Firefox/1.0.7,gzip(gfe),gzip(gfe)
Complaints-To: groups-abuse@google.com
Injection-Info: f14g2000cwb.googlegroups.com; posting-host=62.57.76.12;
   posting-account=8dhvHw0AAAAQ9vUW-tbNxLhRauOXVnjn
Xref: news-wrt-01.tampabay.rr.com comp.os.minix:18210

I have half succeeded. Read Only by now. I am working on the patch.
Here it is:

diff -ur linux-2.6.14.5/fs/minix/inode.c
modified_linux-2.6.14.5/fs/minix/inode.c
--- linux-2.6.14.5/fs/minix/inode.c	2005-12-27 01:26:33.000000000 +0100
+++ modified_linux-2.6.14.5/fs/minix/inode.c	2006-01-05
14:57:25.000000000 +0100
@@ -7,6 +7,7 @@
  *	Minix V2 fs support.
  *
  *  Modified for 680x0 by Andreas Schwab
+ *  Wrongly updated to version V3 by Daniel. January 5 2006
  */

 #include <linux/module.h>
@@ -24,7 +25,6 @@

 static void minix_delete_inode(struct inode *inode)
 {
-	truncate_inode_pages(&inode->i_data, 0);
 	inode->i_size = 0;
 	minix_truncate(inode);
 	minix_free_inode(inode);
@@ -35,7 +35,7 @@
 	int i;
 	struct minix_sb_info *sbi = minix_sb(sb);

-	if (!(sb->s_flags & MS_RDONLY)) {
+	if (!(sb->s_flags & MS_RDONLY) && (sbi->s_version != MINIX_V3)) {
 		sbi->s_ms->s_state = sbi->s_mount_state;
 		mark_buffer_dirty(sbi->s_sbh);
 	}
@@ -118,19 +118,22 @@
 			return 0;
 		/* Mounting a rw partition read-only. */
 		ms->s_state = sbi->s_mount_state;
-		mark_buffer_dirty(sbi->s_sbh);
+			if (sbi->s_version != MINIX_V3)
+			mark_buffer_dirty(sbi->s_sbh);
 	} else {
 	  	/* Mount a partition which is read-only, read-write. */
 		sbi->s_mount_state = ms->s_state;
 		ms->s_state &= ~MINIX_VALID_FS;
-		mark_buffer_dirty(sbi->s_sbh);
+			if (sbi->s_version != MINIX_V3)
+			mark_buffer_dirty(sbi->s_sbh);
+
+		if (!(sbi->s_mount_state & MINIX_VALID_FS) && (sbi->s_version !=
MINIX_V3))
+			printk ("MINIX-fs warning: remounting unchecked V%i fs, "
+				"running fsck is recommended.\n", sbi->s_version);
+		else if ((sbi->s_mount_state & MINIX_ERROR_FS) && (sbi->s_version !=
MINIX_V3))
+			printk ("MINIX-fs warning: remounting  V%i fs with errors, "
+				"running fsck is recommended.\n", sbi->s_version);

-		if (!(sbi->s_mount_state & MINIX_VALID_FS))
-			printk ("MINIX-fs warning: remounting unchecked fs, "
-				"running fsck is recommended.\n");
-		else if ((sbi->s_mount_state & MINIX_ERROR_FS))
-			printk ("MINIX-fs warning: remounting fs with errors, "
-				"running fsck is recommended.\n");
 	}
 	return 0;
 }
@@ -197,6 +200,23 @@
 		sbi->s_dirsize = 32;
 		sbi->s_namelen = 30;
 		sbi->s_link_max = MINIX2_LINK_MAX;
+	} else if ( *(__u16 *)(bh->b_data + 24) == MINIX3_SUPER_MAGIC) {
+
+		s->s_magic = MINIX3_SUPER_MAGIC;
+		sbi->s_imap_blocks = *(__u16 *)(bh->b_data + 6);
+		sbi->s_zmap_blocks = *(__u16 *)(bh->b_data + 8);
+		sbi->s_firstdatazone = *(__u16 *)(bh->b_data + 10);
+		sbi->s_log_zone_size = *(__u16 *)(bh->b_data + 12);
+		sbi->s_max_size = *(__u32 *)(bh->b_data + 16);
+		sbi->s_nzones = *(__u32 *)(bh->b_data + 20);
+		sbi->s_dirsize = 64;
+		sbi->s_namelen = 60;
+		sbi->s_version = MINIX_V3;
+		sbi->s_link_max = MINIX2_LINK_MAX;
+			if ( *(__u16 *)(bh->b_data + 28) != 1024) {
+				if (!sb_set_blocksize(s,( *(__u16 *)(bh->b_data + 28))))
+ 				goto out_bad_hblock;
+		}
 	} else
 		goto out_no_fs;

@@ -239,16 +259,16 @@
 	if (!NO_TRUNCATE)
 		s->s_root->d_op = &minix_dentry_operations;

-	if (!(s->s_flags & MS_RDONLY)) {
+	if (!(s->s_flags & MS_RDONLY) && (sbi->s_version != MINIX_V3)) {
 		ms->s_state &= ~MINIX_VALID_FS;
 		mark_buffer_dirty(bh);
 	}
-	if (!(sbi->s_mount_state & MINIX_VALID_FS))
-		printk ("MINIX-fs: mounting unchecked file system, "
-			"running fsck is recommended.\n");
- 	else if (sbi->s_mount_state & MINIX_ERROR_FS)
-		printk ("MINIX-fs: mounting file system with errors, "
-			"running fsck is recommended.\n");
+	if (!(sbi->s_mount_state & MINIX_VALID_FS) && (sbi->s_version !=
MINIX_V3))
+		printk ("MINIX-fs: mounting unchecked  V%i file system, "
+			"running fsck is recommended.\n", sbi->s_version);
+ 	else if ((sbi->s_mount_state & MINIX_ERROR_FS) && (sbi->s_version !=
MINIX_V3))
+		printk ("MINIX-fs: mounting  V%i file system with errors, "
+			"running fsck is recommended.\n", sbi->s_version);
 	return 0;

 out_iput:
@@ -277,7 +297,7 @@

 out_no_fs:
 	if (!silent)
-		printk("VFS: Can't find a Minix or Minix V2 filesystem on device "
+		printk("VFS: Can't find a Minix V1|V2|V3 filesystem on device "
 		       "%s.\n", s->s_id);
     out_release:
 	brelse(bh);
diff -ur linux-2.6.14.5/fs/minix/minix.h
modified_linux-2.6.14.5/fs/minix/minix.h
--- linux-2.6.14.5/fs/minix/minix.h	2005-12-27 01:26:33.000000000 +0100
+++ modified_linux-2.6.14.5/fs/minix/minix.h	2006-01-05
14:55:00.000000000 +0100
@@ -12,6 +12,7 @@

 #define MINIX_V1		0x0001		/* original minix fs */
 #define MINIX_V2		0x0002		/* minix V2 fs */
+#define MINIX_V3		0x0003		/* minix V3 fs */

 /*
  * minix fs inode data in memory
diff -ur linux-2.6.14.5/include/linux/minix_fs.h
modified_linux-2.6.14.5/include/linux/minix_fs.h
--- linux-2.6.14.5/include/linux/minix_fs.h	2005-12-27
01:26:33.000000000 +0100
+++ modified_linux-2.6.14.5/include/linux/minix_fs.h	2006-01-05
14:54:06.000000000 +0100
@@ -23,6 +23,7 @@
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC	0x2468		/* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2	0x2478		/* minix V2 fs, 30 char names */
+#define MINIX3_SUPER_MAGIC	0x4d5a		/* minix V3 fs */
 #define MINIX_VALID_FS		0x0001		/* Clean fs. */
 #define MINIX_ERROR_FS		0x0002		/* fs has errors. */

@@ -78,7 +79,7 @@
 };

 struct minix_dir_entry {
-	__u16 inode;
+	__u32 inode;
 	char name[0];
 };


The remaining work is just here at the end in the structure
minix_dir_entry: How to merge the 16 bit pointers to the directories in
the old version with the 32 bit pointers in the new one.

Something will have to be patched also in dir.c


--------------030502080202090202000403--
