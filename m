Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVAFWxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVAFWxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbVAFWuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:50:50 -0500
Received: from mail.dif.dk ([193.138.115.101]:17849 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261178AbVAFWq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:46:57 -0500
Date: Thu, 6 Jan 2005 23:58:23 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: isdn4linux <isdn4linux@listserv.isdn4linux.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Karsten Keil <keil@isdn4linux.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>
Subject: [patch] copy_to_user return value checks in drivers/isdn/hisax/config.c
Message-ID: <Pine.LNX.4.61.0501062353420.3430@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a proposed patch for drivers/isdn/hisax/config.c to make sure the 
return value from copy_to_user gets checked and acted upon properly.
I don't have hardware to test this, so please review carefully before 
applying - I think it does the right thing, but I can't really test to 
know for sure.

Pplease keep me on CC as I'm not subscribed to the isdn4linux list.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk9-orig/drivers/isdn/hisax/config.c linux-2.6.10-bk9/drivers/isdn/hisax/config.c
--- linux-2.6.10-bk9-orig/drivers/isdn/hisax/config.c	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6.10-bk9/drivers/isdn/hisax/config.c	2005-01-06 23:49:19.000000000 +0100
@@ -625,6 +625,7 @@ int HiSax_readstatus(u_char __user *buf,
 	struct IsdnCardState *cs = hisax_findcard(id);
 
 	if (cs) {
+		int residue;
 		if (len > HISAX_STATUS_BUFSIZE) {
 			printk(KERN_WARNING
 			       "HiSax: status overflow readstat %d/%d\n",
@@ -633,7 +634,8 @@ int HiSax_readstatus(u_char __user *buf,
 		count = cs->status_end - cs->status_read + 1;
 		if (count >= len)
 			count = len;
-		copy_to_user(p, cs->status_read, count);
+		if (copy_to_user(p, cs->status_read, count))
+			return -EFAULT;
 		cs->status_read += count;
 		if (cs->status_read > cs->status_end)
 			cs->status_read = cs->status_buf;
@@ -644,9 +646,12 @@ int HiSax_readstatus(u_char __user *buf,
 				cnt = HISAX_STATUS_BUFSIZE;
 			else
 				cnt = count;
-			copy_to_user(p, cs->status_read, cnt);
+			if ((residue = copy_to_user(p, cs->status_read, cnt)) != 0)
+				cnt -= residue;
 			p += cnt;
 			cs->status_read += cnt % HISAX_STATUS_BUFSIZE;
+			if (residue)
+				return -EFAULT;
 			count -= cnt;
 		}
 		return len;



