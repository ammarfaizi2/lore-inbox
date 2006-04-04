Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWDDTAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWDDTAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWDDTAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:00:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39183 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750733AbWDDTAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:00:04 -0400
Date: Tue, 4 Apr 2006 21:00:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: hjlipp@web.de, tilman@imap.cc
Cc: gigaset307x-common@lists.sourceforge.net, kkeil@suse.de,
       isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] isdn/gigaset/common.c: fix a memory leak
Message-ID: <20060404190002.GZ6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a memory leak spotted by the Coverity checker
if (!try_module_get(owner)).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/gigaset/common.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- linux-2.6.17-rc1-mm1-full/drivers/isdn/gigaset/common.c.old	2006-04-04 19:45:19.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/isdn/gigaset/common.c	2006-04-04 19:51:23.000000000 +0200
@@ -1110,8 +1110,9 @@ struct gigaset_driver *gigaset_initdrive
 	drv = kmalloc(sizeof *drv, GFP_KERNEL);
 	if (!drv)
 		return NULL;
+
 	if (!try_module_get(owner))
-		return NULL;
+		goto out1;
 
 	drv->cs = NULL;
 	drv->have_tty = 0;
@@ -1125,10 +1126,11 @@ struct gigaset_driver *gigaset_initdrive
 
 	drv->cs = kmalloc(minors * sizeof *drv->cs, GFP_KERNEL);
 	if (!drv->cs)
-		goto out1;
+		goto out2;
+
 	drv->flags = kmalloc(minors * sizeof *drv->flags, GFP_KERNEL);
 	if (!drv->flags)
-		goto out2;
+		goto out3;
 
 	for (i = 0; i < minors; ++i) {
 		drv->flags[i] = 0;
@@ -1145,11 +1147,12 @@ struct gigaset_driver *gigaset_initdrive
 
 	return drv;
 
-out2:
+out3:
 	kfree(drv->cs);
+out2:
+	module_put(owner);
 out1:
 	kfree(drv);
-	module_put(owner);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(gigaset_initdriver);

