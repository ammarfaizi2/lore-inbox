Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTKGXhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTKGWRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:17:35 -0500
Received: from ns.suse.de ([195.135.220.2]:23018 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263958AbTKGJK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:10:26 -0500
Date: Fri, 7 Nov 2003 10:09:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual content is read (only directory structure)
Message-ID: <20031107090924.GB616@suse.de>
References: <20031105084002.GX1477@suse.de> <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org> <20031107082439.GB504@suse.de> <1068195038.21576.1.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1068195038.21576.1.camel@ulysse.olympe.o2t>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07 2003, Nicolas Mailhot wrote:
> Le ven 07/11/2003 à 09:24, Jens Axboe a écrit :
> > On Wed, Nov 05 2003, Alan Stern wrote:
> 
> > > In any case, it quite likely _does_ point to a driver bug.  But since
> > > sddr09_read_data() was handed this sg entry and didn't change it, if there
> > > is such a bug it must lie in a higher-level driver.  Maybe the scsi layer, 
> > > maybe the block layer, maybe the memory-management system, maybe the file 
> > > system.  That was my original point.
> > 
> > Well, the sg entry looks perfectly valid. And that was my original
> > point :-). And that is why I said it looks like a driver bug, not in
> > upper layers. How much memory did the system that crashed have? If the
> > system has highmem, try testing with scsi_calculate_bounce_limit()
> > unconditionally returning BLK_BOUNCE_HIGH.
> 
> The system has 1 GiB of memory, ie just enough to make stuff like
> radeonfb fail

Try with this debug patch then, does it work now?

===== drivers/scsi/scsi_lib.c 1.77 vs edited =====
--- 1.77/drivers/scsi/scsi_lib.c	Tue Oct 14 09:28:06 2003
+++ edited/drivers/scsi/scsi_lib.c	Fri Nov  7 10:08:52 2003
@@ -1215,6 +1215,7 @@
 
 u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
 {
+#if 0
 	struct device *host_dev;
 
 	if (shost->unchecked_isa_dma)
@@ -1229,6 +1230,9 @@
 	 * hardware have no practical limit.
 	 */
 	return BLK_BOUNCE_ANY;
+#else
+	return BLK_BOUNCE_HIGH;
+#endif
 }
 
 struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)

-- 
Jens Axboe

