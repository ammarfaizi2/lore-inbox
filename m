Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVCaWVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVCaWVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVCaWVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:21:43 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52906 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262028AbVCaWU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:20:29 -0500
Subject: [PATCH] undo do_readv_writev() behavior change
From: Dave Hansen <haveblue@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sharyathi@in.ibm.com
Content-Type: multipart/mixed; boundary="=-6eQOI8xRDKASvT5IezAT"
Date: Thu, 31 Mar 2005 14:20:20 -0800
Message-Id: <1112307620.20331.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6eQOI8xRDKASvT5IezAT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Bugme bug 4326: http://bugme.osdl.org/show_bug.cgi?id=4326 reports:

> Problem Description: 
> On executing the systemcall readv with Bad argument
> (iovec->len == -1) it gives out error EFAULT instead of EINVAL 

This is not a serious bug, but is a slight behavior change.  This changeset:

	http://linus.bkbits.net:8080/linux-2.5/cset@4202616998ECZp5x5NfCDbX9JcEG7g?nav=index.html|src/|src/fs|related/fs/read_write.c

does an access_ok() check before the 'len < 0' check, in
do_readv_writev() so it now does an EFAULT instead of EVINAL for the -1
length argument. 

>  	for (seg = 0; seg < nr_segs; seg++) {
...
> +		if (unlikely(!access_ok(vrfy_dir(type), buf, len)))
> +			goto Efault;
>  		if (len < 0)	/* size_t not fitting an ssize_t .. */
>  			goto out;
>  		tot_len += len;

The attached path moves the access check to after the len check, to make
it behave a little more like it did before.

-- Dave


--=-6eQOI8xRDKASvT5IezAT
Content-Disposition: attachment; filename=do_readv_writev-bugno-4326.patch
Content-Type: text/x-patch; name=do_readv_writev-bugno-4326.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- linux-2.6/fs/read_write.c.orig	2005-03-31 14:02:03.940333696 -0800
+++ linux-2.6/fs/read_write.c	2005-03-31 14:03:24.651063800 -0800
@@ -467,10 +467,10 @@ static ssize_t do_readv_writev(int type,
 		void __user *buf = iov[seg].iov_base;
 		ssize_t len = (ssize_t)iov[seg].iov_len;
 
-		if (unlikely(!access_ok(vrfy_dir(type), buf, len)))
-			goto Efault;
 		if (len < 0)	/* size_t not fitting an ssize_t .. */
 			goto out;
+		if (unlikely(!access_ok(vrfy_dir(type), buf, len)))
+			goto Efault;
 		tot_len += len;
 		if ((ssize_t)tot_len < 0) /* maths overflow on the ssize_t */
 			goto out;

--=-6eQOI8xRDKASvT5IezAT--

