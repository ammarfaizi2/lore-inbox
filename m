Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263176AbVHFHeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbVHFHeu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263175AbVHFHci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:32:38 -0400
Received: from smtp.istop.com ([66.11.167.126]:8135 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262342AbVHFHay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:30:54 -0400
From: Daniel Phillips <phillips@istop.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] netpoll can lock up on low memory.
Date: Sat, 6 Aug 2005 17:30:51 +1000
User-Agent: KMail/1.7.2
Cc: Matt Mackall <mpm@selenic.com>, "David S. Miller" <davem@davemloft.net>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>
References: <p73ek987gjw.fsf@bragg.suse.de> <20050806015310.GA8074@waste.org> <1123295548.18332.126.camel@localhost.localdomain>
In-Reply-To: <1123295548.18332.126.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508061730.52536.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 August 2005 12:32, Steven Rostedt wrote:
> > > If you need to really get the data out, then the design should be
> > > changed.  Have some return value showing the failure, check for
> > > oops_in_progress or whatever, and try again after turning interrupts
> > > back on, and getting to a point where the system can free up memory
> > > (write to swap, etc).  Just a busy loop without ever getting a skb is
> > > just bad.
> >
> > Why, pray tell, do you think there will be a second chance after
> > re-enabling interrupts? How does this work when we're panicking or
> > oopsing where we most care? How does this work when the netpoll client
> > is the kernel debugger and the machine is completely stopped because
> > we're tracing it?
>
> What I meant was to check for an oops and maybe then don't break out.
> Otherwise let the system try to reclaim memory. Since this is locked
> when the alloc_skb called with GFP_ATOMIC and fails.

You might want to take a look at my stupid little __GFP_MEMALLOC hack in the 
network block IO deadlock thread on netdev.  It will let you use the memalloc 
reserve from atomic context.  As long as you can be sure your usage will be 
bounded and you will eventually give it back, this should be ok.

Regards,

Daniel
