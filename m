Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUBEN4Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUBEN4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:56:19 -0500
Received: from intra.cyclades.com ([64.186.161.6]:16566 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265252AbUBENy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:54:58 -0500
Date: Thu, 5 Feb 2004 11:47:11 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: torvalds@osdl.org, tytso@mit.edu, sct@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] ext2: update inode ctime on rename()
Message-ID: <Pine.LNX.4.58L.0402041855230.2391@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Chris Siebenmann posted a fix to update the old inode ctime on rename().

This fix went into 2.2.13, but did not make into 2.4 or 2.6 kernels (the
2.2.13 diff is at the end of this message).

Here is updated 2.6 version without mark_inode_dirty(), which is not
necessary anymore because its called by "ext2_dec_count()" few lines
down.

--- a/linux-2.6.1/fs/ext2/namei.c	2004-01-09 04:59:56.000000000 -0200
+++ linux-2.6.1/fs/ext2/namei.c	2004-02-05 11:44:05.922691472 -0200
@@ -356,6 +356,13 @@
 			ext2_inc_count(new_dir);
 	}

+	/*
+	 * Like most other Unix systems, set the ctime for inodes on a
+ 	 * rename.
+	 * ext2_dec_count() will mark the inode dirty.
+	 */
+	old_inode->i_ctime = CURRENT_TIME;
+
 	ext2_delete_entry (old_de, old_page);
 	ext2_dec_count(old_inode);




On Wed, 21 Jan 2004, Chris Siebenmann wrote:

>  Ext2 in 2.2.13+ updates the ctime of an inode on rename(), but this fix
> didn't make it into 2.4. Other filesystems (including ext3) do update
> inode ctime on rename in 2.4, and failure to do so makes various backup
> tools skip backing up renamed files during incremental backups. Here is
> the very simple patch to fix this.
>
>  My earlier message to linux-kernel and ext2-devel has a longer
> discussion of the situation; you can find it at
> 	http://www.ussg.iu.edu/hypermail/linux/kernel/0401.1/0594.html
> (Or with the original subject in a local archive of linux-kernel).
> It hasn't gotten any replies, which may or may not be a good sign.
>
>  Because I feel that not capturing renamed files in incremental
> backups is a fairly severe issue, I urge you to apply this patch
> to 2.4. It's run here on several systems for quite a while without
> apparent problems.
>
> ===== fs/ext2/namei.c 1.3 vs edited =====
> --- 1.3/fs/ext2/namei.c	Tue Feb  5 02:41:03 2002
> +++ edited/fs/ext2/namei.c	Wed Dec 10 17:13:30 2003
> @@ -313,6 +313,13 @@
>  			ext2_inc_count(new_dir);
>  	}
>
> +	/*
> +	 * Like most other Unix systems, set the ctime for inodes on a
> +	 * rename.
> +	 */
> +	old_inode->i_ctime = CURRENT_TIME;
> +	mark_inode_dirty(old_inode);		/* still necessary? */
> +
>  	ext2_delete_entry (old_de, old_page);
>  	ext2_dec_count(old_inode);

The 2.2 fix:

diff -u --recursive --new-file v2.2.12/linux/fs/ext2/namei.c
linux/fs/ext2/namei.c
--- v2.2.12/linux/fs/ext2/namei.c       Thu May 13 23:25:58 1999
+++ linux/fs/ext2/namei.c       Tue Oct 19 17:14:01 1999
@@ -883,6 +883,13 @@
        new_dir->i_version = ++event;

        /*
+        * Like most other Unix systems, set the ctime for inodes on a
+        * rename.
+        */
+       old_inode->i_ctime = CURRENT_TIME;
+       mark_inode_dirty(old_inode);
+
+       /*
         * ok, that's it
         */
        new_de->inode = le32_to_cpu(old_inode->i_ino);

