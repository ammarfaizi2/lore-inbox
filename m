Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbULUWwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbULUWwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 17:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbULUWwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 17:52:53 -0500
Received: from mail.dif.dk ([193.138.115.101]:44516 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261849AbULUWwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 17:52:50 -0500
Date: Wed, 22 Dec 2004 00:03:33 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: isdn4linux@listserv.isdn4linux.de, Karsten Keil <keil@isdn4linux.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>
Subject: [PATCH] act upon copy_to_user failing and silence warning
Message-ID: <Pine.LNX.4.61.0412212356030.3518@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

patch below silences these two warnings :

drivers/isdn/hisax/config.c:636: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
drivers/isdn/hisax/config.c:647: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result

by checking the return value of copy_to_user and returning -EFAULT if it 
fails.

note: I don't have the hardware to actually test this, so all I've done is 
tried to convince myself that this is correct by reading the code and then 
compile test it.

Please review and consider applying.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk13-orig/drivers/isdn/hisax/config.c linux-2.6.10-rc3-bk13/drivers/isdn/hisax/config.c
--- linux-2.6.10-rc3-bk13-orig/drivers/isdn/hisax/config.c	2004-12-06 22:24:29.000000000 +0100
+++ linux-2.6.10-rc3-bk13/drivers/isdn/hisax/config.c	2004-12-21 23:55:00.000000000 +0100
@@ -633,7 +633,8 @@ int HiSax_readstatus(u_char __user *buf,
 		count = cs->status_end - cs->status_read + 1;
 		if (count >= len)
 			count = len;
-		copy_to_user(p, cs->status_read, count);
+		if (copy_to_user(p, cs->status_read, count))
+			return -EFAULT;
 		cs->status_read += count;
 		if (cs->status_read > cs->status_end)
 			cs->status_read = cs->status_buf;
@@ -644,7 +645,8 @@ int HiSax_readstatus(u_char __user *buf,
 				cnt = HISAX_STATUS_BUFSIZE;
 			else
 				cnt = count;
-			copy_to_user(p, cs->status_read, cnt);
+			if (copy_to_user(p, cs->status_read, cnt))
+				return -EFAULT;
 			p += cnt;
 			cs->status_read += cnt % HISAX_STATUS_BUFSIZE;
 			count -= cnt;



PS. please kee me on CC if replies go only to lists other than LKML.


