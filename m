Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWDLWjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWDLWjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 18:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWDLWjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 18:39:36 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:59756 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932364AbWDLWjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 18:39:35 -0400
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="423606761:sNHT47285636"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] InfiniBand updates for 2.6.17-rc1
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Apr 2006 15:39:30 -0700
Message-ID: <adahd4yto4d.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Apr 2006 22:39:31.0496 (UTC) FILETIME=[F7088280:01C65E81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This includes changes that I've asked you to pull a couple of times,
but which probably got lost in your mail queue because of your trip.

There are a couple of largish changes in here, but they are all needed:
 - the IPoIB ring size tunables fix horrible performance IBM sees
 - the static rate change fixes big problems on mixed rate networks

The exact changes and patch are:

Eli Cohen:
      IPoIB: Wait for join to finish before freeing mcast struct
      IPoIB: Close race in ipoib_flush_paths()

Jack Morgenstein:
      IB: simplify static rate encoding
      IB/mthca: Fix max_srq_sge returned by ib_query_device for Tavor devices

Michael S. Tsirkin:
      IB/mad: fix oops in cancel_mads
      IPoIB: Consolidate private neighbour data handling
      IB/mthca: Disable tuning PCI read burst size
      IB/cache: Use correct pointer to calculate size

Roland Dreier:
      IPoIB: Always build debugging code unless CONFIG_EMBEDDED=y
      IB/mthca: Always build debugging code unless CONFIG_EMBEDDED=y
      IB/srp: Fix memory leak in options parsing
      IPoIB: Use spin_lock_irq() instead of spin_lock_irqsave()

Shirley Ma:
      IPoIB: Make send and receive queue sizes tunable

 drivers/infiniband/core/cache.c                |    2 
 drivers/infiniband/core/mad.c                  |    2 
 drivers/infiniband/core/verbs.c                |   34 ++++++++
 drivers/infiniband/hw/mthca/Kconfig            |   11 +--
 drivers/infiniband/hw/mthca/Makefile           |    4 -
 drivers/infiniband/hw/mthca/mthca_av.c         |  100 ++++++++++++++++++++++++
 drivers/infiniband/hw/mthca/mthca_cmd.c        |    4 +
 drivers/infiniband/hw/mthca/mthca_cmd.h        |    1 
 drivers/infiniband/hw/mthca/mthca_dev.h        |   23 +++++-
 drivers/infiniband/hw/mthca/mthca_mad.c        |   42 ++++++++++
 drivers/infiniband/hw/mthca/mthca_main.c       |   28 +++++++
 drivers/infiniband/hw/mthca/mthca_provider.c   |    2 
 drivers/infiniband/hw/mthca/mthca_provider.h   |    3 -
 drivers/infiniband/hw/mthca/mthca_qp.c         |   46 ++++++++---
 drivers/infiniband/hw/mthca/mthca_srq.c        |   27 ++++++
 drivers/infiniband/ulp/ipoib/Kconfig           |    3 -
 drivers/infiniband/ulp/ipoib/ipoib.h           |    7 ++
 drivers/infiniband/ulp/ipoib/ipoib_fs.c        |    2 
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |   22 +++--
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   88 ++++++++++++++-------
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   58 ++++++--------
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c     |    6 +
 drivers/infiniband/ulp/srp/ib_srp.c            |    1 
 include/rdma/ib_sa.h                           |   28 -------
 include/rdma/ib_verbs.h                        |   28 +++++++
 25 files changed, 430 insertions(+), 142 deletions(-)


diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index c57a387..50364c0 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -302,7 +302,7 @@ static void ib_cache_setup_one(struct ib
 		kmalloc(sizeof *device->cache.pkey_cache *
 			(end_port(device) - start_port(device) + 1), GFP_KERNEL);
 	device->cache.gid_cache =
-		kmalloc(sizeof *device->cache.pkey_cache *
+		kmalloc(sizeof *device->cache.gid_cache *
 			(end_port(device) - start_port(device) + 1), GFP_KERNEL);
 
 	if (!device->cache.pkey_cache || !device->cache.gid_cache) {
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index ba54c85..3a702da 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2311,6 +2311,7 @@ static void local_completions(void *data
 		local = list_entry(mad_agent_priv->local_list.next,
 				   struct ib_mad_local_private,
 				   completion_list);
+		list_del(&local->completion_list);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 		if (local->mad_priv) {
 			recv_mad_agent = local->recv_mad_agent;
@@ -2362,7 +2363,6 @@ local_send_completion:
 						   &mad_send_wc);
 
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
-		list_del(&local->completion_list);
 		atomic_dec(&mad_agent_priv->refcount);
 		if (!recv)
 			kmem_cache_free(ib_mad_cache, local->mad_priv);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index cae0845..b78e7dc 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -45,6 +45,40 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cache.h>
 
+int ib_rate_to_mult(enum ib_rate rate)
+{
+	switch (rate) {
+	case IB_RATE_2_5_GBPS: return  1;
+	case IB_RATE_5_GBPS:   return  2;
+	case IB_RATE_10_GBPS:  return  4;
+	case IB_RATE_20_GBPS:  return  8;
+	case IB_RATE_30_GBPS:  return 12;
+	case IB_RATE_40_GBPS:  return 16;
+	case IB_RATE_60_GBPS:  return 24;
+	case IB_RATE_80_GBPS:  return 32;
+	case IB_RATE_120_GBPS: return 48;
+	default:	       return -1;
+	}
+}
+EXPORT_SYMBOL(ib_rate_to_mult);
+
+enum ib_rate mult_to_ib_rate(int mult)
+{
+	switch (mult) {
+	case 1:  return IB_RATE_2_5_GBPS;
+	case 2:  return IB_RATE_5_GBPS;
+	case 4:  return IB_RATE_10_GBPS;
+	case 8:  return IB_RATE_20_GBPS;
+	case 12: return IB_RATE_30_GBPS;
+	case 16: return IB_RATE_40_GBPS;
+	case 24: return IB_RATE_60_GBPS;
+	case 32: return IB_RATE_80_GBPS;
+	case 48: return IB_RATE_120_GBPS;
+	default: return IB_RATE_PORT_CURRENT;
+	}
+}
+EXPORT_SYMBOL(mult_to_ib_rate);
+
 /* Protection domains */
 
 struct ib_pd *ib_alloc_pd(struct ib_device *device)
diff --git a/drivers/infiniband/hw/mthca/Kconfig b/drivers/infiniband/hw/mthca/Kconfig
index e88be85..9aa5a44 100644
--- a/drivers/infiniband/hw/mthca/Kconfig
+++ b/drivers/infiniband/hw/mthca/Kconfig
@@ -7,10 +7,11 @@ config INFINIBAND_MTHCA
 	  ("Tavor") and the MT25208 PCI Express HCA ("Arbel").
 
 config INFINIBAND_MTHCA_DEBUG
-	bool "Verbose debugging output"
+	bool "Verbose debugging output" if EMBEDDED
 	depends on INFINIBAND_MTHCA
-	default n
+	default y
 	---help---
-	  This option causes the mthca driver produce a bunch of debug
-	  messages.  Select this is you are developing the driver or
-	  trying to diagnose a problem.
+	  This option causes debugging code to be compiled into the
+	  mthca driver.  The output can be turned on via the
+	  debug_level module parameter (which can also be set after
+	  the driver is loaded through sysfs).
diff --git a/drivers/infiniband/hw/mthca/Makefile b/drivers/infiniband/hw/mthca/Makefile
index 47ec5a7..e388d95 100644
--- a/drivers/infiniband/hw/mthca/Makefile
+++ b/drivers/infiniband/hw/mthca/Makefile
@@ -1,7 +1,3 @@
-ifdef CONFIG_INFINIBAND_MTHCA_DEBUG
-EXTRA_CFLAGS += -DDEBUG
-endif
-
 obj-$(CONFIG_INFINIBAND_MTHCA) += ib_mthca.o
 
 ib_mthca-y :=	mthca_main.o mthca_cmd.o mthca_profile.o mthca_reset.o \
diff --git a/drivers/infiniband/hw/mthca/mthca_av.c b/drivers/infiniband/hw/mthca/mthca_av.c
index bc5bdcb..b12aa03 100644
--- a/drivers/infiniband/hw/mthca/mthca_av.c
+++ b/drivers/infiniband/hw/mthca/mthca_av.c
@@ -42,6 +42,20 @@
 
 #include "mthca_dev.h"
 
+enum {
+      MTHCA_RATE_TAVOR_FULL   = 0,
+      MTHCA_RATE_TAVOR_1X     = 1,
+      MTHCA_RATE_TAVOR_4X     = 2,
+      MTHCA_RATE_TAVOR_1X_DDR = 3
+};
+
+enum {
+      MTHCA_RATE_MEMFREE_FULL    = 0,
+      MTHCA_RATE_MEMFREE_QUARTER = 1,
+      MTHCA_RATE_MEMFREE_EIGHTH  = 2,
+      MTHCA_RATE_MEMFREE_HALF    = 3
+};
+
 struct mthca_av {
 	__be32 port_pd;
 	u8     reserved1;
@@ -55,6 +69,90 @@ struct mthca_av {
 	__be32 dgid[4];
 };
 
+static enum ib_rate memfree_rate_to_ib(u8 mthca_rate, u8 port_rate)
+{
+	switch (mthca_rate) {
+	case MTHCA_RATE_MEMFREE_EIGHTH:
+		return mult_to_ib_rate(port_rate >> 3);
+	case MTHCA_RATE_MEMFREE_QUARTER:
+		return mult_to_ib_rate(port_rate >> 2);
+	case MTHCA_RATE_MEMFREE_HALF:
+		return mult_to_ib_rate(port_rate >> 1);
+	case MTHCA_RATE_MEMFREE_FULL:
+	default:
+		return mult_to_ib_rate(port_rate);
+	}
+}
+
+static enum ib_rate tavor_rate_to_ib(u8 mthca_rate, u8 port_rate)
+{
+	switch (mthca_rate) {
+	case MTHCA_RATE_TAVOR_1X:     return IB_RATE_2_5_GBPS;
+	case MTHCA_RATE_TAVOR_1X_DDR: return IB_RATE_5_GBPS;
+	case MTHCA_RATE_TAVOR_4X:     return IB_RATE_10_GBPS;
+	default:		      return port_rate;
+	}
+}
+
+enum ib_rate mthca_rate_to_ib(struct mthca_dev *dev, u8 mthca_rate, u8 port)
+{
+	if (mthca_is_memfree(dev)) {
+		/* Handle old Arbel FW */
+		if (dev->limits.stat_rate_support == 0x3 && mthca_rate)
+			return IB_RATE_2_5_GBPS;
+
+		return memfree_rate_to_ib(mthca_rate, dev->rate[port - 1]);
+	} else
+		return tavor_rate_to_ib(mthca_rate, dev->rate[port - 1]);
+}
+
+static u8 ib_rate_to_memfree(u8 req_rate, u8 cur_rate)
+{
+	if (cur_rate <= req_rate)
+		return 0;
+
+	/*
+	 * Inter-packet delay (IPD) to get from rate X down to a rate
+	 * no more than Y is (X - 1) / Y.
+	 */
+	switch ((cur_rate - 1) / req_rate) {
+	case 0:	 return MTHCA_RATE_MEMFREE_FULL;
+	case 1:	 return MTHCA_RATE_MEMFREE_HALF;
+	case 2:	 /* fall through */
+	case 3:	 return MTHCA_RATE_MEMFREE_QUARTER;
+	default: return MTHCA_RATE_MEMFREE_EIGHTH;
+	}
+}
+
+static u8 ib_rate_to_tavor(u8 static_rate)
+{
+	switch (static_rate) {
+	case IB_RATE_2_5_GBPS: return MTHCA_RATE_TAVOR_1X;
+	case IB_RATE_5_GBPS:   return MTHCA_RATE_TAVOR_1X_DDR;
+	case IB_RATE_10_GBPS:  return MTHCA_RATE_TAVOR_4X;
+	default:	       return MTHCA_RATE_TAVOR_FULL;
+	}
+}
+
+u8 mthca_get_rate(struct mthca_dev *dev, int static_rate, u8 port)
+{
+	u8 rate;
+
+	if (!static_rate || ib_rate_to_mult(static_rate) >= dev->rate[port - 1])
+		return 0;
+
+	if (mthca_is_memfree(dev))
+		rate = ib_rate_to_memfree(ib_rate_to_mult(static_rate),
+					  dev->rate[port - 1]);
+	else
+		rate = ib_rate_to_tavor(static_rate);
+
+	if (!(dev->limits.stat_rate_support & (1 << rate)))
+		rate = 1;
+
+	return rate;
+}
+
 int mthca_create_ah(struct mthca_dev *dev,
 		    struct mthca_pd *pd,
 		    struct ib_ah_attr *ah_attr,
@@ -107,7 +205,7 @@ on_hca_fail:
 	av->g_slid  = ah_attr->src_path_bits;
 	av->dlid    = cpu_to_be16(ah_attr->dlid);
 	av->msg_sr  = (3 << 4) | /* 2K message */
-		ah_attr->static_rate;
+		mthca_get_rate(dev, ah_attr->static_rate, ah_attr->port_num);
 	av->sl_tclass_flowlabel = cpu_to_be32(ah_attr->sl << 28);
 	if (ah_attr->ah_flags & IB_AH_GRH) {
 		av->g_slid |= 0x80;
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index 343eca5..1985b5d 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -965,6 +965,7 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 	u32 *outbox;
 	u8 field;
 	u16 size;
+	u16 stat_rate;
 	int err;
 
 #define QUERY_DEV_LIM_OUT_SIZE             0x100
@@ -995,6 +996,7 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 #define QUERY_DEV_LIM_MTU_WIDTH_OFFSET      0x36
 #define QUERY_DEV_LIM_VL_PORT_OFFSET        0x37
 #define QUERY_DEV_LIM_MAX_GID_OFFSET        0x3b
+#define QUERY_DEV_LIM_RATE_SUPPORT_OFFSET   0x3c
 #define QUERY_DEV_LIM_MAX_PKEY_OFFSET       0x3f
 #define QUERY_DEV_LIM_FLAGS_OFFSET          0x44
 #define QUERY_DEV_LIM_RSVD_UAR_OFFSET       0x48
@@ -1086,6 +1088,8 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 	dev_lim->num_ports = field & 0xf;
 	MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_GID_OFFSET);
 	dev_lim->max_gids = 1 << (field & 0xf);
+	MTHCA_GET(stat_rate, outbox, QUERY_DEV_LIM_RATE_SUPPORT_OFFSET);
+	dev_lim->stat_rate_support = stat_rate;
 	MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_PKEY_OFFSET);
 	dev_lim->max_pkeys = 1 << (field & 0xf);
 	MTHCA_GET(dev_lim->flags, outbox, QUERY_DEV_LIM_FLAGS_OFFSET);
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.h b/drivers/infiniband/hw/mthca/mthca_cmd.h
index e4ec35c..2f976f2 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.h
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.h
@@ -146,6 +146,7 @@ struct mthca_dev_lim {
 	int max_vl;
 	int num_ports;
 	int max_gids;
+	u16 stat_rate_support;
 	int max_pkeys;
 	u32 flags;
 	int reserved_uars;
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index ad52edb..4c1dcb4 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -151,6 +151,7 @@ struct mthca_limits {
 	int      reserved_qps;
 	int      num_srqs;
 	int      max_srq_wqes;
+	int      max_srq_sge;
 	int      reserved_srqs;
 	int      num_eecs;
 	int      reserved_eecs;
@@ -172,6 +173,7 @@ struct mthca_limits {
 	int      reserved_pds;
 	u32      page_size_cap;
 	u32      flags;
+	u16      stat_rate_support;
 	u8       port_width_cap;
 };
 
@@ -353,10 +355,24 @@ struct mthca_dev {
 	struct ib_mad_agent  *send_agent[MTHCA_MAX_PORTS][2];
 	struct ib_ah         *sm_ah[MTHCA_MAX_PORTS];
 	spinlock_t            sm_lock;
+	u8                    rate[MTHCA_MAX_PORTS];
 };
 
-#define mthca_dbg(mdev, format, arg...) \
-	dev_dbg(&mdev->pdev->dev, format, ## arg)
+#ifdef CONFIG_INFINIBAND_MTHCA_DEBUG
+extern int mthca_debug_level;
+
+#define mthca_dbg(mdev, format, arg...)					\
+	do {								\
+		if (mthca_debug_level)					\
+			dev_printk(KERN_DEBUG, &mdev->pdev->dev, format, ## arg); \
+	} while (0)
+
+#else /* CONFIG_INFINIBAND_MTHCA_DEBUG */
+
+#define mthca_dbg(mdev, format, arg...) do { (void) mdev; } while (0)
+
+#endif /* CONFIG_INFINIBAND_MTHCA_DEBUG */
+
 #define mthca_err(mdev, format, arg...) \
 	dev_err(&mdev->pdev->dev, format, ## arg)
 #define mthca_info(mdev, format, arg...) \
@@ -492,6 +508,7 @@ void mthca_free_srq(struct mthca_dev *de
 int mthca_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 		     enum ib_srq_attr_mask attr_mask);
 int mthca_query_srq(struct ib_srq *srq, struct ib_srq_attr *srq_attr);
+int mthca_max_srq_sge(struct mthca_dev *dev);
 void mthca_srq_event(struct mthca_dev *dev, u32 srqn,
 		     enum ib_event_type event_type);
 void mthca_free_srq_wqe(struct mthca_srq *srq, u32 wqe_addr);
@@ -542,6 +559,8 @@ int mthca_read_ah(struct mthca_dev *dev,
 		  struct ib_ud_header *header);
 int mthca_ah_query(struct ib_ah *ibah, struct ib_ah_attr *attr);
 int mthca_ah_grh_present(struct mthca_ah *ah);
+u8 mthca_get_rate(struct mthca_dev *dev, int static_rate, u8 port);
+enum ib_rate mthca_rate_to_ib(struct mthca_dev *dev, u8 mthca_rate, u8 port);
 
 int mthca_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid);
 int mthca_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid);
diff --git a/drivers/infiniband/hw/mthca/mthca_mad.c b/drivers/infiniband/hw/mthca/mthca_mad.c
index dfb482e..f235c7e 100644
--- a/drivers/infiniband/hw/mthca/mthca_mad.c
+++ b/drivers/infiniband/hw/mthca/mthca_mad.c
@@ -49,6 +49,30 @@ enum {
 	MTHCA_VENDOR_CLASS2 = 0xa
 };
 
+int mthca_update_rate(struct mthca_dev *dev, u8 port_num)
+{
+	struct ib_port_attr *tprops = NULL;
+	int                  ret;
+
+	tprops = kmalloc(sizeof *tprops, GFP_KERNEL);
+	if (!tprops)
+		return -ENOMEM;
+
+	ret = ib_query_port(&dev->ib_dev, port_num, tprops);
+	if (ret) {
+		printk(KERN_WARNING "ib_query_port failed (%d) for %s port %d\n",
+		       ret, dev->ib_dev.name, port_num);
+		goto out;
+	}
+
+	dev->rate[port_num - 1] = tprops->active_speed *
+				  ib_width_enum_to_int(tprops->active_width);
+
+out:
+	kfree(tprops);
+	return ret;
+}
+
 static void update_sm_ah(struct mthca_dev *dev,
 			 u8 port_num, u16 lid, u8 sl)
 {
@@ -90,6 +114,7 @@ static void smp_snoop(struct ib_device *
 	     mad->mad_hdr.mgmt_class  == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE) &&
 	    mad->mad_hdr.method     == IB_MGMT_METHOD_SET) {
 		if (mad->mad_hdr.attr_id == IB_SMP_ATTR_PORT_INFO) {
+			mthca_update_rate(to_mdev(ibdev), port_num);
 			update_sm_ah(to_mdev(ibdev), port_num,
 				     be16_to_cpup((__be16 *) (mad->data + 58)),
 				     (*(u8 *) (mad->data + 76)) & 0xf);
@@ -246,6 +271,7 @@ int mthca_create_agents(struct mthca_dev
 {
 	struct ib_mad_agent *agent;
 	int p, q;
+	int ret;
 
 	spin_lock_init(&dev->sm_lock);
 
@@ -255,11 +281,23 @@ int mthca_create_agents(struct mthca_dev
 						      q ? IB_QPT_GSI : IB_QPT_SMI,
 						      NULL, 0, send_handler,
 						      NULL, NULL);
-			if (IS_ERR(agent))
+			if (IS_ERR(agent)) {
+				ret = PTR_ERR(agent);
 				goto err;
+			}
 			dev->send_agent[p][q] = agent;
 		}
 
+
+	for (p = 1; p <= dev->limits.num_ports; ++p) {
+		ret = mthca_update_rate(dev, p);
+		if (ret) {
+			mthca_err(dev, "Failed to obtain port %d rate."
+				  " aborting.\n", p);
+			goto err;
+		}
+	}
+
 	return 0;
 
 err:
@@ -268,7 +306,7 @@ err:
 			if (dev->send_agent[p][q])
 				ib_unregister_mad_agent(dev->send_agent[p][q]);
 
-	return PTR_ERR(agent);
+	return ret;
 }
 
 void __devexit mthca_free_agents(struct mthca_dev *dev)
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 266f347..9b9ff7b 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -52,6 +52,14 @@ MODULE_DESCRIPTION("Mellanox InfiniBand 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRV_VERSION);
 
+#ifdef CONFIG_INFINIBAND_MTHCA_DEBUG
+
+int mthca_debug_level = 0;
+module_param_named(debug_level, mthca_debug_level, int, 0644);
+MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0");
+
+#endif /* CONFIG_INFINIBAND_MTHCA_DEBUG */
+
 #ifdef CONFIG_PCI_MSI
 
 static int msi_x = 0;
@@ -69,6 +77,10 @@ MODULE_PARM_DESC(msi, "attempt to use MS
 
 #endif /* CONFIG_PCI_MSI */
 
+static int tune_pci = 0;
+module_param(tune_pci, int, 0444);
+MODULE_PARM_DESC(tune_pci, "increase PCI burst from the default set by BIOS if nonzero");
+
 static const char mthca_version[] __devinitdata =
 	DRV_NAME ": Mellanox InfiniBand HCA driver v"
 	DRV_VERSION " (" DRV_RELDATE ")\n";
@@ -90,6 +102,9 @@ static int __devinit mthca_tune_pci(stru
 	int cap;
 	u16 val;
 
+	if (!tune_pci)
+		return 0;
+
 	/* First try to max out Read Byte Count */
 	cap = pci_find_capability(mdev->pdev, PCI_CAP_ID_PCIX);
 	if (cap) {
@@ -176,6 +191,7 @@ static int __devinit mthca_dev_lim(struc
 	mdev->limits.reserved_srqs      = dev_lim->reserved_srqs;
 	mdev->limits.reserved_eecs      = dev_lim->reserved_eecs;
 	mdev->limits.max_desc_sz        = dev_lim->max_desc_sz;
+	mdev->limits.max_srq_sge	= mthca_max_srq_sge(mdev);
 	/*
 	 * Subtract 1 from the limit because we need to allocate a
 	 * spare CQE so the HCA HW can tell the difference between an
@@ -191,6 +207,18 @@ static int __devinit mthca_dev_lim(struc
 	mdev->limits.port_width_cap     = dev_lim->max_port_width;
 	mdev->limits.page_size_cap      = ~(u32) (dev_lim->min_page_sz - 1);
 	mdev->limits.flags              = dev_lim->flags;
+	/*
+	 * For old FW that doesn't return static rate support, use a
+	 * value of 0x3 (only static rate values of 0 or 1 are handled),
+	 * except on Sinai, where even old FW can handle static rate
+	 * values of 2 and 3.
+	 */
+	if (dev_lim->stat_rate_support)
+		mdev->limits.stat_rate_support = dev_lim->stat_rate_support;
+	else if (mdev->mthca_flags & MTHCA_FLAG_SINAI_OPT)
+		mdev->limits.stat_rate_support = 0xf;
+	else
+		mdev->limits.stat_rate_support = 0x3;
 
 	/* IB_DEVICE_RESIZE_MAX_WR not supported by driver.
 	   May be doable since hardware supports it for SRQ.
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 2c250bc..565a24b 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -106,7 +106,7 @@ static int mthca_query_device(struct ib_
 	props->max_res_rd_atom     = props->max_qp_rd_atom * props->max_qp;
 	props->max_srq             = mdev->limits.num_srqs - mdev->limits.reserved_srqs;
 	props->max_srq_wr          = mdev->limits.max_srq_wqes;
-	props->max_srq_sge         = mdev->limits.max_sg;
+	props->max_srq_sge         = mdev->limits.max_srq_sge;
 	props->local_ca_ack_delay  = mdev->limits.local_ca_ack_delay;
 	props->atomic_cap          = mdev->limits.flags & DEV_LIM_FLAG_ATOMIC ?
 					IB_ATOMIC_HCA : IB_ATOMIC_NONE;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.h b/drivers/infiniband/hw/mthca/mthca_provider.h
index 2e7f521..6676a78 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.h
+++ b/drivers/infiniband/hw/mthca/mthca_provider.h
@@ -257,6 +257,8 @@ struct mthca_qp {
 	atomic_t               refcount;
 	u32                    qpn;
 	int                    is_direct;
+	u8                     port; /* for SQP and memfree use only */
+	u8                     alt_port; /* for memfree use only */
 	u8                     transport;
 	u8                     state;
 	u8                     atomic_rd_en;
@@ -278,7 +280,6 @@ struct mthca_qp {
 
 struct mthca_sqp {
 	struct mthca_qp qp;
-	int             port;
 	int             pkey_index;
 	u32             qkey;
 	u32             send_psn;
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 057c8e6..f37b0e3 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -248,6 +248,9 @@ void mthca_qp_event(struct mthca_dev *de
 		return;
 	}
 
+	if (event_type == IB_EVENT_PATH_MIG)
+		qp->port = qp->alt_port;
+
 	event.device      = &dev->ib_dev;
 	event.event       = event_type;
 	event.element.qp  = &qp->ibqp;
@@ -392,10 +395,16 @@ static void to_ib_ah_attr(struct mthca_d
 {
 	memset(ib_ah_attr, 0, sizeof *path);
 	ib_ah_attr->port_num 	  = (be32_to_cpu(path->port_pkey) >> 24) & 0x3;
+
+	if (ib_ah_attr->port_num == 0 || ib_ah_attr->port_num > dev->limits.num_ports)
+		return;
+
 	ib_ah_attr->dlid     	  = be16_to_cpu(path->rlid);
 	ib_ah_attr->sl       	  = be32_to_cpu(path->sl_tclass_flowlabel) >> 28;
 	ib_ah_attr->src_path_bits = path->g_mylmc & 0x7f;
-	ib_ah_attr->static_rate   = path->static_rate & 0x7;
+	ib_ah_attr->static_rate   = mthca_rate_to_ib(dev,
+						     path->static_rate & 0x7,
+						     ib_ah_attr->port_num);
 	ib_ah_attr->ah_flags      = (path->g_mylmc & (1 << 7)) ? IB_AH_GRH : 0;
 	if (ib_ah_attr->ah_flags) {
 		ib_ah_attr->grh.sgid_index = path->mgid_index & (dev->limits.gid_table_len - 1);
@@ -455,8 +464,10 @@ int mthca_query_qp(struct ib_qp *ibqp, s
 	qp_attr->cap.max_recv_sge    = qp->rq.max_gs;
 	qp_attr->cap.max_inline_data = qp->max_inline_data;
 
-	to_ib_ah_attr(dev, &qp_attr->ah_attr, &context->pri_path);
-	to_ib_ah_attr(dev, &qp_attr->alt_ah_attr, &context->alt_path);
+	if (qp->transport == RC || qp->transport == UC) {
+		to_ib_ah_attr(dev, &qp_attr->ah_attr, &context->pri_path);
+		to_ib_ah_attr(dev, &qp_attr->alt_ah_attr, &context->alt_path);
+	}
 
 	qp_attr->pkey_index     = be32_to_cpu(context->pri_path.port_pkey) & 0x7f;
 	qp_attr->alt_pkey_index = be32_to_cpu(context->alt_path.port_pkey) & 0x7f;
@@ -484,11 +495,11 @@ out:
 }
 
 static int mthca_path_set(struct mthca_dev *dev, struct ib_ah_attr *ah,
-			  struct mthca_qp_path *path)
+			  struct mthca_qp_path *path, u8 port)
 {
 	path->g_mylmc     = ah->src_path_bits & 0x7f;
 	path->rlid        = cpu_to_be16(ah->dlid);
-	path->static_rate = !!ah->static_rate;
+	path->static_rate = mthca_get_rate(dev, ah->static_rate, port);
 
 	if (ah->ah_flags & IB_AH_GRH) {
 		if (ah->grh.sgid_index >= dev->limits.gid_table_len) {
@@ -634,7 +645,7 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 
 	if (qp->transport == MLX)
 		qp_context->pri_path.port_pkey |=
-			cpu_to_be32(to_msqp(qp)->port << 24);
+			cpu_to_be32(qp->port << 24);
 	else {
 		if (attr_mask & IB_QP_PORT) {
 			qp_context->pri_path.port_pkey |=
@@ -657,7 +668,8 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_AV) {
-		if (mthca_path_set(dev, &attr->ah_attr, &qp_context->pri_path))
+		if (mthca_path_set(dev, &attr->ah_attr, &qp_context->pri_path,
+				   attr_mask & IB_QP_PORT ? attr->port_num : qp->port))
 			return -EINVAL;
 
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_PRIMARY_ADDR_PATH);
@@ -681,7 +693,8 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 			return -EINVAL;
 		}
 
-		if (mthca_path_set(dev, &attr->alt_ah_attr, &qp_context->alt_path))
+		if (mthca_path_set(dev, &attr->alt_ah_attr, &qp_context->alt_path,
+				   attr->alt_ah_attr.port_num))
 			return -EINVAL;
 
 		qp_context->alt_path.port_pkey |= cpu_to_be32(attr->alt_pkey_index |
@@ -791,6 +804,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		qp->atomic_rd_en = attr->qp_access_flags;
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
 		qp->resp_depth = attr->max_dest_rd_atomic;
+	if (attr_mask & IB_QP_PORT)
+		qp->port = attr->port_num;
+	if (attr_mask & IB_QP_ALT_PATH)
+		qp->alt_port = attr->alt_port_num;
 
 	if (is_sqp(dev, qp))
 		store_attrs(to_msqp(qp), attr, attr_mask);
@@ -802,13 +819,13 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	if (is_qp0(dev, qp)) {
 		if (cur_state != IB_QPS_RTR &&
 		    new_state == IB_QPS_RTR)
-			init_port(dev, to_msqp(qp)->port);
+			init_port(dev, qp->port);
 
 		if (cur_state != IB_QPS_RESET &&
 		    cur_state != IB_QPS_ERR &&
 		    (new_state == IB_QPS_RESET ||
 		     new_state == IB_QPS_ERR))
-			mthca_CLOSE_IB(dev, to_msqp(qp)->port, &status);
+			mthca_CLOSE_IB(dev, qp->port, &status);
 	}
 
 	/*
@@ -1212,6 +1229,9 @@ int mthca_alloc_qp(struct mthca_dev *dev
 	if (qp->qpn == -1)
 		return -ENOMEM;
 
+	/* initialize port to zero for error-catching. */
+	qp->port = 0;
+
 	err = mthca_alloc_qp_common(dev, pd, send_cq, recv_cq,
 				    send_policy, qp);
 	if (err) {
@@ -1261,7 +1281,7 @@ int mthca_alloc_sqp(struct mthca_dev *de
 	if (err)
 		goto err_out;
 
-	sqp->port = port;
+	sqp->qp.port      = port;
 	sqp->qp.qpn       = mqpn;
 	sqp->qp.transport = MLX;
 
@@ -1404,10 +1424,10 @@ static int build_mlx_header(struct mthca
 		sqp->ud_header.lrh.source_lid = IB_LID_PERMISSIVE;
 	sqp->ud_header.bth.solicited_event = !!(wr->send_flags & IB_SEND_SOLICITED);
 	if (!sqp->qp.ibqp.qp_num)
-		ib_get_cached_pkey(&dev->ib_dev, sqp->port,
+		ib_get_cached_pkey(&dev->ib_dev, sqp->qp.port,
 				   sqp->pkey_index, &pkey);
 	else
-		ib_get_cached_pkey(&dev->ib_dev, sqp->port,
+		ib_get_cached_pkey(&dev->ib_dev, sqp->qp.port,
 				   wr->wr.ud.pkey_index, &pkey);
 	sqp->ud_header.bth.pkey = cpu_to_be16(pkey);
 	sqp->ud_header.bth.destination_qpn = cpu_to_be32(wr->wr.ud.remote_qpn);
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index 2dd3aea..1cfb0fb 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -192,7 +192,7 @@ int mthca_alloc_srq(struct mthca_dev *de
 
 	/* Sanity check SRQ size before proceeding */
 	if (attr->max_wr  > dev->limits.max_srq_wqes ||
-	    attr->max_sge > dev->limits.max_sg)
+	    attr->max_sge > dev->limits.max_srq_sge)
 		return -EINVAL;
 
 	srq->max      = attr->max_wr;
@@ -660,6 +660,31 @@ int mthca_arbel_post_srq_recv(struct ib_
 	return err;
 }
 
+int mthca_max_srq_sge(struct mthca_dev *dev)
+{
+	if (mthca_is_memfree(dev))
+		return dev->limits.max_sg;
+
+	/*
+	 * SRQ allocations are based on powers of 2 for Tavor,
+	 * (although they only need to be multiples of 16 bytes).
+	 *
+	 * Therefore, we need to base the max number of sg entries on
+	 * the largest power of 2 descriptor size that is <= to the
+	 * actual max WQE descriptor size, rather than return the
+	 * max_sg value given by the firmware (which is based on WQE
+	 * sizes as multiples of 16, not powers of 2).
+	 *
+	 * If SRQ implementation is changed for Tavor to be based on
+	 * multiples of 16, the calculation below can be deleted and
+	 * the FW max_sg value returned.
+	 */
+	return min(dev->limits.max_sg,
+		   ((1 << (fls(dev->limits.max_desc_sz) - 1)) -
+		    sizeof (struct mthca_next_seg)) /
+		   sizeof (struct mthca_data_seg));
+}
+
 int __devinit mthca_init_srq_table(struct mthca_dev *dev)
 {
 	int err;
diff --git a/drivers/infiniband/ulp/ipoib/Kconfig b/drivers/infiniband/ulp/ipoib/Kconfig
index 8d2e04c..13d6d01 100644
--- a/drivers/infiniband/ulp/ipoib/Kconfig
+++ b/drivers/infiniband/ulp/ipoib/Kconfig
@@ -10,8 +10,9 @@ config INFINIBAND_IPOIB
 	  group: <http://www.ietf.org/html.charters/ipoib-charter.html>.
 
 config INFINIBAND_IPOIB_DEBUG
-	bool "IP-over-InfiniBand debugging"
+	bool "IP-over-InfiniBand debugging" if EMBEDDED
 	depends on INFINIBAND_IPOIB
+	default y
 	---help---
 	  This option causes debugging code to be compiled into the
 	  IPoIB driver.  The output can be turned on via the
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index b640107..12a1e05 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -65,6 +65,8 @@ enum {
 
 	IPOIB_RX_RING_SIZE 	  = 128,
 	IPOIB_TX_RING_SIZE 	  = 64,
+	IPOIB_MAX_QUEUE_SIZE	  = 8192,
+	IPOIB_MIN_QUEUE_SIZE	  = 2,
 
 	IPOIB_NUM_WC 		  = 4,
 
@@ -230,6 +232,9 @@ static inline struct ipoib_neigh **to_ip
 				     INFINIBAND_ALEN, sizeof(void *));
 }
 
+struct ipoib_neigh *ipoib_neigh_alloc(struct neighbour *neigh);
+void ipoib_neigh_free(struct ipoib_neigh *neigh);
+
 extern struct workqueue_struct *ipoib_workqueue;
 
 /* functions */
@@ -329,6 +334,8 @@ static inline void ipoib_unregister_debu
 #define ipoib_warn(priv, format, arg...)		\
 	ipoib_printk(KERN_WARNING, priv, format , ## arg)
 
+extern int ipoib_sendq_size;
+extern int ipoib_recvq_size;
 
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
 extern int ipoib_debug_level;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_fs.c b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
index 685258e..5dde380 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_fs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
@@ -213,7 +213,7 @@ static int ipoib_path_seq_show(struct se
 		   gid_buf, path.pathrec.dlid ? "yes" : "no");
 
 	if (path.pathrec.dlid) {
-		rate = ib_sa_rate_enum_to_int(path.pathrec.rate) * 25;
+		rate = ib_rate_to_mult(path.pathrec.rate) * 25;
 
 		seq_printf(file,
 			   "  DLID:     0x%04x\n"
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index ed65202..a54da42 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -161,7 +161,7 @@ static int ipoib_ib_post_receives(struct
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	int i;
 
-	for (i = 0; i < IPOIB_RX_RING_SIZE; ++i) {
+	for (i = 0; i < ipoib_recvq_size; ++i) {
 		if (ipoib_alloc_rx_skb(dev, i)) {
 			ipoib_warn(priv, "failed to allocate receive buffer %d\n", i);
 			return -ENOMEM;
@@ -187,7 +187,7 @@ static void ipoib_ib_handle_wc(struct ne
 	if (wr_id & IPOIB_OP_RECV) {
 		wr_id &= ~IPOIB_OP_RECV;
 
-		if (wr_id < IPOIB_RX_RING_SIZE) {
+		if (wr_id < ipoib_recvq_size) {
 			struct sk_buff *skb  = priv->rx_ring[wr_id].skb;
 			dma_addr_t      addr = priv->rx_ring[wr_id].mapping;
 
@@ -252,9 +252,9 @@ static void ipoib_ib_handle_wc(struct ne
 		struct ipoib_tx_buf *tx_req;
 		unsigned long flags;
 
-		if (wr_id >= IPOIB_TX_RING_SIZE) {
+		if (wr_id >= ipoib_sendq_size) {
 			ipoib_warn(priv, "completion event with wrid %d (> %d)\n",
-				   wr_id, IPOIB_TX_RING_SIZE);
+				   wr_id, ipoib_sendq_size);
 			return;
 		}
 
@@ -275,7 +275,7 @@ static void ipoib_ib_handle_wc(struct ne
 		spin_lock_irqsave(&priv->tx_lock, flags);
 		++priv->tx_tail;
 		if (netif_queue_stopped(dev) &&
-		    priv->tx_head - priv->tx_tail <= IPOIB_TX_RING_SIZE / 2)
+		    priv->tx_head - priv->tx_tail <= ipoib_sendq_size >> 1)
 			netif_wake_queue(dev);
 		spin_unlock_irqrestore(&priv->tx_lock, flags);
 
@@ -344,13 +344,13 @@ void ipoib_send(struct net_device *dev, 
 	 * means we have to make sure everything is properly recorded and
 	 * our state is consistent before we call post_send().
 	 */
-	tx_req = &priv->tx_ring[priv->tx_head & (IPOIB_TX_RING_SIZE - 1)];
+	tx_req = &priv->tx_ring[priv->tx_head & (ipoib_sendq_size - 1)];
 	tx_req->skb = skb;
 	addr = dma_map_single(priv->ca->dma_device, skb->data, skb->len,
 			      DMA_TO_DEVICE);
 	pci_unmap_addr_set(tx_req, mapping, addr);
 
-	if (unlikely(post_send(priv, priv->tx_head & (IPOIB_TX_RING_SIZE - 1),
+	if (unlikely(post_send(priv, priv->tx_head & (ipoib_sendq_size - 1),
 			       address->ah, qpn, addr, skb->len))) {
 		ipoib_warn(priv, "post_send failed\n");
 		++priv->stats.tx_errors;
@@ -363,7 +363,7 @@ void ipoib_send(struct net_device *dev, 
 		address->last_send = priv->tx_head;
 		++priv->tx_head;
 
-		if (priv->tx_head - priv->tx_tail == IPOIB_TX_RING_SIZE) {
+		if (priv->tx_head - priv->tx_tail == ipoib_sendq_size) {
 			ipoib_dbg(priv, "TX ring full, stopping kernel net queue\n");
 			netif_stop_queue(dev);
 		}
@@ -488,7 +488,7 @@ static int recvs_pending(struct net_devi
 	int pending = 0;
 	int i;
 
-	for (i = 0; i < IPOIB_RX_RING_SIZE; ++i)
+	for (i = 0; i < ipoib_recvq_size; ++i)
 		if (priv->rx_ring[i].skb)
 			++pending;
 
@@ -527,7 +527,7 @@ int ipoib_ib_dev_stop(struct net_device 
 			 */
 			while ((int) priv->tx_tail - (int) priv->tx_head < 0) {
 				tx_req = &priv->tx_ring[priv->tx_tail &
-							(IPOIB_TX_RING_SIZE - 1)];
+							(ipoib_sendq_size - 1)];
 				dma_unmap_single(priv->ca->dma_device,
 						 pci_unmap_addr(tx_req, mapping),
 						 tx_req->skb->len,
@@ -536,7 +536,7 @@ int ipoib_ib_dev_stop(struct net_device 
 				++priv->tx_tail;
 			}
 
-			for (i = 0; i < IPOIB_RX_RING_SIZE; ++i)
+			for (i = 0; i < ipoib_recvq_size; ++i)
 				if (priv->rx_ring[i].skb) {
 					dma_unmap_single(priv->ca->dma_device,
 							 pci_unmap_addr(&priv->rx_ring[i],
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 9b0bd7c..cb078a7 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/kernel.h>
 
 #include <linux/if_arp.h>	/* For ARPHRD_xxx */
 
@@ -53,6 +54,14 @@ MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("IP-over-InfiniBand net driver");
 MODULE_LICENSE("Dual BSD/GPL");
 
+int ipoib_sendq_size __read_mostly = IPOIB_TX_RING_SIZE;
+int ipoib_recvq_size __read_mostly = IPOIB_RX_RING_SIZE;
+
+module_param_named(send_queue_size, ipoib_sendq_size, int, 0444);
+MODULE_PARM_DESC(send_queue_size, "Number of descriptors in send queue");
+module_param_named(recv_queue_size, ipoib_recvq_size, int, 0444);
+MODULE_PARM_DESC(recv_queue_size, "Number of descriptors in receive queue");
+
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
 int ipoib_debug_level;
 
@@ -252,8 +261,8 @@ static void path_free(struct net_device 
 		 */
 		if (neigh->ah)
 			ipoib_put_ah(neigh->ah);
-		*to_ipoib_neigh(neigh->neighbour) = NULL;
-		kfree(neigh);
+
+		ipoib_neigh_free(neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -327,9 +336,8 @@ void ipoib_flush_paths(struct net_device
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_path *path, *tp;
 	LIST_HEAD(remove_list);
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irq(&priv->lock);
 
 	list_splice(&priv->path_list, &remove_list);
 	INIT_LIST_HEAD(&priv->path_list);
@@ -337,14 +345,15 @@ void ipoib_flush_paths(struct net_device
 	list_for_each_entry(path, &remove_list, list)
 		rb_erase(&path->rb_node, &priv->path_tree);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
-
 	list_for_each_entry_safe(path, tp, &remove_list, list) {
 		if (path->query)
 			ib_sa_cancel_query(path->query_id, path->query);
+		spin_unlock_irq(&priv->lock);
 		wait_for_completion(&path->done);
 		path_free(dev, path);
+		spin_lock_irq(&priv->lock);
 	}
+	spin_unlock_irq(&priv->lock);
 }
 
 static void path_rec_completion(int status,
@@ -373,16 +382,9 @@ static void path_rec_completion(int stat
 		struct ib_ah_attr av = {
 			.dlid 	       = be16_to_cpu(pathrec->dlid),
 			.sl 	       = pathrec->sl,
-			.port_num      = priv->port
+			.port_num      = priv->port,
+			.static_rate   = pathrec->rate
 		};
-		int path_rate = ib_sa_rate_enum_to_int(pathrec->rate);
-
-		if (path_rate > 0 && priv->local_rate > path_rate)
-			av.static_rate = (priv->local_rate - 1) / path_rate;
-
-		ipoib_dbg(priv, "static_rate %d for local port %dX, path %dX\n",
-			  av.static_rate, priv->local_rate,
-			  ib_sa_rate_enum_to_int(pathrec->rate));
 
 		ah = ipoib_create_ah(dev, priv->pd, &av);
 	}
@@ -481,7 +483,7 @@ static void neigh_add_path(struct sk_buf
 	struct ipoib_path *path;
 	struct ipoib_neigh *neigh;
 
-	neigh = kmalloc(sizeof *neigh, GFP_ATOMIC);
+	neigh = ipoib_neigh_alloc(skb->dst->neighbour);
 	if (!neigh) {
 		++priv->stats.tx_dropped;
 		dev_kfree_skb_any(skb);
@@ -489,8 +491,6 @@ static void neigh_add_path(struct sk_buf
 	}
 
 	skb_queue_head_init(&neigh->queue);
-	neigh->neighbour = skb->dst->neighbour;
-	*to_ipoib_neigh(skb->dst->neighbour) = neigh;
 
 	/*
 	 * We can only be called from ipoib_start_xmit, so we're
@@ -503,7 +503,7 @@ static void neigh_add_path(struct sk_buf
 		path = path_rec_create(dev,
 				       (union ib_gid *) (skb->dst->neighbour->ha + 4));
 		if (!path)
-			goto err;
+			goto err_path;
 
 		__path_add(dev, path);
 	}
@@ -521,17 +521,17 @@ static void neigh_add_path(struct sk_buf
 		__skb_queue_tail(&neigh->queue, skb);
 
 		if (!path->query && path_rec_start(dev, path))
-			goto err;
+			goto err_list;
 	}
 
 	spin_unlock(&priv->lock);
 	return;
 
-err:
-	*to_ipoib_neigh(skb->dst->neighbour) = NULL;
+err_list:
 	list_del(&neigh->list);
-	kfree(neigh);
 
+err_path:
+	ipoib_neigh_free(neigh);
 	++priv->stats.tx_dropped;
 	dev_kfree_skb_any(skb);
 
@@ -763,8 +763,7 @@ static void ipoib_neigh_destructor(struc
 		if (neigh->ah)
 			ah = neigh->ah;
 		list_del(&neigh->list);
-		*to_ipoib_neigh(n) = NULL;
-		kfree(neigh);
+		ipoib_neigh_free(neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -773,6 +772,26 @@ static void ipoib_neigh_destructor(struc
 		ipoib_put_ah(ah);
 }
 
+struct ipoib_neigh *ipoib_neigh_alloc(struct neighbour *neighbour)
+{
+	struct ipoib_neigh *neigh;
+
+	neigh = kmalloc(sizeof *neigh, GFP_ATOMIC);
+	if (!neigh)
+		return NULL;
+
+	neigh->neighbour = neighbour;
+	*to_ipoib_neigh(neighbour) = neigh;
+
+	return neigh;
+}
+
+void ipoib_neigh_free(struct ipoib_neigh *neigh)
+{
+	*to_ipoib_neigh(neigh->neighbour) = NULL;
+	kfree(neigh);
+}
+
 static int ipoib_neigh_setup_dev(struct net_device *dev, struct neigh_parms *parms)
 {
 	parms->neigh_destructor = ipoib_neigh_destructor;
@@ -785,20 +804,19 @@ int ipoib_dev_init(struct net_device *de
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
 	/* Allocate RX/TX "rings" to hold queued skbs */
-
-	priv->rx_ring =	kzalloc(IPOIB_RX_RING_SIZE * sizeof (struct ipoib_rx_buf),
+	priv->rx_ring =	kzalloc(ipoib_recvq_size * sizeof *priv->rx_ring,
 				GFP_KERNEL);
 	if (!priv->rx_ring) {
 		printk(KERN_WARNING "%s: failed to allocate RX ring (%d entries)\n",
-		       ca->name, IPOIB_RX_RING_SIZE);
+		       ca->name, ipoib_recvq_size);
 		goto out;
 	}
 
-	priv->tx_ring = kzalloc(IPOIB_TX_RING_SIZE * sizeof (struct ipoib_tx_buf),
+	priv->tx_ring = kzalloc(ipoib_sendq_size * sizeof *priv->tx_ring,
 				GFP_KERNEL);
 	if (!priv->tx_ring) {
 		printk(KERN_WARNING "%s: failed to allocate TX ring (%d entries)\n",
-		       ca->name, IPOIB_TX_RING_SIZE);
+		       ca->name, ipoib_sendq_size);
 		goto out_rx_ring_cleanup;
 	}
 
@@ -866,7 +884,7 @@ static void ipoib_setup(struct net_devic
 	dev->hard_header_len 	 = IPOIB_ENCAP_LEN + INFINIBAND_ALEN;
 	dev->addr_len 		 = INFINIBAND_ALEN;
 	dev->type 		 = ARPHRD_INFINIBAND;
-	dev->tx_queue_len 	 = IPOIB_TX_RING_SIZE * 2;
+	dev->tx_queue_len 	 = ipoib_sendq_size * 2;
 	dev->features            = NETIF_F_VLAN_CHALLENGED | NETIF_F_LLTX;
 
 	/* MTU will be reset when mcast join happens */
@@ -1118,6 +1136,14 @@ static int __init ipoib_init_module(void
 {
 	int ret;
 
+	ipoib_recvq_size = roundup_pow_of_two(ipoib_recvq_size);
+	ipoib_recvq_size = min(ipoib_recvq_size, IPOIB_MAX_QUEUE_SIZE);
+	ipoib_recvq_size = max(ipoib_recvq_size, IPOIB_MIN_QUEUE_SIZE);
+
+	ipoib_sendq_size = roundup_pow_of_two(ipoib_sendq_size);
+	ipoib_sendq_size = min(ipoib_sendq_size, IPOIB_MAX_QUEUE_SIZE);
+	ipoib_sendq_size = max(ipoib_sendq_size, IPOIB_MIN_QUEUE_SIZE);
+
 	ret = ipoib_register_debugfs();
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 93c462e..1dae4b2 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -114,8 +114,7 @@ static void ipoib_mcast_free(struct ipoi
 		 */
 		if (neigh->ah)
 			ipoib_put_ah(neigh->ah);
-		*to_ipoib_neigh(neigh->neighbour) = NULL;
-		kfree(neigh);
+		ipoib_neigh_free(neigh);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -251,6 +250,7 @@ static int ipoib_mcast_join_finish(struc
 			.port_num      = priv->port,
 			.sl	       = mcast->mcmember.sl,
 			.ah_flags      = IB_AH_GRH,
+			.static_rate   = mcast->mcmember.rate,
 			.grh	       = {
 				.flow_label    = be32_to_cpu(mcast->mcmember.flow_label),
 				.hop_limit     = mcast->mcmember.hop_limit,
@@ -258,17 +258,8 @@ static int ipoib_mcast_join_finish(struc
 				.traffic_class = mcast->mcmember.traffic_class
 			}
 		};
-		int path_rate = ib_sa_rate_enum_to_int(mcast->mcmember.rate);
-
 		av.grh.dgid = mcast->mcmember.mgid;
 
-		if (path_rate > 0 && priv->local_rate > path_rate)
-			av.static_rate = (priv->local_rate - 1) / path_rate;
-
-		ipoib_dbg_mcast(priv, "static_rate %d for local port %dX, mcmember %dX\n",
-				av.static_rate, priv->local_rate,
-				ib_sa_rate_enum_to_int(mcast->mcmember.rate));
-
 		ah = ipoib_create_ah(dev, priv->pd, &av);
 		if (!ah) {
 			ipoib_warn(priv, "ib_address_create failed\n");
@@ -618,6 +609,22 @@ int ipoib_mcast_start_thread(struct net_
 	return 0;
 }
 
+static void wait_for_mcast_join(struct ipoib_dev_priv *priv,
+				struct ipoib_mcast *mcast)
+{
+	spin_lock_irq(&priv->lock);
+	if (mcast && mcast->query) {
+		ib_sa_cancel_query(mcast->query_id, mcast->query);
+		mcast->query = NULL;
+		spin_unlock_irq(&priv->lock);
+		ipoib_dbg_mcast(priv, "waiting for MGID " IPOIB_GID_FMT "\n",
+				IPOIB_GID_ARG(mcast->mcmember.mgid));
+		wait_for_completion(&mcast->done);
+	}
+	else
+		spin_unlock_irq(&priv->lock);
+}
+
 int ipoib_mcast_stop_thread(struct net_device *dev, int flush)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
@@ -637,28 +644,10 @@ int ipoib_mcast_stop_thread(struct net_d
 	if (flush)
 		flush_workqueue(ipoib_workqueue);
 
-	spin_lock_irq(&priv->lock);
-	if (priv->broadcast && priv->broadcast->query) {
-		ib_sa_cancel_query(priv->broadcast->query_id, priv->broadcast->query);
-		priv->broadcast->query = NULL;
-		spin_unlock_irq(&priv->lock);
-		ipoib_dbg_mcast(priv, "waiting for bcast\n");
-		wait_for_completion(&priv->broadcast->done);
-	} else
-		spin_unlock_irq(&priv->lock);
+	wait_for_mcast_join(priv, priv->broadcast);
 
-	list_for_each_entry(mcast, &priv->multicast_list, list) {
-		spin_lock_irq(&priv->lock);
-		if (mcast->query) {
-			ib_sa_cancel_query(mcast->query_id, mcast->query);
-			mcast->query = NULL;
-			spin_unlock_irq(&priv->lock);
-			ipoib_dbg_mcast(priv, "waiting for MGID " IPOIB_GID_FMT "\n",
-					IPOIB_GID_ARG(mcast->mcmember.mgid));
-			wait_for_completion(&mcast->done);
-		} else
-			spin_unlock_irq(&priv->lock);
-	}
+	list_for_each_entry(mcast, &priv->multicast_list, list)
+		wait_for_mcast_join(priv, mcast);
 
 	return 0;
 }
@@ -772,13 +761,11 @@ out:
 		if (skb->dst            &&
 		    skb->dst->neighbour &&
 		    !*to_ipoib_neigh(skb->dst->neighbour)) {
-			struct ipoib_neigh *neigh = kmalloc(sizeof *neigh, GFP_ATOMIC);
+			struct ipoib_neigh *neigh = ipoib_neigh_alloc(skb->dst->neighbour);
 
 			if (neigh) {
 				kref_get(&mcast->ah->ref);
 				neigh->ah  	= mcast->ah;
-				neigh->neighbour = skb->dst->neighbour;
-				*to_ipoib_neigh(skb->dst->neighbour) = neigh;
 				list_add_tail(&neigh->list, &mcast->neigh_list);
 			}
 		}
@@ -913,6 +900,7 @@ void ipoib_mcast_restart_task(void *dev_
 
 	/* We have to cancel outside of the spinlock */
 	list_for_each_entry_safe(mcast, tmcast, &remove_list, list) {
+		wait_for_mcast_join(priv, mcast);
 		ipoib_mcast_leave(mcast->dev, mcast);
 		ipoib_mcast_free(mcast);
 	}
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index 5f03880..1d49d16 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -159,8 +159,8 @@ int ipoib_transport_dev_init(struct net_
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ib_qp_init_attr init_attr = {
 		.cap = {
-			.max_send_wr  = IPOIB_TX_RING_SIZE,
-			.max_recv_wr  = IPOIB_RX_RING_SIZE,
+			.max_send_wr  = ipoib_sendq_size,
+			.max_recv_wr  = ipoib_recvq_size,
 			.max_send_sge = 1,
 			.max_recv_sge = 1
 		},
@@ -175,7 +175,7 @@ int ipoib_transport_dev_init(struct net_
 	}
 
 	priv->cq = ib_create_cq(priv->ca, ipoib_ib_completion, NULL, dev,
-				IPOIB_TX_RING_SIZE + IPOIB_RX_RING_SIZE + 1);
+				ipoib_sendq_size + ipoib_recvq_size + 1);
 	if (IS_ERR(priv->cq)) {
 		printk(KERN_WARNING "%s: failed to create CQ\n", ca->name);
 		goto out_free_pd;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index fd8a95a..5f2b3f6 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1434,6 +1434,7 @@ static int srp_parse_options(const char 
 			p = match_strdup(args);
 			if (strlen(p) != 32) {
 				printk(KERN_WARNING PFX "bad dest GID parameter '%s'\n", p);
+				kfree(p);
 				goto out;
 			}
 
diff --git a/include/rdma/ib_sa.h b/include/rdma/ib_sa.h
index f404fe2..ad63c21 100644
--- a/include/rdma/ib_sa.h
+++ b/include/rdma/ib_sa.h
@@ -91,34 +91,6 @@ enum ib_sa_selector {
 	IB_SA_BEST = 3
 };
 
-enum ib_sa_rate {
-	IB_SA_RATE_2_5_GBPS = 2,
-	IB_SA_RATE_5_GBPS   = 5,
-	IB_SA_RATE_10_GBPS  = 3,
-	IB_SA_RATE_20_GBPS  = 6,
-	IB_SA_RATE_30_GBPS  = 4,
-	IB_SA_RATE_40_GBPS  = 7,
-	IB_SA_RATE_60_GBPS  = 8,
-	IB_SA_RATE_80_GBPS  = 9,
-	IB_SA_RATE_120_GBPS = 10
-};
-
-static inline int ib_sa_rate_enum_to_int(enum ib_sa_rate rate)
-{
-	switch (rate) {
-	case IB_SA_RATE_2_5_GBPS: return  1;
-	case IB_SA_RATE_5_GBPS:   return  2;
-	case IB_SA_RATE_10_GBPS:  return  4;
-	case IB_SA_RATE_20_GBPS:  return  8;
-	case IB_SA_RATE_30_GBPS:  return 12;
-	case IB_SA_RATE_40_GBPS:  return 16;
-	case IB_SA_RATE_60_GBPS:  return 24;
-	case IB_SA_RATE_80_GBPS:  return 32;
-	case IB_SA_RATE_120_GBPS: return 48;
-	default: 	          return -1;
-	}
-}
-
 /*
  * Structures for SA records are named "struct ib_sa_xxx_rec."  No
  * attempt is made to pack structures to match the physical layout of
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c1ad627..6bbf1b3 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -314,6 +314,34 @@ enum ib_ah_flags {
 	IB_AH_GRH	= 1
 };
 
+enum ib_rate {
+	IB_RATE_PORT_CURRENT = 0,
+	IB_RATE_2_5_GBPS = 2,
+	IB_RATE_5_GBPS   = 5,
+	IB_RATE_10_GBPS  = 3,
+	IB_RATE_20_GBPS  = 6,
+	IB_RATE_30_GBPS  = 4,
+	IB_RATE_40_GBPS  = 7,
+	IB_RATE_60_GBPS  = 8,
+	IB_RATE_80_GBPS  = 9,
+	IB_RATE_120_GBPS = 10
+};
+
+/**
+ * ib_rate_to_mult - Convert the IB rate enum to a multiple of the
+ * base rate of 2.5 Gbit/sec.  For example, IB_RATE_5_GBPS will be
+ * converted to 2, since 5 Gbit/sec is 2 * 2.5 Gbit/sec.
+ * @rate: rate to convert.
+ */
+int ib_rate_to_mult(enum ib_rate rate) __attribute_const__;
+
+/**
+ * mult_to_ib_rate - Convert a multiple of 2.5 Gbit/sec to an IB rate
+ * enum.
+ * @mult: multiple to convert.
+ */
+enum ib_rate mult_to_ib_rate(int mult) __attribute_const__;
+
 struct ib_ah_attr {
 	struct ib_global_route	grh;
 	u16			dlid;
