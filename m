Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757826AbWKXVGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757826AbWKXVGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757827AbWKXVGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:06:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:52152 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1757826AbWKXVGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:06:42 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
Date: Fri, 24 Nov 2006 22:06:36 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>
References: <20061124170246.GA9956@elte.hu> <200611242137.39012.ak@suse.de> <20061124204636.GA12196@elte.hu>
In-Reply-To: <20061124204636.GA12196@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611242206.36681.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 November 2006 21:46, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > 
> > > yeah - the main new bit for x86-64 is the unconditional check for time 
> > > warps. We shouldnt (and cannot) really trust the CPU and the board/BIOS 
> > > getting it right. There were always some motherboards using Intel CPUs 
> > > that had the TSCs wrong.
> > 
> > In the 64bit capable generation I don't know of any run in spec 
> > (except for multinode systems and there was one overclocked system 
> > where the cores got unsync, but overclocking is an operator error)
> 
> i have one (Intel based), 64-bit, fully in spec, which is off by 
> ~3000-4000 cycles. So it happens.

More details?

> I was in fact surprised when i noticed that you removed the 
> unconditional TSC check that i put there years ago 

I removed it because you pointed out that it usually caused
trouble on Intel systems: we would always detect errors due to measurement errors
and then make things worse by trying to fix it.

But you're right it might have been better to keep 
a check with a threshold to catch totally broken cases.

> but which apps are using RDTSC natively? Trapping isnt too good i agree

The only sure way would be to trap+printk -- but from previous
user complaints it's a substantial number.

> - if then we should remove it from the CPU features and hence apps wont 
> (or shouldnt) use it.

I doubt the majority checks any cpu features first ...

> 
> > > nor can the TSC really be synced up properly in the hotplug CPU 
> > > case, after the fact - what if the app already read out an older TSC 
> > > value and a new CPU is added. If the TSC isnt sync on SMP then it 
> > > quickly gets pretty messy, and we should rather take a look at /why/ 
> > > these apps are using RDTSC.
> > 
> > Because gettimeofday is too slow.
> 
> as i indicated it in another discussion, i can fix that. Next patch will 
> be that.

Well I hope it's not making it HZ resolution. As noted earlier we tried
that already and it didn't work (it violates the "forward monotonity"
that is commonly expected) 

Ok I could imagine it making sense as a new CLOCK_FASTBUTLOUSYRESOLUTION timer in 
clock_gettime() [together with the new vdso fastpath], but not as default.

-Andi
