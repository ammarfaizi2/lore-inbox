Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVAHVA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVAHVA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 16:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVAHVA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 16:00:56 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:21479 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261490AbVAHVAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 16:00:45 -0500
Date: Sat, 8 Jan 2005 22:01:07 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] Fix MSF overflow in ide-cd with multisession DVDs
Message-ID: <20050108210107.GA10804@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
this a backport of my patch that went into 2.6.10.

---
cdrom_read_toc (ide-cd.c) always reads the TOC using MSF format. If the
last session of the disk starts beyond block 1152000 (LBA) there's an
overflow in the MSF format and kernel complains:

Unable to identify CD-ROM format.

So read the multi-session TOC in LBA format in order to avoid an
overflow in MSF format with multisession DVDs.

Signed-off-by: Luca Tettamanti <kronos@kronoz.cjb.net>

--- a/drivers/ide/ide-cd.c	2005-01-08 21:53:03.000000000 +0100
+++ b/drivers/ide/ide-cd.c	2005-01-08 21:53:08.000000000 +0100
@@ -2206,25 +2206,31 @@
 	/* Read the multisession information. */
 	if (toc->hdr.first_track != CDROM_LEADOUT) {
 		/* Read the multisession information. */
-		stat = cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
+		stat = cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,
 					   sizeof(ms_tmp), sense);
 		if (stat) return stat;
+	
+		toc->last_session_lba = be32_to_cpu(ms_tmp.ent.addr.lba);
 	} else {
-		ms_tmp.ent.addr.msf.minute = 0;
-		ms_tmp.ent.addr.msf.second = 2;
-		ms_tmp.ent.addr.msf.frame  = 0;
 		ms_tmp.hdr.first_track = ms_tmp.hdr.last_track = CDROM_LEADOUT;
+		toc->last_session_lba = msf_to_lba(0, 2, 0); /* 0m 2s 0f */
 	}
 
 #if ! STANDARD_ATAPI
-	if (CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd)
+	if (CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd) {
+		/* Re-read multisession information using MSF format */
+		stat = cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
+					   sizeof(ms_tmp), sense);
+		if (stat)
+			return stat;
+
 		msf_from_bcd (&ms_tmp.ent.addr.msf);
+		toc->last_session_lba = msf_to_lba(ms_tmp.ent.addr.msf.minute,
+					  	   ms_tmp.ent.addr.msf.second,
+						   ms_tmp.ent.addr.msf.frame);
+	}
 #endif  /* not STANDARD_ATAPI */
 
-	toc->last_session_lba = msf_to_lba (ms_tmp.ent.addr.msf.minute,
-					    ms_tmp.ent.addr.msf.second,
-					    ms_tmp.ent.addr.msf.frame);
-
 	toc->xa_flag = (ms_tmp.hdr.first_track != ms_tmp.hdr.last_track);
 
 	/* Now try to get the total cdrom capacity. */


Luca
-- 
Home: http://kronoz.cjb.net
Collect some stars to shine for you
And start today 'cause there's only a few
A sign of times my friend
