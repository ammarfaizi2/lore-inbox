Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVJEQfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVJEQfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbVJEQfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:35:53 -0400
Received: from server02.es6.egwn.net ([195.10.6.12]:48019 "EHLO
	mx1.es6.egwn.net") by vger.kernel.org with ESMTP id S1030226AbVJEQfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:35:52 -0400
Subject: [patch] raw1394: fix locking in the presence of SMP and interrupts
From: Andy Wingo <wingo@pobox.com>
To: bcollins@debian.org, scjody@steamballoon.com
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-UuHkA9lzRFOoSow3OrH6"
Date: Wed, 05 Oct 2005 18:35:42 +0200
Message-Id: <1128530142.12591.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UuHkA9lzRFOoSow3OrH6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Changes all spinlocks that can be held during an irq handler to disable
interrupts while the lock is held. Changes spin_[un]lock_irq to use the
irqsave/irqrestore variants for robustness and readability.

In raw1394.c:handle_iso_listen(), don't grab host_info_lock at all --
we're not accessing host_info_list or host_count, and holding this lock
while trying to tasklet_kill the iso tasklet this can cause an ABBA
deadlock if ohci:dma_rcv_tasklet is running and tries to grab
host_info_lock in raw1394.c:receive_iso. Test program attached reliably
deadlocks all SMP machines I have been able to test without this patch.

Signed-off-by: Andy Wingo <wingo@pobox.com>
---

(This is my first kernel patch, I hope my MUA gets it right...)

 ohci1394.c |    6 +--
 raw1394.c  |  102 +++++++++++++++++++++++++++++++++----------------------------
 2 files changed, 59 insertions(+), 49 deletions(-)

Index: linux-source-2.6.12-2.6.12-work/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-source-2.6.12-2.6.12-work.orig/drivers/ieee1394/ohci1394.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-source-2.6.12-2.6.12-work/drivers/ieee1394/ohci1394.c	2005-10-05 11:55:13.000000000 +0200
@@ -2281,8 +2281,9 @@
 {
 	struct ohci1394_iso_tasklet *t;
 	unsigned long mask;
+	unsigned long flags;
 
-	spin_lock(&ohci->iso_tasklet_list_lock);
+	spin_lock_irqsave(&ohci->iso_tasklet_list_lock, flags);
 
 	list_for_each_entry(t, &ohci->iso_tasklet_list, link) {
 		mask = 1 << t->context;
@@ -2293,8 +2294,7 @@
 			tasklet_schedule(&t->tasklet);
 	}
 
-	spin_unlock(&ohci->iso_tasklet_list_lock);
-
+	spin_unlock_irqrestore(&ohci->iso_tasklet_list_lock, flags);
 }
 
 static irqreturn_t ohci_irq_handler(int irq, void *dev_id,
Index: linux-source-2.6.12-2.6.12-work/drivers/ieee1394/raw1394.c
===================================================================
--- linux-source-2.6.12-2.6.12-work.orig/drivers/ieee1394/raw1394.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-source-2.6.12-2.6.12-work/drivers/ieee1394/raw1394.c	2005-10-05 15:23:43.000000000 +0200
@@ -412,6 +412,7 @@
 static ssize_t raw1394_read(struct file *file, char __user * buffer,
 			    size_t count, loff_t * offset_is_ignored)
 {
+	unsigned long flags;
 	struct file_info *fi = (struct file_info *)file->private_data;
 	struct list_head *lh;
 	struct pending_request *req;
@@ -435,10 +436,10 @@
 		}
 	}
 
-	spin_lock_irq(&fi->reqlists_lock);
+	spin_lock_irqsave(&fi->reqlists_lock, flags);
 	lh = fi->req_complete.next;
 	list_del(lh);
-	spin_unlock_irq(&fi->reqlists_lock);
+	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 
 	req = list_entry(lh, struct pending_request, list);
 
@@ -486,6 +487,7 @@
 
 static int state_initialized(struct file_info *fi, struct pending_request *req)
 {
+	unsigned long flags;
 	struct host_info *hi;
 	struct raw1394_khost_list *khl;
 
@@ -499,7 +501,7 @@
 
 	switch (req->req.type) {
 	case RAW1394_REQ_LIST_CARDS:
-		spin_lock_irq(&host_info_lock);
+		spin_lock_irqsave(&host_info_lock, flags);
 		khl = kmalloc(sizeof(struct raw1394_khost_list) * host_count,
 			      SLAB_ATOMIC);
 
@@ -513,7 +515,7 @@
 				khl++;
 			}
 		}
-		spin_unlock_irq(&host_info_lock);
+		spin_unlock_irqrestore(&host_info_lock, flags);
 
 		if (khl != NULL) {
 			req->req.error = RAW1394_ERROR_NONE;
@@ -528,7 +530,7 @@
 		break;
 
 	case RAW1394_REQ_SET_CARD:
-		spin_lock_irq(&host_info_lock);
+		spin_lock_irqsave(&host_info_lock, flags);
 		if (req->req.misc < host_count) {
 			list_for_each_entry(hi, &host_info_list, list) {
 				if (!req->req.misc--)
@@ -550,7 +552,7 @@
 		} else {
 			req->req.error = RAW1394_ERROR_INVALID_ARG;
 		}
-		spin_unlock_irq(&host_info_lock);
+		spin_unlock_irqrestore(&host_info_lock, flags);
 
 		req->req.length = 0;
 		break;
@@ -569,7 +571,6 @@
 {
 	int channel = req->req.misc;
 
-	spin_lock_irq(&host_info_lock);
 	if ((channel > 63) || (channel < -64)) {
 		req->req.error = RAW1394_ERROR_INVALID_ARG;
 	} else if (channel >= 0) {
@@ -601,7 +602,6 @@
 
 	req->req.length = 0;
 	queue_complete_req(req);
-	spin_unlock_irq(&host_info_lock);
 }
 
 static void handle_fcp_listen(struct file_info *fi, struct pending_request *req)
@@ -627,6 +627,7 @@
 static int handle_async_request(struct file_info *fi,
 				struct pending_request *req, int node)
 {
+	unsigned long flags;
 	struct hpsb_packet *packet = NULL;
 	u64 addr = req->req.address & 0xffffffffffffULL;
 
@@ -761,9 +762,9 @@
 	hpsb_set_packet_complete_task(packet,
 				      (void (*)(void *))queue_complete_cb, req);
 
-	spin_lock_irq(&fi->reqlists_lock);
+	spin_lock_irqsave(&fi->reqlists_lock, flags);
 	list_add_tail(&req->list, &fi->req_pending);
-	spin_unlock_irq(&fi->reqlists_lock);
+	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 
 	packet->generation = req->req.generation;
 
@@ -779,6 +780,7 @@
 static int handle_iso_send(struct file_info *fi, struct pending_request *req,
 			   int channel)
 {
+	unsigned long flags;
 	struct hpsb_packet *packet;
 
 	packet = hpsb_make_isopacket(fi->host, req->req.length, channel & 0x3f,
@@ -804,9 +806,9 @@
 				      (void (*)(void *))queue_complete_req,
 				      req);
 
-	spin_lock_irq(&fi->reqlists_lock);
+	spin_lock_irqsave(&fi->reqlists_lock, flags);
 	list_add_tail(&req->list, &fi->req_pending);
-	spin_unlock_irq(&fi->reqlists_lock);
+	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 
 	/* Update the generation of the packet just before sending. */
 	packet->generation = req->req.generation;
@@ -821,6 +823,7 @@
 
 static int handle_async_send(struct file_info *fi, struct pending_request *req)
 {
+	unsigned long flags;
 	struct hpsb_packet *packet;
 	int header_length = req->req.misc & 0xffff;
 	int expect_response = req->req.misc >> 16;
@@ -867,9 +870,9 @@
 	hpsb_set_packet_complete_task(packet,
 				      (void (*)(void *))queue_complete_cb, req);
 
-	spin_lock_irq(&fi->reqlists_lock);
+	spin_lock_irqsave(&fi->reqlists_lock, flags);
 	list_add_tail(&req->list, &fi->req_pending);
-	spin_unlock_irq(&fi->reqlists_lock);
+	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 
 	/* Update the generation of the packet just before sending. */
 	packet->generation = req->req.generation;
@@ -885,6 +888,7 @@
 static int arm_read(struct hpsb_host *host, int nodeid, quadlet_t * buffer,
 		    u64 addr, size_t length, u16 flags)
 {
+	unsigned long irqflags;
 	struct pending_request *req;
 	struct host_info *hi;
 	struct file_info *fi = NULL;
@@ -899,7 +903,7 @@
 	       "addr: %4.4x %8.8x length: %Zu", nodeid,
 	       (u16) ((addr >> 32) & 0xFFFF), (u32) (addr & 0xFFFFFFFF),
 	       length);
-	spin_lock(&host_info_lock);
+	spin_lock_irqsave(&host_info_lock, irqflags);
 	hi = find_host_info(host);	/* search address-entry */
 	if (hi != NULL) {
 		list_for_each_entry(fi, &hi->file_info_list, list) {
@@ -924,7 +928,7 @@
 	if (!found) {
 		printk(KERN_ERR "raw1394: arm_read FAILED addr_entry not found"
 		       " -> rcode_address_error\n");
-		spin_unlock(&host_info_lock);
+		spin_unlock_irqrestore(&host_info_lock, irqflags);
 		return (RCODE_ADDRESS_ERROR);
 	} else {
 		DBGMSG("arm_read addr_entry FOUND");
@@ -954,7 +958,7 @@
 		req = __alloc_pending_request(SLAB_ATOMIC);
 		if (!req) {
 			DBGMSG("arm_read -> rcode_conflict_error");
-			spin_unlock(&host_info_lock);
+			spin_unlock_irqrestore(&host_info_lock, irqflags);
 			return (RCODE_CONFLICT_ERROR);	/* A resource conflict was detected.
 							   The request may be retried */
 		}
@@ -974,7 +978,7 @@
 		if (!(req->data)) {
 			free_pending_request(req);
 			DBGMSG("arm_read -> rcode_conflict_error");
-			spin_unlock(&host_info_lock);
+			spin_unlock_irqrestore(&host_info_lock, irqflags);
 			return (RCODE_CONFLICT_ERROR);	/* A resource conflict was detected.
 							   The request may be retried */
 		}
@@ -1031,13 +1035,14 @@
 			    sizeof(struct arm_request));
 		queue_complete_req(req);
 	}
-	spin_unlock(&host_info_lock);
+	spin_unlock_irqrestore(&host_info_lock, irqflags);
 	return (rcode);
 }
 
 static int arm_write(struct hpsb_host *host, int nodeid, int destid,
 		     quadlet_t * data, u64 addr, size_t length, u16 flags)
 {
+	unsigned long irqflags;
 	struct pending_request *req;
 	struct host_info *hi;
 	struct file_info *fi = NULL;
@@ -1052,7 +1057,7 @@
 	       "addr: %4.4x %8.8x length: %Zu", nodeid,
 	       (u16) ((addr >> 32) & 0xFFFF), (u32) (addr & 0xFFFFFFFF),
 	       length);
-	spin_lock(&host_info_lock);
+	spin_lock_irqsave(&host_info_lock, irqflags);
 	hi = find_host_info(host);	/* search address-entry */
 	if (hi != NULL) {
 		list_for_each_entry(fi, &hi->file_info_list, list) {
@@ -1077,7 +1082,7 @@
 	if (!found) {
 		printk(KERN_ERR "raw1394: arm_write FAILED addr_entry not found"
 		       " -> rcode_address_error\n");
-		spin_unlock(&host_info_lock);
+		spin_unlock_irqrestore(&host_info_lock, irqflags);
 		return (RCODE_ADDRESS_ERROR);
 	} else {
 		DBGMSG("arm_write addr_entry FOUND");
@@ -1106,7 +1111,7 @@
 		req = __alloc_pending_request(SLAB_ATOMIC);
 		if (!req) {
 			DBGMSG("arm_write -> rcode_conflict_error");
-			spin_unlock(&host_info_lock);
+			spin_unlock_irqrestore(&host_info_lock, irqflags);
 			return (RCODE_CONFLICT_ERROR);	/* A resource conflict was detected.
 							   The request my be retried */
 		}
@@ -1118,7 +1123,7 @@
 		if (!(req->data)) {
 			free_pending_request(req);
 			DBGMSG("arm_write -> rcode_conflict_error");
-			spin_unlock(&host_info_lock);
+			spin_unlock_irqrestore(&host_info_lock, irqflags);
 			return (RCODE_CONFLICT_ERROR);	/* A resource conflict was detected.
 							   The request may be retried */
 		}
@@ -1165,7 +1170,7 @@
 			    sizeof(struct arm_request));
 		queue_complete_req(req);
 	}
-	spin_unlock(&host_info_lock);
+	spin_unlock_irqrestore(&host_info_lock, irqflags);
 	return (rcode);
 }
 
@@ -1173,6 +1178,7 @@
 		    u64 addr, quadlet_t data, quadlet_t arg, int ext_tcode,
 		    u16 flags)
 {
+	unsigned long irqflags;
 	struct pending_request *req;
 	struct host_info *hi;
 	struct file_info *fi = NULL;
@@ -1198,7 +1204,7 @@
 		       (u32) (addr & 0xFFFFFFFF), ext_tcode & 0xFF,
 		       be32_to_cpu(data), be32_to_cpu(arg));
 	}
-	spin_lock(&host_info_lock);
+	spin_lock_irqsave(&host_info_lock, irqflags);
 	hi = find_host_info(host);	/* search address-entry */
 	if (hi != NULL) {
 		list_for_each_entry(fi, &hi->file_info_list, list) {
@@ -1224,7 +1230,7 @@
 	if (!found) {
 		printk(KERN_ERR "raw1394: arm_lock FAILED addr_entry not found"
 		       " -> rcode_address_error\n");
-		spin_unlock(&host_info_lock);
+		spin_unlock_irqrestore(&host_info_lock, irqflags);
 		return (RCODE_ADDRESS_ERROR);
 	} else {
 		DBGMSG("arm_lock addr_entry FOUND");
@@ -1307,7 +1313,7 @@
 		req = __alloc_pending_request(SLAB_ATOMIC);
 		if (!req) {
 			DBGMSG("arm_lock -> rcode_conflict_error");
-			spin_unlock(&host_info_lock);
+			spin_unlock_irqrestore(&host_info_lock, irqflags);
 			return (RCODE_CONFLICT_ERROR);	/* A resource conflict was detected.
 							   The request may be retried */
 		}
@@ -1316,7 +1322,7 @@
 		if (!(req->data)) {
 			free_pending_request(req);
 			DBGMSG("arm_lock -> rcode_conflict_error");
-			spin_unlock(&host_info_lock);
+			spin_unlock_irqrestore(&host_info_lock, irqflags);
 			return (RCODE_CONFLICT_ERROR);	/* A resource conflict was detected.
 							   The request may be retried */
 		}
@@ -1382,7 +1388,7 @@
 			    sizeof(struct arm_response) + 2 * sizeof(*store));
 		queue_complete_req(req);
 	}
-	spin_unlock(&host_info_lock);
+	spin_unlock_irqrestore(&host_info_lock, irqflags);
 	return (rcode);
 }
 
@@ -1390,6 +1396,7 @@
 		      u64 addr, octlet_t data, octlet_t arg, int ext_tcode,
 		      u16 flags)
 {
+	unsigned long irqflags;
 	struct pending_request *req;
 	struct host_info *hi;
 	struct file_info *fi = NULL;
@@ -1422,7 +1429,7 @@
 		       (u32) ((be64_to_cpu(arg) >> 32) & 0xFFFFFFFF),
 		       (u32) (be64_to_cpu(arg) & 0xFFFFFFFF));
 	}
-	spin_lock(&host_info_lock);
+	spin_lock_irqsave(&host_info_lock, irqflags);
 	hi = find_host_info(host);	/* search addressentry in file_info's for host */
 	if (hi != NULL) {
 		list_for_each_entry(fi, &hi->file_info_list, list) {
@@ -1449,7 +1456,7 @@
 		printk(KERN_ERR
 		       "raw1394: arm_lock64 FAILED addr_entry not found"
 		       " -> rcode_address_error\n");
-		spin_unlock(&host_info_lock);
+		spin_unlock_irqrestore(&host_info_lock, irqflags);
 		return (RCODE_ADDRESS_ERROR);
 	} else {
 		DBGMSG("arm_lock64 addr_entry FOUND");
@@ -1533,7 +1540,7 @@
 		DBGMSG("arm_lock64 -> entering notification-section");
 		req = __alloc_pending_request(SLAB_ATOMIC);
 		if (!req) {
-			spin_unlock(&host_info_lock);
+			spin_unlock_irqrestore(&host_info_lock, irqflags);
 			DBGMSG("arm_lock64 -> rcode_conflict_error");
 			return (RCODE_CONFLICT_ERROR);	/* A resource conflict was detected.
 							   The request may be retried */
@@ -1542,7 +1549,7 @@
 		req->data = kmalloc(size, SLAB_ATOMIC);
 		if (!(req->data)) {
 			free_pending_request(req);
-			spin_unlock(&host_info_lock);
+			spin_unlock_irqrestore(&host_info_lock, irqflags);
 			DBGMSG("arm_lock64 -> rcode_conflict_error");
 			return (RCODE_CONFLICT_ERROR);	/* A resource conflict was detected.
 							   The request may be retried */
@@ -1609,7 +1616,7 @@
 			    sizeof(struct arm_response) + 2 * sizeof(*store));
 		queue_complete_req(req);
 	}
-	spin_unlock(&host_info_lock);
+	spin_unlock_irqrestore(&host_info_lock, irqflags);
 	return (rcode);
 }
 
@@ -1980,6 +1987,7 @@
 	struct hpsb_packet *packet = NULL;
 	int retval = 0;
 	quadlet_t data;
+	unsigned long flags;
 
 	data = be32_to_cpu((u32) req->req.sendb);
 	DBGMSG("write_phypacket called - quadlet 0x%8.8x ", data);
@@ -1990,9 +1998,9 @@
 	req->packet = packet;
 	hpsb_set_packet_complete_task(packet,
 				      (void (*)(void *))queue_complete_cb, req);
-	spin_lock_irq(&fi->reqlists_lock);
+	spin_lock_irqsave(&fi->reqlists_lock, flags);
 	list_add_tail(&req->list, &fi->req_pending);
-	spin_unlock_irq(&fi->reqlists_lock);
+	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 	packet->generation = req->req.generation;
 	retval = hpsb_send_packet(packet);
 	DBGMSG("write_phypacket send_packet called => retval: %d ", retval);
@@ -2656,14 +2664,15 @@
 {
 	struct file_info *fi = file->private_data;
 	unsigned int mask = POLLOUT | POLLWRNORM;
+	unsigned long flags;
 
 	poll_wait(file, &fi->poll_wait_complete, pt);
 
-	spin_lock_irq(&fi->reqlists_lock);
+	spin_lock_irqsave(&fi->reqlists_lock, flags);
 	if (!list_empty(&fi->req_complete)) {
 		mask |= POLLIN | POLLRDNORM;
 	}
-	spin_unlock_irq(&fi->reqlists_lock);
+	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 
 	return mask;
 }
@@ -2707,6 +2716,7 @@
 	struct arm_addr *arm_addr = NULL;
 	int another_host;
 	int csr_mod = 0;
+	unsigned long flags;
 
 	if (fi->iso_state != RAW1394_ISO_INACTIVE)
 		raw1394_iso_shutdown(fi);
@@ -2717,13 +2727,13 @@
 		}
 	}
 
-	spin_lock_irq(&host_info_lock);
+	spin_lock_irqsave(&host_info_lock, flags);
 	fi->listen_channels = 0;
-	spin_unlock_irq(&host_info_lock);
+	spin_unlock_irqrestore(&host_info_lock, flags);
 
 	fail = 0;
 	/* set address-entries invalid */
-	spin_lock_irq(&host_info_lock);
+	spin_lock_irqsave(&host_info_lock, flags);
 
 	while (!list_empty(&fi->addr_list)) {
 		another_host = 0;
@@ -2774,14 +2784,14 @@
 		vfree(addr->addr_space_buffer);
 		kfree(addr);
 	}			/* while */
-	spin_unlock_irq(&host_info_lock);
+	spin_unlock_irqrestore(&host_info_lock, flags);
 	if (fail > 0) {
 		printk(KERN_ERR "raw1394: during addr_list-release "
 		       "error(s) occurred \n");
 	}
 
 	while (!done) {
-		spin_lock_irq(&fi->reqlists_lock);
+		spin_lock_irqsave(&fi->reqlists_lock, flags);
 
 		while (!list_empty(&fi->req_complete)) {
 			lh = fi->req_complete.next;
@@ -2795,7 +2805,7 @@
 		if (list_empty(&fi->req_pending))
 			done = 1;
 
-		spin_unlock_irq(&fi->reqlists_lock);
+		spin_unlock_irqrestore(&fi->reqlists_lock, flags);
 
 		if (!done)
 			down_interruptible(&fi->complete_sem);
@@ -2825,9 +2835,9 @@
 		     fi->host->id);
 
 	if (fi->state == connected) {
-		spin_lock_irq(&host_info_lock);
+		spin_lock_irqsave(&host_info_lock, flags);
 		list_del(&fi->list);
-		spin_unlock_irq(&host_info_lock);
+		spin_unlock_irqrestore(&host_info_lock, flags);
 
 		put_device(&fi->host->device);
 	}


--=-UuHkA9lzRFOoSow3OrH6
Content-Disposition: attachment; filename=raw1394reader_nothreads.c
Content-Type: text/x-csrc; name=raw1394reader_nothreads.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

/* $ gcc `pkg-config --cflags --libs glib-2.0` -lraw1394 -o \
        raw1394reader_nothreads raw1394reader_nothreads.c
 */
#include <glib.h>
#include <libraw1394/raw1394.h>

static int
iso_receive (raw1394handle_t handle, int channel, size_t len, quadlet_t * data)
{
    switch (len) {
    case 12:
        g_print ("x");
        break;
    case 492:
        g_print (".");
        break;
    default:
        g_print (" %ld ???\n", len);
        break;
    }
    
    return 0;
}

static int
bus_reset (raw1394handle_t handle, unsigned int generation)
{
    g_print ("got bus reset, generation %u\n", generation);
    
    return 0;
}

static gpointer
reader_loop (gpointer data)
{
    raw1394handle_t handle = data;
    
    g_print ("[1] reader loop starting\n");

    /* process */
    while (g_random_double () > 0.001)
        raw1394_loop_iterate (handle);

    g_print ("\n[1] reader thread stopping\n");

    return NULL;
}
        
int
main (int argc, char *argv[])
{
    raw1394handle_t handle;
    struct raw1394_portinfo pinf[16];
    int num_ports;
    
    handle = raw1394_new_handle ();
    if (!handle) {
        g_warning ("failed to open raw1394 handle");
        return 1;
    }
    
    num_ports = raw1394_get_port_info (handle, pinf, 16);
    if (num_ports <= 0) {
        g_warning ("no ports available");
        return 1;
    }
    
    if (raw1394_set_port (handle, 0) < 0) {
        g_warning ("failed to set port");
        return 1;
    }

    raw1394_set_iso_handler (handle, 63, iso_receive);
    raw1394_set_bus_reset_handler (handle, bus_reset);

    if (raw1394_start_iso_rcv (handle, 63) < 0) {
        g_warning ("failed to start isochronous transfer");
        return 1;
    }

    reader_loop (handle);

    g_print ("[0] stopping iso_rcv\n");

    raw1394_stop_iso_rcv (handle, 63);
    raw1394_destroy_handle (handle);

    g_print ("[0] success\n");

    return 0;
}

--=-UuHkA9lzRFOoSow3OrH6--

