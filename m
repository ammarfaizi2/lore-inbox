Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSIJTEk>; Tue, 10 Sep 2002 15:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318014AbSIJTEk>; Tue, 10 Sep 2002 15:04:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48830 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318013AbSIJTEj>;
	Tue, 10 Sep 2002 15:04:39 -0400
Date: Tue, 10 Sep 2002 21:09:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Knoblauch <martin.knoblauch@mscsoftware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops + Aiee when mounting CDROM via ide-scsi under 2.4.20-pre5-ac4
Message-ID: <20020910190906.GI21877@suse.de>
References: <200209102015.51536.martin.knoblauch@mscsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209102015.51536.martin.knoblauch@mscsoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10 2002, Martin Knoblauch wrote:
> Hi,
> 
>  I am getting a reproducable Oops+Aiee when trying to mount a ATAPI 
> CDROM via the ide-scsi interface under 2.4.20-pre5-ac4. Works OK 
> without ide-scsi.

Ok, the problem is that ide-scsi builds a request which eventually ends
up going through the ide code dma mapping. ide_build_sglist() does a
rq_data_dir() on the request, which BUG()'s if the command isn't an fs
read or write. This actually went undetected before, because the ide
code did:

	if (rq->cmd == READ)
		direction is dma from device
	else
		direction is to device

and rq->cmd is IDESCSI_PC_RQ in this case. So we always mapped for dma
to the device, even if that wasn't the case.

Hmm, maybe just adding a single direction bit to struct request is the
easy way out for 2.4. Or... I'll cook something up.

-- 
Jens Axboe

