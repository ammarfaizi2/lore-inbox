Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUJCCBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUJCCBp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 22:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUJCCBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 22:01:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20396 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267668AbUJCCBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 22:01:41 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Joel White <cv223@comcast.net>
In-Reply-To: <20040928000516.GA3096@elte.hu>
References: <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
	 <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu>  <20040928000516.GA3096@elte.hu>
Content-Type: text/plain
Message-Id: <1096768900.1375.26.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 02 Oct 2004 22:01:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 20:05, Ingo Molnar wrote:
> i've released the -S7 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
> 

I believe we have found a bug.  A user reported massive xruns with S7,
they turned out to be printk() overhead from tons of "using
smp_processor_id() in preemptible code" errors.  The trace below repeats
over and over.  Looks like raid0 is the problem.

using smp_processor_id() in preemptible code: kjournald/685
 [<c011892a>] smp_processor_id+0x8a/0xa0
 [<c0273f67>] raid0_make_request+0x37/0x240
 [<c02e1bde>] cond_resched+0xe/0x80
 [<c0111608>] mcount+0x14/0x18
 [<c020f4a7>] generic_make_request+0x117/0x1a0
 [<c01621e6>] submit_bh+0xe6/0x150
 [<c020f544>] submit_bio+0x14/0x120
 [<c0111608>] mcount+0x14/0x18
 [<c020f5a2>] submit_bio+0x72/0x120
 [<c0133050>] autoremove_wake_function+0x0/0x60
 [<c0111608>] mcount+0x14/0x18
 [<c0162a6a>] bio_alloc+0xea/0x1d0
 [<c01621e6>] submit_bh+0xe6/0x150
 [<c01b022b>] journal_commit_transaction+0x102b/0x1680
 [<c02e27b3>] _spin_unlock+0x13/0x40
 [<c0136914>] _metered_spin_unlock+0x14/0xa0
 [<c0117c51>] find_busiest_group+0xf1/0x310
 [<c01de306>] find_next_bit+0x16/0xa0
 [<c011815e>] load_balance_newidle+0x8e/0xc0
 [<c01178ee>] move_tasks+0xe/0x280
 [<c02e27b3>] _spin_unlock+0x13/0x40
 [<c0136914>] _metered_spin_unlock+0x14/0xa0
 [<c0135059>] sub_preempt_count+0x69/0x80
 [<c0135059>] sub_preempt_count+0x69/0x80
 [<c01263bf>] del_timer_sync+0xaf/0x160
 [<c01de306>] find_next_bit+0x16/0xa0
 [<c0111608>] mcount+0x14/0x18
 [<c01de306>] find_next_bit+0x16/0xa0
 [<c01263bf>] del_timer_sync+0xaf/0x160
 [<c0111608>] mcount+0x14/0x18
 [<c02e27bf>] _spin_unlock+0x1f/0x40
 [<c01b31f3>] kjournald+0xf3/0x270
 [<c0133050>] autoremove_wake_function+0x0/0x60
 [<c02e2b20>] _spin_unlock_irq+0x20/0x40
 [<c0133050>] autoremove_wake_function+0x0/0x60
 [<c0117223>] schedule_tail+0x23/0x70
 [<c01b30d0>] commit_timeout+0x0/0x20
 [<c01b3100>] kjournald+0x0/0x270
 [<c0102779>] kernel_thread_helper+0x5/0xc
printk: 4203 messages suppressed.
using smp_processor_id() in preemptible code: kjournald/685
 [<c011892a>] smp_processor_id+0x8a/0xa0
 [<c0273f67>] raid0_make_request+0x37/0x240

etc.

I have the .config if you need more info.  All PREEMPT_ options are
enabled.

Joel, you reported the same xruns with SCSI and IDE.  Are you running
raid0 in both cases?  Also what is your hardware configuration?  Is this
regular SMP, or HT?

Lee

