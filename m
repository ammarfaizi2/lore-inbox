Return-Path: <linux-kernel-owner+w=401wt.eu-S1760803AbWLHSZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760803AbWLHSZG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760805AbWLHSZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:25:06 -0500
Received: from ns2.gothnet.se ([82.193.160.251]:2045 "EHLO
	GOTHNET-SMTP2.gothnet.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760803AbWLHSZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:25:01 -0500
Message-ID: <4579ADE3.6040609@tungstengraphics.com>
Date: Fri, 08 Dec 2006 19:24:35 +0100
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.6.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 1/2] agpgart - allow user-populated memory types.
Content-Type: multipart/mixed;
 boundary="------------020509030803080808000700"
X-BitDefender-Scanner: Mail not scanned due to license constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020509030803080808000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

This patch allows drm to populate an agpgart structure with pages of its=20
own.
It's needed for the new drm memory manager which dynamically flips pages=20
in and out of AGP.

The patch modifies the generic functions as well as the intel agp=20
driver. The intel drm driver is
currently the only one supporting the new memory manager.

Other agp drivers may need some minor fixing up once they have a=20
corresponding memory manager enabled drm driver.

AGP memory types >=3D AGP_USER_TYPES are not populated by the agpgart=20
driver, but the drm is expected to do that, as well as taking care of=20
cache- and tlb flushing when needed.

It's not possible to request these types from user space using agpgart=20
ioctls.

The intel driver also gets a new memory type for pages that can be bound=20
cached to the intel GTT.

Patch against davej's agpgart.git

/Thomas Hellstr=F6m


--------------020509030803080808000700
Content-Type: text/x-patch;
 name="patch1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch1.diff"

diff --git a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
index 8b3317f..8abbbda 100644
--- a/drivers/char/agp/agp.h
+++ b/drivers/char/agp/agp.h
@@ -114,6 +114,7 @@ struct agp_bridge_driver {
 	void (*free_by_type)(struct agp_memory *);
 	void *(*agp_alloc_page)(struct agp_bridge_data *);
 	void (*agp_destroy_page)(void *);
+        int (*agp_type_to_mask_type) (struct agp_bridge_data *, int);
 };
 
 struct agp_bridge_data {
@@ -218,6 +219,7 @@ #define I810_PTE_BASE		0x10000
 #define I810_PTE_MAIN_UNCACHED	0x00000000
 #define I810_PTE_LOCAL		0x00000002
 #define I810_PTE_VALID		0x00000001
+#define I830_PTE_SYSTEM_CACHED  0x00000006
 #define I810_SMRAM_MISCC	0x70
 #define I810_GFX_MEM_WIN_SIZE	0x00010000
 #define I810_GFX_MEM_WIN_32M	0x00010000
@@ -266,8 +268,14 @@ void global_cache_flush(void);
 void get_agp_version(struct agp_bridge_data *bridge);
 unsigned long agp_generic_mask_memory(struct agp_bridge_data *bridge,
 	unsigned long addr, int type);
+int agp_generic_type_to_mask_type(struct agp_bridge_data *bridge,
+				  int type);
 struct agp_bridge_data *agp_generic_find_bridge(struct pci_dev *pdev);
 
+/* generic functions for user-populated AGP memory types */
+struct agp_memory *agp_generic_alloc_user(size_t page_count, int type);
+void agp_generic_free_user(struct agp_memory *curr);
+
 /* generic routines for agp>=3 */
 int agp3_generic_fetch_size(void);
 void agp3_generic_tlbflush(struct agp_memory *mem);
diff --git a/drivers/char/agp/ali-agp.c b/drivers/char/agp/ali-agp.c
index 5a31ec7..98177a9 100644
--- a/drivers/char/agp/ali-agp.c
+++ b/drivers/char/agp/ali-agp.c
@@ -214,6 +214,7 @@ static struct agp_bridge_driver ali_gene
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= ali_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver ali_m1541_bridge = {
@@ -237,6 +238,7 @@ static struct agp_bridge_driver ali_m154
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= m1541_alloc_page,
 	.agp_destroy_page	= m1541_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 
diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index b4e00a3..b0acf41 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -91,6 +91,9 @@ static int alpha_core_agp_insert_memory(
 	int num_entries, status;
 	void *temp;
 
+	if (type >= AGP_USER_TYPES || mem->type >= AGP_USER_TYPES)
+		return -EINVAL;
+
 	temp = agp_bridge->current_size;
 	num_entries = A_SIZE_FIX(temp)->num_entries;
 	if ((pg_start + mem->page_count) > num_entries)
@@ -142,6 +145,7 @@ struct agp_bridge_driver alpha_core_agp_
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 struct agp_bridge_data *alpha_bridge;
diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 51d0d56..9c129bd 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -376,6 +376,7 @@ static struct agp_bridge_driver amd_iron
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_device_ids amd_agp_device_ids[] __devinitdata =
diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 00b17ae..ac24340 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -62,12 +62,18 @@ static int amd64_insert_memory(struct ag
 {
 	int i, j, num_entries;
 	long long tmp;
+	int mask_type;
+	struct agp_bridge_data *bridge = mem->bridge;
 	u32 pte;
 
 	num_entries = agp_num_entries();
 
-	if (type != 0 || mem->type != 0)
+	if (type != mem->type)
 		return -EINVAL;
+	mask_type = bridge->driver->agp_type_to_mask_type(bridge, type);
+	if (mask_type != 0)
+		return -EINVAL;
+	
 
 	/* Make sure we can fit the range in the gatt table. */
 	/* FIXME: could wrap */
@@ -90,7 +96,7 @@ static int amd64_insert_memory(struct ag
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		tmp = agp_bridge->driver->mask_memory(agp_bridge,
-			mem->memory[i], mem->type);
+			mem->memory[i], mask_type);
 
 		BUG_ON(tmp & 0xffffff0000000ffcULL);
 		pte = (tmp & 0x000000ff00000000ULL) >> 28;
@@ -247,6 +253,7 @@ static struct agp_bridge_driver amd_8151
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 /* Some basic sanity checks for the aperture. */
diff --git a/drivers/char/agp/ati-agp.c b/drivers/char/agp/ati-agp.c
index f244c66..d4f7b75 100644
--- a/drivers/char/agp/ati-agp.c
+++ b/drivers/char/agp/ati-agp.c
@@ -431,6 +431,7 @@ static struct agp_bridge_driver ati_gene
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 
diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index 30f730f..658cb1a 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -335,6 +335,7 @@ static struct agp_bridge_driver efficeon
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static int __devinit agp_efficeon_probe(struct pci_dev *pdev,
diff --git a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
index 0f2ed2a..e21a319 100644
--- a/drivers/char/agp/frontend.c
+++ b/drivers/char/agp/frontend.c
@@ -892,6 +892,9 @@ static int agpioc_allocate_wrap(struct a
 	if (copy_from_user(&alloc, arg, sizeof(struct agp_allocate)))
 		return -EFAULT;
 
+	if (alloc.type >= AGP_USER_TYPES)
+		return -EINVAL;
+
 	memory = agp_allocate_memory_wrap(alloc.pg_count, alloc.type);
 
 	if (memory == NULL)
diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index ca4629f..7a6107f 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -101,6 +101,45 @@ static int agp_get_key(void)
 	return -1;
 }
 
+/*
+ * Use kmalloc if possible for the page list. Otherwise fall back to
+ * vmalloc. This speeds things up and also saves memory for small AGP
+ * regions.
+ */
+
+static struct agp_memory *agp_create_user_memory(unsigned long num_agp_pages)
+{
+	struct agp_memory *new;
+	unsigned long alloc_size = num_agp_pages*sizeof(struct page *);
+
+	new = kmalloc(sizeof(struct agp_memory), GFP_KERNEL);
+
+	if (new == NULL)
+		return NULL;
+
+	memset(new, 0, sizeof(struct agp_memory));
+	new->key = agp_get_key();
+
+	if (new->key < 0) {
+		kfree(new);
+		return NULL;
+	}
+
+	if (alloc_size <= PAGE_SIZE) {
+		new->memory = kmalloc(alloc_size, GFP_KERNEL);
+	}
+	if (new->memory == NULL) {
+		new->memory = vmalloc(alloc_size);
+	} 
+	if (new->memory == NULL) {
+		agp_free_key(new->key);
+		kfree(new);
+		return NULL;
+	}
+	new->num_scratch_pages = 0;
+	return new;
+}	
+
 
 struct agp_memory *agp_create_memory(int scratch_pages)
 {
@@ -146,6 +185,11 @@ void agp_free_memory(struct agp_memory *
 	if (curr->is_bound == TRUE)
 		agp_unbind_memory(curr);
 
+	if (curr->type >= AGP_USER_TYPES) {
+		agp_generic_free_user(curr);
+		return;
+	}
+
 	if (curr->type != 0) {
 		curr->bridge->driver->free_by_type(curr);
 		return;
@@ -188,6 +232,13 @@ struct agp_memory *agp_allocate_memory(s
 	if ((atomic_read(&bridge->current_memory_agp) + page_count) > bridge->max_memory_agp)
 		return NULL;
 
+	if (type >= AGP_USER_TYPES) {
+		new = agp_generic_alloc_user(page_count, type);
+		if (new)
+			new->bridge = bridge;
+		return new;
+	}
+		
 	if (type != 0) {
 		new = bridge->driver->alloc_by_type(page_count, type);
 		if (new)
@@ -960,6 +1011,7 @@ int agp_generic_insert_memory(struct agp
 	off_t j;
 	void *temp;
 	struct agp_bridge_data *bridge;
+	int mask_type;
 
 	bridge = mem->bridge;
 	if (!bridge)
@@ -992,7 +1044,12 @@ int agp_generic_insert_memory(struct agp
 	num_entries -= agp_memory_reserved/PAGE_SIZE;
 	if (num_entries < 0) num_entries = 0;
 
-	if (type != 0 || mem->type != 0) {
+	if (type != mem->type) {
+		return -EINVAL;
+	}
+
+	mask_type = bridge->driver->agp_type_to_mask_type(bridge, type);
+	if (mask_type != 0) {
 		/* The generic routines know nothing of memory types */
 		return -EINVAL;
 	}
@@ -1001,6 +1058,9 @@ int agp_generic_insert_memory(struct agp
 	if ((pg_start + mem->page_count) > num_entries)
 		return -EINVAL;
 
+	if (mem->page_count == 0)
+		return 0;
+
 	j = pg_start;
 
 	while (j < (pg_start + mem->page_count)) {
@@ -1015,7 +1075,7 @@ int agp_generic_insert_memory(struct agp
 	}
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		writel(bridge->driver->mask_memory(bridge, mem->memory[i], mem->type), bridge->gatt_table+j);
+		writel(bridge->driver->mask_memory(bridge, mem->memory[i], mask_type), bridge->gatt_table+j);
 		readl(bridge->gatt_table+j);	/* PCI Posting. */
 	}
 
@@ -1029,12 +1089,21 @@ int agp_generic_remove_memory(struct agp
 {
 	size_t i;
 	struct agp_bridge_data *bridge;
+	int mask_type;
 
 	bridge = mem->bridge;
 	if (!bridge)
 		return -EINVAL;
 
-	if (type != 0 || mem->type != 0) {
+	if (type != mem->type) {
+		return -EINVAL;
+	}
+
+	if (mem->page_count == 0)
+		return 0;
+
+	mask_type = bridge->driver->agp_type_to_mask_type(bridge, type);
+	if (mask_type != 0) {
 		/* The generic routines know nothing of memory types */
 		return -EINVAL;
 	}
@@ -1067,6 +1136,42 @@ void agp_generic_free_by_type(struct agp
 }
 EXPORT_SYMBOL(agp_generic_free_by_type);
 
+struct agp_memory *agp_generic_alloc_user(size_t page_count, int type)
+{
+	struct agp_memory *new;
+	int i;
+	int pages;
+
+	pages = (page_count + ENTRIES_PER_PAGE - 1) / ENTRIES_PER_PAGE;
+	new = agp_create_user_memory(page_count);
+	if (new == NULL) 
+		return NULL;
+
+	for (i = 0; i < page_count; i++) {
+		new->memory[i] = 0;
+	}
+	new->page_count = 0;
+	new->type = type;
+	new->num_scratch_pages = pages;
+
+	return new;
+}
+EXPORT_SYMBOL(agp_generic_alloc_user);
+
+
+void agp_generic_free_user(struct agp_memory *curr)
+{
+	if ((unsigned long) curr->memory >= VMALLOC_START 
+	    && (unsigned long) curr->memory < VMALLOC_END) {
+		vfree(curr->memory);
+	} else {
+		kfree(curr->memory);
+	}
+	agp_free_key(curr->key);
+	kfree(curr);
+}
+EXPORT_SYMBOL(agp_generic_free_user);
+
 
 /*
  * Basic Page Allocation Routines -
@@ -1160,6 +1265,15 @@ unsigned long agp_generic_mask_memory(st
 }
 EXPORT_SYMBOL(agp_generic_mask_memory);
 
+int agp_generic_type_to_mask_type(struct agp_bridge_data *bridge,
+				  int type)
+{
+	if (type >= AGP_USER_TYPES)
+		return 0;
+	return type;
+}
+EXPORT_SYMBOL(agp_generic_type_to_mask_type);
+
 /*
  * These functions are implemented according to the AGPv3 spec,
  * which covers implementation details that had previously been
diff --git a/drivers/char/agp/hp-agp.c b/drivers/char/agp/hp-agp.c
index 907fb66..847deab 100644
--- a/drivers/char/agp/hp-agp.c
+++ b/drivers/char/agp/hp-agp.c
@@ -438,6 +438,7 @@ struct agp_bridge_driver hp_zx1_driver =
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 	.cant_use_aperture	= 1,
 };
 
diff --git a/drivers/char/agp/i460-agp.c b/drivers/char/agp/i460-agp.c
index 9176944..3e76186 100644
--- a/drivers/char/agp/i460-agp.c
+++ b/drivers/char/agp/i460-agp.c
@@ -293,6 +293,9 @@ static int i460_insert_memory_small_io_p
 	pr_debug("i460_insert_memory_small_io_page(mem=%p, pg_start=%ld, type=%d, paddr0=0x%lx)\n",
 		 mem, pg_start, type, mem->memory[0]);
 
+	if (type >= AGP_USER_TYPES || mem->type >= AGP_USER_TYPES)
+		return -EINVAL;
+
 	io_pg_start = I460_IOPAGES_PER_KPAGE * pg_start;
 
 	temp = agp_bridge->current_size;
@@ -396,6 +399,9 @@ static int i460_insert_memory_large_io_p
 	struct lp_desc *start, *end, *lp;
 	void *temp;
 
+	if (type >= AGP_USER_TYPES || mem->type >= AGP_USER_TYPES)
+		return -EINVAL;
+
 	temp = agp_bridge->current_size;
 	num_entries = A_SIZE_8(temp)->num_entries;
 
@@ -572,6 +578,7 @@ #else
 #endif
 	.alloc_by_type		= agp_generic_alloc_by_type,
 	.free_by_type		= agp_generic_free_by_type,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 	.cant_use_aperture	= 1,
 };
 
diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index d1ede7d..677581a 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -24,6 +24,9 @@ #define IS_I965 (agp_bridge->dev->device
                  agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82965G_HB)
 
 
+extern int agp_memory_reserved;
+
+
 /* Intel 815 register */
 #define INTEL_815_APCONT	0x51
 #define INTEL_815_ATTBASE_MASK	~0x1FFFFFFF
@@ -68,12 +71,15 @@ static struct aper_size_info_fixed intel
 
 #define AGP_DCACHE_MEMORY	1
 #define AGP_PHYS_MEMORY		2
+#define INTEL_AGP_CACHED_MEMORY 3
 
 static struct gatt_mask intel_i810_masks[] =
 {
 	{.mask = I810_PTE_VALID, .type = 0},
 	{.mask = (I810_PTE_VALID | I810_PTE_LOCAL), .type = AGP_DCACHE_MEMORY},
-	{.mask = I810_PTE_VALID, .type = 0}
+	{.mask = I810_PTE_VALID, .type = 0},
+	{.mask = I810_PTE_VALID | I830_PTE_SYSTEM_CACHED, 
+	 .type = INTEL_AGP_CACHED_MEMORY}
 };
 
 static struct _intel_i810_private {
@@ -82,6 +88,7 @@ static struct _intel_i810_private {
 	int num_dcache_entries;
 } intel_i810_private;
 
+
 static int intel_i810_fetch_size(void)
 {
 	u32 smram_miscc;
@@ -201,52 +208,79 @@ static void i8xx_destroy_pages(void *add
 	atomic_dec(&agp_bridge->current_memory_agp);
 }
 
+static int intel_i830_type_to_mask_type(struct agp_bridge_data *bridge,
+					int type)
+{
+	if (type < AGP_USER_TYPES) 
+		return type;
+	else if (type == AGP_USER_CACHED_MEMORY)
+		return INTEL_AGP_CACHED_MEMORY;
+	else
+		return 0;
+}
+
 static int intel_i810_insert_entries(struct agp_memory *mem, off_t pg_start,
 				int type)
 {
 	int i, j, num_entries;
 	void *temp;
+	int ret = -EINVAL;
+	int mask_type;
+
+	if (mem->page_count == 0)
+		goto out;
 
 	temp = agp_bridge->current_size;
 	num_entries = A_SIZE_FIX(temp)->num_entries;
 
 	if ((pg_start + mem->page_count) > num_entries)
-		return -EINVAL;
+		goto out_err;
+
 
 	for (j = pg_start; j < (pg_start + mem->page_count); j++) {
-		if (!PGE_EMPTY(agp_bridge, readl(agp_bridge->gatt_table+j)))
-			return -EBUSY;
+		if (!PGE_EMPTY(agp_bridge, readl(agp_bridge->gatt_table+j))) {
+			ret = -EBUSY;
+			goto out_err;
+		}
 	}
 
-	if (type != 0 || mem->type != 0) {
-		if ((type == AGP_DCACHE_MEMORY) && (mem->type == AGP_DCACHE_MEMORY)) {
-			/* special insert */
+	if (type != mem->type)
+		goto out_err;
+
+	mask_type = agp_bridge->driver->agp_type_to_mask_type(agp_bridge, type);
+
+	switch (mask_type) {
+	case AGP_DCACHE_MEMORY:
+		if (!mem->is_flushed) 
 			global_cache_flush();
-			for (i = pg_start; i < (pg_start + mem->page_count); i++) {
-				writel((i*4096)|I810_PTE_LOCAL|I810_PTE_VALID, intel_i810_private.registers+I810_PTE_BASE+(i*4));
-				readl(intel_i810_private.registers+I810_PTE_BASE+(i*4));	/* PCI Posting. */
-			}
+		for (i = pg_start; i < (pg_start + mem->page_count); i++) {
+			writel((i*4096)|I810_PTE_LOCAL|I810_PTE_VALID, 
+			       intel_i810_private.registers+I810_PTE_BASE+(i*4));
+			readl(intel_i810_private.registers+I810_PTE_BASE+(i*4));
+			
+		}
+		break;
+	case AGP_PHYS_MEMORY:
+		if (!mem->is_flushed) 
 			global_cache_flush();
-			agp_bridge->driver->tlb_flush(mem);
-			return 0;
+		for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
+			writel(agp_bridge->driver->mask_memory(agp_bridge,
+							       mem->memory[i],
+							       mask_type),
+			       intel_i810_private.registers+I810_PTE_BASE+(j*4));
+			readl(intel_i810_private.registers+I810_PTE_BASE+(j*4));
 		}
-		if ((type == AGP_PHYS_MEMORY) && (mem->type == AGP_PHYS_MEMORY))
-			goto insert;
-		return -EINVAL;
-	}
-
-insert:
-	global_cache_flush();
-	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		writel(agp_bridge->driver->mask_memory(agp_bridge,
-			mem->memory[i], mem->type),
-			intel_i810_private.registers+I810_PTE_BASE+(j*4));
-		readl(intel_i810_private.registers+I810_PTE_BASE+(j*4));	/* PCI Posting. */
+		break;
+	default:
+		goto out_err;
 	}
 	global_cache_flush();
-
 	agp_bridge->driver->tlb_flush(mem);
-	return 0;
+out:
+	ret = 0;
+out_err:
+	mem->is_flushed = 1;
+	return ret;
 }
 
 static int intel_i810_remove_entries(struct agp_memory *mem, off_t pg_start,
@@ -254,11 +288,14 @@ static int intel_i810_remove_entries(str
 {
 	int i;
 
+	if (mem->page_count == 0)
+		return 0;
+
 	for (i = pg_start; i < (mem->page_count + pg_start); i++) {
 		writel(agp_bridge->scratch_page, intel_i810_private.registers+I810_PTE_BASE+(i*4));
-		readl(intel_i810_private.registers+I810_PTE_BASE+(i*4));	/* PCI Posting. */
+		readl(intel_i810_private.registers+I810_PTE_BASE+(i*4))	;
 	}
-
+	
 	global_cache_flush();
 	agp_bridge->driver->tlb_flush(mem);
 	return 0;
@@ -330,7 +367,6 @@ static struct agp_memory *intel_i810_all
 	}
 	if (type == AGP_PHYS_MEMORY)
 		return alloc_agpphysmem_i8xx(pg_count, type);
-
 	return NULL;
 }
 
@@ -579,41 +615,55 @@ static int intel_i830_insert_entries(str
 {
 	int i,j,num_entries;
 	void *temp;
+	int ret = -EINVAL;
+	int mask_type;
 
 	temp = agp_bridge->current_size;
 	num_entries = A_SIZE_FIX(temp)->num_entries;
+	if (mem->page_count == 0)
+		goto out;
 
 	if (pg_start < intel_i830_private.gtt_entries) {
 		printk (KERN_DEBUG PFX "pg_start == 0x%.8lx,intel_i830_private.gtt_entries == 0x%.8x\n",
 				pg_start,intel_i830_private.gtt_entries);
 
 		printk (KERN_INFO PFX "Trying to insert into local/stolen memory\n");
-		return -EINVAL;
+		goto out_err;
 	}
 
 	if ((pg_start + mem->page_count) > num_entries)
-		return -EINVAL;
+		goto out_err;
 
 	/* The i830 can't check the GTT for entries since its read only,
 	 * depend on the caller to make the correct offset decisions.
 	 */
 
-	if ((type != 0 && type != AGP_PHYS_MEMORY) ||
-		(mem->type != 0 && mem->type != AGP_PHYS_MEMORY))
-		return -EINVAL;
+	if (type != mem->type)
+		goto out_err;
+
+	mask_type = agp_bridge->driver->agp_type_to_mask_type(agp_bridge, type);
+
+	if (mask_type != 0 && mask_type != AGP_PHYS_MEMORY && 
+	    mask_type != INTEL_AGP_CACHED_MEMORY)
+		goto out_err;
 
-	global_cache_flush();	/* FIXME: Necessary ?*/
+	if (!mem->is_flushed)
+		global_cache_flush();
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		writel(agp_bridge->driver->mask_memory(agp_bridge,
-			mem->memory[i], mem->type),
-			intel_i830_private.registers+I810_PTE_BASE+(j*4));
-		readl(intel_i830_private.registers+I810_PTE_BASE+(j*4));	/* PCI Posting. */
+						       mem->memory[i], mask_type),
+		       intel_i830_private.registers+I810_PTE_BASE+(j*4));
+		readl(intel_i830_private.registers+I810_PTE_BASE+(j*4));
 	}
-
 	global_cache_flush();
 	agp_bridge->driver->tlb_flush(mem);
-	return 0;
+
+out:
+	ret = 0;
+out_err:
+	mem->is_flushed = 1;
+	return ret;
 }
 
 static int intel_i830_remove_entries(struct agp_memory *mem,off_t pg_start,
@@ -630,9 +680,9 @@ static int intel_i830_remove_entries(str
 
 	for (i = pg_start; i < (mem->page_count + pg_start); i++) {
 		writel(agp_bridge->scratch_page, intel_i830_private.registers+I810_PTE_BASE+(i*4));
-		readl(intel_i830_private.registers+I810_PTE_BASE+(i*4));	/* PCI Posting. */
+		readl(intel_i830_private.registers+I810_PTE_BASE+(i*4));
 	}
-
+	
 	global_cache_flush();
 	agp_bridge->driver->tlb_flush(mem);
 	return 0;
@@ -642,7 +692,6 @@ static struct agp_memory *intel_i830_all
 {
 	if (type == AGP_PHYS_MEMORY)
 		return alloc_agpphysmem_i8xx(pg_count, type);
-
 	/* always return NULL for other allocation types for now */
 	return NULL;
 }
@@ -689,6 +738,11 @@ static int intel_i915_insert_entries(str
 {
 	int i,j,num_entries;
 	void *temp;
+	int ret = -EINVAL;
+	int mask_type;
+
+	if (mem->page_count == 0)
+		goto out;
 
 	temp = agp_bridge->current_size;
 	num_entries = A_SIZE_FIX(temp)->num_entries;
@@ -698,31 +752,42 @@ static int intel_i915_insert_entries(str
 				pg_start,intel_i830_private.gtt_entries);
 
 		printk (KERN_INFO PFX "Trying to insert into local/stolen memory\n");
-		return -EINVAL;
+		goto out_err;
 	}
 
 	if ((pg_start + mem->page_count) > num_entries)
-		return -EINVAL;
+		goto out_err;
 
-	/* The i830 can't check the GTT for entries since its read only,
+	/* The i915 can't check the GTT for entries since its read only,
 	 * depend on the caller to make the correct offset decisions.
 	 */
 
-	if ((type != 0 && type != AGP_PHYS_MEMORY) ||
-		(mem->type != 0 && mem->type != AGP_PHYS_MEMORY))
-		return -EINVAL;
+	if (type != mem->type) 
+		goto out_err;
 
-	global_cache_flush();
+	mask_type = agp_bridge->driver->agp_type_to_mask_type(agp_bridge, type);
+
+	if (mask_type != 0 && mask_type != AGP_PHYS_MEMORY && 
+	    mask_type != INTEL_AGP_CACHED_MEMORY)
+		goto out_err;
+
+	if (!mem->is_flushed)
+		global_cache_flush();
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		writel(agp_bridge->driver->mask_memory(agp_bridge,
-			mem->memory[i], mem->type), intel_i830_private.gtt+j);
-		readl(intel_i830_private.gtt+j);	/* PCI Posting. */
+			mem->memory[i], mask_type), intel_i830_private.gtt+j);
+		readl(intel_i830_private.gtt+j);
 	}
-
+	
 	global_cache_flush();
 	agp_bridge->driver->tlb_flush(mem);
-	return 0;
+
+ out:
+	ret = 0;
+ out_err:
+	mem->is_flushed = 1;
+	return ret;
 }
 
 static int intel_i915_remove_entries(struct agp_memory *mem,off_t pg_start,
@@ -1339,6 +1404,7 @@ static struct agp_bridge_driver intel_ge
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_810_driver = {
@@ -1363,6 +1429,7 @@ static struct agp_bridge_driver intel_81
 	.free_by_type		= intel_i810_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_815_driver = {
@@ -1386,6 +1453,7 @@ static struct agp_bridge_driver intel_81
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_830_driver = {
@@ -1410,6 +1478,7 @@ static struct agp_bridge_driver intel_83
 	.free_by_type		= intel_i810_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = intel_i830_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_820_driver = {
@@ -1433,6 +1502,7 @@ static struct agp_bridge_driver intel_82
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_830mp_driver = {
@@ -1456,6 +1526,7 @@ static struct agp_bridge_driver intel_83
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_840_driver = {
@@ -1479,6 +1550,7 @@ static struct agp_bridge_driver intel_84
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_845_driver = {
@@ -1502,6 +1574,7 @@ static struct agp_bridge_driver intel_84
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_850_driver = {
@@ -1525,6 +1598,7 @@ static struct agp_bridge_driver intel_85
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_860_driver = {
@@ -1548,6 +1622,7 @@ static struct agp_bridge_driver intel_86
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_915_driver = {
@@ -1572,6 +1647,7 @@ static struct agp_bridge_driver intel_91
 	.free_by_type		= intel_i810_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = intel_i830_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_i965_driver = {
@@ -1596,6 +1672,7 @@ static struct agp_bridge_driver intel_i9
        .free_by_type           = intel_i810_free_by_type,
        .agp_alloc_page         = agp_generic_alloc_page,
        .agp_destroy_page       = agp_generic_destroy_page,
+       .agp_type_to_mask_type  = intel_i830_type_to_mask_type,
 };
 
 static struct agp_bridge_driver intel_7505_driver = {
@@ -1619,6 +1696,7 @@ static struct agp_bridge_driver intel_75
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static int find_i810(u16 device)
diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index df7f37b..2563286 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -310,6 +310,7 @@ static struct agp_bridge_driver nvidia_d
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static int __devinit agp_nvidia_probe(struct pci_dev *pdev,
diff --git a/drivers/char/agp/sgi-agp.c b/drivers/char/agp/sgi-agp.c
index d73be4c..e191d2b 100644
--- a/drivers/char/agp/sgi-agp.c
+++ b/drivers/char/agp/sgi-agp.c
@@ -265,6 +265,7 @@ struct agp_bridge_driver sgi_tioca_drive
 	.free_by_type = agp_generic_free_by_type,
 	.agp_alloc_page = sgi_tioca_alloc_page,
 	.agp_destroy_page = agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 	.cant_use_aperture = 1,
 	.needs_scratch_page = 0,
 	.num_aperture_sizes = 1,
diff --git a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
index 4f2d7d9..9f5ae77 100644
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -444,6 +444,7 @@ static struct agp_bridge_driver sworks_d
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static int __devinit agp_serverworks_probe(struct pci_dev *pdev,
diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index dffc193..6c45702 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -510,6 +510,7 @@ struct agp_bridge_driver uninorth_agp_dr
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 	.cant_use_aperture	= 1,
 };
 
@@ -534,6 +535,7 @@ struct agp_bridge_driver u3_agp_driver =
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 	.cant_use_aperture	= 1,
 	.needs_scratch_page	= 1,
 };
diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index c149ac9..143d3fa 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -191,6 +191,7 @@ static struct agp_bridge_driver via_agp3
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_bridge_driver via_driver = {
@@ -214,6 +215,7 @@ static struct agp_bridge_driver via_driv
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
 	.agp_destroy_page	= agp_generic_destroy_page,
+	.agp_type_to_mask_type  = agp_generic_type_to_mask_type,
 };
 
 static struct agp_device_ids via_agp_device_ids[] __devinitdata =
diff --git a/include/linux/agp_backend.h b/include/linux/agp_backend.h
index a5c8bb5..89868be 100644
--- a/include/linux/agp_backend.h
+++ b/include/linux/agp_backend.h
@@ -91,6 +91,10 @@ struct agp_memory {
 
 #define AGP_NORMAL_MEMORY 0
 
+#define AGP_USER_TYPES (1 << 16)
+#define AGP_USER_MEMORY (AGP_USER_TYPES)
+#define AGP_USER_CACHED_MEMORY (AGP_USER_TYPES + 1)
+
 extern struct agp_bridge_data *agp_bridge;
 extern struct list_head agp_bridges;
 

--------------020509030803080808000700--



