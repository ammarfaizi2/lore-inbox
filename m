Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268518AbUHQXYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268518AbUHQXYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268512AbUHQXYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:24:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47080 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S268518AbUHQXYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:24:33 -0400
To: Peter Osterlund <petero2@telia.com>
Cc: Frediano Ziglio <freddyz77@tin.it>, axboe@suse.de,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Packet writing problems
References: <1092669361.4254.24.camel@freddy> <m3acwuq5nc.fsf@telia.com>
	<m3657iq4rk.fsf@telia.com> <1092686149.4338.1.camel@freddy>
	<m37jrxk024.fsf@telia.com>
From: Julien Oster <lkml-7994@mc.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: Peter Osterlund <petero2@telia.com>,
	Frediano Ziglio <freddyz77@tin.it>, axboe@suse.de,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Date: Wed, 18 Aug 2004 01:31:58 +0200
In-Reply-To: <m37jrxk024.fsf@telia.com> (Peter Osterlund's message of "17
 Aug 2004 21:59:47 +0200")
Message-ID: <87acwt49zl.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

Hello Peter,

> That shouldn't cause any real problems, but since it's quite
> confusing, here is a patch to fix it.  With this change, both DVD+RW
> and DVD-RW media is correctly identified in the kernel log, and DVD
> speeds are printed in kB/s.

The following patch on top of your patch adds all commonly used media
types to the output and changes CD-R and CD-RW to be detected by
profile type. It also reports unconforming non-standard profiles as
well as profiles which have a MMC profile definition but are unknown
as of the current MMC3 revision.

Please review.

--- fuzzy-2.6.8.1-orig/drivers/block/pktcdvd.c	2004-08-18 01:22:53.540198893 +0200
+++ fuzzy-2.6.8.1/drivers/block/pktcdvd.c	2004-08-18 01:24:25.983297748 +0200
@@ -1628,14 +1628,38 @@ static int pkt_probe_settings(struct pkt
 		return -ENXIO;
 
 	switch (pd->mmc3_profile) {
+	        case 0x08: /* CD-ROM */
+	                printk("pktcdvd: inserted media is CD-ROM\n");
+			break;
+	        case 0x09: /* CD-R */
+	                printk("pktcdvd: inserted media is CD-R\n");
+			break;
+	        case 0x0a: /* CD-RW */
+	                printk("pktcdvd: inserted media is CD-RW\n");
+			break;
+	        case 0x10: /* DVD-ROM */
+	                printk("pktcdvd: inserted media is DVD-ROM\n");
+			break;
+	        case 0x11: /* DVD-R */
+	                printk("pktcdvd: inserted media is DVD-R\n");
+			break;
+	        case 0x12: /* DVD-RAM */
+	                printk("pktcdvd: inserted media is DVD-RAM\n");
+			break;
+		case 0x13: /* DVD-RW restricted overwrite */
+			printk("pktcdvd: inserted media is DVD-RW with restricted overwrite\n");
+			break;
+		case 0x14: /* DVD-RW sequential recording */
+			printk("pktcdvd: inserted media is DVD-RW with sequential recording\n");
+			break;
 		case 0x1a: /* DVD+RW */
 			printk("pktcdvd: inserted media is DVD+RW\n");
 			break;
-		case 0x13: /* DVD-RW */
-			printk("pktcdvd: inserted media is DVD-RW\n");
+		case 0xffff: /* unconforming */
+			printk("pktcdvd: inserted media does not conform to a known standard\n");
 			break;
 		default:
-			printk("pktcdvd: inserted media is CD-R%s\n", di.erasable ? "W" : "");
+			printk("pktcdvd: inserted media is yet UNKNOWN by pktcdvd\n");
 			break;
 	}
 	pd->type = di.erasable ? PACKET_CDRW : PACKET_CDR;


Regards,
Julien
