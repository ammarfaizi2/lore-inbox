Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261211AbTC0S7d>; Thu, 27 Mar 2003 13:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbTC0S7d>; Thu, 27 Mar 2003 13:59:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7173 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261211AbTC0S7a>; Thu, 27 Mar 2003 13:59:30 -0500
Date: Thu, 27 Mar 2003 11:08:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dan Eble <dane@aiinet.com>
cc: "David S. Miller" <davem@redhat.com>, <shmulik.hen@intel.com>,
       <bonding-devel@lists.sourceforge.net>,
       <bonding-announce@lists.sourceforge.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
       <mingo@redhat.com>, <kuznet@ms2.inr.ac.ru>
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
In-Reply-To: <Pine.LNX.4.33.0303271315010.30532-100000@dane-linux.aiinet.com>
Message-ID: <Pine.LNX.4.44.0303271104270.31459-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Mar 2003, Dan Eble wrote:
> 
> This makes checks like the following (in alloc_skb) asymmetric:
> 
>     if (in_interrupt() && (gfp_mask & __GFP_WAIT)) {
>         static int count = 0;
>         if (++count < 5) {
>             printk(KERN_ERR "alloc_skb called nonatomically "
>                    "from interrupt %p\n", NET_CALLER(size));
>             BUG();
> 
> In a driver I'm writing, this bug was hidden until I switched from using
> write_lock_irqsave() to write_lock_bh().  Shouldn't this bug also be
> announced if interrupts are disabled?

Yeah. It should also probably use "in_atomic()" instead of 
"in_interrupt()", since that also finds people who have marked themselves 
non-preemptible.

So what the test SHOULD look like is this:

	if (gfp_mask & __GFP_WAIT) {
		if (in_atomic() || irqs_disabled()) {
			static int count = 0;
			...
		}
	}

which should catch all the cases we really care about.

		Linus

