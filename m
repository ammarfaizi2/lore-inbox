Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWA3VYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWA3VYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030180AbWA3VYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:24:41 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:3259 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030182AbWA3VYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:24:16 -0500
Subject: [patch 8/8] mempool - Use mempool_create_slab_pool()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060130211951.225129000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 30 Jan 2006 13:24:10 -0800
Message-Id: <1138656250.20704.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment
(mempool-use_mempool_create_slab_pool.patch)
Modify well over a dozen mempool users to call mempool_create_slab_pool()
rather than calling mempool_create() with extra arguments, saving about
30 lines of code and increasing readability.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 block/cfq-iosched.c             |    2 +-
 drivers/block/aoe/aoeblk.c      |    4 +---
 drivers/md/dm-crypt.c           |    3 +--
 drivers/md/dm-mpath.c           |    3 +--
 drivers/md/dm-snap.c            |    3 +--
 drivers/md/dm.c                 |    6 ++----
 drivers/md/kcopyd.c             |    3 +--
 drivers/message/i2o/i2o_block.c |    7 +++----
 drivers/scsi/iscsi_tcp.c        |    4 ++--
 drivers/scsi/qla2xxx/qla_os.c   |    3 +--
 drivers/scsi/scsi_lib.c         |    5 ++---
 fs/bio.c                        |    6 ++----
 fs/cifs/cifsfs.c                |   18 ++++++------------
 fs/jfs/jfs_metapage.c           |    4 ++--
 fs/nfs/read.c                   |    6 ++----
 fs/nfs/write.c                  |   12 ++++--------
 fs/xfs/linux-2.6/xfs_super.c    |    5 ++---
 include/linux/i2o.h             |    4 +---
 net/sunrpc/sched.c              |   12 ++++--------
 19 files changed, 39 insertions(+), 71 deletions(-)

Index: linux-2.6.16-rc1-mm4+mempool_work/block/cfq-iosched.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/block/cfq-iosched.c
+++ linux-2.6.16-rc1-mm4+mempool_work/block/cfq-iosched.c
@@ -2179,7 +2179,7 @@ static int cfq_init_queue(request_queue_
 	if (!cfqd->cfq_hash)
 		goto out_cfqhash;
 
-	cfqd->crq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, crq_pool);
+	cfqd->crq_pool = mempool_create_slab_pool(BLKDEV_MIN_RQ, crq_pool);
 	if (!cfqd->crq_pool)
 		goto out_crqpool;
 
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/block/aoe/aoeblk.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/block/aoe/aoeblk.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/block/aoe/aoeblk.c
@@ -211,9 +211,7 @@ aoeblk_gdalloc(void *vp)
 		return;
 	}
 
-	d->bufpool = mempool_create(MIN_BUFS,
-				    mempool_alloc_slab, mempool_free_slab,
-				    buf_pool_cache);
+	d->bufpool = mempool_create_slab_pool(MIN_BUFS, buf_pool_cache);
 	if (d->bufpool == NULL) {
 		printk(KERN_ERR "aoe: aoeblk_gdalloc: cannot allocate bufpool "
 			"for %ld.%ld\n", d->aoemajor, d->aoeminor);
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/md/dm-crypt.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-crypt.c
@@ -616,8 +616,7 @@ static int crypt_ctr(struct dm_target *t
 		}
 	}
 
-	cc->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
-				     mempool_free_slab, _crypt_io_pool);
+	cc->io_pool = mempool_create_slab_pool(MIN_IOS, _crypt_io_pool);
 	if (!cc->io_pool) {
 		ti->error = PFX "Cannot allocate crypt io mempool";
 		goto bad3;
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/md/dm-mpath.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-mpath.c
@@ -179,8 +179,7 @@ static struct multipath *alloc_multipath
 		m->queue_io = 1;
 		INIT_WORK(&m->process_queued_ios, process_queued_ios, m);
 		INIT_WORK(&m->trigger_event, trigger_event, m);
-		m->mpio_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
-					      mempool_free_slab, _mpio_cache);
+		m->mpio_pool = mempool_create_slab_pool(MIN_IOS, _mpio_cache);
 		if (!m->mpio_pool) {
 			kfree(m);
 			return NULL;
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/md/dm-snap.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-snap.c
@@ -1258,8 +1258,7 @@ static int __init dm_snapshot_init(void)
 		goto bad4;
 	}
 
-	pending_pool = mempool_create(128, mempool_alloc_slab,
-				      mempool_free_slab, pending_cache);
+	pending_pool = mempool_create_slab_pool(128, pending_cache);
 	if (!pending_pool) {
 		DMERR("Couldn't create pending pool.");
 		r = -ENOMEM;
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/md/dm.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm.c
@@ -819,13 +819,11 @@ static struct mapped_device *alloc_dev(u
 	md->queue->unplug_fn = dm_unplug_all;
 	md->queue->issue_flush_fn = dm_flush_all;
 
-	md->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
-				     mempool_free_slab, _io_cache);
+	md->io_pool = mempool_create_slab_pool(MIN_IOS, _io_cache);
  	if (!md->io_pool)
  		goto bad2;
 
-	md->tio_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
-				      mempool_free_slab, _tio_cache);
+	md->tio_pool = mempool_create_slab_pool(MIN_IOS, _tio_cache);
 	if (!md->tio_pool)
 		goto bad3;
 
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/md/kcopyd.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/md/kcopyd.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/md/kcopyd.c
@@ -228,8 +228,7 @@ static int jobs_init(void)
 	if (!_job_cache)
 		return -ENOMEM;
 
-	_job_pool = mempool_create(MIN_JOBS, mempool_alloc_slab,
-				   mempool_free_slab, _job_cache);
+	_job_pool = mempool_create_slab_pool(MIN_JOBS, _job_cache);
 	if (!_job_pool) {
 		kmem_cache_destroy(_job_cache);
 		return -ENOMEM;
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/message/i2o/i2o_block.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/message/i2o/i2o_block.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/message/i2o/i2o_block.c
@@ -1179,10 +1179,9 @@ static int __init i2o_block_init(void)
 		goto exit;
 	}
 
-	i2o_blk_req_pool.pool = mempool_create(I2O_BLOCK_REQ_MEMPOOL_SIZE,
-					       mempool_alloc_slab,
-					       mempool_free_slab,
-					       i2o_blk_req_pool.slab);
+	i2o_blk_req_pool.pool =
+		mempool_create_slab_pool(I2O_BLOCK_REQ_MEMPOOL_SIZE,
+					 i2o_blk_req_pool.slab);
 	if (!i2o_blk_req_pool.pool) {
 		osm_err("can't init request mempool\n");
 		rc = -ENOMEM;
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/scsi/iscsi_tcp.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/scsi/iscsi_tcp.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/scsi/iscsi_tcp.c
@@ -3201,8 +3201,8 @@ iscsi_r2tpool_alloc(struct iscsi_session
 		 * Data-Out PDU's within R2T-sequence can be quite big;
 		 * using mempool
 		 */
-		ctask->datapool = mempool_create(ISCSI_DTASK_DEFAULT_MAX,
-			 mempool_alloc_slab, mempool_free_slab, taskcache);
+		ctask->datapool = mempool_create_slab_pool(ISCSI_DTASK_DEFAULT_MAX,
+							   taskcache);
 		if (ctask->datapool == NULL) {
 			kfifo_free(ctask->r2tqueue);
 			iscsi_pool_free(&ctask->r2tpool, (void**)ctask->r2ts);
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/scsi/qla2xxx/qla_os.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/scsi/qla2xxx/qla_os.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/scsi/qla2xxx/qla_os.c
@@ -2087,8 +2087,7 @@ qla2x00_allocate_sp_pool(scsi_qla_host_t
 	int      rval;
 
 	rval = QLA_SUCCESS;
-	ha->srb_mempool = mempool_create(SRB_MIN_REQ, mempool_alloc_slab,
-	    mempool_free_slab, srb_cachep);
+	ha->srb_mempool = mempool_create_slab_pool(SRB_MIN_REQ, srb_cachep);
 	if (ha->srb_mempool == NULL) {
 		qla_printk(KERN_INFO, ha, "Unable to allocate SRB mempool.\n");
 		rval = QLA_FUNCTION_FAILED;
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/scsi/scsi_lib.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/scsi/scsi_lib.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/scsi/scsi_lib.c
@@ -1787,9 +1787,8 @@ int __init scsi_init_queue(void)
 					sgp->name);
 		}
 
-		sgp->pool = mempool_create(SG_MEMPOOL_SIZE,
-				mempool_alloc_slab, mempool_free_slab,
-				sgp->slab);
+		sgp->pool = mempool_create_slab_pool(SG_MEMPOOL_SIZE,
+						     sgp->slab);
 		if (!sgp->pool) {
 			printk(KERN_ERR "SCSI: can't init sg mempool %s\n",
 					sgp->name);
Index: linux-2.6.16-rc1-mm4+mempool_work/fs/bio.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/fs/bio.c
+++ linux-2.6.16-rc1-mm4+mempool_work/fs/bio.c
@@ -1143,8 +1143,7 @@ static int biovec_create_pools(struct bi
 		if (i >= scale)
 			pool_entries >>= 1;
 
-		*bvp = mempool_create(pool_entries, mempool_alloc_slab,
-					mempool_free_slab, bp->slab);
+		*bvp = mempool_create_slab_pool(pool_entries, bp->slab);
 		if (!*bvp)
 			return -ENOMEM;
 	}
@@ -1182,8 +1181,7 @@ struct bio_set *bioset_create(int bio_po
 		return NULL;
 
 	memset(bs, 0, sizeof(*bs));
-	bs->bio_pool = mempool_create(bio_pool_size, mempool_alloc_slab,
-			mempool_free_slab, bio_slab);
+	bs->bio_pool = mempool_create_slab_pool(bio_pool_size, bio_slab);
 
 	if (!bs->bio_pool)
 		goto bad;
Index: linux-2.6.16-rc1-mm4+mempool_work/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/fs/cifs/cifsfs.c
+++ linux-2.6.16-rc1-mm4+mempool_work/fs/cifs/cifsfs.c
@@ -737,10 +737,8 @@ cifs_init_request_bufs(void)
 		cERROR(1,("cifs_min_rcv set to maximum (64)"));
 	}
 
-	cifs_req_poolp = mempool_create(cifs_min_rcv,
-					mempool_alloc_slab,
-					mempool_free_slab,
-					cifs_req_cachep);
+	cifs_req_poolp = mempool_create_slab_pool(cifs_min_rcv,
+						  cifs_req_cachep);
 
 	if(cifs_req_poolp == NULL) {
 		kmem_cache_destroy(cifs_req_cachep);
@@ -770,10 +768,8 @@ cifs_init_request_bufs(void)
 		cFYI(1,("cifs_min_small set to maximum (256)"));
 	}
 
-	cifs_sm_req_poolp = mempool_create(cifs_min_small,
-				mempool_alloc_slab,
-				mempool_free_slab,
-				cifs_sm_req_cachep);
+	cifs_sm_req_poolp = mempool_create_slab_pool(cifs_min_small,
+						     cifs_sm_req_cachep);
 
 	if(cifs_sm_req_poolp == NULL) {
 		mempool_destroy(cifs_req_poolp);
@@ -807,10 +803,8 @@ cifs_init_mids(void)
 	if (cifs_mid_cachep == NULL)
 		return -ENOMEM;
 
-	cifs_mid_poolp = mempool_create(3 /* a reasonable min simultan opers */,
-					mempool_alloc_slab,
-					mempool_free_slab,
-					cifs_mid_cachep);
+	/* 3 is a reasonable minimum number of simultaneous operations */
+	cifs_mid_poolp = mempool_create_slab_pool(3, cifs_mid_cachep);
 	if(cifs_mid_poolp == NULL) {
 		kmem_cache_destroy(cifs_mid_cachep);
 		return -ENOMEM;
Index: linux-2.6.16-rc1-mm4+mempool_work/fs/jfs/jfs_metapage.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/fs/jfs/jfs_metapage.c
+++ linux-2.6.16-rc1-mm4+mempool_work/fs/jfs/jfs_metapage.c
@@ -221,8 +221,8 @@ int __init metapage_init(void)
 	if (metapage_cache == NULL)
 		return -ENOMEM;
 
-	metapage_mempool = mempool_create(METAPOOL_MIN_PAGES, mempool_alloc_slab,
-					  mempool_free_slab, metapage_cache);
+	metapage_mempool = mempool_create_slab_pool(METAPOOL_MIN_PAGES,
+						    metapage_cache);
 
 	if (metapage_mempool == NULL) {
 		kmem_cache_destroy(metapage_cache);
Index: linux-2.6.16-rc1-mm4+mempool_work/fs/nfs/read.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/fs/nfs/read.c
+++ linux-2.6.16-rc1-mm4+mempool_work/fs/nfs/read.c
@@ -597,10 +597,8 @@ int nfs_init_readpagecache(void)
 	if (nfs_rdata_cachep == NULL)
 		return -ENOMEM;
 
-	nfs_rdata_mempool = mempool_create(MIN_POOL_READ,
-					   mempool_alloc_slab,
-					   mempool_free_slab,
-					   nfs_rdata_cachep);
+	nfs_rdata_mempool = mempool_create_slab_pool(MIN_POOL_READ,
+						     nfs_rdata_cachep);
 	if (nfs_rdata_mempool == NULL)
 		return -ENOMEM;
 
Index: linux-2.6.16-rc1-mm4+mempool_work/fs/nfs/write.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/fs/nfs/write.c
+++ linux-2.6.16-rc1-mm4+mempool_work/fs/nfs/write.c
@@ -1407,17 +1407,13 @@ int nfs_init_writepagecache(void)
 	if (nfs_wdata_cachep == NULL)
 		return -ENOMEM;
 
-	nfs_wdata_mempool = mempool_create(MIN_POOL_WRITE,
-					   mempool_alloc_slab,
-					   mempool_free_slab,
-					   nfs_wdata_cachep);
+	nfs_wdata_mempool = mempool_create_slab_pool(MIN_POOL_WRITE,
+						     nfs_wdata_cachep);
 	if (nfs_wdata_mempool == NULL)
 		return -ENOMEM;
 
-	nfs_commit_mempool = mempool_create(MIN_POOL_COMMIT,
-					   mempool_alloc_slab,
-					   mempool_free_slab,
-					   nfs_wdata_cachep);
+	nfs_commit_mempool = mempool_create_slab_pool(MIN_POOL_COMMIT,
+						      nfs_wdata_cachep);
 	if (nfs_commit_mempool == NULL)
 		return -ENOMEM;
 
Index: linux-2.6.16-rc1-mm4+mempool_work/fs/xfs/linux-2.6/xfs_super.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/fs/xfs/linux-2.6/xfs_super.c
+++ linux-2.6.16-rc1-mm4+mempool_work/fs/xfs/linux-2.6/xfs_super.c
@@ -376,9 +376,8 @@ linvfs_init_zones(void)
 	if (!xfs_ioend_zone)
 		goto out_destroy_vnode_zone;
 
-	xfs_ioend_pool = mempool_create(4 * MAX_BUF_PER_PAGE,
-			mempool_alloc_slab, mempool_free_slab,
-			xfs_ioend_zone);
+	xfs_ioend_pool = mempool_create_slab_pool(4 * MAX_BUF_PER_PAGE,
+						  xfs_ioend_zone);
 	if (!xfs_ioend_pool)
 		goto out_free_ioend_zone;
 
Index: linux-2.6.16-rc1-mm4+mempool_work/include/linux/i2o.h
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/include/linux/i2o.h
+++ linux-2.6.16-rc1-mm4+mempool_work/include/linux/i2o.h
@@ -950,9 +950,7 @@ static inline int i2o_pool_alloc(struct 
 	if (!pool->slab)
 		goto free_name;
 
-	pool->mempool =
-	    mempool_create(min_nr, mempool_alloc_slab, mempool_free_slab,
-			   pool->slab);
+	pool->mempool = mempool_create_slab_pool(min_nr, pool->slab);
 	if (!pool->mempool)
 		goto free_slab;
 
Index: linux-2.6.16-rc1-mm4+mempool_work/net/sunrpc/sched.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/net/sunrpc/sched.c
+++ linux-2.6.16-rc1-mm4+mempool_work/net/sunrpc/sched.c
@@ -1162,16 +1162,12 @@ rpc_init_mempool(void)
 					     NULL, NULL);
 	if (!rpc_buffer_slabp)
 		goto err_nomem;
-	rpc_task_mempool = mempool_create(RPC_TASK_POOLSIZE,
-					    mempool_alloc_slab,
-					    mempool_free_slab,
-					    rpc_task_slabp);
+	rpc_task_mempool = mempool_create_slab_pool(RPC_TASK_POOLSIZE,
+						    rpc_task_slabp);
 	if (!rpc_task_mempool)
 		goto err_nomem;
-	rpc_buffer_mempool = mempool_create(RPC_BUFFER_POOLSIZE,
-					    mempool_alloc_slab,
-					    mempool_free_slab,
-					    rpc_buffer_slabp);
+	rpc_buffer_mempool = mempool_create_slab_pool(RPC_BUFFER_POOLSIZE,
+						      rpc_buffer_slabp);
 	if (!rpc_buffer_mempool)
 		goto err_nomem;
 	return 0;

--

