Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbULQSd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbULQSd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbULQSd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:33:26 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:39656 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262095AbULQSc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:32:58 -0500
Date: Fri, 17 Dec 2004 19:33:03 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rashkae <rashkae@tigershaunt.com>
Subject: Re: Cannot mount multi-session DVD with ide-cd, must use ide-scsi
Message-ID: <20041217183303.GA9561@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217120854.GC3140@suse.de>
Referrences: <20041217012014.GA5374@tigershaunt.com> <20041217001315.1b31cf2d.akpm@osdl.org> <20041217120854.GC3140@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> ha scritto:
> On Fri, Dec 17 2004, Andrew Morton wrote:
>> Rashkae <rashkae@tigershaunt.com> wrote:
>> >
>> > I can confirm that Linux Kerenl 2.6.9 still cannot mount a
>> >  multi-session DVD if the last session starts at > 2.2 GB.  The
>> >  only information on this problem I can find is here:
>> > 
>> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=108827602322464&w=2
>> > 
>> >  Is there a patch anywhere to address this?
>> 
>> Please test this.  Jens, could you please check this one?
> 
> It looks fine for the case where the tocentry read suceeds, but you
> should change the fallback assignment to be lba based as well I think.

Ok, changed that part. I also changed the part inside the #if
!STANDARD_ATAPI to re-read using MSF, just to be sure to not break
anything. Maybe those two weird units (Vertos 300 and NEC 260) return
the LBA value in a sane way and the whole #if block can be removed? 

---
Read the multi-session TOC in LBA format in order to avoid an overflow
in MSF format when the last session starts beyond block 1152000 (LBA).

Signed-off-by: Luca Tettamanti <kronos@kronoz.cjb.net>

--- a/drivers/ide/ide-cd.c	2004-12-10 23:06:18.000000000 +0100
+++ b/drivers/ide/ide-cd.c	2004-12-17 19:30:56.000000000 +0100
@@ -2356,25 +2356,31 @@
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
The trouble with computers is that they do what you tell them, 
not what you want.
D. Cohen
