Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUIAIRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUIAIRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUIAIRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:17:15 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:63539 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S263001AbUIAIQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:16:52 -0400
Date: Wed, 1 Sep 2004 11:19:40 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: discuss@x86-64.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901081940.GH13749@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040901072245.GF13749@mellanox.co.il> <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk> <1094024831.1970.21.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094024831.1970.21.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Lee Revell (rlrevell@joe-job.com) "Re: f_ops flag to speed up compatible ioctls in linux kernel":
> By adding a new ioctl you are adding a new use of the BKL.  It has been
> suggested on dri-devel that this should be fixed.  Is this even
> possible?
> 
> Lee

I dont know - can the lock be released before the call to
filp->f_op->ioctl ?

I assume the reason its there is for legacy code - existing ioctls
may be assuming the BKL is taken, but maybe there could be another
flag in f_ops to let sys_ioctl release the lock before doing the call ...

Like this - would that be safe?


--- linux-2.6.8.1/fs/ioctl.c	2004-08-14 13:54:51.000000000 +0300
+++ linux-2.6.8.1-built/fs/ioctl.c	2004-09-01 11:14:59.944417160 +0300
@@ -126,6 +126,14 @@
 			error = -ENOTTY;
 			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
 				error = file_ioctl(filp, cmd, arg);
+			else if (filp->f_op && filp->f_op->ioctl &&
+				(filp->f_op->fops_flags & FOPS_IOCTL_NOLOCK)) {
+			{
+				unlock_kernel();
+				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+				goto out;
+
+			}
 			else if (filp->f_op && filp->f_op->ioctl)
 				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
 	}

