Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUIPHxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUIPHxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267828AbUIPHxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:53:42 -0400
Received: from cantor.suse.de ([195.135.220.2]:43456 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267709AbUIPHxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:53:40 -0400
Date: Thu, 16 Sep 2004 09:53:39 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@fsmlabs.com>, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916075339.GJ12915@wotan.suse.de>
References: <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu> <20040916064428.GD12915@wotan.suse.de> <20040916065101.GA11726@elte.hu> <20040916065342.GE12915@wotan.suse.de> <20040916065805.GA12244@elte.hu> <20040916070902.GF12915@wotan.suse.de> <20040916071931.GA12876@elte.hu> <20040916072959.GH12915@wotan.suse.de> <20040916074431.GA13713@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916074431.GA13713@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 09:44:31AM +0200, Ingo Molnar wrote:
> it only works on pointer less kernels because the spinlock profile 
> unwinding is _conditional_ on an FP kernel right now:
> 
>  #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
>  unsigned long profile_pc(struct pt_regs *regs)
>  {
>  ...
> 
> on non-FP kernels you'll see all the overhead in the single spin_lock()
> function, agreed?

Agreed.  Ok, should be easy to fix with the same scheme, except
that it has to use offset 0 instead of 1 for the !FP case.
I will cook up a patch.

BTW the SMP check is also wrong because preemptive kernels also
need this unwinding, although they should not spend too much
time in locking.

> > > in this respect - it might work if you can detect for sure at build time
> > > whether there's any local variable. Tricks like this really tend to
> > > haunt us later.
> > 
> > There are already lots of such assumptions in the kernel (e.g. WCHAN
> > and others).  I don't think adding one more is a big issue.
> 
> wchan has only one assumption: that that all __sched section functions

It's more than WCHAN, e.g. sysrq-t assumes it too. 

-Andi
