Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWJSNUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWJSNUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWJSNUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:20:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3593 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751604AbWJSNUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:20:08 -0400
Date: Thu, 19 Oct 2006 15:20:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: swhiteho@redhat.com
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/gfs2/dir.c:gfs2_dir_write_data(): don't use an uninitialized variable
Message-ID: <20061019132003.GN3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the "if (extlen)" case, "new" might be used uninitialized.

Looking at the code, it should be initialized to 0.

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/fs/gfs2/dir.c.old	2006-10-19 01:08:00.000000000 +0200
+++ linux-2.6/fs/gfs2/dir.c	2006-10-19 01:08:18.000000000 +0200
@@ -169,37 +169,37 @@ static int gfs2_dir_write_data(struct gf
 		return gfs2_dir_write_stuffed(ip, buf, (unsigned int)offset,
 					      size);
 
 	if (gfs2_assert_warn(sdp, gfs2_is_jdata(ip)))
 		return -EINVAL;
 
 	if (gfs2_is_stuffed(ip)) {
 		error = gfs2_unstuff_dinode(ip, NULL);
 		if (error)
 			return error;
 	}
 
 	lblock = offset;
 	o = do_div(lblock, sdp->sd_jbsize) + sizeof(struct gfs2_meta_header);
 
 	while (copied < size) {
 		unsigned int amount;
 		struct buffer_head *bh;
-		int new;
+		int new = 0;
 
 		amount = size - copied;
 		if (amount > sdp->sd_sb.sb_bsize - o)
 			amount = sdp->sd_sb.sb_bsize - o;
 
 		if (!extlen) {
 			new = 1;
 			error = gfs2_extent_map(&ip->i_inode, lblock, &new,
 						&dblock, &extlen);
 			if (error)
 				goto fail;
 			error = -EIO;
 			if (gfs2_assert_withdraw(sdp, dblock))
 				goto fail;
 		}
 
 		if (amount == sdp->sd_jbsize || new)
 			error = gfs2_dir_get_new_buffer(ip, dblock, &bh);

