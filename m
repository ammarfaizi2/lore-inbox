Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSGVQSE>; Mon, 22 Jul 2002 12:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSGVQSD>; Mon, 22 Jul 2002 12:18:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:32011 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317498AbSGVQSC>; Mon, 22 Jul 2002 12:18:02 -0400
Message-ID: <3D3C2FA1.2010703@evision.ag>
Date: Mon, 22 Jul 2002 18:15:29 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 read_write - take 2
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> 	<3D3C11DE.7010000@evision.ag> <1027356923.31787.47.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------090509090901060700070806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090509090901060700070806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> On Mon, 2002-07-22 at 15:08, Marcin Dalecki wrote:
> 
>>- It is fixing completely confused wild casting to 32 bits.
>>
>>- Actually adding a comment explaining the obscure code, which is
>>   relying on integer arithmetics overflow.
> 
> 
> Better yet take the code from 2.4.19-rc3. The code you fixed up is still
> wrong. Sincie iov_len is not permitted to exceed 2Gb (SuS v3, found by
> the LSB test suite) the actual fix turns out to be even simpler and
> cleaner than the one you did

You are right. It makes sese, since readv and writev are
supposed to return ssize_t. Fixed patch version attached.



--------------090509090901060700070806
Content-Type: text/plain;
 name="read_write-2.5.27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="read_write-2.5.27.diff"

diff -urN linux-2.5.27/fs/read_write.c linux/fs/read_write.c
--- linux-2.5.27/fs/read_write.c	2002-07-22 17:51:25.000000000 +0200
+++ linux/fs/read_write.c	2002-07-22 17:57:22.000000000 +0200
@@ -306,12 +306,16 @@
 	tot_len = 0;
 	ret = -EINVAL;
 	for (i = 0 ; i < count ; i++) {
-		size_t tmp = tot_len;
-		int len = iov[i].iov_len;
+		ssize_t tmp = tot_len;
+		ssize_t len = iov[i].iov_len;
+
+		/* check for SSIZE_MAX overflow */
 		if (len < 0)
 			goto out;
-		(u32)tot_len += len;
-		if (tot_len < tmp || tot_len < (u32)len)
+
+		tot_len += len;
+		/* check for overflows */
+		if (tot_len < tmp)
 			goto out;
 	}
 

--------------090509090901060700070806--

