Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264971AbUEYQ6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUEYQ6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUEYQ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 12:58:38 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:55787 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264971AbUEYQ63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 12:58:29 -0400
Date: Tue, 25 May 2004 10:58:28 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
Cc: Adam Cassar <adam.cassar@netregistry.com.au>
Subject: Re: [Ext2-devel] Re: problems with ext3 fs, kernels up to 2.6.6-rc2
Message-ID: <20040525165828.GC2603@schnapps.adilger.int>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
	Adam Cassar <adam.cassar@netregistry.com.au>
References: <20040519104152.GM19183@stingr.net> <20040519170604.GS18086@schnapps.adilger.int> <20040520064051.GP19183@stingr.net> <20040520092245.GE24219@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520092245.GE24219@schnapps.adilger.int>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 20, 2004  03:22 -0600, Andreas Dilger wrote:
> This seems to fix the majority of the problems, although there are still
> some rare failures in the rename test.
> 
> ===== fs/ext3/namei.c 1.52 vs edited =====
> --- 1.52/fs/ext3/namei.c	Mon May 10 05:25:34 2004
> +++ edited/fs/ext3/namei.c	Thu May 20 03:16:43 2004
> @@ -2264,8 +2264,9 @@
>  	/*
>  	 * ok, that's it
>  	 */
> -	retval = ext3_delete_entry(handle, old_dir, old_de, old_bh);
> -	if (retval == -ENOENT) {
> +	if (le32_to_cpu(old_de->inode) != old_inode->i_ino ||
> +	    (retval = ext3_delete_entry(handle, old_dir,
> +					old_de, old_bh)) ==  -ENOENT) {
>  		/*
>  		 * old_de could have moved out from under us.
>  		 */

I isolated the source of the remaining problems.  In very rare cases
even with the above patch we could still do the wrong thing.  If old_de
is pointing to the newly-added entry (i_ino is the same) we end up
deleting the new entry instead of the old one.  It looks as if the
rename never happened.  We need to verify that the name we are unlinking
is what we expect.

If is also possible that old_de is pointing to the now-unused space
at the end of a newly-split leaf block, so we still need to try
ext3_delete_entry() (which will skip the stale entry and return ENOENT)
instead of just relying on the inum + name check.

===== fs/ext3/namei.c 1.52 vs edited =====
--- 1.52/fs/ext3/namei.c	Mon May 10 05:25:34 2004
+++ edited/fs/ext3/namei.c	Thu May 20 19:57:10 2004
@@ -2264,11 +2264,15 @@
 	/*
 	 * ok, that's it
 	 */
-	retval = ext3_delete_entry(handle, old_dir, old_de, old_bh);
-	if (retval == -ENOENT) {
-		/*
-		 * old_de could have moved out from under us.
-		 */
+	if (le32_to_cpu(old_de->inode) != old_inode->i_ino ||
+	    old_de->name_len != old_dentry->d_name.len ||
+	    strncmp(old_de->name, old_dentry->d_name.name, old_de->name_len) ||
+	    (retval = ext3_delete_entry(handle, old_dir,
+					old_de, old_bh)) == -ENOENT) {
+		/* old_de could have moved from under us during htree split, so
+		 * make sure that we are deleting the right entry.  We might
+		 * also be pointing to a stale entry in the unused part of
+		 * old_bh so just checking inum and the name isn't enough. */
 		struct buffer_head *old_bh2;
 		struct ext3_dir_entry_2 *old_de2;
 
Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

