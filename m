Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbTIOPcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbTIOPcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:32:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45221 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261263AbTIOPcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:32:53 -0400
Date: Mon, 15 Sep 2003 17:32:55 +0200
From: Jens Axboe <axboe@suse.de>
To: casino_e@terra.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
Message-ID: <20030915153255.GB3412@suse.de>
References: <d95d2d93f8.d93f8d95d2@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95d2d93f8.d93f8d95d2@teleline.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15 2003, CASINO_E wrote:
> Forgive me if I'm saying something stupid but, do you mean a special 
> case for this controller in ide-dma.c:ide_build_dmatable()?

No that's not stupid at all. In 2.4 that would be how you do it, in 2.6
I was referring to the possibility of letting the drive queues that hang
off that controller be naturally limited. So you would do something ala

	if (hwif->dma_boundary)
		blk_queue_segment_boundary(drive->queue, 0x1fff);

and then no segment would be >= 8192 (or cross it, naturally) by
default.

> In this case, should not segment size and boundary be included in hwif 
> so we can have a generic ide_build_dmatable() without dealing 
> explicitly with special cases? We could initialize to the default for 
> most controllers and set the values for the exceptions inside each 
> particular driver.

Of course. But that is implementation detail, I was just worried that
someone would clamp on a nasty work around like 15 sectors (which would
in reality be just a 4kb request, nasty!) when you could get nice 128kb
requests with just the right segment limiting instead.

But basically I don't understand why the work-around was _ever_ in
sectors, if that is the bug in the hardware dma engine. Two
explanations: it's not really that bug and NetBSD is wrong, or the
person who did the work-around didn't know a better solution existed
(don't laugh, I wouldn't be surprised if something like that came down
from a vendor :)

-- 
Jens Axboe

