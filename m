Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWHUJIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWHUJIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWHUJIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:08:42 -0400
Received: from tim.rpsys.net ([194.106.48.114]:21738 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750898AbWHUJIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:08:41 -0400
Subject: [PATCH] [MTD] Protect chip->ops with correct locking - fix jffs2
	corruption
From: Richard Purdie <rpurdie@rpsys.net>
To: Josh Boyer <jwboyer@gmail.com>, Greg KH <greg@kroah.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       linux-mtd <linux-mtd@lists.infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 10:05:10 +0100
Message-Id: <1156151110.5557.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read the return value before we release the nand device otherwise the
value can become corrupted by another user of chip->ops, ultimately
resulting in filesystem corruption.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Josh Boyer <jwboyer@gmail.com>

---

This fixes the jffs2 errors and filesystem corruption I reported. It
should be applied for 2.6.18.

On Sun, 2006-08-20 at 18:35 -0700, Greg KH wrote:
> On Sat, Aug 19, 2006 at 08:34:46PM -0500, Josh Boyer wrote: 
> > We have multiple confirmations that this patch fixes the issue
> > reported.  I agree it should go in 2.6.18.
> > 
> > Greg, can you add this to your tree?
> 
> Add what to what tree?  I need things to be a bit more specific
> here :) 

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
 


