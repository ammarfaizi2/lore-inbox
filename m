Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWE3Tmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWE3Tmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWE3Tmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:42:42 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41642 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932439AbWE3Tml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:42:41 -0400
Date: Tue, 30 May 2006 21:42:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530194259.GB22742@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> SCSI or libata problem.

i think SCSI and libata is innocent here.

> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {in-hardirq-W} -> {hardirq-on-W} usage.

> 1 locks held by init/1:
> #0:  (&base->lock#2){++..}, at: [<c0129a24>] lock_timer_base+0x29/0x55
> 
> stack backtrace:
> [<c0103e52>] show_trace_log_lvl+0x4b/0xf4
> [<c01044b3>] show_trace+0xd/0x10
> [<c010457b>] dump_stack+0x19/0x1b
> [<c0137d63>] print_usage_bug+0x1a1/0x1ab
> [<c0138458>] mark_lock+0x2d7/0x514
> [<c01386dc>] mark_held_locks+0x47/0x65
> [<c0139745>] trace_hardirqs_on+0x12b/0x16f
> [<c02f2b61>] restore_nocheck+0x8/0xb

weird. We are holding base->lock#2 [CPU#1's timer base lock], _and_ we 
execute restore_nocheck - which is a return-to-userspace thing.

unfortunately the stacktrace provides no clues of how we got here. 
For such nasty cases i have a kernel tracing patch prepared, you can get 
it from:

  http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch

just apply it ontop of your current tree and accept all the new .config 
options as the kernel suggests them to you. Then rebuild and reboot into 
the kernel, and reproduce the lockdep bug. Once such a bug is reported, 
/proc/latency_trace should have a full kernel trace leading up to the 
bug. Please upload that trace to your site and send us the URL.

(the tracer runs nonstop and it saves the current trace if it encounters 
a lockdep bug. That way i can see the history of the bug.)

if possible it would be nice to boot with maxcpus=1 as well, to make 
sure we have all relevant kernel activity traced. (assuming that booting 
with maxcpus=1 does not make the bug go away)

	Ingo
