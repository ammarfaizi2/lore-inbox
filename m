Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVDQUTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVDQUTq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDQUTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:19:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18707 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261477AbVDQUOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:14:25 -0400
Date: Sun, 17 Apr 2005 22:14:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: scjody@steamballoon.com
Cc: linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/ieee1394/pcilynx.c: remove dead options
Message-ID: <20050417201424.GN3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The options CONFIG_IEEE1394_PCILYNX_LOCALRAM and 
CONFIG_IEEE1394_PCILYNX_PORTS are not available for some time.

Is this patch for removing them and the code behind them correct, or is 
a future usage planned?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ieee1394/Kconfig   |    5 
 drivers/ieee1394/pcilynx.c |  391 -------------------------------------
 drivers/ieee1394/pcilynx.h |   49 ----
 3 files changed, 2 insertions(+), 443 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/ieee1394/Kconfig.old	2005-04-17 21:01:11.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/ieee1394/Kconfig	2005-04-17 21:01:23.000000000 +0200
@@ -84,11 +84,6 @@
 	  To compile this driver as a module, say M here: the
 	  module will be called pcilynx.
 
-# Non-maintained pcilynx options
-# if [ "$CONFIG_IEEE1394_PCILYNX" != "n" ]; then
-#     bool '    Use PCILynx local RAM' CONFIG_IEEE1394_PCILYNX_LOCALRAM
-#     bool '    Support for non-IEEE1394 local ports' CONFIG_IEEE1394_PCILYNX_PORTS
-# fi
 config IEEE1394_OHCI1394
 	tristate "OHCI-1394 support"
 	depends on PCI && IEEE1394
--- linux-2.6.12-rc2-mm3-full/drivers/ieee1394/pcilynx.h.old	2005-04-17 21:01:31.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/ieee1394/pcilynx.h	2005-04-17 21:02:21.000000000 +0200
@@ -55,16 +55,6 @@
         void __iomem *aux_port;
 	quadlet_t bus_info_block[5];
 
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-        atomic_t aux_intr_seen;
-        wait_queue_head_t aux_intr_wait;
-
-        void *mem_dma_buffer;
-        dma_addr_t mem_dma_buffer_dma;
-        struct semaphore mem_dma_mutex;
-        wait_queue_head_t mem_dma_intr_wait;
-#endif
-
         /*
          * use local RAM of LOCALRAM_SIZE bytes for PCLs, which allows for
          * LOCALRAM_SIZE * 8 PCLs (each sized 128 bytes);
@@ -72,11 +62,9 @@
          */
         u8 pcl_bmap[LOCALRAM_SIZE / 1024];
 
-#ifndef CONFIG_IEEE1394_PCILYNX_LOCALRAM
 	/* point to PCLs memory area if needed */
 	void *pcl_mem;
         dma_addr_t pcl_mem_dma;
-#endif
 
         /* PCLs for local mem / aux transfers */
         pcl_t dmem_pcl;
@@ -378,39 +366,6 @@
 #define pcloffs(MEMBER) (offsetof(struct ti_pcl, MEMBER))
 
 
-#ifdef CONFIG_IEEE1394_PCILYNX_LOCALRAM
-
-static inline void put_pcl(const struct ti_lynx *lynx, pcl_t pclid,
-                           const struct ti_pcl *pcl)
-{
-        int i;
-        u32 *in = (u32 *)pcl;
-        u32 *out = (u32 *)(lynx->local_ram + pclid * sizeof(struct ti_pcl));
-
-        for (i = 0; i < 32; i++, out++, in++) {
-                writel(*in, out);
-        }
-}
-
-static inline void get_pcl(const struct ti_lynx *lynx, pcl_t pclid,
-                           struct ti_pcl *pcl)
-{
-        int i;
-        u32 *out = (u32 *)pcl;
-        u32 *in = (u32 *)(lynx->local_ram + pclid * sizeof(struct ti_pcl));
-
-        for (i = 0; i < 32; i++, out++, in++) {
-                *out = readl(in);
-        }
-}
-
-static inline u32 pcl_bus(const struct ti_lynx *lynx, pcl_t pclid)
-{
-        return pci_resource_start(lynx->dev, 1) + pclid * sizeof(struct ti_pcl);
-}
-
-#else /* CONFIG_IEEE1394_PCILYNX_LOCALRAM */
-
 static inline void put_pcl(const struct ti_lynx *lynx, pcl_t pclid,
                            const struct ti_pcl *pcl)
 {
@@ -431,10 +386,8 @@
         return lynx->pcl_mem_dma + pclid * sizeof(struct ti_pcl);
 }
 
-#endif /* CONFIG_IEEE1394_PCILYNX_LOCALRAM */
-
 
-#if defined (CONFIG_IEEE1394_PCILYNX_LOCALRAM) || defined (__BIG_ENDIAN)
+#if defined (__BIG_ENDIAN)
 typedef struct ti_pcl pcltmp_t;
 
 static inline struct ti_pcl *edit_pcl(const struct ti_lynx *lynx, pcl_t pclid,
--- linux-2.6.12-rc2-mm3-full/drivers/ieee1394/pcilynx.c.old	2005-04-17 21:02:29.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/ieee1394/pcilynx.c	2005-04-17 21:05:02.000000000 +0200
@@ -834,327 +834,6 @@
  * IEEE-1394 functionality section END *
  ***************************************/
 
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-/* VFS functions for local bus / aux device access.  Access to those
- * is implemented as a character device instead of block devices
- * because buffers are not wanted for this.  Therefore llseek (from
- * VFS) can be used for these char devices with obvious effects.
- */
-static int mem_open(struct inode*, struct file*);
-static int mem_release(struct inode*, struct file*);
-static unsigned int aux_poll(struct file*, struct poll_table_struct*);
-static loff_t mem_llseek(struct file*, loff_t, int);
-static ssize_t mem_read (struct file*, char*, size_t, loff_t*);
-static ssize_t mem_write(struct file*, const char*, size_t, loff_t*);
-
-
-static struct file_operations aux_ops = {
-	.owner =	THIS_MODULE,
-        .read =         mem_read,
-        .write =        mem_write,
-        .poll =         aux_poll,
-        .llseek =       mem_llseek,
-        .open =         mem_open,
-        .release =      mem_release,
-};
-
-
-static void aux_setup_pcls(struct ti_lynx *lynx)
-{
-        struct ti_pcl pcl;
-
-        pcl.next = PCL_NEXT_INVALID;
-        pcl.user_data = pcl_bus(lynx, lynx->dmem_pcl);
-        put_pcl(lynx, lynx->dmem_pcl, &pcl);
-}
-
-static int mem_open(struct inode *inode, struct file *file)
-{
-        int cid = iminor(inode);
-        enum { t_rom, t_aux, t_ram } type;
-        struct memdata *md;
-
-        if (cid < PCILYNX_MINOR_AUX_START) {
-                /* just for completeness */
-                return -ENXIO;
-        } else if (cid < PCILYNX_MINOR_ROM_START) {
-                cid -= PCILYNX_MINOR_AUX_START;
-                if (cid >= num_of_cards || !cards[cid].aux_port)
-                        return -ENXIO;
-                type = t_aux;
-        } else if (cid < PCILYNX_MINOR_RAM_START) {
-                cid -= PCILYNX_MINOR_ROM_START;
-                if (cid >= num_of_cards || !cards[cid].local_rom)
-                        return -ENXIO;
-                type = t_rom;
-        } else {
-                /* WARNING: Know what you are doing when opening RAM.
-                 * It is currently used inside the driver! */
-                cid -= PCILYNX_MINOR_RAM_START;
-                if (cid >= num_of_cards || !cards[cid].local_ram)
-                        return -ENXIO;
-                type = t_ram;
-        }
-
-        md = (struct memdata *)kmalloc(sizeof(struct memdata), SLAB_KERNEL);
-        if (md == NULL)
-                return -ENOMEM;
-
-        md->lynx = &cards[cid];
-        md->cid = cid;
-
-        switch (type) {
-        case t_rom:
-                md->type = rom;
-                break;
-        case t_ram:
-                md->type = ram;
-                break;
-        case t_aux:
-                atomic_set(&md->aux_intr_last_seen,
-                           atomic_read(&cards[cid].aux_intr_seen));
-                md->type = aux;
-                break;
-        }
-
-        file->private_data = md;
-
-        return 0;
-}
-
-static int mem_release(struct inode *inode, struct file *file)
-{
-        kfree(file->private_data);
-        return 0;
-}
-
-static unsigned int aux_poll(struct file *file, poll_table *pt)
-{
-        struct memdata *md = (struct memdata *)file->private_data;
-        int cid = md->cid;
-        unsigned int mask;
-
-        /* reading and writing is always allowed */
-        mask = POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM;
-
-        if (md->type == aux) {
-                poll_wait(file, &cards[cid].aux_intr_wait, pt);
-
-                if (atomic_read(&md->aux_intr_last_seen)
-                    != atomic_read(&cards[cid].aux_intr_seen)) {
-                        mask |= POLLPRI;
-                        atomic_inc(&md->aux_intr_last_seen);
-                }
-        }
-
-        return mask;
-}
-
-loff_t mem_llseek(struct file *file, loff_t offs, int orig)
-{
-        loff_t newoffs;
-
-        switch (orig) {
-        case 0:
-                newoffs = offs;
-                break;
-        case 1:
-                newoffs = offs + file->f_pos;
-                break;
-        case 2:
-                newoffs = PCILYNX_MAX_MEMORY + 1 + offs;
-                break;
-        default:
-                return -EINVAL;
-        }
-
-        if (newoffs < 0 || newoffs > PCILYNX_MAX_MEMORY + 1) return -EINVAL;
-
-        file->f_pos = newoffs;
-        return newoffs;
-}
-
-/*
- * do not DMA if count is too small because this will have a serious impact
- * on performance - the value 2400 was found by experiment and may not work
- * everywhere as good as here - use mem_mindma option for modules to change
- */
-static short mem_mindma = 2400;
-module_param(mem_mindma, short, 0444);
-MODULE_PARM_DESC(mem_mindma, "Minimum amount of data required to use DMA");
-
-static ssize_t mem_dmaread(struct memdata *md, u32 physbuf, ssize_t count,
-                           int offset)
-{
-        pcltmp_t pcltmp;
-        struct ti_pcl *pcl;
-        size_t retval;
-        int i;
-        DECLARE_WAITQUEUE(wait, current);
-
-        count &= ~3;
-        count = min(count, 53196);
-        retval = count;
-
-        if (reg_read(md->lynx, DMA_CHAN_CTRL(CHANNEL_LOCALBUS))
-            & DMA_CHAN_CTRL_BUSY) {
-                PRINT(KERN_WARNING, md->lynx->id, "DMA ALREADY ACTIVE!");
-        }
-
-        reg_write(md->lynx, LBUS_ADDR, md->type | offset);
-
-        pcl = edit_pcl(md->lynx, md->lynx->dmem_pcl, &pcltmp);
-        pcl->buffer[0].control = PCL_CMD_LBUS_TO_PCI | min(count, 4092);
-        pcl->buffer[0].pointer = physbuf;
-        count -= 4092;
-
-        i = 0;
-        while (count > 0) {
-                i++;
-                pcl->buffer[i].control = min(count, 4092);
-                pcl->buffer[i].pointer = physbuf + i * 4092;
-                count -= 4092;
-        }
-        pcl->buffer[i].control |= PCL_LAST_BUFF;
-        commit_pcl(md->lynx, md->lynx->dmem_pcl, &pcltmp);
-
-        set_current_state(TASK_INTERRUPTIBLE);
-        add_wait_queue(&md->lynx->mem_dma_intr_wait, &wait);
-        run_sub_pcl(md->lynx, md->lynx->dmem_pcl, 2, CHANNEL_LOCALBUS);
-
-        schedule();
-        while (reg_read(md->lynx, DMA_CHAN_CTRL(CHANNEL_LOCALBUS))
-               & DMA_CHAN_CTRL_BUSY) {
-                if (signal_pending(current)) {
-                        retval = -EINTR;
-                        break;
-                }
-                schedule();
-        }
-
-        reg_write(md->lynx, DMA_CHAN_CTRL(CHANNEL_LOCALBUS), 0);
-        remove_wait_queue(&md->lynx->mem_dma_intr_wait, &wait);
-
-        if (reg_read(md->lynx, DMA_CHAN_CTRL(CHANNEL_LOCALBUS))
-            & DMA_CHAN_CTRL_BUSY) {
-                PRINT(KERN_ERR, md->lynx->id, "DMA STILL ACTIVE!");
-        }
-
-        return retval;
-}
-
-static ssize_t mem_read(struct file *file, char *buffer, size_t count,
-                        loff_t *offset)
-{
-        struct memdata *md = (struct memdata *)file->private_data;
-        ssize_t bcount;
-        size_t alignfix;
-	loff_t off = *offset; /* avoid useless 64bit-arithmetic */
-        ssize_t retval;
-        void *membase;
-
-        if ((off + count) > PCILYNX_MAX_MEMORY+1) {
-                count = PCILYNX_MAX_MEMORY+1 - off;
-        }
-        if (count == 0 || off > PCILYNX_MAX_MEMORY) {
-                return -ENOSPC;
-        }
-
-        switch (md->type) {
-        case rom:
-                membase = md->lynx->local_rom;
-                break;
-        case ram:
-                membase = md->lynx->local_ram;
-                break;
-        case aux:
-                membase = md->lynx->aux_port;
-                break;
-        default:
-                panic("pcilynx%d: unsupported md->type %d in %s",
-                      md->lynx->id, md->type, __FUNCTION__);
-        }
-
-        down(&md->lynx->mem_dma_mutex);
-
-        if (count < mem_mindma) {
-                memcpy_fromio(md->lynx->mem_dma_buffer, membase+off, count);
-                goto out;
-        }
-
-        bcount = count;
-        alignfix = 4 - (off % 4);
-        if (alignfix != 4) {
-                if (bcount < alignfix) {
-                        alignfix = bcount;
-                }
-                memcpy_fromio(md->lynx->mem_dma_buffer, membase+off,
-                              alignfix);
-                if (bcount == alignfix) {
-                        goto out;
-                }
-                bcount -= alignfix;
-                off += alignfix;
-        }
-
-        while (bcount >= 4) {
-                retval = mem_dmaread(md, md->lynx->mem_dma_buffer_dma
-                                     + count - bcount, bcount, off);
-                if (retval < 0) return retval;
-
-                bcount -= retval;
-                off += retval;
-        }
-
-        if (bcount) {
-                memcpy_fromio(md->lynx->mem_dma_buffer + count - bcount,
-                              membase+off, bcount);
-        }
-
- out:
-        retval = copy_to_user(buffer, md->lynx->mem_dma_buffer, count);
-        up(&md->lynx->mem_dma_mutex);
-
-	if (retval) return -EFAULT;
-        *offset += count;
-        return count;
-}
-
-
-static ssize_t mem_write(struct file *file, const char *buffer, size_t count,
-                         loff_t *offset)
-{
-        struct memdata *md = (struct memdata *)file->private_data;
-
-        if (((*offset) + count) > PCILYNX_MAX_MEMORY+1) {
-                count = PCILYNX_MAX_MEMORY+1 - *offset;
-        }
-        if (count == 0 || *offset > PCILYNX_MAX_MEMORY) {
-                return -ENOSPC;
-        }
-
-        /* FIXME: dereferencing pointers to PCI mem doesn't work everywhere */
-        switch (md->type) {
-        case aux:
-		if (copy_from_user(md->lynx->aux_port+(*offset), buffer, count))
-			return -EFAULT;
-                break;
-        case ram:
-		if (copy_from_user(md->lynx->local_ram+(*offset), buffer, count))
-			return -EFAULT;
-                break;
-        case rom:
-                /* the ROM may be writeable */
-		if (copy_from_user(md->lynx->local_rom+(*offset), buffer, count))
-			return -EFAULT;
-                break;
-        }
-
-        file->f_pos += count;
-        return count;
-}
-#endif /* CONFIG_IEEE1394_PCILYNX_PORTS */
-
 
 /********************************************************
  * Global stuff (interrupt handler, init/shutdown code) *
@@ -1181,18 +860,6 @@
         reg_write(lynx, LINK_INT_STATUS, linkint);
         reg_write(lynx, PCI_INT_STATUS, intmask);
 
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-        if (intmask & PCI_INT_AUX_INT) {
-                atomic_inc(&lynx->aux_intr_seen);
-                wake_up_interruptible(&lynx->aux_intr_wait);
-        }
-
-        if (intmask & PCI_INT_DMA_HLT(CHANNEL_LOCALBUS)) {
-                wake_up_interruptible(&lynx->mem_dma_intr_wait);
-        }
-#endif
-
-
         if (intmask & PCI_INT_1394) {
                 if (linkint & LINK_INT_PHY_TIMEOUT) {
                         PRINT(KERN_INFO, lynx->id, "PHY timeout occurred");
@@ -1484,15 +1151,9 @@
                 pci_free_consistent(lynx->dev, PAGE_SIZE, lynx->rcv_page,
                                     lynx->rcv_page_dma);
         case have_aux_buf:
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-                pci_free_consistent(lynx->dev, 65536, lynx->mem_dma_buffer,
-                                    lynx->mem_dma_buffer_dma);
-#endif
         case have_pcl_mem:
-#ifndef CONFIG_IEEE1394_PCILYNX_LOCALRAM
                 pci_free_consistent(lynx->dev, LOCALRAM_SIZE, lynx->pcl_mem,
                                     lynx->pcl_mem_dma);
-#endif
         case clear:
                 /* do nothing - already freed */
                 ;
@@ -1546,7 +1207,6 @@
         spin_lock_init(&lynx->lock);
         spin_lock_init(&lynx->phy_reg_lock);
 
-#ifndef CONFIG_IEEE1394_PCILYNX_LOCALRAM
         lynx->pcl_mem = pci_alloc_consistent(dev, LOCALRAM_SIZE,
                                              &lynx->pcl_mem_dma);
 
@@ -1558,16 +1218,6 @@
         } else {
                 FAIL("failed to allocate PCL memory area");
         }
-#endif
-
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-        lynx->mem_dma_buffer = pci_alloc_consistent(dev, 65536,
-                                                    &lynx->mem_dma_buffer_dma);
-        if (lynx->mem_dma_buffer == NULL) {
-                FAIL("failed to allocate DMA buffer for aux");
-        }
-        lynx->state = have_aux_buf;
-#endif
 
         lynx->rcv_page = pci_alloc_consistent(dev, PAGE_SIZE,
                                               &lynx->rcv_page_dma);
@@ -1597,13 +1247,6 @@
                 FAIL("failed to remap registers - card not accessible");
         }
 
-#ifdef CONFIG_IEEE1394_PCILYNX_LOCALRAM
-        if (lynx->local_ram == NULL) {
-                FAIL("failed to remap local RAM which is required for "
-                     "operation");
-        }
-#endif
-
         reg_set_bits(lynx, MISC_CONTROL, MISC_CONTROL_SWRESET);
         /* Fix buggy cards with autoboot pin not tied low: */
         reg_write(lynx, DMA0_CHAN_CTRL, 0);
@@ -1624,13 +1267,6 @@
 
         /* alloc_pcl return values are not checked, it is expected that the
          * provided PCL space is sufficient for the initial allocations */
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-        if (lynx->aux_port != NULL) {
-                lynx->dmem_pcl = alloc_pcl(lynx);
-                aux_setup_pcls(lynx);
-                sema_init(&lynx->mem_dma_mutex, 1);
-        }
-#endif
         lynx->rcv_pcl = alloc_pcl(lynx);
         lynx->rcv_pcl_start = alloc_pcl(lynx);
         lynx->async.pcl = alloc_pcl(lynx);
@@ -1647,12 +1283,6 @@
 
         reg_write(lynx, PCI_INT_ENABLE, PCI_INT_DMA_ALL);
 
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-        reg_set_bits(lynx, PCI_INT_ENABLE, PCI_INT_AUX_INT);
-        init_waitqueue_head(&lynx->mem_dma_intr_wait);
-        init_waitqueue_head(&lynx->aux_intr_wait);
-#endif
-
 	tasklet_init(&lynx->iso_rcv.tq, (void (*)(unsigned long))iso_rcv_bh,
 		     (unsigned long)lynx);
 
@@ -1944,37 +1574,18 @@
 {
         int ret;
 
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-        if (register_chrdev(PCILYNX_MAJOR, PCILYNX_DRIVER_NAME, &aux_ops)) {
-                PRINT_G(KERN_ERR, "allocation of char major number %d failed",
-                        PCILYNX_MAJOR);
-                return -EBUSY;
-        }
-#endif
-
         ret = pci_register_driver(&lynx_pci_driver);
         if (ret < 0) {
                 PRINT_G(KERN_ERR, "PCI module init failed");
-                goto free_char_dev;
+                return ret;
         }
 
         return 0;
-
- free_char_dev:
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-        unregister_chrdev(PCILYNX_MAJOR, PCILYNX_DRIVER_NAME);
-#endif
-
-        return ret;
 }
 
 static void __exit pcilynx_cleanup(void)
 {
         pci_unregister_driver(&lynx_pci_driver);
-
-#ifdef CONFIG_IEEE1394_PCILYNX_PORTS
-        unregister_chrdev(PCILYNX_MAJOR, PCILYNX_DRIVER_NAME);
-#endif
 }
 
 

