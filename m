Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSGYNlv>; Thu, 25 Jul 2002 09:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSGYNlG>; Thu, 25 Jul 2002 09:41:06 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:8701 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314546AbSGYNjK>; Thu, 25 Jul 2002 09:39:10 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251456.g6PEuMuV010555@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 (resend #1) SuS/LSB compliance in readv/writev from 2.4
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:56:22 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/fs/read_write.c linux-2.5.28-ac1/fs/read_write.c
--- linux-2.5.28/fs/read_write.c	Thu Jul 25 10:51:25 2002
+++ linux-2.5.28-ac1/fs/read_write.c	Mon Jul 22 15:43:46 2002
@@ -301,17 +301,23 @@
 	if (copy_from_user(iov, vector, count*sizeof(*vector)))
 		goto out;
 
-	/* BSD readv/writev returns EINVAL if one of the iov_len
-	   values < 0 or tot_len overflowed a 32-bit integer. -ink */
+	/*
+	 * Single unix specification:
+	 * We should -EINVAL if an element length is not >= 0 and fitting an ssize_t
+	 * The total length is fitting an ssize_t
+	 *
+	 * Be careful here because iov_len is a size_t not an ssize_t
+	 */
+	 
 	tot_len = 0;
 	ret = -EINVAL;
 	for (i = 0 ; i < count ; i++) {
-		size_t tmp = tot_len;
-		int len = iov[i].iov_len;
-		if (len < 0)
+		ssize_t tmp = tot_len;
+		ssize_t len = (ssize_t)iov[i].iov_len;
+		if (len < 0)	/* size_t not fitting an ssize_t .. */
 			goto out;
-		(u32)tot_len += len;
-		if (tot_len < tmp || tot_len < (u32)len)
+		tot_len += len;
+		if (tot_len < tmp) /* maths overflow on the ssize_t */
 			goto out;
 	}
 
