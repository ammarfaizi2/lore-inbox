Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUESRGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUESRGO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 13:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUESRGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 13:06:14 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:52155 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264414AbUESRGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 13:06:10 -0400
Date: Wed, 19 May 2004 11:06:04 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
Subject: Re: problems with ext3 fs, kernels up to 2.6.6-rc2
Message-ID: <20040519170604.GS18086@schnapps.adilger.int>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
References: <20040519104152.GM19183@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519104152.GM19183@stingr.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 19, 2004  14:41 +0400, Paul P Komkoff Jr wrote:
> For a long time I'm sorta have the following problem.
> 
> I have ext3 partition with dir_index turned on. I have programs, which
> store many files on it (for example, Maildir mailboxes for 500+ users,
> about 200k files).
> 
> Sometimes something going wrong. I am noticing it by rdiff-backup on
> this partition producing the following output:
> ListError goloub/Maildir/cur/1082623479.1763_0.ns:2,S [Errno 5]
> Input/output error:
> +'/mnt/mail/goloub/Maildir/cur/1082623479.1763_0.ns:2,S'
> 
> Yes, when I am doing strace ls -al (failed file), I am seeing -EIO
> 
> lstat64("/mnt/mail/goloub/Maildir/cur/1082623479.1763_0.ns:2,S",
> 0x806408c) = -1 EIO (Input/output error)
> 
> I know, so when I will e2fsck it it will be repaired. But how I can
> help debug it?
> 
> Which on-disk structs I need to examine, maybe extract, and send to
> someone?

A problem with htree was recently discovered during Lustre testing when
files were being renamed within the same directory.  In some cases the
addition of the new name caused a directory block split and the old
dir_entry was pointing at the wrong entry, and the wrong entry was removed.
This would seem entirely possible in a Maildir directory, since the MTA
will be doing a lot of renames within the same directory.

This seems to fix the majority of the problems, although there are still
some rare failures in the rename test.

===== fs/ext3/namei.c 1.52 vs edited =====
--- 1.52/fs/ext3/namei.c        Mon May 10 05:25:34 2004
+++ edited/fs/ext3/namei.c      Wed May 19 10:59:39 2004
@@ -2265,7 +2265,9 @@
 	 * ok, that's it
 	 */
 	retval = ext3_delete_entry(handle, old_dir, old_de, old_bh);
-	if (retval == -ENOENT) {
+	if (le32_to_cpu(old_de->inode) != old_inode->i_ino ||
+	    (retval = ext3_delete_entry(handle, old_dir, old_de, old_bh)) ==
+	    -ENOENT) {
 		/*
 		 * old_de could have moved out from under us.
 		 */

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

