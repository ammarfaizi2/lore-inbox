Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWFSIKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWFSIKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWFSIKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:10:21 -0400
Received: from 1wt.eu ([62.212.114.60]:61192 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932264AbWFSIKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:10:20 -0400
Date: Mon, 19 Jun 2006 10:06:51 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060619080651.GA3273@1wt.eu>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt> <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com> <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com> <20060619040152.GB2678@1wt.eu> <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

OK, it does *really* crash in vfs_unlink(), during the double_up on
dentry->inode-i_zombie (dentry->inode = NULL).

I suggest the following fix, I hope that it is correct and is not subject
to any race condition :

--- ./fs/namei.c.orig	2006-06-19 09:39:52.000000000 +0200
+++ ./fs/namei.c	2006-06-19 09:51:09.000000000 +0200
@@ -1478,12 +1478,14 @@
 int vfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error;
+	struct inode *inode;
 
 	error = may_delete(dir, dentry, 0);
 	if (error)
 		return error;
 
-	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
+	inode = dentry->d_inode;
+	double_down(&dir->i_zombie, &inode->i_zombie);
 	error = -EPERM;
 	if (dir->i_op && dir->i_op->unlink) {
 		DQUOT_INIT(dir);
@@ -1495,7 +1497,7 @@
 			unlock_kernel();
 		}
 	}
-	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
+	double_up(&dir->i_zombie, &inode->i_zombie);
 	if (!error) {
 		d_delete(dentry);
 		inode_dir_notify(dir, DN_DELETE);

I think it will *not* oops anymore with this fix, but I'd like someone to
review it to ensure that it is valid.

Cheers,
Willy

