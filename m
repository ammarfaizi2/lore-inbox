Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUISVfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUISVfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUISVfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:35:39 -0400
Received: from mail.dif.dk ([193.138.115.101]:15012 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264213AbUISVfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:35:38 -0400
Date: Sun, 19 Sep 2004 23:42:15 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Fritz Elfert <fritz@isdn4linux.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Karsten Keil <kkeil@suse.de>
Subject: [PATCH] check copy_from_user return value in act2000_isa_download
Message-ID: <Pine.LNX.4.61.0409192336300.2758@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch to fix the following warning by checking the return value 
of copy_from_user and returning -EFAULT if it fails.

drivers/isdn/act2000/act2000_isa.c: In function `act2000_isa_download':
drivers/isdn/act2000/act2000_isa.c:437: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result

I don't have the hardware so I've only been able to do compile testing of 
this patch.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


diff -up linux-2.6.9-rc2-bk5-orig/drivers/isdn/act2000/act2000_isa.c linux-2.6.9-rc2-bk5/drivers/isdn/act2000/act2000_isa.c
--- linux-2.6.9-rc2-bk5-orig/drivers/isdn/act2000/act2000_isa.c	2004-08-14 07:36:56.000000000 +0200
+++ linux-2.6.9-rc2-bk5/drivers/isdn/act2000/act2000_isa.c	2004-09-19 23:34:49.000000000 +0200
@@ -434,7 +434,10 @@ act2000_isa_download(act2000_card * card
                 l = (length > 1024) ? 1024 : length;
                 c = 0;
                 b = buf;
-                copy_from_user(buf, p, l);
+                if (copy_from_user(buf, p, l)) {
+                        kfree(buf);
+                        return -EFAULT;
+                }
                 while (c < l) {
                         if (act2000_isa_writeb(card, *b++)) {
                                 printk(KERN_WARNING


