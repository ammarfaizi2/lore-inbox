Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUIFVkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUIFVkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIFVkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:40:43 -0400
Received: from mail.dif.dk ([193.138.115.101]:24742 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267313AbUIFVki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:40:38 -0400
Date: Mon, 6 Sep 2004 23:46:47 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] remember to check return value from __copy_to_user() in
 cdrom_read_cdda_old() 
Message-ID: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a patch to ensure that the return value from __copy_to_user() gets 
checked in cdrom_read_cdda_old().
I assume that returning -EFAULT if the copy fails to copy all bytes is an 
appropriate action, but please correct me if I'm wrong.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc1-bk13-orig/drivers/cdrom/cdrom.c linux-2.6.9-rc1-bk13/drivers/cdrom/cdrom.c
--- linux-2.6.9-rc1-bk13-orig/drivers/cdrom/cdrom.c	2004-08-24 20:44:01.000000000 +0200
+++ linux-2.6.9-rc1-bk13/drivers/cdrom/cdrom.c	2004-09-06 23:41:20.000000000 +0200
@@ -1959,7 +1959,10 @@ static int cdrom_read_cdda_old(struct cd
 		ret = cdrom_read_block(cdi, &cgc, lba, nr, 1, CD_FRAMESIZE_RAW);
 		if (ret)
 			break;
-		__copy_to_user(ubuf, cgc.buffer, CD_FRAMESIZE_RAW * nr);
+		if (__copy_to_user(ubuf, cgc.buffer, CD_FRAMESIZE_RAW * nr)) {
+			kfree(cgc.buffer);
+			return -EFAULT;
+		}
 		ubuf += CD_FRAMESIZE_RAW * nr;
 		nframes -= nr;
 		lba += nr;



I'm wondering if it would make sense to wrap this branch in unlikely() 
since it should rarely fail...?
I should also mention that I've only compile tested this so far.


--
Jesper Juhl

