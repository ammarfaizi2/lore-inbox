Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTEIXFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTEIXFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:05:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263570AbTEIXFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:05:16 -0400
Date: Fri, 9 May 2003 16:17:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.69] Fix module ref counting in block/loop.c
Message-Id: <20030509161753.75a17f2e.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace old MOD_INC with new __module_get.
No need for using try_module_get, because module_get is only called in open
routine where there must already be a ref count.

diff -Nru a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Fri May  9 15:54:51 2003
+++ b/drivers/block/loop.c	Fri May  9 15:54:51 2003
@@ -651,7 +651,7 @@
 	int		lo_flags = 0;
 	int		error;
 
-	MOD_INC_USE_COUNT;
+	__module_get(THIS_MODULE);	/* already have ref we are open */
 
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
@@ -751,7 +751,7 @@
  out_putf:
 	fput(file);
  out:
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return error;
 }
 
@@ -824,7 +824,7 @@
 	filp->f_dentry->d_inode->i_mapping->gfp_mask = gfp;
 	lo->lo_state = Lo_unbound;
 	fput(filp);
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return 0;
 }
 
