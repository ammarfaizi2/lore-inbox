Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVCWGg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVCWGg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVCWGg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:36:57 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:55049 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262824AbVCWGgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:36:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Y3OoSbflvH+MfW5PxLO2HPdaiGK5OhxFaZX2eEXt4tAo7kaOz4GyEXLk5LU2DmjGUw00Fm/t5JhaAzGXf2d+egJAxAf1jMsPuvpSTMDI0DgGfzYE8GGm9v4zqi/FQqMTLi4G3R50WGZwySuZQ5dAYr4/zfHAXVq6nBuqAmwqiLI=
Message-ID: <424107F9.5070807@gmail.com>
Date: Wed, 23 Mar 2005 15:08:57 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 01/08] scsi: remove unused bounce-buffer
 release path
References: <20050323021335.960F95F8@htj.dyndns.org>	 <20050323021335.F07B64D9@htj.dyndns.org> <1111550846.5520.90.camel@mulgrave>
In-Reply-To: <1111550846.5520.90.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, James.

James Bottomley wrote:
> On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> 
>>01_scsi_remove_scsi_release_buffers.patch
>>
>>	Buffer bouncing hasn't been done inside the scsi midlayer for
>>	quite sometime now, but bounce-buffer release paths are still
>>	around.  This patch removes these unused paths.
> 
> 
> Yes, but scsi_release_buffers isn't referring to bounce buffers anymore,
> it's simply releasing the sg buffers.
> 

  That's what I did.  Replacing scsi_release_buffers() calls with calls 
to scsi_free_sgtable().  The only logic removed is bounce-buffer 
release/copy-back.

> [...]
> 
>>-	else if (cmd->buffer != req->buffer) {
>>-		if (rq_data_dir(req) == READ) {
>>-			unsigned long flags;
>>-			char *to = bio_kmap_irq(req->bio, &flags);
>>-			memcpy(to, cmd->buffer, cmd->bufflen);
>>-			bio_kunmap_irq(to, &flags);
>>-		}
>>-		kfree(cmd->buffer);
>>-	}
> 
> 
> I'll defer to Jens here, but I don't thing you can just remove this ...
> sg_io with a misaligned buffer will fail without this.

  AFAIK, those are done by blk_rq_map_user() and blk_rq_unmap_user(), 
both of which are invoked directly by sg_io().

> That rather nasty code freeing cmd->buffer needs to be in there as
> well ... so it does make sense to keep this API

  That code is invoked only for REQ_BLOCK_PC requests without bio, and I 
digged pretty hard but, in those cases, AFAICT, the callers are 
responsible for supplying dma-able buffers and nothing seems to alter 
cmd->buffer after the cmd gets initialized, but I might be missing 
things here.  If so, please point out.

  Thanks.

-- 
tejun

