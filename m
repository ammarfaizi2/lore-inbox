Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWDGAf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWDGAf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 20:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWDGAf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 20:35:26 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:1722 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932245AbWDGAf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 20:35:26 -0400
Date: Thu, 06 Apr 2006 20:35:23 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [RFC: 2.6 patch] the overdue removal of
 RAW1394_REQ_ISO_{LISTEN,SEND}
In-reply-to: <20060406224706.GD7118@stusta.de>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200604062035.23880.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060406224706.GD7118@stusta.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 18:47, Adrian Bunk wrote:
>This patch contains the overdue removal of the RAW1394_REQ_ISO_SEND
> and RAW1394_REQ_ISO_LISTEN request types plus all support code for
> them.
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>

NAK if my vote is worth $.02.  ieee1394 has been broken since 
2.6.13-rc1, and apparently no one cares.  I have a firewire movie 
camera I haven't been able to use since then.  A Sony DVR-TVR460.

However, since my vote isn't worth a bucket of warm spit here, I do hope 
that when you are done, my camera can be used with linux again.  Its 
been about 9 months now, the baby is due.

>---
>
> Documentation/feature-removal-schedule.txt |    9 --
> drivers/ieee1394/highlevel.c               |   15 ---
> drivers/ieee1394/highlevel.h               |    4
> drivers/ieee1394/ieee1394_core.c           |    2
> drivers/ieee1394/ieee1394_transactions.c   |   30 -------
> drivers/ieee1394/ieee1394_transactions.h   |    3
> drivers/ieee1394/raw1394.c                 |   88
> --------------------- drivers/ieee1394/raw1394.h                 |   
> 4
> 8 files changed, 3 insertions(+), 152 deletions(-)
>
>---
> linux-2.6.17-rc1-mm1-full/Documentation/feature-removal-schedule.txt.
>old	2006-04-06 22:45:55.000000000 +0200 +++
> linux-2.6.17-rc1-mm1-full/Documentation/feature-removal-schedule.txt	
>2006-04-06 22:46:04.000000000 +0200 @@ -48,15 +48,6 @@
>
> ---------------------------
>
>-What:	raw1394: requests of type RAW1394_REQ_ISO_SEND,
> RAW1394_REQ_ISO_LISTEN -When:	November 2005
>-Why:	Deprecated in favour of the new ioctl-based rawiso interface,
> which is -	more efficient.  You should really be using libraw1394 for
> raw1394 -	access anyway.
>-Who:	Jody McIntyre <scjody@steamballoon.com>
>-
>----------------------------
>-
> What:	Video4Linux API 1 ioctls and video_decoder.h from Video
> devices. When:	July 2006
> Why:	V4L1 AP1 was replaced by V4L2 API. during migration from 2.4 to
> 2.6 ---
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/raw1394.h.old	2006-04-06
> 22:44:51.000000000 +0200 +++
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/raw1394.h	2006-04-06
> 22:45:44.000000000 +0200 @@ -17,11 +17,11 @@
> #define RAW1394_REQ_ASYNC_WRITE     101
> #define RAW1394_REQ_LOCK            102
> #define RAW1394_REQ_LOCK64          103
>-#define RAW1394_REQ_ISO_SEND        104
>+/* removed: RAW1394_REQ_ISO_SEND    104 */
> #define RAW1394_REQ_ASYNC_SEND      105
> #define RAW1394_REQ_ASYNC_STREAM    106
>
>-#define RAW1394_REQ_ISO_LISTEN      200
>+/* removed: RAW1394_REQ_ISO_LISTEN  200 */
> #define RAW1394_REQ_FCP_LISTEN      201
> #define RAW1394_REQ_RESET_BUS       202
> #define RAW1394_REQ_GET_ROM         203
>---
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/raw1394.c.old	2006-04-06
> 22:46:15.000000000 +0200 +++
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/raw1394.c	2006-04-06
> 22:47:11.000000000 +0200 @@ -636,43 +636,6 @@
> 	return sizeof(struct raw1394_request);
> }
>
>-static void handle_iso_listen(struct file_info *fi, struct
> pending_request *req) -{
>-	int channel = req->req.misc;
>-
>-	if ((channel > 63) || (channel < -64)) {
>-		req->req.error = RAW1394_ERROR_INVALID_ARG;
>-	} else if (channel >= 0) {
>-		/* allocate channel req.misc */
>-		if (fi->listen_channels & (1ULL << channel)) {
>-			req->req.error = RAW1394_ERROR_ALREADY;
>-		} else {
>-			if (hpsb_listen_channel
>-			    (&raw1394_highlevel, fi->host, channel)) {
>-				req->req.error = RAW1394_ERROR_ALREADY;
>-			} else {
>-				fi->listen_channels |= 1ULL << channel;
>-				fi->iso_buffer = int2ptr(req->req.recvb);
>-				fi->iso_buffer_length = req->req.length;
>-			}
>-		}
>-	} else {
>-		/* deallocate channel (one's complement neg) req.misc */
>-		channel = ~channel;
>-
>-		if (fi->listen_channels & (1ULL << channel)) {
>-			hpsb_unlisten_channel(&raw1394_highlevel, fi->host,
>-					      channel);
>-			fi->listen_channels &= ~(1ULL << channel);
>-		} else {
>-			req->req.error = RAW1394_ERROR_INVALID_ARG;
>-		}
>-	}
>-
>-	req->req.length = 0;
>-	queue_complete_req(req);
>-}
>-
> static void handle_fcp_listen(struct file_info *fi, struct
> pending_request *req) {
> 	if (req->req.misc) {
>@@ -846,50 +809,6 @@
> 	return sizeof(struct raw1394_request);
> }
>
>-static int handle_iso_send(struct file_info *fi, struct
> pending_request *req, -			   int channel)
>-{
>-	unsigned long flags;
>-	struct hpsb_packet *packet;
>-
>-	packet = hpsb_make_isopacket(fi->host, req->req.length, channel &
> 0x3f, -				     (req->req.misc >> 16) & 0x3,
>-				     req->req.misc & 0xf);
>-	if (!packet)
>-		return -ENOMEM;
>-
>-	packet->speed_code = req->req.address & 0x3;
>-
>-	req->packet = packet;
>-
>-	if (copy_from_user(packet->data, int2ptr(req->req.sendb),
>-			   req->req.length)) {
>-		req->req.error = RAW1394_ERROR_MEMFAULT;
>-		req->req.length = 0;
>-		queue_complete_req(req);
>-		return sizeof(struct raw1394_request);
>-	}
>-
>-	req->req.length = 0;
>-	hpsb_set_packet_complete_task(packet,
>-				      (void (*)(void *))queue_complete_req,
>-				      req);
>-
>-	spin_lock_irqsave(&fi->reqlists_lock, flags);
>-	list_add_tail(&req->list, &fi->req_pending);
>-	spin_unlock_irqrestore(&fi->reqlists_lock, flags);
>-
>-	/* Update the generation of the packet just before sending. */
>-	packet->generation = req->req.generation;
>-
>-	if (hpsb_send_packet(packet) < 0) {
>-		req->req.error = RAW1394_ERROR_SEND_ERROR;
>-		queue_complete_req(req);
>-	}
>-
>-	return sizeof(struct raw1394_request);
>-}
>-
> static int handle_async_send(struct file_info *fi, struct
> pending_request *req) {
> 	unsigned long flags;
>@@ -2272,9 +2191,6 @@
> 		queue_complete_req(req);
> 		return sizeof(struct raw1394_request);
>
>-	case RAW1394_REQ_ISO_SEND:
>-		return handle_iso_send(fi, req, node);
>-
> 	case RAW1394_REQ_ARM_REGISTER:
> 		return arm_register(fi, req);
>
>@@ -2290,10 +2206,6 @@
> 	case RAW1394_REQ_RESET_NOTIFY:
> 		return reset_notification(fi, req);
>
>-	case RAW1394_REQ_ISO_LISTEN:
>-		handle_iso_listen(fi, req);
>-		return sizeof(struct raw1394_request);
>-
> 	case RAW1394_REQ_FCP_LISTEN:
> 		handle_fcp_listen(fi, req);
> 		return sizeof(struct raw1394_request);
>---
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/highlevel.h.old	2006-04-06
> 22:55:51.000000000 +0200 +++
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/highlevel.h	2006-04-06
> 22:56:09.000000000 +0200 @@ -152,11 +152,9 @@
>                               u64 start);
>
> /*
>- * Enable or disable receving a certain isochronous channel through
> the + * Disable receving a certain isochronous channel through the *
> iso_receive op.
>  */
>-int hpsb_listen_channel(struct hpsb_highlevel *hl, struct hpsb_host
> *host, -                         unsigned int channel);
> void hpsb_unlisten_channel(struct hpsb_highlevel *hl, struct
> hpsb_host *host, unsigned int channel);
>
>---
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/highlevel.c.old	2006-04-06
> 22:56:17.000000000 +0200 +++
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/highlevel.c	2006-04-06
> 22:56:22.000000000 +0200 @@ -439,21 +439,6 @@
>         return retval;
> }
>
>-int hpsb_listen_channel(struct hpsb_highlevel *hl, struct hpsb_host
> *host, -                         unsigned int channel)
>-{
>-        if (channel > 63) {
>-                HPSB_ERR("%s called with invalid channel",
> __FUNCTION__); -                return -EINVAL;
>-        }
>-
>-        if (host->iso_listen_count[channel]++ == 0) {
>-                return host->driver->devctl(host, ISO_LISTEN_CHANNEL,
> channel); -        }
>-
>-	return 0;
>-}
>-
> void hpsb_unlisten_channel(struct hpsb_highlevel *hl, struct
> hpsb_host *host, unsigned int channel)
> {
>---
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/ieee1394_core.c.old	2006-0
>4-06 22:56:30.000000000 +0200 +++
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/ieee1394_core.c	2006-04-06
> 22:56:48.000000000 +0200 @@ -1223,7 +1223,6 @@
> EXPORT_SYMBOL(hpsb_make_lockpacket);
> EXPORT_SYMBOL(hpsb_make_lock64packet);
> EXPORT_SYMBOL(hpsb_make_phypacket);
>-EXPORT_SYMBOL(hpsb_make_isopacket);
> EXPORT_SYMBOL(hpsb_read);
> EXPORT_SYMBOL(hpsb_write);
> EXPORT_SYMBOL(hpsb_packet_success);
>@@ -1234,7 +1233,6 @@
> EXPORT_SYMBOL(hpsb_register_addrspace);
> EXPORT_SYMBOL(hpsb_unregister_addrspace);
> EXPORT_SYMBOL(hpsb_allocate_and_register_addrspace);
>-EXPORT_SYMBOL(hpsb_listen_channel);
> EXPORT_SYMBOL(hpsb_unlisten_channel);
> EXPORT_SYMBOL(hpsb_get_hostinfo);
> EXPORT_SYMBOL(hpsb_create_hostinfo);
>---
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/ieee1394_transactions.h.ol
>d	2006-04-06 22:56:59.000000000 +0200 +++
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/ieee1394_transactions.h	20
>06-04-06 22:57:03.000000000 +0200 @@ -20,9 +20,6 @@
> 					  octlet_t arg);
> struct hpsb_packet *hpsb_make_phypacket(struct hpsb_host *host,
>                                         quadlet_t data) ;
>-struct hpsb_packet *hpsb_make_isopacket(struct hpsb_host *host,
>-					int length, int channel,
>-					int tag, int sync);
> struct hpsb_packet *hpsb_make_writepacket (struct hpsb_host *host,
> nodeid_t node, u64 addr, quadlet_t *buffer, size_t length);
> struct hpsb_packet *hpsb_make_streampacket(struct hpsb_host *host, u8
> *buffer, ---
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/ieee1394_transactions.c.ol
>d	2006-04-06 22:57:11.000000000 +0200 +++
> linux-2.6.17-rc1-mm1-full/drivers/ieee1394/ieee1394_transactions.c	20
>06-04-06 22:58:21.000000000 +0200 @@ -79,18 +79,6 @@
> 	packet->expect_response = 1;
> }
>
>-static void fill_iso_packet(struct hpsb_packet *packet, int length,
> int channel, -			    int tag, int sync)
>-{
>-	packet->header[0] = (length << 16) | (tag << 14) | (channel << 8)
>-	    | (TCODE_ISO_DATA << 4) | sync;
>-
>-	packet->header_size = 4;
>-	packet->data_size = length;
>-	packet->type = hpsb_iso;
>-	packet->tcode = TCODE_ISO_DATA;
>-}
>-
> static void fill_phy_packet(struct hpsb_packet *packet, quadlet_t
> data) {
> 	packet->header[0] = data;
>@@ -446,24 +434,6 @@
> 	return p;
> }
>
>-struct hpsb_packet *hpsb_make_isopacket(struct hpsb_host *host,
>-					int length, int channel,
>-					int tag, int sync)
>-{
>-	struct hpsb_packet *p;
>-
>-	p = hpsb_alloc_packet(length);
>-	if (!p)
>-		return NULL;
>-
>-	p->host = host;
>-	fill_iso_packet(p, length, channel, tag, sync);
>-
>-	p->generation = get_hpsb_generation(host);
>-
>-	return p;
>-}
>-
> /*
>  * FIXME - these functions should probably read from / write to user
> space to * avoid in kernel buffers for user space callers
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
