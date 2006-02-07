Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWBGQpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWBGQpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWBGQpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:45:55 -0500
Received: from ns1.coraid.com ([65.14.39.133]:59522 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1750961AbWBGQpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:45:55 -0500
Message-ID: <da638be17efe289af96e958ab6c5dc54@coraid.com>
Date: Tue, 7 Feb 2006 11:37:24 -0500
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.16-rc2-git2-gkh] aoe [2/3]: don't request ATA device ID on ATA error
References: <E1F6Vgr-0005nf-02@kokone>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

On an ATA error response, take the device down instead of
sending another ATA device identify command.

diff -upr 2.6.16-rc2-git2-gkh-orig/drivers/block/aoe/aoecmd.c 2.6.16-rc2-git2-gkh-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.16-rc2-git2-gkh-orig/drivers/block/aoe/aoecmd.c	2006-02-06 17:41:05.000000000 -0500
+++ 2.6.16-rc2-git2-gkh-aoe/drivers/block/aoe/aoecmd.c	2006-02-06 17:56:59.000000000 -0500
@@ -517,6 +517,8 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	ahout = (struct aoe_atahdr *) (f->data + sizeof(struct aoe_hdr));
 	buf = f->buf;
 
+	if (ahout->cmdstat == WIN_IDENTIFY)
+		d->flags &= ~DEVFL_PAUSE;
 	if (ahin->cmdstat & 0xa9) {	/* these bits cleared on success */
 		printk(KERN_CRIT "aoe: aoecmd_ata_rsp: ata error cmd=%2.2Xh "
 			"stat=%2.2Xh from e%ld.%ld\n", 
@@ -549,7 +551,6 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 				return;
 			}
 			ataid_complete(d, (char *) (ahin+1));
-			d->flags &= ~DEVFL_PAUSE;
 			break;
 		default:
 			printk(KERN_INFO "aoe: aoecmd_ata_rsp: unrecognized "


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
