Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVAYP1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVAYP1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVAYP1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:27:48 -0500
Received: from ns1.coraid.com ([65.14.39.133]:58825 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261979AbVAYP1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:27:39 -0500
To: Greg K-H <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH  block-2.6] aoe: fail IO on disk errors
From: Ed L Cashin <ecashin@coraid.com>
Date: Tue, 25 Jan 2005 10:11:43 -0500
Message-ID: <87d5vt4k7k.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

This patch makes disk errors fail the IO instead of getting logged and
ignored.


Fail IO on disk errors
Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=diff-91-block

diff -uprN block-2.6-aa/drivers/block/aoe/aoecmd.c block-2.6-bb/drivers/block/aoe/aoecmd.c
--- block-2.6-aa/drivers/block/aoe/aoecmd.c	2005-01-25 08:07:33.000000000 -0500
+++ block-2.6-bb/drivers/block/aoe/aoecmd.c	2005-01-25 10:00:45.000000000 -0500
@@ -416,7 +416,9 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 
 	if (ahin->cmdstat & 0xa9) {	/* these bits cleared on success */
 		printk(KERN_CRIT "aoe: aoecmd_ata_rsp: ata error cmd=%2.2Xh "
-			"stat=%2.2Xh\n", ahout->cmdstat, ahin->cmdstat);
+			"stat=%2.2Xh from e%ld.%ld\n", 
+			ahout->cmdstat, ahin->cmdstat,
+			d->aoemajor, d->aoeminor);
 		if (buf)
 			buf->flags |= BUFFL_FAIL;
 	} else {
@@ -458,8 +460,8 @@ aoecmd_ata_rsp(struct sk_buff *skb)
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

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

