Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVACRVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVACRVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVACRVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:21:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5648 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261509AbVACRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:19:40 -0500
Date: Mon, 3 Jan 2005 18:19:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: roland@topspin.com, mshefty@ichips.intel.com, halr@voltaire.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] infiniband: possible cleanups
Message-ID: <20050103171937.GG2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups for the current 
infiniband code:
- make needlessly global code static
- don't build the completely unused core/fmr_pool.c
- #if 0 the following EXPORT_SYMBOL'ed but unused functions:
  - core/device.c: ib_modify_device
  - core/device.c: ib_modify_port
  - core/mad.c: ib_coalesce_recv_mad
  - core/mad.c: ib_process_mad_wc
  - core/mad.c: ib_redirect_mad_qp
  - core/mad.c: ib_register_mad_snoop
  - core/ud_header.c: ib_ud_header_unpack
  - core/verbs.c: ib_alloc_mw
  - core/verbs.c: ib_dealloc_mw
  - core/verbs.c: ib_modify_ah
  - core/verbs.c: ib_query_ah
  - core/verbs.c: ib_query_mr
  - core/verbs.c: ib_query_qp
  - core/verbs.c: ib_reg_phys_mr
  - core/verbs.c: ib_rereg_phys_mr
  - core/verbs.c: ib_resize_cq
  - hw/mthca/mthca_cmd.c: mthca_QUERY_QP

If code will be  added that uses some of the functions this patch
#if 0's it will be trivial to remove the corresponding #if 0's, but as 
long as this hasn't happened, they only make the kernel needlessly 
larger for people who use infiniband.


diffstat output:
 drivers/infiniband/core/Makefile               |    2 -
 drivers/infiniband/core/cache.c                |    6 ++---
 drivers/infiniband/core/device.c               |    4 +++
 drivers/infiniband/core/mad.c                  |    8 ++++++
 drivers/infiniband/core/ud_header.c            |    3 ++
 drivers/infiniband/core/verbs.c                |   16 +++++++++++++
 drivers/infiniband/hw/mthca/mthca_cmd.c        |    2 +
 drivers/infiniband/hw/mthca/mthca_cmd.h        |    2 +
 drivers/infiniband/include/ib_mad.h            |    8 ++++++
 drivers/infiniband/include/ib_pack.h           |    3 +-
 drivers/infiniband/include/ib_verbs.h          |   20 +++++++++++++++++
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    2 -
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |    2 -
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    4 +--
 14 files changed, 73 insertions(+), 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm1-full/drivers/infiniband/ulp/ipoib/ipoib_multicast.c.old	2005-01-03 17:32:08.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-01-03 17:33:06.000000000 +0100
@@ -44,7 +44,7 @@
 #include "ipoib.h"
 
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
-int mcast_debug_level;
+static int mcast_debug_level;
 
 module_param(mcast_debug_level, int, 0644);
 MODULE_PARM_DESC(mcast_debug_level,
@@ -621,7 +621,7 @@
 	return 0;
 }
 
-int ipoib_mcast_leave(struct net_device *dev, struct ipoib_mcast *mcast)
+static int ipoib_mcast_leave(struct net_device *dev, struct ipoib_mcast *mcast)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ib_sa_mcmember_rec rec = {
--- linux-2.6.10-mm1-full/drivers/infiniband/ulp/ipoib/ipoib_main.c.old	2005-01-03 17:33:28.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-01-03 17:33:36.000000000 +0100
@@ -606,7 +606,7 @@
 	return NETDEV_TX_OK;
 }
 
-struct net_device_stats *ipoib_get_stats(struct net_device *dev)
+static struct net_device_stats *ipoib_get_stats(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
--- linux-2.6.10-mm1-full/drivers/infiniband/ulp/ipoib/ipoib_ib.c.old	2005-01-03 17:33:53.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-01-03 17:34:00.000000000 +0100
@@ -357,7 +357,7 @@
 	}
 }
 
-void __ipoib_reap_ah(struct net_device *dev)
+static void __ipoib_reap_ah(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_ah *ah, *tah;
--- linux-2.6.10-mm1-full/drivers/infiniband/core/cache.c.old	2005-01-03 17:34:15.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/core/cache.c	2005-01-03 17:34:44.000000000 +0100
@@ -252,7 +252,7 @@
 	}
 }
 
-void ib_cache_setup_one(struct ib_device *device)
+static void ib_cache_setup_one(struct ib_device *device)
 {
 	int p;
 
@@ -295,7 +295,7 @@
 	kfree(device->cache.gid_cache);
 }
 
-void ib_cache_cleanup_one(struct ib_device *device)
+static void ib_cache_cleanup_one(struct ib_device *device)
 {
 	int p;
 
@@ -311,7 +311,7 @@
 	kfree(device->cache.gid_cache);
 }
 
-struct ib_client cache_client = {
+static struct ib_client cache_client = {
 	.name   = "cache",
 	.add    = ib_cache_setup_one,
 	.remove = ib_cache_cleanup_one
--- linux-2.6.10-mm1-full/drivers/infiniband/include/ib_verbs.h.old	2005-01-03 18:03:28.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/include/ib_verbs.h	2005-01-03 17:50:32.000000000 +0100
@@ -865,6 +865,8 @@
 int ib_query_pkey(struct ib_device *device,
 		  u8 port_num, u16 index, u16 *pkey);
 
+#if 0
+
 int ib_modify_device(struct ib_device *device,
 		     int device_modify_mask,
 		     struct ib_device_modify *device_modify);
@@ -873,6 +875,8 @@
 		   u8 port_num, int port_modify_mask,
 		   struct ib_port_modify *port_modify);
 
+#endif  /*  0  */
+
 /**
  * ib_alloc_pd - Allocates an unused protection domain.
  * @device: The device on which to allocate the protection domain.
@@ -898,6 +902,8 @@
  */
 struct ib_ah *ib_create_ah(struct ib_pd *pd, struct ib_ah_attr *ah_attr);
 
+#if 0
+
 /**
  * ib_modify_ah - Modifies the address vector associated with an address
  *   handle.
@@ -916,6 +922,8 @@
  */
 int ib_query_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr);
 
+#endif  /*  0  */
+
 /**
  * ib_destroy_ah - Destroys an address handle.
  * @ah: The address handle to destroy.
@@ -955,10 +963,12 @@
  * The qp_attr_mask may be used to limit the query to gathering only the
  * selected attributes.
  */
+#if 0
 int ib_query_qp(struct ib_qp *qp,
 		struct ib_qp_attr *qp_attr,
 		int qp_attr_mask,
 		struct ib_qp_init_attr *qp_init_attr);
+#endif
 
 /**
  * ib_destroy_qp - Destroys the specified QP.
@@ -1021,7 +1031,9 @@
  *
  * Users can examine the cq structure to determine the actual CQ size.
  */
+#if 0
 int ib_resize_cq(struct ib_cq *cq, int cqe);
+#endif
 
 /**
  * ib_destroy_cq - Destroys the specified CQ.
@@ -1094,6 +1106,8 @@
  */
 struct ib_mr *ib_get_dma_mr(struct ib_pd *pd, int mr_access_flags);
 
+#if 0
+
 /**
  * ib_reg_phys_mr - Prepares a virtually addressed memory region for use
  *   by an HCA.
@@ -1147,6 +1161,8 @@
  */
 int ib_query_mr(struct ib_mr *mr, struct ib_mr_attr *mr_attr);
 
+#endif  /*  0  */
+
 /**
  * ib_dereg_mr - Deregisters a memory region and removes it from the
  *   HCA translation table.
@@ -1158,7 +1174,9 @@
  * ib_alloc_mw - Allocates a memory window.
  * @pd: The protection domain associated with the memory window.
  */
+#if 0
 struct ib_mw *ib_alloc_mw(struct ib_pd *pd);
+#endif
 
 /**
  * ib_bind_mw - Posts a work request to the send queue of the specified
@@ -1183,7 +1201,9 @@
  * ib_dealloc_mw - Deallocates a memory window.
  * @mw: The memory window to deallocate.
  */
+#if 0
 int ib_dealloc_mw(struct ib_mw *mw);
+#endif
 
 /**
  * ib_alloc_fmr - Allocates a unmapped fast memory region.
--- linux-2.6.10-mm1-full/drivers/infiniband/core/device.c.old	2005-01-03 17:34:59.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/core/device.c	2005-01-03 17:36:15.000000000 +0100
@@ -549,6 +549,8 @@
 }
 EXPORT_SYMBOL(ib_query_pkey);
 
+#if 0
+
 /**
  * ib_modify_device - Change IB device attributes
  * @device:Device to modify
@@ -587,6 +589,8 @@
 }
 EXPORT_SYMBOL(ib_modify_port);
 
+#endif  /*  0  */
+
 static int __init ib_core_init(void)
 {
 	int ret;
--- linux-2.6.10-mm1-full/drivers/infiniband/core/Makefile.old	2005-01-03 17:40:51.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/core/Makefile	2005-01-03 17:41:26.000000000 +0100
@@ -3,7 +3,7 @@
 obj-$(CONFIG_INFINIBAND) +=	ib_core.o ib_mad.o ib_sa.o ib_umad.o
 
 ib_core-y :=			packer.o ud_header.o verbs.o sysfs.o \
-				device.o fmr_pool.o cache.o
+				device.o cache.o
 
 ib_mad-y :=			mad.o smi.o agent.o
 
--- linux-2.6.10-mm1-full/drivers/infiniband/include/ib_mad.h.old	2005-01-03 17:42:48.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/include/ib_mad.h	2005-01-03 17:43:56.000000000 +0100
@@ -297,6 +297,7 @@
  * @recv_handler: The callback routine invoked for a snooped receive.
  * @context: User specified context associated with the registration.
  */
+#if 0
 struct ib_mad_agent *ib_register_mad_snoop(struct ib_device *device,
 					   u8 port_num,
 					   enum ib_qp_type qp_type,
@@ -304,6 +305,7 @@
 					   ib_mad_snoop_handler snoop_handler,
 					   ib_mad_recv_handler recv_handler,
 					   void *context);
+#endif
 
 /**
  * ib_unregister_mad_agent - Unregisters a client from using MAD services.
@@ -337,8 +339,10 @@
  * This call copies a chain of received RMPP MADs into a single data buffer,
  * removing duplicated headers.
  */
+#if 0
 void ib_coalesce_recv_mad(struct ib_mad_recv_wc *mad_recv_wc,
 			  void *buf);
+#endif
 
 /**
  * ib_free_recv_mad - Returns data buffers used to receive a MAD to the
@@ -361,6 +365,8 @@
 void ib_cancel_mad(struct ib_mad_agent *mad_agent,
 		   u64 wr_id);
 
+#if 0
+
 /**
  * ib_redirect_mad_qp - Registers a QP for MAD services.
  * @qp: Reference to a QP that requires MAD services.
@@ -401,4 +407,6 @@
 int ib_process_mad_wc(struct ib_mad_agent *mad_agent,
 		      struct ib_wc *wc);
 
+#endif  /*  0  */
+
 #endif /* IB_MAD_H */
--- linux-2.6.10-mm1-full/drivers/infiniband/core/mad.c.old	2005-01-03 17:44:07.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/core/mad.c	2005-01-03 18:00:30.000000000 +0100
@@ -370,6 +370,8 @@
 		 IB_MAD_SNOOP_RMPP_RECVS*/));
 }
 
+#if 0
+
 static int register_snoop_agent(struct ib_mad_qp_info *qp_info,
 				struct ib_mad_snoop_private *mad_snoop_priv)
 {
@@ -473,6 +475,8 @@
 }
 EXPORT_SYMBOL(ib_register_mad_snoop);
 
+#endif  /*  0  */
+
 static void unregister_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 {
 	struct ib_mad_port_private *port_priv;
@@ -892,6 +896,8 @@
 }
 EXPORT_SYMBOL(ib_free_recv_mad);
 
+#if 0
+
 void ib_coalesce_recv_mad(struct ib_mad_recv_wc *mad_recv_wc,
 			  void *buf)
 {
@@ -917,6 +923,8 @@
 }
 EXPORT_SYMBOL(ib_process_mad_wc);
 
+#endif  /*  0  */
+
 static int method_in_use(struct ib_mad_mgmt_method_table **method,
 			 struct ib_mad_reg_req *mad_reg_req)
 {
--- linux-2.6.10-mm1-full/drivers/infiniband/include/ib_pack.h.old	2005-01-03 17:45:55.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/include/ib_pack.h	2005-01-03 17:46:06.000000000 +0100
@@ -238,8 +238,9 @@
 
 int ib_ud_header_pack(struct ib_ud_header *header,
 		      void                *buf);
-
+#if 0
 int ib_ud_header_unpack(void                *buf,
 			struct ib_ud_header *header);
+#endif
 
 #endif /* IB_PACK_H */
--- linux-2.6.10-mm1-full/drivers/infiniband/core/ud_header.c.old	2005-01-03 17:46:14.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/core/ud_header.c	2005-01-03 17:46:40.000000000 +0100
@@ -288,6 +288,7 @@
  * ib_ud_header_pack() unpacks the UD header structure @header from wire
  * format in the buffer @buf.
  */
+#if 0
 int ib_ud_header_unpack(void                *buf,
 			struct ib_ud_header *header)
 {
@@ -363,3 +364,5 @@
 	return 0;
 }
 EXPORT_SYMBOL(ib_ud_header_unpack);
+#endif  /*  0  */
+
--- linux-2.6.10-mm1-full/drivers/infiniband/core/verbs.c.old	2005-01-03 17:50:40.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/core/verbs.c	2005-01-03 17:52:44.000000000 +0100
@@ -85,6 +85,8 @@
 }
 EXPORT_SYMBOL(ib_create_ah);
 
+#if 0
+
 int ib_modify_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr)
 {
 	return ah->device->modify_ah ?
@@ -101,6 +103,8 @@
 }
 EXPORT_SYMBOL(ib_query_ah);
 
+#endif  /*  0  */
+
 int ib_destroy_ah(struct ib_ah *ah)
 {
 	struct ib_pd *pd;
@@ -151,6 +155,7 @@
 }
 EXPORT_SYMBOL(ib_modify_qp);
 
+#if 0
 int ib_query_qp(struct ib_qp *qp,
 		struct ib_qp_attr *qp_attr,
 		int qp_attr_mask,
@@ -161,6 +166,7 @@
 		-ENOSYS;
 }
 EXPORT_SYMBOL(ib_query_qp);
+#endif  /*  0  */
 
 int ib_destroy_qp(struct ib_qp *qp)
 {
@@ -219,6 +225,7 @@
 }
 EXPORT_SYMBOL(ib_destroy_cq);
 
+#if 0
 int ib_resize_cq(struct ib_cq *cq,
                  int           cqe)
 {
@@ -234,6 +241,7 @@
 	return ret;
 }
 EXPORT_SYMBOL(ib_resize_cq);
+#endif  /*  0  */
 
 /* Memory regions */
 
@@ -254,6 +262,8 @@
 }
 EXPORT_SYMBOL(ib_get_dma_mr);
 
+#if 0
+
 struct ib_mr *ib_reg_phys_mr(struct ib_pd *pd,
 			     struct ib_phys_buf *phys_buf_array,
 			     int num_phys_buf,
@@ -315,6 +325,8 @@
 }
 EXPORT_SYMBOL(ib_query_mr);
 
+#endif  /*  0  */
+
 int ib_dereg_mr(struct ib_mr *mr)
 {
 	struct ib_pd *pd;
@@ -334,6 +346,8 @@
 
 /* Memory windows */
 
+#if 0
+
 struct ib_mw *ib_alloc_mw(struct ib_pd *pd)
 {
 	struct ib_mw *mw;
@@ -366,6 +380,8 @@
 }
 EXPORT_SYMBOL(ib_dealloc_mw);
 
+#endif  /*  0  */
+
 /* "Fast" memory regions */
 
 struct ib_fmr *ib_alloc_fmr(struct ib_pd *pd,
--- linux-2.6.10-mm1-full/drivers/infiniband/hw/mthca/mthca_cmd.h.old	2005-01-03 17:53:41.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-01-03 17:53:51.000000000 +0100
@@ -258,8 +258,10 @@
 int mthca_MODIFY_QP(struct mthca_dev *dev, int trans, u32 num,
 		    int is_ee, void *qp_context, u32 optmask,
 		    u8 *status);
+#if 0
 int mthca_QUERY_QP(struct mthca_dev *dev, u32 num, int is_ee,
 		   void *qp_context, u8 *status);
+#endif
 int mthca_CONF_SPECIAL_QP(struct mthca_dev *dev, int type, u32 qpn,
 			  u8 *status);
 int mthca_MAD_IFC(struct mthca_dev *dev, int ignore_mkey, int port,
--- linux-2.6.10-mm1-full/drivers/infiniband/hw/mthca/mthca_cmd.c.old	2005-01-03 17:53:03.000000000 +0100
+++ linux-2.6.10-mm1-full/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-03 17:53:28.000000000 +0100
@@ -1439,6 +1439,7 @@
 	return err;
 }
 
+#if 0
 int mthca_QUERY_QP(struct mthca_dev *dev, u32 num, int is_ee,
 		   void *qp_context, u8 *status)
 {
@@ -1460,6 +1461,7 @@
 			 PCI_DMA_FROMDEVICE);
 	return err;
 }
+#endif  /*  0  */
 
 int mthca_CONF_SPECIAL_QP(struct mthca_dev *dev, int type, u32 qpn,
 			  u8 *status)



