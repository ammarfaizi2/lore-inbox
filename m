Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWFVUUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWFVUUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWFVUUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:20:24 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32896 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030390AbWFVUUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:20:22 -0400
Date: Thu, 22 Jun 2006 13:19:20 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.16.22
Message-ID: <20060622201920.GA22737@sequoia.sous-sol.org>
References: <20060622201757.GZ22737@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622201757.GZ22737@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 7ae2744..4b2bb08 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .21
+EXTRAVERSION = .22
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/arch/sparc64/kernel/pci_iommu.c b/arch/sparc64/kernel/pci_iommu.c
index a11910b..f63f065 100644
--- a/arch/sparc64/kernel/pci_iommu.c
+++ b/arch/sparc64/kernel/pci_iommu.c
@@ -219,7 +219,7 @@ static inline void iommu_free_ctx(struct
  * DMA for PCI device PDEV.  Return non-NULL cpu-side address if
  * successful and set *DMA_ADDRP to the PCI side dma address.
  */
-void *pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp)
+void *__pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp, gfp_t gfp)
 {
 	struct pcidev_cookie *pcp;
 	struct pci_iommu *iommu;
@@ -233,7 +233,7 @@ void *pci_alloc_consistent(struct pci_de
 	if (order >= 10)
 		return NULL;
 
-	first_page = __get_free_pages(GFP_ATOMIC, order);
+	first_page = __get_free_pages(gfp, order);
 	if (first_page == 0UL)
 		return NULL;
 	memset((char *)first_page, 0, PAGE_SIZE << order);
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 3c06bfb..a6fe4f3 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -221,7 +221,7 @@ #ifdef CONFIG_PCI
 EXPORT_SYMBOL(ebus_chain);
 EXPORT_SYMBOL(isa_chain);
 EXPORT_SYMBOL(pci_memspace_mask);
-EXPORT_SYMBOL(pci_alloc_consistent);
+EXPORT_SYMBOL(__pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
 EXPORT_SYMBOL(pci_map_single);
 EXPORT_SYMBOL(pci_unmap_single);
diff --git a/arch/sparc64/lib/checksum.S b/arch/sparc64/lib/checksum.S
index ba9cd3c..1d230f6 100644
--- a/arch/sparc64/lib/checksum.S
+++ b/arch/sparc64/lib/checksum.S
@@ -165,8 +165,9 @@ csum_partial_end_cruft:
 	sll		%g1, 8, %g1
 	or		%o5, %g1, %o4
 
-1:	add		%o2, %o4, %o2
+1:	addcc		%o2, %o4, %o2
+	addc		%g0, %o2, %o2
 
 csum_partial_finish:
 	retl
-	 mov		%o2, %o0
+	 srl		%o2, 0, %o0
diff --git a/arch/sparc64/lib/csum_copy.S b/arch/sparc64/lib/csum_copy.S
index 71af488..e566c77 100644
--- a/arch/sparc64/lib/csum_copy.S
+++ b/arch/sparc64/lib/csum_copy.S
@@ -221,11 +221,12 @@ FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len
 	sll		%g1, 8, %g1
 	or		%o5, %g1, %o4
 
-1:	add		%o3, %o4, %o3
+1:	addcc		%o3, %o4, %o3
+	addc		%g0, %o3, %o3
 
 70:
 	retl
-	 mov		%o3, %o0
+	 srl		%o3, 0, %o0
 
 95:	mov		0, GLOBAL_SPARE
 	brlez,pn	%o2, 4f
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index abbdb37..f36db22 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -577,6 +577,8 @@ acpi_processor_register_performance(stru
 		return_VALUE(-EBUSY);
 	}
 
+	WARN_ON(!performance);
+
 	pr->performance = performance;
 
 	if (acpi_processor_get_performance_info(pr)) {
@@ -609,7 +611,8 @@ acpi_processor_unregister_performance(st
 		return_VOID;
 	}
 
-	kfree(pr->performance->states);
+	if (pr->performance)
+		kfree(pr->performance->states);
 	pr->performance = NULL;
 
 	acpi_cpufreq_remove_file(pr);
diff --git a/drivers/message/i2o/exec-osm.c b/drivers/message/i2o/exec-osm.c
index 9bb9859..04e0357 100644
--- a/drivers/message/i2o/exec-osm.c
+++ b/drivers/message/i2o/exec-osm.c
@@ -55,6 +55,7 @@ struct i2o_exec_wait {
 	u32 m;			/* message id */
 	struct i2o_message *msg;	/* pointer to the reply message */
 	struct list_head list;	/* node in global wait list */
+	spinlock_t lock;	/* lock before modifying */
 };
 
 /* Exec OSM class handling definition */
@@ -80,6 +81,7 @@ static struct i2o_exec_wait *i2o_exec_wa
 		return NULL;
 
 	INIT_LIST_HEAD(&wait->list);
+	spin_lock_init(&wait->lock);
 
 	return wait;
 };
@@ -118,6 +120,7 @@ int i2o_msg_post_wait_mem(struct i2o_con
 	DECLARE_WAIT_QUEUE_HEAD(wq);
 	struct i2o_exec_wait *wait;
 	static u32 tcntxt = 0x80000000;
+	long flags;
 	int rc = 0;
 
 	wait = i2o_exec_wait_alloc();
@@ -139,33 +142,28 @@ int i2o_msg_post_wait_mem(struct i2o_con
 	wait->tcntxt = tcntxt++;
 	msg->u.s.tcntxt = cpu_to_le32(wait->tcntxt);
 
+	wait->wq = &wq;
+	/*
+	 * we add elements to the head, because if a entry in the list will
+	 * never be removed, we have to iterate over it every time
+	 */
+	list_add(&wait->list, &i2o_exec_wait_list);
+
 	/*
 	 * Post the message to the controller. At some point later it will
 	 * return. If we time out before it returns then complete will be zero.
 	 */
 	i2o_msg_post(c, msg);
 
-	if (!wait->complete) {
-		wait->wq = &wq;
-		/*
-		 * we add elements add the head, because if a entry in the list
-		 * will never be removed, we have to iterate over it every time
-		 */
-		list_add(&wait->list, &i2o_exec_wait_list);
-
-		wait_event_interruptible_timeout(wq, wait->complete,
-						 timeout * HZ);
+	wait_event_interruptible_timeout(wq, wait->complete, timeout * HZ);
 
-		wait->wq = NULL;
-	}
+	spin_lock_irqsave(&wait->lock, flags);
 
-	barrier();
+	wait->wq = NULL;
 
-	if (wait->complete) {
+	if (wait->complete)
 		rc = le32_to_cpu(wait->msg->body[0]) >> 24;
-		i2o_flush_reply(c, wait->m);
-		i2o_exec_wait_free(wait);
-	} else {
+	else {
 		/*
 		 * We cannot remove it now. This is important. When it does
 		 * terminate (which it must do if the controller has not
@@ -179,6 +177,13 @@ int i2o_msg_post_wait_mem(struct i2o_con
 		rc = -ETIMEDOUT;
 	}
 
+	spin_unlock_irqrestore(&wait->lock, flags);
+
+	if (rc != -ETIMEDOUT) {
+		i2o_flush_reply(c, wait->m);
+		i2o_exec_wait_free(wait);
+	}
+
 	return rc;
 };
 
@@ -206,7 +211,6 @@ static int i2o_msg_post_wait_complete(st
 {
 	struct i2o_exec_wait *wait, *tmp;
 	unsigned long flags;
-	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
 	int rc = 1;
 
 	/*
@@ -216,23 +220,24 @@ static int i2o_msg_post_wait_complete(st
 	 * already expired. Not much we can do about that except log it for
 	 * debug purposes, increase timeout, and recompile.
 	 */
-	spin_lock_irqsave(&lock, flags);
 	list_for_each_entry_safe(wait, tmp, &i2o_exec_wait_list, list) {
 		if (wait->tcntxt == context) {
-			list_del(&wait->list);
+			spin_lock_irqsave(&wait->lock, flags);
 
-			spin_unlock_irqrestore(&lock, flags);
+			list_del(&wait->list);
 
 			wait->m = m;
 			wait->msg = msg;
 			wait->complete = 1;
 
-			barrier();
-
-			if (wait->wq) {
-				wake_up_interruptible(wait->wq);
+			if (wait->wq)
 				rc = 0;
-			} else {
+			else
+				rc = -1;
+
+			spin_unlock_irqrestore(&wait->lock, flags);
+
+			if (rc) {
 				struct device *dev;
 
 				dev = &c->pdev->dev;
@@ -241,15 +246,13 @@ static int i2o_msg_post_wait_complete(st
 					 c->name);
 				i2o_dma_free(dev, &wait->dma);
 				i2o_exec_wait_free(wait);
-				rc = -1;
-			}
+			} else
+				wake_up_interruptible(wait->wq);
 
 			return rc;
 		}
 	}
 
-	spin_unlock_irqrestore(&lock, flags);
-
 	osm_warn("%s: Bogus reply in POST WAIT (tr-context: %08x)!\n", c->name,
 		 context);
 
@@ -315,14 +318,9 @@ static DEVICE_ATTR(product_id, S_IRUGO, 
 static int i2o_exec_probe(struct device *dev)
 {
 	struct i2o_device *i2o_dev = to_i2o_device(dev);
-	struct i2o_controller *c = i2o_dev->iop;
 
 	i2o_event_register(i2o_dev, &i2o_exec_driver, 0, 0xffffffff);
 
-	c->exec = i2o_dev;
-
-	i2o_exec_lct_notify(c, c->lct->change_ind + 1);
-
 	device_create_file(dev, &dev_attr_vendor_id);
 	device_create_file(dev, &dev_attr_product_id);
 
@@ -510,6 +508,8 @@ static int i2o_exec_lct_notify(struct i2
 	struct device *dev;
 	struct i2o_message *msg;
 
+	down(&c->lct_lock);
+
 	dev = &c->pdev->dev;
 
 	if (i2o_dma_realloc
@@ -532,6 +532,8 @@ static int i2o_exec_lct_notify(struct i2
 
 	i2o_msg_post(c, msg);
 
+	up(&c->lct_lock);
+
 	return 0;
 };
 
diff --git a/drivers/message/i2o/iop.c b/drivers/message/i2o/iop.c
index 4921674..febbdd4 100644
--- a/drivers/message/i2o/iop.c
+++ b/drivers/message/i2o/iop.c
@@ -804,8 +804,6 @@ void i2o_iop_remove(struct i2o_controlle
 
 	/* Ask the IOP to switch to RESET state */
 	i2o_iop_reset(c);
-
-	put_device(&c->device);
 }
 
 /**
@@ -1059,7 +1057,7 @@ struct i2o_controller *i2o_iop_alloc(voi
 
 	snprintf(poolname, sizeof(poolname), "i2o_%s_msg_inpool", c->name);
 	if (i2o_pool_alloc
-	    (&c->in_msg, poolname, I2O_INBOUND_MSG_FRAME_SIZE * 4,
+	    (&c->in_msg, poolname, I2O_INBOUND_MSG_FRAME_SIZE * 4 + sizeof(u32),
 	     I2O_MSG_INPOOL_MIN)) {
 		kfree(c);
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index f63c387..6c8452e 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -48,7 +48,7 @@ config PARPORT_PC
 
 config PARPORT_SERIAL
 	tristate "Multi-IO cards (parallel and serial)"
-	depends on SERIAL_8250 && PARPORT_PC && PCI
+	depends on SERIAL_8250_PCI && PARPORT_PC && PCI
 	help
 	  This adds support for multi-IO PCI cards that have parallel and
 	  serial ports.  You should say Y or M here.  If you say M, the module
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 701a328..a0cd6de 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -368,7 +368,7 @@ static int scsi_req_map_sg(struct reques
 			   int nsegs, unsigned bufflen, gfp_t gfp)
 {
 	struct request_queue *q = rq->q;
-	int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned int data_len = 0, len, bytes, off;
 	struct page *page;
 	struct bio *bio = NULL;
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index 557411c..f494b67 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -388,7 +388,7 @@ static int whiteheat_attach (struct usb_
 	if (ret) {
 		err("%s: Couldn't send command [%d]", serial->type->description, ret);
 		goto no_firmware;
-	} else if (alen != sizeof(command)) {
+	} else if (alen != 2) {
 		err("%s: Send command incomplete [%d]", serial->type->description, alen);
 		goto no_firmware;
 	}
@@ -400,7 +400,7 @@ static int whiteheat_attach (struct usb_
 	if (ret) {
 		err("%s: Couldn't get results [%d]", serial->type->description, ret);
 		goto no_firmware;
-	} else if (alen != sizeof(result)) {
+	} else if (alen != sizeof(*hw_info) + 1) {
 		err("%s: Get results incomplete [%d]", serial->type->description, alen);
 		goto no_firmware;
 	} else if (result[0] != command[0]) {
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 8a53981..c82d076 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -543,7 +543,7 @@ add_failed:
 static int metapage_releasepage(struct page *page, gfp_t gfp_mask)
 {
 	struct metapage *mp;
-	int busy = 0;
+	int ret = 1;
 	unsigned int offset;
 
 	for (offset = 0; offset < PAGE_CACHE_SIZE; offset += PSIZE) {
@@ -553,30 +553,20 @@ static int metapage_releasepage(struct p
 			continue;
 
 		jfs_info("metapage_releasepage: mp = 0x%p", mp);
-		if (mp->count || mp->nohomeok) {
+		if (mp->count || mp->nohomeok ||
+		    test_bit(META_dirty, &mp->flag)) {
 			jfs_info("count = %ld, nohomeok = %d", mp->count,
 				 mp->nohomeok);
-			busy = 1;
+			ret = 0;
 			continue;
 		}
-		wait_on_page_writeback(page);
-		//WARN_ON(test_bit(META_dirty, &mp->flag));
-		if (test_bit(META_dirty, &mp->flag)) {
-			dump_mem("dirty mp in metapage_releasepage", mp,
-				 sizeof(struct metapage));
-			dump_mem("page", page, sizeof(struct page));
-			dump_stack();
-		}
 		if (mp->lsn)
 			remove_from_logsync(mp);
 		remove_metapage(page, mp);
 		INCREMENT(mpStat.pagefree);
 		free_metapage(mp);
 	}
-	if (busy)
-		return -1;
-
-	return 0;
+	return ret;
 }
 
 static int metapage_invalidatepage(struct page *page, unsigned long offset)
diff --git a/fs/namei.c b/fs/namei.c
index 8dc2b03..f11c0aa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1077,8 +1077,8 @@ static int fastcall do_path_lookup(int d
 	nd->flags = flags;
 	nd->depth = 0;
 
-	read_lock(&current->fs->lock);
 	if (*name=='/') {
+		read_lock(&current->fs->lock);
 		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
 			nd->mnt = mntget(current->fs->altrootmnt);
 			nd->dentry = dget(current->fs->altroot);
@@ -1089,33 +1089,35 @@ static int fastcall do_path_lookup(int d
 		}
 		nd->mnt = mntget(current->fs->rootmnt);
 		nd->dentry = dget(current->fs->root);
+		read_unlock(&current->fs->lock);
 	} else if (dfd == AT_FDCWD) {
+		read_lock(&current->fs->lock);
 		nd->mnt = mntget(current->fs->pwdmnt);
 		nd->dentry = dget(current->fs->pwd);
+		read_unlock(&current->fs->lock);
 	} else {
 		struct dentry *dentry;
 
 		file = fget_light(dfd, &fput_needed);
 		retval = -EBADF;
 		if (!file)
-			goto unlock_fail;
+			goto out_fail;
 
 		dentry = file->f_dentry;
 
 		retval = -ENOTDIR;
 		if (!S_ISDIR(dentry->d_inode->i_mode))
-			goto fput_unlock_fail;
+			goto fput_fail;
 
 		retval = file_permission(file, MAY_EXEC);
 		if (retval)
-			goto fput_unlock_fail;
+			goto fput_fail;
 
 		nd->mnt = mntget(file->f_vfsmnt);
 		nd->dentry = dget(dentry);
 
 		fput_light(file, fput_needed);
 	}
-	read_unlock(&current->fs->lock);
 	current->total_link_count = 0;
 	retval = link_path_walk(name, nd);
 out:
@@ -1124,13 +1126,12 @@ out:
 				nd->dentry->d_inode))
 		audit_inode(name, nd->dentry->d_inode, flags);
 	}
+out_fail:
 	return retval;
 
-fput_unlock_fail:
+fput_fail:
 	fput_light(file, fput_needed);
-unlock_fail:
-	read_unlock(&current->fs->lock);
-	return retval;
+	goto out_fail;
 }
 
 int fastcall path_lookup(const char *name, unsigned int flags,
@@ -1628,6 +1629,12 @@ do_last:
 		goto exit;
 	}
 
+	if (IS_ERR(nd->intent.open.file)) {
+		mutex_unlock(&dir->d_inode->i_mutex);
+		error = PTR_ERR(nd->intent.open.file);
+		goto exit_dput;
+	}
+
 	/* Negative dentry, just create the file */
 	if (!path.dentry->d_inode) {
 		if (!IS_POSIXACL(dir->d_inode))
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 5027d3d..89449d3 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1489,14 +1489,15 @@ static inline void ntfs_flush_dcache_pag
 		unsigned nr_pages)
 {
 	BUG_ON(!nr_pages);
+	/*
+	 * Warning: Do not do the decrement at the same time as the call to
+	 * flush_dcache_page() because it is a NULL macro on i386 and hence the
+	 * decrement never happens so the loop never terminates.
+	 */
 	do {
-		/*
-		 * Warning: Do not do the decrement at the same time as the
-		 * call because flush_dcache_page() is a NULL macro on i386
-		 * and hence the decrement never happens.
-		 */
+		--nr_pages;
 		flush_dcache_page(pages[nr_pages]);
-	} while (--nr_pages > 0);
+	} while (nr_pages > 0);
 }
 
 /**
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 358e4d3..c2059a3 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -159,17 +159,8 @@ #ifndef __HAVE_ARCH_LAZY_MMU_PROT_UPDATE
 #define lazy_mmu_prot_update(pte)	do { } while (0)
 #endif
 
-#ifndef __HAVE_ARCH_MULTIPLE_ZERO_PAGE
+#ifndef __HAVE_ARCH_MOVE_PTE
 #define move_pte(pte, prot, old_addr, new_addr)	(pte)
-#else
-#define move_pte(pte, prot, old_addr, new_addr)				\
-({									\
- 	pte_t newpte = (pte);						\
-	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
-			pte_page(pte) == ZERO_PAGE(old_addr))		\
-		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
-	newpte;								\
-})
 #endif
 
 /*
diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 702a28f..69cebbd 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -70,7 +70,15 @@ extern unsigned long zero_page_mask;
 #define ZERO_PAGE(vaddr) \
 	(virt_to_page(empty_zero_page + (((unsigned long)(vaddr)) & zero_page_mask)))
 
-#define __HAVE_ARCH_MULTIPLE_ZERO_PAGE
+#define __HAVE_ARCH_MOVE_PTE
+#define move_pte(pte, prot, old_addr, new_addr)				\
+({									\
+ 	pte_t newpte = (pte);						\
+	if (pte_present(pte) && pfn_valid(pte_pfn(pte)) &&		\
+			pte_page(pte) == ZERO_PAGE(old_addr))		\
+		newpte = mk_pte(ZERO_PAGE(new_addr), (prot));		\
+	newpte;								\
+})
 
 extern void paging_init(void);
 
diff --git a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
index c7d5804..a587fd7 100644
--- a/include/asm-sparc64/dma-mapping.h
+++ b/include/asm-sparc64/dma-mapping.h
@@ -4,7 +4,146 @@ #define _ASM_SPARC64_DMA_MAPPING_H
 #include <linux/config.h>
 
 #ifdef CONFIG_PCI
-#include <asm-generic/dma-mapping.h>
+
+/* we implement the API below in terms of the existing PCI one,
+ * so include it */
+#include <linux/pci.h>
+/* need struct page definitions */
+#include <linux/mm.h>
+
+static inline int
+dma_supported(struct device *dev, u64 mask)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_dma_supported(to_pci_dev(dev), mask);
+}
+
+static inline int
+dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
+}
+
+static inline void *
+dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		   gfp_t flag)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return __pci_alloc_consistent(to_pci_dev(dev), size, dma_handle, flag);
+}
+
+static inline void
+dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
+		    dma_addr_t dma_handle)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_free_consistent(to_pci_dev(dev), size, cpu_addr, dma_handle);
+}
+
+static inline dma_addr_t
+dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_map_single(to_pci_dev(dev), cpu_addr, size, (int)direction);
+}
+
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_unmap_single(to_pci_dev(dev), dma_addr, size, (int)direction);
+}
+
+static inline dma_addr_t
+dma_map_page(struct device *dev, struct page *page,
+	     unsigned long offset, size_t size,
+	     enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_map_page(to_pci_dev(dev), page, offset, size, (int)direction);
+}
+
+static inline void
+dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_unmap_page(to_pci_dev(dev), dma_address, size, (int)direction);
+}
+
+static inline int
+dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	   enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_map_sg(to_pci_dev(dev), sg, nents, (int)direction);
+}
+
+static inline void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+	     enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_unmap_sg(to_pci_dev(dev), sg, nhwentries, (int)direction);
+}
+
+static inline void
+dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
+			enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_single_for_cpu(to_pci_dev(dev), dma_handle,
+				    size, (int)direction);
+}
+
+static inline void
+dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
+			   enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_single_for_device(to_pci_dev(dev), dma_handle,
+				       size, (int)direction);
+}
+
+static inline void
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
+		    enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_sg_for_cpu(to_pci_dev(dev), sg, nelems, (int)direction);
+}
+
+static inline void
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
+		       enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_sg_for_device(to_pci_dev(dev), sg, nelems, (int)direction);
+}
+
+static inline int
+dma_mapping_error(dma_addr_t dma_addr)
+{
+	return pci_dma_mapping_error(dma_addr);
+}
+
 #else
 
 struct device;
diff --git a/include/asm-sparc64/pci.h b/include/asm-sparc64/pci.h
index 89bd71b..5b12c2a 100644
--- a/include/asm-sparc64/pci.h
+++ b/include/asm-sparc64/pci.h
@@ -44,7 +44,9 @@ struct pci_dev;
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
  * hwdev should be valid struct pci_dev pointer for PCI devices.
  */
-extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size, dma_addr_t *dma_handle);
+extern void *__pci_alloc_consistent(struct pci_dev *hwdev, size_t size, dma_addr_t *dma_handle, gfp_t gfp);
+#define pci_alloc_consistent(DEV,SZ,HANDLE) \
+	__pci_alloc_consistent(DEV,SZ,HANDLE,GFP_ATOMIC)
 
 /* Free and unmap a consistent DMA buffer.
  * cpu_addr is what was returned from pci_alloc_consistent,
diff --git a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
index f0a9b44..3d6dff2 100644
--- a/include/asm-sparc64/pgtable.h
+++ b/include/asm-sparc64/pgtable.h
@@ -335,6 +335,23 @@ static inline void set_pte_at(struct mm_
 #define pte_clear(mm,addr,ptep)		\
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
+#ifdef DCACHE_ALIASING_POSSIBLE
+#define __HAVE_ARCH_MOVE_PTE
+#define move_pte(pte, prot, old_addr, new_addr)				\
+({									\
+ 	pte_t newpte = (pte);						\
+	if (pte_present(pte)) {						\
+		unsigned long this_pfn = pte_pfn(pte);			\
+									\
+		if (pfn_valid(this_pfn) &&				\
+		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
+			flush_dcache_page_all(current->mm,		\
+					      pfn_to_page(this_pfn));	\
+	}								\
+	newpte;								\
+})
+#endif
+
 extern pgd_t swapper_pg_dir[2048];
 extern pmd_t swapper_low_pmd_dir[2048];
 
diff --git a/include/linux/i2o.h b/include/linux/i2o.h
index 5a9d8c5..6368e31 100644
--- a/include/linux/i2o.h
+++ b/include/linux/i2o.h
@@ -1116,8 +1116,11 @@ static inline struct i2o_message *i2o_ms
 
 	mmsg->mfa = readl(c->in_port);
 	if (unlikely(mmsg->mfa >= c->in_queue.len)) {
+		u32 mfa = mmsg->mfa;
+
 		mempool_free(mmsg, c->in_msg.mempool);
-		if(mmsg->mfa == I2O_QUEUE_EMPTY)
+
+		if (mfa == I2O_QUEUE_EMPTY)
 			return ERR_PTR(-EBUSY);
 		return ERR_PTR(-EFAULT);
 	}
diff --git a/mm/shmem.c b/mm/shmem.c
index f0eb2f2..1bc2285 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2100,6 +2100,7 @@ #endif
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
+	sb->s_time_gran = 1;
 
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)
