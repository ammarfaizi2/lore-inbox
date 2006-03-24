Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423153AbWCXGLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423153AbWCXGLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbWCXGLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:11:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:33498 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161007AbWCXGLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:37 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>
Subject: [PATCH 11/12] aoe [2/3]: don't request ATA device ID on ATA error
In-Reply-To: <1143180654720-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:54 -0800
Message-Id: <11431806542227-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an ATA error response, take the device down instead of
sending another ATA device identify command.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

---

 drivers/block/aoe/aoecmd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

9d41965b783474dba9fcf3eb02e5eb60540e6ff6
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 207aabc..39da28d 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
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
1.2.4


