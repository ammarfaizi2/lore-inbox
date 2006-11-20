Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966741AbWKTVHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966741AbWKTVHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966744AbWKTVHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:07:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44556 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966741AbWKTVHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:07:07 -0500
Date: Mon, 20 Nov 2006 22:07:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jody McIntyre <scjody@modernduck.com>
Cc: bcollins@debian.org, stefanr@s5r6.in-berlin.de,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] the scheduled removal of RAW1394_REQ_ISO_{SEND,LISTEN}
Message-ID: <20061120210705.GD31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled removal of requests of type 
RAW1394_REQ_ISO_SEND, RAW1394_REQ_ISO_LISTEN.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |    9 -
 drivers/ieee1394/highlevel.c               |   37 ----
 drivers/ieee1394/highlevel.h               |   21 --
 drivers/ieee1394/hosts.h                   |    2 
 drivers/ieee1394/ieee1394_core.c           |    7 
 drivers/ieee1394/ieee1394_transactions.c   |   30 ----
 drivers/ieee1394/ieee1394_transactions.h   |    2 
 drivers/ieee1394/raw1394-private.h         |    5 
 drivers/ieee1394/raw1394.c                 |  157 ---------------------
 drivers/ieee1394/raw1394.h                 |    4 
 10 files changed, 3 insertions(+), 271 deletions(-)

--- linux-2.6.19-rc5-mm2/Documentation/feature-removal-schedule.txt.old	2006-11-20 21:29:34.000000000 +0100
+++ linux-2.6.19-rc5-mm2/Documentation/feature-removal-schedule.txt	2006-11-20 21:29:49.000000000 +0100
@@ -29,15 +29,6 @@ Who:	Adrian Bunk <bunk@stusta.de>
 
 ---------------------------
 
-What:	raw1394: requests of type RAW1394_REQ_ISO_SEND, RAW1394_REQ_ISO_LISTEN
-When:	November 2006
-Why:	Deprecated in favour of the new ioctl-based rawiso interface, which is
-	more efficient.  You should really be using libraw1394 for raw1394
-	access anyway.
-Who:	Jody McIntyre <scjody@modernduck.com>
-
----------------------------
-
 What:	Video4Linux API 1 ioctls and video_decoder.h from Video devices.
 When:	December 2006
 Why:	V4L1 AP1 was replaced by V4L2 API. during migration from 2.4 to 2.6
--- linux-2.6.19-rc5-mm2/drivers/ieee1394/raw1394.h.old	2006-11-20 21:31:11.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/raw1394.h	2006-11-20 21:31:47.000000000 +0100
@@ -17,11 +17,11 @@
 #define RAW1394_REQ_ASYNC_WRITE     101
 #define RAW1394_REQ_LOCK            102
 #define RAW1394_REQ_LOCK64          103
-#define RAW1394_REQ_ISO_SEND        104
+/* removed: RAW1394_REQ_ISO_SEND        104 */
 #define RAW1394_REQ_ASYNC_SEND      105
 #define RAW1394_REQ_ASYNC_STREAM    106
 
-#define RAW1394_REQ_ISO_LISTEN      200
+/* removed: RAW1394_REQ_ISO_LISTEN      200 */
 #define RAW1394_REQ_FCP_LISTEN      201
 #define RAW1394_REQ_RESET_BUS       202
 #define RAW1394_REQ_GET_ROM         203
--- linux-2.6.19-rc5-mm2/drivers/ieee1394/raw1394.c.old	2006-11-20 21:31:54.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/raw1394.c	2006-11-20 21:49:53.000000000 +0100
@@ -283,67 +283,6 @@ static void host_reset(struct hpsb_host 
 	spin_unlock_irqrestore(&host_info_lock, flags);
 }
 
-static void iso_receive(struct hpsb_host *host, int channel, quadlet_t * data,
-			size_t length)
-{
-	unsigned long flags;
-	struct host_info *hi;
-	struct file_info *fi;
-	struct pending_request *req, *req_next;
-	struct iso_block_store *ibs = NULL;
-	LIST_HEAD(reqs);
-
-	if ((atomic_read(&iso_buffer_size) + length) > iso_buffer_max) {
-		HPSB_INFO("dropped iso packet");
-		return;
-	}
-
-	spin_lock_irqsave(&host_info_lock, flags);
-	hi = find_host_info(host);
-
-	if (hi != NULL) {
-		list_for_each_entry(fi, &hi->file_info_list, list) {
-			if (!(fi->listen_channels & (1ULL << channel)))
-				continue;
-
-			req = __alloc_pending_request(SLAB_ATOMIC);
-			if (!req)
-				break;
-
-			if (!ibs) {
-				ibs = kmalloc(sizeof(*ibs) + length,
-					      SLAB_ATOMIC);
-				if (!ibs) {
-					kfree(req);
-					break;
-				}
-
-				atomic_add(length, &iso_buffer_size);
-				atomic_set(&ibs->refcount, 0);
-				ibs->data_size = length;
-				memcpy(ibs->data, data, length);
-			}
-
-			atomic_inc(&ibs->refcount);
-
-			req->file_info = fi;
-			req->ibs = ibs;
-			req->data = ibs->data;
-			req->req.type = RAW1394_REQ_ISO_RECEIVE;
-			req->req.generation = get_hpsb_generation(host);
-			req->req.misc = 0;
-			req->req.recvb = ptr2int(fi->iso_buffer);
-			req->req.length = min(length, fi->iso_buffer_length);
-
-			list_add_tail(&req->list, &reqs);
-		}
-	}
-	spin_unlock_irqrestore(&host_info_lock, flags);
-
-	list_for_each_entry_safe(req, req_next, &reqs, list)
-	    queue_complete_req(req);
-}
-
 static void fcp_request(struct hpsb_host *host, int nodeid, int direction,
 			int cts, u8 * data, size_t length)
 {
@@ -657,43 +596,6 @@ static int state_initialized(struct file
 	return sizeof(struct raw1394_request);
 }
 
-static void handle_iso_listen(struct file_info *fi, struct pending_request *req)
-{
-	int channel = req->req.misc;
-
-	if ((channel > 63) || (channel < -64)) {
-		req->req.error = RAW1394_ERROR_INVALID_ARG;
-	} else if (channel >= 0) {
-		/* allocate channel req.misc */
-		if (fi->listen_channels & (1ULL << channel)) {
-			req->req.error = RAW1394_ERROR_ALREADY;
-		} else {
-			if (hpsb_listen_channel
-			    (&raw1394_highlevel, fi->host, channel)) {
-				req->req.error = RAW1394_ERROR_ALREADY;
-			} else {
-				fi->listen_channels |= 1ULL << channel;
-				fi->iso_buffer = int2ptr(req->req.recvb);
-				fi->iso_buffer_length = req->req.length;
-			}
-		}
-	} else {
-		/* deallocate channel (one's complement neg) req.misc */
-		channel = ~channel;
-
-		if (fi->listen_channels & (1ULL << channel)) {
-			hpsb_unlisten_channel(&raw1394_highlevel, fi->host,
-					      channel);
-			fi->listen_channels &= ~(1ULL << channel);
-		} else {
-			req->req.error = RAW1394_ERROR_INVALID_ARG;
-		}
-	}
-
-	req->req.length = 0;
-	queue_complete_req(req);
-}
-
 static void handle_fcp_listen(struct file_info *fi, struct pending_request *req)
 {
 	if (req->req.misc) {
@@ -867,50 +769,6 @@ static int handle_async_request(struct f
 	return sizeof(struct raw1394_request);
 }
 
-static int handle_iso_send(struct file_info *fi, struct pending_request *req,
-			   int channel)
-{
-	unsigned long flags;
-	struct hpsb_packet *packet;
-
-	packet = hpsb_make_isopacket(fi->host, req->req.length, channel & 0x3f,
-				     (req->req.misc >> 16) & 0x3,
-				     req->req.misc & 0xf);
-	if (!packet)
-		return -ENOMEM;
-
-	packet->speed_code = req->req.address & 0x3;
-
-	req->packet = packet;
-
-	if (copy_from_user(packet->data, int2ptr(req->req.sendb),
-			   req->req.length)) {
-		req->req.error = RAW1394_ERROR_MEMFAULT;
-		req->req.length = 0;
-		queue_complete_req(req);
-		return sizeof(struct raw1394_request);
-	}
-
-	req->req.length = 0;
-	hpsb_set_packet_complete_task(packet,
-				      (void (*)(void *))queue_complete_req,
-				      req);
-
-	spin_lock_irqsave(&fi->reqlists_lock, flags);
-	list_add_tail(&req->list, &fi->req_pending);
-	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
-
-	/* Update the generation of the packet just before sending. */
-	packet->generation = req->req.generation;
-
-	if (hpsb_send_packet(packet) < 0) {
-		req->req.error = RAW1394_ERROR_SEND_ERROR;
-		queue_complete_req(req);
-	}
-
-	return sizeof(struct raw1394_request);
-}
-
 static int handle_async_send(struct file_info *fi, struct pending_request *req)
 {
 	unsigned long flags;
@@ -2291,9 +2149,6 @@ static int state_connected(struct file_i
 		queue_complete_req(req);
 		return sizeof(struct raw1394_request);
 
-	case RAW1394_REQ_ISO_SEND:
-		return handle_iso_send(fi, req, node);
-
 	case RAW1394_REQ_ARM_REGISTER:
 		return arm_register(fi, req);
 
@@ -2309,10 +2164,6 @@ static int state_connected(struct file_i
 	case RAW1394_REQ_RESET_NOTIFY:
 		return reset_notification(fi, req);
 
-	case RAW1394_REQ_ISO_LISTEN:
-		handle_iso_listen(fi, req);
-		return sizeof(struct raw1394_request);
-
 	case RAW1394_REQ_FCP_LISTEN:
 		handle_fcp_listen(fi, req);
 		return sizeof(struct raw1394_request);
@@ -2817,14 +2668,7 @@ static int raw1394_release(struct inode 
 	if (fi->iso_state != RAW1394_ISO_INACTIVE)
 		raw1394_iso_shutdown(fi);
 
-	for (i = 0; i < 64; i++) {
-		if (fi->listen_channels & (1ULL << i)) {
-			hpsb_unlisten_channel(&raw1394_highlevel, fi->host, i);
-		}
-	}
-
 	spin_lock_irqsave(&host_info_lock, flags);
-	fi->listen_channels = 0;
 
 	fail = 0;
 	/* set address-entries invalid */
@@ -2986,7 +2830,6 @@ static struct hpsb_highlevel raw1394_hig
 	.add_host = add_host,
 	.remove_host = remove_host,
 	.host_reset = host_reset,
-	.iso_receive = iso_receive,
 	.fcp_request = fcp_request,
 };
 
--- linux-2.6.19-rc5-mm2/drivers/ieee1394/highlevel.h.old	2006-11-20 21:33:21.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/highlevel.h	2006-11-20 21:47:55.000000000 +0100
@@ -26,9 +26,7 @@ struct hpsb_address_serve {
 struct hpsb_highlevel {
 	const char *name;
 
-	/* Any of the following pointers can legally be NULL, except for
-	 * iso_receive which can only be NULL when you don't request
-	 * channels. */
+	/* Any of the following pointers can legally be NULL. */
 
 	/* New host initialized.  Will also be called during
 	 * hpsb_register_highlevel for all hosts already installed. */
@@ -43,13 +41,6 @@ struct hpsb_highlevel {
 	 * You can not expect to be able to do stock hpsb_reads. */
 	void (*host_reset)(struct hpsb_host *host);
 
-	/* An isochronous packet was received.  Channel contains the channel
-	 * number for your convenience, it is also contained in the included
-	 * packet header (first quadlet, CRCs are missing).  You may get called
-	 * for channel/host combinations you did not request. */
-	void (*iso_receive)(struct hpsb_host *host, int channel,
-			    quadlet_t *data, size_t length);
-
 	/* A write request was received on either the FCP_COMMAND (direction =
 	 * 0) or the FCP_RESPONSE (direction = 1) register.  The cts arg
 	 * contains the cts field (first byte of data). */
@@ -120,7 +111,6 @@ int highlevel_lock64(struct hpsb_host *h
 		     u64 addr, octlet_t data, octlet_t arg, int ext_tcode,
 		     u16 flags);
 
-void highlevel_iso_receive(struct hpsb_host *host, void *data, size_t length);
 void highlevel_fcp_request(struct hpsb_host *host, int nodeid, int direction,
 			   void *data, size_t length);
 
@@ -153,15 +143,6 @@ int hpsb_register_addrspace(struct hpsb_
 int hpsb_unregister_addrspace(struct hpsb_highlevel *hl, struct hpsb_host *host,
 			      u64 start);
 
-/*
- * Enable or disable receving a certain isochronous channel through the
- * iso_receive op.
- */
-int hpsb_listen_channel(struct hpsb_highlevel *hl, struct hpsb_host *host,
-			 unsigned int channel);
-void hpsb_unlisten_channel(struct hpsb_highlevel *hl, struct hpsb_host *host,
-			   unsigned int channel);
-
 /* Retrieve a hostinfo pointer bound to this driver/host */
 void *hpsb_get_hostinfo(struct hpsb_highlevel *hl, struct hpsb_host *host);
 
--- linux-2.6.19-rc5-mm2/drivers/ieee1394/highlevel.c.old	2006-11-20 21:33:54.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/highlevel.c	2006-11-20 21:48:08.000000000 +0100
@@ -419,29 +419,6 @@ int hpsb_unregister_addrspace(struct hps
 	return retval;
 }
 
-int hpsb_listen_channel(struct hpsb_highlevel *hl, struct hpsb_host *host,
-			unsigned int channel)
-{
-	if (channel > 63) {
-		HPSB_ERR("%s called with invalid channel", __FUNCTION__);
-		return -EINVAL;
-	}
-	if (host->iso_listen_count[channel]++ == 0)
-		return host->driver->devctl(host, ISO_LISTEN_CHANNEL, channel);
-	return 0;
-}
-
-void hpsb_unlisten_channel(struct hpsb_highlevel *hl, struct hpsb_host *host,
-			   unsigned int channel)
-{
-	if (channel > 63) {
-		HPSB_ERR("%s called with invalid channel", __FUNCTION__);
-		return;
-	}
-	if (--host->iso_listen_count[channel] == 0)
-		host->driver->devctl(host, ISO_UNLISTEN_CHANNEL, channel);
-}
-
 static void init_hpsb_highlevel(struct hpsb_host *host)
 {
 	INIT_LIST_HEAD(&dummy_zero_addr.host_list);
@@ -498,20 +475,6 @@ void highlevel_host_reset(struct hpsb_ho
 	read_unlock_irqrestore(&hl_irqs_lock, flags);
 }
 
-void highlevel_iso_receive(struct hpsb_host *host, void *data, size_t length)
-{
-	unsigned long flags;
-	struct hpsb_highlevel *hl;
-	int channel = (((quadlet_t *)data)[0] >> 8) & 0x3f;
-
-	read_lock_irqsave(&hl_irqs_lock, flags);
-	list_for_each_entry(hl, &hl_irqs, irq_list) {
-		if (hl->iso_receive)
-			hl->iso_receive(host, channel, data, length);
-	}
-	read_unlock_irqrestore(&hl_irqs_lock, flags);
-}
-
 void highlevel_fcp_request(struct hpsb_host *host, int nodeid, int direction,
 			   void *data, size_t length)
 {
--- linux-2.6.19-rc5-mm2/drivers/ieee1394/ieee1394_core.c.old	2006-11-20 21:34:06.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/ieee1394_core.c	2006-11-20 21:48:42.000000000 +0100
@@ -925,10 +925,6 @@ void hpsb_packet_received(struct hpsb_ho
 		break;
 
 
-	case TCODE_ISO_DATA:
-		highlevel_iso_receive(host, data, size);
-		break;
-
 	case TCODE_CYCLE_START:
 		/* simply ignore this packet if it is passed on */
 		break;
@@ -1209,7 +1205,6 @@ EXPORT_SYMBOL(hpsb_make_streampacket);
 EXPORT_SYMBOL(hpsb_make_lockpacket);
 EXPORT_SYMBOL(hpsb_make_lock64packet);
 EXPORT_SYMBOL(hpsb_make_phypacket);
-EXPORT_SYMBOL(hpsb_make_isopacket);
 EXPORT_SYMBOL(hpsb_read);
 EXPORT_SYMBOL(hpsb_write);
 EXPORT_SYMBOL(hpsb_packet_success);
@@ -1220,8 +1215,6 @@ EXPORT_SYMBOL(hpsb_unregister_highlevel)
 EXPORT_SYMBOL(hpsb_register_addrspace);
 EXPORT_SYMBOL(hpsb_unregister_addrspace);
 EXPORT_SYMBOL(hpsb_allocate_and_register_addrspace);
-EXPORT_SYMBOL(hpsb_listen_channel);
-EXPORT_SYMBOL(hpsb_unlisten_channel);
 EXPORT_SYMBOL(hpsb_get_hostinfo);
 EXPORT_SYMBOL(hpsb_create_hostinfo);
 EXPORT_SYMBOL(hpsb_destroy_hostinfo);
--- linux-2.6.19-rc5-mm2/drivers/ieee1394/ieee1394_transactions.h.old	2006-11-20 21:34:52.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/ieee1394_transactions.h	2006-11-20 21:34:58.000000000 +0100
@@ -19,8 +19,6 @@ struct hpsb_packet *hpsb_make_lock64pack
 					   nodeid_t node, u64 addr, int extcode,
 					   octlet_t *data, octlet_t arg);
 struct hpsb_packet *hpsb_make_phypacket(struct hpsb_host *host, quadlet_t data);
-struct hpsb_packet *hpsb_make_isopacket(struct hpsb_host *host, int length,
-					int channel, int tag, int sync);
 struct hpsb_packet *hpsb_make_writepacket(struct hpsb_host *host,
 					  nodeid_t node, u64 addr,
 					  quadlet_t *buffer, size_t length);
--- linux-2.6.19-rc5-mm2/drivers/ieee1394/ieee1394_transactions.c.old	2006-11-20 21:35:04.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/ieee1394_transactions.c	2006-11-20 21:35:37.000000000 +0100
@@ -84,18 +84,6 @@ static void fill_async_lock(struct hpsb_
 	packet->expect_response = 1;
 }
 
-static void fill_iso_packet(struct hpsb_packet *packet, int length, int channel,
-			    int tag, int sync)
-{
-	packet->header[0] = (length << 16) | (tag << 14) | (channel << 8)
-	    | (TCODE_ISO_DATA << 4) | sync;
-
-	packet->header_size = 4;
-	packet->data_size = length;
-	packet->type = hpsb_iso;
-	packet->tcode = TCODE_ISO_DATA;
-}
-
 static void fill_phy_packet(struct hpsb_packet *packet, quadlet_t data)
 {
 	packet->header[0] = data;
@@ -470,24 +458,6 @@ struct hpsb_packet *hpsb_make_phypacket(
 	return p;
 }
 
-struct hpsb_packet *hpsb_make_isopacket(struct hpsb_host *host,
-					int length, int channel,
-					int tag, int sync)
-{
-	struct hpsb_packet *p;
-
-	p = hpsb_alloc_packet(length);
-	if (!p)
-		return NULL;
-
-	p->host = host;
-	fill_iso_packet(p, length, channel, tag, sync);
-
-	p->generation = get_hpsb_generation(host);
-
-	return p;
-}
-
 /*
  * FIXME - these functions should probably read from / write to user space to
  * avoid in kernel buffers for user space callers
--- linux-2.6.19-rc5-mm2/drivers/ieee1394/hosts.h.old	2006-11-20 21:37:05.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/hosts.h	2006-11-20 21:37:11.000000000 +0100
@@ -30,8 +30,6 @@ struct hpsb_host {
 	struct timer_list timeout;
 	unsigned long timeout_interval;
 
-	unsigned char iso_listen_count[64];
-
 	int node_count;      /* number of identified nodes on this bus */
 	int selfid_count;    /* total number of SelfIDs received */
 	int nodes_active;    /* number of nodes with active link layer */
--- linux-2.6.19-rc5-mm2/drivers/ieee1394/raw1394-private.h.old	2006-11-20 21:38:34.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/ieee1394/raw1394-private.h	2006-11-20 21:41:03.000000000 +0100
@@ -36,11 +36,6 @@ struct file_info {
 
         u8 __user *fcp_buffer;
 
-	/* old ISO API */
-        u64 listen_channels;
-        quadlet_t __user *iso_buffer;
-        size_t iso_buffer_length;
-
         u8 notification; /* (busreset-notification) RAW1394_NOTIFY_OFF/ON */
 
 	/* new rawiso API */

