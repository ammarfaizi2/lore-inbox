Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbTBFSYK>; Thu, 6 Feb 2003 13:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbTBFSYK>; Thu, 6 Feb 2003 13:24:10 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:57246 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S267510AbTBFSYH>;
	Thu, 6 Feb 2003 13:24:07 -0500
Date: Thu, 6 Feb 2003 20:47:14 -0500
From: Christoph Hellwig <hch@sgi.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix leaks in vxfs_read_fshead()
Message-ID: <20030206204714.A23235@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Stanford checker disclose that vxfs_read_fshead was missing any
unwinding in the error cases..

Here's the fix.


--- 1.6/fs/freevxfs/vxfs_fshead.c	Sun Nov 17 20:00:17 2002
+++ edited/fs/freevxfs/vxfs_fshead.c	Thu Feb  6 18:58:49 2003
@@ -111,13 +111,15 @@
 	struct vxfs_fsh			*pfp, *sfp;
 	struct vxfs_inode_info		*vip, *tip;
 
-	if (!(vip = vxfs_blkiget(sbp, infp->vsi_iext, infp->vsi_fshino))) {
+	vip = vxfs_blkiget(sbp, infp->vsi_iext, infp->vsi_fshino);
+	if (!vip) {
 		printk(KERN_ERR "vxfs: unabled to read fsh inode\n");
 		return -EINVAL;
-	} else if (!VXFS_ISFSH(vip)) {
+	}
+	if (!VXFS_ISFSH(vip)) {
 		printk(KERN_ERR "vxfs: fsh list inode is of wrong type (%x)\n",
 				vip->vii_mode & VXFS_TYPE_MASK); 
-		return -EINVAL;
+		goto out_free_fship;
 	}
 
 
@@ -126,23 +128,26 @@
 	vxfs_dumpi(vip, infp->vsi_fshino);
 #endif
 
-	if (!(infp->vsi_fship = vxfs_get_fake_inode(sbp, vip))) {
+	infp->vsi_fship = vxfs_get_fake_inode(sbp, vip);
+	if (!infp->vsi_fship) {
 		printk(KERN_ERR "vxfs: unabled to get fsh inode\n");
-		return -EINVAL;
+		goto out_free_fship;
 	}
 
-	if (!(sfp = vxfs_getfsh(infp->vsi_fship, 0))) {
+	sfp = vxfs_getfsh(infp->vsi_fship, 0);
+	if (!sfp) {
 		printk(KERN_ERR "vxfs: unabled to get structural fsh\n");
-		return -EINVAL;
+		goto out_iput_fship;
 	} 
 
 #ifdef DIAGNOSTIC
 	vxfs_dumpfsh(sfp);
 #endif
 
-	if (!(pfp = vxfs_getfsh(infp->vsi_fship, 1))) {
+	pfp = vxfs_getfsh(infp->vsi_fship, 1);
+	if (!pfp) {
 		printk(KERN_ERR "vxfs: unabled to get primary fsh\n");
-		return -EINVAL;
+		goto out_free_sfp;
 	}
 
 #ifdef DIAGNOSTIC
@@ -150,24 +155,50 @@
 #endif
 
 	tip = vxfs_blkiget(sbp, infp->vsi_iext, sfp->fsh_ilistino[0]);
-	if (!tip || ((infp->vsi_stilist = vxfs_get_fake_inode(sbp, tip)) == NULL)) {
+	if (!tip)
+		goto out_free_pfp;
+
+	infp->vsi_stilist = vxfs_get_fake_inode(sbp, tip);
+	if (!infp->vsi_stilist) {
 		printk(KERN_ERR "vxfs: unabled to get structual list inode\n");
-		return -EINVAL;
-	} else if (!VXFS_ISILT(VXFS_INO(infp->vsi_stilist))) {
+		kfree(tip);
+		goto out_free_pfp;
+	}
+	if (!VXFS_ISILT(VXFS_INO(infp->vsi_stilist))) {
 		printk(KERN_ERR "vxfs: structual list inode is of wrong type (%x)\n",
 				VXFS_INO(infp->vsi_stilist)->vii_mode & VXFS_TYPE_MASK); 
-		return -EINVAL;
+		goto out_iput_stilist;
 	}
 
 	tip = vxfs_stiget(sbp, pfp->fsh_ilistino[0]);
-	if (!tip || ((infp->vsi_ilist = vxfs_get_fake_inode(sbp, tip)) == NULL)) {
+	if (!tip)
+		goto out_iput_stilist;
+	infp->vsi_ilist = vxfs_get_fake_inode(sbp, tip);
+	if (!infp->vsi_ilist) {
 		printk(KERN_ERR "vxfs: unabled to get inode list inode\n");
-		return -EINVAL;
-	} else if (!VXFS_ISILT(VXFS_INO(infp->vsi_ilist))) {
+		kfree(tip);
+		goto out_iput_stilist;
+	}
+	if (!VXFS_ISILT(VXFS_INO(infp->vsi_ilist))) {
 		printk(KERN_ERR "vxfs: inode list inode is of wrong type (%x)\n",
 				VXFS_INO(infp->vsi_ilist)->vii_mode & VXFS_TYPE_MASK);
-		return -EINVAL;
+		goto out_iput_ilist;
 	}
 
 	return 0;
+
+ out_iput_ilist:
+ 	iput(infp->vsi_ilist);
+ out_iput_stilist:
+ 	iput(infp->vsi_stilist);
+ out_free_pfp:
+	kfree(pfp);
+ out_free_sfp:
+ 	kfree(sfp);
+ out_iput_fship:
+	iput(infp->vsi_fship);
+	return -EINVAL;
+ out_free_fship:
+ 	kfree(vip);
+	return -EINVAL;
 }
