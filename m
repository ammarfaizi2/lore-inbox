Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUIJTCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUIJTCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIJTCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:02:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:11394 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267554AbUIJTCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:02:36 -0400
Date: Fri, 10 Sep 2004 14:01:53 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, paulmck@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
Message-ID: <20040910190153.GA32062@sgi.com>
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408192016.10064.jbarnes@engr.sgi.com> <20040820155717.GF1243@us.ibm.com> <200408201324.32464.jbarnes@engr.sgi.com> <41265CCE.3070808@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41265CCE.3070808@colorfullife.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 10:19:26PM +0200, Manfred Spraul wrote:
| Jesse Barnes wrote:
| 
| >Looks like a bit more context has changed.  Manfred, care to respin 
| >against -mm3 so I can test?
| >
| > 
| >
| The patches are attached. Just boot-tested on a single-cpu system.
| 
| Three  changes:
| - I've placed the per-group structure into rcu_state. That's simpler but 
| wrong: the state should be allocated from node-local memory, not a big 
| global array.
| - I found a bug/race in the cpu_offline path: When the last cpu of a 
| group goes offline then the group must be forced into quiescent state. 
| The "&& (!forced)" was missing.
| - I've removed the spin_unlock_wait(). It was intended to synchronize 
| cpu_online_mask changes with the calculation of ->outstanding. Paul 
| convinced me that this is not necessary.

Manfred,

I just tried these patches against 2.6.9-rc1-mm3, on a 2p box, and I'm
getting intermittent hangs, either during bootup or shortly after reaching
multi-user.  In all cases, one of the processes is stuck on rcu_bh_state:

[0]kdb> bt
Stack traceback for pid 0
0xa000000100970000        0        0  1    0   I  0xa000000100970430
*swapper
0xa0000001000090b0 ia64_spinlock_contention_pre3_4+0x30
        args (0xa0000001009f7000, 0xa0000001001017e0, 0x288)
        r31 (spinlock address) 0xa0000001009f7000 rcu_bh_state
0xa00000010010e100 _metered_spin_lock+0x40
0xa0000001001017e0 __rcu_process_callbacks+0x260
        args (0xa0000001009eef00, 0xa0000001009f7000, 0xe000003004a07f70, 0xa0000001000debe0, 0x50d)
0xa0000001000debe0 tasklet_action+0x1c0
        args (0xe000003004a07fe8, 0x0, 0xffffffffffff5e10, 0xffffffffffff0020, 0xffffffffffff0028)
0xa0000001000de290 __do_softirq+0x250
        args (0xa000000100977bc0, 0x0, 0x1, 0xa000000100d8e2d0, 0x20000001)
0xa0000001000de360 do_softirq+0x80
        args (0xef, 0xa000000100977bc0, 0xa000000100d8e2d0, 0xa00000010098b780, 0xa0000001009b5958)
0xa000000100019030 ia64_handle_irq+0x190
        args (0xf, 0xa000000100977bc0, 0x0, 0x0, 0xfd) 0xa000000100012300 ia64_leave_kernel
        args (0xf, 0xa000000100977bc0)
0xa000000100019840 ia64_save_scratch_fpregs+0x20
        args (0xa000000100977dd0)
0xa00000010001ad20 default_idle+0xc0
        args (0x1, 0xa000000100ba5fe4, 0xa000000100977db0, 0xa000000100977e28, 0xa000000100977e20)
0xa00000010001afe0 cpu_idle+0x1e0
        args (0xa000000100d8e2d0, 0xa0000001009024e0, 0xa0000001009024e8, 0xa0000001009059b0, 0xa0000001009059b8)
0xa0000001000095c0 rest_init+0xa0
        args (0xa0000001009190b0, 0x590)
0xa0000001009190b0 start_kernel+0x510
        args (0x307bd8ac08, 0xd13, 0x3004a3e240, 0x300485da80, 0x307bd31b30)
0xa000000100008590 _start+0x270
        args (0x307bd8ac08, 0x307bd5b398, 0x3004a3e270, 0x307bd1f008, 0x30045b2e60)

If I'm reading this right, this corresponds to (kernel/rcupdate.c):

    507                 if (!next_pending) {
    508                         /* and start it/schedule start if it's a new batch */
    509                         spin_lock(&rsp->lock);   <---- here
    510                         rcu_start_batch(rcp, rsp, 1);
    511                         spin_unlock(&rsp->lock);
    512                 }


Whenever this happens, there is another thread waiting to sync buffers
(sometimes with several backed up behind him).  It was kjournald in this
case.  Have you seen this ever with these patches?

Regards,
Greg Edwards
