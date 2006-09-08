Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWIHWIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWIHWIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWIHWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:08:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:31186 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751159AbWIHWIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:08:14 -0400
Date: Fri, 8 Sep 2006 15:08:00 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.12
Message-ID: <20060908220800.GB26950@kroah.com>
References: <20060908220741.GA26950@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908220741.GA26950@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index a261e36..5e9bd16 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .11
+EXTRAVERSION = .12
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/arch/ia64/sn/kernel/xpc_channel.c b/arch/ia64/sn/kernel/xpc_channel.c
index 8255a9b..7e8a4d1 100644
--- a/arch/ia64/sn/kernel/xpc_channel.c
+++ b/arch/ia64/sn/kernel/xpc_channel.c
@@ -279,8 +279,8 @@ xpc_pull_remote_cachelines(struct xpc_pa
 		return part->reason;
 	}
 
-	bte_ret = xp_bte_copy((u64) src, (u64) ia64_tpa((u64) dst),
-				(u64) cnt, (BTE_NORMAL | BTE_WACQUIRE), NULL);
+	bte_ret = xp_bte_copy((u64) src, (u64) dst, (u64) cnt,
+					(BTE_NORMAL | BTE_WACQUIRE), NULL);
 	if (bte_ret == BTE_SUCCESS) {
 		return xpcSuccess;
 	}
diff --git a/arch/ia64/sn/kernel/xpc_main.c b/arch/ia64/sn/kernel/xpc_main.c
index 99b123a..440039f 100644
--- a/arch/ia64/sn/kernel/xpc_main.c
+++ b/arch/ia64/sn/kernel/xpc_main.c
@@ -1052,6 +1052,8 @@ xpc_do_exit(enum xpc_retval reason)
 	if (xpc_sysctl) {
 		unregister_sysctl_table(xpc_sysctl);
 	}
+
+	kfree(xpc_remote_copy_buffer_base);
 }
 
 
@@ -1212,24 +1214,20 @@ xpc_init(void)
 	partid_t partid;
 	struct xpc_partition *part;
 	pid_t pid;
+	size_t buf_size;
 
 
 	if (!ia64_platform_is("sn2")) {
 		return -ENODEV;
 	}
 
-	/*
-	 * xpc_remote_copy_buffer is used as a temporary buffer for bte_copy'ng
-	 * various portions of a partition's reserved page. Its size is based
-	 * on the size of the reserved page header and part_nasids mask. So we
-	 * need to ensure that the other items will fit as well.
-	 */
-	if (XPC_RP_VARS_SIZE > XPC_RP_HEADER_SIZE + XP_NASID_MASK_BYTES) {
-		dev_err(xpc_part, "xpc_remote_copy_buffer is not big enough\n");
-		return -EPERM;
-	}
-	DBUG_ON((u64) xpc_remote_copy_buffer !=
-				L1_CACHE_ALIGN((u64) xpc_remote_copy_buffer));
+
+	buf_size = max(XPC_RP_VARS_SIZE,
+				XPC_RP_HEADER_SIZE + XP_NASID_MASK_BYTES);
+	xpc_remote_copy_buffer = xpc_kmalloc_cacheline_aligned(buf_size,
+				     GFP_KERNEL, &xpc_remote_copy_buffer_base);
+	if (xpc_remote_copy_buffer == NULL)
+		return -ENOMEM;
 
 	snprintf(xpc_part->bus_id, BUS_ID_SIZE, "part");
 	snprintf(xpc_chan->bus_id, BUS_ID_SIZE, "chan");
@@ -1293,6 +1291,8 @@ xpc_init(void)
 		if (xpc_sysctl) {
 			unregister_sysctl_table(xpc_sysctl);
 		}
+
+		kfree(xpc_remote_copy_buffer_base);
 		return -EBUSY;
 	}
 
@@ -1311,6 +1311,8 @@ xpc_init(void)
 		if (xpc_sysctl) {
 			unregister_sysctl_table(xpc_sysctl);
 		}
+
+		kfree(xpc_remote_copy_buffer_base);
 		return -EBUSY;
 	}
 
@@ -1362,6 +1364,8 @@ xpc_init(void)
 		if (xpc_sysctl) {
 			unregister_sysctl_table(xpc_sysctl);
 		}
+
+		kfree(xpc_remote_copy_buffer_base);
 		return -EBUSY;
 	}
 
diff --git a/arch/ia64/sn/kernel/xpc_partition.c b/arch/ia64/sn/kernel/xpc_partition.c
index 2a89cfc..57c723f 100644
--- a/arch/ia64/sn/kernel/xpc_partition.c
+++ b/arch/ia64/sn/kernel/xpc_partition.c
@@ -71,19 +71,15 @@ struct xpc_partition xpc_partitions[XP_M
  * Generic buffer used to store a local copy of portions of a remote
  * partition's reserved page (either its header and part_nasids mask,
  * or its vars).
- *
- * xpc_discovery runs only once and is a seperate thread that is
- * very likely going to be processing in parallel with receiving
- * interrupts.
  */
-char ____cacheline_aligned xpc_remote_copy_buffer[XPC_RP_HEADER_SIZE +
-							XP_NASID_MASK_BYTES];
+char *xpc_remote_copy_buffer;
+void *xpc_remote_copy_buffer_base;
 
 
 /*
  * Guarantee that the kmalloc'd memory is cacheline aligned.
  */
-static void *
+void *
 xpc_kmalloc_cacheline_aligned(size_t size, gfp_t flags, void **base)
 {
 	/* see if kmalloc will give us cachline aligned memory by default */
@@ -148,7 +144,7 @@ xpc_get_rsvd_page_pa(int nasid)
 			}
 		}
 
-		bte_res = xp_bte_copy(rp_pa, ia64_tpa(buf), buf_len,
+		bte_res = xp_bte_copy(rp_pa, buf, buf_len,
 					(BTE_NOTIFY | BTE_WACQUIRE), NULL);
 		if (bte_res != BTE_SUCCESS) {
 			dev_dbg(xpc_part, "xp_bte_copy failed %i\n", bte_res);
@@ -447,7 +443,7 @@ xpc_check_remote_hb(void)
 
 		/* pull the remote_hb cache line */
 		bres = xp_bte_copy(part->remote_vars_pa,
-					ia64_tpa((u64) remote_vars),
+					(u64) remote_vars,
 					XPC_RP_VARS_SIZE,
 					(BTE_NOTIFY | BTE_WACQUIRE), NULL);
 		if (bres != BTE_SUCCESS) {
@@ -498,8 +494,7 @@ xpc_get_remote_rp(int nasid, u64 *discov
 
 
 	/* pull over the reserved page header and part_nasids mask */
-
-	bres = xp_bte_copy(*remote_rp_pa, ia64_tpa((u64) remote_rp),
+	bres = xp_bte_copy(*remote_rp_pa, (u64) remote_rp,
 				XPC_RP_HEADER_SIZE + xp_nasid_mask_bytes,
 				(BTE_NOTIFY | BTE_WACQUIRE), NULL);
 	if (bres != BTE_SUCCESS) {
@@ -554,11 +549,8 @@ xpc_get_remote_vars(u64 remote_vars_pa, 
 		return xpcVarsNotSet;
 	}
 
-
 	/* pull over the cross partition variables */
-
-	bres = xp_bte_copy(remote_vars_pa, ia64_tpa((u64) remote_vars),
-				XPC_RP_VARS_SIZE,
+	bres = xp_bte_copy(remote_vars_pa, (u64) remote_vars, XPC_RP_VARS_SIZE,
 				(BTE_NOTIFY | BTE_WACQUIRE), NULL);
 	if (bres != BTE_SUCCESS) {
 		return xpc_map_bte_errors(bres);
@@ -1239,7 +1231,7 @@ xpc_initiate_partid_to_nasids(partid_t p
 
 	part_nasid_pa = (u64) XPC_RP_PART_NASIDS(part->remote_rp_pa);
 
-	bte_res = xp_bte_copy(part_nasid_pa, ia64_tpa((u64) nasid_mask),
+	bte_res = xp_bte_copy(part_nasid_pa, (u64) nasid_mask,
 			xp_nasid_mask_bytes, (BTE_NOTIFY | BTE_WACQUIRE), NULL);
 
 	return xpc_map_bte_errors(bte_res);
diff --git a/arch/sparc64/mm/generic.c b/arch/sparc64/mm/generic.c
index 8cb0620..af9d81d 100644
--- a/arch/sparc64/mm/generic.c
+++ b/arch/sparc64/mm/generic.c
@@ -69,6 +69,8 @@ static inline void io_remap_pte_range(st
 		} else
 			offset += PAGE_SIZE;
 
+		if (pte_write(entry))
+			entry = pte_mkdirty(entry);
 		do {
 			BUG_ON(!pte_none(*pte));
 			set_pte_at(mm, address, pte, entry);
diff --git a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
index 3e677c4..9914a78 100644
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -6,7 +6,7 @@
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
  *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a,
- *   vt8235, vt8237
+ *   vt8235, vt8237, vt8237a
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -82,6 +82,7 @@ static struct via_isa_bridge {
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
diff --git a/drivers/md/dm-exception-store.c b/drivers/md/dm-exception-store.c
index cc07bbe..34a7593 100644
--- a/drivers/md/dm-exception-store.c
+++ b/drivers/md/dm-exception-store.c
@@ -91,7 +91,6 @@ struct pstore {
 	struct dm_snapshot *snap;	/* up pointer to my snapshot */
 	int version;
 	int valid;
-	uint32_t chunk_size;
 	uint32_t exceptions_per_area;
 
 	/*
@@ -133,7 +132,7 @@ static int alloc_area(struct pstore *ps)
 	int r = -ENOMEM;
 	size_t len;
 
-	len = ps->chunk_size << SECTOR_SHIFT;
+	len = ps->snap->chunk_size << SECTOR_SHIFT;
 
 	/*
 	 * Allocate the chunk_size block of memory that will hold
@@ -160,8 +159,8 @@ static int chunk_io(struct pstore *ps, u
 	unsigned long bits;
 
 	where.bdev = ps->snap->cow->bdev;
-	where.sector = ps->chunk_size * chunk;
-	where.count = ps->chunk_size;
+	where.sector = ps->snap->chunk_size * chunk;
+	where.count = ps->snap->chunk_size;
 
 	return dm_io_sync_vm(1, &where, rw, ps->area, &bits);
 }
@@ -188,7 +187,7 @@ static int area_io(struct pstore *ps, ui
 
 static int zero_area(struct pstore *ps, uint32_t area)
 {
-	memset(ps->area, 0, ps->chunk_size << SECTOR_SHIFT);
+	memset(ps->area, 0, ps->snap->chunk_size << SECTOR_SHIFT);
 	return area_io(ps, area, WRITE);
 }
 
@@ -196,6 +195,7 @@ static int read_header(struct pstore *ps
 {
 	int r;
 	struct disk_header *dh;
+	chunk_t chunk_size;
 
 	r = chunk_io(ps, 0, READ);
 	if (r)
@@ -210,8 +210,29 @@ static int read_header(struct pstore *ps
 		*new_snapshot = 0;
 		ps->valid = le32_to_cpu(dh->valid);
 		ps->version = le32_to_cpu(dh->version);
-		ps->chunk_size = le32_to_cpu(dh->chunk_size);
-
+		chunk_size = le32_to_cpu(dh->chunk_size);
+		if (ps->snap->chunk_size != chunk_size) {
+			DMWARN("chunk size %llu in device metadata overrides "
+			       "table chunk size of %llu.",
+			       (unsigned long long)chunk_size,
+			       (unsigned long long)ps->snap->chunk_size);
+
+			/* We had a bogus chunk_size. Fix stuff up. */
+			dm_io_put(sectors_to_pages(ps->snap->chunk_size));
+			free_area(ps);
+
+			ps->snap->chunk_size = chunk_size;
+			ps->snap->chunk_mask = chunk_size - 1;
+			ps->snap->chunk_shift = ffs(chunk_size) - 1;
+
+			r = alloc_area(ps);
+			if (r)
+				return r;
+
+			r = dm_io_get(sectors_to_pages(chunk_size));
+			if (r)
+				return r;
+		}
 	} else {
 		DMWARN("Invalid/corrupt snapshot");
 		r = -ENXIO;
@@ -224,13 +245,13 @@ static int write_header(struct pstore *p
 {
 	struct disk_header *dh;
 
-	memset(ps->area, 0, ps->chunk_size << SECTOR_SHIFT);
+	memset(ps->area, 0, ps->snap->chunk_size << SECTOR_SHIFT);
 
 	dh = (struct disk_header *) ps->area;
 	dh->magic = cpu_to_le32(SNAP_MAGIC);
 	dh->valid = cpu_to_le32(ps->valid);
 	dh->version = cpu_to_le32(ps->version);
-	dh->chunk_size = cpu_to_le32(ps->chunk_size);
+	dh->chunk_size = cpu_to_le32(ps->snap->chunk_size);
 
 	return chunk_io(ps, 0, WRITE);
 }
@@ -365,7 +386,7 @@ static void persistent_destroy(struct ex
 {
 	struct pstore *ps = get_info(store);
 
-	dm_io_put(sectors_to_pages(ps->chunk_size));
+	dm_io_put(sectors_to_pages(ps->snap->chunk_size));
 	vfree(ps->callbacks);
 	free_area(ps);
 	kfree(ps);
@@ -384,6 +405,16 @@ static int persistent_read_metadata(stru
 		return r;
 
 	/*
+	 * Now we know correct chunk_size, complete the initialisation.
+	 */
+	ps->exceptions_per_area = (ps->snap->chunk_size << SECTOR_SHIFT) /
+				  sizeof(struct disk_exception);
+	ps->callbacks = dm_vcalloc(ps->exceptions_per_area,
+			sizeof(*ps->callbacks));
+	if (!ps->callbacks)
+		return -ENOMEM;
+
+	/*
 	 * Do we need to setup a new snapshot ?
 	 */
 	if (new_snapshot) {
@@ -533,9 +564,6 @@ int dm_create_persistent(struct exceptio
 	ps->snap = store->snap;
 	ps->valid = 1;
 	ps->version = SNAPSHOT_DISK_VERSION;
-	ps->chunk_size = chunk_size;
-	ps->exceptions_per_area = (chunk_size << SECTOR_SHIFT) /
-	    sizeof(struct disk_exception);
 	ps->next_free = 2;	/* skipping the header and first area */
 	ps->current_committed = 0;
 
@@ -543,18 +571,9 @@ int dm_create_persistent(struct exceptio
 	if (r)
 		goto bad;
 
-	/*
-	 * Allocate space for all the callbacks.
-	 */
 	ps->callback_count = 0;
 	atomic_set(&ps->pending_count, 0);
-	ps->callbacks = dm_vcalloc(ps->exceptions_per_area,
-				   sizeof(*ps->callbacks));
-
-	if (!ps->callbacks) {
-		r = -ENOMEM;
-		goto bad;
-	}
+	ps->callbacks = NULL;
 
 	store->destroy = persistent_destroy;
 	store->read_metadata = persistent_read_metadata;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 8edd643..f7e7436 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -102,8 +102,10 @@ static struct hash_cell *__get_name_cell
 	unsigned int h = hash_str(str);
 
 	list_for_each_entry (hc, _name_buckets + h, name_list)
-		if (!strcmp(hc->name, str))
+		if (!strcmp(hc->name, str)) {
+			dm_get(hc->md);
 			return hc;
+		}
 
 	return NULL;
 }
@@ -114,8 +116,10 @@ static struct hash_cell *__get_uuid_cell
 	unsigned int h = hash_str(str);
 
 	list_for_each_entry (hc, _uuid_buckets + h, uuid_list)
-		if (!strcmp(hc->uuid, str))
+		if (!strcmp(hc->uuid, str)) {
+			dm_get(hc->md);
 			return hc;
+		}
 
 	return NULL;
 }
@@ -191,7 +195,7 @@ static int unregister_with_devfs(struct 
  */
 static int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
 {
-	struct hash_cell *cell;
+	struct hash_cell *cell, *hc;
 
 	/*
 	 * Allocate the new cells.
@@ -204,14 +208,19 @@ static int dm_hash_insert(const char *na
 	 * Insert the cell into both hash tables.
 	 */
 	down_write(&_hash_lock);
-	if (__get_name_cell(name))
+	hc = __get_name_cell(name);
+	if (hc) {
+		dm_put(hc->md);
 		goto bad;
+	}
 
 	list_add(&cell->name_list, _name_buckets + hash_str(name));
 
 	if (uuid) {
-		if (__get_uuid_cell(uuid)) {
+		hc = __get_uuid_cell(uuid);
+		if (hc) {
 			list_del(&cell->name_list);
+			dm_put(hc->md);
 			goto bad;
 		}
 		list_add(&cell->uuid_list, _uuid_buckets + hash_str(uuid));
@@ -289,6 +298,7 @@ static int dm_hash_rename(const char *ol
 	if (hc) {
 		DMWARN("asked to rename to an already existing name %s -> %s",
 		       old, new);
+		dm_put(hc->md);
 		up_write(&_hash_lock);
 		kfree(new_name);
 		return -EBUSY;
@@ -328,6 +338,7 @@ static int dm_hash_rename(const char *ol
 		dm_table_put(table);
 	}
 
+	dm_put(hc->md);
 	up_write(&_hash_lock);
 	kfree(old_name);
 	return 0;
@@ -611,10 +622,8 @@ static struct hash_cell *__find_device_h
 		return __get_name_cell(param->name);
 
 	md = dm_get_md(huge_decode_dev(param->dev));
-	if (md) {
+	if (md)
 		mdptr = dm_get_mdptr(md);
-		dm_put(md);
-	}
 
 	return mdptr;
 }
@@ -628,7 +637,6 @@ static struct mapped_device *find_device
 	hc = __find_device_hash_cell(param);
 	if (hc) {
 		md = hc->md;
-		dm_get(md);
 
 		/*
 		 * Sneakily write in both the name and the uuid
@@ -653,6 +661,7 @@ static struct mapped_device *find_device
 static int dev_remove(struct dm_ioctl *param, size_t param_size)
 {
 	struct hash_cell *hc;
+	struct mapped_device *md;
 
 	down_write(&_hash_lock);
 	hc = __find_device_hash_cell(param);
@@ -663,8 +672,11 @@ static int dev_remove(struct dm_ioctl *p
 		return -ENXIO;
 	}
 
+	md = hc->md;
+
 	__hash_remove(hc);
 	up_write(&_hash_lock);
+	dm_put(md);
 	param->data_size = 0;
 	return 0;
 }
@@ -790,7 +802,6 @@ static int do_resume(struct dm_ioctl *pa
 	}
 
 	md = hc->md;
-	dm_get(md);
 
 	new_map = hc->new_map;
 	hc->new_map = NULL;
@@ -1078,6 +1089,7 @@ static int table_clear(struct dm_ioctl *
 {
 	int r;
 	struct hash_cell *hc;
+	struct mapped_device *md;
 
 	down_write(&_hash_lock);
 
@@ -1096,7 +1108,9 @@ static int table_clear(struct dm_ioctl *
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 
 	r = __dev_status(hc->md, param);
+	md = hc->md;
 	up_write(&_hash_lock);
+	dm_put(md);
 	return r;
 }
 
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index d12cf3e..2cab46e 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -106,12 +106,42 @@ struct region {
 	struct bio_list delayed_bios;
 };
 
+
+/*-----------------------------------------------------------------
+ * Mirror set structures.
+ *---------------------------------------------------------------*/
+struct mirror {
+	atomic_t error_count;
+	struct dm_dev *dev;
+	sector_t offset;
+};
+
+struct mirror_set {
+	struct dm_target *ti;
+	struct list_head list;
+	struct region_hash rh;
+	struct kcopyd_client *kcopyd_client;
+
+	spinlock_t lock;	/* protects the next two lists */
+	struct bio_list reads;
+	struct bio_list writes;
+
+	/* recovery */
+	region_t nr_regions;
+	int in_sync;
+
+	struct mirror *default_mirror;	/* Default mirror */
+
+	unsigned int nr_mirrors;
+	struct mirror mirror[0];
+};
+
 /*
  * Conversion fns
  */
 static inline region_t bio_to_region(struct region_hash *rh, struct bio *bio)
 {
-	return bio->bi_sector >> rh->region_shift;
+	return (bio->bi_sector - rh->ms->ti->begin) >> rh->region_shift;
 }
 
 static inline sector_t region_to_sector(struct region_hash *rh, region_t region)
@@ -223,7 +253,9 @@ static struct region *__rh_alloc(struct 
 	struct region *reg, *nreg;
 
 	read_unlock(&rh->hash_lock);
-	nreg = mempool_alloc(rh->region_pool, GFP_NOIO);
+	nreg = mempool_alloc(rh->region_pool, GFP_ATOMIC);
+	if (unlikely(!nreg))
+		nreg = kmalloc(sizeof(struct region), GFP_NOIO);
 	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
 		RH_CLEAN : RH_NOSYNC;
 	nreg->rh = rh;
@@ -541,35 +573,6 @@ static void rh_start_recovery(struct reg
 	wake();
 }
 
-/*-----------------------------------------------------------------
- * Mirror set structures.
- *---------------------------------------------------------------*/
-struct mirror {
-	atomic_t error_count;
-	struct dm_dev *dev;
-	sector_t offset;
-};
-
-struct mirror_set {
-	struct dm_target *ti;
-	struct list_head list;
-	struct region_hash rh;
-	struct kcopyd_client *kcopyd_client;
-
-	spinlock_t lock;	/* protects the next two lists */
-	struct bio_list reads;
-	struct bio_list writes;
-
-	/* recovery */
-	region_t nr_regions;
-	int in_sync;
-
-	struct mirror *default_mirror;	/* Default mirror */
-
-	unsigned int nr_mirrors;
-	struct mirror mirror[0];
-};
-
 /*
  * Every mirror should look like this one.
  */
@@ -1115,7 +1118,7 @@ static int mirror_map(struct dm_target *
 	struct mirror *m;
 	struct mirror_set *ms = ti->private;
 
-	map_context->ll = bio->bi_sector >> ms->rh.region_shift;
+	map_context->ll = bio_to_region(&ms->rh, bio);
 
 	if (rw == WRITE) {
 		queue_bio(ms, bio, rw);
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 08312b4..b84bc1a 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -530,7 +530,7 @@ static int snapshot_ctr(struct dm_target
 	}
 
 	ti->private = s;
-	ti->split_io = chunk_size;
+	ti->split_io = s->chunk_size;
 
 	return 0;
 
@@ -1204,7 +1204,7 @@ static int origin_status(struct dm_targe
 
 static struct target_type origin_target = {
 	.name    = "snapshot-origin",
-	.version = {1, 1, 0},
+	.version = {1, 4, 0},
 	.module  = THIS_MODULE,
 	.ctr     = origin_ctr,
 	.dtr     = origin_dtr,
@@ -1215,7 +1215,7 @@ static struct target_type origin_target 
 
 static struct target_type snapshot_target = {
 	.name    = "snapshot",
-	.version = {1, 1, 0},
+	.version = {1, 4, 0},
 	.module  = THIS_MODULE,
 	.ctr     = snapshot_ctr,
 	.dtr     = snapshot_dtr,
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4d710b7..dfd0378 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -26,6 +26,7 @@ static const char *_name = DM_NAME;
 static unsigned int major = 0;
 static unsigned int _major = 0;
 
+static DEFINE_SPINLOCK(_minor_lock);
 /*
  * One of these is allocated per bio.
  */
@@ -54,12 +55,15 @@ union map_info *dm_get_mapinfo(struct bi
         return NULL;
 }
 
+#define MINOR_ALLOCED ((void *)-1)
+
 /*
  * Bits for the md->flags field.
  */
 #define DMF_BLOCK_IO 0
 #define DMF_SUSPENDED 1
 #define DMF_FROZEN 2
+#define DMF_FREEING 3
 
 struct mapped_device {
 	struct rw_semaphore io_lock;
@@ -218,9 +222,23 @@ static int dm_blk_open(struct inode *ino
 {
 	struct mapped_device *md;
 
+	spin_lock(&_minor_lock);
+
 	md = inode->i_bdev->bd_disk->private_data;
+	if (!md)
+		goto out;
+
+	if (test_bit(DMF_FREEING, &md->flags)) {
+		md = NULL;
+		goto out;
+	}
+
 	dm_get(md);
-	return 0;
+
+out:
+	spin_unlock(&_minor_lock);
+
+	return md ? 0 : -ENXIO;
 }
 
 static int dm_blk_close(struct inode *inode, struct file *file)
@@ -744,14 +762,13 @@ static int dm_any_congested(void *conges
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
-static DEFINE_MUTEX(_minor_lock);
 static DEFINE_IDR(_minor_idr);
 
 static void free_minor(unsigned int minor)
 {
-	mutex_lock(&_minor_lock);
+	spin_lock(&_minor_lock);
 	idr_remove(&_minor_idr, minor);
-	mutex_unlock(&_minor_lock);
+	spin_unlock(&_minor_lock);
 }
 
 /*
@@ -764,23 +781,20 @@ static int specific_minor(struct mapped_
 	if (minor >= (1 << MINORBITS))
 		return -EINVAL;
 
-	mutex_lock(&_minor_lock);
+	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
+	spin_lock(&_minor_lock);
 
 	if (idr_find(&_minor_idr, minor)) {
 		r = -EBUSY;
 		goto out;
 	}
 
-	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r) {
-		r = -ENOMEM;
-		goto out;
-	}
-
-	r = idr_get_new_above(&_minor_idr, md, minor, &m);
-	if (r) {
+	r = idr_get_new_above(&_minor_idr, MINOR_ALLOCED, minor, &m);
+	if (r)
 		goto out;
-	}
 
 	if (m != minor) {
 		idr_remove(&_minor_idr, m);
@@ -789,7 +803,7 @@ static int specific_minor(struct mapped_
 	}
 
 out:
-	mutex_unlock(&_minor_lock);
+	spin_unlock(&_minor_lock);
 	return r;
 }
 
@@ -798,15 +812,13 @@ static int next_free_minor(struct mapped
 	int r;
 	unsigned int m;
 
-	mutex_lock(&_minor_lock);
-
 	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r) {
-		r = -ENOMEM;
-		goto out;
-	}
+	if (!r)
+		return -ENOMEM;
 
-	r = idr_get_new(&_minor_idr, md, &m);
+	spin_lock(&_minor_lock);
+
+	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m);
 	if (r) {
 		goto out;
 	}
@@ -820,7 +832,7 @@ static int next_free_minor(struct mapped
 	*minor = m;
 
 out:
-	mutex_unlock(&_minor_lock);
+	spin_unlock(&_minor_lock);
 	return r;
 }
 
@@ -833,12 +845,16 @@ static struct mapped_device *alloc_dev(u
 {
 	int r;
 	struct mapped_device *md = kmalloc(sizeof(*md), GFP_KERNEL);
+	void *old_md;
 
 	if (!md) {
 		DMWARN("unable to allocate device, out of memory.");
 		return NULL;
 	}
 
+	if (!try_module_get(THIS_MODULE))
+		goto bad0;
+
 	/* get a minor number for the dev */
 	r = persistent ? specific_minor(md, minor) : next_free_minor(md, &minor);
 	if (r < 0)
@@ -875,6 +891,10 @@ static struct mapped_device *alloc_dev(u
 	if (!md->disk)
 		goto bad4;
 
+	atomic_set(&md->pending, 0);
+	init_waitqueue_head(&md->wait);
+	init_waitqueue_head(&md->eventq);
+
 	md->disk->major = _major;
 	md->disk->first_minor = minor;
 	md->disk->fops = &dm_blk_dops;
@@ -884,9 +904,12 @@ static struct mapped_device *alloc_dev(u
 	add_disk(md->disk);
 	format_dev_t(md->name, MKDEV(_major, minor));
 
-	atomic_set(&md->pending, 0);
-	init_waitqueue_head(&md->wait);
-	init_waitqueue_head(&md->eventq);
+	/* Populate the mapping, nobody knows we exist yet */
+	spin_lock(&_minor_lock);
+	old_md = idr_replace(&_minor_idr, md, minor);
+	spin_unlock(&_minor_lock);
+
+	BUG_ON(old_md != MINOR_ALLOCED);
 
 	return md;
 
@@ -898,6 +921,8 @@ static struct mapped_device *alloc_dev(u
 	blk_cleanup_queue(md->queue);
 	free_minor(minor);
  bad1:
+	module_put(THIS_MODULE);
+ bad0:
 	kfree(md);
 	return NULL;
 }
@@ -914,8 +939,14 @@ static void free_dev(struct mapped_devic
 	mempool_destroy(md->io_pool);
 	del_gendisk(md->disk);
 	free_minor(minor);
+
+	spin_lock(&_minor_lock);
+	md->disk->private_data = NULL;
+	spin_unlock(&_minor_lock);
+
 	put_disk(md->disk);
 	blk_cleanup_queue(md->queue);
+	module_put(THIS_MODULE);
 	kfree(md);
 }
 
@@ -1015,13 +1046,18 @@ static struct mapped_device *dm_find_md(
 	if (MAJOR(dev) != _major || minor >= (1 << MINORBITS))
 		return NULL;
 
-	mutex_lock(&_minor_lock);
+	spin_lock(&_minor_lock);
 
 	md = idr_find(&_minor_idr, minor);
-	if (!md || (dm_disk(md)->first_minor != minor))
+	if (md && (md == MINOR_ALLOCED ||
+		   (dm_disk(md)->first_minor != minor) ||
+	           test_bit(DMF_FREEING, &md->flags))) {
 		md = NULL;
+		goto out;
+	}
 
-	mutex_unlock(&_minor_lock);
+out:
+	spin_unlock(&_minor_lock);
 
 	return md;
 }
@@ -1055,8 +1091,13 @@ void dm_put(struct mapped_device *md)
 {
 	struct dm_table *map;
 
-	if (atomic_dec_and_test(&md->holders)) {
+	BUG_ON(test_bit(DMF_FREEING, &md->flags));
+
+	if (atomic_dec_and_lock(&md->holders, &_minor_lock)) {
 		map = dm_get_table(md);
+		idr_replace(&_minor_idr, MINOR_ALLOCED, dm_disk(md)->first_minor);
+		set_bit(DMF_FREEING, &md->flags);
+		spin_unlock(&_minor_lock);
 		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);
 			dm_table_postsuspend_targets(map);
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index 72ca553..cc66193 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -51,7 +51,7 @@ #endif
 #include "sky2.h"
 
 #define DRV_NAME		"sky2"
-#define DRV_VERSION		"1.4"
+#define DRV_VERSION		"1.6.1"
 #define PFX			DRV_NAME " "
 
 /*
@@ -321,7 +321,7 @@ static void sky2_phy_init(struct sky2_hw
 	}
 
 	ctrl = gm_phy_read(hw, port, PHY_MARV_PHY_CTRL);
-	if (hw->copper) {
+	if (sky2_is_copper(hw)) {
 		if (hw->chip_id == CHIP_ID_YUKON_FE) {
 			/* enable automatic crossover */
 			ctrl |= PHY_M_PC_MDI_XMODE(PHY_M_PC_ENA_AUTO) >> 1;
@@ -338,25 +338,37 @@ static void sky2_phy_init(struct sky2_hw
 				ctrl |= PHY_M_PC_DSC(2) | PHY_M_PC_DOWN_S_ENA;
 			}
 		}
-		gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
 	} else {
 		/* workaround for deviation #4.88 (CRC errors) */
 		/* disable Automatic Crossover */
 
 		ctrl &= ~PHY_M_PC_MDIX_MSK;
-		gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
+	}
 
-		if (hw->chip_id == CHIP_ID_YUKON_XL) {
-			/* Fiber: select 1000BASE-X only mode MAC Specific Ctrl Reg. */
-			gm_phy_write(hw, port, PHY_MARV_EXT_ADR, 2);
-			ctrl = gm_phy_read(hw, port, PHY_MARV_PHY_CTRL);
-			ctrl &= ~PHY_M_MAC_MD_MSK;
-			ctrl |= PHY_M_MAC_MODE_SEL(PHY_M_MAC_MD_1000BX);
-			gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
+	gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
+
+	/* special setup for PHY 88E1112 Fiber */
+	if (hw->chip_id == CHIP_ID_YUKON_XL && !sky2_is_copper(hw)) {
+		pg = gm_phy_read(hw, port, PHY_MARV_EXT_ADR);
+
+		/* Fiber: select 1000BASE-X only mode MAC Specific Ctrl Reg. */
+		gm_phy_write(hw, port, PHY_MARV_EXT_ADR, 2);
+		ctrl = gm_phy_read(hw, port, PHY_MARV_PHY_CTRL);
+		ctrl &= ~PHY_M_MAC_MD_MSK;
+		ctrl |= PHY_M_MAC_MODE_SEL(PHY_M_MAC_MD_1000BX);
+		gm_phy_write(hw, port, PHY_MARV_PHY_CTRL, ctrl);
 
+		if (hw->pmd_type  == 'P') {
 			/* select page 1 to access Fiber registers */
 			gm_phy_write(hw, port, PHY_MARV_EXT_ADR, 1);
+
+			/* for SFP-module set SIGDET polarity to low */
+			ctrl = gm_phy_read(hw, port, PHY_MARV_PHY_CTRL);
+			ctrl |= PHY_M_FIB_SIGD_POL;
+			gm_phy_write(hw, port, PHY_MARV_CTRL, ctrl);
 		}
+
+		gm_phy_write(hw, port, PHY_MARV_EXT_ADR, pg);
 	}
 
 	ctrl = gm_phy_read(hw, port, PHY_MARV_CTRL);
@@ -373,7 +385,7 @@ static void sky2_phy_init(struct sky2_hw
 	adv = PHY_AN_CSMA;
 
 	if (sky2->autoneg == AUTONEG_ENABLE) {
-		if (hw->copper) {
+		if (sky2_is_copper(hw)) {
 			if (sky2->advertising & ADVERTISED_1000baseT_Full)
 				ct1000 |= PHY_M_1000C_AFD;
 			if (sky2->advertising & ADVERTISED_1000baseT_Half)
@@ -386,8 +398,12 @@ static void sky2_phy_init(struct sky2_hw
 				adv |= PHY_M_AN_10_FD;
 			if (sky2->advertising & ADVERTISED_10baseT_Half)
 				adv |= PHY_M_AN_10_HD;
-		} else		/* special defines for FIBER (88E1011S only) */
-			adv |= PHY_M_AN_1000X_AHD | PHY_M_AN_1000X_AFD;
+		} else {	/* special defines for FIBER (88E1040S only) */
+			if (sky2->advertising & ADVERTISED_1000baseT_Full)
+				adv |= PHY_M_AN_1000X_AFD;
+			if (sky2->advertising & ADVERTISED_1000baseT_Half)
+				adv |= PHY_M_AN_1000X_AHD;
+		}
 
 		/* Set Flow-control capabilities */
 		if (sky2->tx_pause && sky2->rx_pause)
@@ -949,14 +965,14 @@ #endif
 /*
  * It appears the hardware has a bug in the FIFO logic that
  * cause it to hang if the FIFO gets overrun and the receive buffer
- * is not aligned. ALso alloc_skb() won't align properly if slab
+ * is not aligned. Also dev_alloc_skb() won't align properly if slab
  * debugging is enabled.
  */
 static inline struct sk_buff *sky2_alloc_skb(unsigned int size, gfp_t gfp_mask)
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(size + RX_SKB_ALIGN, gfp_mask);
+	skb = __dev_alloc_skb(size + RX_SKB_ALIGN, gfp_mask);
 	if (likely(skb)) {
 		unsigned long p	= (unsigned long) skb->data;
 		skb_reserve(skb, ALIGN(p, RX_SKB_ALIGN) - p);
@@ -1497,7 +1513,7 @@ static int sky2_down(struct net_device *
 
 static u16 sky2_phy_speed(const struct sky2_hw *hw, u16 aux)
 {
-	if (!hw->copper)
+	if (!sky2_is_copper(hw))
 		return SPEED_1000;
 
 	if (hw->chip_id == CHIP_ID_YUKON_FE)
@@ -1855,7 +1871,7 @@ static struct sk_buff *sky2_receive(stru
 		goto oversize;
 
 	if (length < copybreak) {
-		skb = alloc_skb(length + 2, GFP_ATOMIC);
+		skb = dev_alloc_skb(length + 2);
 		if (!skb)
 			goto resubmit;
 
@@ -2016,6 +2032,9 @@ #endif
 		}
 	}
 
+	/* Fully processed status ring so clear irq */
+	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
+
 exit_loop:
 	return work_done;
 }
@@ -2218,9 +2237,6 @@ static int sky2_poll(struct net_device *
 	*budget -= work_done;
 	dev0->quota -= work_done;
 
-	if (status & Y2_IS_STAT_BMU)
-		sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
-
 	if (sky2_more_work(hw))
 		return 1;
 
@@ -2287,7 +2303,7 @@ static inline u32 sky2_clk2us(const stru
 static int __devinit sky2_reset(struct sky2_hw *hw)
 {
 	u16 status;
-	u8 t8, pmd_type;
+	u8 t8;
 	int i;
 
 	sky2_write8(hw, B0_CTST, CS_RST_CLR);
@@ -2333,9 +2349,7 @@ static int __devinit sky2_reset(struct s
 		sky2_pci_write32(hw, PEX_UNC_ERR_STAT, 0xffffffffUL);
 
 
-	pmd_type = sky2_read8(hw, B2_PMD_TYP);
-	hw->copper = !(pmd_type == 'L' || pmd_type == 'S');
-
+	hw->pmd_type = sky2_read8(hw, B2_PMD_TYP);
 	hw->ports = 1;
 	t8 = sky2_read8(hw, B2_Y2_HW_RES);
 	if ((t8 & CFG_DUAL_MAC_MSK) == CFG_DUAL_MAC_MSK) {
@@ -2432,21 +2446,22 @@ static int __devinit sky2_reset(struct s
 
 static u32 sky2_supported_modes(const struct sky2_hw *hw)
 {
-	u32 modes;
-	if (hw->copper) {
-		modes = SUPPORTED_10baseT_Half
-		    | SUPPORTED_10baseT_Full
-		    | SUPPORTED_100baseT_Half
-		    | SUPPORTED_100baseT_Full
-		    | SUPPORTED_Autoneg | SUPPORTED_TP;
+	if (sky2_is_copper(hw)) {
+		u32 modes = SUPPORTED_10baseT_Half
+			| SUPPORTED_10baseT_Full
+			| SUPPORTED_100baseT_Half
+			| SUPPORTED_100baseT_Full
+			| SUPPORTED_Autoneg | SUPPORTED_TP;
 
 		if (hw->chip_id != CHIP_ID_YUKON_FE)
 			modes |= SUPPORTED_1000baseT_Half
-			    | SUPPORTED_1000baseT_Full;
+				| SUPPORTED_1000baseT_Full;
+		return modes;
 	} else
-		modes = SUPPORTED_1000baseT_Full | SUPPORTED_FIBRE
-		    | SUPPORTED_Autoneg;
-	return modes;
+		return  SUPPORTED_1000baseT_Half
+			| SUPPORTED_1000baseT_Full
+			| SUPPORTED_Autoneg
+			| SUPPORTED_FIBRE;
 }
 
 static int sky2_get_settings(struct net_device *dev, struct ethtool_cmd *ecmd)
@@ -2457,7 +2472,7 @@ static int sky2_get_settings(struct net_
 	ecmd->transceiver = XCVR_INTERNAL;
 	ecmd->supported = sky2_supported_modes(hw);
 	ecmd->phy_address = PHY_ADDR_MARV;
-	if (hw->copper) {
+	if (sky2_is_copper(hw)) {
 		ecmd->supported = SUPPORTED_10baseT_Half
 		    | SUPPORTED_10baseT_Full
 		    | SUPPORTED_100baseT_Half
@@ -2466,12 +2481,14 @@ static int sky2_get_settings(struct net_
 		    | SUPPORTED_1000baseT_Full
 		    | SUPPORTED_Autoneg | SUPPORTED_TP;
 		ecmd->port = PORT_TP;
-	} else
+		ecmd->speed = sky2->speed;
+	} else {
+		ecmd->speed = SPEED_1000;
 		ecmd->port = PORT_FIBRE;
+	}
 
 	ecmd->advertising = sky2->advertising;
 	ecmd->autoneg = sky2->autoneg;
-	ecmd->speed = sky2->speed;
 	ecmd->duplex = sky2->duplex;
 	return 0;
 }
@@ -3184,6 +3201,8 @@ static int __devinit sky2_test_msi(struc
 	struct pci_dev *pdev = hw->pdev;
 	int err;
 
+	init_waitqueue_head (&hw->msi_wait);
+
 	sky2_write32(hw, B0_IMSK, Y2_IS_IRQ_SW);
 
 	err = request_irq(pdev->irq, sky2_test_intr, SA_SHIRQ, DRV_NAME, hw);
@@ -3193,10 +3212,8 @@ static int __devinit sky2_test_msi(struc
 		return err;
 	}
 
-	init_waitqueue_head (&hw->msi_wait);
-
 	sky2_write8(hw, B0_CTST, CS_ST_SW_IRQ);
-	wmb();
+	sky2_read8(hw, B0_CTST);
 
 	wait_event_timeout(hw->msi_wait, hw->msi_detected, HZ/10);
 
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index 8a0bc55..9516c1f 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -1318,6 +1318,14 @@ enum {
 };
 
 /* for Yukon-2 Gigabit Ethernet PHY (88E1112 only) */
+/*****  PHY_MARV_PHY_CTRL (page 1)		16 bit r/w	Fiber Specific Ctrl *****/
+enum {
+	PHY_M_FIB_FORCE_LNK	= 1<<10,/* Force Link Good */
+	PHY_M_FIB_SIGD_POL	= 1<<9,	/* SIGDET Polarity */
+	PHY_M_FIB_TX_DIS	= 1<<3,	/* Transmitter Disable */
+};
+
+/* for Yukon-2 Gigabit Ethernet PHY (88E1112 only) */
 /*****  PHY_MARV_PHY_CTRL (page 2)		16 bit r/w	MAC Specific Ctrl *****/
 enum {
 	PHY_M_MAC_MD_MSK	= 7<<7, /* Bit  9.. 7: Mode Select Mask */
@@ -1566,7 +1574,7 @@ enum {
 
 	GMR_FS_ANY_ERR	= GMR_FS_RX_FF_OV | GMR_FS_CRC_ERR |
 			  GMR_FS_FRAGMENT | GMR_FS_LONG_ERR |
-		  	  GMR_FS_MII_ERR | GMR_FS_BAD_FC | GMR_FS_GOOD_FC |
+		  	  GMR_FS_MII_ERR | GMR_FS_BAD_FC |
 			  GMR_FS_UN_SIZE | GMR_FS_JABBER,
 };
 
@@ -1879,7 +1887,7 @@ struct sky2_hw {
 	int		     pm_cap;
 	u8	     	     chip_id;
 	u8		     chip_rev;
-	u8		     copper;
+	u8		     pmd_type;
 	u8		     ports;
 
 	struct sky2_status_le *st_le;
@@ -1891,6 +1899,11 @@ struct sky2_hw {
 	wait_queue_head_t    msi_wait;
 };
 
+static inline int sky2_is_copper(const struct sky2_hw *hw)
+{
+	return !(hw->pmd_type == 'L' || hw->pmd_type == 'S' || hw->pmd_type == 'P');
+}
+
 /* Register accessor for memory mapped device */
 static inline u32 sky2_read32(const struct sky2_hw *hw, unsigned reg)
 {
diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
index 862c226..38b605d 100644
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -69,8 +69,8 @@ #include "tg3.h"
 
 #define DRV_MODULE_NAME		"tg3"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"3.59"
-#define DRV_MODULE_RELDATE	"June 8, 2006"
+#define DRV_MODULE_VERSION	"3.59.1"
+#define DRV_MODULE_RELDATE	"August 25, 2006"
 
 #define TG3_DEF_MAC_MODE	0
 #define TG3_DEF_RX_MODE		0
@@ -11381,11 +11381,15 @@ #if TG3_TSO_SUPPORT != 0
 		tp->tg3_flags2 |= TG3_FLG2_TSO_CAPABLE;
 	}
 
-	/* TSO is on by default on chips that support hardware TSO.
+	/* TSO is on by default on chips that support HW_TSO_2.
+	 * Some HW_TSO_1 capable chips have bugs that can lead to
+	 * tx timeouts in some cases when TSO is enabled.
 	 * Firmware TSO on older chips gives lower performance, so it
 	 * is off by default, but can be enabled using ethtool.
 	 */
-	if (tp->tg3_flags2 & TG3_FLG2_HW_TSO)
+	if ((tp->tg3_flags2 & TG3_FLG2_HW_TSO_2) ||
+	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 &&
+	     tp->pci_chip_rev_id >= CHIPREV_ID_5750_C2))
 		dev->features |= NETIF_F_TSO;
 
 #endif
diff --git a/drivers/net/tg3.h b/drivers/net/tg3.h
index ff0faab..cd68f46 100644
--- a/drivers/net/tg3.h
+++ b/drivers/net/tg3.h
@@ -125,6 +125,7 @@ #define  CHIPREV_ID_5705_A3		 0x3003
 #define  CHIPREV_ID_5750_A0		 0x4000
 #define  CHIPREV_ID_5750_A1		 0x4001
 #define  CHIPREV_ID_5750_A3		 0x4003
+#define  CHIPREV_ID_5750_C2		 0x4202
 #define  CHIPREV_ID_5752_A0_HW		 0x5000
 #define  CHIPREV_ID_5752_A0		 0x6000
 #define  CHIPREV_ID_5752_A1		 0x6001
diff --git a/drivers/net/wireless/spectrum_cs.c b/drivers/net/wireless/spectrum_cs.c
index f7b77ce..54fe4e4 100644
--- a/drivers/net/wireless/spectrum_cs.c
+++ b/drivers/net/wireless/spectrum_cs.c
@@ -245,7 +245,7 @@ spectrum_reset(struct pcmcia_device *lin
 	u_int save_cor;
 
 	/* Doing it if hardware is gone is guaranteed crash */
-	if (pcmcia_dev_present(link))
+	if (!pcmcia_dev_present(link))
 		return -ENODEV;
 
 	/* Save original COR value */
diff --git a/drivers/usb/host/uhci-q.c b/drivers/usb/host/uhci-q.c
index 27909bc..5f44354 100644
--- a/drivers/usb/host/uhci-q.c
+++ b/drivers/usb/host/uhci-q.c
@@ -264,7 +264,7 @@ static void uhci_fixup_toggles(struct uh
 		 * need to change any toggles in this URB */
 		td = list_entry(urbp->td_list.next, struct uhci_td, list);
 		if (toggle > 1 || uhci_toggle(td_token(td)) == toggle) {
-			td = list_entry(urbp->td_list.next, struct uhci_td,
+			td = list_entry(urbp->td_list.prev, struct uhci_td,
 					list);
 			toggle = uhci_toggle(td_token(td)) ^ 1;
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 537893a..997a202 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -86,7 +86,7 @@ static struct linux_binfmt elf_format = 
 		.min_coredump	= ELF_EXEC_PAGESIZE
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
 
 static int set_brk(unsigned long start, unsigned long end)
 {
@@ -389,7 +389,7 @@ static unsigned long load_elf_interp(str
 	     * <= p_memsize so it is only necessary to check p_memsz.
 	     */
 	    k = load_addr + eppnt->p_vaddr;
-	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
+	    if (BAD_ADDR(k) || eppnt->p_filesz > eppnt->p_memsz ||
 		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
 	        error = -ENOMEM;
 		goto out_close;
@@ -876,7 +876,7 @@ static int load_elf_binary(struct linux_
 		 * allowed task size. Note that p_filesz must always be
 		 * <= p_memsz so it is only necessary to check p_memsz.
 		 */
-		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
+		if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
 		    elf_ppnt->p_memsz > TASK_SIZE ||
 		    TASK_SIZE - elf_ppnt->p_memsz < k) {
 			/* set_brk can never work.  Avoid overflows.  */
@@ -930,10 +930,9 @@ static int load_elf_binary(struct linux_
 						    interpreter,
 						    &interp_load_addr);
 		if (BAD_ADDR(elf_entry)) {
-			printk(KERN_ERR "Unable to load interpreter %.128s\n",
-				elf_interpreter);
 			force_sig(SIGSEGV, current);
-			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
+			retval = IS_ERR((void *)elf_entry) ?
+					(int)elf_entry : -EINVAL;
 			goto out_free_dentry;
 		}
 		reloc_func_desc = interp_load_addr;
@@ -944,8 +943,8 @@ static int load_elf_binary(struct linux_
 	} else {
 		elf_entry = loc->elf_ex.e_entry;
 		if (BAD_ADDR(elf_entry)) {
-			send_sig(SIGSEGV, current, 0);
-			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
+			force_sig(SIGSEGV, current);
+			retval = -EINVAL;
 			goto out_free_dentry;
 		}
 	}
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 7e30bae..e51d1a8 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -252,6 +252,46 @@ #ifdef CONFIG_QUOTA
 #endif
 };
 
+static struct dentry *ext2_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+	struct inode *inode;
+	struct dentry *result;
+
+	if (ino != EXT2_ROOT_INO && ino < EXT2_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+	if (ino > le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count))
+		return ERR_PTR(-ESTALE);
+
+	/* iget isn't really right if the inode is currently unallocated!!
+	 * ext2_read_inode currently does appropriate checks, but
+	 * it might be "neater" to call ext2_get_inode first and check
+	 * if the inode is valid.....
+	 */
+	inode = iget(sb, ino);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
+		/* we didn't find the right inode.. */
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	result = d_alloc_anon(inode);
+	if (!result) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	return result;
+}
+
+
 /* Yes, most of these are left as NULL!!
  * A NULL value implies the default, which works with ext2-like file
  * systems, but can be improved upon.
@@ -259,6 +299,7 @@ #endif
  */
 static struct export_operations ext2_export_ops = {
 	.get_parent = ext2_get_parent,
+	.get_dentry = ext2_get_dentry,
 };
 
 static unsigned long get_sb_block(void **data)
diff --git a/fs/locks.c b/fs/locks.c
index ab61a8b..529a0ed 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1389,8 +1389,9 @@ static int __setlease(struct file *filp,
 	if (!leases_enable)
 		goto out;
 
-	error = lease_alloc(filp, arg, &fl);
-	if (error)
+	error = -ENOMEM;
+	fl = locks_alloc_lock();
+	if (fl == NULL)
 		goto out;
 
 	locks_copy_lock(fl, lease);
@@ -1398,6 +1399,7 @@ static int __setlease(struct file *filp,
 	locks_insert_lock(before, fl);
 
 	*flp = fl;
+	error = 0;
 out:
 	return error;
 }
diff --git a/include/asm-ia64/mman.h b/include/asm-ia64/mman.h
index df1b20e..b242f95 100644
--- a/include/asm-ia64/mman.h
+++ b/include/asm-ia64/mman.h
@@ -9,10 +9,12 @@ #define _ASM_IA64_MMAN_H
  */
 
 #ifdef __KERNEL__
+#ifndef __ASSEMBLY__
 #define arch_mmap_check	ia64_map_check_rgn
 int ia64_map_check_rgn(unsigned long addr, unsigned long len,
 		unsigned long flags);
 #endif
+#endif
 
 #include <asm-generic/mman.h>
 
diff --git a/include/asm-ia64/sn/xp.h b/include/asm-ia64/sn/xp.h
index 9bd2f9b..6f807e0 100644
--- a/include/asm-ia64/sn/xp.h
+++ b/include/asm-ia64/sn/xp.h
@@ -60,23 +60,37 @@ #define XP_NASID_MASK_WORDS	((XP_MAX_PHY
  * the bte_copy() once in the hope that the failure was due to a temporary
  * aberration (i.e., the link going down temporarily).
  *
- * See bte_copy for definition of the input parameters.
+ * 	src - physical address of the source of the transfer.
+ *	vdst - virtual address of the destination of the transfer.
+ *	len - number of bytes to transfer from source to destination.
+ *	mode - see bte_copy() for definition.
+ *	notification - see bte_copy() for definition.
  *
  * Note: xp_bte_copy() should never be called while holding a spinlock.
  */
 static inline bte_result_t
-xp_bte_copy(u64 src, u64 dest, u64 len, u64 mode, void *notification)
+xp_bte_copy(u64 src, u64 vdst, u64 len, u64 mode, void *notification)
 {
 	bte_result_t ret;
+	u64 pdst = ia64_tpa(vdst);
 
 
-	ret = bte_copy(src, dest, len, mode, notification);
+	/*
+	 * Ensure that the physically mapped memory is contiguous.
+	 *
+	 * We do this by ensuring that the memory is from region 7 only.
+	 * If the need should arise to use memory from one of the other
+	 * regions, then modify the BUG_ON() statement to ensure that the
+	 * memory from that region is always physically contiguous.
+	 */
+	BUG_ON(REGION_NUMBER(vdst) != RGN_KERNEL);
 
+	ret = bte_copy(src, pdst, len, mode, notification);
 	if (ret != BTE_SUCCESS) {
 		if (!in_interrupt()) {
 			cond_resched();
 		}
-		ret = bte_copy(src, dest, len, mode, notification);
+		ret = bte_copy(src, pdst, len, mode, notification);
 	}
 
 	return ret;
diff --git a/include/asm-ia64/sn/xpc.h b/include/asm-ia64/sn/xpc.h
index aa3b8ac..b454ad4 100644
--- a/include/asm-ia64/sn/xpc.h
+++ b/include/asm-ia64/sn/xpc.h
@@ -684,7 +684,9 @@ extern struct xpc_vars *xpc_vars;
 extern struct xpc_rsvd_page *xpc_rsvd_page;
 extern struct xpc_vars_part *xpc_vars_part;
 extern struct xpc_partition xpc_partitions[XP_MAX_PARTITIONS + 1];
-extern char xpc_remote_copy_buffer[];
+extern char *xpc_remote_copy_buffer;
+extern void *xpc_remote_copy_buffer_base;
+extern void *xpc_kmalloc_cacheline_aligned(size_t, gfp_t, void **);
 extern struct xpc_rsvd_page *xpc_rsvd_page_init(void);
 extern void xpc_allow_IPI_ops(void);
 extern void xpc_restrict_IPI_ops(void);
diff --git a/include/linux/netfilter_bridge.h b/include/linux/netfilter_bridge.h
index a75b84b..178a97e 100644
--- a/include/linux/netfilter_bridge.h
+++ b/include/linux/netfilter_bridge.h
@@ -47,18 +47,26 @@ #define BRNF_DONT_TAKE_PARENT		0x04
 #define BRNF_BRIDGED			0x08
 #define BRNF_NF_BRIDGE_PREROUTING	0x10
 
-
 /* Only used in br_forward.c */
-static inline
-void nf_bridge_maybe_copy_header(struct sk_buff *skb)
+static inline int nf_bridge_maybe_copy_header(struct sk_buff *skb)
 {
+	int err;
+
 	if (skb->nf_bridge) {
 		if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
+			err = skb_cow(skb, 18);
+			if (err)
+				return err;
 			memcpy(skb->data - 18, skb->nf_bridge->data, 18);
 			skb_push(skb, 4);
-		} else
+		} else {
+			err = skb_cow(skb, 16);
+			if (err)
+				return err;
 			memcpy(skb->data - 16, skb->nf_bridge->data, 16);
+		}
 	}
+	return 0;
 }
 
 /* This is called by the IP fragmenting code and it ensures there is
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2c31bb0..a1ce843 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1009,6 +1009,21 @@ static inline int pskb_trim(struct sk_bu
 }
 
 /**
+ *	pskb_trim_unique - remove end from a paged unique (not cloned) buffer
+ *	@skb: buffer to alter
+ *	@len: new length
+ *
+ *	This is identical to pskb_trim except that the caller knows that
+ *	the skb is not cloned so we should never get an error due to out-
+ *	of-memory.
+ */
+static inline void pskb_trim_unique(struct sk_buff *skb, unsigned int len)
+{
+	int err = pskb_trim(skb, len);
+	BUG_ON(err);
+}
+
+/**
  *	skb_orphan - orphan a buffer
  *	@skb: buffer to orphan
  *
diff --git a/kernel/futex.c b/kernel/futex.c
index 5699c51..225af28 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -593,6 +593,7 @@ static int unqueue_me(struct futex_q *q)
 	/* In the common case we don't take the spinlock, which is nice. */
  retry:
 	lock_ptr = q->lock_ptr;
+	barrier();
 	if (lock_ptr != 0) {
 		spin_lock(lock_ptr);
 		/*
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index dcfb5d7..51cacd1 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -111,7 +111,6 @@ static int stop_machine(void)
 	/* If some failed, kill them all. */
 	if (ret < 0) {
 		stopmachine_set_state(STOPMACHINE_EXIT);
-		up(&stopmachine_mutex);
 		return ret;
 	}
 
diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index c4c1ac5..7917265 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -112,15 +112,14 @@ static int subpattern(u8 *pattern, int i
 	return ret;
 }
 
-static void compute_prefix_tbl(struct ts_bm *bm, const u8 *pattern,
-			       unsigned int len)
+static void compute_prefix_tbl(struct ts_bm *bm)
 {
 	int i, j, g;
 
 	for (i = 0; i < ASIZE; i++)
-		bm->bad_shift[i] = len;
-	for (i = 0; i < len - 1; i++)
-		bm->bad_shift[pattern[i]] = len - 1 - i;
+		bm->bad_shift[i] = bm->patlen;
+	for (i = 0; i < bm->patlen - 1; i++)
+		bm->bad_shift[bm->pattern[i]] = bm->patlen - 1 - i;
 
 	/* Compute the good shift array, used to match reocurrences 
 	 * of a subpattern */
@@ -151,8 +150,8 @@ static struct ts_config *bm_init(const v
 	bm = ts_config_priv(conf);
 	bm->patlen = len;
 	bm->pattern = (u8 *) bm->good_shift + prefix_tbl_len;
-	compute_prefix_tbl(bm, pattern, len);
 	memcpy(bm->pattern, pattern, len);
+	compute_prefix_tbl(bm);
 
 	return conf;
 }
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 56f3aa4..ddb7e1c 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -43,11 +43,15 @@ int br_dev_queue_push_xmit(struct sk_buf
 	else {
 #ifdef CONFIG_BRIDGE_NETFILTER
 		/* ip_refrag calls ip_fragment, doesn't copy the MAC header. */
-		nf_bridge_maybe_copy_header(skb);
+		if (nf_bridge_maybe_copy_header(skb))
+			kfree_skb(skb);
+		else
 #endif
-		skb_push(skb, ETH_HLEN);
+		{
+			skb_push(skb, ETH_HLEN);
 
-		dev_queue_xmit(skb);
+			dev_queue_xmit(skb);
+		}
 	}
 
 	return 0;
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index c23e9c0..b916b7f 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2149,6 +2149,8 @@ static struct sk_buff *fill_packet_ipv4(
 	skb->mac.raw = ((u8 *) iph) - 14 - pkt_dev->nr_labels*sizeof(u32);
 	skb->dev = odev;
 	skb->pkt_type = PACKET_HOST;
+	skb->nh.iph = iph;
+	skb->h.uh = udph;
 
 	if (pkt_dev->nfrags <= 0)
 		pgh = (struct pktgen_hdr *)skb_put(skb, datalen);
@@ -2460,6 +2462,8 @@ static struct sk_buff *fill_packet_ipv6(
 	skb->protocol = protocol;
 	skb->dev = odev;
 	skb->pkt_type = PACKET_HOST;
+	skb->nh.ipv6h = iph;
+	skb->h.uh = udph;
 
 	if (pkt_dev->nfrags <= 0)
 		pgh = (struct pktgen_hdr *)skb_put(skb, datalen);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index cff9c3a..d987a27 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -946,7 +946,7 @@ alloc_new_skb:
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 
 			copy = datalen - transhdrlen - fraggap;
@@ -1139,7 +1139,7 @@ ssize_t	ip_append_page(struct sock *sk, 
 					data, fraggap, 0);
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 
 			/*
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f33c9dd..e0657b9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -197,6 +197,7 @@ void tcp_select_initial_window(int __spa
 		 * See RFC1323 for an explanation of the limit to 14 
 		 */
 		space = max_t(u32, sysctl_tcp_rmem[2], sysctl_rmem_max);
+		space = min_t(u32, space, *window_clamp);
 		while (space > 65535 && (*rcv_wscale) < 14) {
 			space >>= 1;
 			(*rcv_wscale)++;
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index a18d425..9ca783d 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -635,14 +635,17 @@ ipv6_renew_options(struct sock *sk, stru
 	struct ipv6_txoptions *opt2;
 	int err;
 
-	if (newtype != IPV6_HOPOPTS && opt->hopopt)
-		tot_len += CMSG_ALIGN(ipv6_optlen(opt->hopopt));
-	if (newtype != IPV6_RTHDRDSTOPTS && opt->dst0opt)
-		tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst0opt));
-	if (newtype != IPV6_RTHDR && opt->srcrt)
-		tot_len += CMSG_ALIGN(ipv6_optlen(opt->srcrt));
-	if (newtype != IPV6_DSTOPTS && opt->dst1opt)
-		tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst1opt));
+	if (opt) {
+		if (newtype != IPV6_HOPOPTS && opt->hopopt)
+			tot_len += CMSG_ALIGN(ipv6_optlen(opt->hopopt));
+		if (newtype != IPV6_RTHDRDSTOPTS && opt->dst0opt)
+			tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst0opt));
+		if (newtype != IPV6_RTHDR && opt->srcrt)
+			tot_len += CMSG_ALIGN(ipv6_optlen(opt->srcrt));
+		if (newtype != IPV6_DSTOPTS && opt->dst1opt)
+			tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst1opt));
+	}
+
 	if (newopt && newoptlen)
 		tot_len += CMSG_ALIGN(newoptlen);
 
@@ -659,25 +662,25 @@ ipv6_renew_options(struct sock *sk, stru
 	opt2->tot_len = tot_len;
 	p = (char *)(opt2 + 1);
 
-	err = ipv6_renew_option(opt->hopopt, newopt, newoptlen,
+	err = ipv6_renew_option(opt ? opt->hopopt : NULL, newopt, newoptlen,
 				newtype != IPV6_HOPOPTS,
 				&opt2->hopopt, &p);
 	if (err)
 		goto out;
 
-	err = ipv6_renew_option(opt->dst0opt, newopt, newoptlen,
+	err = ipv6_renew_option(opt ? opt->dst0opt : NULL, newopt, newoptlen,
 				newtype != IPV6_RTHDRDSTOPTS,
 				&opt2->dst0opt, &p);
 	if (err)
 		goto out;
 
-	err = ipv6_renew_option(opt->srcrt, newopt, newoptlen,
+	err = ipv6_renew_option(opt ? opt->srcrt : NULL, newopt, newoptlen,
 				newtype != IPV6_RTHDR,
-				(struct ipv6_opt_hdr **)opt2->srcrt, &p);
+				(struct ipv6_opt_hdr **)&opt2->srcrt, &p);
 	if (err)
 		goto out;
 
-	err = ipv6_renew_option(opt->dst1opt, newopt, newoptlen,
+	err = ipv6_renew_option(opt ? opt->dst1opt : NULL, newopt, newoptlen,
 				newtype != IPV6_DSTOPTS,
 				&opt2->dst1opt, &p);
 	if (err)
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index e460489..56eddb3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1047,7 +1047,7 @@ alloc_new_skb:
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 			copy = datalen - transhdrlen - fraggap;
 			if (copy < 0) {
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 600eb59..5b1c837 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1246,9 +1246,13 @@ SCTP_STATIC void sctp_close(struct sock 
 			}
 		}
 
-		if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)
-			sctp_primitive_ABORT(asoc, NULL);
-		else
+		if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
+			struct sctp_chunk *chunk;
+
+			chunk = sctp_make_abort_user(asoc, NULL, 0);
+			if (chunk)
+				sctp_primitive_ABORT(asoc, chunk);
+		} else
 			sctp_primitive_SHUTDOWN(asoc, NULL);
 	}
 
