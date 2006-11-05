Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWKEUoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWKEUoq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWKEUoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:44:46 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:18081 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1422634AbWKEUoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:44:44 -0500
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block in 64k page mode
Date: Sun, 5 Nov 2006 21:40:38 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GxkTFb9TlYxTAq7"
Message-Id: <200611052140.38445.hnguyen@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GxkTFb9TlYxTAq7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Roland!
This is a patch of ehca that assures 4k alignment for firmware control block
in 64k page mode, because kzalloc()'s result address might not be 4k aligned 
if kernel's 64k page is enabled. Thus, we introduced wrappers called
ehca_alloc/free_fw_ctrlblock(), which use a slab cache for objects with
4k length and 4k alignment in order to alloc/free firmware control blocks
in 64k page mode. In 4k page mode those wrappers just are defines of
get_zeroed_page() and free_page().
Thanks!
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_hca.c    |   17 ++++++++-------
 ehca_irq.c    |   17 +++++++--------
 ehca_iverbs.h |    8 +++++++
 ehca_main.c   |   62 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 ehca_mrmw.c   |    8 +++----
 ehca_qp.c     |   12 ++++++-----
 6 files changed, 89 insertions(+), 35 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index 5eae6ac..f77e626 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -40,6 +40,7 @@
  */
 
 #include "ehca_tools.h"
+#include "ehca_iverbs.h"
 #include "hcp_if.h"
 
 int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
@@ -49,7 +50,7 @@ int ehca_query_device(struct ib_device *
            ib_device);
  struct hipz_query_hca *rblock;
 
- rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+ rblock = (struct hipz_query_hca*)ehca_alloc_fw_ctrlblock();
  if (!rblock) {
   ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
   return -ENOMEM;
@@ -96,7 +97,7 @@ int ehca_query_device(struct ib_device *
   = min_t(int, rblock->max_total_mcast_qp_attach, INT_MAX);
 
 query_device1:
- kfree(rblock);
+ ehca_free_fw_ctrlblock(rblock);
 
  return ret;
 }
@@ -109,7 +110,7 @@ int ehca_query_port(struct ib_device *ib
            ib_device);
  struct hipz_query_port *rblock;
 
- rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+ rblock = (struct hipz_query_port*)ehca_alloc_fw_ctrlblock();
  if (!rblock) {
   ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
   return -ENOMEM;
@@ -162,7 +163,7 @@ int ehca_query_port(struct ib_device *ib
  props->active_speed    = 0x1;
 
 query_port1:
- kfree(rblock);
+ ehca_free_fw_ctrlblock(rblock);
 
  return ret;
 }
@@ -178,7 +179,7 @@ int ehca_query_pkey(struct ib_device *ib
   return -EINVAL;
  }
 
- rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+ rblock = (struct hipz_query_port*)ehca_alloc_fw_ctrlblock();
  if (!rblock) {
   ehca_err(&shca->ib_device,  "Can't allocate rblock memory.");
   return -ENOMEM;
@@ -193,7 +194,7 @@ int ehca_query_pkey(struct ib_device *ib
  memcpy(pkey, &rblock->pkey_entries + index, sizeof(u16));
 
 query_pkey1:
- kfree(rblock);
+ ehca_free_fw_ctrlblock(rblock);
 
  return ret;
 }
@@ -211,7 +212,7 @@ int ehca_query_gid(struct ib_device *ibd
   return -EINVAL;
  }
 
- rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+ rblock = (struct hipz_query_port*)ehca_alloc_fw_ctrlblock();
  if (!rblock) {
   ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
   return -ENOMEM;
@@ -227,7 +228,7 @@ int ehca_query_gid(struct ib_device *ibd
  memcpy(&gid->raw[8], &rblock->guid_entries[index], sizeof(u64));
 
 query_gid1:
- kfree(rblock);
+ ehca_free_fw_ctrlblock(rblock);
 
  return ret;
 }
diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index 048cc44..01b66d7 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -45,6 +45,7 @@ #include "ehca_iverbs.h"
 #include "ehca_tools.h"
 #include "hcp_if.h"
 #include "hipz_fns.h"
+#include "ipz_pt_fn.h"
 
 #define EQE_COMPLETION_EVENT   EHCA_BMASK_IBM(1,1)
 #define EQE_CQ_QP_NUMBER       EHCA_BMASK_IBM(8,31)
@@ -137,38 +138,36 @@ int ehca_error_data(struct ehca_shca *sh
  u64 *rblock;
  unsigned long block_count;
 
- rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+ rblock = (u64*)ehca_alloc_fw_ctrlblock();
  if (!rblock) {
   ehca_err(&shca->ib_device, "Cannot allocate rblock memory.");
   ret = -ENOMEM;
   goto error_data1;
  }
 
+ /* rblock must be 4K aligned and should be 4K large */
  ret = hipz_h_error_data(shca->ipz_hca_handle,
     resource,
     rblock,
     &block_count);
 
- if (ret == H_R_STATE) {
+ if (ret == H_R_STATE)
   ehca_err(&shca->ib_device,
     "No error data is available: %lx.", resource);
- }
  else if (ret == H_SUCCESS) {
   int length;
 
   length = EHCA_BMASK_GET(ERROR_DATA_LENGTH, rblock[0]);
 
-  if (length > PAGE_SIZE)
-   length = PAGE_SIZE;
+  if (length > EHCA_PAGESIZE)
+   length = EHCA_PAGESIZE;
 
   print_error_data(shca, data, rblock, length);
- }
- else {
+ } else
   ehca_err(&shca->ib_device,
     "Error data could not be fetched: %lx", resource);
- }
 
- kfree(rblock);
+ ehca_free_fw_ctrlblock(rblock);
 
 error_data1:
  return ret;
diff --git a/drivers/infiniband/hw/ehca/ehca_iverbs.h b/drivers/infiniband/hw/ehca/ehca_iverbs.h
index 319c39d..73e5f3f 100644
--- a/drivers/infiniband/hw/ehca/ehca_iverbs.h
+++ b/drivers/infiniband/hw/ehca/ehca_iverbs.h
@@ -179,4 +179,12 @@ int ehca_mmap_register(u64 physical,void
 
 int ehca_munmap(unsigned long addr, size_t len);
 
+#ifdef CONFIG_PPC_64K_PAGES
+void *ehca_alloc_fw_ctrlblock(void);
+void ehca_free_fw_ctrlblock(void *ptr);
+#else
+#define ehca_alloc_fw_ctrlblock() get_zeroed_page(GFP_KERNEL)
+#define ehca_free_fw_ctrlblock(ptr) free_page((unsigned long)(ptr))
+#endif
+
 #endif
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 024d511..d66d66b 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -40,6 +40,9 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 
+#ifdef CONFIG_PPC_64K_PAGES
+#include <linux/slab.h>
+#endif
 #include "ehca_classes.h"
 #include "ehca_iverbs.h"
 #include "ehca_mrmw.h"
@@ -49,7 +52,7 @@ #include "hcp_if.h"
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0017");
+MODULE_VERSION("SVNEHCA_0018");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -94,11 +97,37 @@ spinlock_t ehca_cq_idr_lock;
 DEFINE_IDR(ehca_qp_idr);
 DEFINE_IDR(ehca_cq_idr);
 
+
 static struct list_head shca_list; /* list of all registered ehcas */
 static spinlock_t shca_list_lock;
 
 static struct timer_list poll_eqs_timer;
 
+#ifdef CONFIG_PPC_64K_PAGES
+static struct kmem_cache *ctblk_cache = NULL;
+
+/* constructor ctblk_cache */
+void ehca_ctblk_ctor(void *ptr, kmem_cache_t *cache, unsigned long flags)
+{
+ memset(ptr, 0, EHCA_PAGESIZE);
+}
+
+void *ehca_alloc_fw_ctrlblock(void)
+{
+ void *ret = kmem_cache_alloc(ctblk_cache, SLAB_KERNEL);
+ if (!ret)
+  ehca_gen_err("Out of memory for ctblk");
+ return ret;
+}
+
+void ehca_free_fw_ctrlblock(void *ptr)
+{
+ if (ptr)
+  kmem_cache_free(ctblk_cache, ptr);
+
+}
+#endif
+
 static int ehca_create_slab_caches(void)
 {
  int ret;
@@ -133,6 +162,17 @@ static int ehca_create_slab_caches(void)
   goto create_slab_caches5;
  }
 
+#ifdef CONFIG_PPC_64K_PAGES
+ ctblk_cache = kmem_cache_create("ehca_cache_ctblk",
+     EHCA_PAGESIZE, H_CB_ALIGNMENT,
+     SLAB_HWCACHE_ALIGN,
+     ehca_ctblk_ctor, NULL);
+ if (!ctblk_cache) {
+  ehca_gen_err("Cannot create ctblk SLAB cache.");
+  ehca_cleanup_mrmw_cache();
+  goto create_slab_caches5;
+ }
+#endif
  return 0;
 
 create_slab_caches5:
@@ -157,6 +197,10 @@ static void ehca_destroy_slab_caches(voi
  ehca_cleanup_qp_cache();
  ehca_cleanup_cq_cache();
  ehca_cleanup_pd_cache();
+#ifdef CONFIG_PPC_64K_PAGES
+ if (ctblk_cache)
+  kmem_cache_destroy(ctblk_cache);
+#endif
 }
 
 #define EHCA_HCAAVER  EHCA_BMASK_IBM(32,39)
@@ -168,7 +212,7 @@ int ehca_sense_attributes(struct ehca_sh
  u64 h_ret;
  struct hipz_query_hca *rblock;
 
- rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+ rblock = (struct hipz_query_hca*)ehca_alloc_fw_ctrlblock();
  if (!rblock) {
   ehca_gen_err("Cannot allocate rblock memory.");
   return -ENOMEM;
@@ -211,7 +255,7 @@ int ehca_sense_attributes(struct ehca_sh
  shca->sport[1].rate = IB_RATE_30_GBPS;
 
 num_ports1:
- kfree(rblock);
+ ehca_free_fw_ctrlblock(rblock);
  return ret;
 }
 
@@ -220,7 +264,7 @@ static int init_node_guid(struct ehca_sh
  int ret = 0;
  struct hipz_query_hca *rblock;
 
- rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+ rblock = (struct hipz_query_hca*)ehca_alloc_fw_ctrlblock();
  if (!rblock) {
   ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
   return -ENOMEM;
@@ -235,7 +279,7 @@ static int init_node_guid(struct ehca_sh
  memcpy(&shca->ib_device.node_guid, &rblock->node_guid, sizeof(u64));
 
 init_node_guid1:
- kfree(rblock);
+ ehca_free_fw_ctrlblock(rblock);
  return ret;
 }
 
@@ -431,7 +475,7 @@ static ssize_t  ehca_show_##name(struct 
             \
  shca = dev->driver_data;        \
             \
- rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);      \
+ rblock = (struct hipz_query_hca*)ehca_alloc_fw_ctrlblock();    \
  if (!rblock) {                 \
   dev_err(dev, "Can't allocate rblock memory.");     \
   return 0;         \
@@ -439,12 +483,12 @@ static ssize_t  ehca_show_##name(struct 
             \
  if (hipz_h_query_hca(shca->ipz_hca_handle, rblock) != H_SUCCESS) { \
   dev_err(dev, "Can't query device properties");        \
-  kfree(rblock);            \
+  ehca_free_fw_ctrlblock(rblock);          \
   return 0;            \
  }           \
             \
  data = rblock->name;                                               \
- kfree(rblock);                                                     \
+ ehca_free_fw_ctrlblock(rblock);                                    \
             \
  if ((strcmp(#name, "num_ports") == 0) && (ehca_nr_ports == 1))    \
   return snprintf(buf, 256, "1\n");      \
@@ -752,7 +796,7 @@ int __init ehca_module_init(void)
  int ret;
 
  printk(KERN_INFO "eHCA Infiniband Device Driver "
-                  "(Rel.: SVNEHCA_0017)\n");
+                  "(Rel.: SVNEHCA_0018)\n");
  idr_init(&ehca_qp_idr);
  idr_init(&ehca_cq_idr);
  spin_lock_init(&ehca_qp_idr_lock);
diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 5ca6544..1b77ac7 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -1013,7 +1013,7 @@ int ehca_reg_mr_rpages(struct ehca_shca 
  u32 i;
  u64 *kpage;
 
- kpage = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+ kpage = (u64*)ehca_alloc_fw_ctrlblock();
  if (!kpage) {
   ehca_err(&shca->ib_device, "kpage alloc failed");
   ret = -ENOMEM;
@@ -1092,7 +1092,7 @@ int ehca_reg_mr_rpages(struct ehca_shca 
 
 
 ehca_reg_mr_rpages_exit1:
- kfree(kpage);
+ ehca_free_fw_ctrlblock(kpage);
 ehca_reg_mr_rpages_exit0:
  if (ret)
   ehca_err(&shca->ib_device, "ret=%x shca=%p e_mr=%p pginfo=%p "
@@ -1124,7 +1124,7 @@ inline int ehca_rereg_mr_rereg1(struct e
  ehca_mrmw_map_acl(acl, &hipz_acl);
  ehca_mrmw_set_pgsize_hipz_acl(&hipz_acl);
 
- kpage = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+ kpage = (u64*)ehca_alloc_fw_ctrlblock();
  if (!kpage) {
   ehca_err(&shca->ib_device, "kpage alloc failed");
   ret = -ENOMEM;
@@ -1181,7 +1181,7 @@ inline int ehca_rereg_mr_rereg1(struct e
  }
 
 ehca_rereg_mr_rereg1_exit1:
- kfree(kpage);
+ ehca_free_fw_ctrlblock(kpage);
 ehca_rereg_mr_rereg1_exit0:
  if ( ret && (ret != -EAGAIN) )
   ehca_err(&shca->ib_device, "ret=%x lkey=%x rkey=%x "
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 4394123..3768d8d 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -811,8 +811,9 @@ static int internal_modify_qp(struct ib_
  unsigned long spl_flags = 0;
 
  /* do query_qp to obtain current attr values */
- mqpcb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
- if (mqpcb == NULL) {
+ mqpcb = (struct hcp_modify_qp_control_block*)
+  ehca_alloc_fw_ctrlblock();
+ if (!mqpcb) {
   ehca_err(ibqp->device, "Could not get zeroed page for mqpcb "
     "ehca_qp=%p qp_num=%x ", my_qp, ibqp->qp_num);
   return -ENOMEM;
@@ -1225,7 +1226,7 @@ modify_qp_exit2:
  }
 
 modify_qp_exit1:
- kfree(mqpcb);
+ ehca_free_fw_ctrlblock(mqpcb);
 
  return ret;
 }
@@ -1277,7 +1278,8 @@ int ehca_query_qp(struct ib_qp *qp,
   return -EINVAL;
  }
 
- qpcb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL );
+ qpcb = (struct hcp_modify_qp_control_block*)
+  ehca_alloc_fw_ctrlblock();
  if (!qpcb) {
   ehca_err(qp->device,"Out of memory for qpcb "
     "ehca_qp=%p qp_num=%x", my_qp, qp->qp_num);
@@ -1401,7 +1403,7 @@ int ehca_query_qp(struct ib_qp *qp,
   ehca_dmp(qpcb, 4*70, "qp_num=%x", qp->qp_num);
 
 query_qp_exit1:
- kfree(qpcb);
+ ehca_free_fw_ctrlblock(qpcb);
 
  return ret;
 }
 

--Boundary-00=_GxkTFb9TlYxTAq7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="roland_svnehca_0018_64kpage_fwctblock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="roland_svnehca_0018_64kpage_fwctblock.patch"

diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index 5eae6ac..f77e626 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -40,6 +40,7 @@
  */
 
 #include "ehca_tools.h"
+#include "ehca_iverbs.h"
 #include "hcp_if.h"
 
 int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
@@ -49,7 +50,7 @@ int ehca_query_device(struct ib_device *
 					      ib_device);
 	struct hipz_query_hca *rblock;
 
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	rblock = (struct hipz_query_hca*)ehca_alloc_fw_ctrlblock();
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -96,7 +97,7 @@ int ehca_query_device(struct ib_device *
 		= min_t(int, rblock->max_total_mcast_qp_attach, INT_MAX);
 
 query_device1:
-	kfree(rblock);
+	ehca_free_fw_ctrlblock(rblock);
 
 	return ret;
 }
@@ -109,7 +110,7 @@ int ehca_query_port(struct ib_device *ib
 					      ib_device);
 	struct hipz_query_port *rblock;
 
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	rblock = (struct hipz_query_port*)ehca_alloc_fw_ctrlblock();
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -162,7 +163,7 @@ int ehca_query_port(struct ib_device *ib
 	props->active_speed    = 0x1;
 
 query_port1:
-	kfree(rblock);
+	ehca_free_fw_ctrlblock(rblock);
 
 	return ret;
 }
@@ -178,7 +179,7 @@ int ehca_query_pkey(struct ib_device *ib
 		return -EINVAL;
 	}
 
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	rblock = (struct hipz_query_port*)ehca_alloc_fw_ctrlblock();
 	if (!rblock) {
 		ehca_err(&shca->ib_device,  "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -193,7 +194,7 @@ int ehca_query_pkey(struct ib_device *ib
 	memcpy(pkey, &rblock->pkey_entries + index, sizeof(u16));
 
 query_pkey1:
-	kfree(rblock);
+	ehca_free_fw_ctrlblock(rblock);
 
 	return ret;
 }
@@ -211,7 +212,7 @@ int ehca_query_gid(struct ib_device *ibd
 		return -EINVAL;
 	}
 
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	rblock = (struct hipz_query_port*)ehca_alloc_fw_ctrlblock();
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -227,7 +228,7 @@ int ehca_query_gid(struct ib_device *ibd
 	memcpy(&gid->raw[8], &rblock->guid_entries[index], sizeof(u64));
 
 query_gid1:
-	kfree(rblock);
+	ehca_free_fw_ctrlblock(rblock);
 
 	return ret;
 }
diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index 048cc44..01b66d7 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -45,6 +45,7 @@ #include "ehca_iverbs.h"
 #include "ehca_tools.h"
 #include "hcp_if.h"
 #include "hipz_fns.h"
+#include "ipz_pt_fn.h"
 
 #define EQE_COMPLETION_EVENT   EHCA_BMASK_IBM(1,1)
 #define EQE_CQ_QP_NUMBER       EHCA_BMASK_IBM(8,31)
@@ -137,38 +138,36 @@ int ehca_error_data(struct ehca_shca *sh
 	u64 *rblock;
 	unsigned long block_count;
 
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	rblock = (u64*)ehca_alloc_fw_ctrlblock();
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Cannot allocate rblock memory.");
 		ret = -ENOMEM;
 		goto error_data1;
 	}
 
+	/* rblock must be 4K aligned and should be 4K large */
 	ret = hipz_h_error_data(shca->ipz_hca_handle,
 				resource,
 				rblock,
 				&block_count);
 
-	if (ret == H_R_STATE) {
+	if (ret == H_R_STATE)
 		ehca_err(&shca->ib_device,
 			 "No error data is available: %lx.", resource);
-	}
 	else if (ret == H_SUCCESS) {
 		int length;
 
 		length = EHCA_BMASK_GET(ERROR_DATA_LENGTH, rblock[0]);
 
-		if (length > PAGE_SIZE)
-			length = PAGE_SIZE;
+		if (length > EHCA_PAGESIZE)
+			length = EHCA_PAGESIZE;
 
 		print_error_data(shca, data, rblock, length);
-	}
-	else {
+	} else
 		ehca_err(&shca->ib_device,
 			 "Error data could not be fetched: %lx", resource);
-	}
 
-	kfree(rblock);
+	ehca_free_fw_ctrlblock(rblock);
 
 error_data1:
 	return ret;
diff --git a/drivers/infiniband/hw/ehca/ehca_iverbs.h b/drivers/infiniband/hw/ehca/ehca_iverbs.h
index 319c39d..73e5f3f 100644
--- a/drivers/infiniband/hw/ehca/ehca_iverbs.h
+++ b/drivers/infiniband/hw/ehca/ehca_iverbs.h
@@ -179,4 +179,12 @@ int ehca_mmap_register(u64 physical,void
 
 int ehca_munmap(unsigned long addr, size_t len);
 
+#ifdef CONFIG_PPC_64K_PAGES
+void *ehca_alloc_fw_ctrlblock(void);
+void ehca_free_fw_ctrlblock(void *ptr);
+#else
+#define ehca_alloc_fw_ctrlblock() get_zeroed_page(GFP_KERNEL)
+#define ehca_free_fw_ctrlblock(ptr) free_page((unsigned long)(ptr))
+#endif
+
 #endif
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 024d511..d66d66b 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -40,6 +40,9 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 
+#ifdef CONFIG_PPC_64K_PAGES
+#include <linux/slab.h>
+#endif
 #include "ehca_classes.h"
 #include "ehca_iverbs.h"
 #include "ehca_mrmw.h"
@@ -49,7 +52,7 @@ #include "hcp_if.h"
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0017");
+MODULE_VERSION("SVNEHCA_0018");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -94,11 +97,37 @@ spinlock_t ehca_cq_idr_lock;
 DEFINE_IDR(ehca_qp_idr);
 DEFINE_IDR(ehca_cq_idr);
 
+
 static struct list_head shca_list; /* list of all registered ehcas */
 static spinlock_t shca_list_lock;
 
 static struct timer_list poll_eqs_timer;
 
+#ifdef CONFIG_PPC_64K_PAGES
+static struct kmem_cache *ctblk_cache = NULL;
+
+/* constructor ctblk_cache */
+void ehca_ctblk_ctor(void *ptr, kmem_cache_t *cache, unsigned long flags)
+{
+	memset(ptr, 0, EHCA_PAGESIZE);
+}
+
+void *ehca_alloc_fw_ctrlblock(void)
+{
+	void *ret = kmem_cache_alloc(ctblk_cache, SLAB_KERNEL);
+	if (!ret)
+		ehca_gen_err("Out of memory for ctblk");
+	return ret;
+}
+
+void ehca_free_fw_ctrlblock(void *ptr)
+{
+	if (ptr)
+		kmem_cache_free(ctblk_cache, ptr);
+
+}
+#endif
+
 static int ehca_create_slab_caches(void)
 {
 	int ret;
@@ -133,6 +162,17 @@ static int ehca_create_slab_caches(void)
 		goto create_slab_caches5;
 	}
 
+#ifdef CONFIG_PPC_64K_PAGES
+	ctblk_cache = kmem_cache_create("ehca_cache_ctblk",
+					EHCA_PAGESIZE, H_CB_ALIGNMENT,
+					SLAB_HWCACHE_ALIGN,
+					ehca_ctblk_ctor, NULL);
+	if (!ctblk_cache) {
+		ehca_gen_err("Cannot create ctblk SLAB cache.");
+		ehca_cleanup_mrmw_cache();
+		goto create_slab_caches5;
+	}
+#endif
 	return 0;
 
 create_slab_caches5:
@@ -157,6 +197,10 @@ static void ehca_destroy_slab_caches(voi
 	ehca_cleanup_qp_cache();
 	ehca_cleanup_cq_cache();
 	ehca_cleanup_pd_cache();
+#ifdef CONFIG_PPC_64K_PAGES
+	if (ctblk_cache)
+		kmem_cache_destroy(ctblk_cache);
+#endif
 }
 
 #define EHCA_HCAAVER  EHCA_BMASK_IBM(32,39)
@@ -168,7 +212,7 @@ int ehca_sense_attributes(struct ehca_sh
 	u64 h_ret;
 	struct hipz_query_hca *rblock;
 
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	rblock = (struct hipz_query_hca*)ehca_alloc_fw_ctrlblock();
 	if (!rblock) {
 		ehca_gen_err("Cannot allocate rblock memory.");
 		return -ENOMEM;
@@ -211,7 +255,7 @@ int ehca_sense_attributes(struct ehca_sh
 	shca->sport[1].rate = IB_RATE_30_GBPS;
 
 num_ports1:
-	kfree(rblock);
+	ehca_free_fw_ctrlblock(rblock);
 	return ret;
 }
 
@@ -220,7 +264,7 @@ static int init_node_guid(struct ehca_sh
 	int ret = 0;
 	struct hipz_query_hca *rblock;
 
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	rblock = (struct hipz_query_hca*)ehca_alloc_fw_ctrlblock();
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -235,7 +279,7 @@ static int init_node_guid(struct ehca_sh
 	memcpy(&shca->ib_device.node_guid, &rblock->node_guid, sizeof(u64));
 
 init_node_guid1:
-	kfree(rblock);
+	ehca_free_fw_ctrlblock(rblock);
 	return ret;
 }
 
@@ -431,7 +475,7 @@ static ssize_t  ehca_show_##name(struct 
 									   \
 	shca = dev->driver_data;					   \
 									   \
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);			   \
+	rblock = (struct hipz_query_hca*)ehca_alloc_fw_ctrlblock();	   \
 	if (!rblock) {						           \
 		dev_err(dev, "Can't allocate rblock memory.");		   \
 		return 0;						   \
@@ -439,12 +483,12 @@ static ssize_t  ehca_show_##name(struct 
 									   \
 	if (hipz_h_query_hca(shca->ipz_hca_handle, rblock) != H_SUCCESS) { \
 		dev_err(dev, "Can't query device properties");	   	   \
-		kfree(rblock);					   	   \
+		ehca_free_fw_ctrlblock(rblock);			   	   \
 		return 0;					   	   \
 	}								   \
 									   \
 	data = rblock->name;                                               \
-	kfree(rblock);                                                     \
+	ehca_free_fw_ctrlblock(rblock);                                    \
 									   \
 	if ((strcmp(#name, "num_ports") == 0) && (ehca_nr_ports == 1))	   \
 		return snprintf(buf, 256, "1\n");			   \
@@ -752,7 +796,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0017)\n");
+	                 "(Rel.: SVNEHCA_0018)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);
diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 5ca6544..1b77ac7 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -1013,7 +1013,7 @@ int ehca_reg_mr_rpages(struct ehca_shca 
 	u32 i;
 	u64 *kpage;
 
-	kpage = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	kpage = (u64*)ehca_alloc_fw_ctrlblock();
 	if (!kpage) {
 		ehca_err(&shca->ib_device, "kpage alloc failed");
 		ret = -ENOMEM;
@@ -1092,7 +1092,7 @@ int ehca_reg_mr_rpages(struct ehca_shca 
 
 
 ehca_reg_mr_rpages_exit1:
-	kfree(kpage);
+	ehca_free_fw_ctrlblock(kpage);
 ehca_reg_mr_rpages_exit0:
 	if (ret)
 		ehca_err(&shca->ib_device, "ret=%x shca=%p e_mr=%p pginfo=%p "
@@ -1124,7 +1124,7 @@ inline int ehca_rereg_mr_rereg1(struct e
 	ehca_mrmw_map_acl(acl, &hipz_acl);
 	ehca_mrmw_set_pgsize_hipz_acl(&hipz_acl);
 
-	kpage = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	kpage = (u64*)ehca_alloc_fw_ctrlblock();
 	if (!kpage) {
 		ehca_err(&shca->ib_device, "kpage alloc failed");
 		ret = -ENOMEM;
@@ -1181,7 +1181,7 @@ inline int ehca_rereg_mr_rereg1(struct e
 	}
 
 ehca_rereg_mr_rereg1_exit1:
-	kfree(kpage);
+	ehca_free_fw_ctrlblock(kpage);
 ehca_rereg_mr_rereg1_exit0:
 	if ( ret && (ret != -EAGAIN) )
 		ehca_err(&shca->ib_device, "ret=%x lkey=%x rkey=%x "
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 4394123..3768d8d 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -811,8 +811,9 @@ static int internal_modify_qp(struct ib_
 	unsigned long spl_flags = 0;
 
 	/* do query_qp to obtain current attr values */
-	mqpcb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
-	if (mqpcb == NULL) {
+	mqpcb = (struct hcp_modify_qp_control_block*)
+		ehca_alloc_fw_ctrlblock();
+	if (!mqpcb) {
 		ehca_err(ibqp->device, "Could not get zeroed page for mqpcb "
 			 "ehca_qp=%p qp_num=%x ", my_qp, ibqp->qp_num);
 		return -ENOMEM;
@@ -1225,7 +1226,7 @@ modify_qp_exit2:
 	}
 
 modify_qp_exit1:
-	kfree(mqpcb);
+	ehca_free_fw_ctrlblock(mqpcb);
 
 	return ret;
 }
@@ -1277,7 +1278,8 @@ int ehca_query_qp(struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	qpcb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL );
+	qpcb = (struct hcp_modify_qp_control_block*)
+		ehca_alloc_fw_ctrlblock();
 	if (!qpcb) {
 		ehca_err(qp->device,"Out of memory for qpcb "
 			 "ehca_qp=%p qp_num=%x", my_qp, qp->qp_num);
@@ -1401,7 +1403,7 @@ int ehca_query_qp(struct ib_qp *qp,
 		ehca_dmp(qpcb, 4*70, "qp_num=%x", qp->qp_num);
 
 query_qp_exit1:
-	kfree(qpcb);
+	ehca_free_fw_ctrlblock(qpcb);
 
 	return ret;
 }
 

--Boundary-00=_GxkTFb9TlYxTAq7--
