Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUH1JyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUH1JyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267399AbUH1JwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:52:14 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:62196 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S267411AbUH1Jqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:46:32 -0400
Message-ID: <413054AE.98FCE658@fy.chalmers.se>
Date: Sat, 28 Aug 2004 11:47:26 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en,sv,ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] ide-cd.c to mount multi-session DVD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With respect to http://marc.theaimsgroup.com/?l=linux-kernel&m=108827602322464&w=2
I'd like to nominate the attached patch. And while we're on ide-cd.c
track I also wonder why has dma alignment requirement been hardened?

-	blk_queue_dma_alignment(drive->queue, 3);
+	blk_queue_dma_alignment(drive->queue, 31);

I can find requirement for minimal lenght reasonable, but who aligns
pointers at 32 byte boundary? Cheers. A.

8<-------8<-------8<-------8<-------8<-------8<-------8<-------8<-------
--- ./drivers/ide/ide-cd.c.orig	Tue Aug 24 18:54:42 2004
+++ ./drivers/ide/ide-cd.c	Fri Aug 27 20:31:27 2004
@@ -2356,26 +2356,32 @@
 	/* Read the multisession information. */
 	if (toc->hdr.first_track != CDROM_LEADOUT) {
 		/* Read the multisession information. */
-		stat = cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
+		int ask_for_msf=0;
+#if ! STANDARD_ATAPI
+		if (CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd)
+			ask_for_msf=1;
+#endif
+		stat = cdrom_read_tocentry(drive, 0, ask_for_msf, 1,
+					   (char *)&ms_tmp,
 					   sizeof(ms_tmp), sense);
 		if (stat) return stat;
 	} else {
-		ms_tmp.ent.addr.msf.minute = 0;
-		ms_tmp.ent.addr.msf.second = 2;
-		ms_tmp.ent.addr.msf.frame  = 0;
+		ms_tmp.ent.addr.lba = 0;
 		ms_tmp.hdr.first_track = ms_tmp.hdr.last_track = CDROM_LEADOUT;
 	}
 
+	toc->last_session_lba = be32_to_cpu(ms_tmp.ent.addr.lba);
+	toc->xa_flag = (ms_tmp.hdr.first_track != ms_tmp.hdr.last_track);
+
 #if ! STANDARD_ATAPI
-	if (CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd)
+	if (CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd
+	    && toc->hdr.first_track != CDROM_LEADOUT) {
 		msf_from_bcd (&ms_tmp.ent.addr.msf);
+		toc->last_session_lba = msf_to_lba (ms_tmp.ent.addr.msf.minute,
+						    ms_tmp.ent.addr.msf.second,
+						    ms_tmp.ent.addr.msf.frame);
+	}
 #endif  /* not STANDARD_ATAPI */
-
-	toc->last_session_lba = msf_to_lba (ms_tmp.ent.addr.msf.minute,
-					    ms_tmp.ent.addr.msf.second,
-					    ms_tmp.ent.addr.msf.frame);
-
-	toc->xa_flag = (ms_tmp.hdr.first_track != ms_tmp.hdr.last_track);
 
 	/* Now try to get the total cdrom capacity. */
 	stat = cdrom_get_last_written(cdi, &last_written);
