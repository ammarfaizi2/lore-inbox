Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWGMER4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWGMER4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 00:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWGMER4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 00:17:56 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:53677 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932233AbWGMERz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 00:17:55 -0400
Message-ID: <44B5C971.7030403@us.ibm.com>
Date: Wed, 12 Jul 2006 21:17:53 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Michael Holzheu <HOLZHEU@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 hypfs fixes for 2.6.18-rc1-mm1
References: <44B5C7CE.6090606@us.ibm.com>
In-Reply-To: <44B5C7CE.6090606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070609080108070306050205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070609080108070306050205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Badari Pulavarty wrote:
> Hi Micheal,
>
> I made fixes to hypfs to fit new vfs ops interfaces. I am not sure if 
> we really
> need to vectorize aio interfaces, can you check and see if this is okay ?
>
> And also, I am not sure what hypfs_aio_write() is actually doing.
> It doesn't seem to be  doing with "buf" ?
>
> (BTW - I have no way to verify these change. Can you give them a spin ?)
>
> Thanks,
> Badari

Here is the updated version ..



--------------070609080108070306050205
Content-Type: text/plain;
 name="hypfs-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hypfs-fixes.patch"

Vectorize aio interfaces to hypfs to fit new vfs ops interfaces.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Index: linux-2.6.18-rc1/arch/s390/hypfs/inode.c
===================================================================
--- linux-2.6.18-rc1.orig/arch/s390/hypfs/inode.c	2006-07-11 21:28:07.000000000 -0700
+++ linux-2.6.18-rc1/arch/s390/hypfs/inode.c	2006-07-12 21:31:43.000000000 -0700
@@ -134,12 +134,20 @@ static int hypfs_open(struct inode *inod
 	return 0;
 }
 
-static ssize_t hypfs_aio_read(struct kiocb *iocb, __user char *buf,
-			      size_t count, loff_t offset)
+static ssize_t hypfs_aio_read(struct kiocb *iocb, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t offset)
 {
 	char *data;
 	size_t len;
 	struct file *filp = iocb->ki_filp;
+	/* XXX: temporary */
+	char __user *buf = iov[0].iov_base;
+	size_t count = iov[0].iov_len;
+
+	if (nr_segs != 1) {
+		count = -EINVAL;
+		goto out;
+	}
 
 	data = filp->private_data;
 	len = strlen(data);
@@ -158,12 +166,13 @@ static ssize_t hypfs_aio_read(struct kio
 out:
 	return count;
 }
-static ssize_t hypfs_aio_write(struct kiocb *iocb, const char __user *buf,
-			       size_t count, loff_t pos)
+static ssize_t hypfs_aio_write(struct kiocb *iocb, const struct iovec *iov,
+			      unsigned long nr_segs, loff_t offset)
 {
 	int rc;
 	struct super_block *sb;
 	struct hypfs_sb_info *fs_info;
+	size_t count = iov_length(iov, nr_segs);
 
 	sb = iocb->ki_filp->f_dentry->d_inode->i_sb;
 	fs_info = sb->s_fs_info;

--------------070609080108070306050205--

