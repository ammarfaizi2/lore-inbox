Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVCJDYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVCJDYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVCJBJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:09:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:51871 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262621AbVCJAm3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:29 -0500
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: fail IO on disk errors
In-Reply-To: <1110413963858@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:19:23 -0800
Message-Id: <11104139631637@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2038, 2005/03/09 10:21:33-08:00, ecashin@coraid.com

[PATCH] aoe: fail IO on disk errors

This patch makes disk errors fail the IO instead of getting logged and
ignored.


Fail IO on disk errors

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/block/aoe/aoecmd.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
--- a/drivers/block/aoe/aoecmd.c	2005-03-09 16:15:53 -08:00
+++ b/drivers/block/aoe/aoecmd.c	2005-03-09 16:15:53 -08:00
@@ -416,7 +416,9 @@
 
 	if (ahin->cmdstat & 0xa9) {	/* these bits cleared on success */
 		printk(KERN_CRIT "aoe: aoecmd_ata_rsp: ata error cmd=%2.2Xh "
-			"stat=%2.2Xh\n", ahout->cmdstat, ahin->cmdstat);
+			"stat=%2.2Xh from e%ld.%ld\n", 
+			ahout->cmdstat, ahin->cmdstat,
+			d->aoemajor, d->aoeminor);
 		if (buf)
 			buf->flags |= BUFFL_FAIL;
 	} else {
@@ -458,8 +460,8 @@
 	if (buf) {
 		buf->nframesout -= 1;
 		if (buf->nframesout == 0 && buf->resid == 0) {
-			n = !(buf->flags & BUFFL_FAIL);
-			bio_endio(buf->bio, buf->bio->bi_size, 0);
+			n = (buf->flags & BUFFL_FAIL) ? -EIO : 0;
+			bio_endio(buf->bio, buf->bio->bi_size, n);
 			mempool_free(buf, d->bufpool);
 		}
 	}

