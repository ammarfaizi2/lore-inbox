Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422988AbWJSOCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422988AbWJSOCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945897AbWJSOCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:02:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32265 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422988AbWJSOCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:02:10 -0400
Date: Thu, 19 Oct 2006 16:02:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: swhiteho@redhat.com
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: gfs2_dir_read_data(): fix uninitialized variable usage
Message-ID: <20061019140207.GP3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the "if (extlen)" case, "bh" was used uninitialized.

This patch changes the code to what seems to have been intended.

Spotted by the Coverity checker.

This patch also removes a pointless "bh = NULL" asignment (the variable 
is never accessed again after this point).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/fs/gfs2/dir.c.old	2006-10-19 15:33:52.000000000 +0200
+++ linux-2.6/fs/gfs2/dir.c	2006-10-19 15:35:44.000000000 +0200
@@ -301,54 +301,52 @@ static int gfs2_dir_read_data(struct gfs
 	while (copied < size) {
 		unsigned int amount;
 		struct buffer_head *bh;
 		int new;
 
 		amount = size - copied;
 		if (amount > sdp->sd_sb.sb_bsize - o)
 			amount = sdp->sd_sb.sb_bsize - o;
 
 		if (!extlen) {
 			new = 0;
 			error = gfs2_extent_map(&ip->i_inode, lblock, &new,
 						&dblock, &extlen);
 			if (error || !dblock)
 				goto fail;
 			BUG_ON(extlen < 1);
 			if (!ra)
 				extlen = 1;
 			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
-		}
-		if (!bh) {
+		} else {
 			error = gfs2_meta_read(ip->i_gl, dblock, DIO_WAIT, &bh);
 			if (error)
 				goto fail;
 		}
 		error = gfs2_metatype_check(sdp, bh, GFS2_METATYPE_JD);
 		if (error) {
 			brelse(bh);
 			goto fail;
 		}
 		dblock++;
 		extlen--;
 		memcpy(buf, bh->b_data + o, amount);
 		brelse(bh);
-		bh = NULL;
 		buf += amount;
 		copied += amount;
 		lblock++;
 		o = sizeof(struct gfs2_meta_header);
 	}
 
 	return copied;
 fail:
 	return (copied) ? copied : error;
 }
 
 static inline int __gfs2_dirent_find(const struct gfs2_dirent *dent,
 				     const struct qstr *name, int ret)
 {
 	if (dent->de_inum.no_addr != 0 &&
 	    be32_to_cpu(dent->de_hash) == name->hash &&
 	    be16_to_cpu(dent->de_name_len) == name->len &&
 	    memcmp(dent+1, name->name, name->len) == 0)
 		return ret;

