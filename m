Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSL1QFR>; Sat, 28 Dec 2002 11:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSL1QFR>; Sat, 28 Dec 2002 11:05:17 -0500
Received: from host194.steeleye.com ([66.206.164.34]:56591 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263589AbSL1QFO>; Sat, 28 Dec 2002 11:05:14 -0500
Message-Id: <200212281613.gBSGDTn02392@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Fri, 27 Dec 2002 17:56:43 PST." <3E0D04DB.1000500@pacbell.net> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_8035964960"
Date: Sat, 28 Dec 2002 10:13:28 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_8035964960
Content-Type: text/plain; charset=us-ascii

OK, the attached is a sketch of an implementation of bus_type operations.

It renames all the platform dma_ operations to platform_dma_  and will call 
only the bus specific operation if it exists.  Thus it will be the 
responsibility of the bus to call the platform_dma_ functions correctly (this 
one is a large loaded gun).

The answer to error handling in the general case is still no (because I don't 
want to impact the main line code for a specific problem, and the main line is 
x86 which effectively has infinite mapping resources), but I don't see why the 
platforms can't export a set of values they guarantee not to return as 
dma_addr_t's that you can use for errors in the bus implementations.

Would this solve most of your problems?

James


--==_Exmh_8035964960
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== include/linux/device.h 1.70 vs edited =====
--- 1.70/include/linux/device.h	Mon Dec 16 10:01:41 2002
+++ edited/include/linux/device.h	Sat Dec 28 09:57:51 2002
@@ -61,6 +61,7 @@
 struct device;
 struct device_driver;
 struct device_class;
+struct bus_dma_ops;
 
 struct bus_type {
 	char			* name;
@@ -75,6 +76,7 @@
 	struct device * (*add)	(struct device * parent, char * bus_id);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
+	struct bus_dma_ops *	dma_ops;
 };
 
 
===== include/linux/dma-mapping.h 1.1 vs edited =====
--- 1.1/include/linux/dma-mapping.h	Sat Dec 21 22:37:05 2002
+++ edited/include/linux/dma-mapping.h	Sat Dec 28 10:02:37 2002
@@ -10,7 +10,144 @@
 	DMA_NONE = 3,
 };
 
+struct bus_dma_ops {
+	int (*supported)(struct device *dev, u64 mask);
+	int (*set_mask)(struct device *dev, u64 mask);
+	void *(*alloc_coherent)(struct device *dev, size_t size,
+				dma_addr_t *dma_handle);
+	void (*free_coherent)(struct device *dev, size_t size, void *cpu_addr,
+			      dma_addr_t dma_handle);
+	dma_addr_t (*map_single)(struct device *dev, void *cpu_addr,
+				 size_t size, enum dma_data_direction direction);
+	void (*unmap_single)(struct device *dev, dma_addr_t dma_addr,
+			     size_t size, enum dma_data_direction direction);
+	int (*map_sg)(struct device *dev, struct scatterlist *sg, int nents,
+		      enum dma_data_direction direction);
+	void (*unmap_sg)(struct device *dev, struct scatterlist *sg,
+			 int nhwentries, enum dma_data_direction direction);
+	void (*sync_single)(struct device *dev, dma_addr_t dma_handle,
+			    size_t size, enum dma_data_direction direction);
+	void (*sync_sg)(struct device *dev, struct scatterlist *sg, int nelems,
+			enum dma_data_direction direction);
+};
+
 #include <asm/dma-mapping.h>
+
+static inline int
+dma_supported(struct device *dev, u64 mask)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->supported)
+		return bus->dma_ops->supported(dev, mask);
+
+	return platform_dma_supported(dev, mask);
+}
+
+static inline int
+dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->set_mask)
+		return bus->dma_ops->set_mask(dev, mask);
+	
+	return platform_dma_set_mask(dev, dma_mask);
+}
+
+static inline void *
+dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->alloc_coherent)
+		return bus->dma_ops->alloc_coherent(dev, size, dma_handle);
+
+	return platform_dma_alloc_coherent(dev, size, dma_handle);
+}
+
+static inline void
+dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
+		    dma_addr_t dma_handle)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->free_coherent)
+		bus->dma_ops->free_coherent(dev, size, cpu_addr, dma_handle);
+	else
+		platform_dma_free_coherent(dev, size, cpu_addr, dma_handle);
+}
+
+static inline dma_addr_t
+dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+	       enum dma_data_direction direction)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->map_single)
+		return bus->dma_ops->map_single(dev, cpu_addr, size, direction);
+	return platform_dma_map_single(dev, cpu_addr, size, direction);
+}
+
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction direction)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->unmap_single)
+		bus->dma_ops->unmap_single(dev, dma_addr, size, direction);
+	else
+		platform_dma_unmap_single(dev, dma_addr, size, direction);
+}
+
+static inline int
+dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	   enum dma_data_direction direction)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->map_sg)
+		return bus->dma_ops->map_sg(dev, sg, nents, direction);
+
+	return platform_dma_map_sg(dev, sg, nents, direction);
+}
+
+static inline void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+	     enum dma_data_direction direction)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->unmap_sg)
+		bus->dma_ops->unmap_sg(dev, sg, nhwentries, direction);
+	else
+		platform_dma_unmap_sg(dev, sg, nhwentries, direction);
+}
+
+static inline void
+dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->sync_single)
+		bus->dma_ops->sync_single(dev, dma_handle, size, direction);
+	else
+		platform_dma_sync_single(dev, dma_handle, size, direction);
+}
+
+static inline void
+dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+	    enum dma_data_direction direction)
+{
+	struct bus_type *bus = dev->bus;
+
+	if(bus->dma_ops && bus->dma_ops->sync_sg)
+		bus->dma_ops->sync_sg(dev, sg, nelems, direction);
+	else
+		platform_dma_sync_sg(dev, sg, nelems, direction);
+}
 
 #endif
 

--==_Exmh_8035964960--


