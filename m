Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUGACtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUGACtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 22:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUGACtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 22:49:33 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:23685 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263741AbUGACt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 22:49:27 -0400
Subject: [PATCH] implement on-chip Coherent memory API for DMA
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Ian Molton <spyro@f2s.com>, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com, david-b@pacbell.net,
       Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jun 2004 21:49:22 -0500
Message-Id: <1088650166.1889.8.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just adds the description and the skeleton null implementation

James

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/30 21:02:11-05:00 jejb@mulgrave.(none) 
#   Add dma_declare_coherent_memory() API
#   
#   This adds the description and a null prototype.
# 
# include/linux/dma-mapping.h
#   2004/06/30 21:01:43-05:00 jejb@mulgrave.(none) +26 -0
#   Add dma_declare_coherent_memory() API
# 
# Documentation/DMA-API.txt
#   2004/06/30 21:01:43-05:00 jejb@mulgrave.(none) +79 -0
#   Add dma_declare_coherent_memory() API
# 
diff -Nru a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
--- a/Documentation/DMA-API.txt	2004-06-30 21:45:21 -05:00
+++ b/Documentation/DMA-API.txt	2004-06-30 21:45:21 -05:00
@@ -444,4 +444,83 @@
 continuing on for size.  Again, you *must* observe the cache line
 boundaries when doing this.
 
+int
+dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+			    dma_addr_t device_addr, size_t size, int
+			    flags)
+
+
+Declare region of memory to be handed out by dma_alloc_coherent when
+it's asked for coherent memory for this device.
+
+bus_addr is the physical address to which the memory is currently
+assigned in the bus responding region (this will be used by the
+platform to perform the mapping)
+
+device_addr is the physical address the device needs to be programmed
+with actually to address this memory (this will be handed out as the
+dma_addr_t in dma_alloc_coherent())
+
+size is the size of the area (must be multiples of PAGE_SIZE).
+
+flags can be or'd together and are
+
+DMA_MEMORY_MAP - request that the memory returned from
+dma_alloc_coherent() be directly writeable.
+
+DMA_MEMORY_IO - request that the memory returned from
+dma_alloc_coherent() be addressable using read/write/memcpy_toio etc.
+
+One or both of these flags must be present
+
+DMA_MEMORY_INCLUDES_CHILDREN - make the declared memory be allocated by
+dma_alloc_coherent of any child devices of this one (for memory residing
+on a bridge).
+
+DMA_MEMORY_EXCLUSIVE - only allocate memory from the declared regions. 
+Do not allow dma_alloc_coherent() to fall back to system memory when
+it's out of memory in the declared region.
+
+The return value will be either DMA_MEMORY_MAP or DMA_MEMORY_IO and
+must correspond to a passed in flag (i.e. no returning DMA_MEMORY_IO
+if only DMA_MEMORY_MAP were passed in) for success or zero for
+failure.
+
+Note, for DMA_MEMORY_IO returns, all subsequent memory returned by
+dma_alloc_coherent() may no longer be accessed directly, but instead
+must be accessed using the correct bus functions.  If your driver
+isn't prepared to handle this contingency, it should not specify
+DMA_MEMORY_IO in the input flags.
+
+As a simplification for the platforms, only *one* such region of
+memory may be declared per device.
+
+For reasons of efficiency, most platforms choose to track the declared
+region only at the granularity of a page.  For smaller allocations,
+you should use the dma_pool() API.
+
+void
+dma_release_declared_memory(struct device *dev)
+
+Remove the memory region previously declared from the system.  This
+API performs *no* in-use checking for this region and will return
+unconditionally having removed all the required structures.  It is the
+drivers job to ensure that no parts of this memory region are
+currently in use.
+
+void *
+dma_mark_declared_memory_occupied(struct device *dev,
+				  dma_addr_t device_addr, size_t size)
+
+This is used to occupy specific regions of the declared space
+(dma_alloc_coherent() will hand out the first free region it finds).
+
+device_addr is the *device* address of the region requested
+
+size is the size (and should be a page sized multiple).
+
+The return value will be either a pointer to the processor virtual
+address of the memory, or an error (via PTR_ERR()) if any part of the
+region is occupied.
+
 
diff -Nru a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
--- a/include/linux/dma-mapping.h	2004-06-30 21:45:21 -05:00
+++ b/include/linux/dma-mapping.h	2004-06-30 21:45:22 -05:00
@@ -42,6 +42,32 @@
 }
 #endif
 
+/* flags for the coherent memory api */
+#define	DMA_MEMORY_MAP			0x01
+#define DMA_MEMORY_IO			0x02
+#define DMA_MEMORY_INCLUDES_CHILDREN	0x04
+#define DMA_MEMORY_EXCLUSIVE		0x08
+
+#ifndef ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+static inline int
+dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+			    dma_addr_t device_addr, size_t size, int flags)
+{
+	return 0;
+}
+
+static inline void
+dma_release_declared_memory(struct device *dev)
+{
+}
+
+void *dma_mark_declared_memory_occupied(struct device *dev,
+					dma_addr_t device_addr, size_t size)
+{
+	return ERR_PTR(-EBUSY);
+}
+#endif
+
 #endif
 


