Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUIPHKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUIPHKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIPHKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:10:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:13980 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267538AbUIPHJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:09:03 -0400
Date: Thu, 16 Sep 2004 09:09:02 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@fsmlabs.com>, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916070902.GF12915@wotan.suse.de>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu> <20040916064428.GD12915@wotan.suse.de> <20040916065101.GA11726@elte.hu> <20040916065342.GE12915@wotan.suse.de> <20040916065805.GA12244@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916065805.GA12244@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 08:58:05AM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > > the alternative would be to unwind the stack - quite some task on some 
> > > platforms ...
> > 
> > Sometimes call graph profiling would be very useful, but I wouldn't
> > want the profiler to do it by default, especially not for this silly
> > simple case. dwarf2 unwinding is complex enough that just requiring
> > frame pointers for the CG case would look attractive.
> 
> but ... frame pointers are overhead to all of the kernel. (the overhead

Yes, it may be up to a few percent in extreme cases because it 
adds a stall on rsp on K8.  On the other hand the code
may get slightly smaller, because a rbp reference is one byte
shorter than a rsp reference.

> is less pronounced on architectures with more registers, but even with
> 15 registers, 14 or 15 can still be a difference.) While unwinding is
> overhead to profiling only - if enabled. Also, there could be other
> functionality (exception handling?) that could benefit from dwarf2
> unwinding.

Your oopses could get better backtraces, but that could be done
with frame pointers too (I'm surprised nobody did it already btw...) 

You can try to write a dwarf2 unwinder for the kernel  (actually
I think IA64 already has one, but it's quite complex as expected
and doesn't easily map to anything else). Even with that doing
a dwarf2 unwind interpretation will have much more overhead.  
For me it doesn't look unreasonable to recompile the kernel for
special profiles though. 

-Andi
