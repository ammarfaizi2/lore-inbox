Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263202AbTCYSJH>; Tue, 25 Mar 2003 13:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbTCYSJH>; Tue, 25 Mar 2003 13:09:07 -0500
Received: from slarti.muc.de ([193.149.48.10]:46095 "HELO slarti.muc.de")
	by vger.kernel.org with SMTP id <S263202AbTCYSI7>;
	Tue, 25 Mar 2003 13:08:59 -0500
From: Stephan Maciej <stephanm@muc.de>
Date: Tue, 25 Mar 2003 20:20:54 +0100
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: Misleading comments or lack of functionality or my stupidness in read_write.c?
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WwKg+thKgGfkoH8"
Message-Id: <200303252020.54145.stephanm@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_WwKg+thKgGfkoH8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am sometimes reading some kernel source in my free time, and I think that I 
either missed something or something is missing or something is wrong. 
Whatever it is, things do not match.

In fs/read_write.c:

> static ssize_t do_readv_writev(blah)
> {
> [...]
>
>	/*
>	 * First get the "struct iovec" from user memory and
>	 * verify all the pointers
>	 */

I thought that there would be some calls to verify_area() womewhere below, but 
there aren't any. There's just

> [... checks of nr_segs and file->f_op ...]
>	ret = -EFAULT;
>	if (copy_from_user(iov, vector, nr_segs*sizeof(*vector)))
>		goto out;
>
>	/*
>	 * Single unix specification:
>	 * We should -EINVAL if an element length is not >= 0 and fitting an
>	 * ssize_t.  The total length is fitting an ssize_t
>	 *
>	 * Be careful here because iov_len is a size_t not an ssize_t
>	 */
>
> [... checks like described ...]
>
>	inode = file->f_dentry->d_inode;
>	/* VERIFY_WRITE actually means a read, as we write to user space */
>	ret = locks_verify_area((type == READ
>				 ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
>				inode, file, *pos, tot_len);

The comments look like someone thought of a call to verify_areas() instead of 
the function actually called. Or am I just missing something? 

Just for the case that I am not, a patch against 2.5.65 for removing the bogus 
comments is included. This one also tries to clean up some very small things. 
Well, it's my first patch, so handle with care... :-)

Stephan

P.S. I am not 100% sure about this:

 	for (seg = 0 ; seg < nr_segs; seg++) {
-		ssize_t tmp = tot_len;
 		ssize_t len = (ssize_t)iov[seg].iov_len;
 		if (len < 0)	/* size_t not fitting an ssize_t .. */
 			goto out;
 		tot_len += len;
-		if (tot_len < tmp) /* maths overflow on the ssize_t */
+		if ((ssize_t)tot_len < 0) /* maths overflow on the ssize_t */
 			goto out;
 	}

That should be okay? Or do size_t and ssize_t differ in more than just in 
signedness?
--Boundary-00=_WwKg+thKgGfkoH8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="read_write.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="read_write.patch"

--- fs/read_write.c~backup	2003-03-25 19:56:50.000000000 +0100
+++ fs/read_write.c	2003-03-25 20:02:04.000000000 +0100
@@ -338,7 +338,7 @@
 	typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
 	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
 
-	size_t tot_len;
+	size_t tot_len = 0;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov=iovstack;
 	ssize_t ret;
@@ -356,21 +356,18 @@
 	if (nr_segs == 0)
 		goto out;
 
-	/*
-	 * First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
 	ret = -EINVAL;
-	if ((nr_segs > UIO_MAXIOV) || (nr_segs <= 0))
-		goto out;
 	if (!file->f_op)
 		goto out;
+	if (nr_segs > UIO_MAXIOV)
+		goto out;
 	if (nr_segs > UIO_FASTIOV) {
 		ret = -ENOMEM;
 		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
 		if (!iov)
 			goto out;
 	}
+
 	ret = -EFAULT;
 	if (copy_from_user(iov, vector, nr_segs*sizeof(*vector)))
 		goto out;
@@ -382,24 +379,22 @@
 	 *
 	 * Be careful here because iov_len is a size_t not an ssize_t
 	 */
-	tot_len = 0;
 	ret = -EINVAL;
 	for (seg = 0 ; seg < nr_segs; seg++) {
-		ssize_t tmp = tot_len;
 		ssize_t len = (ssize_t)iov[seg].iov_len;
 		if (len < 0)	/* size_t not fitting an ssize_t .. */
 			goto out;
 		tot_len += len;
-		if (tot_len < tmp) /* maths overflow on the ssize_t */
+		if ((ssize_t)tot_len < 0) /* maths overflow on the ssize_t */
 			goto out;
 	}
+
 	if (tot_len == 0) {
 		ret = 0;
 		goto out;
 	}
 
 	inode = file->f_dentry->d_inode;
-	/* VERIFY_WRITE actually means a read, as we write to user space */
 	ret = locks_verify_area((type == READ 
 				 ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
 				inode, file, *pos, tot_len);

--Boundary-00=_WwKg+thKgGfkoH8--

