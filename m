Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315824AbSEJHVc>; Fri, 10 May 2002 03:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315825AbSEJHVb>; Fri, 10 May 2002 03:21:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46789 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315824AbSEJHVa>;
	Fri, 10 May 2002 03:21:30 -0400
Date: Fri, 10 May 2002 09:21:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Lincoln Dale <ltd@cisco.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14IDE 56)
Message-ID: <20020510072114.GK9183@suse.de>
In-Reply-To: <3CDAC4EB.FC4FE5CF@zip.com.au> <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com> <3CDB7387.F309D519@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10 2002, Andrew Morton wrote:
> > given there's still lots of idle-time, i'll file up lockmeter on here and
> > see if theres any gremlins there.
> 
> lockmeter will go off the dial.  All those copies happen at
> interrupt time, inside the global io_request_lock.  It's horrid.

Depends. For IDE, that is so. For SCSI, actually no io_request_lock is
not held while doing the bounce copy. The write bounce copy never
happens with io_request_lock held for either, the copy-back on reads
only does if the caller holds io_request_lock while entering
end_that_request_first() (or its own replacement, __scsi_end_request()
for instance).

The read copy-back is nasty for most users regardless of io_request_lock
status, because it happens with interrupts disabled.

> Try it with the block-highmem patch:
>  http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1/00_block-highmem-all-18b-4.gz

That's good advise :-)

-- 
Jens Axboe

