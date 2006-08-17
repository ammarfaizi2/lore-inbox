Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWHQWNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWHQWNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWHQWNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:13:11 -0400
Received: from tim.rpsys.net ([194.106.48.114]:27335 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030275AbWHQWNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:13:10 -0400
Subject: Re: 2.6.18-rc4 jffs2 problems
From: Richard Purdie <rpurdie@rpsys.net>
To: linux-mtd <linux-mtd@lists.infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1154976111.17725.8.camel@localhost.localdomain>
References: <1154976111.17725.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 23:09:47 +0100
Message-Id: <1155852587.5530.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read the return value before we release the nand device otherwise the
value can become corrupted by another user of chip->ops, ultimately
resulting in filesystem corruption.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

---

This fixes the jffs2 errors and filesystem corruption I reported. It
should be applied for 2.6.18.

 drivers/mtd/nand/nand_base.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: git/drivers/mtd/nand/nand_base.c
===================================================================
--- git.orig/drivers/mtd/nand/nand_base.c	2006-08-17 22:46:19.000000000 +0100
+++ git/drivers/mtd/nand/nand_base.c	2006-08-17 22:47:27.000000000 +0100
@@ -1093,9 +1093,10 @@ static int nand_read(struct mtd_info *mt
 
 	ret = nand_do_read_ops(mtd, from, &chip->ops);
 
+	*retlen = chip->ops.retlen;
+
 	nand_release_device(mtd);
 
-	*retlen = chip->ops.retlen;
 	return ret;
 }
 
@@ -1691,9 +1692,10 @@ static int nand_write(struct mtd_info *m
 
 	ret = nand_do_write_ops(mtd, to, &chip->ops);
 
+	*retlen = chip->ops.retlen;
+
 	nand_release_device(mtd);
 
-	*retlen = chip->ops.retlen;
 	return ret;
 }
 


