Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSH3WKn>; Fri, 30 Aug 2002 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317701AbSH3WJq>; Fri, 30 Aug 2002 18:09:46 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:34323 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317606AbSH3WJR>;
	Fri, 30 Aug 2002 18:09:17 -0400
Date: Fri, 30 Aug 2002 15:12:40 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830221239.GK10783@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830220846.GB10783@kroah.com> <20020830220912.GC10783@kroah.com> <20020830220931.GD10783@kroah.com> <20020830221017.GE10783@kroah.com> <20020830221044.GF10783@kroah.com> <20020830221107.GG10783@kroah.com> <20020830221127.GH10783@kroah.com> <20020830221157.GI10783@kroah.com> <20020830221220.GJ10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830221220.GJ10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.551   -> 1.552  
#	 drivers/pci/probe.c	1.8     -> 1.9    
#	 include/linux/pci.h	1.37    -> 1.38   
#	  drivers/pci/pool.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	david-b@pacbell.net	1.552
# [PATCH] show pci_pool stats in driverfs]
# 
# This patch exposes basic allocation statistics for pci pools,
# very much like /proc/slabinfo but applying to DMA-consistent
# memory.  A file "pools" is created in the driverfs directory
# for the relevant pci device when the first pool is created, and
# removed when the last pool is destroyed.
# 
# Please merge to 2.5.latest.  If it matters, DaveM said it
# looks fine.  It produces sane output for all the 2.5.30
# USB host controller drivers.
# --------------------------------------------
#
diff -Nru a/drivers/pci/pool.c b/drivers/pci/pool.c
--- a/drivers/pci/pool.c	Fri Aug 30 15:00:12 2002
+++ b/drivers/pci/pool.c	Fri Aug 30 15:00:12 2002
@@ -17,18 +17,70 @@
 	size_t			allocation;
 	char			name [32];
 	wait_queue_head_t	waitq;
+	struct list_head	pools;
 };
 
 struct pci_page {	/* cacheable header for 'allocation' bytes */
 	struct list_head	page_list;
 	void			*vaddr;
 	dma_addr_t		dma;
+	unsigned		in_use;
 	unsigned long		bitmap [0];
 };
 
 #define	POOL_TIMEOUT_JIFFIES	((100 /* msec */ * HZ) / 1000)
 #define	POOL_POISON_BYTE	0xa7
 
+static spinlock_t pools_lock = SPIN_LOCK_UNLOCKED;
+
+static ssize_t
+show_pools (struct device *dev, char *buf, size_t count, loff_t off)
+{
+	struct pci_dev		*pdev;
+	unsigned long		flags;
+	unsigned		temp, size;
+	char			*next;
+	struct list_head	*i, *j;
+
+	if (off != 0)
+		return 0;
+
+	pdev = container_of (dev, struct pci_dev, dev);
+	next = buf;
+	size = count;
+
+	temp = snprintf (next, size, "poolinfo - 0.1\n");
+	size -= temp;
+	next += temp;
+
+	spin_lock_irqsave (&pools_lock, flags);
+	list_for_each (i, &pdev->pools) {
+		struct pci_pool	*pool;
+		unsigned	pages = 0, blocks = 0;
+
+		pool = list_entry (i, struct pci_pool, pools);
+
+		list_for_each (j, &pool->page_list) {
+			struct pci_page	*page;
+
+			page = list_entry (j, struct pci_page, page_list);
+			pages++;
+			blocks += page->in_use;
+		}
+
+		/* per-pool info, no real statistics yet */
+		temp = snprintf (next, size, "%-16s %4u %4u %4u %2u\n",
+				pool->name,
+				blocks, pages * pool->blocks_per_page,
+				pool->size, pages);
+		size -= temp;
+		next += temp;
+	}
+	spin_unlock_irqrestore (&pools_lock, flags);
+
+	return count - size;
+}
+static DEVICE_ATTR (pools, "pools", S_IRUGO, show_pools, NULL);
 
 /**
  * pci_pool_create - Creates a pool of pci consistent memory blocks, for dma.
@@ -56,6 +108,7 @@
 	size_t size, size_t align, size_t allocation, int mem_flags)
 {
 	struct pci_pool		*retval;
+	unsigned long		flags;
 
 	if (align == 0)
 		align = 1;
@@ -84,6 +137,17 @@
 	retval->name [sizeof retval->name - 1] = 0;
 
 	retval->dev = pdev;
+
+	if (pdev) {
+		spin_lock_irqsave (&pools_lock, flags);
+		/* note:  not currently insisting "name" be unique */
+		if (list_empty (&pdev->pools))
+			device_create_file (&pdev->dev, &dev_attr_pools);
+		list_add (&retval->pools, &pdev->pools);
+		spin_unlock_irqrestore (&pools_lock, flags);
+	} else
+		INIT_LIST_HEAD (&retval->pools);
+
 	INIT_LIST_HEAD (&retval->page_list);
 	spin_lock_init (&retval->lock);
 	retval->size = size;
@@ -117,6 +181,7 @@
 		memset (page->vaddr, POOL_POISON_BYTE, pool->allocation);
 #endif
 		list_add (&page->page_list, &pool->page_list);
+		page->in_use = 0;
 	} else {
 		kfree (page);
 		page = 0;
@@ -177,6 +242,13 @@
 		} else
 			pool_free_page (pool, page);
 	}
+
+	spin_lock (&pools_lock);
+	list_del (&pool->pools);
+	if (pool->dev && list_empty (&pool->dev->pools))
+		device_remove_file (&pool->dev->dev, &dev_attr_pools);
+	spin_unlock (&pools_lock);
+
 	spin_unlock_irqrestore (&pool->lock, flags);
 	kfree (pool);
 }
@@ -243,6 +315,7 @@
 	clear_bit (0, &page->bitmap [0]);
 	offset = 0;
 ready:
+	page->in_use++;
 	retval = offset + page->vaddr;
 	*handle = offset + page->dma;
 done:
@@ -318,6 +391,7 @@
 #endif
 
 	spin_lock_irqsave (&pool->lock, flags);
+	page->in_use--;
 	set_bit (block, &page->bitmap [map]);
 	if (waitqueue_active (&pool->waitq))
 		wake_up (&pool->waitq);
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Fri Aug 30 15:00:12 2002
+++ b/drivers/pci/probe.c	Fri Aug 30 15:00:12 2002
@@ -364,6 +364,7 @@
 
 	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	sprintf(dev->name, "PCI device %04x:%04x", dev->vendor, dev->device);
+	INIT_LIST_HEAD(&dev->pools);
 	
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
 	class >>= 8;				    /* upper 3 bytes */
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Fri Aug 30 15:00:12 2002
+++ b/include/linux/pci.h	Fri Aug 30 15:00:12 2002
@@ -359,6 +359,7 @@
 					   0xffffffff.  You only need to change
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
+	struct list_head pools;		/* pci_pools tied to this device */
 
 	u32             current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
