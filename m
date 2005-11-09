Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbVKIElI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVKIElI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 23:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVKIElI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 23:41:08 -0500
Received: from [205.233.219.253] ([205.233.219.253]:41440 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S965146AbVKIElF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 23:41:05 -0500
Date: Tue, 8 Nov 2005 23:39:36 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Panagiotis Issaris <takis@issaris.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee1394: Conversions from kmalloc/memset to kzalloc.
Message-ID: <20051109043936.GC14318@conscoop.ottawa.on.ca>
References: <20051108232857.E6D9820A1A@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108232857.E6D9820A1A@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 12:28:57AM +0100, Panagiotis Issaris wrote:
> 
> ieee1394: Conversions from kmalloc/memset to kzalloc.

Already in the -mm series, and will be submitted for 2.6.15.  Pasted
below for reference.

Cheers,
Jody


kmalloc/kzalloc changes:
dv1394, eth1394, ieee1394, ohci1394, pcilynx, raw1394, sbp2c, video1394:
 - use kzalloc
 - provide safer size arguments to kmalloc and kzalloc
 - omit some casts

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/dv1394.c linux-2.6.14-git3/drivers/ieee1394/dv1394.c
--- linux-2.6.14-git3/drivers/ieee1394+version/dv1394.c	2005-10-31 12:27:19.000000000 +0100
+++ linux-2.6.14-git3/drivers/ieee1394/dv1394.c	2005-10-31 21:06:49.000000000 +0100
@@ -2218,14 +2218,12 @@ static int dv1394_init(struct ti_ohci *o
 	unsigned long flags;
 	int i;
 
-	video = kmalloc(sizeof(struct video_card), GFP_KERNEL);
+	video = kzalloc(sizeof(*video), GFP_KERNEL);
 	if (!video) {
 		printk(KERN_ERR "dv1394: cannot allocate video_card\n");
 		goto err;
 	}
 
-	memset(video, 0, sizeof(struct video_card));
-
 	video->ohci = ohci;
 	/* lower 2 bits of id indicate which of four "plugs"
 	   per host */
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/eth1394.c linux-2.6.14-git3/drivers/ieee1394/eth1394.c
--- linux-2.6.14-git3/drivers/ieee1394+version/eth1394.c	2005-10-31 18:37:11.000000000 +0100
+++ linux-2.6.14-git3/drivers/ieee1394/eth1394.c	2005-10-31 21:06:49.000000000 +0100
@@ -352,12 +352,12 @@ static int eth1394_probe(struct device *
 	if (!hi)
 		return -ENOENT;
 
-	new_node = kmalloc(sizeof(struct eth1394_node_ref),
+	new_node = kmalloc(sizeof(*new_node),
 			   in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	if (!new_node)
 		return -ENOMEM;
 
-	node_info = kmalloc(sizeof(struct eth1394_node_info),
+	node_info = kmalloc(sizeof(*node_info),
 			    in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 	if (!node_info) {
 		kfree(new_node);
@@ -433,12 +433,12 @@ static int eth1394_update(struct unit_di
 	node = eth1394_find_node(&priv->ip_node_list, ud);
 
 	if (!node) {
-		node = kmalloc(sizeof(struct eth1394_node_ref),
+		node = kmalloc(sizeof(*node),
 			       in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 		if (!node)
 			return -ENOMEM;
 
-		node_info = kmalloc(sizeof(struct eth1394_node_info),
+		node_info = kmalloc(sizeof(*node_info),
 				    in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
 		if (!node_info) {
 			kfree(node);
@@ -1014,7 +1014,7 @@ static inline int new_fragment(struct li
 		}
 	}
 
-	new = kmalloc(sizeof(struct fragment_info), GFP_ATOMIC);
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	if (!new)
 		return -ENOMEM;
 
@@ -1033,7 +1033,7 @@ static inline int new_partial_datagram(s
 {
 	struct partial_datagram *new;
 
-	new = kmalloc(sizeof(struct partial_datagram), GFP_ATOMIC);
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	if (!new)
 		return -ENOMEM;
 
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/highlevel.c linux-2.6.14-git3/drivers/ieee1394/highlevel.c
--- linux-2.6.14-git3/drivers/ieee1394+version/highlevel.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3/drivers/ieee1394/highlevel.c	2005-10-31 21:06:49.000000000 +0100
@@ -101,12 +101,10 @@ void *hpsb_create_hostinfo(struct hpsb_h
 		return NULL;
 	}
 
-	hi = kmalloc(sizeof(*hi) + data_size, GFP_ATOMIC);
+	hi = kzalloc(sizeof(*hi) + data_size, GFP_ATOMIC);
 	if (!hi)
 		return NULL;
 
-	memset(hi, 0, sizeof(*hi) + data_size);
-
 	if (data_size) {
 		data = hi->data = hi + 1;
 		hi->size = data_size;
@@ -326,11 +324,9 @@ u64 hpsb_allocate_and_register_addrspace
 		return retval;
 	}
 
-	as = (struct hpsb_address_serve *)
-		kmalloc(sizeof(struct hpsb_address_serve), GFP_KERNEL);
-	if (as == NULL) {
+	as = kmalloc(sizeof(*as), GFP_KERNEL);
+	if (!as)
 		return retval;
-	}
 
 	INIT_LIST_HEAD(&as->host_list);
 	INIT_LIST_HEAD(&as->hl_list);
@@ -383,11 +379,9 @@ int hpsb_register_addrspace(struct hpsb_
                 return 0;
         }
 
-        as = (struct hpsb_address_serve *)
-                kmalloc(sizeof(struct hpsb_address_serve), GFP_ATOMIC);
-        if (as == NULL) {
-                return 0;
-        }
+	as = kmalloc(sizeof(*as), GFP_ATOMIC);
+	if (!as)
+		return 0;
 
         INIT_LIST_HEAD(&as->host_list);
         INIT_LIST_HEAD(&as->hl_list);
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/hosts.c linux-2.6.14-git3/drivers/ieee1394/hosts.c
--- linux-2.6.14-git3/drivers/ieee1394+version/hosts.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3/drivers/ieee1394/hosts.c	2005-10-31 21:06:49.000000000 +0100
@@ -114,9 +114,9 @@ struct hpsb_host *hpsb_alloc_host(struct
 	int i;
 	int hostnum = 0;
 
-        h = kmalloc(sizeof(struct hpsb_host) + extra, SLAB_KERNEL);
-        if (!h) return NULL;
-        memset(h, 0, sizeof(struct hpsb_host) + extra);
+        h = kzalloc(sizeof(*h) + extra, SLAB_KERNEL);
+        if (!h)
+		return NULL;
 
 	h->csr.rom = csr1212_create_csr(&csr_bus_ops, CSR_BUS_INFO_SIZE, h);
 	if (!h->csr.rom) {
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/nodemgr.c linux-2.6.14-git3/drivers/ieee1394/nodemgr.c
--- linux-2.6.14-git3/drivers/ieee1394+version/nodemgr.c	2005-10-31 12:27:19.000000000 +0100
+++ linux-2.6.14-git3/drivers/ieee1394/nodemgr.c	2005-10-31 21:09:03.000000000 +0100
@@ -743,21 +743,20 @@ static struct node_entry *nodemgr_create
 					      unsigned int generation)
 {
 	struct hpsb_host *host = hi->host;
-        struct node_entry *ne;
-
-	ne = kmalloc(sizeof(struct node_entry), GFP_KERNEL);
-        if (!ne) return NULL;
+	struct node_entry *ne;
 
-	memset(ne, 0, sizeof(struct node_entry));
+	ne = kzalloc(sizeof(*ne), GFP_KERNEL);
+	if (!ne)
+		return NULL;
 
 	ne->tpool = &host->tpool[nodeid & NODE_MASK];
 
-        ne->host = host;
-        ne->nodeid = nodeid;
+	ne->host = host;
+	ne->nodeid = nodeid;
 	ne->generation = generation;
 	ne->needs_probe = 1;
 
-        ne->guid = guid;
+	ne->guid = guid;
 	ne->guid_vendor_id = (guid >> 40) & 0xffffff;
 	ne->guid_vendor_oui = nodemgr_find_oui_name(ne->guid_vendor_id);
 	ne->csr = csr;
@@ -787,7 +786,7 @@ static struct node_entry *nodemgr_create
 		   (host->node_id == nodeid) ? "Host" : "Node",
 		   NODE_BUS_ARGS(host, nodeid), (unsigned long long)guid);
 
-        return ne;
+	return ne;
 }
 
 
@@ -872,12 +871,10 @@ static struct unit_directory *nodemgr_pr
 	struct csr1212_keyval *kv;
 	u8 last_key_id = 0;
 
-	ud = kmalloc(sizeof(struct unit_directory), GFP_KERNEL);
+	ud = kzalloc(sizeof(*ud), GFP_KERNEL);
 	if (!ud)
 		goto unit_directory_error;
 
-	memset (ud, 0, sizeof(struct unit_directory));
-
 	ud->ne = ne;
 	ud->ignore_driver = ignore_drivers;
 	ud->address = ud_kv->offset + CSR1212_CONFIG_ROM_SPACE_BASE;
@@ -937,10 +934,10 @@ static struct unit_directory *nodemgr_pr
 			/* Logical Unit Number */
 			if (kv->key.type == CSR1212_KV_TYPE_IMMEDIATE) {
 				if (ud->flags & UNIT_DIRECTORY_HAS_LUN) {
-					ud_child = kmalloc(sizeof(struct unit_directory), GFP_KERNEL);
+					ud_child = kmalloc(sizeof(*ud_child), GFP_KERNEL);
 					if (!ud_child)
 						goto unit_directory_error;
-					memcpy(ud_child, ud, sizeof(struct unit_directory));
+					memcpy(ud_child, ud, sizeof(*ud_child));
 					nodemgr_register_device(ne, ud_child, &ne->device);
 					ud_child = NULL;
 					
@@ -1200,7 +1197,7 @@ static void nodemgr_node_scan_one(struct
 	struct csr1212_csr *csr;
 	struct nodemgr_csr_info *ci;
 
-	ci = kmalloc(sizeof(struct nodemgr_csr_info), GFP_KERNEL);
+	ci = kmalloc(sizeof(*ci), GFP_KERNEL);
 	if (!ci)
 		return;
 
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/ohci1394.c linux-2.6.14-git3/drivers/ieee1394/ohci1394.c
--- linux-2.6.14-git3/drivers/ieee1394+version/ohci1394.c	2005-10-31 18:25:09.000000000 +0100
+++ linux-2.6.14-git3/drivers/ieee1394/ohci1394.c	2005-10-31 21:06:49.000000000 +0100
@@ -2957,28 +2957,23 @@ alloc_dma_rcv_ctx(struct ti_ohci *ohci, 
 	d->ctrlClear = 0;
 	d->cmdPtr = 0;
 
-	d->buf_cpu = kmalloc(d->num_desc * sizeof(quadlet_t*), GFP_ATOMIC);
-	d->buf_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_ATOMIC);
+	d->buf_cpu = kzalloc(d->num_desc * sizeof(*d->buf_cpu), GFP_ATOMIC);
+	d->buf_bus = kzalloc(d->num_desc * sizeof(*d->buf_bus), GFP_ATOMIC);
 
 	if (d->buf_cpu == NULL || d->buf_bus == NULL) {
 		PRINT(KERN_ERR, "Failed to allocate dma buffer");
 		free_dma_rcv_ctx(d);
 		return -ENOMEM;
 	}
-	memset(d->buf_cpu, 0, d->num_desc * sizeof(quadlet_t*));
-	memset(d->buf_bus, 0, d->num_desc * sizeof(dma_addr_t));
 
-	d->prg_cpu = kmalloc(d->num_desc * sizeof(struct dma_cmd*),
-				GFP_ATOMIC);
-	d->prg_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_ATOMIC);
+	d->prg_cpu = kzalloc(d->num_desc * sizeof(*d->prg_cpu), GFP_ATOMIC);
+	d->prg_bus = kzalloc(d->num_desc * sizeof(*d->prg_bus), GFP_ATOMIC);
 
 	if (d->prg_cpu == NULL || d->prg_bus == NULL) {
 		PRINT(KERN_ERR, "Failed to allocate dma prg");
 		free_dma_rcv_ctx(d);
 		return -ENOMEM;
 	}
-	memset(d->prg_cpu, 0, d->num_desc * sizeof(struct dma_cmd*));
-	memset(d->prg_bus, 0, d->num_desc * sizeof(dma_addr_t));
 
 	d->spb = kmalloc(d->split_buf_size, GFP_ATOMIC);
 
@@ -3090,17 +3085,14 @@ alloc_dma_trm_ctx(struct ti_ohci *ohci, 
 	d->ctrlClear = 0;
 	d->cmdPtr = 0;
 
-	d->prg_cpu = kmalloc(d->num_desc * sizeof(struct at_dma_prg*),
-			     GFP_KERNEL);
-	d->prg_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_KERNEL);
+	d->prg_cpu = kzalloc(d->num_desc * sizeof(*d->prg_cpu), GFP_KERNEL);
+	d->prg_bus = kzalloc(d->num_desc * sizeof(*d->prg_bus), GFP_KERNEL);
 
 	if (d->prg_cpu == NULL || d->prg_bus == NULL) {
 		PRINT(KERN_ERR, "Failed to allocate at dma prg");
 		free_dma_trm_ctx(d);
 		return -ENOMEM;
 	}
-	memset(d->prg_cpu, 0, d->num_desc * sizeof(struct at_dma_prg*));
-	memset(d->prg_bus, 0, d->num_desc * sizeof(dma_addr_t));
 
 	len = sprintf(pool_name, "ohci1394_trm_prg");
 	sprintf(pool_name+len, "%d", num_allocs);
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/pcilynx.c linux-2.6.14-git3/drivers/ieee1394/pcilynx.c
--- linux-2.6.14-git3/drivers/ieee1394+version/pcilynx.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3/drivers/ieee1394/pcilynx.c	2005-10-31 21:06:49.000000000 +0100
@@ -1435,7 +1435,7 @@ static int __devinit add_card(struct pci
         	struct i2c_algo_bit_data i2c_adapter_data;
 
         	error = -ENOMEM;
-		i2c_ad = kmalloc(sizeof(struct i2c_adapter), SLAB_KERNEL);
+		i2c_ad = kmalloc(sizeof(*i2c_ad), SLAB_KERNEL);
         	if (!i2c_ad) FAIL("failed to allocate I2C adapter memory");
 
 		memcpy(i2c_ad, &bit_ops, sizeof(struct i2c_adapter));
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/raw1394.c linux-2.6.14-git3/drivers/ieee1394/raw1394.c
--- linux-2.6.14-git3/drivers/ieee1394+version/raw1394.c	2005-10-31 12:27:19.000000000 +0100
+++ linux-2.6.14-git3/drivers/ieee1394/raw1394.c	2005-10-31 21:22:14.000000000 +0100
@@ -102,12 +102,9 @@ static struct pending_request *__alloc_p
 {
 	struct pending_request *req;
 
-	req = (struct pending_request *)kmalloc(sizeof(struct pending_request),
-						flags);
-	if (req != NULL) {
-		memset(req, 0, sizeof(struct pending_request));
+	req = kzalloc(sizeof(*req), flags);
+	if (req)
 		INIT_LIST_HEAD(&req->list);
-	}
 
 	return req;
 }
@@ -192,9 +189,9 @@ static void add_host(struct hpsb_host *h
 	struct host_info *hi;
 	unsigned long flags;
 
-	hi = (struct host_info *)kmalloc(sizeof(struct host_info), GFP_KERNEL);
+	hi = kmalloc(sizeof(*hi), GFP_KERNEL);
 
-	if (hi != NULL) {
+	if (hi) {
 		INIT_LIST_HEAD(&hi->list);
 		hi->host = host;
 		INIT_LIST_HEAD(&hi->file_info_list);
@@ -315,8 +312,8 @@ static void iso_receive(struct hpsb_host
 				break;
 
 			if (!ibs) {
-				ibs = kmalloc(sizeof(struct iso_block_store)
-					      + length, SLAB_ATOMIC);
+				ibs = kmalloc(sizeof(*ibs) + length,
+					      SLAB_ATOMIC);
 				if (!ibs) {
 					kfree(req);
 					break;
@@ -376,8 +373,8 @@ static void fcp_request(struct hpsb_host
 				break;
 
 			if (!ibs) {
-				ibs = kmalloc(sizeof(struct iso_block_store)
-					      + length, SLAB_ATOMIC);
+				ibs = kmalloc(sizeof(*ibs) + length,
+					      SLAB_ATOMIC);
 				if (!ibs) {
 					kfree(req);
 					break;
@@ -502,10 +499,9 @@ static int state_initialized(struct file
 	switch (req->req.type) {
 	case RAW1394_REQ_LIST_CARDS:
 		spin_lock_irqsave(&host_info_lock, flags);
-		khl = kmalloc(sizeof(struct raw1394_khost_list) * host_count,
-			      SLAB_ATOMIC);
+		khl = kmalloc(sizeof(*khl) * host_count, SLAB_ATOMIC);
 
-		if (khl != NULL) {
+		if (khl) {
 			req->req.misc = host_count;
 			req->data = (quadlet_t *) khl;
 
@@ -517,7 +513,7 @@ static int state_initialized(struct file
 		}
 		spin_unlock_irqrestore(&host_info_lock, flags);
 
-		if (khl != NULL) {
+		if (khl) {
 			req->req.error = RAW1394_ERROR_NONE;
 			req->req.length = min(req->req.length,
 					      (u32) (sizeof
@@ -1647,13 +1643,13 @@ static int arm_register(struct file_info
 		return (-EINVAL);
 	}
 	/* addr-list-entry for fileinfo */
-	addr = (struct arm_addr *)kmalloc(sizeof(struct arm_addr), SLAB_KERNEL);
+	addr = kmalloc(sizeof(*addr), SLAB_KERNEL);
 	if (!addr) {
 		req->req.length = 0;
 		return (-ENOMEM);
 	}
 	/* allocation of addr_space_buffer */
-	addr->addr_space_buffer = (u8 *) vmalloc(req->req.length);
+	addr->addr_space_buffer = vmalloc(req->req.length);
 	if (!(addr->addr_space_buffer)) {
 		kfree(addr);
 		req->req.length = 0;
@@ -2122,8 +2118,7 @@ static int modify_config_rom(struct file
 		return -ENOMEM;
 	}
 
-	cache->filled_head =
-	    kmalloc(sizeof(struct csr1212_cache_region), GFP_KERNEL);
+	cache->filled_head = kmalloc(sizeof(*cache->filled_head), GFP_KERNEL);
 	if (!cache->filled_head) {
 		csr1212_release_keyval(fi->csr1212_dirs[dr]);
 		fi->csr1212_dirs[dr] = NULL;
@@ -2684,11 +2679,10 @@ static int raw1394_open(struct inode *in
 {
 	struct file_info *fi;
 
-	fi = kmalloc(sizeof(struct file_info), SLAB_KERNEL);
-	if (fi == NULL)
+	fi = kzalloc(sizeof(*fi), SLAB_KERNEL);
+	if (!fi)
 		return -ENOMEM;
 
-	memset(fi, 0, sizeof(struct file_info));
 	fi->notification = (u8) RAW1394_NOTIFY_ON;	/* busreset notification */
 
 	INIT_LIST_HEAD(&fi->list);
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/sbp2.c linux-2.6.14-git3/drivers/ieee1394/sbp2.c
--- linux-2.6.14-git3/drivers/ieee1394+version/sbp2.c	2005-10-31 18:24:23.000000000 +0100
+++ linux-2.6.14-git3/drivers/ieee1394/sbp2.c	2005-10-31 21:06:49.000000000 +0100
@@ -411,14 +411,12 @@ static int sbp2util_create_command_orb_p
 
 	spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
 	for (i = 0; i < orbs; i++) {
-		command = (struct sbp2_command_info *)
-		    kmalloc(sizeof(struct sbp2_command_info), GFP_ATOMIC);
+		command = kzalloc(sizeof(*command), GFP_ATOMIC);
 		if (!command) {
 			spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock,
 					       flags);
 			return -ENOMEM;
 		}
-		memset(command, '\0', sizeof(struct sbp2_command_info));
 		command->command_orb_dma =
 		    pci_map_single(hi->host->pdev, &command->command_orb,
 				   sizeof(struct sbp2_command_orb),
@@ -714,12 +712,11 @@ static struct scsi_id_instance_data *sbp
 
 	SBP2_DEBUG("sbp2_alloc_device");
 
-	scsi_id = kmalloc(sizeof(*scsi_id), GFP_KERNEL);
+	scsi_id = kzalloc(sizeof(*scsi_id), GFP_KERNEL);
 	if (!scsi_id) {
 		SBP2_ERR("failed to create scsi_id");
 		goto failed_alloc;
 	}
-	memset(scsi_id, 0, sizeof(*scsi_id));
 
 	scsi_id->ne = ud->ne;
 	scsi_id->ud = ud;
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+version/video1394.c linux-2.6.14-git3/drivers/ieee1394/video1394.c
--- linux-2.6.14-git3/drivers/ieee1394+version/video1394.c	2005-10-31 12:27:19.000000000 +0100
+++ linux-2.6.14-git3/drivers/ieee1394/video1394.c	2005-10-31 21:29:38.000000000 +0100
@@ -206,14 +206,12 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 	struct dma_iso_ctx *d;
 	int i;
 
-	d = kmalloc(sizeof(struct dma_iso_ctx), GFP_KERNEL);
-	if (d == NULL) {
+	d = kzalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
 		PRINT(KERN_ERR, ohci->host->id, "Failed to allocate dma_iso_ctx");
 		return NULL;
 	}
 
-	memset(d, 0, sizeof *d);
-
 	d->ohci = ohci;
 	d->type = type;
 	d->channel = channel;
@@ -251,9 +249,8 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 	}
 	d->ctx = d->iso_tasklet.context;
 
-	d->prg_reg = kmalloc(d->num_desc * sizeof(struct dma_prog_region),
-			GFP_KERNEL);
-	if (d->prg_reg == NULL) {
+	d->prg_reg = kmalloc(d->num_desc * sizeof(*d->prg_reg), GFP_KERNEL);
+	if (!d->prg_reg) {
 		PRINT(KERN_ERR, ohci->host->id, "Failed to allocate ir prg regs");
 		free_dma_iso_ctx(d);
 		return NULL;
@@ -268,15 +265,14 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 		d->cmdPtr = OHCI1394_IsoRcvCommandPtr+32*d->ctx;
 		d->ctxMatch = OHCI1394_IsoRcvContextMatch+32*d->ctx;
 
-		d->ir_prg = kmalloc(d->num_desc * sizeof(struct dma_cmd *),
+		d->ir_prg = kzalloc(d->num_desc * sizeof(*d->ir_prg),
 				    GFP_KERNEL);
 
-		if (d->ir_prg == NULL) {
+		if (!d->ir_prg) {
 			PRINT(KERN_ERR, ohci->host->id, "Failed to allocate dma ir prg");
 			free_dma_iso_ctx(d);
 			return NULL;
 		}
-		memset(d->ir_prg, 0, d->num_desc * sizeof(struct dma_cmd *));
 
 		d->nb_cmd = d->buf_size / PAGE_SIZE + 1;
 		d->left_size = (d->frame_size % PAGE_SIZE) ?
@@ -297,16 +293,15 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 		d->ctrlClear = OHCI1394_IsoXmitContextControlClear+16*d->ctx;
 		d->cmdPtr = OHCI1394_IsoXmitCommandPtr+16*d->ctx;
 
-		d->it_prg = kmalloc(d->num_desc * sizeof(struct it_dma_prg *),
+		d->it_prg = kzalloc(d->num_desc * sizeof(*d->it_prg),
 				    GFP_KERNEL);
 
-		if (d->it_prg == NULL) {
+		if (!d->it_prg) {
 			PRINT(KERN_ERR, ohci->host->id,
 			      "Failed to allocate dma it prg");
 			free_dma_iso_ctx(d);
 			return NULL;
 		}
-		memset(d->it_prg, 0, d->num_desc*sizeof(struct it_dma_prg *));
 
 		d->packet_size = packet_size;
 
@@ -337,47 +332,24 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 		}
 	}
 
-	d->buffer_status = kmalloc(d->num_desc * sizeof(unsigned int),
-				   GFP_KERNEL);
-	d->buffer_prg_assignment = kmalloc(d->num_desc * sizeof(unsigned int),
-				   GFP_KERNEL);
-	d->buffer_time = kmalloc(d->num_desc * sizeof(struct timeval),
-				   GFP_KERNEL);
-	d->last_used_cmd = kmalloc(d->num_desc * sizeof(unsigned int),
-				   GFP_KERNEL);
-	d->next_buffer = kmalloc(d->num_desc * sizeof(int),
-				 GFP_KERNEL);
-
-	if (d->buffer_status == NULL) {
-		PRINT(KERN_ERR, ohci->host->id, "Failed to allocate buffer_status");
-		free_dma_iso_ctx(d);
-		return NULL;
-	}
-	if (d->buffer_prg_assignment == NULL) {
-		PRINT(KERN_ERR, ohci->host->id, "Failed to allocate buffer_prg_assignment");
-		free_dma_iso_ctx(d);
-		return NULL;
-	}
-	if (d->buffer_time == NULL) {
-		PRINT(KERN_ERR, ohci->host->id, "Failed to allocate buffer_time");
-		free_dma_iso_ctx(d);
-		return NULL;
-	}
-	if (d->last_used_cmd == NULL) {
-		PRINT(KERN_ERR, ohci->host->id, "Failed to allocate last_used_cmd");
-		free_dma_iso_ctx(d);
-		return NULL;
-	}
-	if (d->next_buffer == NULL) {
-		PRINT(KERN_ERR, ohci->host->id, "Failed to allocate next_buffer");
+	d->buffer_status =
+	    kzalloc(d->num_desc * sizeof(*d->buffer_status), GFP_KERNEL);
+	d->buffer_prg_assignment =
+	    kzalloc(d->num_desc * sizeof(*d->buffer_prg_assignment), GFP_KERNEL);
+	d->buffer_time =
+	    kzalloc(d->num_desc * sizeof(*d->buffer_time), GFP_KERNEL);
+	d->last_used_cmd =
+	    kzalloc(d->num_desc * sizeof(*d->last_used_cmd), GFP_KERNEL);
+	d->next_buffer =
+	    kzalloc(d->num_desc * sizeof(*d->next_buffer), GFP_KERNEL);
+
+	if (!d->buffer_status || !d->buffer_prg_assignment || !d->buffer_time ||
+	    !d->last_used_cmd || !d->next_buffer) {
+		PRINT(KERN_ERR, ohci->host->id,
+		      "Failed to allocate dma_iso_ctx member");
 		free_dma_iso_ctx(d);
 		return NULL;
 	}
-	memset(d->buffer_status, 0, d->num_desc * sizeof(unsigned int));
-	memset(d->buffer_prg_assignment, 0, d->num_desc * sizeof(unsigned int));
-	memset(d->buffer_time, 0, d->num_desc * sizeof(struct timeval));
-	memset(d->last_used_cmd, 0, d->num_desc * sizeof(unsigned int));
-	memset(d->next_buffer, -1, d->num_desc * sizeof(int));
 
         spin_lock_init(&d->lock);
 
@@ -1085,7 +1057,7 @@ static int __video1394_ioctl(struct file
 		}
 
 		if (d->flags & VIDEO1394_VARIABLE_PACKET_SIZE) {
-			int buf_size = d->nb_cmd * sizeof(unsigned int);
+			int buf_size = d->nb_cmd * sizeof(*psizes);
 			struct video1394_queue_variable __user *p = argp;
 			unsigned int __user *qv;
 
@@ -1251,13 +1223,12 @@ static int video1394_open(struct inode *
         if (ohci == NULL)
                 return -EIO;
 
-	ctx = kmalloc(sizeof(struct file_ctx), GFP_KERNEL);
-	if (ctx == NULL)  {
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)  {
 		PRINT(KERN_ERR, ohci->host->id, "Cannot malloc file_ctx");
 		return -ENOMEM;
 	}
 
-	memset(ctx, 0, sizeof(struct file_ctx));
 	ctx->ohci = ohci;
 	INIT_LIST_HEAD(&ctx->context_list);
 	ctx->current_ctx = NULL;
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+kzalloc/csr1212.c linux-2.6.14-git3/drivers/ieee1394/csr1212.c
--- linux-2.6.14-git3/drivers/ieee1394+kzalloc/csr1212.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3/drivers/ieee1394/csr1212.c	2005-10-31 23:11:26.000000000 +0100
@@ -1261,7 +1261,7 @@ static int csr1212_parse_bus_info_block(
 		return CSR1212_EINVAL;
 #endif
 
-	cr = CSR1212_MALLOC(sizeof(struct csr1212_cache_region));
+	cr = CSR1212_MALLOC(sizeof(*cr));
 	if (!cr)
 		return CSR1212_ENOMEM;
 
@@ -1393,8 +1393,7 @@ int csr1212_parse_keyval(struct csr1212_
 	case CSR1212_KV_TYPE_LEAF:
 		if (kv->key.id != CSR1212_KV_ID_EXTENDED_ROM) {
 			kv->value.leaf.data = CSR1212_MALLOC(quads_to_bytes(kvi_len));
-			if (!kv->value.leaf.data)
-			{
+			if (!kv->value.leaf.data) {
 				ret = CSR1212_ENOMEM;
 				goto fail;
 			}
@@ -1462,7 +1461,7 @@ int _csr1212_read_keyval(struct csr1212_
 		cache->next = NULL;
 		csr->cache_tail = cache;
 		cache->filled_head =
-			CSR1212_MALLOC(sizeof(struct csr1212_cache_region));
+			CSR1212_MALLOC(sizeof(*cache->filled_head));
 		if (!cache->filled_head) {
 			return CSR1212_ENOMEM;
 		}
@@ -1484,7 +1483,7 @@ int _csr1212_read_keyval(struct csr1212_
 	/* Now seach read portions of the cache to see if it is there. */
 	for (cr = cache->filled_head; cr; cr = cr->next) {
 		if (cache_index < cr->offset_start) {
-			newcr = CSR1212_MALLOC(sizeof(struct csr1212_cache_region));
+			newcr = CSR1212_MALLOC(sizeof(*newcr));
 			if (!newcr)
 				return CSR1212_ENOMEM;
 
@@ -1508,7 +1507,7 @@ int _csr1212_read_keyval(struct csr1212_
 
 	if (!cr) {
 		cr = cache->filled_tail;
-		newcr = CSR1212_MALLOC(sizeof(struct csr1212_cache_region));
+		newcr = CSR1212_MALLOC(sizeof(*newcr));
 		if (!newcr)
 			return CSR1212_ENOMEM;
 
diff -uprN -X linux-2.6.14-git3/Documentation/dontdiff linux-2.6.14-git3/drivers/ieee1394+kzalloc/csr1212.h linux-2.6.14-git3/drivers/ieee1394/csr1212.h
--- linux-2.6.14-git3/drivers/ieee1394+kzalloc/csr1212.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3/drivers/ieee1394/csr1212.h	2005-10-31 23:07:46.000000000 +0100
@@ -646,7 +646,7 @@ static inline struct csr1212_csr_rom_cac
 {
 	struct csr1212_csr_rom_cache *cache;
 
-	cache = CSR1212_MALLOC(sizeof(struct csr1212_csr_rom_cache) + size);
+	cache = CSR1212_MALLOC(sizeof(*cache) + size);
 	if (!cache)
 		return NULL;
 
