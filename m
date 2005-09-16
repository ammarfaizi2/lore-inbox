Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbVIPMUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbVIPMUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 08:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbVIPMUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 08:20:33 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:16512 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1161063AbVIPMUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 08:20:33 -0400
Date: Fri, 16 Sep 2005 14:20:31 +0200
Message-Id: <200509161220.j8GCKV37002454@localhost.localdomain>
In-reply-to: <20050916022319.12bf53f3.akpm@osdl.org>
Subject: [PATCH] drivers/base: a little speedup and cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.14-rc1-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
---

 platform.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Performance improvement -- we don't need to zero all allocated memory, only a
	few bytes from the beginning.
sizeof cleanup -- we want struct a *b; sizeof(*b) rather than sizeof(struct a).

---
commit 0173dea2b934339a62947115081483278c289d1d
tree 3fb8fcd0afa14f636972d2fa7d0a6d136a12654e
parent ee677410285dd60b28e9a5503365e7f0c961f01e
author root <root@bellona.(none)> Fri, 16 Sep 2005 14:16:10 +0200
committer root <root@bellona.(none)> Fri, 16 Sep 2005 14:16:10 +0200

 drivers/base/platform.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -225,18 +225,19 @@ struct platform_device *platform_device_
 	struct platform_object *pobj;
 	int retval;
 
-	pobj = kzalloc(sizeof(*pobj) + sizeof(struct resource) * num, GFP_KERNEL);
+	pobj = kmalloc(sizeof(*pobj) + sizeof(*res) * num, GFP_KERNEL);
 	if (!pobj) {
 		retval = -ENOMEM;
 		goto error;
 	}
+	memset(pobj, 0, sizeof(*pobj));
 
 	pobj->pdev.name = name;
 	pobj->pdev.id = id;
 	pobj->pdev.dev.release = platform_device_release_simple;
 
 	if (num) {
-		memcpy(pobj->resources, res, sizeof(struct resource) * num);
+		memcpy(pobj->resources, res, sizeof(*res) * num);
 		pobj->pdev.resource = pobj->resources;
 		pobj->pdev.num_resources = num;
 	}
