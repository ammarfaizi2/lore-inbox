Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUFHMrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUFHMrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 08:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265197AbUFHMrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 08:47:16 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:50633 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S265196AbUFHMrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 08:47:03 -0400
Date: Tue, 8 Jun 2004 22:46:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, linuxppc64-dev@lists.linuxppc.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PPC64 iSeries virtual DVD-RAM
Message-Id: <20040608224646.529860f4.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__8_Jun_2004_22_46_46_+1000_sgWRfCfyIwnZHIuo"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__8_Jun_2004_22_46_46_+1000_sgWRfCfyIwnZHIuo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew, Linus,

This patch enables access to DVD-RAM devices on iSeries boxes.  It also
adds some more device ids for some newer DVD-RAM drives.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.7-rc3/drivers/cdrom/viocd.c 2.6.7-rc3.dvd/drivers/cdrom/viocd.c
--- 2.6.7-rc3/drivers/cdrom/viocd.c	2004-05-10 15:31:08.000000000 +1000
+++ 2.6.7-rc3.dvd/drivers/cdrom/viocd.c	2004-06-08 22:28:43.000000000 +1000
@@ -120,7 +120,10 @@
 };
 
 static struct capability_entry capability_table[] __initdata = {
-	{ "6330", CDC_LOCK | CDC_DVD_RAM },
+	{ "6330", CDC_LOCK | CDC_DVD_RAM | CDC_RAM },
+	{ "6331", CDC_LOCK | CDC_DVD_RAM | CDC_RAM },
+	{ "6333", CDC_LOCK | CDC_DVD_RAM | CDC_RAM },
+	{ "632A", CDC_LOCK | CDC_DVD_RAM | CDC_RAM },
 	{ "6321", CDC_LOCK },
 	{ "632B", 0 },
 	{ NULL  , CDC_LOCK },
@@ -330,10 +333,19 @@
 	struct disk_info *diskinfo = req->rq_disk->private_data;
 	u64 len;
 	dma_addr_t dmaaddr;
+	int direction;
+	u16 cmd;
 	struct scatterlist sg;
 
 	BUG_ON(req->nr_phys_segments > 1);
-	BUG_ON(rq_data_dir(req) != READ);
+
+	if (rq_data_dir(req) == READ) {
+		direction = DMA_FROM_DEVICE;
+		cmd = viomajorsubtype_cdio | viocdread;
+	} else {
+		direction = DMA_TO_DEVICE;
+		cmd = viomajorsubtype_cdio | viocdwrite;
+	}
 
         if (blk_rq_map_sg(req->q, req, &sg) == 0) {
 		printk(VIOCD_KERN_WARNING
@@ -341,7 +353,7 @@
 		return -1;
 	}
 
-	if (dma_map_sg(iSeries_vio_dev, &sg, 1, DMA_FROM_DEVICE) == 0) {
+	if (dma_map_sg(iSeries_vio_dev, &sg, 1, direction) == 0) {
 		printk(VIOCD_KERN_WARNING "error allocating sg tce\n");
 		return -1;
 	}
@@ -349,8 +361,7 @@
 	len = sg_dma_len(&sg);
 
 	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
-			HvLpEvent_Type_VirtualIo,
-			viomajorsubtype_cdio | viocdread,
+			HvLpEvent_Type_VirtualIo, cmd,
 			HvLpEvent_AckInd_DoAck,
 			HvLpEvent_AckType_ImmediateAck,
 			viopath_sourceinst(viopath_hostLp),
@@ -455,6 +466,35 @@
 	return 0;
 }
 
+static int viocd_packet(struct cdrom_device_info *cdi,
+		struct packet_command *cgc)
+{
+	unsigned int buflen = cgc->buflen;
+	int ret = -ENOTTY;
+
+	switch (cgc->cmd[0]) {
+	case GPCMD_READ_DISC_INFO:
+		{
+			disc_information *di = (disc_information *)cgc->buffer;
+
+			if (buflen >= 2) {
+				di->disc_information_length = cpu_to_be16(1);
+				ret = 0;
+			}
+			if (buflen >= 3)
+				di->erasable =
+					(cdi->ops->capability & ~cdi->mask
+					 & (CDC_DVD_RAM | CDC_RAM)) != 0;
+		}
+		break;
+	default:
+		break;
+	}
+
+	cgc->stat = ret;
+	return ret;
+}
+
 /* This routine handles incoming CD LP events */
 static void vio_handle_cd_event(struct HvLpEvent *event)
 {
@@ -508,6 +548,7 @@
 	case viocdclose:
 		break;
 
+	case viocdwrite:
 	case viocdread:
 		/*
 		 * Since this is running in interrupt mode, we need to
@@ -515,7 +556,8 @@
 		 */
 		spin_lock_irqsave(&viocd_reqlock, flags);
 		dma_unmap_single(iSeries_vio_dev, bevent->token, bevent->len,
-				DMA_FROM_DEVICE);
+				((event->xSubtype & VIOMINOR_SUBTYPE_MASK) == viocdread)
+				?  DMA_FROM_DEVICE : DMA_TO_DEVICE);
 		req = (struct request *)bevent->event.xCorrelationToken;
 		rwreq--;
 
@@ -552,14 +594,15 @@
 	.release = viocd_release,
 	.media_changed = viocd_media_changed,
 	.lock_door = viocd_lock_door,
-	.capability = CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK | CDC_SELECT_SPEED | CDC_SELECT_DISC | CDC_MULTI_SESSION | CDC_MCN | CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET | CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_GENERIC_PACKET | CDC_CD_R | CDC_CD_RW | CDC_DVD | CDC_DVD_R | CDC_DVD_RAM
+	.generic_packet = viocd_packet,
+	.capability = CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK | CDC_SELECT_SPEED | CDC_SELECT_DISC | CDC_MULTI_SESSION | CDC_MCN | CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET | CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_GENERIC_PACKET | CDC_CD_R | CDC_CD_RW | CDC_DVD | CDC_DVD_R | CDC_DVD_RAM | CDC_RAM
 };
 
 static int __init find_capability(const char *type)
 {
 	struct capability_entry *entry;
 
-	for(entry = capability_table; entry->type; ++entry)
+	for (entry = capability_table; entry->type; ++entry)
 		if(!strncmp(entry->type, type, 4))
 			break;
 	return entry->capability;

--Signature=_Tue__8_Jun_2004_22_46_46_+1000_sgWRfCfyIwnZHIuo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxbU8FG47PeJeR58RAtaNAJ9VljG8kNn4mx1xaQyZtoZHc9/qSACdF7IM
DI1AR/oWggFOwi9pQbZqJvo=
=zHSi
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jun_2004_22_46_46_+1000_sgWRfCfyIwnZHIuo--
