Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUITPyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUITPyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUITPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:54:52 -0400
Received: from [217.111.56.18] ([217.111.56.18]:60034 "EHLO spring.sncag.com")
	by vger.kernel.org with ESMTP id S266749AbUITPyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:54:43 -0400
To: linux-kernel@vger.kernel.org
Subject: Implementation defined behaviour in read_write.c
From: Rainer Weikusat <rainer.weikusat@sncag.com>
Date: Mon, 20 Sep 2004 23:54:34 +0800
Message-ID: <878yb5ey11.fsf@farside.sncag.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following code is in the function do_readv_writev in the file
fs/read_write.c (2.6.8.1):


	/*
	 * Single unix specification:
	 * We should -EINVAL if an element length is not >= 0 and fitting an
	 * ssize_t.  The total length is fitting an ssize_t
	 *
	 * Be careful here because iov_len is a size_t not an ssize_t
	 */
	tot_len = 0;
	ret = -EINVAL;
	for (seg = 0; seg < nr_segs; seg++) {
		ssize_t len = (ssize_t)iov[seg].iov_len;

		if (len < 0)	/* size_t not fitting an ssize_t .. */
			goto out;
		tot_len += len;
		if ((ssize_t)tot_len < 0) /* maths overflow on the ssize_t */
			goto out;
	}
	if (tot_len == 0) {
		ret = 0;
		goto out;
	}

There is a potential problem here, namely, that the result of the
conversion to ssize_t is implementation defined (ISO-C
6.3.1.3|3). This is not a problem with current gcc versions, but might
become a future one, because len need not be below zero after
attempting to convert a value too large for a ssize_t to that type. The
following patch would get rid off this (and corrects to errors in the
comment text ;-).

--- read_write.c.orig	2004-09-20 22:26:43.000000000 +0800
+++ read_write.c	2004-09-20 23:45:51.000000000 +0800
@@ -386,10 +386,10 @@
 	typedef ssize_t (*io_fn_t)(struct file *, char __user *, size_t, loff_t *);
 	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
 
-	size_t tot_len;
+	size_t tot_len, cur_len;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov=iovstack, *vector;
-	ssize_t ret;
+	ssize_t ret, x;
 	int seg;
 	io_fn_t fn;
 	iov_fn_t fnv;
@@ -425,22 +425,32 @@
 
 	/*
 	 * Single unix specification:
-	 * We should -EINVAL if an element length is not >= 0 and fitting an
-	 * ssize_t.  The total length is fitting an ssize_t
+	 * We should -EINVAL if an element length is not >= 0 and fitting a
+	 * ssize_t.  The total length is fitting a ssize_t
 	 *
-	 * Be careful here because iov_len is a size_t not an ssize_t
+	 * Be careful here because iov_len is a size_t not an ssize_t.
 	 */
 	tot_len = 0;
 	ret = -EINVAL;
 	for (seg = 0; seg < nr_segs; seg++) {
-		ssize_t len = (ssize_t)iov[seg].iov_len;
-
-		if (len < 0)	/* size_t not fitting an ssize_t .. */
-			goto out;
-		tot_len += len;
-		if ((ssize_t)tot_len < 0) /* maths overflow on the ssize_t */
+		cur_len = iov[seg].iov_len;
+		/* guard against overflows during the addition */
+		if (cur_len + tot_len < tot_len) goto out;
+		tot_len += cur_len;
 	}
+
+	/*
+	  This is as ISO-compliant as possible.
+	  If the value in tot_len changes when
+	  converted to a ssize_t and back,
+	  something 'implementation defined' happened
+	  because of an overflow.
+	*/
+	x = tot_len;
+	cur_len = x;
+	if (tot_len != cur_len) goto out;
+	
 	if (tot_len == 0) {
 		ret = 0;
 		goto out;
