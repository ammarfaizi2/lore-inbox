Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbULQINm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbULQINm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 03:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbULQINm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 03:13:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:26573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262768AbULQINi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 03:13:38 -0500
Date: Fri, 17 Dec 2004 00:13:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rashkae <rashkae@tigershaunt.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: Cannot mount multi-session DVD with ide-cd, must use ide-scsi
Message-Id: <20041217001315.1b31cf2d.akpm@osdl.org>
In-Reply-To: <20041217012014.GA5374@tigershaunt.com>
References: <20041217012014.GA5374@tigershaunt.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rashkae <rashkae@tigershaunt.com> wrote:
>
> I can confirm that Linux Kerenl 2.6.9 still cannot mount a
>  multi-session DVD if the last session starts at > 2.2 GB.  The
>  only information on this problem I can find is here:
> 
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=108827602322464&w=2
> 
>  Is there a patch anywhere to address this?

Please test this.  Jens, could you please check this one?



From: Kronos <kronos@kronoz.cjb.net>

cdrom_read_toc (ide-cd.c) always reads the TOC using MSF format.  If the
last session of the disk starts beyond block 1152000 (LBA) there's an
overflow in the MSF format and kernel complains:

Unable to identify CD-ROM format.

I reported this bug a while ago (see bug #1930 on bugzilla) and Andy
Polyakov tracked it down.

I tried fixing it by myself setting msf_flag (cdrom_read_tocentry) to 0 and
removing the MSF to LBA conversions in cdrom_read_toc.  It works but I
don't have a complete understanding of the code in ide-cd...

This is the quick & dirty patch (against 2.6.9, apply with offset to
2.6.10-rc3):

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/ide/ide-cd.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -puN drivers/ide/ide-cd.c~ide-cd-unable-to-read-multisession-dvds drivers/ide/ide-cd.c
--- 25/drivers/ide/ide-cd.c~ide-cd-unable-to-read-multisession-dvds	2004-12-11 22:14:16.629388296 -0800
+++ 25-akpm/drivers/ide/ide-cd.c	2004-12-11 22:14:16.635387384 -0800
@@ -2353,7 +2353,7 @@ static int cdrom_read_toc(ide_drive_t *d
 	/* Read the multisession information. */
 	if (toc->hdr.first_track != CDROM_LEADOUT) {
 		/* Read the multisession information. */
-		stat = cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
+		stat = cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,
 					   sizeof(ms_tmp), sense);
 		if (stat) return stat;
 	} else {
@@ -2368,9 +2368,11 @@ static int cdrom_read_toc(ide_drive_t *d
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
 
_

