Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUHRRKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUHRRKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 13:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUHRRKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 13:10:31 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60595 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S267354AbUHRRKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 13:10:15 -0400
To: Alex Riesen <ari@mbs-software.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Packet writing problems
References: <20040818125719.GA6021@linux-ari.internal>
From: Julien Oster <lkml-7994@mc.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: Alex Riesen <ari@mbs-software.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 18 Aug 2004 19:08:15 +0200
In-Reply-To: <20040818125719.GA6021@linux-ari.internal> (Alex Riesen's
 message of "Wed, 18 Aug 2004 14:57:19 +0200")
Message-ID: <87u0v08jcw.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen <ari@mbs-software.de> writes:

(I guess your mail was also meant to lkml?)

> this part has '\n' missing.

> BTW, all the printks have "pktcdvd: inserted media " prefixed and no
> arguments. Probably something like this can be useful:

> static void inserted_media(const char* desc)

[...]

> The purpose is clear without an extra comment.

Aaaand another one.

Maybe the following approach is nice?

We're making a lot of mess about some simple output.


--- fuzzy-2.6.8.1-orig/drivers/block/pktcdvd.c	2004-08-18 01:22:53.000000000 +0200
+++ fuzzy-2.6.8.1/drivers/block/pktcdvd.c	2004-08-18 18:59:41.136535859 +0200
@@ -1528,7 +1528,7 @@ static int pkt_set_write_settings(struct
 }
 
 /*
- * 0 -- we can write to this track, 1 -- we can't
+ * 1 -- we can write to this track, 0 -- we can't
  */
 static int pkt_good_track(track_information *ti)
 {
@@ -1540,66 +1540,111 @@ static int pkt_good_track(track_informat
 	 * FIXME: only for FP
 	 */
 	if (ti->fp == 0)
-		return 0;
+		return 1;
 
 	/*
 	 * "good" settings as per Mt Fuji.
 	 */
 	if (ti->rt == 0 && ti->blank == 0 && ti->packet == 1)
-		return 0;
+		return 1;
 
 	if (ti->rt == 0 && ti->blank == 1 && ti->packet == 1)
-		return 0;
+		return 1;
 
 	if (ti->rt == 1 && ti->blank == 0 && ti->packet == 1)
-		return 0;
+		return 1;
 
 	printk("pktcdvd: bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
-	return 1;
+	return 0;
 }
 
 /*
- * 0 -- we can write to this disc, 1 -- we can't
+ * 1 -- we can write to this disc, 0 -- we can't
  */
 static int pkt_good_disc(struct pktcdvd_device *pd, disc_information *di)
 {
+        char *mediatypename;
+	int packet_ok;
+
 	switch (pd->mmc3_profile) {
-		case 0x0a: /* CD-RW */
-		case 0xffff: /* MMC3 not supported */
+	        case 0x08: /* CD-ROM */
+		        mediatypename = "CD-ROM";
+			packet_ok = 0;
+			break;
+	        case 0x09: /* CD-R */
+		        mediatypename = "CD-R";
+			packet_ok = 0;
+			break;
+	        case 0x0a: /* CD-RW */
+		        mediatypename = "CD-RW";
+			packet_ok = 1;
+			break;
+	        case 0x10: /* DVD-ROM */
+		        mediatypename = "DVD-ROM";
+			packet_ok = 0;
+			break;
+	        case 0x11: /* DVD-R */
+		        mediatypename = "DVD-R";
+			packet_ok = 0;
+			break;
+	        case 0x12: /* DVD-RAM */
+		        mediatypename = "DVD-RAM";
+			packet_ok = 0;
+			break;
+		case 0x13: /* DVD-RW restricted overwrite */
+		        mediatypename = "DVD-RW w/ restricted overwrite";
+			packet_ok = 1;
+			break;
+		case 0x14: /* DVD-RW sequential recording */
+		        mediatypename = "DVD-RW w/ sequential recording";
+			packet_ok = 0;
 			break;
 		case 0x1a: /* DVD+RW */
-		case 0x13: /* DVD-RW */
-			return 0;
+		        mediatypename = "DVD+RW";
+			packet_ok = 1;
+			break;
+		case 0xffff: /* unconforming */
+		        mediatypename = "MMC unconforming";
+
+			/* handle it specially below */
+			packet_ok = 2;
+			break;
 		default:
-			printk("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
-			return 1;
+		        mediatypename = "unknown to pktcdvd";
+			packet_ok = 0;
 	}
 
+	printk("pktcdvd: inserted media is %s %s\n", mediatypename,
+	       packet_ok ? "" : "- no packet writing supported");
+
+	if (packet_ok != 2)
+	  return packet_ok;
+
 	/*
 	 * for disc type 0xff we should probably reserve a new track.
 	 * but i'm not sure, should we leave this to user apps? probably.
 	 */
 	if (di->disc_type == 0xff) {
 		printk("pktcdvd: Unknown disc. No track?\n");
-		return 1;
+		return 0;
 	}
 
 	if (di->disc_type != 0x20 && di->disc_type != 0) {
 		printk("pktcdvd: Wrong disc type (%x)\n", di->disc_type);
-		return 1;
+		return 0;
 	}
 
 	if (di->erasable == 0) {
 		printk("pktcdvd: Disc not erasable\n");
-		return 1;
+		return 0;
 	}
 
 	if (di->border_status == PACKET_SESSION_RESERVED) {
 		printk("pktcdvd: Can't write to last track (reserved)\n");
-		return 1;
+		return 0;
 	}
 
-	return 0;
+	return 1;
 }
 
 static int pkt_probe_settings(struct pktcdvd_device *pd)
@@ -1624,20 +1669,9 @@ static int pkt_probe_settings(struct pkt
 		return ret;
 	}
 
-	if (pkt_good_disc(pd, &di))
+	if (!pkt_good_disc(pd, &di))
 		return -ENXIO;
 
-	switch (pd->mmc3_profile) {
-		case 0x1a: /* DVD+RW */
-			printk("pktcdvd: inserted media is DVD+RW\n");
-			break;
-		case 0x13: /* DVD-RW */
-			printk("pktcdvd: inserted media is DVD-RW\n");
-			break;
-		default:
-			printk("pktcdvd: inserted media is CD-R%s\n", di.erasable ? "W" : "");
-			break;
-	}
 	pd->type = di.erasable ? PACKET_CDRW : PACKET_CDR;
 
 	track = 1; /* (di.last_track_msb << 8) | di.last_track_lsb; */
@@ -1646,7 +1680,7 @@ static int pkt_probe_settings(struct pkt
 		return ret;
 	}
 
-	if (pkt_good_track(&ti)) {
+	if (!pkt_good_track(&ti)) {
 		printk("pktcdvd: can't write to this track\n");
 		return -ENXIO;
 	}

Regards,
Julien
