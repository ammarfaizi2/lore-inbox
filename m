Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbWJPWF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWJPWF3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWJPWF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:05:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:59021 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161135AbWJPWF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:05:28 -0400
Date: Mon, 16 Oct 2006 15:04:26 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.14
Message-ID: <20061016220426.GA9194@kroah.com>
References: <20061016215701.GA12407@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016215701.GA12407@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff --git a/Makefile b/Makefile
index 078ac10..79072d8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .13
+EXTRAVERSION = .14
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index e55b5c6..2031eda 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -1105,7 +1105,7 @@ static struct time_interpolator sparc64_
 };
 
 /* The quotient formula is taken from the IA64 port. */
-#define SPARC64_NSEC_PER_CYC_SHIFT	30UL
+#define SPARC64_NSEC_PER_CYC_SHIFT	10UL
 void __init time_init(void)
 {
 	unsigned long clock = sparc64_init_timers();
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 1539a83..562e10a 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -902,8 +902,7 @@ #ifdef CONFIG_BLK_DEV_INITRD
 	if (sparc_ramdisk_image || sparc_ramdisk_image64) {
 		unsigned long ramdisk_image = sparc_ramdisk_image ?
 			sparc_ramdisk_image : sparc_ramdisk_image64;
-		if (ramdisk_image >= (unsigned long)_end - 2 * PAGE_SIZE)
-			ramdisk_image -= KERNBASE;
+		ramdisk_image -= KERNBASE;
 		initrd_start = ramdisk_image + phys_base;
 		initrd_end = initrd_start + sparc_ramdisk_size;
 		if (initrd_end > end_of_phys_memory) {
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index b72dde7..10467da 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -597,6 +597,10 @@ u8 eighty_ninty_three (ide_drive_t *driv
 {
 	if(HWIF(drive)->udma_four == 0)
 		return 0;
+
+    /* Check for SATA but only if we are ATA5 or higher */
+    if (drive->id->hw_config == 0 && (drive->id->major_rev_num & 0x7FE0))
+        return 1;
 	if (!(drive->id->hw_config & 0x6000))
 		return 0;
 #ifndef CONFIG_IDEDMA_IVB
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index 2f0d288..54b696c 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -238,8 +238,7 @@ static struct ps2pp_info *get_model_info
 		{ 100,	PS2PP_KIND_MX,					/* MX510 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },
-		{ 111,  PS2PP_KIND_MX,					/* MX300 */
-				PS2PP_WHEEL | PS2PP_EXTRA_BTN | PS2PP_TASK_BTN },
+		{ 111,  PS2PP_KIND_MX,	PS2PP_WHEEL | PS2PP_SIDE_BTN },	/* MX300 reports task button as side */
 		{ 112,	PS2PP_KIND_MX,					/* MX500 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },
diff --git a/drivers/media/dvb/dvb-core/dvb_net.c b/drivers/media/dvb/dvb-core/dvb_net.c
index 2f0f358..e8e21b9 100644
--- a/drivers/media/dvb/dvb-core/dvb_net.c
+++ b/drivers/media/dvb/dvb-core/dvb_net.c
@@ -492,7 +492,8 @@ #endif
 				} else
 					priv->ule_dbit = 0;
 
-				if (priv->ule_sndu_len > 32763) {
+				if (priv->ule_sndu_len > 32763 ||
+				    priv->ule_sndu_len < ((priv->ule_dbit) ? 4 : 4 + ETH_ALEN)) {
 					printk(KERN_WARNING "%lu: Invalid ULE SNDU length %u. "
 					       "Resyncing.\n", priv->ts_count, priv->ule_sndu_len);
 					priv->ule_sndu_len = 0;
diff --git a/drivers/media/dvb/frontends/cx24123.c b/drivers/media/dvb/frontends/cx24123.c
index 691dc84..afb08ff 100644
--- a/drivers/media/dvb/frontends/cx24123.c
+++ b/drivers/media/dvb/frontends/cx24123.c
@@ -579,8 +579,8 @@ static int cx24123_pll_calculate(struct 
 	ndiv = ( ((p->frequency * vco_div * 10) / (2 * XTAL / 1000)) / 32) & 0x1ff;
 	adiv = ( ((p->frequency * vco_div * 10) / (2 * XTAL / 1000)) % 32) & 0x1f;
 
-	if (adiv == 0)
-		ndiv++;
+	if (adiv == 0 && ndiv > 0)
+		ndiv--;
 
 	/* control bits 11, refdiv 11, charge pump polarity 1, charge pump current, ndiv, adiv */
 	state->pllarg = (3 << 19) | (3 << 17) | (1 << 16) | (pump << 14) | (ndiv << 5) | adiv;
diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index b806999..dd23219 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -942,6 +942,8 @@ static int msp_attach(struct i2c_adapter
 	state->has_virtual_dolby_surround = msp_revision == 'G' && msp_prod_lo == 1;
 	/* Has Virtual Dolby Surround & Dolby Pro Logic: only in msp34x2 */
 	state->has_dolby_pro_logic = msp_revision == 'G' && msp_prod_lo == 2;
+	/* The msp343xG supports BTSC only and cannot do Automatic Standard Detection. */
+	state->force_btsc = msp_family == 3 && msp_revision == 'G' && msp_prod_hi == 3;
 
 	state->opmode = opmode;
 	if (state->opmode == OPMODE_AUTO) {
diff --git a/drivers/media/video/msp3400-driver.h b/drivers/media/video/msp3400-driver.h
index 4e45104..6359d74 100644
--- a/drivers/media/video/msp3400-driver.h
+++ b/drivers/media/video/msp3400-driver.h
@@ -64,6 +64,7 @@ struct msp_state {
 	u8 has_sound_processing;
 	u8 has_virtual_dolby_surround;
 	u8 has_dolby_pro_logic;
+	u8 force_btsc;
 
 	int radio;
 	int opmode;
diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
index 633a102..a0ac592 100644
--- a/drivers/media/video/msp3400-kthreads.c
+++ b/drivers/media/video/msp3400-kthreads.c
@@ -949,11 +949,12 @@ int msp34xxg_thread(void *data)
 
 		/* setup the chip*/
 		msp34xxg_reset(client);
-		state->std = state->radio ? 0x40 : msp_standard;
-		if (state->std != 1)
-			goto unmute;
+		state->std = state->radio ? 0x40 :
+			(state->force_btsc && msp_standard == 1) ? 32 : msp_standard;
 		/* start autodetect */
 		msp_write_dem(client, 0x20, state->std);
+		if (state->std != 1)
+			goto unmute;
 
 		/* watch autodetect */
 		v4l_dbg(1, msp_debug, client, "started autodetect, waiting for result\n");
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index 587458b..96049e2 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -325,52 +325,11 @@ static struct mmc_blk_data *mmc_blk_allo
 	md->read_only = mmc_blk_readonly(card);
 
 	/*
-	 * Figure out a workable block size.  MMC cards have:
-	 *  - two block sizes, one for read and one for write.
-	 *  - may support partial reads and/or writes
-	 *    (allows block sizes smaller than specified)
+	 * Both SD and MMC specifications state (although a bit
+	 * unclearly in the MMC case) that a block size of 512
+	 * bytes must always be supported by the card.
 	 */
-	md->block_bits = card->csd.read_blkbits;
-	if (card->csd.write_blkbits != card->csd.read_blkbits) {
-		if (card->csd.write_blkbits < card->csd.read_blkbits &&
-		    card->csd.read_partial) {
-			/*
-			 * write block size is smaller than read block
-			 * size, but we support partial reads, so choose
-			 * the smaller write block size.
-			 */
-			md->block_bits = card->csd.write_blkbits;
-		} else if (card->csd.write_blkbits > card->csd.read_blkbits &&
-			   card->csd.write_partial) {
-			/*
-			 * read block size is smaller than write block
-			 * size, but we support partial writes.  Use read
-			 * block size.
-			 */
-		} else {
-			/*
-			 * We don't support this configuration for writes.
-			 */
-			printk(KERN_ERR "%s: unable to select block size for "
-				"writing (rb%u wb%u rp%u wp%u)\n",
-				mmc_card_id(card),
-				1 << card->csd.read_blkbits,
-				1 << card->csd.write_blkbits,
-				card->csd.read_partial,
-				card->csd.write_partial);
-			md->read_only = 1;
-		}
-	}
-
-	/*
-	 * Refuse to allow block sizes smaller than 512 bytes.
-	 */
-	if (md->block_bits < 9) {
-		printk(KERN_ERR "%s: unable to support block size %u\n",
-			mmc_card_id(card), 1 << md->block_bits);
-		ret = -EINVAL;
-		goto err_kfree;
-	}
+	md->block_bits = 9;
 
 	md->disk = alloc_disk(1 << MMC_SHIFT);
 	if (md->disk == NULL) {
diff --git a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
index 71f4505..aeda7ad 100644
--- a/drivers/net/pcmcia/xirc2ps_cs.c
+++ b/drivers/net/pcmcia/xirc2ps_cs.c
@@ -345,6 +345,7 @@ typedef struct local_info_t {
     void __iomem *dingo_ccr; /* only used for CEM56 cards */
     unsigned last_ptr_value; /* last packets transmitted value */
     const char *manf_str;
+    struct work_struct tx_timeout_task;
 } local_info_t;
 
 /****************
@@ -352,6 +353,7 @@ typedef struct local_info_t {
  */
 static int do_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void do_tx_timeout(struct net_device *dev);
+static void xirc2ps_tx_timeout_task(void *data);
 static struct net_device_stats *do_get_stats(struct net_device *dev);
 static void set_addresses(struct net_device *dev);
 static void set_multicast_list(struct net_device *dev);
@@ -589,6 +591,7 @@ xirc2ps_probe(struct pcmcia_device *link
 #ifdef HAVE_TX_TIMEOUT
     dev->tx_timeout = do_tx_timeout;
     dev->watchdog_timeo = TX_TIMEOUT;
+    INIT_WORK(&local->tx_timeout_task, xirc2ps_tx_timeout_task, dev);
 #endif
 
     return xirc2ps_config(link);
@@ -1341,17 +1344,24 @@ xirc2ps_interrupt(int irq, void *dev_id,
 /*====================================================================*/
 
 static void
-do_tx_timeout(struct net_device *dev)
+xirc2ps_tx_timeout_task(void *data)
 {
-    local_info_t *lp = netdev_priv(dev);
-    printk(KERN_NOTICE "%s: transmit timed out\n", dev->name);
-    lp->stats.tx_errors++;
+    struct net_device *dev = data;
     /* reset the card */
     do_reset(dev,1);
     dev->trans_start = jiffies;
     netif_wake_queue(dev);
 }
 
+static void
+do_tx_timeout(struct net_device *dev)
+{
+    local_info_t *lp = netdev_priv(dev);
+    lp->stats.tx_errors++;
+    printk(KERN_NOTICE "%s: transmit timed out\n", dev->name);
+    schedule_work(&lp->tx_timeout_task);
+}
+
 static int
 do_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6e3786f..c19ffa6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -390,6 +390,7 @@ static void __devinit quirk_piix4_acpi(s
 	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443MX_3,	quirk_piix4_acpi );
 
 /*
  * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index b4f8fb1..2dcfc1b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -548,6 +548,12 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
+	if (!sata_dev_present(ap)) {
+		DPRINTK("PHY reports no device\n");
+		*class = ATA_DEV_NONE;
+		return 0;
+	}
+
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_stop_engine(ap);
 	if (rc) {
diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
index 21b8bf4..f9be16e 100644
--- a/fs/ext3/inode.c
+++ b/fs/ext3/inode.c
@@ -926,7 +926,7 @@ int ext3_get_blocks_handle(handle_t *han
 	set_buffer_new(bh_result);
 got_it:
 	map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
-	if (blocks_to_boundary == 0)
+	if (count > blocks_to_boundary)
 		set_buffer_boundary(bh_result);
 	err = count;
 	/* Clean up and exit */
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index a570e5c..ef9c953 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -238,19 +238,22 @@ static int
 nlm_traverse_files(struct nlm_host *host, int action)
 {
 	struct nlm_file	*file, **fp;
-	int		i;
+	int i, ret = 0;
 
 	mutex_lock(&nlm_file_mutex);
 	for (i = 0; i < FILE_NRHASH; i++) {
 		fp = nlm_files + i;
 		while ((file = *fp) != NULL) {
+			file->f_count++;
+			mutex_unlock(&nlm_file_mutex);
+
 			/* Traverse locks, blocks and shares of this file
 			 * and update file->f_locks count */
-			if (nlm_inspect_file(host, file, action)) {
-				mutex_unlock(&nlm_file_mutex);
-				return 1;
-			}
+			if (nlm_inspect_file(host, file, action))
+				ret = 1;
 
+			mutex_lock(&nlm_file_mutex);
+			file->f_count--;
 			/* No more references to this file. Let go of it. */
 			if (!file->f_blocks && !file->f_locks
 			 && !file->f_shares && !file->f_count) {
@@ -263,7 +266,7 @@ nlm_traverse_files(struct nlm_host *host
 		}
 	}
 	mutex_unlock(&nlm_file_mutex);
-	return 0;
+	return ret;
 }
 
 /*
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index fade02c..801cc0f 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -325,7 +325,13 @@ static void nfs_invalidate_page(struct p
 
 static int nfs_release_page(struct page *page, gfp_t gfp)
 {
-	return !nfs_wb_page(page->mapping->host, page);
+	if (gfp & __GFP_FS)
+		return !nfs_wb_page(page->mapping->host, page);
+	else
+		/*
+		 * Avoid deadlock on nfs_wait_on_request().
+		 */
+		return 0;
 }
 
 struct address_space_operations nfs_file_aops = {
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d86c0db..e790ba5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -185,15 +185,15 @@ static void renew_lease(const struct nfs
 	spin_unlock(&clp->cl_lock);
 }
 
-static void update_changeattr(struct inode *inode, struct nfs4_change_info *cinfo)
+static void update_changeattr(struct inode *dir, struct nfs4_change_info *cinfo)
 {
-	struct nfs_inode *nfsi = NFS_I(inode);
+	struct nfs_inode *nfsi = NFS_I(dir);
 
-	spin_lock(&inode->i_lock);
-	nfsi->cache_validity |= NFS_INO_INVALID_ATTR;
+	spin_lock(&dir->i_lock);
+	nfsi->cache_validity |= NFS_INO_INVALID_ATTR|NFS_INO_REVAL_PAGECACHE|NFS_INO_INVALID_DATA;
 	if (cinfo->before == nfsi->change_attr && cinfo->atomic)
 		nfsi->change_attr = cinfo->after;
-	spin_unlock(&inode->i_lock);
+	spin_unlock(&dir->i_lock);
 }
 
 struct nfs4_opendata {
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index cf37866..5bb3e17 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -483,11 +483,6 @@ int sysfs_update_file(struct kobject * k
 		    (victim->d_parent->d_inode == dir->d_inode)) {
 			victim->d_inode->i_mtime = CURRENT_TIME;
 			fsnotify_modify(victim);
-
-			/**
-			 * Drop reference from initial sysfs_get_dentry().
-			 */
-			dput(victim);
 			res = 0;
 		} else
 			d_drop(victim);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index c71227d..1d81e7d 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -234,8 +234,12 @@ static inline int nfs_caches_unstable(st
 
 static inline void nfs_mark_for_revalidate(struct inode *inode)
 {
+	struct nfs_inode *nfsi = NFS_I(inode);
+
 	spin_lock(&inode->i_lock);
-	NFS_I(inode)->cache_validity |= NFS_INO_INVALID_ATTR | NFS_INO_INVALID_ACCESS;
+	nfsi->cache_validity |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ACCESS;
+	if (S_ISDIR(inode->i_mode))
+		nfsi->cache_validity |= NFS_INO_REVAL_PAGECACHE|NFS_INO_INVALID_DATA;
 	spin_unlock(&inode->i_lock);
 }
 
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index e8bbe81..e615957 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -37,7 +37,7 @@ extern unsigned int xprt_max_resvport;
 
 #define RPC_MIN_RESVPORT	(1U)
 #define RPC_MAX_RESVPORT	(65535U)
-#define RPC_DEF_MIN_RESVPORT	(650U)
+#define RPC_DEF_MIN_RESVPORT	(665U)
 #define RPC_DEF_MAX_RESVPORT	(1023U)
 
 /*
diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
index dfb300b..0f42544 100644
--- a/net/sched/cls_basic.c
+++ b/net/sched/cls_basic.c
@@ -197,7 +197,7 @@ static int basic_change(struct tcf_proto
 	if (handle)
 		f->handle = handle;
 	else {
-		int i = 0x80000000;
+		unsigned int i = 0x80000000;
 		do {
 			if (++head->hgenerator == 0x7FFFFFFF)
 				head->hgenerator = 1;
