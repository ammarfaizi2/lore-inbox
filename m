Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUHTHkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUHTHkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHTHkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:40:36 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:18653 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S263003AbUHTHk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:40:28 -0400
Date: Fri, 20 Aug 2004 17:38:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, Jens Axboe <axboe@suse.de>,
       ppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       LKML <linux-kernel@vger.kernel.org>, olh@suse.de
Subject: Re: [PATCH] PPC64 iSeries virtual DVD-RAM
Message-Id: <20040820173850.652694ba.sfr@canb.auug.org.au>
In-Reply-To: <20040609061227.GR13836@suse.de>
References: <20040608224646.529860f4.sfr@canb.auug.org.au>
	<40C5E0CD.8060107@pobox.com>
	<20040609115035.2167efee.sfr@canb.auug.org.au>
	<20040609061227.GR13836@suse.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__20_Aug_2004_17_38_50_+1000_SPu6rO.5ikYPiZN/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__20_Aug_2004_17_38_50_+1000_SPu6rO.5ikYPiZN/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch adds the ability to use DVD-RAM drives to the iSeries virtual
cdrom driver.  This version adresses (hopefully) Jens comments on the
previous one.

The patch is against 2.6.8.1 but sould apply to just about anything. 
Please apply to your tree and Linus'.  There is no clash with the patches
that Paulus has been sending you.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp 2.6.8.1/drivers/cdrom/viocd.c 2.6.8.1-dvdram.1/drivers/cdrom/viocd.c
--- 2.6.8.1/drivers/cdrom/viocd.c	2004-08-19 17:02:02.000000000 +1000
+++ 2.6.8.1-dvdram.1/drivers/cdrom/viocd.c	2004-08-20 00:38:40.000000000 +1000
@@ -121,7 +121,10 @@ struct capability_entry {
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
@@ -332,10 +335,19 @@ static int send_request(struct request *
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
@@ -343,7 +355,7 @@ static int send_request(struct request *
 		return -1;
 	}
 
-	if (dma_map_sg(diskinfo->dev, &sg, 1, DMA_FROM_DEVICE) == 0) {
+	if (dma_map_sg(diskinfo->dev, &sg, 1, direction) == 0) {
 		printk(VIOCD_KERN_WARNING "error allocating sg tce\n");
 		return -1;
 	}
@@ -351,8 +363,7 @@ static int send_request(struct request *
 	len = sg_dma_len(&sg);
 
 	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
-			HvLpEvent_Type_VirtualIo,
-			viomajorsubtype_cdio | viocdread,
+			HvLpEvent_Type_VirtualIo, cmd,
 			HvLpEvent_AckInd_DoAck,
 			HvLpEvent_AckType_ImmediateAck,
 			viopath_sourceinst(viopath_hostLp),
@@ -457,6 +468,41 @@ static int viocd_lock_door(struct cdrom_
 	return 0;
 }
 
+static int viocd_packet(struct cdrom_device_info *cdi,
+		struct packet_command *cgc)
+{
+	unsigned int buflen = cgc->buflen;
+	int ret = -EIO;
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
+		if (cgc->sense) {
+			/* indicate Unknown code */
+			cgc->sense->sense_key = 0x05;
+			cgc->sense->asc = 0x20;
+			cgc->sense->ascq = 0x00;
+		}
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
@@ -510,6 +556,7 @@ return_complete:
 	case viocdclose:
 		break;
 
+	case viocdwrite:
 	case viocdread:
 		/*
 		 * Since this is running in interrupt mode, we need to
@@ -518,7 +565,8 @@ return_complete:
 		di = &viocd_diskinfo[bevent->disk];
 		spin_lock_irqsave(&viocd_reqlock, flags);
 		dma_unmap_single(di->dev, bevent->token, bevent->len,
-				DMA_FROM_DEVICE);
+				((event->xSubtype & VIOMINOR_SUBTYPE_MASK) == viocdread)
+				?  DMA_FROM_DEVICE : DMA_TO_DEVICE);
 		req = (struct request *)bevent->event.xCorrelationToken;
 		rwreq--;
 
@@ -555,7 +603,8 @@ static struct cdrom_device_ops viocd_dop
 	.release = viocd_release,
 	.media_changed = viocd_media_changed,
 	.lock_door = viocd_lock_door,
-	.capability = CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK | CDC_SELECT_SPEED | CDC_SELECT_DISC | CDC_MULTI_SESSION | CDC_MCN | CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET | CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_GENERIC_PACKET | CDC_CD_R | CDC_CD_RW | CDC_DVD | CDC_DVD_R | CDC_DVD_RAM
+	.generic_packet = viocd_packet,
+	.capability = CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK | CDC_SELECT_SPEED | CDC_SELECT_DISC | CDC_MULTI_SESSION | CDC_MCN | CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET | CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_GENERIC_PACKET | CDC_CD_R | CDC_CD_RW | CDC_DVD | CDC_DVD_R | CDC_DVD_RAM | CDC_RAM
 };
 
 static int __init find_capability(const char *type)


--Signature=_Fri__20_Aug_2004_17_38_50_+1000_SPu6rO.5ikYPiZN/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJaqK4CJfqux9a+8RAnI8AJ0fZ4n6BQjYuLzg+p9j3j+c5jBamQCfa2E4
KAGS6wJmQu1mtWyeJ92I59s=
=oMVO
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Aug_2004_17_38_50_+1000_SPu6rO.5ikYPiZN/--
