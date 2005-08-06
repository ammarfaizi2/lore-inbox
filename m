Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVHFL3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVHFL3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 07:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVHFL3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 07:29:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39852 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262114AbVHFL3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 07:29:22 -0400
Date: Sat, 6 Aug 2005 13:29:14 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Matt Mackall <mpm@selenic.com>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       John B?ckstrand <sandos@home.se>, davem@davemloft.net
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050806112913.GK8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org> <20050805212610.GA8266@wotan.suse.de> <20050806074503.GA5914@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050806074503.GA5914@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 09:45:03AM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > On Fri, Aug 05, 2005 at 01:01:57PM -0700, Matt Mackall wrote:
> > > The netpoll philosophy is to assume that its traffic is an absolute
> > > priority - it is better to potentially hang trying to deliver a panic
> > > message than to give up and crash silently.
> > 
> > That would be ok if netpoll was only used to deliver panics. But it is 
> > not. It delivers all messages, and you cannot hang the kernel during 
> > that. Actually even for panics it is wrong, because often it is more 
> > important to reboot in a panic than (with a panic timeout) to actually 
> > deliver the panic. That's needed e.g. in a failover cluster.
> 
> without going into the merits of this discussion, reliable failover 
> clusters must include (and do include) an external ability to cut power.  
> No amount of in-kernel logic will prevent the kernel from hanging, given 
> a bad enough kernel bug.

Ok, true, but we should do a best effort.

> 
> So the right question is not 'can we prevent the kernel from hanging, 
> ever' (we cannot), but 'which change makes it less likely for the kernel 
> to hang'. (and, obviously: assuming all other kernel components are 
> functioning per specification, netpoll itself most not hang :-)
> 
> even a plain printk to VGA can hang in certain kernel crashes. Netpoll 
> is more complex and thus has more exposure to hangs. E.g. netpoll relies 
> on the network driver to correctly recycle skbs within a bound amount of 
> time. If the network driver leaks skbs, it's game over for netpoll.

I don't think we even need to think about such rare cases,
until the easy cases ("everything hangs when the cable is pulled") 
are not fixed.

> [ i'd prefer a hang over nondeterministic behavior, and e.g. losing 
>   console messages is sure nondeterministic behavior. What if the 
>   console message is "WARNING: the box has just been broken into"? ]

That just makes netconsole useless in production. If it causes frequenet
hangs people will not use it.


> 
> we could do one thing (see the patch below): i think it would be useful 
> to fill up the netlogging skb queue straight at initialization time.  
> Especially if netpoll is used for dumping alone, the system might not be 
> in a situation to fill up the queue at the point of crash, so better be 
> a bit more prepared and keep the pipeline filled.

You're solving a completely different issue here?

-Andi

