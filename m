Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWCZRbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWCZRbi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWCZRbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:31:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8711 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751312AbWCZRbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:31:36 -0500
Date: Sun, 26 Mar 2006 19:31:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20060326173134.GQ4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following:


Adrian Bunk:
      Kconfig help: MTD_JEDECPROBE already supports Intel

Artem B. Bityuckiy:
      Remove ugly debugging stuff

Bastien Roucaries:
      drivers/char/ftape/lowlevel/fdc-io.c: Correct a comment

Eric Sesterhenn:
      BUG_ON() Conversion in drivers/mtd/
      BUG_ON() Conversion in drivers/char
      BUG_ON() Conversion in drivers/isdn
      BUG_ON() Conversion in md/dm-path-selector.c
      BUG_ON() Conversion in md/dm-table.c
      BUG_ON() Conversion in input/serio/hp_sdc_mlc.c
      BUG_ON() Conversion in fs/buffer.c
      BUG_ON() Conversion in fs/dcache.c
      BUG_ON() Conversion in fs/hfs/
      BUG_ON() Conversion in fs/ext2/
      BUG_ON() Conversion in ipc/sem.c
      BUG_ON() Conversion in kernel/fork.c
      BUG_ON() Conversion in mm/memory.c
      BUG_ON() Conversion in mm/mempool.c
      BUG_ON() Conversion in drivers/s390/block/dasd_devmap.c

Florin Malita:
      do_mounts.c: Minor ROOT_DEV comment cleanup


 drivers/char/epca.c                  |    3 +--
 drivers/char/ftape/lowlevel/fdc-io.c |    2 +-
 drivers/char/tty_io.c                |   11 ++++-------
 drivers/input/serio/hp_sdc_mlc.c     |    7 ++++---
 drivers/isdn/hisax/hisax_fcpcipnp.c  |    7 ++-----
 drivers/isdn/hisax/hisax_isac.c      |    9 +++------
 drivers/isdn/hisax/st5481_b.c        |    4 +---
 drivers/isdn/hisax/st5481_d.c        |    4 +---
 drivers/isdn/i4l/isdn_ppp.c          |    6 ++----
 drivers/md/dm-path-selector.c        |    3 +--
 drivers/md/dm-table.c                |    6 ++----
 drivers/mtd/chips/Kconfig            |    5 ++---
 drivers/mtd/maps/dilnetpc.c          |    8 ++++----
 drivers/mtd/mtd_blkdevs.c            |    3 +--
 drivers/mtd/mtdconcat.c              |    6 ++----
 drivers/s390/block/dasd_devmap.c     |    6 ++----
 fs/buffer.c                          |    9 +++------
 fs/dcache.c                          |   11 +----------
 fs/ext2/dir.c                        |    6 ++----
 fs/hfs/bnode.c                       |    9 +++------
 fs/hfs/btree.c                       |    3 +--
 init/do_mounts.c                     |    1 -
 ipc/sem.c                            |    6 ++----
 kernel/fork.c                        |    3 +--
 mm/memory.c                          |    6 ++----
 mm/mempool.c                         |    4 ++--
 26 files changed, 50 insertions(+), 98 deletions(-)


diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index 765c5c1..9cad850 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -486,8 +486,7 @@ static void pc_close(struct tty_struct *
 		} /* End channel is open more than once */
 
 		/* Port open only once go ahead with shutdown & reset */
-		if (ch->count < 0)
-			BUG();
+		BUG_ON(ch->count < 0);
 
 		/* ---------------------------------------------------------------
 			Let the rest of the driver know the channel is being closed.
diff --git a/drivers/char/ftape/lowlevel/fdc-io.c b/drivers/char/ftape/lowlevel/fdc-io.c
index b2e0928..093fdf9 100644
--- a/drivers/char/ftape/lowlevel/fdc-io.c
+++ b/drivers/char/ftape/lowlevel/fdc-io.c
@@ -607,7 +607,7 @@ void fdc_reset(void)
 
 	fdc_mode = fdc_idle;
 
-	/*  maybe the cli()/sti() pair is not necessary, BUT:
+	/*  maybe the spin_lock_irq* pair is not necessary, BUT:
 	 *  the following line MUST be here. Otherwise fdc_interrupt_wait()
 	 *  won't wait. Note that fdc_reset() is called from 
 	 *  ftape_dumb_stop() when the fdc is busy transferring data. In this
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 48d795b..811dadb 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -543,14 +543,12 @@ void tty_ldisc_put(int disc)
 	struct tty_ldisc *ld;
 	unsigned long flags;
 	
-	if (disc < N_TTY || disc >= NR_LDISCS)
-		BUG();
+	BUG_ON(disc < N_TTY || disc >= NR_LDISCS);
 		
 	spin_lock_irqsave(&tty_ldisc_lock, flags);
 	ld = &tty_ldiscs[disc];
-	if(ld->refcount == 0)
-		BUG();
-	ld->refcount --;
+	BUG_ON(ld->refcount == 0);
+	ld->refcount--;
 	module_put(ld->owner);
 	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 }
@@ -645,8 +643,7 @@ void tty_ldisc_deref(struct tty_ldisc *l
 {
 	unsigned long flags;
 
-	if(ld == NULL)
-		BUG();
+	BUG_ON(ld == NULL);
 		
 	spin_lock_irqsave(&tty_ldisc_lock, flags);
 	if(ld->refcount == 0)
diff --git a/drivers/input/serio/hp_sdc_mlc.c b/drivers/input/serio/hp_sdc_mlc.c
index 1c9426f..aa4a8a4 100644
--- a/drivers/input/serio/hp_sdc_mlc.c
+++ b/drivers/input/serio/hp_sdc_mlc.c
@@ -270,9 +270,10 @@ static void hp_sdc_mlc_out (hil_mlc *mlc
 
  do_control:
 	priv->emtestmode = mlc->opacket & HIL_CTRL_TEST;
-	if ((mlc->opacket & (HIL_CTRL_APE | HIL_CTRL_IPF)) == HIL_CTRL_APE) {
-		BUG(); /* we cannot emulate this, it should not be used. */
-	}
+	
+	/* we cannot emulate this, it should not be used. */
+	BUG_ON((mlc->opacket & (HIL_CTRL_APE | HIL_CTRL_IPF)) == HIL_CTRL_APE);
+	
 	if ((mlc->opacket & HIL_CTRL_ONLY) == HIL_CTRL_ONLY) goto control_only;
 	if (mlc->opacket & HIL_CTRL_APE) { 
 		BUG(); /* Should not send command/data after engaging APE */
diff --git a/drivers/isdn/hisax/hisax_fcpcipnp.c b/drivers/isdn/hisax/hisax_fcpcipnp.c
index dc7ef95..dbcca28 100644
--- a/drivers/isdn/hisax/hisax_fcpcipnp.c
+++ b/drivers/isdn/hisax/hisax_fcpcipnp.c
@@ -387,8 +387,7 @@ static void hdlc_fill_fifo(struct fritz_
 
 	DBG(0x40, "hdlc_fill_fifo");
 
-	if (skb->len == 0)
-		BUG();
+	BUG_ON(skb->len == 0);
 
 	bcs->ctrl.sr.cmd &= ~HDLC_CMD_XME;
 	if (bcs->tx_skb->len > bcs->fifo_size) {
@@ -630,9 +629,7 @@ static void fritz_b_l2l1(struct hisax_if
 
 	switch (pr) {
 	case PH_DATA | REQUEST:
-		if (bcs->tx_skb)
-			BUG();
-		
+		BUG_ON(bcs->tx_skb);
 		bcs->tx_skb = skb;
 		DBG_SKB(1, skb);
 		hdlc_fill_fifo(bcs);
diff --git a/drivers/isdn/hisax/hisax_isac.c b/drivers/isdn/hisax/hisax_isac.c
index f4972f6..81eac34 100644
--- a/drivers/isdn/hisax/hisax_isac.c
+++ b/drivers/isdn/hisax/hisax_isac.c
@@ -476,12 +476,10 @@ static void isac_fill_fifo(struct isac *
 	unsigned char cmd;
 	u_char *ptr;
 
-	if (!isac->tx_skb)
-		BUG();
+	BUG_ON(!isac->tx_skb);
 
 	count = isac->tx_skb->len;
-	if (count <= 0)
-		BUG();
+	BUG_ON(count <= 0);
 
 	DBG(DBG_IRQ, "count %d", count);
 
@@ -859,8 +857,7 @@ void isac_d_l2l1(struct hisax_if *hisax_
 			dev_kfree_skb(skb);
 			break;
 		}
-		if (isac->tx_skb)
-			BUG();
+		BUG_ON(isac->tx_skb);
 
 		isac->tx_skb = skb;
 		isac_fill_fifo(isac);
diff --git a/drivers/isdn/hisax/st5481_b.c b/drivers/isdn/hisax/st5481_b.c
index 657817a..22fd5db 100644
--- a/drivers/isdn/hisax/st5481_b.c
+++ b/drivers/isdn/hisax/st5481_b.c
@@ -356,9 +356,7 @@ void st5481_b_l2l1(struct hisax_if *ifc,
 
 	switch (pr) {
 	case PH_DATA | REQUEST:
-		if (bcs->b_out.tx_skb)
-			BUG();
-		
+		BUG_ON(bcs->b_out.tx_skb);
 		bcs->b_out.tx_skb = skb;
 		break;
 	case PH_ACTIVATE | REQUEST:
diff --git a/drivers/isdn/hisax/st5481_d.c b/drivers/isdn/hisax/st5481_d.c
index 941f702..493dc94 100644
--- a/drivers/isdn/hisax/st5481_d.c
+++ b/drivers/isdn/hisax/st5481_d.c
@@ -596,9 +596,7 @@ void st5481_d_l2l1(struct hisax_if *hisa
 		break;
 	case PH_DATA | REQUEST:
 		DBG(2, "PH_DATA REQUEST len %d", skb->len);
-		if (adapter->d_out.tx_skb)
-			BUG();
-
+		BUG_ON(adapter->d_out.tx_skb);
 		adapter->d_out.tx_skb = skb;
 		FsmEvent(&adapter->d_out.fsm, EV_DOUT_START_XMIT, NULL);
 		break;
diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
index b9fed8a..a0927d1 100644
--- a/drivers/isdn/i4l/isdn_ppp.c
+++ b/drivers/isdn/i4l/isdn_ppp.c
@@ -974,8 +974,7 @@ void isdn_ppp_receive(isdn_net_dev * net
 	int slot;
 	int proto;
 
-	if (net_dev->local->master)
-		BUG(); // we're called with the master device always
+	BUG_ON(net_dev->local->master); // we're called with the master device always
 
 	slot = lp->ppp_slot;
 	if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
@@ -2527,8 +2526,7 @@ static struct sk_buff *isdn_ppp_decompre
 		printk(KERN_DEBUG "ippp: no decompressor defined!\n");
 		return skb;
 	}
-	if (!stat) // if we have a compressor, stat has been set as well
-		BUG();
+	BUG_ON(!stat); // if we have a compressor, stat has been set as well
 
 	if((master && *proto == PPP_COMP) || (!master && *proto == PPP_COMPFRAG) ) {
 		// compressed packets are compressed by their protocol type
diff --git a/drivers/md/dm-path-selector.c b/drivers/md/dm-path-selector.c
index a28c1c2..f10a0c8 100644
--- a/drivers/md/dm-path-selector.c
+++ b/drivers/md/dm-path-selector.c
@@ -86,8 +86,7 @@ void dm_put_path_selector(struct path_se
 	if (--psi->use == 0)
 		module_put(psi->pst.module);
 
-	if (psi->use < 0)
-		BUG();
+	BUG_ON(psi->use < 0);
 
 out:
 	up_read(&_ps_lock);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 9b1e2f5..907b08d 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -352,8 +352,7 @@ static int open_dev(struct dm_dev *d, de
 
 	int r;
 
-	if (d->bdev)
-		BUG();
+	BUG_ON(d->bdev);
 
 	bdev = open_by_devnum(dev, d->mode);
 	if (IS_ERR(bdev))
@@ -427,8 +426,7 @@ static int __table_get_device(struct dm_
 	struct dm_dev *dd;
 	unsigned int major, minor;
 
-	if (!t)
-		BUG();
+	BUG_ON(!t);
 
 	if (sscanf(path, "%u:%u", &major, &minor) == 2) {
 		/* Extract the major/minor numbers */
diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index 205bb70..0f6bb2e 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -25,9 +25,8 @@ config MTD_JEDECPROBE
 	  compatible with the Common Flash Interface, but will use the common
 	  CFI-targetted flash drivers for any chips which are identified which
 	  are in fact compatible in all but the probe method. This actually
-	  covers most AMD/Fujitsu-compatible chips, and will shortly cover also
-	  non-CFI Intel chips (that code is in MTD CVS and should shortly be sent
-	  for inclusion in Linus' tree)
+	  covers most AMD/Fujitsu-compatible chips and also non-CFI
+	  Intel chips.
 
 config MTD_GEN_PROBE
 	tristate
diff --git a/drivers/mtd/maps/dilnetpc.c b/drivers/mtd/maps/dilnetpc.c
index b51c757..efb2216 100644
--- a/drivers/mtd/maps/dilnetpc.c
+++ b/drivers/mtd/maps/dilnetpc.c
@@ -218,8 +218,8 @@ static void dnp_set_vpp(struct map_info 
 	{
 		if(--vpp_counter == 0)
 			setcsc(CSC_RBWR, getcsc(CSC_RBWR) | 0x4);
-		else if(vpp_counter < 0)
-			BUG();
+		else
+			BUG_ON(vpp_counter < 0);
 	}
 	spin_unlock_irq(&dnpc_spin);
 }
@@ -240,8 +240,8 @@ static void adnp_set_vpp(struct map_info
 	{
 		if(--vpp_counter == 0)
 			setcsc(CSC_RBWR, getcsc(CSC_RBWR) | 0x8);
-		else if(vpp_counter < 0)
-			BUG();
+		else
+			BUG_ON(vpp_counter < 0);
 	}
 	spin_unlock_irq(&dnpc_spin);
 }
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 7f3ff50..840dd66 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -450,8 +450,7 @@ int deregister_mtd_blktrans(struct mtd_b
 
 	kfree(tr->blkcore_priv);
 
-	if (!list_empty(&tr->devs))
-		BUG();
+	BUG_ON(!list_empty(&tr->devs));
 	return 0;
 }
 
diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index b1bf8c4..9af8403 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -477,8 +477,7 @@ static int concat_erase(struct mtd_info 
 	}
 
 	/* must never happen since size limit has been verified above */
-	if (i >= concat->num_subdev)
-		BUG();
+	BUG_ON(i >= concat->num_subdev);
 
 	/* now do the erase: */
 	err = 0;
@@ -500,8 +499,7 @@ static int concat_erase(struct mtd_info 
 		if ((err = concat_dev_erase(subdev, erase))) {
 			/* sanity check: should never happen since
 			 * block alignment has been checked above */
-			if (err == -EINVAL)
-				BUG();
+			BUG_ON(err == -EINVAL);
 			if (erase->fail_addr != 0xffffffff)
 				instr->fail_addr = erase->fail_addr + offset;
 			break;
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 2f72010..c1c6f13 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -437,8 +437,7 @@ dasd_forget_ranges(void)
 	spin_lock(&dasd_devmap_lock);
 	for (i = 0; i < 256; i++) {
 		list_for_each_entry_safe(devmap, n, &dasd_hashlists[i], list) {
-			if (devmap->device != NULL)
-				BUG();
+			BUG_ON(devmap->device != NULL);
 			list_del(&devmap->list);
 			kfree(devmap);
 		}
@@ -547,8 +546,7 @@ dasd_delete_device(struct dasd_device *d
 
 	/* First remove device pointer from devmap. */
 	devmap = dasd_find_busid(device->cdev->dev.bus_id);
-	if (IS_ERR(devmap))
-		BUG();
+	BUG_ON(IS_ERR(devmap));
 	spin_lock(&dasd_devmap_lock);
 	if (devmap->device != device) {
 		spin_unlock(&dasd_devmap_lock);
diff --git a/fs/buffer.c b/fs/buffer.c
index 3b3ab52..4342ab0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -796,8 +796,7 @@ void mark_buffer_dirty_inode(struct buff
 	if (!mapping->assoc_mapping) {
 		mapping->assoc_mapping = buffer_mapping;
 	} else {
-		if (mapping->assoc_mapping != buffer_mapping)
-			BUG();
+		BUG_ON(mapping->assoc_mapping != buffer_mapping);
 	}
 	if (list_empty(&bh->b_assoc_buffers)) {
 		spin_lock(&buffer_mapping->private_lock);
@@ -1114,8 +1113,7 @@ grow_dev_page(struct block_device *bdev,
 	if (!page)
 		return NULL;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 
 	if (page_has_buffers(page)) {
 		bh = page_buffers(page);
@@ -1522,8 +1520,7 @@ void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset)
 {
 	bh->b_page = page;
-	if (offset >= PAGE_SIZE)
-		BUG();
+	BUG_ON(offset >= PAGE_SIZE);
 	if (PageHighMem(page))
 		/*
 		 * This catches illegal uses and preserves the offset:
diff --git a/fs/dcache.c b/fs/dcache.c
index 9395846..0778f49 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -34,7 +34,6 @@
 #include <linux/swap.h>
 #include <linux/bootmem.h>
 
-/* #define DCACHE_DEBUG 1 */
 
 int sysctl_vfs_cache_pressure = 100;
 EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
@@ -603,10 +602,6 @@ resume:
 		 */
 		if (!list_empty(&dentry->d_subdirs)) {
 			this_parent = dentry;
-#ifdef DCACHE_DEBUG
-printk(KERN_DEBUG "select_parent: descending to %s/%s, found=%d\n",
-dentry->d_parent->d_name.name, dentry->d_name.name, found);
-#endif
 			goto repeat;
 		}
 	}
@@ -616,10 +611,6 @@ dentry->d_parent->d_name.name, dentry->d
 	if (this_parent != parent) {
 		next = this_parent->d_u.d_child.next;
 		this_parent = this_parent->d_parent;
-#ifdef DCACHE_DEBUG
-printk(KERN_DEBUG "select_parent: ascending to %s/%s, found=%d\n",
-this_parent->d_parent->d_name.name, this_parent->d_name.name, found);
-#endif
 		goto resume;
 	}
 out:
@@ -798,7 +789,7 @@ struct dentry *d_alloc_name(struct dentr
  
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
-	if (!list_empty(&entry->d_alias)) BUG();
+	BUG_ON(!list_empty(&entry->d_alias));
 	spin_lock(&dcache_lock);
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index b3dbd71..0165388 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -416,8 +416,7 @@ void ext2_set_link(struct inode *dir, st
 
 	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type (de, inode);
 	err = ext2_commit_chunk(page, from, to);
@@ -554,8 +553,7 @@ int ext2_delete_entry (struct ext2_dir_e
 		from = (char*)pde - (char*)page_address(page);
 	lock_page(page);
 	err = mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	if (pde)
 		pde->rec_len = cpu_to_le16(to-from);
 	dir->inode = 0;
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index a7a7d77..1e44dcf 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -306,8 +306,7 @@ void hfs_bnode_unhash(struct hfs_bnode *
 	for (p = &node->tree->node_hash[hfs_bnode_hash(node->this)];
 	     *p && *p != node; p = &(*p)->next_hash)
 		;
-	if (!*p)
-		BUG();
+	BUG_ON(!*p);
 	*p = node->next_hash;
 	node->tree->node_hash_cnt--;
 }
@@ -415,8 +414,7 @@ struct hfs_bnode *hfs_bnode_create(struc
 	spin_lock(&tree->hash_lock);
 	node = hfs_bnode_findhash(tree, num);
 	spin_unlock(&tree->hash_lock);
-	if (node)
-		BUG();
+	BUG_ON(node);
 	node = __hfs_bnode_create(tree, num);
 	if (!node)
 		return ERR_PTR(-ENOMEM);
@@ -459,8 +457,7 @@ void hfs_bnode_put(struct hfs_bnode *nod
 
 		dprint(DBG_BNODE_REFS, "put_node(%d:%d): %d\n",
 		       node->tree->cnid, node->this, atomic_read(&node->refcnt));
-		if (!atomic_read(&node->refcnt))
-			BUG();
+		BUG_ON(!atomic_read(&node->refcnt));
 		if (!atomic_dec_and_lock(&node->refcnt, &tree->hash_lock))
 			return;
 		for (i = 0; i < tree->pages_per_bnode; i++) {
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 7bb11ed..d20131c 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -36,8 +36,7 @@ struct hfs_btree *hfs_btree_open(struct 
 	tree->inode = iget_locked(sb, id);
 	if (!tree->inode)
 		goto free_tree;
-	if (!(tree->inode->i_state & I_NEW))
-		BUG();
+	BUG_ON(!(tree->inode->i_state & I_NEW));
 	{
 	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
 	HFS_I(tree->inode)->flags = 0;
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 8b671fe..adb7cad 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -23,7 +23,6 @@ int root_mountflags = MS_RDONLY | MS_SIL
 char * __initdata root_device_name;
 static char __initdata saved_root_name[64];
 
-/* this is initialized in init/main.c */
 dev_t ROOT_DEV;
 
 static int __init load_ramdisk(char *str)
diff --git a/ipc/sem.c b/ipc/sem.c
index 59696a8..18a78fe 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -227,8 +227,7 @@ asmlinkage long sys_semget (key_t key, i
 		err = -EEXIST;
 	} else {
 		sma = sem_lock(id);
-		if(sma==NULL)
-			BUG();
+		BUG_ON(sma==NULL);
 		if (nsems > sma->sem_nsems)
 			err = -EINVAL;
 		else if (ipcperms(&sma->sem_perm, semflg))
@@ -1181,8 +1180,7 @@ retry_undos:
 
 	sma = sem_lock(semid);
 	if(sma==NULL) {
-		if(queue.prev != NULL)
-			BUG();
+		BUG_ON(queue.prev != NULL);
 		error = -EIDRM;
 		goto out_free;
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index a020639..d93ab2b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -769,8 +769,7 @@ int unshare_files(void)
 	struct files_struct *files  = current->files;
 	int rc;
 
-	if(!files)
-		BUG();
+	BUG_ON(!files);
 
 	/* This can race but the race causes us to copy when we don't
 	   need to and drop the copy */
diff --git a/mm/memory.c b/mm/memory.c
index e347e10..d90ff9d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2352,10 +2352,8 @@ int make_pages_present(unsigned long add
 	if (!vma)
 		return -1;
 	write = (vma->vm_flags & VM_WRITE) != 0;
-	if (addr >= end)
-		BUG();
-	if (end > vma->vm_end)
-		BUG();
+	BUG_ON(addr >= end);
+	BUG_ON(end > vma->vm_end);
 	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
 	ret = get_user_pages(current, current->mm, addr,
 			len, write, 0, NULL, NULL);
diff --git a/mm/mempool.c b/mm/mempool.c
index f71893e..9ef13dd 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -183,8 +183,8 @@ EXPORT_SYMBOL(mempool_resize);
  */
 void mempool_destroy(mempool_t *pool)
 {
-	if (pool->curr_nr != pool->min_nr)
-		BUG();		/* There were outstanding elements */
+	/* Check for outstanding elements */
+	BUG_ON(pool->curr_nr != pool->min_nr);
 	free_pool(pool);
 }
 EXPORT_SYMBOL(mempool_destroy);

