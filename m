Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265036AbUETJWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbUETJWw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 05:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUETJWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 05:22:51 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:8071 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265036AbUETJWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 05:22:49 -0400
Date: Thu, 20 May 2004 03:22:45 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: problems with ext3 fs, kernels up to 2.6.6-rc2
Message-ID: <20040520092245.GE24219@schnapps.adilger.int>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
References: <20040519104152.GM19183@stingr.net> <20040519170604.GS18086@schnapps.adilger.int> <20040520064051.GP19183@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520064051.GP19183@stingr.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 20, 2004  10:40 +0400, Paul P Komkoff Jr wrote:
> Replying to Andreas Dilger:
> > This seems to fix the majority of the problems, although there are still
> > some rare failures in the rename test.
> 
> Just curious. Is it really doing what it should? Is there are cases
> where ext3_delete_entry(handle, old_dir, old_de, old_bh) will be
> called twice with the same set of parameters? :()

Grr, my bad.  I had moved this by hand from 2.4 (where this was discovered
and where I'm testing) to 2.6.current just to make sure the context and
everything was right for submissions and of course botched it.  The right
patch removes the old call to ext3_delete_entry():


===== fs/ext3/namei.c 1.52 vs edited =====
--- 1.52/fs/ext3/namei.c	Mon May 10 05:25:34 2004
+++ edited/fs/ext3/namei.c	Thu May 20 03:16:43 2004
@@ -2264,8 +2264,9 @@
 	/*
 	 * ok, that's it
 	 */
-	retval = ext3_delete_entry(handle, old_dir, old_de, old_bh);
-	if (retval == -ENOENT) {
+	if (le32_to_cpu(old_de->inode) != old_inode->i_ino ||
+	    (retval = ext3_delete_entry(handle, old_dir,
+					old_de, old_bh)) ==  -ENOENT) {
 		/*
 		 * old_de could have moved out from under us.
 		 */

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

