Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288156AbSAMVJh>; Sun, 13 Jan 2002 16:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSAMVJ1>; Sun, 13 Jan 2002 16:09:27 -0500
Received: from colorfullife.com ([216.156.138.34]:6408 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S288156AbSAMVJW>;
	Sun, 13 Jan 2002 16:09:22 -0500
Message-ID: <3C41F772.543C2F85@colorfullife.com>
Date: Sun, 13 Jan 2002 22:09:06 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linuxdiskcert.org>
Subject: Re: BIO Usage Error or Conflicting Designs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> 
> Is this with the highmem debug stuff enabled? That's the only way I can
> see this BUG triggering, otherwise q->bounce_pfn _cannot_ be smaller
> than the max_pfn.
> 
Have you tested that?

Unless I misread arch/i386/kernel/setup.c, line 740 to 760, max_pfn is
the upper end of the highmem area, if highmem is configured.
For non-highmem setup, it's set to min(system_memory, 4 GB).
It was a local variable within setup_arch, and someone made it a global
variable.

I.e. max_pfn is 1 GB with Andre's setup.

His patch doesn't touch the bounce limit, the default limit from
blk_queue_make_request() is used: BLK_BOUNCE_HIGH, which is max_low_pfn.

max_low_pfn is 896 MB.

--> BUG in create_bounce(), because a request comes in with a bounce
limit less than the total system memory, and no highmem configured.

--
	Manfred
