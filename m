Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVARLEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVARLEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 06:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVARLET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 06:04:19 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:26070 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261255AbVARLEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 06:04:12 -0500
Date: Tue, 18 Jan 2005 13:04:32 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       chrisw@osdl.org, davem@davemloft.net
Subject: [PATCH 5/5] symmetry between compat_ioctl and unlocked_ioctl
Message-ID: <20050118110432.GE23127@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118072133.GB76018@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Make unlocked_ioctl and compat_ioctl behave symmetrically -
check them first thing, and always require returning ENOIOCTLCMD
on error from unlocked_ioctl, same as we do for compat_ioctl.
This also makes it possible to override *all* ioctl commands, and
hopefully may enable some speed ups on the data path.

diff -rup linux-2.6.10-orig/fs/ioctl.c linux-2.6.10-ioctl-sym/fs/ioctl.c
--- linux-2.6.10-orig/fs/ioctl.c	2005-01-18 10:58:33.609880024 +0200
+++ linux-2.6.10-ioctl-sym/fs/ioctl.c	2005-01-18 10:51:55.690372984 +0200
@@ -24,12 +24,7 @@ static long do_ioctl(struct file *filp, 
 	if (!filp->f_op)
 		goto out;
 
-	if (filp->f_op->unlocked_ioctl) {
-		error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
-		if (error == -ENOIOCTLCMD)
-			error = -EINVAL;
-		goto out;
-	} else if (filp->f_op->ioctl) {
+	if (filp->f_op->ioctl) {
 		lock_kernel();
 		error = filp->f_op->ioctl(filp->f_dentry->d_inode,
 					  filp, cmd, arg);
@@ -93,6 +91,12 @@ asmlinkage long sys_ioctl(unsigned int f
  	if (error)
  		goto out_fput;
 
+	if (filp->f_op && filp->f_op->unlocked_ioctl) {
+		error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
+		if (error != -ENOIOCTLCMD)
+			goto out_fput;
+	}
+
 	switch (cmd) {
 		case FIOCLEX:
 			set_close_on_exec(fd, 1);
