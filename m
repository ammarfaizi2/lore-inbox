Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUGSPYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUGSPYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 11:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUGSPYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 11:24:01 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:20442 "EHLO
	mailfe02.swip.net") by vger.kernel.org with ESMTP id S264774AbUGSPXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 11:23:24 -0400
X-T2-Posting-ID: fsSkX0G4UDZBQyf4PliIiQ==
Date: Mon, 19 Jul 2004 17:20:29 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Cc: sebastien.hinderer@libertysurf.fr
Subject: cdrom.c fixup
Message-ID: <20040719152029.GN2553@bouh.famille.thibault.fr>
Mail-Followup-To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	sebastien.hinderer@libertysurf.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i-nntp3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's something wrong in cdrom.c: cdrom_get_last_written() for
instance calls cdrom_get_disc_info() and cdrom_get_track_info() to
get information about tracks, but these functions don't ensure that
all the track_information or disc_information structure is filled:
	/* (buflen was first set to 8 to get track_information_length field) */

	if ((ret = cdo->generic_packet(cdi, &cgc)))
		return ret;
	
	cgc.buflen = be16_to_cpu(ti->track_information_length) +
		     sizeof(ti->track_information_length);

	if (cgc.buflen > sizeof(track_information))
		cgc.buflen = sizeof(track_information);

	cgc.cmd[8] = cgc.buflen;
	return cdo->generic_packet(cdi, &cgc);

The second test ensures that at least we won't overflow the structure,
but nothing ensures that all the structure will be filled.

And indeed, we have a drive here that won't fill it all:
the returned track_information_length field will be *less than*
sizeof(track_information) - sizeof(ti->track_information_length),
so that cdrom_get_last_written() reads values that weren't filled in!
As a result, we are sometimes unable to read some parts of CDROMs,
depending on the uninitialized state of the structure...

Here is a patch that adds filling checks: cdrom_get_disc_info() and
cdrom_get_track_info() return the actual filled length, and it's up
to the caller to check that this is enough for him to get the values
it wants.

Note: adding something like a
#define spanof(TYPE, MEMBER) ((size_t) ((&((TYPE *)0)->MEMBER)+1))
definition just near that of offsetof() in include/linux/stddef.h would
make it more pretty, but still it won't help for bitfields :/

Regards,
Samuel

--- linux-2.6.7-orig/drivers/cdrom/cdrom.c	2004-06-16 10:40:57.000000000 +0200
+++ linux/drivers/cdrom/cdrom.c	2004-07-19 16:52:53.000000000 +0200
@@ -603,7 +603,7 @@
 	disc_information di;
 	int ret = 0;
 
-	if (cdrom_get_disc_info(cdi, &di))
+	if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),disc_type))
 		return 1;
 
 	if (di.mrw_status == CDM_MRW_BGFORMAT_ACTIVE) {
@@ -712,7 +712,7 @@
 {
 	disc_information di;
 
-	if (cdrom_get_disc_info(cdi, &di))
+	if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),n_first_track))
 		return -1;
 
 	return di.erasable;
@@ -748,7 +748,7 @@
 		return 1;
 	}
 
-	if (cdrom_get_disc_info(cdi, &di))
+	if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),disc_type))
 		return 1;
 
 	if (!di.erasable)
@@ -2718,7 +2718,7 @@
 {
 	struct cdrom_device_ops *cdo = cdi->ops;
 	struct packet_command cgc;
-	int ret;
+	int ret, buflen;
 
 	init_cdrom_command(&cgc, ti, 8, CGC_DATA_READ);
 	cgc.cmd[0] = GPCMD_READ_TRACK_RZONE_INFO;
@@ -2731,14 +2731,18 @@
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
 		return ret;
 	
-	cgc.buflen = be16_to_cpu(ti->track_information_length) +
+	buflen = be16_to_cpu(ti->track_information_length) +
 		     sizeof(ti->track_information_length);
 
-	if (cgc.buflen > sizeof(track_information))
-		cgc.buflen = sizeof(track_information);
+	if (buflen > sizeof(track_information))
+		buflen = sizeof(track_information);
 
-	cgc.cmd[8] = cgc.buflen;
-	return cdo->generic_packet(cdi, &cgc);
+	cgc.cmd[8] = cgc.buflen = buflen;
+	if ((ret = cdo->generic_packet(cdi, &cgc)))
+		return ret;
+
+	/* return actual fill size */
+	return buflen;
 }
 
 /* requires CD R/RW */
@@ -2746,7 +2750,7 @@
 {
 	struct cdrom_device_ops *cdo = cdi->ops;
 	struct packet_command cgc;
-	int ret;
+	int ret, buflen;
 
 	/* set up command and get the disc info */
 	init_cdrom_command(&cgc, di, sizeof(*di), CGC_DATA_READ);
@@ -2760,14 +2764,18 @@
 	/* not all drives have the same disc_info length, so requeue
 	 * packet with the length the drive tells us it can supply
 	 */
-	cgc.buflen = be16_to_cpu(di->disc_information_length) +
+	buflen = be16_to_cpu(di->disc_information_length) +
 		     sizeof(di->disc_information_length);
 
-	if (cgc.buflen > sizeof(disc_information))
-		cgc.buflen = sizeof(disc_information);
+	if (buflen > sizeof(disc_information))
+		buflen = sizeof(disc_information);
 
-	cgc.cmd[8] = cgc.buflen;
-	return cdo->generic_packet(cdi, &cgc);
+	cgc.cmd[8] = cgc.buflen = buflen;
+	if ((ret = cdo->generic_packet(cdi, &cgc)))
+		return ret;
+
+	/* return actual fill size */
+	return buflen;
 }
 
 /* return the last written block on the CD-R media. this is for the udf
@@ -2778,27 +2786,33 @@
 	disc_information di;
 	track_information ti;
 	__u32 last_track;
-	int ret = -1;
+	int ret = -1, ti_size;
 
 	if (!CDROM_CAN(CDC_GENERIC_PACKET))
 		goto use_toc;
 
-	if ((ret = cdrom_get_disc_info(cdi, &di)))
+	if ((ret = cdrom_get_disc_info(cdi, &di))
+			< offsetof(typeof(di), last_track_msb)
+			+ sizeof(di.last_track_msb))
 		goto use_toc;
 
 	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
-	if ((ret = cdrom_get_track_info(cdi, last_track, 1, &ti)))
+	ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
+	if (ti_size < offsetof(typeof(ti), track_start))
 		goto use_toc;
 
 	/* if this track is blank, try the previous. */
 	if (ti.blank) {
 		last_track--;
-		if ((ret = cdrom_get_track_info(cdi, last_track, 1, &ti)))
-			goto use_toc;
+		ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
 	}
 
+	if (ti_size < offsetof(typeof(ti), track_size) + sizeof(ti.track_size))
+		goto use_toc;
+
 	/* if last recorded field is valid, return it. */
-	if (ti.lra_v) {
+	if (ti.lra_v && ti_size >= offsetof(typeof(ti), last_rec_address)
+				+ sizeof(ti.last_rec_address)) {
 		*last_written = be32_to_cpu(ti.last_rec_address);
 	} else {
 		/* make it up instead */
@@ -2811,11 +2825,12 @@
 
 	/* this is where we end up if the drive either can't do a
 	   GPCMD_READ_DISC_INFO or GPCMD_READ_TRACK_RZONE_INFO or if
-	   it fails. then we return the toc contents. */
+	   it doesn't give enough information or fails. then we return
+	   the toc contents. */
 use_toc:
 	toc.cdte_format = CDROM_MSF;
 	toc.cdte_track = CDROM_LEADOUT;
-	if (cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc))
+	if ((ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc)))
 		return ret;
 	sanitize_format(&toc.cdte_addr, &toc.cdte_format, CDROM_LBA);
 	*last_written = toc.cdte_addr.lba;
@@ -2828,32 +2843,33 @@
 	disc_information di;
 	track_information ti;
 	__u16 last_track;
-	int ret = -1;
+	int ret = -1, ti_size;
 
 	if (!CDROM_CAN(CDC_GENERIC_PACKET))
 		goto use_last_written;
 
-	if ((ret = cdrom_get_disc_info(cdi, &di)))
+	if ((ret = cdrom_get_disc_info(cdi, &di))
+			< offsetof(typeof(di), last_track_msb)
+			+ sizeof(di.last_track_msb))
 		goto use_last_written;
 
 	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
-	if ((ret = cdrom_get_track_info(cdi, last_track, 1, &ti)))
+	ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
+	if (ti_size < offsetof(typeof(ti), track_start))
 		goto use_last_written;
 
         /* if this track is blank, try the previous. */
 	if (ti.blank) {
 		last_track--;
-		if ((ret = cdrom_get_track_info(cdi, last_track, 1, &ti)))
-			goto use_last_written;
+		ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
 	}
 
 	/* if next recordable address field is valid, use it. */
-	if (ti.nwa_v)
+	if (ti.nwa_v && ti_size >= offsetof(typeof(ti), next_writable)
+				+ sizeof(ti.next_writable)) {
 		*next_writable = be32_to_cpu(ti.next_writable);
-	else
-		goto use_last_written;
-
-	return 0;
+		return 0;
+	}
 
 use_last_written:
 	if ((ret = cdrom_get_last_written(cdi, next_writable))) {
