Return-Path: <linux-kernel-owner+w=401wt.eu-S932649AbWLZPSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWLZPSs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWLZPSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:18:47 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:15386 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650AbWLZPSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:18:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=t/zvoLl/43pIg2LbYw+m/aL0HUvhIfhdPPASTmSnySk/lRgOsQylO8eFL0BggB3mlXVAojWQysslpOhMPV76BiMVNQkaMx8BQ/D34G9DcqWrBXabS6ctXEHE/XtWSKQ5B809HuKvQ8FseN2irCtM2L/D4BqR2Xmow5b84DqWr5E=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/12] devres: implement managed DMA interface
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 27 Dec 2006 00:18:34 +0900
Message-Id: <11671463141533-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement managed DMA interface - dmam_alloc_coherent(),
dmam_free_coherent(), dmam_declare_coherent_memory(),
dmam_pool_create() and dmam_pool_destroy().  Except for being managed,
these take the same arguments and have the same effect as non-managed
counterparts.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/base/Makefile       |    3 +-
 drivers/base/dma-mapping.c  |  218 +++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dmapool.c      |   59 ++++++++++++
 include/linux/dma-mapping.h |   29 ++++++-
 include/linux/dmapool.h     |    7 ++
 5 files changed, 314 insertions(+), 2 deletions(-)

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index e236f42..e9eb738 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -2,7 +2,8 @@
 
 obj-y			:= core.o sys.o bus.o dd.o \
 			   driver.o class.o platform.o \
-			   cpu.o firmware.o init.o map.o dmapool.o devres.o \
+			   cpu.o firmware.o init.o map.o dmapool.o \
+			   dma-mapping.o devres.o \
 			   attribute_container.o transport_class.o
 obj-y			+= power/
 obj-$(CONFIG_ISA)	+= isa.o
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
new file mode 100644
index 0000000..ca9186f
--- /dev/null
+++ b/drivers/base/dma-mapping.c
@@ -0,0 +1,218 @@
+/*
+ * drivers/base/dma-mapping.c - arch-independent dma-mapping routines
+ *
+ * Copyright (c) 2006  SUSE Linux Products GmbH
+ * Copyright (c) 2006  Tejun Heo <teheo@suse.de>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/dma-mapping.h>
+
+/*
+ * Managed DMA API
+ */
+struct dma_devres {
+	size_t		size;
+	void		*vaddr;
+	dma_addr_t	dma_handle;
+};
+
+static void dmam_coherent_release(struct device *dev, void *res)
+{
+	struct dma_devres *this = res;
+
+	dma_free_coherent(dev, this->size, this->vaddr, this->dma_handle);
+}
+
+static void dmam_noncoherent_release(struct device *dev, void *res)
+{
+	struct dma_devres *this = res;
+
+	dma_free_noncoherent(dev, this->size, this->vaddr, this->dma_handle);
+}
+
+static int dmam_match(struct device *dev, void *res, void *match_data)
+{
+	struct dma_devres *this = res, *match = match_data;
+
+	if (this->vaddr == match->vaddr) {
+		WARN_ON(this->size != match->size ||
+			this->dma_handle != match->dma_handle);
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * dmam_alloc_coherent - Managed dma_alloc_coherent()
+ * @dev: Device to allocate coherent memory for
+ * @size: Size of allocation
+ * @dma_handle: Out argument for allocated DMA handle
+ * @gfp: Allocation flags
+ *
+ * Managed dma_alloc_coherent().  Memory allocated using this function
+ * will be automatically released on driver detach.
+ *
+ * RETURNS:
+ * Pointer to allocated memory on success, NULL on failure.
+ */
+void * dmam_alloc_coherent(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle, gfp_t gfp)
+{
+	struct dma_devres *dr;
+	void *vaddr;
+
+	dr = devres_alloc(dmam_coherent_release, sizeof(*dr), gfp);
+	if (!dr)
+		return NULL;
+
+	vaddr = dma_alloc_coherent(dev, size, dma_handle, gfp);
+	if (!vaddr) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	dr->vaddr = vaddr;
+	dr->dma_handle = *dma_handle;
+	dr->size = size;
+
+	devres_add(dev, dr);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(dmam_alloc_coherent);
+
+/**
+ * dmam_free_coherent - Managed dma_free_coherent()
+ * @dev: Device to free coherent memory for
+ * @size: Size of allocation
+ * @vaddr: Virtual address of the memory to free
+ * @dma_handle: DMA handle of the memory to free
+ *
+ * Managed dma_free_coherent().
+ */
+void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
+			dma_addr_t dma_handle)
+{
+	struct dma_devres match_data = { size, vaddr, dma_handle };
+
+	dma_free_coherent(dev, size, vaddr, dma_handle);
+	WARN_ON(devres_destroy(dev, dmam_coherent_release, dmam_match,
+			       &match_data));
+}
+EXPORT_SYMBOL(dmam_free_coherent);
+
+/**
+ * dmam_alloc_non_coherent - Managed dma_alloc_non_coherent()
+ * @dev: Device to allocate non_coherent memory for
+ * @size: Size of allocation
+ * @dma_handle: Out argument for allocated DMA handle
+ * @gfp: Allocation flags
+ *
+ * Managed dma_alloc_non_coherent().  Memory allocated using this
+ * function will be automatically released on driver detach.
+ *
+ * RETURNS:
+ * Pointer to allocated memory on success, NULL on failure.
+ */
+void *dmam_alloc_noncoherent(struct device *dev, size_t size,
+			     dma_addr_t *dma_handle, gfp_t gfp)
+{
+	struct dma_devres *dr;
+	void *vaddr;
+
+	dr = devres_alloc(dmam_noncoherent_release, sizeof(*dr), gfp);
+	if (!dr)
+		return NULL;
+
+	vaddr = dma_alloc_noncoherent(dev, size, dma_handle, gfp);
+	if (!vaddr) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	dr->vaddr = vaddr;
+	dr->dma_handle = *dma_handle;
+	dr->size = size;
+
+	devres_add(dev, dr);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(dmam_alloc_noncoherent);
+
+/**
+ * dmam_free_coherent - Managed dma_free_noncoherent()
+ * @dev: Device to free noncoherent memory for
+ * @size: Size of allocation
+ * @vaddr: Virtual address of the memory to free
+ * @dma_handle: DMA handle of the memory to free
+ *
+ * Managed dma_free_noncoherent().
+ */
+void dmam_free_noncoherent(struct device *dev, size_t size, void *vaddr,
+			   dma_addr_t dma_handle)
+{
+	struct dma_devres match_data = { size, vaddr, dma_handle };
+
+	dma_free_noncoherent(dev, size, vaddr, dma_handle);
+	WARN_ON(!devres_destroy(dev, dmam_noncoherent_release, dmam_match,
+				&match_data));
+}
+EXPORT_SYMBOL(dmam_free_noncoherent);
+
+#ifdef ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+
+static void dmam_coherent_decl_release(struct device *dev, void *res)
+{
+	dma_release_declared_memory(dev);
+}
+
+/**
+ * dmam_declare_coherent_memory - Managed dma_declare_coherent_memory()
+ * @dev: Device to declare coherent memory for
+ * @bus_addr: Bus address of coherent memory to be declared
+ * @device_addr: Device address of coherent memory to be declared
+ * @size: Size of coherent memory to be declared
+ * @flags: Flags
+ *
+ * Managed dma_declare_coherent_memory().
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+int dmam_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+				 dma_addr_t device_addr, size_t size, int flags)
+{
+	void *res;
+	int rc;
+
+	res = devres_alloc(dmam_coherent_decl_release, 0, GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	rc = dma_declare_coherent_memory(dev, bus_addr, device_addr, size,
+					 flags);
+	if (rc == 0)
+		devres_add(dev, res);
+	else
+		devres_free(res);
+
+	return rc;
+}
+EXPORT_SYMBOL(dmam_declare_coherent_memory);
+
+/**
+ * dmam_release_declared_memory - Managed dma_release_declared_memory().
+ * @dev: Device to release declared coherent memory for
+ *
+ * Managed dmam_release_declared_memory().
+ */
+void dmam_release_declared_memory(struct device *dev)
+{
+	WARN_ON(devres_destroy(dev, dmam_coherent_decl_release, NULL, NULL));
+}
+EXPORT_SYMBOL(dmam_release_declared_memory);
+
+#endif
diff --git a/drivers/base/dmapool.c b/drivers/base/dmapool.c
index f95d502..cd467c9 100644
--- a/drivers/base/dmapool.c
+++ b/drivers/base/dmapool.c
@@ -415,8 +415,67 @@ dma_pool_free (struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	spin_unlock_irqrestore (&pool->lock, flags);
 }
 
+/*
+ * Managed DMA pool
+ */
+static void dmam_pool_release(struct device *dev, void *res)
+{
+	struct dma_pool *pool = *(struct dma_pool **)res;
+
+	dma_pool_destroy(pool);
+}
+
+static int dmam_pool_match(struct device *dev, void *res, void *match_data)
+{
+	return *(struct dma_pool **)res == match_data;
+}
+
+/**
+ * dmam_pool_create - Managed dma_pool_create()
+ * @name: name of pool, for diagnostics
+ * @dev: device that will be doing the DMA
+ * @size: size of the blocks in this pool.
+ * @align: alignment requirement for blocks; must be a power of two
+ * @allocation: returned blocks won't cross this boundary (or zero)
+ *
+ * Managed dma_pool_create().  DMA pool created with this function is
+ * automatically destroyed on driver detach.
+ */
+struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
+				  size_t size, size_t align, size_t allocation)
+{
+	struct dma_pool **ptr, *pool;
+
+	ptr = devres_alloc(dmam_pool_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	pool = *ptr = dma_pool_create(name, dev, size, align, allocation);
+	if (pool)
+		devres_add(dev, ptr);
+	else
+		devres_free(ptr);
+
+	return pool;
+}
+
+/**
+ * dmam_pool_destroy - Managed dma_pool_destroy()
+ * @pool: dma pool that will be destroyed
+ *
+ * Managed dma_pool_destroy().
+ */
+void dmam_pool_destroy(struct dma_pool *pool)
+{
+	struct device *dev = pool->dev;
+
+	dma_pool_destroy(pool);
+	WARN_ON(devres_destroy(dev, dmam_pool_release, dmam_pool_match, pool));
+}
 
 EXPORT_SYMBOL (dma_pool_create);
 EXPORT_SYMBOL (dma_pool_destroy);
 EXPORT_SYMBOL (dma_pool_alloc);
 EXPORT_SYMBOL (dma_pool_free);
+EXPORT_SYMBOL (dmam_pool_create);
+EXPORT_SYMBOL (dmam_pool_destroy);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ff203c4..9a663c6 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -66,6 +66,33 @@ dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif
 
-#endif
+/*
+ * Managed DMA API
+ */
+extern void *dmam_alloc_coherent(struct device *dev, size_t size,
+				 dma_addr_t *dma_handle, gfp_t gfp);
+extern void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
+			       dma_addr_t dma_handle);
+extern void *dmam_alloc_noncoherent(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp);
+extern void dmam_free_noncoherent(struct device *dev, size_t size, void *vaddr,
+				  dma_addr_t dma_handle);
+#ifdef ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+extern int dmam_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+					dma_addr_t device_addr, size_t size,
+					int flags);
+extern void dmam_release_declared_memory(struct device *dev);
+#else /* ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY */
+static inline int dmam_declare_coherent_memory(struct device *dev,
+				dma_addr_t bus_addr, dma_addr_t device_addr,
+				size_t size, gfp_t gfp)
+{
+	return 0;
+}
 
+static inline void dmam_release_declared_memory(struct device *dev)
+{
+}
+#endif /* ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY */
 
+#endif
diff --git a/include/linux/dmapool.h b/include/linux/dmapool.h
index 76f12f4..022e34f 100644
--- a/include/linux/dmapool.h
+++ b/include/linux/dmapool.h
@@ -24,5 +24,12 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 
 void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
 
+/*
+ * Managed DMA pool
+ */
+struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
+				  size_t size, size_t align, size_t allocation);
+void dmam_pool_destroy(struct dma_pool *pool);
+
 #endif
 
-- 
1.4.4.2


