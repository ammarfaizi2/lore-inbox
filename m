Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUH1JyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUH1JyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUH1Jvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:51:54 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:34036 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S267401AbUH1JqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:46:05 -0400
Message-ID: <41305493.CCA78311@fy.chalmers.se>
Date: Sat, 28 Aug 2004 11:46:59 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en,sv,ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, samuel.thibault@ens-lyon.org
Subject: Re: 2.6.9-rcX cdrom.c is subject to "chaotic" behaviour
References: <412C65D6.4050105@fy.chalmers.se> <20040826031414.56052871.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As per
> > http://marc.theaimsgroup.com/?l=bk-commits-head&m=109330228416908&w=2,
> > cdrom.c becomes subject to chaotic behavior. The culprit is newly
> > introduced if-statement such as following:
> >
> > if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),disc_type))
> >
> > The catch is that cdrom_get_disc_info returns signed value, most notably
> > negative one upon error, while the offsetof on the other hand is
> > unsigned. When signed and unsigned values are compared, signed one is
> > treated as unsigned and therefore in case of error condition in
> > cdrom_get_disc_info the if-statement is doomed to be evaluated false,
> > which in turn results in random values from the stack being evaluated
> > further down.

I suppose I have to retract on the last part of my statement, namely
"random values from the stack being evaluated," as the structures
are zeroed in init_cdrom_command prior issuing corresponding MMC command.
But it doesn't invalidate the statement as whole, as execution flow does
take unintended path.

> How about this?

It's insufficient. There're more occurences of broken comparisons and
not only with cdrom_get_disc_info. I suggest following. In addition to
comparisons, the suggested patch makes CDROMVOL* ioctl more robust. A.

8<-------8<-------8<-------8<-------8<-------8<-------8<-------8<-------
--- ./drivers/cdrom/cdrom.c.orig	Tue Aug 24 18:54:41 2004
+++ ./drivers/cdrom/cdrom.c	Sat Aug 28 11:08:43 2004
@@ -610,7 +610,7 @@
 	disc_information di;
 	int ret = 0;
 
-	if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),disc_type))
+	if (cdrom_get_disc_info(cdi, &di) < (int)offsetof(typeof(di),disc_type))
 		return 1;
 
 	if (di.mrw_status == CDM_MRW_BGFORMAT_ACTIVE) {
@@ -719,7 +719,7 @@
 {
 	disc_information di;
 
-	if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),n_first_track))
+	if (cdrom_get_disc_info(cdi, &di) < (int)offsetof(typeof(di),n_first_track))
 		return -1;
 
 	return di.erasable;
@@ -755,7 +755,7 @@
 		return 1;
 	}
 
-	if (cdrom_get_disc_info(cdi, &di) < offsetof(typeof(di),disc_type))
+	if (cdrom_get_disc_info(cdi, &di) < (int)offsetof(typeof(di),disc_type))
 		return 1;
 
 	if (!di.erasable)
@@ -2507,7 +2507,7 @@
 	struct cdrom_device_ops *cdo = cdi->ops;
 	struct packet_command cgc;
 	struct request_sense sense;
-	char buffer[32];
+	unsigned char buffer[32];
 	int ret = 0;
 
 	memset(&cgc, 0, sizeof(cgc));
@@ -2634,8 +2634,9 @@
 	case CDROMVOLCTRL:
 	case CDROMVOLREAD: {
 		struct cdrom_volctrl volctrl;
-		char mask[32];
+		char mask[sizeof(buffer)];
 		unsigned short offset;
+
 		cdinfo(CD_DO_IOCTL, "entering CDROMVOLUME\n");
 
 		IOCTL_IN(arg, struct cdrom_volctrl, volctrl);
@@ -2645,18 +2646,27 @@
 		if ((ret = cdrom_mode_sense(cdi, &cgc, GPMODE_AUDIO_CTL_PAGE, 0)))
 		    return ret;
 		
-		/* some drives have longer pages, adjust and reread. */
-		if (buffer[1] > cgc.buflen) {
-			cgc.buflen = buffer[1] + 2;
+		/* originally the code depended on buffer[1] to determine
+		   how much data is available for transfer. buffer[1] is
+		   unfortunately ambigious and the only reliable way seem
+		   to be to simply skip over the block descriptor... */
+		offset = 8 + be16_to_cpu(*(unsigned short *)(buffer+6));
+
+		if (offset+16 > sizeof(buffer))
+			return -E2BIG;
+
+		if (offset+16 > cgc.buflen) {
+			cgc.buflen = offset+16;
 			if ((ret = cdrom_mode_sense(cdi, &cgc, 
 					GPMODE_AUDIO_CTL_PAGE, 0))) 
 			    return ret;
 		}
-		
-		/* get the offset from the length of the page. length
-		   is measure from byte 2 an on, thus the 14. */
-		offset = buffer[1] - 14;
 
+		/* sanity check */
+		if ((buffer[offset]&0x3F) == GPMODE_AUDIO_CTL_PAGE
+		    || buffer[offset+1] < 14)
+			return -EINVAL;
+		
 		/* now we have the current volume settings. if it was only
 		   a CDROMVOLREAD, return these values */
 		if (cmd == CDROMVOLREAD) {
@@ -2680,7 +2690,8 @@
 		buffer[offset+15] = volctrl.channel3 & mask[offset+15];
 
 		/* set volume */
-		cgc.buffer = buffer;
+		cgc.buffer = buffer+offset-8;
+		memset(cgc.buffer,0,8);
 		return cdrom_mode_select(cdi, &cgc);
 		}
 
@@ -2836,28 +2847,32 @@
 	if (!CDROM_CAN(CDC_GENERIC_PACKET))
 		goto use_toc;
 
-	if ((ret = cdrom_get_disc_info(cdi, &di))
-			< offsetof(typeof(di), last_track_msb)
-			+ sizeof(di.last_track_msb))
+	ret = cdrom_get_disc_info(cdi, &di);
+	if (ret < (int)(offsetof(typeof(di), last_track_lsb)
+			+ sizeof(di.last_track_lsb)))
 		goto use_toc;
 
+	/* if unit didn't return msb, it's zeroed by cdrom_get_disc_info */
 	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
 	ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
-	if (ti_size < offsetof(typeof(ti), track_start))
+	if (ti_size < (int)offsetof(typeof(ti), track_start))
 		goto use_toc;
 
 	/* if this track is blank, try the previous. */
 	if (ti.blank) {
+		if (last_track==1)
+			goto use_toc;
 		last_track--;
 		ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
 	}
 
-	if (ti_size < offsetof(typeof(ti), track_size) + sizeof(ti.track_size))
+	if (ti_size < (int)(offsetof(typeof(ti), track_size)
+				+ sizeof(ti.track_size)))
 		goto use_toc;
 
 	/* if last recorded field is valid, return it. */
-	if (ti.lra_v && ti_size >= offsetof(typeof(ti), last_rec_address)
-				+ sizeof(ti.last_rec_address)) {
+	if (ti.lra_v && ti_size >= (int)(offsetof(typeof(ti), last_rec_address)
+				+ sizeof(ti.last_rec_address))) {
 		*last_written = be32_to_cpu(ti.last_rec_address);
 	} else {
 		/* make it up instead */
@@ -2893,25 +2908,30 @@
 	if (!CDROM_CAN(CDC_GENERIC_PACKET))
 		goto use_last_written;
 
-	if ((ret = cdrom_get_disc_info(cdi, &di))
-			< offsetof(typeof(di), last_track_msb)
-			+ sizeof(di.last_track_msb))
+	ret = cdrom_get_disc_info(cdi, &di);
+	if (ret < (int)(offsetof(typeof(di), last_track_lsb)
+			+ sizeof(di.last_track_lsb)))
 		goto use_last_written;
 
+	/* if unit didn't return msb, it's zeroed by cdrom_get_disc_info */
 	last_track = (di.last_track_msb << 8) | di.last_track_lsb;
 	ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
-	if (ti_size < offsetof(typeof(ti), track_start))
+	if (ti_size < (int)offsetof(typeof(ti), track_start))
 		goto use_last_written;
 
         /* if this track is blank, try the previous. */
 	if (ti.blank) {
+		if (last_track==1)
+			goto use_last_written;
 		last_track--;
 		ti_size = cdrom_get_track_info(cdi, last_track, 1, &ti);
+		if (ti_size < 0)
+			goto use_last_written;
 	}
 
 	/* if next recordable address field is valid, use it. */
-	if (ti.nwa_v && ti_size >= offsetof(typeof(ti), next_writable)
-				+ sizeof(ti.next_writable)) {
+	if (ti.nwa_v && ti_size >= (int)(offsetof(typeof(ti), next_writable)
+				+ sizeof(ti.next_writable))) {
 		*next_writable = be32_to_cpu(ti.next_writable);
 		return 0;
 	}
