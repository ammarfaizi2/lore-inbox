Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757101AbWLCQyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101AbWLCQyx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757138AbWLCQyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:54:52 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:52156 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1757101AbWLCQyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:54:51 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 3 Dec 2006 17:54:36 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] ieee1394: raw1394: don't save irq flags in interrupt-enabled
 sections
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.34edcffa1d46035c@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file operations raw1394_write(), raw1394_poll(), raw1394_release()
are always called with interrupts enabled.  Hence everything in their
context does not need to save IRQ flags when taking spinlocks.

This reverts unnecessary parts of
"[PATCH] raw1394: fix locking in the presence of SMP and interrupts",
commit 4a9949d7ac9e2bc51939f27b184be6e1bd99004e

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/raw1394.c |   94 ++++++++++++++++---------------------
 1 files changed, 41 insertions(+), 53 deletions(-)

Index: linux/drivers/ieee1394/raw1394.c
===================================================================
--- linux.orig/drivers/ieee1394/raw1394.c	2006-12-02 11:08:17.000000000 +0100
+++ linux/drivers/ieee1394/raw1394.c	2006-12-03 14:05:25.000000000 +0100
@@ -593,7 +593,6 @@ static int state_opened(struct file_info
 
 static int state_initialized(struct file_info *fi, struct pending_request *req)
 {
-	unsigned long flags;
 	struct host_info *hi;
 	struct raw1394_khost_list *khl;
 
@@ -607,7 +606,7 @@ static int state_initialized(struct file
 
 	switch (req->req.type) {
 	case RAW1394_REQ_LIST_CARDS:
-		spin_lock_irqsave(&host_info_lock, flags);
+		spin_lock_irq(&host_info_lock);
 		khl = kmalloc(sizeof(*khl) * host_count, SLAB_ATOMIC);
 
 		if (khl) {
@@ -620,7 +619,7 @@ static int state_initialized(struct file
 				khl++;
 			}
 		}
-		spin_unlock_irqrestore(&host_info_lock, flags);
+		spin_unlock_irq(&host_info_lock);
 
 		if (khl) {
 			req->req.error = RAW1394_ERROR_NONE;
@@ -635,7 +634,7 @@ static int state_initialized(struct file
 		break;
 
 	case RAW1394_REQ_SET_CARD:
-		spin_lock_irqsave(&host_info_lock, flags);
+		spin_lock_irq(&host_info_lock);
 		if (req->req.misc < host_count) {
 			list_for_each_entry(hi, &host_info_list, list) {
 				if (!req->req.misc--)
@@ -657,7 +656,7 @@ static int state_initialized(struct file
 		} else {
 			req->req.error = RAW1394_ERROR_INVALID_ARG;
 		}
-		spin_unlock_irqrestore(&host_info_lock, flags);
+		spin_unlock_irq(&host_info_lock);
 
 		req->req.length = 0;
 		break;
@@ -732,7 +731,6 @@ static void handle_fcp_listen(struct fil
 static int handle_async_request(struct file_info *fi,
 				struct pending_request *req, int node)
 {
-	unsigned long flags;
 	struct hpsb_packet *packet = NULL;
 	u64 addr = req->req.address & 0xffffffffffffULL;
 
@@ -867,9 +865,9 @@ static int handle_async_request(struct f
 	hpsb_set_packet_complete_task(packet,
 				      (void (*)(void *))queue_complete_cb, req);
 
-	spin_lock_irqsave(&fi->reqlists_lock, flags);
+	spin_lock_irq(&fi->reqlists_lock);
 	list_add_tail(&req->list, &fi->req_pending);
-	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
+	spin_unlock_irq(&fi->reqlists_lock);
 
 	packet->generation = req->req.generation;
 
@@ -885,7 +883,6 @@ static int handle_async_request(struct f
 static int handle_iso_send(struct file_info *fi, struct pending_request *req,
 			   int channel)
 {
-	unsigned long flags;
 	struct hpsb_packet *packet;
 
 	packet = hpsb_make_isopacket(fi->host, req->req.length, channel & 0x3f,
@@ -911,9 +908,9 @@ static int handle_iso_send(struct file_i
 				      (void (*)(void *))queue_complete_req,
 				      req);
 
-	spin_lock_irqsave(&fi->reqlists_lock, flags);
+	spin_lock_irq(&fi->reqlists_lock);
 	list_add_tail(&req->list, &fi->req_pending);
-	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
+	spin_unlock_irq(&fi->reqlists_lock);
 
 	/* Update the generation of the packet just before sending. */
 	packet->generation = req->req.generation;
@@ -928,7 +925,6 @@ static int handle_iso_send(struct file_i
 
 static int handle_async_send(struct file_info *fi, struct pending_request *req)
 {
-	unsigned long flags;
 	struct hpsb_packet *packet;
 	int header_length = req->req.misc & 0xffff;
 	int expect_response = req->req.misc >> 16;
@@ -975,9 +971,9 @@ static int handle_async_send(struct file
 	hpsb_set_packet_complete_task(packet,
 				      (void (*)(void *))queue_complete_cb, req);
 
-	spin_lock_irqsave(&fi->reqlists_lock, flags);
+	spin_lock_irq(&fi->reqlists_lock);
 	list_add_tail(&req->list, &fi->req_pending);
-	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
+	spin_unlock_irq(&fi->reqlists_lock);
 
 	/* Update the generation of the packet just before sending. */
 	packet->generation = req->req.generation;
@@ -1734,7 +1730,6 @@ static int arm_register(struct file_info
 	struct list_head *entry;
 	struct arm_addr *arm_addr = NULL;
 	int same_host, another_host;
-	unsigned long flags;
 
 	DBGMSG("arm_register called "
 	       "addr(Offset): %8.8x %8.8x length: %u "
@@ -1790,7 +1785,7 @@ static int arm_register(struct file_info
 	addr->recvb = req->req.recvb;
 	addr->rec_length = (u16) ((req->req.misc >> 16) & 0xFFFF);
 
-	spin_lock_irqsave(&host_info_lock, flags);
+	spin_lock_irq(&host_info_lock);
 	hi = find_host_info(fi->host);
 	same_host = 0;
 	another_host = 0;
@@ -1815,7 +1810,7 @@ static int arm_register(struct file_info
 	}
 	if (same_host) {
 		/* addressrange occupied by same host */
-		spin_unlock_irqrestore(&host_info_lock, flags);
+		spin_unlock_irq(&host_info_lock);
 		vfree(addr->addr_space_buffer);
 		kfree(addr);
 		return (-EALREADY);
@@ -1845,7 +1840,7 @@ static int arm_register(struct file_info
 			}
 		}
 	}
-	spin_unlock_irqrestore(&host_info_lock, flags);
+	spin_unlock_irq(&host_info_lock);
 
 	if (another_host) {
 		DBGMSG("another hosts entry is valid -> SUCCESS");
@@ -1859,9 +1854,9 @@ static int arm_register(struct file_info
 		}
 		free_pending_request(req);	/* immediate success or fail */
 		/* INSERT ENTRY */
-		spin_lock_irqsave(&host_info_lock, flags);
+		spin_lock_irq(&host_info_lock);
 		list_add_tail(&addr->addr_list, &fi->addr_list);
-		spin_unlock_irqrestore(&host_info_lock, flags);
+		spin_unlock_irq(&host_info_lock);
 		return sizeof(struct raw1394_request);
 	}
 	retval =
@@ -1870,9 +1865,9 @@ static int arm_register(struct file_info
 				    req->req.address + req->req.length);
 	if (retval) {
 		/* INSERT ENTRY */
-		spin_lock_irqsave(&host_info_lock, flags);
+		spin_lock_irq(&host_info_lock);
 		list_add_tail(&addr->addr_list, &fi->addr_list);
-		spin_unlock_irqrestore(&host_info_lock, flags);
+		spin_unlock_irq(&host_info_lock);
 	} else {
 		DBGMSG("arm_register failed errno: %d \n", retval);
 		vfree(addr->addr_space_buffer);
@@ -1893,13 +1888,12 @@ static int arm_unregister(struct file_in
 	struct file_info *fi_hlp = NULL;
 	struct arm_addr *arm_addr = NULL;
 	int another_host;
-	unsigned long flags;
 
 	DBGMSG("arm_Unregister called addr(Offset): "
 	       "%8.8x %8.8x",
 	       (u32) ((req->req.address >> 32) & 0xFFFF),
 	       (u32) (req->req.address & 0xFFFFFFFF));
-	spin_lock_irqsave(&host_info_lock, flags);
+	spin_lock_irq(&host_info_lock);
 	/* get addr */
 	entry = fi->addr_list.next;
 	while (entry != &(fi->addr_list)) {
@@ -1912,7 +1906,7 @@ static int arm_unregister(struct file_in
 	}
 	if (!found) {
 		DBGMSG("arm_Unregister addr not found");
-		spin_unlock_irqrestore(&host_info_lock, flags);
+		spin_unlock_irq(&host_info_lock);
 		return (-EINVAL);
 	}
 	DBGMSG("arm_Unregister addr found");
@@ -1944,7 +1938,7 @@ static int arm_unregister(struct file_in
 	if (another_host) {
 		DBGMSG("delete entry from list -> success");
 		list_del(&addr->addr_list);
-		spin_unlock_irqrestore(&host_info_lock, flags);
+		spin_unlock_irq(&host_info_lock);
 		vfree(addr->addr_space_buffer);
 		kfree(addr);
 		free_pending_request(req);	/* immediate success or fail */
@@ -1955,12 +1949,12 @@ static int arm_unregister(struct file_in
 				      addr->start);
 	if (!retval) {
 		printk(KERN_ERR "raw1394: arm_Unregister failed -> EINVAL\n");
-		spin_unlock_irqrestore(&host_info_lock, flags);
+		spin_unlock_irq(&host_info_lock);
 		return (-EINVAL);
 	}
 	DBGMSG("delete entry from list -> success");
 	list_del(&addr->addr_list);
-	spin_unlock_irqrestore(&host_info_lock, flags);
+	spin_unlock_irq(&host_info_lock);
 	vfree(addr->addr_space_buffer);
 	kfree(addr);
 	free_pending_request(req);	/* immediate success or fail */
@@ -1971,7 +1965,6 @@ static int arm_unregister(struct file_in
 static int arm_get_buf(struct file_info *fi, struct pending_request *req)
 {
 	struct arm_addr *arm_addr = NULL;
-	unsigned long flags;
 	unsigned long offset;
 
 	struct list_head *entry;
@@ -1981,7 +1974,7 @@ static int arm_get_buf(struct file_info 
 	       (u32) ((req->req.address >> 32) & 0xFFFF),
 	       (u32) (req->req.address & 0xFFFFFFFF), (u32) req->req.length);
 
-	spin_lock_irqsave(&host_info_lock, flags);
+	spin_lock_irq(&host_info_lock);
 	entry = fi->addr_list.next;
 	while (entry != &(fi->addr_list)) {
 		arm_addr = list_entry(entry, struct arm_addr, addr_list);
@@ -1989,7 +1982,7 @@ static int arm_get_buf(struct file_info 
 		    (arm_addr->end > req->req.address)) {
 			if (req->req.address + req->req.length <= arm_addr->end) {
 				offset = req->req.address - arm_addr->start;
-				spin_unlock_irqrestore(&host_info_lock, flags);
+				spin_unlock_irq(&host_info_lock);
 
 				DBGMSG
 				    ("arm_get_buf copy_to_user( %08X, %p, %u )",
@@ -2009,13 +2002,13 @@ static int arm_get_buf(struct file_info 
 				return sizeof(struct raw1394_request);
 			} else {
 				DBGMSG("arm_get_buf request exceeded mapping");
-				spin_unlock_irqrestore(&host_info_lock, flags);
+				spin_unlock_irq(&host_info_lock);
 				return (-EINVAL);
 			}
 		}
 		entry = entry->next;
 	}
-	spin_unlock_irqrestore(&host_info_lock, flags);
+	spin_unlock_irq(&host_info_lock);
 	return (-EINVAL);
 }
 
@@ -2023,7 +2016,6 @@ static int arm_get_buf(struct file_info 
 static int arm_set_buf(struct file_info *fi, struct pending_request *req)
 {
 	struct arm_addr *arm_addr = NULL;
-	unsigned long flags;
 	unsigned long offset;
 
 	struct list_head *entry;
@@ -2033,7 +2025,7 @@ static int arm_set_buf(struct file_info 
 	       (u32) ((req->req.address >> 32) & 0xFFFF),
 	       (u32) (req->req.address & 0xFFFFFFFF), (u32) req->req.length);
 
-	spin_lock_irqsave(&host_info_lock, flags);
+	spin_lock_irq(&host_info_lock);
 	entry = fi->addr_list.next;
 	while (entry != &(fi->addr_list)) {
 		arm_addr = list_entry(entry, struct arm_addr, addr_list);
@@ -2041,7 +2033,7 @@ static int arm_set_buf(struct file_info 
 		    (arm_addr->end > req->req.address)) {
 			if (req->req.address + req->req.length <= arm_addr->end) {
 				offset = req->req.address - arm_addr->start;
-				spin_unlock_irqrestore(&host_info_lock, flags);
+				spin_unlock_irq(&host_info_lock);
 
 				DBGMSG
 				    ("arm_set_buf copy_from_user( %p, %08X, %u )",
@@ -2061,13 +2053,13 @@ static int arm_set_buf(struct file_info 
 				return sizeof(struct raw1394_request);
 			} else {
 				DBGMSG("arm_set_buf request exceeded mapping");
-				spin_unlock_irqrestore(&host_info_lock, flags);
+				spin_unlock_irq(&host_info_lock);
 				return (-EINVAL);
 			}
 		}
 		entry = entry->next;
 	}
-	spin_unlock_irqrestore(&host_info_lock, flags);
+	spin_unlock_irq(&host_info_lock);
 	return (-EINVAL);
 }
 
@@ -2090,7 +2082,6 @@ static int write_phypacket(struct file_i
 	struct hpsb_packet *packet = NULL;
 	int retval = 0;
 	quadlet_t data;
-	unsigned long flags;
 
 	data = be32_to_cpu((u32) req->req.sendb);
 	DBGMSG("write_phypacket called - quadlet 0x%8.8x ", data);
@@ -2101,9 +2092,9 @@ static int write_phypacket(struct file_i
 	req->packet = packet;
 	hpsb_set_packet_complete_task(packet,
 				      (void (*)(void *))queue_complete_cb, req);
-	spin_lock_irqsave(&fi->reqlists_lock, flags);
+	spin_lock_irq(&fi->reqlists_lock);
 	list_add_tail(&req->list, &fi->req_pending);
-	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
+	spin_unlock_irq(&fi->reqlists_lock);
 	packet->generation = req->req.generation;
 	retval = hpsb_send_packet(packet);
 	DBGMSG("write_phypacket send_packet called => retval: %d ", retval);
@@ -2779,15 +2770,13 @@ static unsigned int raw1394_poll(struct 
 {
 	struct file_info *fi = file->private_data;
 	unsigned int mask = POLLOUT | POLLWRNORM;
-	unsigned long flags;
 
 	poll_wait(file, &fi->wait_complete, pt);
 
-	spin_lock_irqsave(&fi->reqlists_lock, flags);
-	if (!list_empty(&fi->req_complete)) {
+	spin_lock_irq(&fi->reqlists_lock);
+	if (!list_empty(&fi->req_complete))
 		mask |= POLLIN | POLLRDNORM;
-	}
-	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
+	spin_unlock_irq(&fi->reqlists_lock);
 
 	return mask;
 }
@@ -2829,7 +2818,6 @@ static int raw1394_release(struct inode 
 	struct arm_addr *arm_addr = NULL;
 	int another_host;
 	int csr_mod = 0;
-	unsigned long flags;
 
 	if (fi->iso_state != RAW1394_ISO_INACTIVE)
 		raw1394_iso_shutdown(fi);
@@ -2840,7 +2828,7 @@ static int raw1394_release(struct inode 
 		}
 	}
 
-	spin_lock_irqsave(&host_info_lock, flags);
+	spin_lock_irq(&host_info_lock);
 	fi->listen_channels = 0;
 
 	fail = 0;
@@ -2894,7 +2882,7 @@ static int raw1394_release(struct inode 
 		vfree(addr->addr_space_buffer);
 		kfree(addr);
 	}			/* while */
-	spin_unlock_irqrestore(&host_info_lock, flags);
+	spin_unlock_irq(&host_info_lock);
 	if (fail > 0) {
 		printk(KERN_ERR "raw1394: during addr_list-release "
 		       "error(s) occurred \n");
@@ -2903,12 +2891,12 @@ static int raw1394_release(struct inode 
 	for (;;) {
 		/* This locked section guarantees that neither
 		 * complete nor pending requests exist once i!=0 */
-		spin_lock_irqsave(&fi->reqlists_lock, flags);
+		spin_lock_irq(&fi->reqlists_lock);
 		while ((req = __next_complete_req(fi)))
 			free_pending_request(req);
 
 		i = list_empty(&fi->req_pending);
-		spin_unlock_irqrestore(&fi->reqlists_lock, flags);
+		spin_unlock_irq(&fi->reqlists_lock);
 
 		if (i)
 			break;
@@ -2948,9 +2936,9 @@ static int raw1394_release(struct inode 
 		     fi->host->id);
 
 	if (fi->state == connected) {
-		spin_lock_irqsave(&host_info_lock, flags);
+		spin_lock_irq(&host_info_lock);
 		list_del(&fi->list);
-		spin_unlock_irqrestore(&host_info_lock, flags);
+		spin_unlock_irq(&host_info_lock);
 
 		put_device(&fi->host->device);
 	}

-- 
Stefan Richter
-=====-=-==- ==-- ---==
http://arcgraph.de/sr/

