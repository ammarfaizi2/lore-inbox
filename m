Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWGQP5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWGQP5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWGQP5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:57:16 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:31570 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750882AbWGQP5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:57:14 -0400
X-IronPort-AV: i="4.06,251,1149490800"; 
   d="scan'208"; a="329457886:sNHT36906778"
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu> <adaveq2v9gn.fsf@cisco.com>
	<20060712183049.bcb6c404.akpm@osdl.org> <adau05ltsso.fsf@cisco.com>
	<20060713135446.5e2c6dd5.akpm@osdl.org> <adau05lrzdy.fsf@cisco.com>
	<20060713144341.97d4f771.akpm@osdl.org> <adazmfdq9ha.fsf@cisco.com>
	<20060713181835.ad5eeff6.akpm@osdl.org>
	<20060713183047.642bd9e6.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 17 Jul 2006 08:57:09 -0700
In-Reply-To: <20060713183047.642bd9e6.akpm@osdl.org> (Andrew Morton's message of "Thu, 13 Jul 2006 18:30:47 -0700")
Message-ID: <adak66cp6lm.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Jul 2006 15:57:12.0907 (UTC) FILETIME=[AAF821B0:01C6A9B9]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Problem is, I think, you'll need to preallocate IDR_FREE_MAX items.  And
 > then free them all again when none of them were consumed (usual).

Actually I think it's OK if we just pass in no more than one extra
layer for each try to add something with idr_get_new().  In the worst
case, this leads to a lot of extra calls to idr_get_new(), but in the
usual case it's fine.

I'm including a lightly tested big patch with all my idr changes for
comments -- I'll split it up into a form more suitable for merging.
(Some of the changes are unrelated and obviously good, eg using
kmem_cache_zalloc() instead of a slab cache with a constructor that
does memset(0)).

I'm not sure I'm thrilled with this approach, but it does seem to be a
net win.  With an allyesconfig with debugging options turned off (so
spinlocks shrink back down to 8 bytes), I get the following:

   text		   data	    bss	    dec		    hex	filename
24347759	5971210	2322176	32641145	1f21079	vmlinux.old
24347370	5970474	2320704	32638548	1f20654	vmlinux.new

Most of the savings comes from ocfs2, which has a static array of
255 structures that each contain an idr -- so removing the lock from
struct idr saves 255 * 8 = 2040 bytes.  However, even without
factoring that in, this does seem to be a net win:

add/remove: 2/4 grow/shrink: 23/51 up/down: 719/-3215 (-2496)
function                                     old     new   delta
idr_get_new_above                             38     554    +516
dm_create                                    957    1000     +43
ipath_init_one                              3294    3329     +35
get_layer                                      -      32     +32
idr_alloc_layer                                -      16     +16
sd_probe                                     871     881     +10
rtc_device_register                          493     503     +10
proc_register                                277     286      +9
mmc_add_host_sysfs                           126     135      +9
idr_add_uobj                                  80      85      +5
cma_alloc_port                               224     229      +5
sys_timer_create                             876     880      +4
set_anon_super                               173     177      +4
sctp_process_init                           1312    1316      +4
ib_ucm_ctx_alloc                             197     201      +4
ib_create_cm_id                              287     290      +3
proc_mkdir_mode                               95      97      +2
vfs_kern_mount                               279     280      +1
send_mad                                     325     326      +1
proc_symlink                                 141     142      +1
proc_file_write                               40      41      +1
kill_block_super                              56      57      +1
get_sb_single                                175     176      +1
free_proc_entry                              108     109      +1
deactivate_super                             126     127      +1
proc_readdir                                 353     352      -1
proc_getattr                                  40      39      -1
get_sb_nodev                                 150     149      -1
o2net_send_message_vec                      2032    2030      -2
hwmon_device_register                        198     196      -2
create_proc_entry                            170     168      -2
__put_super_and_need_restart                  54      52      -2
v9fs_read_work                              1424    1421      -3
v9fs_mux_init                               1333    1330      -3
v9fs_mux_flush_cb                            303     300      -3
v9fs_mux_destroy                             369     366      -3
v9fs_mux_cancel                              382     379      -3
o2net_init                                   441     438      -3
inotify_add_watch                            285     280      -5
v9fs_session_init                           1490    1484      -6
unnamed_dev_idr                               32      24      -8
unit_table                                    32      24      -8
tcp_ps                                        32      24      -8
sdp_ps                                        32      24      -8
sd_index_idr                                  32      24      -8
sctp_assocs_id                                32      24      -8
rtc_idr                                       32      24      -8
query_idr                                     32      24      -8
proc_inum_idr                                 32      24      -8
posix_timers_id                               32      24      -8
mmc_host_idr                                  32      24      -8
lpfc_hba_index                                32      24      -8
ib_uverbs_srq_idr                             32      24      -8
ib_uverbs_qp_idr                              32      24      -8
ib_uverbs_pd_idr                              32      24      -8
ib_uverbs_mw_idr                              32      24      -8
ib_uverbs_mr_idr                              32      24      -8
ib_uverbs_cq_idr                              32      24      -8
ib_uverbs_ah_idr                              32      24      -8
i2c_adapter_idr                               32      24      -8
hwmon_idr                                     32      24      -8
ctx_id_table                                  32      24      -8
cm                                           112     104      -8
allocated_ptys                                32      24      -8
_minor_idr                                    32      24      -8
i2c_add_adapter                              494     484     -10
idr_cache_ctor                                12       -     -12
v9fs_get_idpool                              149     134     -15
ib_cm_init                                   237     220     -17
free_layer                                    55      34     -21
idr_init                                      88      62     -26
idr_get_new                                   40      13     -27
idr_remove                                   357     328     -29
infinipath_init                              227     197     -30
lpfc_pci_probe_one                          2752    2710     -42
ptmx_open                                    427     379     -48
idr_pre_get                                   59       -     -59
alloc_layer                                   66       -     -66
idr_get_new_above_int                        533       -    -533
o2net_nodes                                99960   97920   -2040

---

diff --git a/arch/powerpc/mm/mmu_context_64.c b/arch/powerpc/mm/mmu_context_64.c
index 90a06ac..85d6a03 100644
--- a/arch/powerpc/mm/mmu_context_64.c
+++ b/arch/powerpc/mm/mmu_context_64.c
@@ -26,20 +26,21 @@ static DEFINE_IDR(mmu_context_idr);
 
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
+	struct idr_layer *layer = NULL;
 	int index;
 	int err;
 
 again:
-	if (!idr_pre_get(&mmu_context_idr, GFP_KERNEL))
-		return -ENOMEM;
-
 	spin_lock(&mmu_context_lock);
-	err = idr_get_new_above(&mmu_context_idr, NULL, 1, &index);
+	err = idr_get_new_above(&mmu_context_idr, NULL, 1, &index, layer);
 	spin_unlock(&mmu_context_lock);
 
-	if (err == -EAGAIN)
+	if (err == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer)
+			return -ENOMEM;
 		goto again;
-	else if (err)
+	} else if (err)
 		return err;
 
 	if (index > MAX_CONTEXT) {
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index bfdb902..0ae099e 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -2135,6 +2135,7 @@ #ifdef CONFIG_UNIX98_PTYS
 static int ptmx_open(struct inode * inode, struct file * filp)
 {
 	struct tty_struct *tty;
+	struct idr_layer *layer = NULL;
 	int retval;
 	int index;
 	int idr_ret;
@@ -2143,24 +2144,27 @@ static int ptmx_open(struct inode * inod
 
 	/* find a device that is not in use. */
 	down(&allocated_ptys_lock);
-	if (!idr_pre_get(&allocated_ptys, GFP_KERNEL)) {
-		up(&allocated_ptys_lock);
-		return -ENOMEM;
-	}
-	idr_ret = idr_get_new(&allocated_ptys, NULL, &index);
-	if (idr_ret < 0) {
-		up(&allocated_ptys_lock);
-		if (idr_ret == -EAGAIN)
-			return -ENOMEM;
-		return -EIO;
-	}
-	if (index >= pty_limit) {
-		idr_remove(&allocated_ptys, index);
-		up(&allocated_ptys_lock);
-		return -EIO;
-	}
+	do {
+		idr_ret = idr_get_new(&allocated_ptys, NULL, &index, layer);
+		if (idr_ret == -EAGAIN) {
+			layer = idr_alloc_layer(GFP_KERNEL);
+			if (!layer) {
+				idr_ret = -ENOMEM;
+				break;
+			}
+			continue;
+		}
+
+		if (index >= pty_limit) {
+			idr_remove(&allocated_ptys, index);
+			idr_ret = -EIO;
+		}
+	} while (idr_ret == -EAGAIN);
 	up(&allocated_ptys_lock);
 
+	if (idr_ret)
+		return idr_ret == -EAGAIN ? -ENOMEM : -EIO;
+
 	mutex_lock(&tty_mutex);
 	retval = init_dev(ptm_driver, index, &tty);
 	mutex_unlock(&tty_mutex);
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 106fa01..82d6d04 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -38,20 +38,21 @@ static DEFINE_SPINLOCK(idr_lock);
  */
 struct class_device *hwmon_device_register(struct device *dev)
 {
+	struct idr_layer *layer = NULL;
 	struct class_device *cdev;
 	int id, err;
 
 again:
-	if (unlikely(idr_pre_get(&hwmon_idr, GFP_KERNEL) == 0))
-		return ERR_PTR(-ENOMEM);
-
 	spin_lock(&idr_lock);
-	err = idr_get_new(&hwmon_idr, NULL, &id);
+	err = idr_get_new(&hwmon_idr, NULL, &id, layer);
 	spin_unlock(&idr_lock);
 
-	if (unlikely(err == -EAGAIN))
+	if (unlikely(err == -EAGAIN)) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer)
+			return ERR_PTR(-ENOMEM);
 		goto again;
-	else if (unlikely(err))
+	} else if (unlikely(err))
 		return ERR_PTR(err);
 
 	id = id & MAX_ID_MASK;
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 9cb277d..f8aa8ea 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -151,22 +151,24 @@ static struct device_attribute dev_attr_
 int i2c_add_adapter(struct i2c_adapter *adap)
 {
 	int id, res = 0;
+	struct idr_layer   *layer = NULL;
 	struct list_head   *item;
 	struct i2c_driver  *driver;
 
 	mutex_lock(&core_lists);
 
-	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0) {
-		res = -ENOMEM;
-		goto out_unlock;
-	}
-
-	res = idr_get_new(&i2c_adapter_idr, adap, &id);
-	if (res < 0) {
-		if (res == -EAGAIN)
+again:
+	res = idr_get_new(&i2c_adapter_idr, adap, &id, layer);
+	if (res == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer) {
 			res = -ENOMEM;
-		goto out_unlock;
+			goto out_unlock;
+		}
+		goto again;
 	}
+	if (res < 0)
+		goto out_unlock;
 
 	adap->nr =  id & MAX_ID_MASK;
 	mutex_init(&adap->bus_lock);
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f85c97f..cf14d01 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -298,6 +298,7 @@ static int cm_init_av_by_path(struct ib_
 
 static int cm_alloc_id(struct cm_id_private *cm_id_priv)
 {
+	struct idr_layer *layer = NULL;
 	unsigned long flags;
 	int ret;
 	static int next_id;
@@ -305,9 +306,15 @@ static int cm_alloc_id(struct cm_id_priv
 	do {
 		spin_lock_irqsave(&cm.lock, flags);
 		ret = idr_get_new_above(&cm.local_id_table, cm_id_priv, next_id++,
-					(__force int *) &cm_id_priv->id.local_id);
+					(__force int *) &cm_id_priv->id.local_id,
+					layer);
 		spin_unlock_irqrestore(&cm.lock, flags);
-	} while( (ret == -EAGAIN) && idr_pre_get(&cm.local_id_table, GFP_KERNEL) );
+		if (ret == -EAGAIN) {
+			layer = idr_alloc_layer(GFP_KERNEL);
+			if (!layer)
+				ret = -ENOMEM;
+		}
+	} while (ret == -EAGAIN);
 	return ret;
 }
 
@@ -3347,7 +3354,6 @@ static int __init ib_cm_init(void)
 	cm.remote_qp_table = RB_ROOT;
 	cm.remote_sidr_table = RB_ROOT;
 	idr_init(&cm.local_id_table);
-	idr_pre_get(&cm.local_id_table, GFP_KERNEL);
 
 	cm.wq = create_workqueue("ib_cm");
 	if (!cm.wq)
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index d6f99d5..314b150 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1433,6 +1433,7 @@ static void cma_bind_port(struct rdma_bi
 static int cma_alloc_port(struct idr *ps, struct rdma_id_private *id_priv,
 			  unsigned short snum)
 {
+	struct idr_layer *layer = NULL;
 	struct rdma_bind_list *bind_list;
 	int port, start, ret;
 
@@ -1443,8 +1444,13 @@ static int cma_alloc_port(struct idr *ps
 	start = snum ? snum : sysctl_local_port_range[0];
 
 	do {
-		ret = idr_get_new_above(ps, bind_list, start, &port);
-	} while ((ret == -EAGAIN) && idr_pre_get(ps, GFP_KERNEL));
+		ret = idr_get_new_above(ps, bind_list, start, &port, layer);
+		if (ret == -EAGAIN) {
+			layer = idr_alloc_layer(GFP_KERNEL);
+			if (!layer)
+				ret = -ENOMEM;
+		}
+	} while (ret == -EAGAIN);
 
 	if (ret)
 		goto err;
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index aeda484..824b652 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -490,17 +490,20 @@ static void init_mad(struct ib_sa_mad *m
 
 static int send_mad(struct ib_sa_query *query, int timeout_ms, gfp_t gfp_mask)
 {
+	struct idr_layer *layer = NULL;
 	unsigned long flags;
 	int ret, id;
 
 retry:
-	if (!idr_pre_get(&query_idr, gfp_mask))
-		return -ENOMEM;
 	spin_lock_irqsave(&idr_lock, flags);
-	ret = idr_get_new(&query_idr, query, &id);
+	ret = idr_get_new(&query_idr, query, &id, layer);
 	spin_unlock_irqrestore(&idr_lock, flags);
-	if (ret == -EAGAIN)
-		goto retry;
+	if (ret == -EAGAIN) {
+		layer = idr_alloc_layer(gfp_mask);
+		if (layer)
+			goto retry;
+		ret = -ENOMEM;
+	}
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index c1c6fda..22d5e24 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -173,6 +173,7 @@ static void ib_ucm_cleanup_events(struct
 
 static struct ib_ucm_context *ib_ucm_ctx_alloc(struct ib_ucm_file *file)
 {
+	struct idr_layer *layer = NULL;
 	struct ib_ucm_context *ctx;
 	int result;
 
@@ -186,13 +187,15 @@ static struct ib_ucm_context *ib_ucm_ctx
 	INIT_LIST_HEAD(&ctx->events);
 
 	do {
-		result = idr_pre_get(&ctx_id_table, GFP_KERNEL);
-		if (!result)
-			goto error;
-
 		mutex_lock(&ctx_id_mutex);
-		result = idr_get_new(&ctx_id_table, ctx, &ctx->id);
+		result = idr_get_new(&ctx_id_table, ctx, &ctx->id, layer);
 		mutex_unlock(&ctx_id_mutex);
+
+		if (result == -EAGAIN) {
+			layer = idr_alloc_layer(GFP_KERNEL);
+			if (!layer)
+				result = -ENOMEM;
+		}
 	} while (result == -EAGAIN);
 
 	if (result)
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index bdf5d50..71dea88 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -109,18 +109,20 @@ static void put_uobj_write(struct ib_uob
 
 static int idr_add_uobj(struct idr *idr, struct ib_uobject *uobj)
 {
+	struct idr_layer *layer = NULL;
 	int ret;
 
-retry:
-	if (!idr_pre_get(idr, GFP_KERNEL))
-		return -ENOMEM;
+	do {
+		spin_lock(&ib_uverbs_idr_lock);
+		ret = idr_get_new(idr, uobj, &uobj->id, layer);
+		spin_unlock(&ib_uverbs_idr_lock);
 
-	spin_lock(&ib_uverbs_idr_lock);
-	ret = idr_get_new(idr, uobj, &uobj->id);
-	spin_unlock(&ib_uverbs_idr_lock);
-
-	if (ret == -EAGAIN)
-		goto retry;
+		if (ret == -EAGAIN) {
+			layer = idr_alloc_layer(GFP_KERNEL);
+			if (!layer)
+				ret = -ENOMEM;
+		}
+	} while (ret == -EAGAIN);
 
 	return ret;
 }
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index 823131d..6f2a711 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -168,15 +168,11 @@ static void ipath_free_devdata(struct pc
 
 static struct ipath_devdata *ipath_alloc_devdata(struct pci_dev *pdev)
 {
+	struct idr_layer *layer = NULL;
 	unsigned long flags;
 	struct ipath_devdata *dd;
 	int ret;
 
-	if (!idr_pre_get(&unit_table, GFP_KERNEL)) {
-		dd = ERR_PTR(-ENOMEM);
-		goto bail;
-	}
-
 	dd = vmalloc(sizeof(*dd));
 	if (!dd) {
 		dd = ERR_PTR(-ENOMEM);
@@ -187,7 +183,19 @@ static struct ipath_devdata *ipath_alloc
 
 	spin_lock_irqsave(&ipath_devs_lock, flags);
 
-	ret = idr_get_new(&unit_table, dd, &dd->ipath_unit);
+	do {
+		ret = idr_get_new(&unit_table, dd, &dd->ipath_unit, layer);
+		if (ret == -EAGAIN) {
+			spin_unlock_irqrestore(&ipath_devs_lock, flags);
+			layer = idr_alloc_layer(GFP_KERNEL);
+			if (!layer) {
+				dd = ERR_PTR(-ENOMEM);
+				goto bail;
+			}
+			spin_lock_irqsave(&ipath_devs_lock, flags);
+		}
+	} while (ret == -EAGAIN);
+
 	if (ret < 0) {
 		printk(KERN_ERR IPATH_DRV_NAME
 		       ": Could not allocate unit ID: error %d\n", -ret);
@@ -1754,10 +1762,6 @@ static int __init infinipath_init(void)
 	 * the PCI subsystem.
 	 */
 	idr_init(&unit_table);
-	if (!idr_pre_get(&unit_table, GFP_KERNEL)) {
-		ret = -ENOMEM;
-		goto bail;
-	}
 
 	ret = pci_register_driver(&ipath_driver);
 	if (ret < 0) {
@@ -1780,7 +1784,7 @@ static int __init infinipath_init(void)
 		goto bail_group;
 	}
 
-	goto bail;
+	return ret;
 
 bail_group:
 	ipath_driver_remove_group(&ipath_driver.driver);
@@ -1791,7 +1795,6 @@ bail_pci:
 bail_unit:
 	idr_destroy(&unit_table);
 
-bail:
 	return ret;
 }
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c99bf9f..e2dd20a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -807,23 +807,30 @@ static void free_minor(int minor)
  */
 static int specific_minor(struct mapped_device *md, int minor)
 {
+	struct idr_layer *layer = NULL;
 	int r, m;
 
 	if (minor >= (1 << MINORBITS))
 		return -EINVAL;
 
-	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r)
-		return -ENOMEM;
-
 	spin_lock(&_minor_lock);
 
+again:
 	if (idr_find(&_minor_idr, minor)) {
 		r = -EBUSY;
 		goto out;
 	}
 
-	r = idr_get_new_above(&_minor_idr, MINOR_ALLOCED, minor, &m);
+	r = idr_get_new_above(&_minor_idr, MINOR_ALLOCED, minor, &m, layer);
+	if (r == -EAGAIN) {
+		spin_unlock(&_minor_lock);
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer)
+			return -ENOMEM;
+
+		spin_lock(&_minor_lock);
+		goto again;
+	}
 	if (r)
 		goto out;
 
@@ -840,18 +847,21 @@ out:
 
 static int next_free_minor(struct mapped_device *md, int *minor)
 {
+	struct idr_layer *layer = NULL;
 	int r, m;
 
-	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
-	if (!r)
-		return -ENOMEM;
-
+again:
 	spin_lock(&_minor_lock);
-
-	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m);
-	if (r) {
-		goto out;
+	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m, layer);
+	if (r == -EAGAIN) {
+		spin_unlock(&_minor_lock);
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer)
+			return -ENOMEM;
+		goto again;
 	}
+	if (r)
+		goto out;
 
 	if (m >= (1 << MINORBITS)) {
 		idr_remove(&_minor_idr, m);
diff --git a/drivers/mmc/mmc_sysfs.c b/drivers/mmc/mmc_sysfs.c
index a2a35fd..bf61ff4 100644
--- a/drivers/mmc/mmc_sysfs.c
+++ b/drivers/mmc/mmc_sysfs.c
@@ -280,14 +280,19 @@ struct mmc_host *mmc_alloc_host_sysfs(in
  */
 int mmc_add_host_sysfs(struct mmc_host *host)
 {
+	struct idr_layer *layer = NULL;
 	int err;
 
-	if (!idr_pre_get(&mmc_host_idr, GFP_KERNEL))
-		return -ENOMEM;
-
+again:
 	spin_lock(&mmc_host_lock);
-	err = idr_get_new(&mmc_host_idr, host, &host->index);
+	err = idr_get_new(&mmc_host_idr, host, &host->index, layer);
 	spin_unlock(&mmc_host_lock);
+	if (err == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer)
+			return -ENOMEM;
+		goto again;
+	}
 	if (err)
 		return err;
 
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 1cb61a7..3388059 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -42,19 +42,21 @@ struct rtc_device *rtc_device_register(c
 					struct rtc_class_ops *ops,
 					struct module *owner)
 {
+	struct idr_layer *layer = NULL;
 	struct rtc_device *rtc;
 	int id, err;
 
-	if (idr_pre_get(&rtc_idr, GFP_KERNEL) == 0) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-
+again:
 	mutex_lock(&idr_lock);
-	err = idr_get_new(&rtc_idr, NULL, &id);
+	err = idr_get_new(&rtc_idr, NULL, &id, layer);
 	mutex_unlock(&idr_lock);
 
+	if (err == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer)
+			return ERR_PTR(-ENOMEM);
+		goto again;
+	}
 	if (err < 0)
 		goto exit;
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 81755a3..401608b 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1421,6 +1421,7 @@ lpfc_pci_probe_one(struct pci_dev *pdev,
 	struct lpfc_hba  *phba;
 	struct lpfc_sli  *psli;
 	struct lpfc_iocbq *iocbq_entry = NULL, *iocbq_next = NULL;
+	struct idr_layer *layer = NULL;
 	unsigned long bar0map_len, bar2map_len;
 	int error = -ENODEV, retval;
 	int i;
@@ -1443,10 +1444,16 @@ lpfc_pci_probe_one(struct pci_dev *pdev,
 	phba->pcidev = pdev;
 
 	/* Assign an unused board number */
-	if (!idr_pre_get(&lpfc_hba_index, GFP_KERNEL))
-		goto out_put_host;
-
-	error = idr_get_new(&lpfc_hba_index, NULL, &phba->brd_no);
+again:
+	error = idr_get_new(&lpfc_hba_index, NULL, &phba->brd_no, layer);
+	if (error == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer) {
+			error = -ENOMEM;
+			goto out_put_host;
+		}
+		goto again;
+	}
 	if (error)
 		goto out_put_host;
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 3225d31..fe504be 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1617,6 +1617,7 @@ static int sd_probe(struct device *dev)
 	struct scsi_device *sdp = to_scsi_device(dev);
 	struct scsi_disk *sdkp;
 	struct gendisk *gd;
+	struct idr_layer *layer = NULL;
 	u32 index;
 	int error;
 
@@ -1636,13 +1637,19 @@ static int sd_probe(struct device *dev)
 	if (!gd)
 		goto out_free;
 
-	if (!idr_pre_get(&sd_index_idr, GFP_KERNEL))
-		goto out_put;
-
+again:
 	spin_lock(&sd_index_lock);
-	error = idr_get_new(&sd_index_idr, NULL, &index);
+	error = idr_get_new(&sd_index_idr, NULL, &index, layer);
 	spin_unlock(&sd_index_lock);
 
+	if (error == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer) {
+			error = -ENOMEM;
+			goto out_put;
+		}
+		goto again;
+	}
 	if (index >= SD_MAX_DISKS)
 		error = -EBUSY;
 	if (error)
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 22f7ccd..d03c3ba 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -198,25 +198,26 @@ struct v9fs_session_info *v9fs_inode2v9s
 
 int v9fs_get_idpool(struct v9fs_idpool *p)
 {
+	struct idr_layer *layer = NULL;
 	int i = 0;
 	int error;
 
 retry:
-	if (idr_pre_get(&p->pool, GFP_KERNEL) == 0)
-		return 0;
-
 	if (down_interruptible(&p->lock) == -EINTR) {
 		eprintk(KERN_WARNING, "Interrupted while locking\n");
 		return -1;
 	}
 
 	/* no need to store exactly p, we just need something non-null */
-	error = idr_get_new(&p->pool, p, &i);
+	error = idr_get_new(&p->pool, p, &i, layer);
 	up(&p->lock);
 
-	if (error == -EAGAIN)
+	if (error == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer)
+			return -1;
 		goto retry;
-	else if (error)
+	} else if (error)
 		return -1;
 
 	return i;
diff --git a/fs/inotify.c b/fs/inotify.c
index 723836a..7e12bed 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -131,12 +131,16 @@ EXPORT_SYMBOL_GPL(put_inotify_watch);
 static int inotify_handle_get_wd(struct inotify_handle *ih,
 				 struct inotify_watch *watch)
 {
+	struct idr_layer *layer = NULL;
 	int ret;
 
 	do {
-		if (unlikely(!idr_pre_get(&ih->idr, GFP_KERNEL)))
-			return -ENOSPC;
-		ret = idr_get_new_above(&ih->idr, watch, ih->last_wd+1, &watch->wd);
+		ret = idr_get_new_above(&ih->idr, watch, ih->last_wd+1, &watch->wd, layer);
+		if (ret == -EAGAIN) {
+			layer = idr_alloc_layer(GFP_KERNEL);
+			if (!layer)
+				ret = -ENOSPC;
+		}
 	} while (ret == -EAGAIN);
 
 	if (likely(!ret))
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index b650efa..f9d1b04 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -175,19 +175,21 @@ static u8 o2net_num_from_nn(struct o2net
 
 static int o2net_prep_nsw(struct o2net_node *nn, struct o2net_status_wait *nsw)
 {
+	struct idr_layer *layer = NULL;
 	int ret = 0;
 
 	do {
-		if (!idr_pre_get(&nn->nn_status_idr, GFP_ATOMIC)) {
-			ret = -EAGAIN;
-			break;
-		}
 		spin_lock(&nn->nn_lock);
-		ret = idr_get_new(&nn->nn_status_idr, nsw, &nsw->ns_id);
+		ret = idr_get_new(&nn->nn_status_idr, nsw, &nsw->ns_id, layer);
 		if (ret == 0)
 			list_add_tail(&nsw->ns_node_item,
 				      &nn->nn_status_list);
 		spin_unlock(&nn->nn_lock);
+		if (ret == -EAGAIN) {
+			layer = idr_alloc_layer(GFP_ATOMIC);
+			if (!layer)
+				ret = -ENOMEM;
+		}
 	} while (ret == -EAGAIN);
 
 	if (ret == 0)  {
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 4ba0300..60bdd42 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -318,19 +318,20 @@ #define PROC_DYNAMIC_FIRST 0xF0000000UL
  */
 static unsigned int get_inode_number(void)
 {
+	struct idr_layer *layer = NULL;
 	int i, inum = 0;
 	int error;
 
 retry:
-	if (idr_pre_get(&proc_inum_idr, GFP_KERNEL) == 0)
-		return 0;
-
 	spin_lock(&proc_inum_lock);
-	error = idr_get_new(&proc_inum_idr, NULL, &i);
+	error = idr_get_new(&proc_inum_idr, NULL, &i, layer);
 	spin_unlock(&proc_inum_lock);
-	if (error == -EAGAIN)
+	if (error == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (!layer)
+			return 0;
 		goto retry;
-	else if (error)
+	} else if (error)
 		return 0;
 
 	inum = (i & MAX_ID_MASK) + PROC_DYNAMIC_FIRST;
diff --git a/fs/super.c b/fs/super.c
index 6d4e817..67455f5 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -607,19 +607,20 @@ static DEFINE_SPINLOCK(unnamed_dev_lock)
 
 int set_anon_super(struct super_block *s, void *data)
 {
+	struct idr_layer *layer = NULL;
 	int dev;
 	int error;
 
  retry:
-	if (idr_pre_get(&unnamed_dev_idr, GFP_ATOMIC) == 0)
-		return -ENOMEM;
 	spin_lock(&unnamed_dev_lock);
-	error = idr_get_new(&unnamed_dev_idr, NULL, &dev);
+	error = idr_get_new(&unnamed_dev_idr, NULL, &dev, layer);
 	spin_unlock(&unnamed_dev_lock);
-	if (error == -EAGAIN)
-		/* We raced and lost with another CPU. */
+	if (error == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_ATOMIC);
+		if (!layer)
+			return -ENOMEM;
 		goto retry;
-	else if (error)
+	} else if (error)
 		return -EAGAIN;
 
 	if ((dev & MAX_ID_MASK) == (1 << MINORBITS)) {
diff --git a/include/linux/idr.h b/include/linux/idr.h
index 8268034..de34c4e 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -44,7 +44,7 @@ #define MAX_ID_MASK (MAX_ID_BIT - 1)
 #define MAX_LEVEL (MAX_ID_SHIFT + IDR_BITS - 1) / IDR_BITS
 
 /* Number of id_layer structs to leave in free list */
-#define IDR_FREE_MAX MAX_LEVEL + MAX_LEVEL
+#define IDR_FREE_MAX (MAX_LEVEL + MAX_LEVEL)
 
 struct idr_layer {
 	unsigned long		 bitmap; /* A zero bit means "space here" */
@@ -57,7 +57,6 @@ struct idr {
 	struct idr_layer *id_free;
 	int		  layers;
 	int		  id_free_cnt;
-	spinlock_t	  lock;
 };
 
 #define IDR_INIT(name)						\
@@ -66,7 +65,6 @@ #define IDR_INIT(name)						\
 	.id_free	= NULL,					\
 	.layers 	= 0,					\
 	.id_free_cnt	= 0,					\
-	.lock		= __SPIN_LOCK_UNLOCKED(name.lock),	\
 }
 #define DEFINE_IDR(name)	struct idr name = IDR_INIT(name)
 
@@ -75,9 +73,10 @@ #define DEFINE_IDR(name)	struct idr name
  */
 
 void *idr_find(struct idr *idp, int id);
-int idr_pre_get(struct idr *idp, gfp_t gfp_mask);
-int idr_get_new(struct idr *idp, void *ptr, int *id);
-int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
+struct idr_layer *idr_alloc_layer(gfp_t gfp_mask);
+int idr_get_new(struct idr *idp, void *ptr, int *id, struct idr_layer *layer);
+int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id,
+		      struct idr_layer *layer);
 void *idr_replace(struct idr *idp, void *ptr, int id);
 void idr_remove(struct idr *idp, int id);
 void idr_destroy(struct idr *idp);
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index ac6dc87..18891b2 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -434,6 +434,7 @@ sys_timer_create(const clockid_t which_c
 		 struct sigevent __user *timer_event_spec,
 		 timer_t __user * created_timer_id)
 {
+	struct idr_layer *layer = NULL;
 	int error = 0;
 	struct k_itimer *new_timer = NULL;
 	int new_timer_id;
@@ -451,17 +452,16 @@ sys_timer_create(const clockid_t which_c
 
 	spin_lock_init(&new_timer->it_lock);
  retry:
-	if (unlikely(!idr_pre_get(&posix_timers_id, GFP_KERNEL))) {
-		error = -EAGAIN;
-		goto out;
-	}
 	spin_lock_irq(&idr_lock);
 	error = idr_get_new(&posix_timers_id, (void *) new_timer,
-			    &new_timer_id);
+			    &new_timer_id, layer);
 	spin_unlock_irq(&idr_lock);
-	if (error == -EAGAIN)
-		goto retry;
-	else if (error) {
+	if (error == -EAGAIN) {
+		layer = idr_alloc_layer(GFP_KERNEL);
+		if (layer)
+			goto retry;
+	}
+	if (error) {
 		/*
 		 * Wierd looking, but we return EAGAIN if the IDR is
 		 * full (proper POSIX return value for this)
diff --git a/lib/idr.c b/lib/idr.c
index 16d2143..187ce4d 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -35,65 +35,39 @@ #include <linux/idr.h>
 
 static kmem_cache_t *idr_layer_cache;
 
-static struct idr_layer *alloc_layer(struct idr *idp)
+static struct idr_layer *get_layer(struct idr *idp)
 {
 	struct idr_layer *p;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idp->lock, flags);
-	if ((p = idp->id_free)) {
+	p = idp->id_free;
+	if (p) {
 		idp->id_free = p->ary[0];
 		idp->id_free_cnt--;
 		p->ary[0] = NULL;
 	}
-	spin_unlock_irqrestore(&idp->lock, flags);
-	return(p);
-}
 
-/* only called when idp->lock is held */
-static void __free_layer(struct idr *idp, struct idr_layer *p)
-{
-	p->ary[0] = idp->id_free;
-	idp->id_free = p;
-	idp->id_free_cnt++;
+	return p;
 }
 
 static void free_layer(struct idr *idp, struct idr_layer *p)
 {
-	unsigned long flags;
-
-	/*
-	 * Depends on the return element being zeroed.
-	 */
-	spin_lock_irqsave(&idp->lock, flags);
-	__free_layer(idp, p);
-	spin_unlock_irqrestore(&idp->lock, flags);
+	if (idp->id_free_cnt < IDR_FREE_MAX) {
+		p->ary[0] = idp->id_free;
+		idp->id_free = p;
+		idp->id_free_cnt++;
+	} else
+		kmem_cache_free(idr_layer_cache, p);
 }
 
 /**
- * idr_pre_get - reserver resources for idr allocation
- * @idp:	idr handle
+ * idr_alloc_layer - reserve resources for idr allocation
  * @gfp_mask:	memory allocation flags
- *
- * This function should be called prior to locking and calling the
- * following function.  It preallocates enough memory to satisfy
- * the worst possible allocation.
- *
- * If the system is REALLY out of memory this function returns 0,
- * otherwise 1.
  */
-int idr_pre_get(struct idr *idp, gfp_t gfp_mask)
+struct idr_layer *idr_alloc_layer(gfp_t gfp_mask)
 {
-	while (idp->id_free_cnt < IDR_FREE_MAX) {
-		struct idr_layer *new;
-		new = kmem_cache_alloc(idr_layer_cache, gfp_mask);
-		if (new == NULL)
-			return (0);
-		free_layer(idp, new);
-	}
-	return 1;
+	return kmem_cache_zalloc(idr_layer_cache, gfp_mask);
 }
-EXPORT_SYMBOL(idr_pre_get);
+EXPORT_SYMBOL(idr_alloc_layer);
 
 static int sub_alloc(struct idr *idp, void *ptr, int *starting_id)
 {
@@ -136,7 +110,7 @@ static int sub_alloc(struct idr *idp, vo
 		 * Create the layer below if it is missing.
 		 */
 		if (!p->ary[m]) {
-			if (!(new = alloc_layer(idp)))
+			if (!(new = get_layer(idp)))
 				return -1;
 			p->ary[m] = new;
 			p->count++;
@@ -171,14 +145,13 @@ static int idr_get_new_above_int(struct 
 {
 	struct idr_layer *p, *new;
 	int layers, v, id;
-	unsigned long flags;
 
 	id = starting_id;
 build_up:
 	p = idp->top;
 	layers = idp->layers;
 	if (unlikely(!p)) {
-		if (!(p = alloc_layer(idp)))
+		if (!(p = get_layer(idp)))
 			return -1;
 		layers = 1;
 	}
@@ -190,19 +163,17 @@ build_up:
 		layers++;
 		if (!p->count)
 			continue;
-		if (!(new = alloc_layer(idp))) {
+		if (!(new = get_layer(idp))) {
 			/*
 			 * The allocation failed.  If we built part of
 			 * the structure tear it down.
 			 */
-			spin_lock_irqsave(&idp->lock, flags);
 			for (new = p; p && p != idp->top; new = p) {
 				p = p->ary[0];
 				new->ary[0] = NULL;
 				new->bitmap = new->count = 0;
-				__free_layer(idp, new);
+				free_layer(idp, new);
 			}
-			spin_unlock_irqrestore(&idp->lock, flags);
 			return -1;
 		}
 		new->ary[0] = p;
@@ -216,7 +187,7 @@ build_up:
 	v = sub_alloc(idp, ptr, &id);
 	if (v == -2)
 		goto build_up;
-	return(v);
+	return v;
 }
 
 /**
@@ -225,20 +196,25 @@ build_up:
  * @ptr: pointer you want associated with the ide
  * @start_id: id to start search at
  * @id: pointer to the allocated handle
+ * @layer: pointer to extra storage
  *
  * This is the allocate id function.  It should be called with any
  * required locks.
  *
  * If memory is required, it will return -EAGAIN, you should unlock
- * and go back to the idr_pre_get() call.  If the idr is full, it will
- * return -ENOSPC.
+ * and call idr_alloc_layer() to get a new layer to pass in as the
+ * @layer parameter.  If the idr is full, it will return -ENOSPC.
  *
  * @id returns a value in the range 0 ... 0x7fffffff
  */
-int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id)
+int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id,
+		      struct idr_layer *layer)
 {
 	int rv;
 
+	if (layer)
+		free_layer(idp, layer);
+
 	rv = idr_get_new_above_int(idp, ptr, starting_id);
 	/*
 	 * This is a cheap hack until the IDR code can be fixed to
@@ -260,33 +236,20 @@ EXPORT_SYMBOL(idr_get_new_above);
  * @idp: idr handle
  * @ptr: pointer you want associated with the ide
  * @id: pointer to the allocated handle
+ * @layer: pointer to extra storage
  *
  * This is the allocate id function.  It should be called with any
  * required locks.
  *
  * If memory is required, it will return -EAGAIN, you should unlock
- * and go back to the idr_pre_get() call.  If the idr is full, it will
- * return -ENOSPC.
+ * and call idr_alloc_layer() to get a new layer to pass in as the
+ * @layer parameter.  If the idr is full, it will return -ENOSPC.
  *
  * @id returns a value in the range 0 ... 0x7fffffff
  */
-int idr_get_new(struct idr *idp, void *ptr, int *id)
+int idr_get_new(struct idr *idp, void *ptr, int *id, struct idr_layer *layer)
 {
-	int rv;
-
-	rv = idr_get_new_above_int(idp, ptr, 0);
-	/*
-	 * This is a cheap hack until the IDR code can be fixed to
-	 * return proper error values.
-	 */
-	if (rv < 0) {
-		if (rv == -1)
-			return -EAGAIN;
-		else /* Will be -3 */
-			return -ENOSPC;
-	}
-	*id = rv;
-	return 0;
+	return idr_get_new_above(idp, ptr, 0, id, layer);
 }
 EXPORT_SYMBOL(idr_get_new);
 
@@ -349,11 +312,6 @@ void idr_remove(struct idr *idp, int id)
 		idp->top = p;
 		--idp->layers;
 	}
-	while (idp->id_free_cnt >= IDR_FREE_MAX) {
-		p = alloc_layer(idp);
-		kmem_cache_free(idr_layer_cache, p);
-		return;
-	}
 }
 EXPORT_SYMBOL(idr_remove);
 
@@ -364,7 +322,7 @@ EXPORT_SYMBOL(idr_remove);
 void idr_destroy(struct idr *idp)
 {
 	while (idp->id_free_cnt) {
-		struct idr_layer *p = alloc_layer(idp);
+		struct idr_layer *p = get_layer(idp);
 		kmem_cache_free(idr_layer_cache, p);
 	}
 }
@@ -445,17 +403,11 @@ void *idr_replace(struct idr *idp, void 
 }
 EXPORT_SYMBOL(idr_replace);
 
-static void idr_cache_ctor(void * idr_layer, kmem_cache_t *idr_layer_cache,
-		unsigned long flags)
-{
-	memset(idr_layer, 0, sizeof(struct idr_layer));
-}
-
 static  int init_id_cache(void)
 {
 	if (!idr_layer_cache)
 		idr_layer_cache = kmem_cache_create("idr_layer_cache",
-			sizeof(struct idr_layer), 0, 0, idr_cache_ctor, NULL);
+			sizeof(struct idr_layer), 0, 0, NULL, NULL);
 	return 0;
 }
 
@@ -470,6 +422,5 @@ void idr_init(struct idr *idp)
 {
 	init_id_cache();
 	memset(idp, 0, sizeof(struct idr));
-	spin_lock_init(&idp->lock);
 }
 EXPORT_SYMBOL(idr_init);
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 2a87736..fc712c4 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1928,6 +1928,7 @@ int sctp_process_init(struct sctp_associ
  	 * association.
 	 */
 	if (!asoc->temp) {
+		struct idr_layer *layer = NULL;
 		int assoc_id;
 		int error;
 
@@ -1937,15 +1938,16 @@ int sctp_process_init(struct sctp_associ
 			goto clean_up;
 
 	retry:
-		if (unlikely(!idr_pre_get(&sctp_assocs_id, gfp)))
-			goto clean_up;
 		spin_lock_bh(&sctp_assocs_id_lock);
 		error = idr_get_new_above(&sctp_assocs_id, (void *)asoc, 1,
-					  &assoc_id);
+					  &assoc_id, layer);
 		spin_unlock_bh(&sctp_assocs_id_lock);
-		if (error == -EAGAIN)
-			goto retry;
-		else if (error)
+		if (error == -EAGAIN) {
+			layer = idr_alloc_layer(gfp);
+			if (layer)
+				goto retry;
+		}
+		if (error)
 			goto clean_up;
 
 		asoc->assoc_id = (sctp_assoc_t) assoc_id;
