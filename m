Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288599AbSAMKWy>; Sun, 13 Jan 2002 05:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288993AbSAMKWo>; Sun, 13 Jan 2002 05:22:44 -0500
Received: from colorfullife.com ([216.156.138.34]:21509 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S288599AbSAMKWd>;
	Sun, 13 Jan 2002 05:22:33 -0500
Message-ID: <3C415FE2.24CB084B@colorfullife.com>
Date: Sun, 13 Jan 2002 11:22:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Q: blk_queue_bounce_limit
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the selection of the ISA pool in blk_queue_bounce_limit is
wrong:
it switches to the ISA pool if the requested DMA address is equal to
16 MB. I think it must switch if the requested bounce limit is smaller
than max_low_pfn.

<<<<<<<
-	if (dma_addr == BLK_BOUNCE_ISA) {
+	if (bounce_pfn < blk_max_low_pfn) {
+		BUG_ON(dma_addr < BLK_BOUNCE_ISA);
                init_emergency_isa_pool();
                q->bounce_gfp = GFP_NOIO | GFP_DMA;
        } else
                q->bounce_gfp = GFP_NOHIGHIO;
<<<

Usually both lines are identical, except:
- If only 16 MB are installed, then bouncing to ISA is never needed.
- There could be broken devices that only support DMA to < 512 MB.
For such a device no bounce it needed if less than 512 MB is installed,
and if more is installed we must bounce to ISA. (since we don't have
a 512MB zone).
- Bouncing to less that 16 MB is not supported.

--
	Manfred
