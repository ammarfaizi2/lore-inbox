Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVCWP2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVCWP2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVCWP2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:28:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60068 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261648AbVCWP15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:27:57 -0500
Date: Wed, 23 Mar 2005 16:27:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 01/08] scsi: remove unused bounce-buffer release path
Message-ID: <20050323152750.GC16149@suse.de>
References: <20050323021335.960F95F8@htj.dyndns.org> <20050323021335.F07B64D9@htj.dyndns.org> <1111550846.5520.90.camel@mulgrave> <424107F9.5070807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424107F9.5070807@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23 2005, Tejun Heo wrote:
> 
>  Hello, James.
> 
> James Bottomley wrote:
> >On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> >
> >>01_scsi_remove_scsi_release_buffers.patch
> >>
> >>	Buffer bouncing hasn't been done inside the scsi midlayer for
> >>	quite sometime now, but bounce-buffer release paths are still
> >>	around.  This patch removes these unused paths.
> >
> >
> >Yes, but scsi_release_buffers isn't referring to bounce buffers anymore,
> >it's simply releasing the sg buffers.
> >
> 
>  That's what I did.  Replacing scsi_release_buffers() calls with calls 
> to scsi_free_sgtable().  The only logic removed is bounce-buffer 
> release/copy-back.
> 
> >[...]
> >
> >>-	else if (cmd->buffer != req->buffer) {
> >>-		if (rq_data_dir(req) == READ) {
> >>-			unsigned long flags;
> >>-			char *to = bio_kmap_irq(req->bio, &flags);
> >>-			memcpy(to, cmd->buffer, cmd->bufflen);
> >>-			bio_kunmap_irq(to, &flags);
> >>-		}
> >>-		kfree(cmd->buffer);
> >>-	}
> >
> >
> >I'll defer to Jens here, but I don't thing you can just remove this ...
> >sg_io with a misaligned buffer will fail without this.
> 
>  AFAIK, those are done by blk_rq_map_user() and blk_rq_unmap_user(), 
> both of which are invoked directly by sg_io().
> 
> >That rather nasty code freeing cmd->buffer needs to be in there as
> >well ... so it does make sense to keep this API
> 
>  That code is invoked only for REQ_BLOCK_PC requests without bio, and I 
> digged pretty hard but, in those cases, AFAICT, the callers are 
> responsible for supplying dma-able buffers and nothing seems to alter 
> cmd->buffer after the cmd gets initialized, but I might be missing 
> things here.  If so, please point out.

That did not use to be true - eg request coming from the CDROM layer to
sr had to be bounced in the scsi layer for isa host adapters. I bet that
is still true.

-- 
Jens Axboe

