Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVDMCZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVDMCZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVDMCWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:22:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263206AbVDMCRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:17:40 -0400
Date: Wed, 13 Apr 2005 04:17:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: bfennema@falcon.csc.calpoly.edu, linux_udf@hpesjro.fc.hp.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/udf/inode.c: fix a check after use
Message-ID: <20050413021737.GR3631@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

---

This patch was already sent on:
- 27 Mar 2005

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

