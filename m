Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUG0Twd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUG0Twd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUG0Twd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:52:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30377 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266517AbUG0Twa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:52:30 -0400
Date: Tue, 27 Jul 2004 21:52:25 +0200
From: Jens Axboe <axboe@suse.de>
To: tabris <tabris@tabris.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Repost] IDE error 2.6.7-rc3-mm2 and 2.6.8-rc1-mm1
Message-ID: <20040727195224.GA10654@suse.de>
References: <200407220659.22948.tabris@tabriel.tabris.net> <20040722153933.GJ3987@suse.de> <200407271407.10631.tabris@tabris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407271407.10631.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27 2004, tabris wrote:
> On Thursday 22 July 2004 11:39 am, Jens Axboe wrote:
> > On Thu, Jul 22 2004, Tabris wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> <snip log>
> > > 	This error did not occur in 2.6.6-rc3-mm2. Turning off ACPI made
> > > no difference, not that I expected one.
> > >
> > > 	It appears to be harmless but it's polluting my syslog.
> > >
> > > Appears related to
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=108946389700930
> > >
> > > 	None of my harddrives are over 60GiB (and hda is an 8GiB), so
> > > there's no reason i should be getting LBA48 Flush Cache.
> > >
> > > 	What should I do, what do you need from me to get to the bottom of
> > > this?
> >
> > Does this work?
> 	No, however it does seem to start it going in my syslog a bit earlier, 
> but that may be meaningless (normally I found it waited until after 
> qmail would start).

Try this.

--- /opt/kernel/linux-2.6.8-rc1-mm1/drivers/ide/ide-disk.c	2004-07-22 13:37:09.000000000 -0200
+++ linux-2.6.8-rc1-mm1/drivers/ide/ide-disk.c	2004-07-27 03:39:11.016545806 -0200
@@ -1248,7 +1248,8 @@
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 
-	if ((drive->id->cfs_enable_2 & 0x2400) == 0x2400)
+	if (ide_id_has_flush_cache_ext(drive->id) &&
+	    (drive->capacity64 >= (1UL << 28)))
 		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
 	else
 		rq->cmd[0] = WIN_FLUSH_CACHE;
@@ -1616,9 +1617,8 @@
 	 * properly. We can safely support FLUSH_CACHE on lba48, if capacity
 	 * doesn't exceed lba28
 	 */
-	barrier = 1;
+	barrier = ide_id_has_flush_cache(id);
 	if (drive->addressing == 1) {
-		barrier = ide_id_has_flush_cache(id);
 		if (capacity > (1ULL << 28) && !ide_id_has_flush_cache_ext(id))
 			barrier = 0;
 	}
--- /opt/kernel/linux-2.6.8-rc1-mm1/drivers/ide/ide-io.c	2004-07-22 13:37:09.000000000 -0200
+++ linux-2.6.8-rc1-mm1/drivers/ide/ide-io.c	2004-07-22 13:38:23.000000000 -0200
@@ -67,7 +67,8 @@
 	rq->buffer = buf;
 	rq->buffer[0] = WIN_FLUSH_CACHE;
 
-	if (ide_id_has_flush_cache_ext(drive->id))
+	if (ide_id_has_flush_cache_ext(drive->id) &&
+	    (drive->capacity64 >= (1UL << 28)))
 		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
 }
 

-- 
Jens Axboe

