Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265591AbSKFFBi>; Wed, 6 Nov 2002 00:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265592AbSKFFBi>; Wed, 6 Nov 2002 00:01:38 -0500
Received: from h00010256f583.ne.client2.attbi.com ([66.30.243.14]:25276 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S265591AbSKFFBh>; Wed, 6 Nov 2002 00:01:37 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Lev Makhlis <mlev@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.46: overflow in disk stats
Date: Wed, 6 Nov 2002 00:09:51 -0500
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>, ricklind@us.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211060009.51684.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see that the SARD changes have been merged, but MSEC() still has
the overflow problem.  This takes care of it:

--------------------------------------------------------------------------------------------------

diff -urN linux-2.5.46.orig/drivers/block/genhd.c 
linux-2.5.46/drivers/block/genhd.c
--- linux-2.5.46.orig/drivers/block/genhd.c	Tue Nov  5 15:15:07 2002
+++ linux-2.5.46/drivers/block/genhd.c	Tue Nov  5 16:14:35 2002
@@ -326,7 +326,13 @@
 }
 static inline unsigned MSEC(unsigned x)
 {
-	return x * 1000 / HZ;
+#if 1000 % HZ == 0
+	return x * (1000 / HZ);
+#elif HZ % 1000 == 0
+	return x / (HZ / 1000);
+#else
+	return (x / HZ) * 1000 + (x % HZ) * 1000 / HZ;
+#endif
 }
 static ssize_t disk_stat_read(struct gendisk * disk,
 			      char *page, size_t count, loff_t off)
