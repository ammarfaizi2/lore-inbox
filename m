Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTFIOXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTFIOXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:23:43 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:7949 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264376AbTFIOWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:22:04 -0400
Date: Mon, 9 Jun 2003 15:35:23 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] dm: signed/unsigned audit
Message-ID: <20030609143523.GC11331@fib011235813.fsnet.co.uk>
References: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

signed/unsigned audit.
--- diff/drivers/md/dm-ioctl.c	2003-06-09 14:18:18.000000000 +0100
+++ source/drivers/md/dm-ioctl.c	2003-06-09 15:05:02.000000000 +0100
@@ -351,7 +351,8 @@
 
 static int populate_table(struct dm_table *table, struct dm_ioctl *args)
 {
-	int i = 0, r, first = 1;
+	int r, first = 1;
+	unsigned int i = 0;
 	struct dm_target_spec *spec;
 	char *params;
 	void *begin, *end;
@@ -380,7 +381,8 @@
 		}
 
 		r = dm_table_add_target(table, spec->target_type,
-					spec->sector_start, spec->length,
+					(sector_t) spec->sector_start,
+					(sector_t) spec->length,
 					params);
 		if (r) {
 			DMWARN("internal error adding target to table");
@@ -558,7 +560,7 @@
 	int r;
 	struct dm_table *t;
 	struct mapped_device *md;
-	int minor;
+	unsigned int minor = 0;
 
 	r = check_name(param->name);
 	if (r)
@@ -574,8 +576,8 @@
 		return r;
 	}
 
-	minor = (param->flags & DM_PERSISTENT_DEV_FLAG) ?
-		minor(to_kdev_t(param->dev)) : -1;
+	if (param->flags & DM_PERSISTENT_DEV_FLAG)
+		minor = minor(to_kdev_t(param->dev));
 
 	r = dm_create(minor, t, &md);
 	if (r) {
@@ -584,7 +586,7 @@
 	}
 	dm_table_put(t);	/* md will have grabbed its own reference */
 
-	set_disk_ro(dm_disk(md), (param->flags & DM_READONLY_FLAG));
+	set_disk_ro(dm_disk(md), (param->flags & DM_READONLY_FLAG) ? 1 : 0);
 	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
 	dm_put(md);
 
@@ -595,9 +597,9 @@
  * Build up the status struct for each target
  */
 static int __status(struct mapped_device *md, struct dm_ioctl *param,
-		    char *outbuf, int *len)
+		    char *outbuf, size_t *len)
 {
-	int i, num_targets;
+	unsigned int i, num_targets;
 	struct dm_target_spec *spec;
 	char *outptr;
 	status_type_t type;
@@ -657,7 +659,7 @@
 static int get_status(struct dm_ioctl *param, struct dm_ioctl *user)
 {
 	struct mapped_device *md;
-	int len = 0;
+	size_t len = 0;
 	int ret;
 	char *outbuf = NULL;
 
@@ -738,7 +740,8 @@
  */
 static int dep(struct dm_ioctl *param, struct dm_ioctl *user)
 {
-	int count, r;
+	int r;
+	unsigned int count;
 	struct mapped_device *md;
 	struct list_head *tmp;
 	size_t len = 0;
@@ -889,7 +892,7 @@
 	}
 	dm_table_put(t);	/* md will have taken its own reference */
 
-	set_disk_ro(dm_disk(md), (param->flags & DM_READONLY_FLAG));
+	set_disk_ro(dm_disk(md), (param->flags & DM_READONLY_FLAG) ? 1 : 0);
 	dm_put(md);
 
 	r = info(param, user);
@@ -945,7 +948,7 @@
  * As well as checking the version compatibility this always
  * copies the kernel interface version out.
  */
-static int check_version(int cmd, struct dm_ioctl *user)
+static int check_version(unsigned int cmd, struct dm_ioctl *user)
 {
 	uint32_t version[3];
 	int r = 0;
@@ -1028,7 +1031,8 @@
 static int ctl_ioctl(struct inode *inode, struct file *file,
 		     uint command, ulong u)
 {
-	int r = 0, cmd;
+	int r = 0;
+	unsigned int cmd;
 	struct dm_ioctl *param;
 	struct dm_ioctl *user = (struct dm_ioctl *) u;
 	ioctl_fn fn = NULL;
--- diff/drivers/md/dm-linear.c	2003-05-21 11:49:55.000000000 +0100
+++ source/drivers/md/dm-linear.c	2003-06-09 15:05:02.000000000 +0100
@@ -23,7 +23,7 @@
 /*
  * Construct a linear mapping: <dev_path> <offset>
  */
-static int linear_ctr(struct dm_target *ti, int argc, char **argv)
+static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 {
 	struct linear_c *lc;
 
@@ -76,7 +76,7 @@
 }
 
 static int linear_status(struct dm_target *ti, status_type_t type,
-			 char *result, int maxlen)
+			 char *result, unsigned int maxlen)
 {
 	struct linear_c *lc = (struct linear_c *) ti->private;
 	char b[BDEVNAME_SIZE];
--- diff/drivers/md/dm-stripe.c	2003-05-21 11:49:55.000000000 +0100
+++ source/drivers/md/dm-stripe.c	2003-06-09 15:05:02.000000000 +0100
@@ -30,7 +30,7 @@
 	struct stripe stripe[0];
 };
 
-static inline struct stripe_c *alloc_context(int stripes)
+static inline struct stripe_c *alloc_context(unsigned int stripes)
 {
 	size_t len;
 
@@ -47,7 +47,7 @@
  * Parse a single <dev> <sector> pair
  */
 static int get_stripe(struct dm_target *ti, struct stripe_c *sc,
-		      int stripe, char **argv)
+		      unsigned int stripe, char **argv)
 {
 	sector_t start;
 
@@ -91,14 +91,15 @@
  * Construct a striped mapping.
  * <number of stripes> <chunk size (2^^n)> [<dev_path> <offset>]+
  */
-static int stripe_ctr(struct dm_target *ti, int argc, char **argv)
+static int stripe_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 {
 	struct stripe_c *sc;
 	sector_t width;
 	uint32_t stripes;
 	uint32_t chunk_size;
 	char *end;
-	int r, i;
+	int r;
+	unsigned int i;
 
 	if (argc < 2) {
 		ti->error = "dm-stripe: Not enough arguments";
@@ -204,11 +205,11 @@
 }
 
 static int stripe_status(struct dm_target *ti,
-			 status_type_t type, char *result, int maxlen)
+			 status_type_t type, char *result, unsigned int maxlen)
 {
 	struct stripe_c *sc = (struct stripe_c *) ti->private;
 	int offset;
-	int i;
+	unsigned int i;
 	char b[BDEVNAME_SIZE];
 
 	switch (type) {
--- diff/drivers/md/dm-table.c	2003-06-09 15:04:57.000000000 +0100
+++ source/drivers/md/dm-table.c	2003-06-09 15:05:02.000000000 +0100
@@ -23,12 +23,12 @@
 	atomic_t holders;
 
 	/* btree table */
-	int depth;
-	int counts[MAX_DEPTH];	/* in nodes */
+	unsigned int depth;
+	unsigned int counts[MAX_DEPTH];	/* in nodes */
 	sector_t *index[MAX_DEPTH];
 
-	int num_targets;
-	int num_allocated;
+	unsigned int num_targets;
+	unsigned int num_allocated;
 	sector_t *highs;
 	struct dm_target *targets;
 
@@ -110,7 +110,7 @@
 /*
  * Calculate the index of the child node of the n'th node k'th key.
  */
-static inline int get_child(int n, int k)
+static inline unsigned int get_child(unsigned int n, unsigned int k)
 {
 	return (n * CHILDREN_PER_NODE) + k;
 }
@@ -118,7 +118,8 @@
 /*
  * Return the n'th node of level l from table t.
  */
-static inline sector_t *get_node(struct dm_table *t, int l, int n)
+static inline sector_t *get_node(struct dm_table *t,
+				 unsigned int l, unsigned int n)
 {
 	return t->index[l] + (n * KEYS_PER_NODE);
 }
@@ -127,7 +128,7 @@
  * Return the highest key that you could lookup from the n'th
  * node on level l of the btree.
  */
-static sector_t high(struct dm_table *t, int l, int n)
+static sector_t high(struct dm_table *t, unsigned int l, unsigned int n)
 {
 	for (; l < t->depth - 1; l++)
 		n = get_child(n, CHILDREN_PER_NODE - 1);
@@ -142,15 +143,15 @@
  * Fills in a level of the btree based on the highs of the level
  * below it.
  */
-static int setup_btree_index(int l, struct dm_table *t)
+static int setup_btree_index(unsigned int l, struct dm_table *t)
 {
-	int n, k;
+	unsigned int n, k;
 	sector_t *node;
 
-	for (n = 0; n < t->counts[l]; n++) {
+	for (n = 0U; n < t->counts[l]; n++) {
 		node = get_node(t, l, n);
 
-		for (k = 0; k < KEYS_PER_NODE; k++)
+		for (k = 0U; k < KEYS_PER_NODE; k++)
 			node[k] = high(t, l + 1, get_child(n, k));
 	}
 
@@ -180,7 +181,7 @@
  * highs, and targets are managed as dynamic arrays during a
  * table load.
  */
-static int alloc_targets(struct dm_table *t, int num)
+static int alloc_targets(struct dm_table *t, unsigned int num)
 {
 	sector_t *n_highs;
 	struct dm_target *n_targets;
@@ -248,7 +249,7 @@
 
 void table_destroy(struct dm_table *t)
 {
-	int i;
+	unsigned int i;
 
 	DMWARN("destroying table");
 
@@ -657,7 +658,8 @@
 
 static int setup_indexes(struct dm_table *t)
 {
-	int i, total = 0;
+	int i;
+	unsigned int total = 0;
 	sector_t *indexes;
 
 	/* allocate the space for *all* the indexes */
@@ -685,7 +687,8 @@
  */
 int dm_table_complete(struct dm_table *t)
 {
-	int leaf_nodes, r = 0;
+	int r = 0;
+	unsigned int leaf_nodes;
 
 	/* how many indexes will the btree have ? */
 	leaf_nodes = div_up(t->num_targets, KEYS_PER_NODE);
@@ -711,7 +714,7 @@
 	return t->num_targets ? (t->highs[t->num_targets - 1] + 1) : 0;
 }
 
-struct dm_target *dm_table_get_target(struct dm_table *t, int index)
+struct dm_target *dm_table_get_target(struct dm_table *t, unsigned int index)
 {
 	if (index > t->num_targets)
 		return NULL;
@@ -724,7 +727,7 @@
  */
 struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
 {
-	int l, n = 0, k = 0;
+	unsigned int l, n = 0, k = 0;
 	sector_t *node;
 
 	for (l = 0; l < t->depth; l++) {
--- diff/drivers/md/dm-target.c	2003-06-09 14:18:18.000000000 +0100
+++ source/drivers/md/dm-target.c	2003-06-09 15:05:02.000000000 +0100
@@ -146,7 +146,7 @@
  * io-err: always fails an io, useful for bringing
  * up LVs that have holes in them.
  */
-static int io_err_ctr(struct dm_target *ti, int argc, char **args)
+static int io_err_ctr(struct dm_target *ti, unsigned int argc, char **args)
 {
 	return 0;
 }
--- diff/drivers/md/dm.c	2003-05-21 11:50:15.000000000 +0100
+++ source/drivers/md/dm.c	2003-06-09 15:05:02.000000000 +0100
@@ -17,8 +17,8 @@
 static const char *_name = DM_NAME;
 #define MAX_DEVICES 1024
 
-static int major = 0;
-static int _major = 0;
+static unsigned int major = 0;
+static unsigned int _major = 0;
 
 struct dm_io {
 	struct mapped_device *md;
@@ -524,7 +524,7 @@
 static spinlock_t _minor_lock = SPIN_LOCK_UNLOCKED;
 static unsigned long _minor_bits[MAX_DEVICES / BITS_PER_LONG];
 
-static void free_minor(int minor)
+static void free_minor(unsigned int minor)
 {
 	spin_lock(&_minor_lock);
 	clear_bit(minor, _minor_bits);
@@ -534,7 +534,7 @@
 /*
  * See if the device with a specific minor # is free.
  */
-static int specific_minor(int minor)
+static int specific_minor(unsigned int minor)
 {
 	int r = -EBUSY;
 
@@ -546,21 +546,22 @@
 
 	spin_lock(&_minor_lock);
 	if (!test_and_set_bit(minor, _minor_bits))
-		r = minor;
+		r = 0;
 	spin_unlock(&_minor_lock);
 
 	return r;
 }
 
-static int next_free_minor(void)
+static int next_free_minor(unsigned int *minor)
 {
-	int minor, r = -EBUSY;
+	unsigned int m, r = -EBUSY;
 
 	spin_lock(&_minor_lock);
-	minor = find_first_zero_bit(_minor_bits, MAX_DEVICES);
-	if (minor != MAX_DEVICES) {
-		set_bit(minor, _minor_bits);
-		r = minor;
+	m = find_first_zero_bit(_minor_bits, MAX_DEVICES);
+	if (m != MAX_DEVICES) {
+		set_bit(m, _minor_bits);
+		*minor = m;
+		r = 0;
 	}
 	spin_unlock(&_minor_lock);
 
@@ -570,8 +571,9 @@
 /*
  * Allocate and initialise a blank device with a given minor.
  */
-static struct mapped_device *alloc_dev(int minor)
+static struct mapped_device *alloc_dev(unsigned int minor)
 {
+	int r;
 	struct mapped_device *md = kmalloc(sizeof(*md), GFP_KERNEL);
 
 	if (!md) {
@@ -580,8 +582,8 @@
 	}
 
 	/* get a minor number for the dev */
-	minor = (minor < 0) ? next_free_minor() : specific_minor(minor);
-	if (minor < 0) {
+	r = (minor < 0) ? next_free_minor(&minor) : specific_minor(minor);
+	if (r < 0) {
 		kfree(md);
 		return NULL;
 	}
@@ -597,7 +599,7 @@
 	md->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
 				     mempool_free_slab, _io_cache);
 	if (!md->io_pool) {
-		free_minor(md->disk->first_minor);
+		free_minor(minor);
 		kfree(md);
 		return NULL;
 	}
@@ -605,7 +607,7 @@
 	md->disk = alloc_disk(1);
 	if (!md->disk) {
 		mempool_destroy(md->io_pool);
-		free_minor(md->disk->first_minor);
+		free_minor(minor);
 		kfree(md);
 		return NULL;
 	}
@@ -661,7 +663,8 @@
 /*
  * Constructor for a new device.
  */
-int dm_create(int minor, struct dm_table *table, struct mapped_device **result)
+int dm_create(unsigned int minor, struct dm_table *table,
+	      struct mapped_device **result)
 {
 	int r;
 	struct mapped_device *md;
--- diff/drivers/md/dm.h	2002-12-30 10:17:13.000000000 +0000
+++ source/drivers/md/dm.h	2003-06-09 15:05:02.000000000 +0100
@@ -51,7 +51,8 @@
  * Functions for manipulating a struct mapped_device.
  * Drop the reference with dm_put when you finish with the object.
  *---------------------------------------------------------------*/
-int dm_create(int minor, struct dm_table *table, struct mapped_device **md);
+int dm_create(unsigned int minor, struct dm_table *table,
+	      struct mapped_device **md);
 
 /*
  * Reference counting for md.
@@ -96,7 +97,7 @@
 int dm_table_complete(struct dm_table *t);
 void dm_table_event(struct dm_table *t);
 sector_t dm_table_get_size(struct dm_table *t);
-struct dm_target *dm_table_get_target(struct dm_table *t, int index);
+struct dm_target *dm_table_get_target(struct dm_table *t, unsigned int index);
 struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector);
 void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q);
 unsigned int dm_table_get_num_targets(struct dm_table *t);
--- diff/include/linux/device-mapper.h	2002-12-30 10:17:13.000000000 +0000
+++ source/include/linux/device-mapper.h	2003-06-09 15:05:02.000000000 +0100
@@ -17,7 +17,8 @@
  * In the constructor the target parameter will already have the
  * table, type, begin and len fields filled in.
  */
-typedef int (*dm_ctr_fn) (struct dm_target *target, int argc, char **argv);
+typedef int (*dm_ctr_fn) (struct dm_target *target,
+			  unsigned int argc, char **argv);
 
 /*
  * The destructor doesn't need to free the dm_target, just
@@ -33,7 +34,7 @@
  */
 typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio);
 typedef int (*dm_status_fn) (struct dm_target *ti, status_type_t status_type,
-			     char *result, int maxlen);
+			     char *result, unsigned int maxlen);
 
 void dm_error(const char *message);
 
