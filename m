Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267701AbUHENyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267701AbUHENyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267693AbUHENxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:53:03 -0400
Received: from colin2.muc.de ([193.149.48.15]:38148 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267694AbUHENvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:51:24 -0400
Date: 5 Aug 2004 15:51:12 +0200
Date: Thu, 5 Aug 2004 15:51:12 +0200
From: Andi Kleen <ak@muc.de>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: prasanna@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [1/3] kprobes-func-args-268-rc3.patch
Message-ID: <20040805135112.GA92798@muc.de>
References: <2pMJz-13N-9@gated-at.bofh.it> <m3acx9yh6t.fsf@averell.firstfloor.org> <20040805122431.GA4411@in.ibm.com> <20040805125423.GA63682@muc.de> <20040805133348.GA4471@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805133348.GA4471@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 07:03:48PM +0530, Suparna Bhattacharya wrote:
> On Thu, Aug 05, 2004 at 02:54:23PM +0200, Andi Kleen wrote:
> > On Thu, Aug 05, 2004 at 05:54:31PM +0530, Suparna Bhattacharya wrote:
> > > > I think you misunderstood Linus' suggestion.  The problem with
> > > > modifying arguments on the stack frame is always there because the C
> > > > ABI allows it. One suggested solution was to use a second function
> > > 
> > > I did realise that it is the ABI which allows this, but I thought
> > > that the only situation in which we know gcc to actually clobber
> > > arguments from the callee in practice is for tailcall optimization. 
> > 
> > It just breaks the most common workaround. 
> 
> Just curious, do you know if other cases/optimizations where the
> callee clobbers arguments on stack ?

gcc can do it all the time. tail call is just a special case.

It happens relatively rarely because often it caches the data
in registers. But when there is enough register pressure it can
be written back to the original argument slot.

If you pass a structure by value it happens more often
(at least in older gccs, 3.5 now loads this into registers too) 

On -O0 code I would also expect it to happen often.

> 
> > 
> > > I'm not sure if that can be guaranteed and yes saving bytes from
> > > stack would avoid the problem totally (hence the comment) and make
> > > it less tied to expected innards of the compiler. The only issue 
> > > with that is deciding the maximum number of arguments so it is 
> > > generic enough. 
> > 
> > 64bytes, aka 16 arguments seem far enough.
> 
> OK, is there is consensus on this ? 

I think there is a clear consensus that anybody who uses 16 arguments
in a kernel function already did something very wrong.

Passing structures by value may be reasonable, but not supporting
that for big structures is a reasonable restriction.

> We'd have to make the code check for stack boundary etc and probably 
> compare and copy back only if there has been a change.

Why? And what stack boundary?

The probe is not supposed to modify the arguments, isn't it, so I don't
see why you ever want to copy back.  

I would write the trampoline in assembly btw, doing such things in C is usually
very fragile.

> > > > >  
> > > 
> > > Even with CONFIG_REGPARM, if you have a large 
> > > number of arguments for example, is spill over into stack 
> > > a possibility ?
> > 
> > Yes. For more than three (Linux uses -mregparm=3) 
> > Also varargs arguments will be always on the stack I think.
> 
> Right, so making the copy dependent on !CONFIG_REGPARM wouldn't
> make sense would it ?

Yes, it wouldn't.

-Andi
