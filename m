Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWGMRgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWGMRgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWGMRgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:36:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:42655 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751417AbWGMRgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:36:43 -0400
Subject: Re: [PATCH] s390 hypfs fixes for 2.6.18-rc1-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <OFABC483F9.1D9AD47C-ON422571AA.0056247F-422571AA.0056297A@de.ibm.com>
References: <OFABC483F9.1D9AD47C-ON422571AA.0056247F-422571AA.0056297A@de.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 10:39:04 -0700
Message-Id: <1152812344.30096.6.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 17:41 +0200, Michael Holzheu wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote on 07/13/2006 04:31:00 PM:
> > Andrew Morton wrote:
> > > On Wed, 12 Jul 2006 21:17:53 -0700
> > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> 
> [snip]
> 
> > >
> > > err, "temporary" things tend to become permanent.  What's the real fix?
> > >
> > I am not sure, if we really need to vectorize this method or not -
> > meaning will this be ever called
> > with more than one items in the vector.
> >
> > Micheal, is it possible ? Can some one directly use AIO interface on
> > hypfs ? If not, we can always
> > look at only first element and ignore rest of them. Otherwise, we need
> > to iterate on all the elements
> > of the vector.
> 
> Of course it is possible that someone uses AIO on hypfs files, but
> normally the synchronous IO functions are used. I used the AIO
> implementation together with do_sync_read/write() only because
> it was not more effort regarding the implementation and we got
> the AIO interface for free.
> 
> Nevertheless we probably should implement the complete
> function.

Well, if you say so.. I have no idea what hypfs provides,
if you think that some one can do vector and/or async
operations on these files, its worth adding the complexity.

I was inclined towards just dealing with only single entry
in the vector and fail if some one called with multiple vectors.
But, its your call. Here is the complete code - completely untested :(
Could you please compile and test it  ?

Thanks,
Badari

Vectorize aio interfaces to hypfs to fit new vfs ops interfaces.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Index: linux-2.6.18-rc1/arch/s390/hypfs/inode.c
===================================================================
--- linux-2.6.18-rc1.orig/arch/s390/hypfs/inode.c	2006-07-11 21:28:07.000000000 -0700
+++ linux-2.6.18-rc1/arch/s390/hypfs/inode.c	2006-07-13 10:47:07.000000000 -0700
@@ -134,36 +134,50 @@ static int hypfs_open(struct inode *inod
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
+	int i, ret = 0;
 
 	data = filp->private_data;
 	len = strlen(data);
-	if (offset > len) {
-		count = 0;
-		goto out;
-	}
-	if (count > len - offset)
-		count = len - offset;
-	if (copy_to_user(buf, data + offset, count)) {
-		count = -EFAULT;
+	if (offset < len)
+		len -= offset;
+	else
 		goto out;
+
+	for (i=0; i < nr_segs; i++) {
+		char __user *buf = iov[i].iov_base;
+		size_t count = iov[i].iov_len;
+
+		if (count > len)
+			count = len;
+		if (copy_to_user(buf, data + offset, count)) {
+			if (!ret)
+				ret = -EFAULT;
+			break;
+		}
+		offset += count;
+		len -= count;
+		ret += count;
+		if (len == 0)
+			break;
 	}
-	iocb->ki_pos += count;
+	iocb->ki_pos = offset;
 	file_accessed(filp);
 out:
-	return count;
+	return ret;
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



