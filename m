Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUJEVg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUJEVg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUJEVg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:36:29 -0400
Received: from mail.dif.dk ([193.138.115.101]:40150 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266048AbUJEVg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:36:27 -0400
Date: Tue, 5 Oct 2004 23:43:54 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Markus Lidel <markus.lidel@shadowconnect.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] add missing checks of __copy_to_user return value in
 i2o_config.c
Message-ID: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes up the following :

  CC      drivers/message/i2o/i2o_config.o
include/asm/uaccess.h: In function `i2o_cfg_getiops':
drivers/message/i2o/i2o_config.c:190: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
include/asm/uaccess.h: In function `i2o_cfg_swul':
drivers/message/i2o/i2o_config.c:477: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c
--- linux-2.6.9-rc3-bk5-orig/drivers/message/i2o/i2o_config.c	2004-09-30 05:05:40.000000000 +0200
+++ linux-2.6.9-rc3-bk5/drivers/message/i2o/i2o_config.c	2004-10-05 23:32:43.000000000 +0200
@@ -187,7 +187,8 @@ static int i2o_cfg_getiops(unsigned long
 	list_for_each_entry(c, &i2o_controllers, list)
 	    tmp[c->unit] = 1;
 
-	__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS);
+	if (__copy_to_user(user_iop_table, tmp, MAX_I2O_CONTROLLERS))
+		return -EFAULT;
 
 	return 0;
 };
@@ -474,7 +475,9 @@ static int i2o_cfg_swul(unsigned long ar
 		return status;
 	}
 
-	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
+	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize))
+		return -EFAULT;
+
 	i2o_dma_free(&c->pdev->dev, &buffer);
 
 	return 0;


