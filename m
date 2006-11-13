Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWKMRmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWKMRmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWKMRmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:42:39 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:58473 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932088AbWKMRmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:42:37 -0500
X-IronPort-AV: i="4.09,418,1157353200"; 
   d="scan'208"; a="2153239:sNHT11726356716"
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Nov 2006 09:42:24 -0800
Message-ID: <adapsbr451b.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Nov 2006 17:42:26.0276 (UTC) FILETIME=[15300A40:01C7074B]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This includes various small fixes for 2.6.19-rc6:

Hoang-Nam Nguyen (3):
      IB/ehca: Assure 4K alignment for firmware control blocks
      IB/ehca: Use named constant for max mtu
      IB/ehca: Activate scaling code by default

Jean Delvare (1):
      RDMA/amso1100: Fix && typo

Roland Dreier (1):
      IB/mad: Fix race between cancel and receive completion

Tom Tucker (1):
      RDMA/amso1100: Fix unitialized pseudo_netdev accessed in c2_register_device

 drivers/infiniband/core/mad.c                |    2 +-
 drivers/infiniband/hw/amso1100/c2.c          |    3 +-
 drivers/infiniband/hw/amso1100/c2_provider.c |   39 +++++++++---------
 drivers/infiniband/hw/amso1100/c2_rnic.c     |    4 +-
 drivers/infiniband/hw/ehca/Kconfig           |    1 +
 drivers/infiniband/hw/ehca/ehca_av.c         |    5 +-
 drivers/infiniband/hw/ehca/ehca_hca.c        |   17 ++++----
 drivers/infiniband/hw/ehca/ehca_irq.c        |   17 ++++----
 drivers/infiniband/hw/ehca/ehca_iverbs.h     |    8 ++++
 drivers/infiniband/hw/ehca/ehca_main.c       |   56 +++++++++++++++++++++----
 drivers/infiniband/hw/ehca/ehca_mrmw.c       |    8 ++--
 drivers/infiniband/hw/ehca/ehca_qp.c         |   10 ++--
 drivers/infiniband/hw/ehca/hipz_hw.h         |    2 +
 13 files changed, 111 insertions(+), 61 deletions(-)

The full log and patch is below:

commit 39798695b4bcc7b145f8910ca56195808d3a7637
Author: Roland Dreier <rolandd@cisco.com>
Date:   Mon Nov 13 09:38:07 2006 -0800

    IB/mad: Fix race between cancel and receive completion
    
    When ib_cancel_mad() is called, it puts the canceled send on a list
    and schedules a "flushed" callback from process context.  However,
    this leaves a window where a receive completion could be processed
    before the send is fully flushed.
    
    This is fine, except that ib_find_send_mad() will find the MAD and
    return it to the receive processing, which results in the sender
    getting both a successful receive and a "flushed" send completion for
    the same request.  Understandably, this confuses the sender, which is
    expecting only one of these two callbacks, and leads to grief such as
    a use-after-free in IPoIB.
    
    Fix this by changing ib_find_send_mad() to return a send struct only
    if the status is still successful (and not "flushed").  The search of
    the send_list already had this check, so this patch just adds the same
    check to the search of the wait_list.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit b26c791e9ca3365616d40836000285931ca033d0
Author: Jean Delvare <khali@linux-fr.org>
Date:   Thu Nov 9 21:02:26 2006 +0100

    RDMA/amso1100: Fix && typo
    
    Fix the AMSO1100 firmware version computation, which was broken
    due to "&&" being used where "&" should have.
    
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 2ffcab6ae44b02679229ca1852526d0a6e062dd2
Author: Tom Tucker <tom@opengridcomputing.com>
Date:   Wed Nov 8 14:23:22 2006 -0600

    RDMA/amso1100: Fix unitialized pseudo_netdev accessed in c2_register_device
    
    Rework some load-time error handling: c2_register_device() leaked when
    it failed, and the function that called it didn't check the return code.
    
    Signed-off-by: Tom Tucker <tom@opengridcomputing.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit f2c238a0c5e155acd49752c5fb93fb8d8534232b
Author: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Date:   Sun Nov 5 21:42:20 2006 +0100

    IB/ehca: Activate scaling code by default
    
    Change ehca's Kconfig to activates scaling code as default.  After
    several measurements we saw that this feature prevents dropped packets
    (UD) in stress situation. Thus, enabling it helps to improve ehca's
    bandwidth through IPoIB.
    
    Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit c58121143f87930621c1a6fa9683b6862f2b42c9
Author: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Date:   Sun Nov 5 21:42:56 2006 +0100

    IB/ehca: Use named constant for max mtu
    
    Define and use a constant EHCA_MAX_MTU instead hardcoded value.
    
    Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 7e28db5d8ff63b1cabc221c5cb84a5f45752f1c2
Author: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Date:   Tue Nov 7 00:56:39 2006 +0100

    IB/ehca: Assure 4K alignment for firmware control blocks
    
    Assure 4K alignment for firmware control blocks in 64K page mode,
    because kzalloc()'s result address might not be 4K aligned if 64K
    pages are enabled. Thus, we introduce wrappers called
    ehca_{alloc,free}_fw_ctrlblock(), which use a slab cache for objects
    with 4K length and 4K alignment in order to alloc/free firmware
    control blocks in 64K page mode. In 4K page mode those wrappers just
    are defines of get_zeroed_page() and free_page().
    
    Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 39798695b4bcc7b145f8910ca56195808d3a7637
Author: Roland Dreier <rolandd@cisco.com>
Date:   Mon Nov 13 09:38:07 2006 -0800

    IB/mad: Fix race between cancel and receive completion
    
    When ib_cancel_mad() is called, it puts the canceled send on a list
    and schedules a "flushed" callback from process context.  However,
    this leaves a window where a receive completion could be processed
    before the send is fully flushed.
    
    This is fine, except that ib_find_send_mad() will find the MAD and
    return it to the receive processing, which results in the sender
    getting both a successful receive and a "flushed" send completion for
    the same request.  Understandably, this confuses the sender, which is
    expecting only one of these two callbacks, and leads to grief such as
    a use-after-free in IPoIB.
    
    Fix this by changing ib_find_send_mad() to return a send struct only
    if the status is still successful (and not "flushed").  The search of
    the send_list already had this check, so this patch just adds the same
    check to the search of the wait_list.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit b26c791e9ca3365616d40836000285931ca033d0
Author: Jean Delvare <khali@linux-fr.org>
Date:   Thu Nov 9 21:02:26 2006 +0100

    RDMA/amso1100: Fix && typo
    
    Fix the AMSO1100 firmware version computation, which was broken
    due to "&&" being used where "&" should have.
    
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 2ffcab6ae44b02679229ca1852526d0a6e062dd2
Author: Tom Tucker <tom@opengridcomputing.com>
Date:   Wed Nov 8 14:23:22 2006 -0600

    RDMA/amso1100: Fix unitialized pseudo_netdev accessed in c2_register_device
    
    Rework some load-time error handling: c2_register_device() leaked when
    it failed, and the function that called it didn't check the return code.
    
    Signed-off-by: Tom Tucker <tom@opengridcomputing.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit f2c238a0c5e155acd49752c5fb93fb8d8534232b
Author: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Date:   Sun Nov 5 21:42:20 2006 +0100

    IB/ehca: Activate scaling code by default
    
    Change ehca's Kconfig to activates scaling code as default.  After
    several measurements we saw that this feature prevents dropped packets
    (UD) in stress situation. Thus, enabling it helps to improve ehca's
    bandwidth through IPoIB.
    
    Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit c58121143f87930621c1a6fa9683b6862f2b42c9
Author: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Date:   Sun Nov 5 21:42:56 2006 +0100

    IB/ehca: Use named constant for max mtu
    
    Define and use a constant EHCA_MAX_MTU instead hardcoded value.
    
    Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 7e28db5d8ff63b1cabc221c5cb84a5f45752f1c2
Author: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Date:   Tue Nov 7 00:56:39 2006 +0100

    IB/ehca: Assure 4K alignment for firmware control blocks
    
    Assure 4K alignment for firmware control blocks in 64K page mode,
    because kzalloc()'s result address might not be 4K aligned if 64K
    pages are enabled. Thus, we introduce wrappers called
    ehca_{alloc,free}_fw_ctrlblock(), which use a slab cache for objects
    with 4K length and 4K alignment in order to alloc/free firmware
    control blocks in 64K page mode. In 4K page mode those wrappers just
    are defines of get_zeroed_page() and free_page().
    
    Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>


diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 493f4c6..a72bcea 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -1750,7 +1750,7 @@ ib_find_send_mad(struct ib_mad_agent_pri
 		     */
 		    (is_direct(wc->recv_buf.mad->mad_hdr.mgmt_class) ||
 		     rcv_has_same_gid(mad_agent_priv, wr, wc)))
-			return wr;
+			return (wr->status == IB_WC_SUCCESS) ? wr : NULL;
 	}
 
 	/*
diff --git a/drivers/infiniband/hw/amso1100/c2.c b/drivers/infiniband/hw/amso1100/c2.c
index 9e7bd94..27fe242 100644
--- a/drivers/infiniband/hw/amso1100/c2.c
+++ b/drivers/infiniband/hw/amso1100/c2.c
@@ -1155,7 +1155,8 @@ static int __devinit c2_probe(struct pci
 		goto bail10;
 	}
 
-	c2_register_device(c2dev);
+	if (c2_register_device(c2dev))
+		goto bail10;
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/amso1100/c2_provider.c b/drivers/infiniband/hw/amso1100/c2_provider.c
index da98d9f..fef9727 100644
--- a/drivers/infiniband/hw/amso1100/c2_provider.c
+++ b/drivers/infiniband/hw/amso1100/c2_provider.c
@@ -757,20 +757,17 @@ #endif
 
 int c2_register_device(struct c2_dev *dev)
 {
-	int ret;
+	int ret = -ENOMEM;
 	int i;
 
 	/* Register pseudo network device */
 	dev->pseudo_netdev = c2_pseudo_netdev_init(dev);
-	if (dev->pseudo_netdev) {
-		ret = register_netdev(dev->pseudo_netdev);
-		if (ret) {
-			printk(KERN_ERR PFX
-				"Unable to register netdev, ret = %d\n", ret);
-			free_netdev(dev->pseudo_netdev);
-			return ret;
-		}
-	}
+	if (!dev->pseudo_netdev)
+		goto out3;
+
+	ret = register_netdev(dev->pseudo_netdev);
+	if (ret)
+		goto out2;
 
 	pr_debug("%s:%u\n", __FUNCTION__, __LINE__);
 	strlcpy(dev->ibdev.name, "amso%d", IB_DEVICE_NAME_MAX);
@@ -848,21 +845,25 @@ int c2_register_device(struct c2_dev *de
 
 	ret = ib_register_device(&dev->ibdev);
 	if (ret)
-		return ret;
+		goto out1;
 
 	for (i = 0; i < ARRAY_SIZE(c2_class_attributes); ++i) {
 		ret = class_device_create_file(&dev->ibdev.class_dev,
 					       c2_class_attributes[i]);
-		if (ret) {
-			unregister_netdev(dev->pseudo_netdev);
-			free_netdev(dev->pseudo_netdev);
-			ib_unregister_device(&dev->ibdev);
-			return ret;
-		}
+		if (ret)
+			goto out0;
 	}
+	goto out3;
 
-	pr_debug("%s:%u\n", __FUNCTION__, __LINE__);
-	return 0;
+out0:
+	ib_unregister_device(&dev->ibdev);
+out1:
+	unregister_netdev(dev->pseudo_netdev);
+out2:
+	free_netdev(dev->pseudo_netdev);
+out3:
+	pr_debug("%s:%u ret=%d\n", __FUNCTION__, __LINE__, ret);
+	return ret;
 }
 
 void c2_unregister_device(struct c2_dev *dev)
diff --git a/drivers/infiniband/hw/amso1100/c2_rnic.c b/drivers/infiniband/hw/amso1100/c2_rnic.c
index 21d9612..623dc95 100644
--- a/drivers/infiniband/hw/amso1100/c2_rnic.c
+++ b/drivers/infiniband/hw/amso1100/c2_rnic.c
@@ -157,8 +157,8 @@ static int c2_rnic_query(struct c2_dev *
 
 	props->fw_ver =
 		((u64)be32_to_cpu(reply->fw_ver_major) << 32) |
-		((be32_to_cpu(reply->fw_ver_minor) && 0xFFFF) << 16) |
-		(be32_to_cpu(reply->fw_ver_patch) && 0xFFFF);
+		((be32_to_cpu(reply->fw_ver_minor) & 0xFFFF) << 16) |
+		(be32_to_cpu(reply->fw_ver_patch) & 0xFFFF);
 	memcpy(&props->sys_image_guid, c2dev->netdev->dev_addr, 6);
 	props->max_mr_size         = 0xFFFFFFFF;
 	props->page_size_cap       = ~(C2_MIN_PAGESIZE-1);
diff --git a/drivers/infiniband/hw/ehca/Kconfig b/drivers/infiniband/hw/ehca/Kconfig
index 922389b..727b10d 100644
--- a/drivers/infiniband/hw/ehca/Kconfig
+++ b/drivers/infiniband/hw/ehca/Kconfig
@@ -10,6 +10,7 @@ config INFINIBAND_EHCA
 config INFINIBAND_EHCA_SCALING
 	bool "Scaling support (EXPERIMENTAL)"
 	depends on IBMEBUS && INFINIBAND_EHCA && HOTPLUG_CPU && EXPERIMENTAL
+	default y
 	---help---
 	eHCA scaling support schedules the CQ callbacks to different CPUs.
 
diff --git a/drivers/infiniband/hw/ehca/ehca_av.c b/drivers/infiniband/hw/ehca/ehca_av.c
index 3bac197..214e2fd 100644
--- a/drivers/infiniband/hw/ehca/ehca_av.c
+++ b/drivers/infiniband/hw/ehca/ehca_av.c
@@ -118,8 +118,7 @@ struct ib_ah *ehca_create_ah(struct ib_p
 		}
 		memcpy(&av->av.grh.word_1, &gid, sizeof(gid));
 	}
-	/* for the time being we use a hard coded PMTU of 2048 Bytes */
-	av->av.pmtu = 4;
+	av->av.pmtu = EHCA_MAX_MTU;
 
 	/* dgid comes in grh.word_3 */
 	memcpy(&av->av.grh.word_3, &ah_attr->grh.dgid,
@@ -193,7 +192,7 @@ int ehca_modify_ah(struct ib_ah *ah, str
 		memcpy(&new_ehca_av.grh.word_1, &gid, sizeof(gid));
 	}
 
-	new_ehca_av.pmtu = 4; /* see also comment in create_ah() */
+	new_ehca_av.pmtu = EHCA_MAX_MTU;
 
 	memcpy(&new_ehca_av.grh.word_3, &ah_attr->grh.dgid,
 	       sizeof(ah_attr->grh.dgid));
diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index 5eae6ac..e1b618c 100644
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
+	rblock = ehca_alloc_fw_ctrlblock();
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
+	rblock = ehca_alloc_fw_ctrlblock();
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
+	rblock = ehca_alloc_fw_ctrlblock();
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
+	rblock = ehca_alloc_fw_ctrlblock();
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
index 048cc44..c3ea746 100644
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
+	rblock = ehca_alloc_fw_ctrlblock();
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
index 319c39d..3720e30 100644
--- a/drivers/infiniband/hw/ehca/ehca_iverbs.h
+++ b/drivers/infiniband/hw/ehca/ehca_iverbs.h
@@ -179,4 +179,12 @@ int ehca_mmap_register(u64 physical,void
 
 int ehca_munmap(unsigned long addr, size_t len);
 
+#ifdef CONFIG_PPC_64K_PAGES
+void *ehca_alloc_fw_ctrlblock(void);
+void ehca_free_fw_ctrlblock(void *ptr);
+#else
+#define ehca_alloc_fw_ctrlblock() ((void *) get_zeroed_page(GFP_KERNEL))
+#define ehca_free_fw_ctrlblock(ptr) free_page((unsigned long)(ptr))
+#endif
+
 #endif
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 024d511..01f5aa9 100644
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
@@ -94,11 +97,31 @@ spinlock_t ehca_cq_idr_lock;
 DEFINE_IDR(ehca_qp_idr);
 DEFINE_IDR(ehca_cq_idr);
 
+
 static struct list_head shca_list; /* list of all registered ehcas */
 static spinlock_t shca_list_lock;
 
 static struct timer_list poll_eqs_timer;
 
+#ifdef CONFIG_PPC_64K_PAGES
+static struct kmem_cache *ctblk_cache = NULL;
+
+void *ehca_alloc_fw_ctrlblock(void)
+{
+	void *ret = kmem_cache_zalloc(ctblk_cache, SLAB_KERNEL);
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
@@ -133,6 +156,17 @@ static int ehca_create_slab_caches(void)
 		goto create_slab_caches5;
 	}
 
+#ifdef CONFIG_PPC_64K_PAGES
+	ctblk_cache = kmem_cache_create("ehca_cache_ctblk",
+					EHCA_PAGESIZE, H_CB_ALIGNMENT,
+					SLAB_HWCACHE_ALIGN,
+					NULL, NULL);
+	if (!ctblk_cache) {
+		ehca_gen_err("Cannot create ctblk SLAB cache.");
+		ehca_cleanup_mrmw_cache();
+		goto create_slab_caches5;
+	}
+#endif
 	return 0;
 
 create_slab_caches5:
@@ -157,6 +191,10 @@ static void ehca_destroy_slab_caches(voi
 	ehca_cleanup_qp_cache();
 	ehca_cleanup_cq_cache();
 	ehca_cleanup_pd_cache();
+#ifdef CONFIG_PPC_64K_PAGES
+	if (ctblk_cache)
+		kmem_cache_destroy(ctblk_cache);
+#endif
 }
 
 #define EHCA_HCAAVER  EHCA_BMASK_IBM(32,39)
@@ -168,7 +206,7 @@ int ehca_sense_attributes(struct ehca_sh
 	u64 h_ret;
 	struct hipz_query_hca *rblock;
 
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	rblock = ehca_alloc_fw_ctrlblock();
 	if (!rblock) {
 		ehca_gen_err("Cannot allocate rblock memory.");
 		return -ENOMEM;
@@ -211,7 +249,7 @@ int ehca_sense_attributes(struct ehca_sh
 	shca->sport[1].rate = IB_RATE_30_GBPS;
 
 num_ports1:
-	kfree(rblock);
+	ehca_free_fw_ctrlblock(rblock);
 	return ret;
 }
 
@@ -220,7 +258,7 @@ static int init_node_guid(struct ehca_sh
 	int ret = 0;
 	struct hipz_query_hca *rblock;
 
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	rblock = ehca_alloc_fw_ctrlblock();
 	if (!rblock) {
 		ehca_err(&shca->ib_device, "Can't allocate rblock memory.");
 		return -ENOMEM;
@@ -235,7 +273,7 @@ static int init_node_guid(struct ehca_sh
 	memcpy(&shca->ib_device.node_guid, &rblock->node_guid, sizeof(u64));
 
 init_node_guid1:
-	kfree(rblock);
+	ehca_free_fw_ctrlblock(rblock);
 	return ret;
 }
 
@@ -431,7 +469,7 @@ static ssize_t  ehca_show_##name(struct
 									   \
 	shca = dev->driver_data;					   \
 									   \
-	rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);			   \
+	rblock = ehca_alloc_fw_ctrlblock();				   \
 	if (!rblock) {						           \
 		dev_err(dev, "Can't allocate rblock memory.");		   \
 		return 0;						   \
@@ -439,12 +477,12 @@ static ssize_t  ehca_show_##name(struct
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
@@ -752,7 +790,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0017)\n");
+	                 "(Rel.: SVNEHCA_0018)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);
diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 5ca6544..abce676 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -1013,7 +1013,7 @@ int ehca_reg_mr_rpages(struct ehca_shca
 	u32 i;
 	u64 *kpage;
 
-	kpage = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	kpage = ehca_alloc_fw_ctrlblock();
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
+	kpage = ehca_alloc_fw_ctrlblock();
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
index 4394123..cf3e50e 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -811,8 +811,8 @@ static int internal_modify_qp(struct ib_
 	unsigned long spl_flags = 0;
 
 	/* do query_qp to obtain current attr values */
-	mqpcb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
-	if (mqpcb == NULL) {
+	mqpcb = ehca_alloc_fw_ctrlblock();
+	if (!mqpcb) {
 		ehca_err(ibqp->device, "Could not get zeroed page for mqpcb "
 			 "ehca_qp=%p qp_num=%x ", my_qp, ibqp->qp_num);
 		return -ENOMEM;
@@ -1225,7 +1225,7 @@ modify_qp_exit2:
 	}
 
 modify_qp_exit1:
-	kfree(mqpcb);
+	ehca_free_fw_ctrlblock(mqpcb);
 
 	return ret;
 }
@@ -1277,7 +1277,7 @@ int ehca_query_qp(struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	qpcb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL );
+	qpcb = ehca_alloc_fw_ctrlblock();
 	if (!qpcb) {
 		ehca_err(qp->device,"Out of memory for qpcb "
 			 "ehca_qp=%p qp_num=%x", my_qp, qp->qp_num);
@@ -1401,7 +1401,7 @@ int ehca_query_qp(struct ib_qp *qp,
 		ehca_dmp(qpcb, 4*70, "qp_num=%x", qp->qp_num);
 
 query_qp_exit1:
-	kfree(qpcb);
+	ehca_free_fw_ctrlblock(qpcb);
 
 	return ret;
 }
diff --git a/drivers/infiniband/hw/ehca/hipz_hw.h b/drivers/infiniband/hw/ehca/hipz_hw.h
index 3fc92b0..fad9136 100644
--- a/drivers/infiniband/hw/ehca/hipz_hw.h
+++ b/drivers/infiniband/hw/ehca/hipz_hw.h
@@ -45,6 +45,8 @@ #define __HIPZ_HW_H__
 
 #include "ehca_tools.h"
 
+#define EHCA_MAX_MTU 4
+
 /* QP Table Entry Memory Map */
 struct hipz_qptemm {
 	u64 qpx_hcr;
