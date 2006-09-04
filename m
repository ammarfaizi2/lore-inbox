Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWIDHW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWIDHW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWIDHW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:22:27 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:35816 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932435AbWIDHWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:22:25 -0400
Date: Mon, 4 Sep 2006 09:18:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 10/22][RFC] Unionfs: Inode operations
In-Reply-To: <20060901014933.GK5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040911510.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014933.GK5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+			//DQ: vfs_create has a different prototype in 2.6

I found a relic! :-)

>+				if (IS_ERR(hidden_dentry)) {
>+					err = PTR_ERR(hidden_dentry);
>+				}
-{}

>+/* We don't lock the dentry here, because readlink does the heavy lifting. */
>+static void *unionfs_follow_link(struct dentry *dentry, struct nameidata *nd)
>+{
>+	char *buf;
>+	int len = PAGE_SIZE, err;
>+	mm_segment_t old_fs;
>+
>+	/* This is freed by the put_link method assuming a successful call. */
>+	buf = (char *)kmalloc(len, GFP_KERNEL);

Nocast.

>+void unionfs_put_link(struct dentry *dentry, struct nameidata *nd, void *cookie)
>+{
>+	char *link;
>+	link = nd_get_link(nd);
>+	kfree(link);
>+}

kfree(nd_get_link(nd));

>+	/* Ordinary permission routines do not understand MAY_APPEND. */
>+	submask = mask & ~MAY_APPEND;
>+	if (inode->i_op && inode->i_op->permission) {
>+		retval = inode->i_op->permission(inode, submask, nd);
>+		if ((retval == -EACCES) && (submask & MAY_WRITE) &&
>+		    (!strcmp("nfs", (inode)->i_sb->s_type->name)) &&
>+		    (nd) && (nd->mnt) && (nd->mnt->mnt_sb) &&
>+		    (branchperms(nd->mnt->mnt_sb, bindex) & MAY_NFSRO)) {
>+			retval = generic_permission(inode, submask, NULL);

I am not sure right now, I would need to test; does someone know out of the box
whether other network filesystems (in particular SMBFS/CIFS) behave like NFS
and also return -EACCES rather than -EROFS?

>+	return ((retval == -EROFS) ? 0 : retval);	/* ignore EROFS */
outer ()
>+	for (bindex = bstart; (bindex <= bend) || (bindex == bstart); bindex++) {

>+				/* if error is in the leftmost f/s, pass it up */

"f/s" => branch, to follow unionfs terminiology.



Jan Engelhardt
-- 

-- 
VGER BF report: H 0.0311395
