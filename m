Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVBHXia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVBHXia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVBHXia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:38:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:62643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261693AbVBHXiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:38:05 -0500
Date: Tue, 8 Feb 2005 15:38:01 -0800
From: Chris Wright <chrisw@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8)
Message-ID: <20050208153801.M24171@build.pdx.osdl.net>
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us> <20050207142603.A469@build.pdx.osdl.net> <20050208172450.GA3598@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050208172450.GA3598@halcrow.us>; from mhalcrow@us.ibm.com on Tue, Feb 08, 2005 at 11:24:50AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Halcrow (mhalcrow@us.ibm.com) wrote:
> [...].  This occurs because the bd_release function will
> bd_release(bdev) and set inode->i_security to NULL on the close(fd1).
> Hence, we want to place the control at the level of the file struct,
> not the inode.

This is basically what I was referring to pre-merge.  And it is still
not fully sufficient.  Multiple processes can share an fd.  So the test
against current is broken.  Also well-behaved apps that are already
using O_EXCL will break.  Using filp as the holder is sufficient to fix
both of these issues.  Here's a 3.5/8 that will fix this.  6/8 no longer
applies cleanly with this change.

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- a/security/seclvl.c~bd_claim	2005-02-08 15:05:09.000000000 -0800
+++ b/security/seclvl.c	2005-02-08 15:05:17.000000000 -0800
@@ -492,17 +492,16 @@
  */
 static int seclvl_bd_claim(struct file * filp)
 {
-	int holder;
 	struct block_device *bdev = NULL;
 	dev_t dev = filp->f_dentry->d_inode->i_rdev;
 	bdev = open_by_devnum(dev, FMODE_WRITE);
 	if (bdev) {
-		if (bd_claim(bdev, &holder)) {
+		if (bd_claim(bdev, filp)) {
 			blkdev_put(bdev);
 			return -EPERM;
 		}
 		/* Claimed; mark it to release on close */
-		filp->f_security = current;
+		filp->f_security = filp;
 	}
 	return 0;
 }
@@ -597,7 +596,7 @@
 	if (dentry && (filp->f_mode & FMODE_WRITE)) {
 		struct inode * inode = dentry->d_inode;
 		if (inode && S_ISBLK(inode->i_mode)
-		    && filp->f_security == current) {
+		    && filp->f_security == filp) {
 			struct block_device *bdev = inode->i_bdev;
 			if (bdev) {
 				bd_release(bdev);
