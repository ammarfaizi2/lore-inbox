Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWGKGz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWGKGz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWGKGz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:55:59 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:35218 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030186AbWGKGz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:55:58 -0400
Date: Tue, 11 Jul 2006 09:55:56 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] msi: Only keep one msi_desc in each slab entry.
In-Reply-To: <m1k66kiqvw.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0607110951240.12720@sbz-30.cs.Helsinki.FI>
References: <m1veq5m87s.fsf@ebiederm.dsl.xmission.com>
 <84144f020607102303o3e379e95qc58cec97cbfd7d0c@mail.gmail.com>
 <m1k66kiqvw.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006, Eric W. Biederman wrote:
> Please look at what the code changes.
> Please recognize how very bad the current code is behaving.

Yes, there's plenty of slab confusion going on.

On Tue, 11 Jul 2006, Eric W. Biederman wrote:
> As for the rest sure go ahead and create a patch to address it
> but that really is a separate issue and thus a separate patch.
> 
> I'm just trying to keep the kernel from calling BUG_ON the first
> time a msi irq is allocated on a kernel with a maximum NR_CPUS
> configuration, and from wasting memory the rest of the time.
> 
> Or you know how bad the msi code is when every patch to fix a major
> issue is followed up comments on how to improve the code even further.

Ok.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 36bc7c4..77b08ee 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -45,16 +45,11 @@ msi_register(struct msi_ops *ops)
 	return 0;
 }
 
-static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
-{
-	memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
-}
-
 static int msi_cache_init(void)
 {
 	msi_cachep = kmem_cache_create("msi_cache",
-			NR_IRQS * sizeof(struct msi_desc),
-		       	0, SLAB_HWCACHE_ALIGN, msi_cache_ctor, NULL);
+			sizeof(struct msi_desc),
+		       	0, SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!msi_cachep)
 		return -ENOMEM;
 
@@ -402,11 +397,10 @@ static struct msi_desc* alloc_msi_entry(
 {
 	struct msi_desc *entry;
 
-	entry = kmem_cache_alloc(msi_cachep, SLAB_KERNEL);
+	entry = kmem_cache_zalloc(msi_cachep, GFP_KERNEL);
 	if (!entry)
 		return NULL;
 
-	memset(entry, 0, sizeof(struct msi_desc));
 	entry->link.tail = entry->link.head = 0;	/* single message */
 	entry->dev = NULL;
 
