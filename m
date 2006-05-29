Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWE2Wkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWE2Wkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWE2Wkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:40:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53692 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751446AbWE2Wkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:40:51 -0400
Date: Tue, 30 May 2006 00:41:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060529224107.GA6037@elte.hu>
References: <20060529212109.GA2058@elte.hu> <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
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

> On 29/05/06, Ingo Molnar <mingo@elte.hu> wrote:
> >We are pleased to announce the first release of the "lock dependency
> >correctness validator" kernel debugging feature, which can be downloaded
> >from:
> >
> >  http://redhat.com/~mingo/lockdep-patches/
> >
> [snip]
> 
> I get this while loading cpufreq modules
> 
> =====================================================
> [ BUG: possible circular locking deadlock detected! ]
> -----------------------------------------------------
> modprobe/1942 is trying to acquire lock:
> (&anon_vma->lock){--..}, at: [<c10609cf>] anon_vma_link+0x1d/0xc9
> 
> but task is already holding lock:
> (&mm->mmap_sem/1){--..}, at: [<c101e5a0>] copy_process+0xbc6/0x1519
> 
> which lock already depends on the new lock,
> which could lead to circular deadlocks!

hm, this one could perhaps be a real bug. Dave: lockdep complains about 
having observed:

	anon_vma->lock  =>   mm->mmap_sem
	mm->mmap_sem    =>   anon_vma->lock

locking sequences, in the cpufreq code. Is there some special runtime 
behavior that still makes this safe, or is it a real bug?

> stack backtrace:
> <c1003f36> show_trace+0xd/0xf  <c1004449> dump_stack+0x17/0x19
> <c103863e> print_circular_bug_tail+0x59/0x64  <c1038e91>
> __lockdep_acquire+0x848/0xa39
> <c10394be> lockdep_acquire+0x69/0x82  <c11ed759>
> __mutex_lock_slowpath+0xd0/0x347

there's one small detail to improve future lockdep printouts: please set 
CONFIG_STACK_BACKTRACE_COLS=1, so that the backtrace is more readable. 
(i'll change the code to force that when CONFIG_LOCKDEP is enabled)

> BTW I still must revert lockdep-serial.patch - it doesn't compile on 
> my gcc 4.1.1

ok, will check this.

	Ingo
