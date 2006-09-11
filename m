Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWIKWkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWIKWkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWIKWkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:40:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:750 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932188AbWIKWkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:40:05 -0400
Subject: Re: What's in libata-dev.git
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       Jeff Garzik <jeff@garzik.org>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060911195106.GA6775@kernel.dk>
References: <20060911132250.GA5178@havoc.gtf.org>
	 <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org>
	 <450568F3.3020005@ru.mvista.com>
	 <1157986974.23085.147.camel@localhost.localdomain>
	 <45057651.8000404@garzik.org>
	 <1157988513.23085.159.camel@localhost.localdomain>
	 <20060911153706.GE4955@suse.de>
	 <Pine.LNX.4.64.0609110850380.27779@g5.osdl.org>
	 <20060911195106.GA6775@kernel.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 00:00:36 +0100
Message-Id: <1158015636.23085.218.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 21:51 +0200, ysgrifennodd Jens Axboe:
> Well, as I said, I don't think we ever saw a case that was demonstrably
> due to the 256 sector issue. And I really don't think it is as obscure a
> fact that people seem to think it is.

One of the ones I've got saved here is this thread. Paul goes on to
demonstrate that changing the 255<->256 limit makes 2.0/2.2/2.4 break or
not break.

--------

There is a potentially serious bug in ide-probe.c in which max_sectors
is set to 256 instead of 255. I am surprised that this hasn't bit anyone
else yet. Perhaps because you need a disk that is slow in comparison to 
the host in order for the queue to climb up to and then hit the 256, at
which point it then falls over. 


For example, with an old 700MB Maxtor on a "fast" 486, VL-bus, PIO, 
hdparm -c1 -m8 -u1, I could pretty much on demand generate the
following 
error by multiple builds, or by the final linking of any big project:


hdc: lost interrupt
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
<user space sees binary cruft in source files, etc etc...>


(Note that nothing in the status is really an error). With the
following 
patch, everything works as it should & no errors even under high load.
Patch is against 2.4.3pre2.


Paul.


--- drivers/ide/ide-probe.c~ Sat Mar 17 16:50:14 2001
+++ drivers/ide/ide-probe.c Sat Mar 17 16:58:33 2001
@@ -1,5 +1,5 @@
/*
- * linux/drivers/ide/ide-probe.c Version 1.06 June 9, 2000
+ * linux/drivers/ide/ide-probe.c Version 1.07 March 18, 2001
*
* Copyright (C) 1994-1998 Linus Torvalds & authors (see below)
*/
@@ -25,6 +25,8 @@
* allowed for secondary flash card to be detectable
* with new flag : drive->ata_flash : 1;
* Version 1.06 stream line request queue and prep for cascade project.
+ * Version 1.07 max_sect <= 255; slower disks would get behind and
+ * then fall over when they get to 256. Paul G.
*/

#undef REALLY_SLOW_IO /* most systems can safely undef this */
@@ -772,10 +774,10 @@
for (unit = 0; unit < minors; ++unit) {
*bs++ = BLOCK_SIZE;
#ifdef CONFIG_BLK_DEV_PDC4030
- *max_sect++ = ((hwif->chipset == ide_pdc4030) ? 127 : 256);
+ *max_sect++ = ((hwif->chipset == ide_pdc4030) ? 127 : 255);
#else
/* IDE can do up to 128K per request. */
- *max_sect++ = 256;
+ *max_sect++ = 255;
#endif
*max_ra++ = MAX_READAHEAD;
}


