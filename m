Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbVKCXMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbVKCXMH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030519AbVKCXLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:11:39 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22347 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030521AbVKCXLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:11:12 -0500
Subject: [git patch review 2/7] [IB] kzalloc() conversions
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 03 Nov 2005 23:10:59 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131059459423-f6e7ac335ed94eef@cisco.com>
In-Reply-To: <1131059459422-6013455baf532b88@cisco.com>
X-OriginalArrivalTime: 03 Nov 2005 23:11:00.0432 (UTC) FILETIME=[DAD54500:01C5E0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc()+memset(,0,) with kzalloc(), for a net savings of 35
source lines and about 500 bytes of text.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/agent.c                |    3 +-
 drivers/infiniband/core/cm.c                   |    6 ++---
 drivers/infiniband/core/device.c               |   10 +-------
 drivers/infiniband/core/mad.c                  |   31 +++++++++---------------
 drivers/infiniband/core/sysfs.c                |    6 ++---
 drivers/infiniband/core/ucm.c                  |    9 ++-----
 drivers/infiniband/core/uverbs_main.c          |    4 +--
 drivers/infiniband/hw/mthca/mthca_mr.c         |    4 +--
 drivers/infiniband/hw/mthca/mthca_profile.c    |    4 +--
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |    8 ++----
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    4 +--
 11 files changed, 27 insertions(+), 62 deletions(-)

applies-to: 184c63c9358b790f4dd3288ea24b8d0c7973247f
de6eb66b56d9df5ce6bd254994f05e065214e8cd
diff --git a/drivers/infiniband/core/agent.c b/drivers/infiniband/core/agent.c
index 0c3c695..7545775 100644
--- a/drivers/infiniband/core/agent.c
+++ b/drivers/infiniband/core/agent.c
@@ -155,13 +155,12 @@ int ib_agent_port_open(struct ib_device 
 	int ret;
 
 	/* Create new device info */
-	port_priv = kmalloc(sizeof *port_priv, GFP_KERNEL);
+	port_priv = kzalloc(sizeof *port_priv, GFP_KERNEL);
 	if (!port_priv) {
 		printk(KERN_ERR SPFX "No memory for ib_agent_port_private\n");
 		ret = -ENOMEM;
 		goto error1;
 	}
-	memset(port_priv, 0, sizeof *port_priv);
 
 	/* Obtain send only MAD agent for SMI QP */
 	port_priv->agent[0] = ib_register_mad_agent(device, port_num,
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 580c3a2..02110e0 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -544,11 +544,10 @@ struct ib_cm_id *ib_create_cm_id(struct 
 	struct cm_id_private *cm_id_priv;
 	int ret;
 
-	cm_id_priv = kmalloc(sizeof *cm_id_priv, GFP_KERNEL);
+	cm_id_priv = kzalloc(sizeof *cm_id_priv, GFP_KERNEL);
 	if (!cm_id_priv)
 		return ERR_PTR(-ENOMEM);
 
-	memset(cm_id_priv, 0, sizeof *cm_id_priv);
 	cm_id_priv->id.state = IB_CM_IDLE;
 	cm_id_priv->id.device = device;
 	cm_id_priv->id.cm_handler = cm_handler;
@@ -621,10 +620,9 @@ static struct cm_timewait_info * cm_crea
 {
 	struct cm_timewait_info *timewait_info;
 
-	timewait_info = kmalloc(sizeof *timewait_info, GFP_KERNEL);
+	timewait_info = kzalloc(sizeof *timewait_info, GFP_KERNEL);
 	if (!timewait_info)
 		return ERR_PTR(-ENOMEM);
-	memset(timewait_info, 0, sizeof *timewait_info);
 
 	timewait_info->work.local_id = local_id;
 	INIT_WORK(&timewait_info->work.work, cm_work_handler,
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 5a6e449..e169e79 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -161,17 +161,9 @@ static int alloc_name(char *name)
  */
 struct ib_device *ib_alloc_device(size_t size)
 {
-	void *dev;
-
 	BUG_ON(size < sizeof (struct ib_device));
 
-	dev = kmalloc(size, GFP_KERNEL);
-	if (!dev)
-		return NULL;
-
-	memset(dev, 0, size);
-
-	return dev;
+	return kzalloc(size, GFP_KERNEL);
 }
 EXPORT_SYMBOL(ib_alloc_device);
 
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 88f9f8c..3d8175e 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -255,12 +255,11 @@ struct ib_mad_agent *ib_register_mad_age
 	}
 
 	/* Allocate structures */
-	mad_agent_priv = kmalloc(sizeof *mad_agent_priv, GFP_KERNEL);
+	mad_agent_priv = kzalloc(sizeof *mad_agent_priv, GFP_KERNEL);
 	if (!mad_agent_priv) {
 		ret = ERR_PTR(-ENOMEM);
 		goto error1;
 	}
-	memset(mad_agent_priv, 0, sizeof *mad_agent_priv);
 
 	mad_agent_priv->agent.mr = ib_get_dma_mr(port_priv->qp_info[qpn].qp->pd,
 						 IB_ACCESS_LOCAL_WRITE);
@@ -448,14 +447,13 @@ struct ib_mad_agent *ib_register_mad_sno
 		goto error1;
 	}
 	/* Allocate structures */
-	mad_snoop_priv = kmalloc(sizeof *mad_snoop_priv, GFP_KERNEL);
+	mad_snoop_priv = kzalloc(sizeof *mad_snoop_priv, GFP_KERNEL);
 	if (!mad_snoop_priv) {
 		ret = ERR_PTR(-ENOMEM);
 		goto error1;
 	}
 
 	/* Now, fill in the various structures */
-	memset(mad_snoop_priv, 0, sizeof *mad_snoop_priv);
 	mad_snoop_priv->qp_info = &port_priv->qp_info[qpn];
 	mad_snoop_priv->agent.device = device;
 	mad_snoop_priv->agent.recv_handler = recv_handler;
@@ -794,10 +792,9 @@ struct ib_mad_send_buf * ib_create_send_
 	    (!rmpp_active && buf_size > sizeof(struct ib_mad)))
 		return ERR_PTR(-EINVAL);
 
-	buf = kmalloc(sizeof *mad_send_wr + buf_size, gfp_mask);
+	buf = kzalloc(sizeof *mad_send_wr + buf_size, gfp_mask);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
-	memset(buf, 0, sizeof *mad_send_wr + buf_size);
 
 	mad_send_wr = buf + buf_size;
 	mad_send_wr->send_buf.mad = buf;
@@ -1039,14 +1036,12 @@ static int method_in_use(struct ib_mad_m
 static int allocate_method_table(struct ib_mad_mgmt_method_table **method)
 {
 	/* Allocate management method table */
-	*method = kmalloc(sizeof **method, GFP_ATOMIC);
+	*method = kzalloc(sizeof **method, GFP_ATOMIC);
 	if (!*method) {
 		printk(KERN_ERR PFX "No memory for "
 		       "ib_mad_mgmt_method_table\n");
 		return -ENOMEM;
 	}
-	/* Clear management method table */
-	memset(*method, 0, sizeof **method);
 
 	return 0;
 }
@@ -1137,15 +1132,14 @@ static int add_nonoui_reg_req(struct ib_
 	class = &port_priv->version[mad_reg_req->mgmt_class_version].class;
 	if (!*class) {
 		/* Allocate management class table for "new" class version */
-		*class = kmalloc(sizeof **class, GFP_ATOMIC);
+		*class = kzalloc(sizeof **class, GFP_ATOMIC);
 		if (!*class) {
 			printk(KERN_ERR PFX "No memory for "
 			       "ib_mad_mgmt_class_table\n");
 			ret = -ENOMEM;
 			goto error1;
 		}
-		/* Clear management class table */
-		memset(*class, 0, sizeof(**class));
+
 		/* Allocate method table for this management class */
 		method = &(*class)->method_table[mgmt_class];
 		if ((ret = allocate_method_table(method)))
@@ -1209,25 +1203,24 @@ static int add_oui_reg_req(struct ib_mad
 				mad_reg_req->mgmt_class_version].vendor;
 	if (!*vendor_table) {
 		/* Allocate mgmt vendor class table for "new" class version */
-		vendor = kmalloc(sizeof *vendor, GFP_ATOMIC);
+		vendor = kzalloc(sizeof *vendor, GFP_ATOMIC);
 		if (!vendor) {
 			printk(KERN_ERR PFX "No memory for "
 			       "ib_mad_mgmt_vendor_class_table\n");
 			goto error1;
 		}
-		/* Clear management vendor class table */
-		memset(vendor, 0, sizeof(*vendor));
+
 		*vendor_table = vendor;
 	}
 	if (!(*vendor_table)->vendor_class[vclass]) {
 		/* Allocate table for this management vendor class */
-		vendor_class = kmalloc(sizeof *vendor_class, GFP_ATOMIC);
+		vendor_class = kzalloc(sizeof *vendor_class, GFP_ATOMIC);
 		if (!vendor_class) {
 			printk(KERN_ERR PFX "No memory for "
 			       "ib_mad_mgmt_vendor_class\n");
 			goto error2;
 		}
-		memset(vendor_class, 0, sizeof(*vendor_class));
+
 		(*vendor_table)->vendor_class[vclass] = vendor_class;
 	}
 	for (i = 0; i < MAX_MGMT_OUI; i++) {
@@ -2524,12 +2517,12 @@ static int ib_mad_port_open(struct ib_de
 	char name[sizeof "ib_mad123"];
 
 	/* Create new device info */
-	port_priv = kmalloc(sizeof *port_priv, GFP_KERNEL);
+	port_priv = kzalloc(sizeof *port_priv, GFP_KERNEL);
 	if (!port_priv) {
 		printk(KERN_ERR PFX "No memory for ib_mad_port_private\n");
 		return -ENOMEM;
 	}
-	memset(port_priv, 0, sizeof *port_priv);
+
 	port_priv->device = device;
 	port_priv->port_num = port_num;
 	spin_lock_init(&port_priv->reg_lock);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 7ce7a6c..b812065 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -307,14 +307,13 @@ static ssize_t show_pma_counter(struct i
 	if (!p->ibdev->process_mad)
 		return sprintf(buf, "N/A (no PMA)\n");
 
-	in_mad  = kmalloc(sizeof *in_mad, GFP_KERNEL);
+	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
 	out_mad = kmalloc(sizeof *in_mad, GFP_KERNEL);
 	if (!in_mad || !out_mad) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	memset(in_mad, 0, sizeof *in_mad);
 	in_mad->mad_hdr.base_version  = 1;
 	in_mad->mad_hdr.mgmt_class    = IB_MGMT_CLASS_PERF_MGMT;
 	in_mad->mad_hdr.class_version = 1;
@@ -508,10 +507,9 @@ static int add_port(struct ib_device *de
 	if (ret)
 		return ret;
 
-	p = kmalloc(sizeof *p, GFP_KERNEL);
+	p = kzalloc(sizeof *p, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
-	memset(p, 0, sizeof *p);
 
 	p->ibdev      = device;
 	p->port_num   = port_num;
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index 2847756..6e15787 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -172,11 +172,10 @@ static struct ib_ucm_context *ib_ucm_ctx
 	struct ib_ucm_context *ctx;
 	int result;
 
-	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof *ctx, GFP_KERNEL);
 	if (!ctx)
 		return NULL;
 
-	memset(ctx, 0, sizeof *ctx);
 	atomic_set(&ctx->ref, 1);
 	init_waitqueue_head(&ctx->wait);
 	ctx->file = file;
@@ -386,11 +385,10 @@ static int ib_ucm_event_handler(struct i
 
 	ctx = cm_id->context;
 
-	uevent = kmalloc(sizeof(*uevent), GFP_KERNEL);
+	uevent = kzalloc(sizeof *uevent, GFP_KERNEL);
 	if (!uevent)
 		goto err1;
 
-	memset(uevent, 0, sizeof(*uevent));
 	uevent->ctx = ctx;
 	uevent->cm_id = cm_id;
 	uevent->resp.uid = ctx->uid;
@@ -1345,11 +1343,10 @@ static void ib_ucm_add_one(struct ib_dev
 	if (!device->alloc_ucontext)
 		return;
 
-	ucm_dev = kmalloc(sizeof *ucm_dev, GFP_KERNEL);
+	ucm_dev = kzalloc(sizeof *ucm_dev, GFP_KERNEL);
 	if (!ucm_dev)
 		return;
 
-	memset(ucm_dev, 0, sizeof *ucm_dev);
 	ucm_dev->ib_dev = device;
 
 	ucm_dev->devnum = find_first_zero_bit(dev_map, IB_UCM_MAX_DEVICES);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index e58a7b2..de6581d 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -725,12 +725,10 @@ static void ib_uverbs_add_one(struct ib_
 	if (!device->alloc_ucontext)
 		return;
 
-	uverbs_dev = kmalloc(sizeof *uverbs_dev, GFP_KERNEL);
+	uverbs_dev = kzalloc(sizeof *uverbs_dev, GFP_KERNEL);
 	if (!uverbs_dev)
 		return;
 
-	memset(uverbs_dev, 0, sizeof *uverbs_dev);
-
 	kref_init(&uverbs_dev->ref);
 
 	spin_lock(&map_lock);
diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
index 1f97a44..e995e2a 100644
--- a/drivers/infiniband/hw/mthca/mthca_mr.c
+++ b/drivers/infiniband/hw/mthca/mthca_mr.c
@@ -140,13 +140,11 @@ static int __devinit mthca_buddy_init(st
 	buddy->max_order = max_order;
 	spin_lock_init(&buddy->lock);
 
-	buddy->bits = kmalloc((buddy->max_order + 1) * sizeof (long *),
+	buddy->bits = kzalloc((buddy->max_order + 1) * sizeof (long *),
 			      GFP_KERNEL);
 	if (!buddy->bits)
 		goto err_out;
 
-	memset(buddy->bits, 0, (buddy->max_order + 1) * sizeof (long *));
-
 	for (i = 0; i <= buddy->max_order; ++i) {
 		s = BITS_TO_LONGS(1 << (buddy->max_order - i));
 		buddy->bits[i] = kmalloc(s * sizeof (long), GFP_KERNEL);
diff --git a/drivers/infiniband/hw/mthca/mthca_profile.c b/drivers/infiniband/hw/mthca/mthca_profile.c
index 0576056..408cd55 100644
--- a/drivers/infiniband/hw/mthca/mthca_profile.c
+++ b/drivers/infiniband/hw/mthca/mthca_profile.c
@@ -80,12 +80,10 @@ u64 mthca_make_profile(struct mthca_dev 
 	struct mthca_resource tmp;
 	int i, j;
 
-	profile = kmalloc(MTHCA_RES_NUM * sizeof *profile, GFP_KERNEL);
+	profile = kzalloc(MTHCA_RES_NUM * sizeof *profile, GFP_KERNEL);
 	if (!profile)
 		return -ENOMEM;
 
-	memset(profile, 0, MTHCA_RES_NUM * sizeof *profile);
-
 	profile[MTHCA_RES_QP].size   = dev_lim->qpc_entry_sz;
 	profile[MTHCA_RES_EEC].size  = dev_lim->eec_entry_sz;
 	profile[MTHCA_RES_SRQ].size  = dev_lim->srq_entry_sz;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 273d5f4..8b67db8 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -729,25 +729,21 @@ int ipoib_dev_init(struct net_device *de
 
 	/* Allocate RX/TX "rings" to hold queued skbs */
 
-	priv->rx_ring =	kmalloc(IPOIB_RX_RING_SIZE * sizeof (struct ipoib_rx_buf),
+	priv->rx_ring =	kzalloc(IPOIB_RX_RING_SIZE * sizeof (struct ipoib_rx_buf),
 				GFP_KERNEL);
 	if (!priv->rx_ring) {
 		printk(KERN_WARNING "%s: failed to allocate RX ring (%d entries)\n",
 		       ca->name, IPOIB_RX_RING_SIZE);
 		goto out;
 	}
-	memset(priv->rx_ring, 0,
-	       IPOIB_RX_RING_SIZE * sizeof (struct ipoib_rx_buf));
 
-	priv->tx_ring = kmalloc(IPOIB_TX_RING_SIZE * sizeof (struct ipoib_tx_buf),
+	priv->tx_ring = kzalloc(IPOIB_TX_RING_SIZE * sizeof (struct ipoib_tx_buf),
 				GFP_KERNEL);
 	if (!priv->tx_ring) {
 		printk(KERN_WARNING "%s: failed to allocate TX ring (%d entries)\n",
 		       ca->name, IPOIB_TX_RING_SIZE);
 		goto out_rx_ring_cleanup;
 	}
-	memset(priv->tx_ring, 0,
-	       IPOIB_TX_RING_SIZE * sizeof (struct ipoib_tx_buf));
 
 	/* priv->tx_head & tx_tail are already 0 */
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 36ce298..022eec7 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -135,12 +135,10 @@ static struct ipoib_mcast *ipoib_mcast_a
 {
 	struct ipoib_mcast *mcast;
 
-	mcast = kmalloc(sizeof (*mcast), can_sleep ? GFP_KERNEL : GFP_ATOMIC);
+	mcast = kzalloc(sizeof *mcast, can_sleep ? GFP_KERNEL : GFP_ATOMIC);
 	if (!mcast)
 		return NULL;
 
-	memset(mcast, 0, sizeof (*mcast));
-
 	init_completion(&mcast->done);
 
 	mcast->dev = dev;
---
0.99.9
