Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVJaIXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVJaIXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 03:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVJaIXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 03:23:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3105 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750952AbVJaIXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 03:23:04 -0500
Date: Mon, 31 Oct 2005 09:23:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@mandriva.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][noop-iosched] don't reuse a freed request
Message-ID: <20051031082354.GO19267@suse.de>
References: <20051031023024.GC5632@mandriva.com> <20051031074022.GN19267@suse.de> <4365D01D.2040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4365D01D.2040406@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31 2005, Tejun Heo wrote:
> Hi, guys.
> 
> Jens Axboe wrote:
> >On Mon, Oct 31 2005, Arnaldo Carvalho de Melo wrote:
> >
> >>Hi,
> >>
> >>	I'm getting the oops below when trying to use qemu with a kernel
> >>built with just the noop iosched, I'm never had looked at this code 
> >>before,
> >>so I did a quick hack that seems enough for my case.
> >>
> >>	Ah, this is with a fairly recent git tree (today), haven't checked
> >>if it is present in 2.6.14.
> >>
> >>Best Regards,
> >>
> >>- Arnaldo
> >>
> >>Unable to handle kernel paging request at virtual address c5f20f60
> >>printing eip:
> >>c01b0ecd
> >>*pde = 00017067
> >>*pte = 05f20000
> >>Oops: 0000 [#1]
> >>DEBUG_PAGEALLOC
> >>Modules linked in:
> >>CPU:    0
> >>EIP:    0060:[<c01b0ecd>]    Not tainted VLI
> >>EFLAGS: 00000046   (2.6.14acme)
> >>EIP is at elv_rq_merge_ok+0x15/0x7b
> >>eax: 00000014   ebx: c5f20f58   ecx: 000003f8   edx: 00000046
> >>esi: c12a5a90   edi: c5f20f58   ebp: c11658d0   esp: c11658c4
> >>ds: 007b   es: 007b   ss: 0068
> >>Process swapper (pid: 1, threadinfo=c1165000 task=c1164af0)
> >>Stack: c0251883 c5ecfe4c c5d688c0 c1165904 c01b0f48 c5f20f58 c12a5a90 
> >>00000000
> >>      c5874000 c018c5e1 c5f15f24 0000002b 00000000 c5ecfe4c c5d688c0 
> >>      c12a5a90
> >>      c1165920 c01b128d c5f20f58 c12a5a90 000a568a 00000000 00000002 
> >>      c1165960
> >>Call Trace:
> >>[<c0102a63>] show_stack+0x78/0x83
> >>[<c0102b88>] show_registers+0x100/0x167
> >>[<c0102d35>] die+0xcb/0x140
> >>[<c0234308>] do_page_fault+0x393/0x53a
> >>[<c0102777>] error_code+0x4f/0x54
> >>[<c01b0f48>] elv_try_merge+0x15/0x84
> >>[<c01b128d>] elv_merge+0x1d/0x4f
> >>[<c01b41d9>] __make_request+0xb2/0x425
> >>[<c01b46f9>] generic_make_request+0x125/0x137
> >
> >
> >Hrmpf, this looks really bad. Tejun, clearly there are still paths where
> >->last_rq isn't being cleared.
> >
> 
> I'm currently debugging this.  The problem is that we are using generic 
> dispatch queue directly in the noop and merging is NOT allowed on 
> dispatch queues but generic handling of last_merge tries to merge 
> requests.  I'm still trying to verify this, so I'll be back with results 
> soon.
> 
> >
> >>--- a/drivers/block/ll_rw_blk.c
> >>+++ b/drivers/block/ll_rw_blk.c
> >>@@ -1787,6 +1787,9 @@ static inline void blk_free_request(requ
> >>	if (rq->flags & REQ_ELVPRIV)
> >>		elv_put_request(q, rq);
> >>	mempool_free(rq, q->rq.rq_pool);
> >>+
> >>+	if (rq == q->last_merge)
> >>+		q->last_merge = NULL;
> >>}
> >>
> >>static inline struct request *
> >
> >
> >It's most likely a bug getting this far in the first place, but does it
> >fix things for you? I'll get on this asap.
> >
> 
> If the bug is where I think it is, I think the proper thing to do is to 
> use separate list_head in noop instead of using generic dispatch queue 
> directly thus making noop consistent with other ioscheds.
> 
> I'm more worried about oops w/ cfq Arnaldo reported in this thread. 
> I'll track that down as soon as I'm done with this one.

So either we disable merging for noop by setting REQ_NOMERGE in
elevator_noop_add_request(), or we add a noop_list and do the
dispatching like in the other io schedulers. I'd prefer the latter,
merging is still beneficial for noop (and it has always done it).

For now, we should add the former.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/drivers/block/noop-iosched.c b/drivers/block/noop-iosched.c
--- a/drivers/block/noop-iosched.c
+++ b/drivers/block/noop-iosched.c
@@ -9,6 +9,7 @@
 
 static void elevator_noop_add_request(request_queue_t *q, struct request *rq)
 {
+	rq->flags |= REQ_NOMERGE;
 	elv_dispatch_add_tail(q, rq);
 }
 

-- 
Jens Axboe

