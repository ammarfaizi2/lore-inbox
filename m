Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965732AbWKDW4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965732AbWKDW4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 17:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965734AbWKDW4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 17:56:46 -0500
Received: from verein.lst.de ([213.95.11.210]:39381 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965732AbWKDW4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 17:56:45 -0500
Date: Sat, 4 Nov 2006 23:56:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Miller <davem@davemloft.net>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
Message-ID: <20061104225629.GA31437@lst.de>
References: <20061030141501.GC7164@lst.de> <20061030.143357.130208425.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030.143357.130208425.davem@davemloft.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.6 () BAYES_01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 02:33:57PM -0800, David Miller wrote:
> It may be a bit much to be calling all the way through up to the PCI
> layer just to pluck out a simple integer, don't you think?  The PCI
> bus pointer comparison is just a symptom of how silly this is.
> 
> Especially since this will be used for every packet allocation a
> device makes.
> 
> So, please add some sanity to this situation and just put the node
> into the generic struct device. :-)

I was concerned about growing struct device, on smaller system it
already eats up a lot of memory.  But we can make the node member
conditional on CONFIG_NUMA, as I did in the patch below.

This directly replaces PATCH 2/2 (the one we're replying to), all
others remain unmodified.


Index: linux-2.6/include/linux/device.h
===================================================================
--- linux-2.6.orig/include/linux/device.h	2006-10-29 16:02:38.000000000 +0100
+++ linux-2.6/include/linux/device.h	2006-11-02 12:47:17.000000000 +0100
@@ -347,6 +347,9 @@
 					   BIOS data),reserved for device core*/
 	struct dev_pm_info	power;
 
+#ifdef CONFIG_NUMA
+	int		numa_node;	/* NUMA node this device is close to */
+#endif
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
 	u64		coherent_dma_mask;/* Like dma_mask, but for
 					     alloc_coherent mappings as
@@ -368,6 +371,12 @@
 	void	(*release)(struct device * dev);
 };
 
+#ifdef CONFIG_NUMA
+#define dev_to_node(dev)	((dev)->numa_node)
+#else
+#define dev_to_node(dev)	(-1)
+#endif
+
 static inline void *
 dev_get_drvdata (struct device *dev)
 {
Index: linux-2.6/drivers/base/core.c
===================================================================
--- linux-2.6.orig/drivers/base/core.c	2006-10-23 17:21:44.000000000 +0200
+++ linux-2.6/drivers/base/core.c	2006-11-02 12:48:12.000000000 +0100
@@ -381,6 +381,7 @@
 	INIT_LIST_HEAD(&dev->node);
 	init_MUTEX(&dev->sem);
 	device_init_wakeup(dev, 0);
+	dev->numa_node = -1;
 }
 
 /**
Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c	2006-10-23 17:21:46.000000000 +0200
+++ linux-2.6/drivers/pci/probe.c	2006-11-02 12:47:35.000000000 +0100
@@ -846,6 +846,7 @@
 	dev->dev.release = pci_release_dev;
 	pci_dev_get(dev);
 
+	dev->dev.numa_node = pcibus_to_node(bus);
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
 
