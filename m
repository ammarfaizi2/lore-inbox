Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUEPHEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUEPHEh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 03:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUEPHEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 03:04:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:41657 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263309AbUEPHEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 03:04:34 -0400
Date: Sun, 16 May 2004 00:04:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@ucw.cz>
Cc: linux-kernel@vger.kernel.org, lukasz@wsisiz.edu.pl,
       j.borsboom@erasmusmc.nl, crosser@average.org, torvalds@osdl.org
Subject: Re: [PATCH] Quota fix 2
Message-Id: <20040516000401.506d8456.akpm@osdl.org>
In-Reply-To: <20040515192824.GB21471@atrey.karlin.mff.cuni.cz>
References: <20040515192824.GB21471@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@ucw.cz> wrote:
>
>   another fix for quota code - it fixes the problem with recursion into
>  filesystem when inode of quota file needs a page + some other allocation
>  problems.

It makes sense.

> I hope I got the GFP mask setting right..

nope!  Here's a fix against your patch.




---

 25-akpm/fs/dquot.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -puN fs/dquot.c~quota-recursion-fix-fix fs/dquot.c
--- 25/fs/dquot.c~quota-recursion-fix-fix	2004-05-15 23:58:31.365278768 -0700
+++ 25-akpm/fs/dquot.c	2004-05-16 00:02:52.667554784 -0700
@@ -1372,7 +1372,16 @@ static int vfs_quota_on_file(struct file
 	 * into filesystem when allocating page for quota inode */
 	down_write(&dqopt->dqptr_sem);
 	inode->i_flags |= S_NOQUOTA | S_NOATIME;
-	clear_bit(ffs(__GFP_FS), &inode->i_mapping->flags);
+
+	/*
+	 * We write to quota files deep within filesystem code.  We don't want
+	 * the VFS to reenter filesystem code when it tries to allocate a
+	 * pagecache page for the quota file write.  So clear __GFP_FS in
+	 * the quota file's allocation flags.
+	 */
+	mapping_set_gfp_mask(inode->i_mapping,
+		mapping_gfp_mask(inode->i_mapping) & ~__GFP_FS);
+
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		to_drop[cnt] = inode->i_dquot[cnt];
 		inode->i_dquot[cnt] = NODQUOT;

_

