Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSKRL6k>; Mon, 18 Nov 2002 06:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSKRL6k>; Mon, 18 Nov 2002 06:58:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63623 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262324AbSKRL6j>;
	Mon, 18 Nov 2002 06:58:39 -0500
Date: Mon, 18 Nov 2002 13:05:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Steve Lord <lord@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SCSI I/O performance problems when CONFIG_HIGHIO is off
Message-ID: <20021118120531.GC839@suse.de>
References: <1037392310.13531.419.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037392310.13531.419.camel@jen.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15 2002, Steve Lord wrote:
> Jens,
> 
> As you know, for the last week or so I have been battling some
> performance issues in XFS and 2.4.20-rc1. Well, we finally found
> the culprit back in 2.4.20-pre2.
> 
> When the block highmem patch was included, it added highmem_io to the
> scsi controller structure. This can only ever be set to one if
> CONFIG_HIGHIO is set. Yet there are several spots in the scsi
> code which test based on its value regardless.
> 
>         /*
>          * we really want to use sg even for a single segment request,
>          * however some people just cannot be bothered to write decent
>          * driver code so we can't risk to break somebody making the
>          * assumption that sg requests will always contain at least 2
>          * segments. if the driver is 32-bit dma safe, then use sg for
>          * 1 entry anyways. if not, don't rely on the driver handling this
>          * case.
>          */
>         if (count == 1 && !SCpnt->host->highmem_io) {
>                 this_count = req->current_nr_sectors;
>                 goto single_segment;
>         }

Steve,

Something isn't quite making sense. If we go over every single instance
of checking ->highmem_io, they all look sane (ie checking on non-highmem
setup must yield 0). So that part looks good.

However, I think a typo snuck in there, in exactly the spot you pasted
above. Could you try 2.4.20-rc2 with this patch applied?

===== drivers/scsi/scsi_merge.c 1.9 vs edited =====
--- 1.9/drivers/scsi/scsi_merge.c	Mon Sep 16 09:25:10 2002
+++ edited/drivers/scsi/scsi_merge.c	Mon Nov 18 13:04:41 2002
@@ -835,7 +835,7 @@
 	 * case.
  	 */
 	if (count == 1 && !SCpnt->host->highmem_io) {
-		this_count = req->current_nr_sectors;
+		this_count = req->nr_sectors;
 		goto single_segment;
 	}
 

-- 
Jens Axboe

