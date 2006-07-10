Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWGJWAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWGJWAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWGJWAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:00:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51073 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965034AbWGJWAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:00:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] msi: Only keep one msi_desc in each slab entry.
Date: Mon, 10 Jul 2006 16:00:07 -0600
Message-ID: <m1veq5m87s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like someone confused kmem_cache_create with a different
allocator and was attempting to give it knowledge of how many cache
entries there were.

With the unfortunate result that each slab entry was big enough to
hold every irq.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0cd4a3e..082e942 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -40,13 +40,13 @@ msi_register(struct msi_ops *ops)
 
 static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
 {
-	memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
+	memset(p, 0, sizeof(struct msi_desc));
 }
 
 static int msi_cache_init(void)
 {
 	msi_cachep = kmem_cache_create("msi_cache",
-			NR_IRQS * sizeof(struct msi_desc),
+			sizeof(struct msi_desc),
 		       	0, SLAB_HWCACHE_ALIGN, msi_cache_ctor, NULL);
 	if (!msi_cachep)
 		return -ENOMEM;
-- 
1.4.1.gac83a

