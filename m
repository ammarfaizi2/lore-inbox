Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRCGW12>; Wed, 7 Mar 2001 17:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131223AbRCGW1S>; Wed, 7 Mar 2001 17:27:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34318 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131219AbRCGW1G>;
	Wed, 7 Mar 2001 17:27:06 -0500
Date: Wed, 7 Mar 2001 23:26:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Derek Fawcus <dfawcus@cisco.com>
Cc: Pozsar Balazs <pozsy@sch.bme.hu>, linux-kernel@vger.kernel.org
Subject: Re: can't read DVD (under 2.4.[12] & 2.2.17)
Message-ID: <20010307232637.T4653@suse.de>
In-Reply-To: <20010307210848.E4653@suse.de> <Pine.GSO.4.30.0103072128180.6575-100000@balu> <20010307213632.H4653@suse.de> <20010307213625.A28742@uk-view2.cisco.com> <20010307224424.R4653@suse.de> <20010307224641.S4653@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20010307224641.S4653@suse.de>; from axboe@suse.de on Wed, Mar 07, 2001 at 10:46:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07 2001, Jens Axboe wrote:
> On Wed, Mar 07 2001, Jens Axboe wrote:
> > Really good question, I sent this patch in the private thread between
> > me and Pozsar just in case the length is what the drive complains about.
> 
> Agrh, that's not all. I will fix this properly, sorry about the noise.

This should work. Pozsar, could you test?

I suspect that Derik is right though, that the 05/24/00 is because
the dvdinfo is requesting info for a non-existant physical layer.
I've attempted to quiet that error. You dvdinfo output did look
very odd.

-- 
Jens Axboe


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dvd-read-phys-2

--- /opt/kernel/linux-2.4.3-pre3/drivers/cdrom/cdrom.c	Thu Feb 22 14:55:22 2001
+++ drivers/cdrom/cdrom.c	Wed Mar  7 23:25:52 2001
@@ -1171,42 +1171,50 @@
 
 static int dvd_read_physical(struct cdrom_device_info *cdi, dvd_struct *s)
 {
-	int ret, i;
-	u_char buf[4 + 4 * 20], *base;
+	unsigned char buf[20], *base;
 	struct dvd_layer *layer;
 	struct cdrom_generic_command cgc;
 	struct cdrom_device_ops *cdo = cdi->ops;
+	int ret, layer_num = s->physical.layer_num;
+
+	if (layer_num >= DVD_LAYERS)
+		return -EINVAL;
 
 	init_cdrom_command(&cgc, buf, sizeof(buf), CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_DVD_STRUCTURE;
-	cgc.cmd[6] = s->physical.layer_num;
+	cgc.cmd[6] = layer_num;
 	cgc.cmd[7] = s->type;
 	cgc.cmd[9] = cgc.buflen & 0xff;
 
+	/*
+	 * refrain from reporting errors on non-existing layers (mainly)
+	 */
+	cgc.quiet = 1;
+
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
 		return ret;
 
 	base = &buf[4];
-	layer = &s->physical.layer[0];
+	layer = &s->physical.layer[layer_num];
 
-	/* place the data... really ugly, but at least we won't have to
-	   worry about endianess in userspace or here. */
-	for (i = 0; i < 4; ++i, base += 20, ++layer) {
-		memset(layer, 0, sizeof(*layer));
-		layer->book_version = base[0] & 0xf;
-		layer->book_type = base[0] >> 4;
-		layer->min_rate = base[1] & 0xf;
-		layer->disc_size = base[1] >> 4;
-		layer->layer_type = base[2] & 0xf;
-		layer->track_path = (base[2] >> 4) & 1;
-		layer->nlayers = (base[2] >> 5) & 3;
-		layer->track_density = base[3] & 0xf;
-		layer->linear_density = base[3] >> 4;
-		layer->start_sector = base[5] << 16 | base[6] << 8 | base[7];
-		layer->end_sector = base[9] << 16 | base[10] << 8 | base[11];
-		layer->end_sector_l0 = base[13] << 16 | base[14] << 8 | base[15];
-		layer->bca = base[16] >> 7;
-	}
+	/*
+	 * place the data... really ugly, but at least we won't have to
+	 * worry about endianess in userspace.
+	 */
+	memset(layer, 0, sizeof(*layer));
+	layer->book_version = base[0] & 0xf;
+	layer->book_type = base[0] >> 4;
+	layer->min_rate = base[1] & 0xf;
+	layer->disc_size = base[1] >> 4;
+	layer->layer_type = base[2] & 0xf;
+	layer->track_path = (base[2] >> 4) & 1;
+	layer->nlayers = (base[2] >> 5) & 3;
+	layer->track_density = base[3] & 0xf;
+	layer->linear_density = base[3] >> 4;
+	layer->start_sector = base[5] << 16 | base[6] << 8 | base[7];
+	layer->end_sector = base[9] << 16 | base[10] << 8 | base[11];
+	layer->end_sector_l0 = base[13] << 16 | base[14] << 8 | base[15];
+	layer->bca = base[16] >> 7;
 
 	return 0;
 }
--- /opt/kernel/linux-2.4.3-pre3/include/linux/cdrom.h	Tue Jan 30 08:24:56 2001
+++ include/linux/cdrom.h	Wed Mar  7 23:00:07 2001
@@ -524,10 +524,12 @@
 	__u32 end_sector_l0;
 };
 
+#define DVD_LAYERS	4
+
 struct dvd_physical {
 	__u8 type;
 	__u8 layer_num;
-	struct dvd_layer layer[4];
+	struct dvd_layer layer[DVD_LAYERS];
 };
 
 struct dvd_copyright {

--gE7i1rD7pdK0Ng3j--
