Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUHRIv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUHRIv3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 04:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUHRIv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 04:51:29 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51598 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S265102AbUHRIux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 04:50:53 -0400
To: Peter Osterlund <petero2@telia.com>
Cc: Julien Oster <lkml-7994@mc.frodoid.org>,
       Frediano Ziglio <freddyz77@tin.it>, axboe@suse.de,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Packet writing problems
References: <1092669361.4254.24.camel@freddy> <m3acwuq5nc.fsf@telia.com>
	<m3657iq4rk.fsf@telia.com> <1092686149.4338.1.camel@freddy>
	<m37jrxk024.fsf@telia.com> <87acwt49zl.fsf@killer.ninja.frodoid.org>
	<m3y8kdibgh.fsf@telia.com> <87fz6k6eel.fsf@killer.ninja.frodoid.org>
	<87brh86du3.fsf@killer.ninja.frodoid.org>
From: Julien Oster <usenet-20040502@usenet.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: Peter Osterlund <petero2@telia.com>,
	Julien Oster <lkml-7994@mc.frodoid.org>,
	Frediano Ziglio <freddyz77@tin.it>, axboe@suse.de,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Date: Wed, 18 Aug 2004 10:48:35 +0200
In-Reply-To: <87brh86du3.fsf@killer.ninja.frodoid.org> (Julien Oster's
 message of "Wed, 18 Aug 2004 10:38:12 +0200")
Message-ID: <877jrw6dcs.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Oster <usenet-20040502@usenet.frodoid.org> writes:

> So here's another patch instead which does what I meant.
>
> Additionally, it inverts the return values of pkt_good_disc, so that
> the condition later becomes "if (!pkt_good_disc(...))" (because
> actually, it is NOT a good disc then)

I forgot to change the comment above the function definition which
describes the return values. Here's a better patch. Additionally, it
also reverts the return values of pkt_good_track() for
convenience. (Same thing as with pkt_good_disc(), since the function
is named that way it should return 'false', i.e. 0, when the disc is
not a good disc for packet writing)

A quick question that came up while writing the patch: can't you
packet write DVD-RAM? I never had the opportunity to handle DVD-RAMs,
but the name suggests a random access memory...

--- fuzzy-2.6.8.1-orig/drivers/block/pktcdvd.c	2004-08-18 01:22:53.000000000 +0200
+++ fuzzy-2.6.8.1/drivers/block/pktcdvd.c	2004-08-18 10:44:26.445886873 +0200
@@ -1528,7 +1528,7 @@ static int pkt_set_write_settings(struct
 }
 
 /*
- * 0 -- we can write to this track, 1 -- we can't
+ * 1 -- we can write to this track, 0 -- we can't
  */
 static int pkt_good_track(track_information *ti)
 {
@@ -1540,39 +1540,64 @@ static int pkt_good_track(track_informat
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
 	switch (pd->mmc3_profile) {
-		case 0x0a: /* CD-RW */
-		case 0xffff: /* MMC3 not supported */
-			break;
-		case 0x1a: /* DVD+RW */
-		case 0x13: /* DVD-RW */
+	        case 0x08: /* CD-ROM */
+	                printk("pktcdvd: inserted media is CD-ROM - no packet writing\n");
 			return 0;
-		default:
-			printk("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
+	        case 0x09: /* CD-R */
+	                printk("pktcdvd: inserted media is CD-R - no packet writing\n");
+			return 0;
+	        case 0x0a: /* CD-RW */
+	                printk("pktcdvd: inserted media is CD-RW\n");
+			return 1;
+	        case 0x10: /* DVD-ROM */
+	                printk("pktcdvd: inserted media is DVD-ROM - no packet writing\n");
+			return 0;
+	        case 0x11: /* DVD-R */
+	                printk("pktcdvd: inserted media is DVD-R - no packet writing\n");
+			return 0;
+	        case 0x12: /* DVD-RAM */
+	                printk("pktcdvd: inserted media is DVD-RAM - no packet writing\n");
+			return 0;
+		case 0x13: /* DVD-RW restricted overwrite */
+			printk("pktcdvd: inserted media is DVD-RW with restricted overwrite");
+			return 1;
+		case 0x14: /* DVD-RW sequential recording */
+			printk("pktcdvd: inserted media is DVD-RW with sequential recording"
+			       " - no packet writing\n");
+			return 0;
+		case 0x1a: /* DVD+RW */
+			printk("pktcdvd: inserted media is DVD+RW\n");
 			return 1;
+		case 0xffff: /* unconforming */
+			printk("pktcdvd: inserted media does not conform to a known standard\n");
+			break;
+		default:
+			printk("pktcdvd: inserted media is yet UNKNOWN by pktcdvd\n");
+			return 0;
 	}
 
 	/*
@@ -1581,25 +1606,25 @@ static int pkt_good_disc(struct pktcdvd_
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
@@ -1624,20 +1649,9 @@ static int pkt_probe_settings(struct pkt
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
@@ -1646,7 +1660,7 @@ static int pkt_probe_settings(struct pkt
 		return ret;
 	}
 
-	if (pkt_good_track(&ti)) {
+	if (!pkt_good_track(&ti)) {
 		printk("pktcdvd: can't write to this track\n");
 		return -ENXIO;
 	}

Regards,
Julien
