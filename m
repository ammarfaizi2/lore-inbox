Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWAJTb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWAJTb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWAJTbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:31:34 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:3416 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932414AbWAJTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:31:28 -0500
X-IronPort-AV: i="3.99,351,1131350400"; 
   d="scan'208"; a="389971624:sNHT35166052"
Subject: [git patch review 5/7] IB: Add node_guid to struct ib_device
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 10 Jan 2006 19:31:23 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136921483291-1d87adb85e116682@cisco.com>
In-Reply-To: <1136921483290-850b093ba9fe8fda@cisco.com>
X-OriginalArrivalTime: 10 Jan 2006 19:31:25.0145 (UTC) FILETIME=[71D70490:01C6161C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node_guid field to struct ib_device.  It is the responsibility
of the low-level driver to initialize this field before registering a
device with the midlayer.  Convert everyone to looking at this field
instead of calling ib_query_device() when all they want is the node
GUID, and remove the node_guid field from struct ib_device_attr.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/cm.c                 |   29 +++----------------
 drivers/infiniband/core/sysfs.c              |   22 +++-----------
 drivers/infiniband/core/uverbs_cmd.c         |    2 +
 drivers/infiniband/hw/mthca/mthca_provider.c |   40 +++++++++++++++++++++++++-
 drivers/infiniband/ulp/srp/ib_srp.c          |   23 +++------------
 include/rdma/ib_verbs.h                      |    2 +
 6 files changed, 54 insertions(+), 64 deletions(-)

cf311cd49a78f1e431787068cc31d29d06a415e6
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 3a611fe..c06b181 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3163,22 +3163,6 @@ int ib_cm_init_qp_attr(struct ib_cm_id *
 }
 EXPORT_SYMBOL(ib_cm_init_qp_attr);
 
-static __be64 cm_get_ca_guid(struct ib_device *device)
-{
-	struct ib_device_attr *device_attr;
-	__be64 guid;
-	int ret;
-
-	device_attr = kmalloc(sizeof *device_attr, GFP_KERNEL);
-	if (!device_attr)
-		return 0;
-
-	ret = ib_query_device(device, device_attr);
-	guid = ret ? 0 : device_attr->node_guid;
-	kfree(device_attr);
-	return guid;
-}
-
 static void cm_add_one(struct ib_device *device)
 {
 	struct cm_device *cm_dev;
@@ -3200,9 +3184,7 @@ static void cm_add_one(struct ib_device 
 		return;
 
 	cm_dev->device = device;
-	cm_dev->ca_guid = cm_get_ca_guid(device);
-	if (!cm_dev->ca_guid)
-		goto error1;
+	cm_dev->ca_guid = device->node_guid;
 
 	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
 	for (i = 1; i <= device->phys_port_cnt; i++) {
@@ -3217,11 +3199,11 @@ static void cm_add_one(struct ib_device 
 							cm_recv_handler,
 							port);
 		if (IS_ERR(port->mad_agent))
-			goto error2;
+			goto error1;
 
 		ret = ib_modify_port(device, i, 0, &port_modify);
 		if (ret)
-			goto error3;
+			goto error2;
 	}
 	ib_set_client_data(device, &cm_client, cm_dev);
 
@@ -3230,9 +3212,9 @@ static void cm_add_one(struct ib_device 
 	write_unlock_irqrestore(&cm.device_lock, flags);
 	return;
 
-error3:
-	ib_unregister_mad_agent(port->mad_agent);
 error2:
+	ib_unregister_mad_agent(port->mad_agent);
+error1:
 	port_modify.set_port_cap_mask = 0;
 	port_modify.clr_port_cap_mask = IB_PORT_CM_SUP;
 	while (--i) {
@@ -3240,7 +3222,6 @@ error2:
 		ib_modify_port(device, port->port_num, 0, &port_modify);
 		ib_unregister_mad_agent(port->mad_agent);
 	}
-error1:
 	kfree(cm_dev);
 }
 
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 1f1743c..5982d68 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -445,13 +445,7 @@ static int ib_device_uevent(struct class
 		return -ENOMEM;
 
 	/*
-	 * It might be nice to pass the node GUID with the event, but
-	 * right now the only way to get it is to query the device
-	 * provider, and this can crash during device removal because
-	 * we are will be running after driver removal has started.
-	 * We could add a node_guid field to struct ib_device, or we
-	 * could just let userspace read the node GUID from sysfs when
-	 * devices are added.
+	 * It would be nice to pass the node GUID with the event...
 	 */
 
 	envp[i] = NULL;
@@ -623,21 +617,15 @@ static ssize_t show_sys_image_guid(struc
 static ssize_t show_node_guid(struct class_device *cdev, char *buf)
 {
 	struct ib_device *dev = container_of(cdev, struct ib_device, class_dev);
-	struct ib_device_attr attr;
-	ssize_t ret;
 
 	if (!ibdev_is_alive(dev))
 		return -ENODEV;
 
-	ret = ib_query_device(dev, &attr);
-	if (ret)
-		return ret;
-
 	return sprintf(buf, "%04x:%04x:%04x:%04x\n",
-		       be16_to_cpu(((__be16 *) &attr.node_guid)[0]),
-		       be16_to_cpu(((__be16 *) &attr.node_guid)[1]),
-		       be16_to_cpu(((__be16 *) &attr.node_guid)[2]),
-		       be16_to_cpu(((__be16 *) &attr.node_guid)[3]));
+		       be16_to_cpu(((__be16 *) &dev->node_guid)[0]),
+		       be16_to_cpu(((__be16 *) &dev->node_guid)[1]),
+		       be16_to_cpu(((__be16 *) &dev->node_guid)[2]),
+		       be16_to_cpu(((__be16 *) &dev->node_guid)[3]));
 }
 
 static CLASS_DEVICE_ATTR(node_type, S_IRUGO, show_node_type, NULL);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a02c5a0..554c205 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -157,7 +157,7 @@ ssize_t ib_uverbs_query_device(struct ib
 	memset(&resp, 0, sizeof resp);
 
 	resp.fw_ver 		       = attr.fw_ver;
-	resp.node_guid 		       = attr.node_guid;
+	resp.node_guid 		       = file->device->ib_dev->node_guid;
 	resp.sys_image_guid 	       = attr.sys_image_guid;
 	resp.max_mr_size 	       = attr.max_mr_size;
 	resp.page_size_cap 	       = attr.page_size_cap;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 4887577..db35690 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -33,7 +33,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: mthca_provider.c 1397 2004-12-28 05:09:00Z roland $
+ * $Id: mthca_provider.c 4859 2006-01-09 21:55:10Z roland $
  */
 
 #include <rdma/ib_smi.h>
@@ -91,7 +91,6 @@ static int mthca_query_device(struct ib_
 	props->vendor_part_id      = be16_to_cpup((__be16 *) (out_mad->data + 30));
 	props->hw_ver              = be32_to_cpup((__be32 *) (out_mad->data + 32));
 	memcpy(&props->sys_image_guid, out_mad->data +  4, 8);
-	memcpy(&props->node_guid,      out_mad->data + 12, 8);
 
 	props->max_mr_size         = ~0ull;
 	props->page_size_cap       = mdev->limits.page_size_cap;
@@ -1054,11 +1053,48 @@ static struct class_device_attribute *mt
 	&class_device_attr_board_id
 };
 
+static int mthca_init_node_data(struct mthca_dev *dev)
+{
+	struct ib_smp *in_mad  = NULL;
+	struct ib_smp *out_mad = NULL;
+	int err = -ENOMEM;
+	u8 status;
+
+	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
+	out_mad = kmalloc(sizeof *out_mad, GFP_KERNEL);
+	if (!in_mad || !out_mad)
+		goto out;
+
+	init_query_mad(in_mad);
+	in_mad->attr_id = IB_SMP_ATTR_NODE_INFO;
+
+	err = mthca_MAD_IFC(dev, 1, 1,
+			    1, NULL, NULL, in_mad, out_mad,
+			    &status);
+	if (err)
+		goto out;
+	if (status) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	memcpy(&dev->ib_dev.node_guid, out_mad->data + 12, 8);
+
+out:
+	kfree(in_mad);
+	kfree(out_mad);
+	return err;
+}
+
 int mthca_register_device(struct mthca_dev *dev)
 {
 	int ret;
 	int i;
 
+	ret = mthca_init_node_data(dev);
+	if (ret)
+		return ret;
+
 	strlcpy(dev->ib_dev.name, "mthca%d", IB_DEVICE_NAME_MAX);
 	dev->ib_dev.owner                = THIS_MODULE;
 
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index dd488d3..31207e6 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1516,8 +1516,7 @@ static ssize_t show_port(struct class_de
 
 static CLASS_DEVICE_ATTR(port, S_IRUGO, show_port, NULL);
 
-static struct srp_host *srp_add_port(struct ib_device *device,
-				     __be64 node_guid, u8 port)
+static struct srp_host *srp_add_port(struct ib_device *device, u8 port)
 {
 	struct srp_host *host;
 
@@ -1532,7 +1531,7 @@ static struct srp_host *srp_add_port(str
 	host->port = port;
 
 	host->initiator_port_id[7] = port;
-	memcpy(host->initiator_port_id + 8, &node_guid, 8);
+	memcpy(host->initiator_port_id + 8, &device->node_guid, 8);
 
 	host->pd   = ib_alloc_pd(device);
 	if (IS_ERR(host->pd))
@@ -1580,22 +1579,11 @@ static void srp_add_one(struct ib_device
 {
 	struct list_head *dev_list;
 	struct srp_host *host;
-	struct ib_device_attr *dev_attr;
 	int s, e, p;
 
-	dev_attr = kmalloc(sizeof *dev_attr, GFP_KERNEL);
-	if (!dev_attr)
-		return;
-
-	if (ib_query_device(device, dev_attr)) {
-		printk(KERN_WARNING PFX "Couldn't query node GUID for %s.\n",
-		       device->name);
-		goto out;
-	}
-
 	dev_list = kmalloc(sizeof *dev_list, GFP_KERNEL);
 	if (!dev_list)
-		goto out;
+		return;
 
 	INIT_LIST_HEAD(dev_list);
 
@@ -1608,15 +1596,12 @@ static void srp_add_one(struct ib_device
 	}
 
 	for (p = s; p <= e; ++p) {
-		host = srp_add_port(device, dev_attr->node_guid, p);
+		host = srp_add_port(device, p);
 		if (host)
 			list_add_tail(&host->list, dev_list);
 	}
 
 	ib_set_client_data(device, &srp_client, dev_list);
-
-out:
-	kfree(dev_attr);
 }
 
 static void srp_remove_one(struct ib_device *device)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a7f4c35..22fc886 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -88,7 +88,6 @@ enum ib_atomic_cap {
 
 struct ib_device_attr {
 	u64			fw_ver;
-	__be64			node_guid;
 	__be64			sys_image_guid;
 	u64			max_mr_size;
 	u64			page_size_cap;
@@ -951,6 +950,7 @@ struct ib_device {
 	u64			     uverbs_cmd_mask;
 	int			     uverbs_abi_ver;
 
+	__be64			     node_guid;
 	u8                           node_type;
 	u8                           phys_port_cnt;
 };
-- 
1.0.7
