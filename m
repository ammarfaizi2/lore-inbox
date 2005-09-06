Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVIFHuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVIFHuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 03:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVIFHuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 03:50:50 -0400
Received: from ozlabs.org ([203.10.76.45]:62356 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932441AbVIFHut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 03:50:49 -0400
Date: Tue, 6 Sep 2005 17:49:43 +1000
From: Anton Blanchard <anton@samba.org>
To: Linda Xie <lxiep@us.ibm.com>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Dave C Boutcher <sleddog@us.ibm.com>,
       Santiago Leon <santil@us.ibm.com>
Subject: Re: [PATCH] IBM VSCSI Client: handle large scatter/gather lists
Message-ID: <20050906074943.GS6945@krispykreme>
References: <42C2D85E.5010306@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C2D85E.5010306@us.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> The maximum size of a scatter-gather list that the current  IBM VSCSI
> Client can handle is 10.  This patch adds large scatter-gather support
> to the client so that  it is capable of handling  up to SG_ALL(255)
> number of requests in the scatter-gather list.   Please consider it
> for inclusion in upstream.
> 
> Comments are always welcome.  
>
> Linda Xie
> IBM LTC
> 
> Signed-off-by: Linda Xie <lxie@us.ibm.com>

Any chance we could get this into 2.6.14? I just tested it on current
git and as expected the number of sg elements increased. Testing a dd
from a virtual disk with clustering disabled (to avoid physical merging
effects) shows:

before:
size    sg count 
1       12295
2       54
3       28
4       45
5       32
6       19
7       17
8       69
9       13
10      18043

after:
size    sg count 
1       410
2       39
3       24
4       39
5       32
6       12
7       8
8       61
9       7
10      4
11      4
12      3
13      3
16      3
17      10
18      7
19      2
20      9
21      2
25      3
26      3
27      1
29      1
30      3
31      4
32      25844
39      1
43      1
62      1
64      1182

The peak at 32 entries is due to a 256kB limitation on the vscsi server.

Anton

diff -X ../dontdiff -purN madinfo/drivers/scsi/ibmvscsi/ibmvscsi.c large-sg/drivers/scsi/ibmvscsi/ibmvscsi.c
--- madinfo/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-06-24 16:36:16.000000000 -0500
+++ large-sg/drivers/scsi/ibmvscsi/ibmvscsi.c	2005-06-24 17:32:27.000000000 -0500
@@ -87,7 +87,7 @@ static int max_channel = 3;
 static int init_timeout = 5;
 static int max_requests = 50;
 
-#define IBMVSCSI_VERSION "1.5.6"
+#define IBMVSCSI_VERSION "1.5.7"
 
 MODULE_DESCRIPTION("IBM Virtual SCSI");
 MODULE_AUTHOR("Dave Boutcher");
@@ -145,6 +145,8 @@ static int initialize_event_pool(struct 
 			sizeof(*evt->xfer_iu) * i;
 		evt->xfer_iu = pool->iu_storage + i;
 		evt->hostdata = hostdata;
+		evt->ext_list = NULL;
+		evt->ext_list_token = 0;
 	}
 
 	return 0;
@@ -161,9 +163,16 @@ static void release_event_pool(struct ev
 			       struct ibmvscsi_host_data *hostdata)
 {
 	int i, in_use = 0;
-	for (i = 0; i < pool->size; ++i)
+	for (i = 0; i < pool->size; ++i) {
 		if (atomic_read(&pool->events[i].free) != 1)
 			++in_use;
+		if (pool->events[i].ext_list) {
+			dma_free_coherent(hostdata->dev,
+				  SG_ALL * sizeof(struct memory_descriptor),
+				  pool->events[i].ext_list,
+				  pool->events[i].ext_list_token);
+		}
+	}
 	if (in_use)
 		printk(KERN_WARNING
 		       "ibmvscsi: releasing event pool with %d "
@@ -286,24 +295,41 @@ static void set_srp_direction(struct scs
 	} else {
 		if (cmd->sc_data_direction == DMA_TO_DEVICE) {
 			srp_cmd->data_out_format = SRP_INDIRECT_BUFFER;
-			srp_cmd->data_out_count = numbuf;
+			srp_cmd->data_out_count =
+				numbuf < MAX_INDIRECT_BUFS ?
+					numbuf: MAX_INDIRECT_BUFS;
 		} else {
 			srp_cmd->data_in_format = SRP_INDIRECT_BUFFER;
-			srp_cmd->data_in_count = numbuf;
+			srp_cmd->data_in_count =
+				numbuf < MAX_INDIRECT_BUFS ?
+					numbuf: MAX_INDIRECT_BUFS;
 		}
 	}
 }
 
+static void unmap_sg_list(int num_entries, 
+		struct device *dev,
+		struct memory_descriptor *md)
+{ 
+	int i;
+
+	for (i = 0; i < num_entries; ++i) {
+		dma_unmap_single(dev,
+			md[i].virtual_address,
+			md[i].length, DMA_BIDIRECTIONAL);
+	}
+}
+
 /**
  * unmap_cmd_data: - Unmap data pointed in srp_cmd based on the format
  * @cmd:	srp_cmd whose additional_data member will be unmapped
  * @dev:	device for which the memory is mapped
  *
 */
-static void unmap_cmd_data(struct srp_cmd *cmd, struct device *dev)
+static void unmap_cmd_data(struct srp_cmd *cmd,
+			   struct srp_event_struct *evt_struct,
+			   struct device *dev)
 {
-	int i;
-
 	if ((cmd->data_out_format == SRP_NO_BUFFER) &&
 	    (cmd->data_in_format == SRP_NO_BUFFER))
 		return;
@@ -318,15 +344,34 @@ static void unmap_cmd_data(struct srp_cm
 			(struct indirect_descriptor *)cmd->additional_data;
 		int num_mapped = indirect->head.length / 
 			sizeof(indirect->list[0]);
-		for (i = 0; i < num_mapped; ++i) {
-			struct memory_descriptor *data = &indirect->list[i];
-			dma_unmap_single(dev,
-					 data->virtual_address,
-					 data->length, DMA_BIDIRECTIONAL);
+
+		if (num_mapped <= MAX_INDIRECT_BUFS) {
+			unmap_sg_list(num_mapped, dev, &indirect->list[0]);
+			return;
 		}
+
+		unmap_sg_list(num_mapped, dev, evt_struct->ext_list);
 	}
 }
 
+static int map_sg_list(int num_entries, 
+		       struct scatterlist *sg,
+		       struct memory_descriptor *md)
+{
+	int i;
+	u64 total_length = 0;
+
+	for (i = 0; i < num_entries; ++i) {
+		struct memory_descriptor *descr = md + i;
+		struct scatterlist *sg_entry = &sg[i];
+		descr->virtual_address = sg_dma_address(sg_entry);
+		descr->length = sg_dma_len(sg_entry);
+		descr->memory_handle = 0;
+		total_length += sg_dma_len(sg_entry);
+ 	}
+	return total_length;
+}
+
 /**
  * map_sg_data: - Maps dma for a scatterlist and initializes decriptor fields
  * @cmd:	Scsi_Cmnd with the scatterlist
@@ -337,10 +382,11 @@ static void unmap_cmd_data(struct srp_cm
  * Returns 1 on success.
 */
 static int map_sg_data(struct scsi_cmnd *cmd,
+		       struct srp_event_struct *evt_struct,
 		       struct srp_cmd *srp_cmd, struct device *dev)
 {
 
-	int i, sg_mapped;
+	int sg_mapped;
 	u64 total_length = 0;
 	struct scatterlist *sg = cmd->request_buffer;
 	struct memory_descriptor *data =
@@ -363,27 +409,46 @@ static int map_sg_data(struct scsi_cmnd 
 		return 1;
 	}
 
-	if (sg_mapped > MAX_INDIRECT_BUFS) {
+	if (sg_mapped > SG_ALL) {
 		printk(KERN_ERR
 		       "ibmvscsi: More than %d mapped sg entries, got %d\n",
-		       MAX_INDIRECT_BUFS, sg_mapped);
+		       SG_ALL, sg_mapped);
 		return 0;
 	}
 
 	indirect->head.virtual_address = 0;
 	indirect->head.length = sg_mapped * sizeof(indirect->list[0]);
 	indirect->head.memory_handle = 0;
-	for (i = 0; i < sg_mapped; ++i) {
-		struct memory_descriptor *descr = &indirect->list[i];
-		struct scatterlist *sg_entry = &sg[i];
-		descr->virtual_address = sg_dma_address(sg_entry);
-		descr->length = sg_dma_len(sg_entry);
-		descr->memory_handle = 0;
-		total_length += sg_dma_len(sg_entry);
+
+	if (sg_mapped <= MAX_INDIRECT_BUFS) {
+		total_length = map_sg_list(sg_mapped, sg, &indirect->list[0]);
+		indirect->total_length = total_length;
+		return 1;
 	}
-	indirect->total_length = total_length;
 
-	return 1;
+	/* get indirect table */
+	if (!evt_struct->ext_list) {
+		evt_struct->ext_list =(struct memory_descriptor*)
+			dma_alloc_coherent(dev, 
+				SG_ALL * sizeof(struct memory_descriptor),
+				&evt_struct->ext_list_token, 0);
+		if (!evt_struct->ext_list) {
+		    printk(KERN_ERR
+		   	"ibmvscsi: Can't allocate memory for indirect table\n");
+			return 0;
+			
+		}
+	}
+
+	total_length = map_sg_list(sg_mapped, sg, evt_struct->ext_list);	
+
+	indirect->total_length = total_length;
+	indirect->head.virtual_address = evt_struct->ext_list_token;
+	indirect->head.length = sg_mapped * sizeof(indirect->list[0]);
+	memcpy(indirect->list, evt_struct->ext_list,
+		MAX_INDIRECT_BUFS * sizeof(struct memory_descriptor));
+	
+ 	return 1;
 }
 
 /**
@@ -428,6 +493,7 @@ static int map_single_data(struct scsi_c
  * Returns 1 on success.
 */
 static int map_data_for_srp_cmd(struct scsi_cmnd *cmd,
+				struct srp_event_struct *evt_struct,
 				struct srp_cmd *srp_cmd, struct device *dev)
 {
 	switch (cmd->sc_data_direction) {
@@ -450,7 +516,7 @@ static int map_data_for_srp_cmd(struct s
 	if (!cmd->request_buffer)
 		return 1;
 	if (cmd->use_sg)
-		return map_sg_data(cmd, srp_cmd, dev);
+		return map_sg_data(cmd, evt_struct, srp_cmd, dev);
 	return map_single_data(cmd, srp_cmd, dev);
 }
 
@@ -486,6 +552,7 @@ static int ibmvscsi_send_srp_event(struc
 		printk(KERN_WARNING 
 		       "ibmvscsi: Warning, request_limit exceeded\n");
 		unmap_cmd_data(&evt_struct->iu.srp.cmd,
+			       evt_struct,
 			       hostdata->dev);
 		free_event_struct(&hostdata->pool, evt_struct);
 		return SCSI_MLQUEUE_HOST_BUSY;
@@ -513,7 +580,7 @@ static int ibmvscsi_send_srp_event(struc
 	return 0;
 
  send_error:
-	unmap_cmd_data(&evt_struct->iu.srp.cmd, hostdata->dev);
+	unmap_cmd_data(&evt_struct->iu.srp.cmd, evt_struct, hostdata->dev);
 
 	if ((cmnd = evt_struct->cmnd) != NULL) {
 		cmnd->result = DID_ERROR << 16;
@@ -551,6 +618,7 @@ static void handle_cmd_rsp(struct srp_ev
 			       rsp->sense_and_response_data,
 			       rsp->sense_data_list_length);
 		unmap_cmd_data(&evt_struct->iu.srp.cmd, 
+			       evt_struct, 
 			       evt_struct->hostdata->dev);
 
 		if (rsp->doover)
@@ -583,6 +651,7 @@ static int ibmvscsi_queuecommand(struct 
 {
 	struct srp_cmd *srp_cmd;
 	struct srp_event_struct *evt_struct;
+	struct indirect_descriptor *indirect;
 	struct ibmvscsi_host_data *hostdata =
 		(struct ibmvscsi_host_data *)&cmnd->device->host->hostdata;
 	u16 lun = lun_from_dev(cmnd->device);
@@ -591,14 +660,6 @@ static int ibmvscsi_queuecommand(struct 
 	if (!evt_struct)
 		return SCSI_MLQUEUE_HOST_BUSY;
 
-	init_event_struct(evt_struct,
-			  handle_cmd_rsp,
-			  VIOSRP_SRP_FORMAT,
-			  cmnd->timeout);
-
-	evt_struct->cmnd = cmnd;
-	evt_struct->cmnd_done = done;
-
 	/* Set up the actual SRP IU */
 	srp_cmd = &evt_struct->iu.srp.cmd;
 	memset(srp_cmd, 0x00, sizeof(*srp_cmd));
@@ -606,17 +667,25 @@ static int ibmvscsi_queuecommand(struct 
 	memcpy(srp_cmd->cdb, cmnd->cmnd, sizeof(cmnd->cmnd));
 	srp_cmd->lun = ((u64) lun) << 48;
 
-	if (!map_data_for_srp_cmd(cmnd, srp_cmd, hostdata->dev)) {
+	if (!map_data_for_srp_cmd(cmnd, evt_struct, srp_cmd, hostdata->dev)) {
 		printk(KERN_ERR "ibmvscsi: couldn't convert cmd to srp_cmd\n");
 		free_event_struct(&hostdata->pool, evt_struct);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 
+	init_event_struct(evt_struct,
+			  handle_cmd_rsp,
+			  VIOSRP_SRP_FORMAT,
+			  cmnd->timeout);
+
+	evt_struct->cmnd = cmnd;
+	evt_struct->cmnd_done = done;
+
 	/* Fix up dma address of the buffer itself */
-	if ((srp_cmd->data_out_format == SRP_INDIRECT_BUFFER) ||
-	    (srp_cmd->data_in_format == SRP_INDIRECT_BUFFER)) {
-		struct indirect_descriptor *indirect =
-		    (struct indirect_descriptor *)srp_cmd->additional_data;
+	indirect = (struct indirect_descriptor *)srp_cmd->additional_data;
+	if (((srp_cmd->data_out_format == SRP_INDIRECT_BUFFER) ||
+	    (srp_cmd->data_in_format == SRP_INDIRECT_BUFFER)) &&
+	    (indirect->head.virtual_address == 0)) {
 		indirect->head.virtual_address = evt_struct->crq.IU_data_ptr +
 		    offsetof(struct srp_cmd, additional_data) +
 		    offsetof(struct indirect_descriptor, list);
@@ -924,7 +993,8 @@ static int ibmvscsi_eh_abort_handler(str
 
 	cmd->result = (DID_ABORT << 16);
 	list_del(&found_evt->list);
-	unmap_cmd_data(&found_evt->iu.srp.cmd, found_evt->hostdata->dev);
+	unmap_cmd_data(&found_evt->iu.srp.cmd, found_evt,
+		       found_evt->hostdata->dev);
 	free_event_struct(&found_evt->hostdata->pool, found_evt);
 	atomic_inc(&hostdata->request_limit);
 	return SUCCESS;
@@ -1011,7 +1081,8 @@ static int ibmvscsi_eh_device_reset_hand
 			if (tmp_evt->cmnd)
 				tmp_evt->cmnd->result = (DID_RESET << 16);
 			list_del(&tmp_evt->list);
-			unmap_cmd_data(&tmp_evt->iu.srp.cmd, tmp_evt->hostdata->dev);
+			unmap_cmd_data(&tmp_evt->iu.srp.cmd, tmp_evt,
+				       tmp_evt->hostdata->dev);
 			free_event_struct(&tmp_evt->hostdata->pool,
 						   tmp_evt);
 			atomic_inc(&hostdata->request_limit);
@@ -1039,6 +1110,7 @@ static void purge_requests(struct ibmvsc
 		if (tmp_evt->cmnd) {
 			tmp_evt->cmnd->result = (DID_ERROR << 16);
 			unmap_cmd_data(&tmp_evt->iu.srp.cmd, 
+				       tmp_evt,	
 				       tmp_evt->hostdata->dev);
 			if (tmp_evt->cmnd_done)
 				tmp_evt->cmnd_done(tmp_evt->cmnd);
@@ -1343,7 +1415,7 @@ static struct scsi_host_template driver_
 	.cmd_per_lun = 16,
 	.can_queue = 1,		/* Updated after SRP_LOGIN */
 	.this_id = -1,
-	.sg_tablesize = MAX_INDIRECT_BUFS,
+	.sg_tablesize = SG_ALL,
 	.use_clustering = ENABLE_CLUSTERING,
 	.shost_attrs = ibmvscsi_attrs,
 };
diff -X ../dontdiff -purN madinfo/drivers/scsi/ibmvscsi/ibmvscsi.h large-sg/drivers/scsi/ibmvscsi/ibmvscsi.h
--- madinfo/drivers/scsi/ibmvscsi/ibmvscsi.h	2005-06-24 16:36:16.000000000 -0500
+++ large-sg/drivers/scsi/ibmvscsi/ibmvscsi.h	2005-06-24 17:32:27.000000000 -0500
@@ -68,6 +68,8 @@ struct srp_event_struct {
 	void (*cmnd_done) (struct scsi_cmnd *);
 	struct completion comp;
 	union viosrp_iu *sync_srp;
+	struct memory_descriptor *ext_list;
+	dma_addr_t ext_list_token;
 };
 
 /* a pool of event structs for use */

