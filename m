Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311503AbSCTD70>; Tue, 19 Mar 2002 22:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311504AbSCTD7K>; Tue, 19 Mar 2002 22:59:10 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13326 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311501AbSCTD6G>; Tue, 19 Mar 2002 22:58:06 -0500
Message-ID: <3C980876.C097A994@zip.com.au>
Date: Tue, 19 Mar 2002 19:56:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-040-touch_buffer
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Move the touch_buffer() from bread into getblk().

Fair enough.  The touch_buffer() call tells the VM "please don't evict
this page, I'm about to use it".  Doing it in getblk() will provide
better coverage than doing it in bread().  I would actually prefer to
do it in get_hash_table(), but that's a minor detail.



=====================================

--- 2.4.19-pre3/fs/buffer.c~aa-040-touch_buffer	Tue Mar 19 19:48:54 2002
+++ 2.4.19-pre3-akpm/fs/buffer.c	Tue Mar 19 19:49:15 2002
@@ -1032,8 +1032,10 @@ struct buffer_head * getblk(kdev_t dev, 
 		struct buffer_head * bh;
 
 		bh = get_hash_table(dev, block, size);
-		if (bh)
+		if (bh) {
+			touch_buffer(bh);
 			return bh;
+		}
 
 		if (!grow_buffers(dev, block, size))
 			free_more_memory();
@@ -1196,7 +1198,6 @@ struct buffer_head * bread(kdev_t dev, i
 	struct buffer_head * bh;
 
 	bh = getblk(dev, block, size);
-	touch_buffer(bh);
 	if (buffer_uptodate(bh))
 		return bh;
 	ll_rw_block(READ, 1, &bh);
