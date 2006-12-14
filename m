Return-Path: <linux-kernel-owner+w=401wt.eu-S1750849AbWLNEF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWLNEF1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 23:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWLNEF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 23:05:27 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:44087 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbWLNEF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 23:05:26 -0500
X-Greylist: delayed 3313 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 23:05:26 EST
Subject: [PATCH 2.6.20-rc1] ib_verbs: Use explicit if-else statements to
	avoid errors with do-while macros
From: Ben Collins <ben.collins@ubuntu.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Dec 2006 22:10:05 -0500
Message-Id: <1166065805.6748.135.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least on PPC, the "op ? op : dma" construct causes a compile failure
because the dma_* is a do{}while(0) macro.

This turns all of them into proper if/else to avoid this problem.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index fd2353f..3c2e105 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1456,9 +1456,9 @@ struct ib_mr *ib_get_dma_mr(struct ib_pd
  */
 static inline int ib_dma_mapping_error(struct ib_device *dev, u64 dma_addr)
 {
-	return dev->dma_ops ?
-		dev->dma_ops->mapping_error(dev, dma_addr) :
-		dma_mapping_error(dma_addr);
+	if (dev->dma_ops)
+		return dev->dma_ops->mapping_error(dev, dma_addr);
+	return dma_mapping_error(dma_addr);
 }
 
 /**
@@ -1472,9 +1472,9 @@ static inline u64 ib_dma_map_single(stru
 				    void *cpu_addr, size_t size,
 				    enum dma_data_direction direction)
 {
-	return dev->dma_ops ?
-		dev->dma_ops->map_single(dev, cpu_addr, size, direction) :
-		dma_map_single(dev->dma_device, cpu_addr, size, direction);
+	if (dev->dma_ops)
+		return dev->dma_ops->map_single(dev, cpu_addr, size, direction);
+	return dma_map_single(dev->dma_device, cpu_addr, size, direction);
 }
 
 /**
@@ -1488,8 +1488,9 @@ static inline void ib_dma_unmap_single(s
 				       u64 addr, size_t size,
 				       enum dma_data_direction direction)
 {
-	dev->dma_ops ?
-		dev->dma_ops->unmap_single(dev, addr, size, direction) :
+	if (dev->dma_ops)
+		dev->dma_ops->unmap_single(dev, addr, size, direction);
+	else
 		dma_unmap_single(dev->dma_device, addr, size, direction);
 }
 
@@ -1507,9 +1508,9 @@ static inline u64 ib_dma_map_page(struct
 				  size_t size,
 					 enum dma_data_direction direction)
 {
-	return dev->dma_ops ?
-		dev->dma_ops->map_page(dev, page, offset, size, direction) :
-		dma_map_page(dev->dma_device, page, offset, size, direction);
+	if (dev->dma_ops)
+		return dev->dma_ops->map_page(dev, page, offset, size, direction);
+	return dma_map_page(dev->dma_device, page, offset, size, direction);
 }
 
 /**
@@ -1523,8 +1524,9 @@ static inline void ib_dma_unmap_page(str
 				     u64 addr, size_t size,
 				     enum dma_data_direction direction)
 {
-	dev->dma_ops ?
-		dev->dma_ops->unmap_page(dev, addr, size, direction) :
+	if (dev->dma_ops)
+		dev->dma_ops->unmap_page(dev, addr, size, direction);
+	else
 		dma_unmap_page(dev->dma_device, addr, size, direction);
 }
 
@@ -1539,9 +1541,9 @@ static inline int ib_dma_map_sg(struct i
 				struct scatterlist *sg, int nents,
 				enum dma_data_direction direction)
 {
-	return dev->dma_ops ?
-		dev->dma_ops->map_sg(dev, sg, nents, direction) :
-		dma_map_sg(dev->dma_device, sg, nents, direction);
+	if (dev->dma_ops)
+		return dev->dma_ops->map_sg(dev, sg, nents, direction);
+	return dma_map_sg(dev->dma_device, sg, nents, direction);
 }
 
 /**
@@ -1555,8 +1557,9 @@ static inline void ib_dma_unmap_sg(struc
 				   struct scatterlist *sg, int nents,
 				   enum dma_data_direction direction)
 {
-	dev->dma_ops ?
-		dev->dma_ops->unmap_sg(dev, sg, nents, direction) :
+	if (dev->dma_ops)
+		dev->dma_ops->unmap_sg(dev, sg, nents, direction);
+	else
 		dma_unmap_sg(dev->dma_device, sg, nents, direction);
 }
 
@@ -1568,8 +1571,9 @@ static inline void ib_dma_unmap_sg(struc
 static inline u64 ib_sg_dma_address(struct ib_device *dev,
 				    struct scatterlist *sg)
 {
-	return dev->dma_ops ?
-		dev->dma_ops->dma_address(dev, sg) : sg_dma_address(sg);
+	if (dev->dma_ops)
+		return dev->dma_ops->dma_address(dev, sg);
+	return sg_dma_address(sg);
 }
 
 /**
@@ -1580,8 +1584,9 @@ static inline u64 ib_sg_dma_address(stru
 static inline unsigned int ib_sg_dma_len(struct ib_device *dev,
 					 struct scatterlist *sg)
 {
-	return dev->dma_ops ?
-		dev->dma_ops->dma_len(dev, sg) : sg_dma_len(sg);
+	if (dev->dma_ops)
+		return dev->dma_ops->dma_len(dev, sg);
+	return sg_dma_len(sg);
 }
 
 /**
@@ -1596,8 +1601,9 @@ static inline void ib_dma_sync_single_fo
 					      size_t size,
 					      enum dma_data_direction dir)
 {
-	dev->dma_ops ?
-		dev->dma_ops->sync_single_for_cpu(dev, addr, size, dir) :
+	if (dev->dma_ops)
+		dev->dma_ops->sync_single_for_cpu(dev, addr, size, dir);
+	else
 		dma_sync_single_for_cpu(dev->dma_device, addr, size, dir);
 }
 
@@ -1613,8 +1619,9 @@ static inline void ib_dma_sync_single_fo
 						 size_t size,
 						 enum dma_data_direction dir)
 {
-	dev->dma_ops ?
-		dev->dma_ops->sync_single_for_device(dev, addr, size, dir) :
+	if (dev->dma_ops)
+		dev->dma_ops->sync_single_for_device(dev, addr, size, dir);
+	else
 		dma_sync_single_for_device(dev->dma_device, addr, size, dir);
 }
 
@@ -1630,9 +1637,9 @@ static inline void *ib_dma_alloc_coheren
 					   u64 *dma_handle,
 					   gfp_t flag)
 {
-	return dev->dma_ops ?
-		dev->dma_ops->alloc_coherent(dev, size, dma_handle, flag) :
-		dma_alloc_coherent(dev->dma_device, size, dma_handle, flag);
+	if (dev->dma_ops)
+		return dev->dma_ops->alloc_coherent(dev, size, dma_handle, flag);
+	return dma_alloc_coherent(dev->dma_device, size, dma_handle, flag);
 }
 
 /**
@@ -1646,8 +1653,9 @@ static inline void ib_dma_free_coherent(
 					size_t size, void *cpu_addr,
 					u64 dma_handle)
 {
-	dev->dma_ops ?
-		dev->dma_ops->free_coherent(dev, size, cpu_addr, dma_handle) :
+	if (dev->dma_ops)
+		dev->dma_ops->free_coherent(dev, size, cpu_addr, dma_handle);
+	else
 		dma_free_coherent(dev->dma_device, size, cpu_addr, dma_handle);
 }
 

