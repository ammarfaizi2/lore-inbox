Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317564AbSGVPtF>; Mon, 22 Jul 2002 11:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317695AbSGVPtF>; Mon, 22 Jul 2002 11:49:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:46074 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317564AbSGVPtE>; Mon, 22 Jul 2002 11:49:04 -0400
Subject: Re: [PATCH] 2.5.27 read_write
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D3C11DE.7010000@evision.ag>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> 
	<3D3C11DE.7010000@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 18:04:49 +0100
Message-Id: <1027357489.32299.53.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 15:08, Marcin Dalecki wrote:
> - This is making the read_write.c C.
> 
> - It is fixing completely confused wild casting to 32 bits.
> 
> - Actually adding a comment explaining the obscure code, which is
>    relying on integer arithmetics overflow.

This is the 2.4 patch. This passes the SuS LSB validation tests and gets
32/64bit behaviour as well as sign rules for iov_len elements right. At
least I hope it does.

--- linux-2.5.27/fs/read_write.c	Sat Jul 20 20:11:25 2002
+++ linux-2.5.27-ac1/fs/read_write.c	Mon Jul 22 15:43:46 2002
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
 
