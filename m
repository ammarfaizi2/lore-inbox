Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbULJXaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbULJXaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 18:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbULJXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 18:30:38 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:17378 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261868AbULJXa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 18:30:26 -0500
Date: Sat, 11 Dec 2004 00:30:40 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] ide-cd: Unable to read multisession DVDs
Message-ID: <20041210233040.GB13479@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
cdrom_read_toc (ide-cd.c) always reads the TOC using MSF format. If the
last session of the disk starts beyond block 1152000 (LBA) there's an
overflow in the MSF format and kernel complains:

Unable to identify CD-ROM format.

I reported this bug a while ago (see bug #1930 on bugzilla) and Andy
Polyakov tracked it down.

I tried fixing it by myself setting msf_flag (cdrom_read_tocentry) to 0
and removing the MSF to LBA conversions in cdrom_read_toc.
It works but I don't have a complete understanding of the code in
ide-cd...

This is the quick & dirty patch (against 2.6.9, apply with offset to
2.6.10-rc3):

--- linux-2.6/drivers/ide/ide-cd.c.orig	2004-12-10 23:06:18.000000000 +0100
+++ linux-2.6/drivers/ide/ide-cd.c	2004-12-11 00:15:40.000000000 +0100
@@ -2356,7 +2357,7 @@
 	/* Read the multisession information. */
 	if (toc->hdr.first_track != CDROM_LEADOUT) {
 		/* Read the multisession information. */
-		stat = cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
+		stat = cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,
 					   sizeof(ms_tmp), sense);
 		if (stat) return stat;
 	} else {
@@ -2371,9 +2372,11 @@
 		msf_from_bcd (&ms_tmp.ent.addr.msf);
 #endif  /* not STANDARD_ATAPI */
 
-	toc->last_session_lba = msf_to_lba (ms_tmp.ent.addr.msf.minute,
-					    ms_tmp.ent.addr.msf.second,
-					    ms_tmp.ent.addr.msf.frame);
+	toc->last_session_lba = be32_to_cpu(ms_tmp.ent.addr.lba);
+	printk("ide-cd: last_session_lba: %d\n", toc->last_session_lba);
+//	toc->last_session_lba = msf_to_lba (ms_tmp.ent.addr.msf.minute,
+//					    ms_tmp.ent.addr.msf.second,
+//					    ms_tmp.ent.addr.msf.frame);
 
 	toc->xa_flag = (ms_tmp.hdr.first_track != ms_tmp.hdr.last_track);
 

Need help for a proper fix ;-)

Luca
-- 
Home: http://kronoz.cjb.net
Windows NT: Designed for the Internet. The Internet: Designed for Unix.
