Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVC0Ur1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVC0Ur1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVC0Ur0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:47:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30480 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261353AbVC0UqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:46:23 -0500
Date: Sun, 27 Mar 2005 22:46:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: bfennema@falcon.csc.calpoly.edu
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/udf/inode.c: fix a check after use
Message-ID: <20050327204621.GB4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.12-rc1-mm1-full/fs/udf/inode.c.old	2005-03-23 05:12:25.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/fs/udf/inode.c	2005-03-23 05:12:53.000000000 +0100
@@ -1948,28 +1948,30 @@
 	udf_release_data(obh);
 	return (elen >> 30);
 }
 
 int8_t inode_bmap(struct inode *inode, int block, kernel_lb_addr *bloc, uint32_t *extoffset,
 	kernel_lb_addr *eloc, uint32_t *elen, uint32_t *offset, struct buffer_head **bh)
 {
-	uint64_t lbcount = 0, bcount = (uint64_t)block << inode->i_sb->s_blocksize_bits;
+	uint64_t lbcount = 0, bcount;
 	int8_t etype;
 
 	if (block < 0)
 	{
 		printk(KERN_ERR "udf: inode_bmap: block < 0\n");
 		return -1;
 	}
 	if (!inode)
 	{
 		printk(KERN_ERR "udf: inode_bmap: NULL inode\n");
 		return -1;
 	}
 
+	bcount = (uint64_t)block << inode->i_sb->s_blocksize_bits;
+
 	*extoffset = 0;
 	*elen = 0;
 	*bloc = UDF_I_LOCATION(inode);
 
 	do
 	{
 		if ((etype = udf_next_aext(inode, bloc, extoffset, eloc, elen, bh, 1)) == -1)

