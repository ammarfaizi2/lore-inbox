Return-Path: <linux-kernel-owner+w=401wt.eu-S1753124AbWLSP5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbWLSP5k (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 10:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbWLSP5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 10:57:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36018 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbWLSP5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 10:57:39 -0500
Subject: Re: [PATCH]  powerpc iseries link error in allmodconfig
From: David Woodhouse <dwmw2@infradead.org>
To: Judith Lebzelter <judith@osdl.org>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, paulus@samba.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061108173429.GB14991@shell0.pdx.osdl.net>
References: <20061108173429.GB14991@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 15:57:19 +0000
Message-Id: <1166543839.25827.117.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 09:34 -0800, Judith Lebzelter wrote:
> Choose rpa_vscsi.c over iseries_vscsi.c when building both
> pseries and iseries. 

Would it not be better to make them both work instead?

Untested-but-otherwise-Signed-off-by: David Woodhouse <dwmw2@infradead.org>


--- linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/rpa_vscsi.c~	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/rpa_vscsi.c	2006-12-19 15:42:57.000000000 +0000
@@ -42,14 +42,14 @@ static unsigned int partition_number = -
  * Routines for managing the command/response queue
  */
 /**
- * ibmvscsi_handle_event: - Interrupt handler for crq events
+ * rpavscsi_handle_event: - Interrupt handler for crq events
  * @irq:	number of irq to handle, not used
  * @dev_instance: ibmvscsi_host_data of host that received interrupt
  *
  * Disables interrupts and schedules srp_task
  * Always returns IRQ_HANDLED
  */
-static irqreturn_t ibmvscsi_handle_event(int irq, void *dev_instance)
+static irqreturn_t rpavscsi_handle_event(int irq, void *dev_instance)
 {
 	struct ibmvscsi_host_data *hostdata =
 	    (struct ibmvscsi_host_data *)dev_instance;
@@ -66,9 +66,9 @@ static irqreturn_t ibmvscsi_handle_event
  * Frees irq, deallocates a page for messages, unmaps dma, and unregisters
  * the crq with the hypervisor.
  */
-void ibmvscsi_release_crq_queue(struct crq_queue *queue,
-				struct ibmvscsi_host_data *hostdata,
-				int max_requests)
+static void rpavscsi_release_crq_queue(struct crq_queue *queue,
+				       struct ibmvscsi_host_data *hostdata,
+				       int max_requests)
 {
 	long rc;
 	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
@@ -108,12 +108,13 @@ static struct viosrp_crq *crq_queue_next
 }
 
 /**
- * ibmvscsi_send_crq: - Send a CRQ
+ * rpavscsi_send_crq: - Send a CRQ
  * @hostdata:	the adapter
  * @word1:	the first 64 bits of the data
  * @word2:	the second 64 bits of the data
  */
-int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u64 word2)
+static int rpavscsi_send_crq(struct ibmvscsi_host_data *hostdata,
+			     u64 word1, u64 word2)
 {
 	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
 
@@ -121,10 +122,10 @@ int ibmvscsi_send_crq(struct ibmvscsi_ho
 }
 
 /**
- * ibmvscsi_task: - Process srps asynchronously
+ * rpavscsi_task: - Process srps asynchronously
  * @data:	ibmvscsi_host_data of host
  */
-static void ibmvscsi_task(void *data)
+static void rpavscsi_task(void *data)
 {
 	struct ibmvscsi_host_data *hostdata = (struct ibmvscsi_host_data *)data;
 	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
@@ -189,6 +190,42 @@ static void set_adapter_info(struct ibmv
 }
 
 /**
+ * reset_crq_queue: - resets a crq after a failure
+ * @queue:	crq_queue to initialize and register
+ * @hostdata:	ibmvscsi_host_data of host
+ *
+ */
+static int rpavscsi_reset_crq_queue(struct crq_queue *queue,
+				    struct ibmvscsi_host_data *hostdata)
+{
+	int rc;
+	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
+
+	/* Close the CRQ */
+	do {
+		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
+	} while ((rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
+
+	/* Clean out the queue */
+	memset(queue->msgs, 0x00, PAGE_SIZE);
+	queue->cur = 0;
+
+	set_adapter_info(hostdata);
+
+	/* And re-open it again */
+	rc = plpar_hcall_norets(H_REG_CRQ,
+				vdev->unit_address,
+				queue->msg_token, PAGE_SIZE);
+	if (rc == 2) {
+		/* Adapter is good, but other end is not ready */
+		printk(KERN_WARNING "ibmvscsi: Partner adapter not ready\n");
+	} else if (rc != 0) {
+		printk(KERN_WARNING
+		       "ibmvscsi: couldn't register crq--rc 0x%x\n", rc);
+	}
+	return rc;
+}
+/**
  * initialize_crq_queue: - Initializes and registers CRQ with hypervisor
  * @queue:	crq_queue to initialize and register
  * @hostdata:	ibmvscsi_host_data of host
@@ -197,9 +234,9 @@ static void set_adapter_info(struct ibmv
  * the crq with the hypervisor.
  * Returns zero on success.
  */
-int ibmvscsi_init_crq_queue(struct crq_queue *queue,
-			    struct ibmvscsi_host_data *hostdata,
-			    int max_requests)
+static int rpavscsi_init_crq_queue(struct crq_queue *queue,
+				   struct ibmvscsi_host_data *hostdata,
+				   int max_requests)
 {
 	int rc;
 	int retrc;
@@ -226,7 +263,7 @@ int ibmvscsi_init_crq_queue(struct crq_q
 				queue->msg_token, PAGE_SIZE);
 	if (rc == H_RESOURCE)
 		/* maybe kexecing and resource is busy. try a reset */
-		rc = ibmvscsi_reset_crq_queue(queue,
+		rc = rpavscsi_reset_crq_queue(queue,
 					      hostdata);
 
 	if (rc == 2) {
@@ -239,7 +276,7 @@ int ibmvscsi_init_crq_queue(struct crq_q
 	}
 
 	if (request_irq(vdev->irq,
-			ibmvscsi_handle_event,
+			rpavscsi_handle_event,
 			0, "ibmvscsi", (void *)hostdata) != 0) {
 		printk(KERN_ERR "ibmvscsi: couldn't register irq 0x%x\n",
 		       vdev->irq);
@@ -256,7 +293,7 @@ int ibmvscsi_init_crq_queue(struct crq_q
 	queue->cur = 0;
 	spin_lock_init(&queue->lock);
 
-	tasklet_init(&hostdata->srp_task, (void *)ibmvscsi_task,
+	tasklet_init(&hostdata->srp_task, (void *)rpavscsi_task,
 		     (unsigned long)hostdata);
 
 	return retrc;
@@ -281,8 +318,8 @@ int ibmvscsi_init_crq_queue(struct crq_q
  * @hostdata:	ibmvscsi_host_data of host
  *
  */
-int ibmvscsi_reenable_crq_queue(struct crq_queue *queue,
-				 struct ibmvscsi_host_data *hostdata)
+static int rpavscsi_reenable_crq_queue(struct crq_queue *queue,
+				       struct ibmvscsi_host_data *hostdata)
 {
 	int rc;
 	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
@@ -297,39 +334,10 @@ int ibmvscsi_reenable_crq_queue(struct c
 	return rc;
 }
 
-/**
- * reset_crq_queue: - resets a crq after a failure
- * @queue:	crq_queue to initialize and register
- * @hostdata:	ibmvscsi_host_data of host
- *
- */
-int ibmvscsi_reset_crq_queue(struct crq_queue *queue,
-			      struct ibmvscsi_host_data *hostdata)
-{
-	int rc;
-	struct vio_dev *vdev = to_vio_dev(hostdata->dev);
-
-	/* Close the CRQ */
-	do {
-		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
-	} while ((rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
-
-	/* Clean out the queue */
-	memset(queue->msgs, 0x00, PAGE_SIZE);
-	queue->cur = 0;
-
-	set_adapter_info(hostdata);
-
-	/* And re-open it again */
-	rc = plpar_hcall_norets(H_REG_CRQ,
-				vdev->unit_address,
-				queue->msg_token, PAGE_SIZE);
-	if (rc == 2) {
-		/* Adapter is good, but other end is not ready */
-		printk(KERN_WARNING "ibmvscsi: Partner adapter not ready\n");
-	} else if (rc != 0) {
-		printk(KERN_WARNING
-		       "ibmvscsi: couldn't register crq--rc 0x%x\n", rc);
-	}
-	return rc;
-}
+struct ibmvscsi_ops rpavscsi_ops = {
+	.init_crq_queue = rpavscsi_init_crq_queue,
+	.release_crq_queue = rpavscsi_release_crq_queue,
+	.reset_crq_queue = rpavscsi_reset_crq_queue,
+	.reenable_crq_queue = rpavscsi_reenable_crq_queue,
+	.send_crq = rpavscsi_send_crq,
+};
--- linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/ibmvscsi.c~	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/ibmvscsi.c	2006-12-19 15:53:59.000000000 +0000
@@ -89,6 +89,8 @@ static int max_requests = 50;
 
 #define IBMVSCSI_VERSION "1.5.8"
 
+static struct ibmvscsi_ops *ibmvscsi_ops;
+
 MODULE_DESCRIPTION("IBM Virtual SCSI");
 MODULE_AUTHOR("Dave Boutcher");
 MODULE_LICENSE("GPL");
@@ -567,7 +569,7 @@ static int ibmvscsi_send_srp_event(struc
 	list_add_tail(&evt_struct->list, &hostdata->sent);
 
 	if ((rc =
-	     ibmvscsi_send_crq(hostdata, crq_as_u64[0], crq_as_u64[1])) != 0) {
+	     ibmvscsi_ops->send_crq(hostdata, crq_as_u64[0], crq_as_u64[1])) != 0) {
 		list_del(&evt_struct->list);
 
 		printk(KERN_ERR "ibmvscsi: send error %d\n",
@@ -1183,8 +1185,8 @@ void ibmvscsi_handle_crq(struct viosrp_c
 		case 0x01:	/* Initialization message */
 			printk(KERN_INFO "ibmvscsi: partner initialized\n");
 			/* Send back a response */
-			if (ibmvscsi_send_crq(hostdata,
-					      0xC002000000000000LL, 0) == 0) {
+			if (ibmvscsi_ops->send_crq(hostdata,
+						   0xC002000000000000LL, 0) == 0) {
 				/* Now login */
 				send_srp_login(hostdata);
 			} else {
@@ -1212,10 +1214,10 @@ void ibmvscsi_handle_crq(struct viosrp_c
 			printk(KERN_INFO
 			       "ibmvscsi: Re-enabling adapter!\n");
 			purge_requests(hostdata, DID_REQUEUE);
-			if ((ibmvscsi_reenable_crq_queue(&hostdata->queue,
-							hostdata)) ||
-			    (ibmvscsi_send_crq(hostdata,
-					       0xC001000000000000LL, 0))) {
+			if ((ibmvscsi_ops->reenable_crq_queue(&hostdata->queue,
+							      hostdata)) ||
+			    (ibmvscsi_ops->send_crq(hostdata,
+						    0xC001000000000000LL, 0))) {
 					atomic_set(&hostdata->request_limit,
 						   -1);
 					printk(KERN_ERR
@@ -1228,10 +1230,10 @@ void ibmvscsi_handle_crq(struct viosrp_c
 			       crq->format);
 
 			purge_requests(hostdata, DID_ERROR);
-			if ((ibmvscsi_reset_crq_queue(&hostdata->queue,
-							hostdata)) ||
-			    (ibmvscsi_send_crq(hostdata,
-					       0xC001000000000000LL, 0))) {
+			if ((ibmvscsi_ops->reset_crq_queue(&hostdata->queue,
+							   hostdata)) ||
+			    (ibmvscsi_ops->send_crq(hostdata,
+						    0xC001000000000000LL, 0))) {
 					atomic_set(&hostdata->request_limit,
 						   -1);
 					printk(KERN_ERR
@@ -1517,7 +1519,7 @@ static int ibmvscsi_probe(struct vio_dev
 	atomic_set(&hostdata->request_limit, -1);
 	hostdata->host->max_sectors = 32 * 8; /* default max I/O 32 pages */
 
-	rc = ibmvscsi_init_crq_queue(&hostdata->queue, hostdata, max_requests);
+	rc = ibmvscsi_ops->init_crq_queue(&hostdata->queue, hostdata, max_requests);
 	if (rc != 0 && rc != H_RESOURCE) {
 		printk(KERN_ERR "ibmvscsi: couldn't initialize crq\n");
 		goto init_crq_failed;
@@ -1538,7 +1540,7 @@ static int ibmvscsi_probe(struct vio_dev
 	 * to fail if the other end is not acive.  In that case we don't
 	 * want to scan
 	 */
-	if (ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0) == 0
+	if (ibmvscsi_ops->send_crq(hostdata, 0xC001000000000000LL, 0) == 0
 	    || rc == H_RESOURCE) {
 		/*
 		 * Wait around max init_timeout secs for the adapter to finish
@@ -1564,7 +1566,7 @@ static int ibmvscsi_probe(struct vio_dev
       add_host_failed:
 	release_event_pool(&hostdata->pool, hostdata);
       init_pool_failed:
-	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata, max_requests);
+	ibmvscsi_ops->release_crq_queue(&hostdata->queue, hostdata, max_requests);
       init_crq_failed:
 	scsi_host_put(host);
       scsi_host_alloc_failed:
@@ -1575,8 +1577,8 @@ static int ibmvscsi_remove(struct vio_de
 {
 	struct ibmvscsi_host_data *hostdata = vdev->dev.driver_data;
 	release_event_pool(&hostdata->pool, hostdata);
-	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata,
-				   max_requests);
+	ibmvscsi_ops->release_crq_queue(&hostdata->queue, hostdata,
+					max_requests);
 	
 	scsi_remove_host(hostdata->host);
 	scsi_host_put(hostdata->host);
@@ -1606,6 +1608,11 @@ static struct vio_driver ibmvscsi_driver
 
 int __init ibmvscsi_module_init(void)
 {
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		ibmvscsi_ops = &iseriesvscsi_ops;
+	else
+		ibmvscsi_ops = &rpavscsi_ops;
+
 	return vio_register_driver(&ibmvscsi_driver);
 }
 
--- linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/ibmvscsi.h~	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/ibmvscsi.h	2006-12-19 15:54:18.000000000 +0000
@@ -94,21 +94,25 @@ struct ibmvscsi_host_data {
 };
 
 /* routines for managing a command/response queue */
-int ibmvscsi_init_crq_queue(struct crq_queue *queue,
-			    struct ibmvscsi_host_data *hostdata,
-			    int max_requests);
-void ibmvscsi_release_crq_queue(struct crq_queue *queue,
-				struct ibmvscsi_host_data *hostdata,
-				int max_requests);
-int ibmvscsi_reset_crq_queue(struct crq_queue *queue,
-			      struct ibmvscsi_host_data *hostdata);
-
-int ibmvscsi_reenable_crq_queue(struct crq_queue *queue,
-				struct ibmvscsi_host_data *hostdata);
-
 void ibmvscsi_handle_crq(struct viosrp_crq *crq,
 			 struct ibmvscsi_host_data *hostdata);
-int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata,
-		      u64 word1, u64 word2);
+
+struct ibmvscsi_ops {
+	int (*init_crq_queue)(struct crq_queue *queue,
+			      struct ibmvscsi_host_data *hostdata,
+			      int max_requests);
+	void (*release_crq_queue)(struct crq_queue *queue,
+				  struct ibmvscsi_host_data *hostdata,
+				  int max_requests);
+	int (*reset_crq_queue)(struct crq_queue *queue,
+			       struct ibmvscsi_host_data *hostdata);
+	int (*reenable_crq_queue)(struct crq_queue *queue,
+				  struct ibmvscsi_host_data *hostdata);
+	int (*send_crq)(struct ibmvscsi_host_data *hostdata,
+		       u64 word1, u64 word2);
+};
+
+extern struct ibmvscsi_ops iseriesvscsi_ops;
+extern struct ibmvscsi_ops rpavscsi_ops;
 
 #endif				/* IBMVSCSI_H */
--- linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/iseries_vscsi.c~	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19.ppc64/drivers/scsi/ibmvscsi/iseries_vscsi.c	2006-12-19 15:47:03.000000000 +0000
@@ -53,7 +53,7 @@ struct srp_lp_event {
 /** 
  * standard interface for handling logical partition events.
  */
-static void ibmvscsi_handle_event(struct HvLpEvent *lpevt)
+static void iseriesvscsi_handle_event(struct HvLpEvent *lpevt)
 {
 	struct srp_lp_event *evt = (struct srp_lp_event *)lpevt;
 
@@ -74,9 +74,9 @@ static void ibmvscsi_handle_event(struct
 /* ------------------------------------------------------------
  * Routines for driver initialization
  */
-int ibmvscsi_init_crq_queue(struct crq_queue *queue,
-			    struct ibmvscsi_host_data *hostdata,
-			    int max_requests)
+static int iseriesvscsi_init_crq_queue(struct crq_queue *queue,
+				       struct ibmvscsi_host_data *hostdata,
+				       int max_requests)
 {
 	int rc;
 
@@ -88,7 +88,7 @@ int ibmvscsi_init_crq_queue(struct crq_q
 		goto viopath_open_failed;
 	}
 
-	rc = vio_setHandler(viomajorsubtype_scsi, ibmvscsi_handle_event);
+	rc = vio_setHandler(viomajorsubtype_scsi, iseriesvscsi_handle_event);
 	if (rc < 0) {
 		printk("vio_setHandler failed with rc %d in open_event_path\n",
 		       rc);
@@ -102,9 +102,9 @@ int ibmvscsi_init_crq_queue(struct crq_q
 	return -1;
 }
 
-void ibmvscsi_release_crq_queue(struct crq_queue *queue,
-				struct ibmvscsi_host_data *hostdata,
-				int max_requests)
+static void iseriesvscsi_release_crq_queue(struct crq_queue *queue,
+					   struct ibmvscsi_host_data *hostdata,
+					   int max_requests)
 {
 	vio_clearHandler(viomajorsubtype_scsi);
 	viopath_close(viopath_hostLp, viomajorsubtype_scsi, max_requests);
@@ -117,8 +117,8 @@ void ibmvscsi_release_crq_queue(struct c
  *
  * no-op for iSeries
  */
-int ibmvscsi_reset_crq_queue(struct crq_queue *queue,
-			      struct ibmvscsi_host_data *hostdata)
+static int iseriesvscsi_reset_crq_queue(struct crq_queue *queue,
+					struct ibmvscsi_host_data *hostdata)
 {
 	return 0;
 }
@@ -130,19 +130,20 @@ int ibmvscsi_reset_crq_queue(struct crq_
  *
  * no-op for iSeries
  */
-int ibmvscsi_reenable_crq_queue(struct crq_queue *queue,
-				struct ibmvscsi_host_data *hostdata)
+static int iseriesvscsi_reenable_crq_queue(struct crq_queue *queue,
+					   struct ibmvscsi_host_data *hostdata)
 {
 	return 0;
 }
 
 /**
- * ibmvscsi_send_crq: - Send a CRQ
+ * iseriesvscsi_send_crq: - Send a CRQ
  * @hostdata:	the adapter
  * @word1:	the first 64 bits of the data
  * @word2:	the second 64 bits of the data
  */
-int ibmvscsi_send_crq(struct ibmvscsi_host_data *hostdata, u64 word1, u64 word2)
+static int iseriesvscsi_send_crq(struct ibmvscsi_host_data *hostdata,
+				 u64 word1, u64 word2)
 {
 	single_host_data = hostdata;
 	return HvCallEvent_signalLpEventFast(viopath_hostLp,
@@ -156,3 +157,11 @@ int ibmvscsi_send_crq(struct ibmvscsi_ho
 					     VIOVERSION << 16, word1, word2, 0,
 					     0);
 }
+
+struct ibmvscsi_ops iseriesvscsi_ops = {
+	.init_crq_queue = iseriesvscsi_init_crq_queue,
+	.release_crq_queue = iseriesvscsi_release_crq_queue,
+	.reset_crq_queue = iseriesvscsi_reset_crq_queue,
+	.reenable_crq_queue = iseriesvscsi_reenable_crq_queue,
+	.send_crq = iseriesvscsi_send_crq,
+};

-- 
dwmw2

