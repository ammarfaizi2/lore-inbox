Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUCWMqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbUCWMqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:46:13 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27083
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262527AbUCWMp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:45:59 -0500
Date: Tue, 23 Mar 2004 13:46:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: tiwai@suse.de, Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040323124651.GK22639@dualathlon.random>
References: <20040323101755.GC3676@in.ibm.com> <20040323122925.GH22639@dualathlon.random> <20040323123426.GG3676@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323123426.GG3676@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 06:04:26PM +0530, Dipankar Sarma wrote:
> I have a patch for that too which I have been testing for DoS in
> route cache, not latency. It is worth testing it here, however 
> I think re-arming tasklets is not as friendly to latency as
> executing the rcu callbacks from process context. One thing
> I have noticed is that more softirqs worsen latency irrespective
> of the worst-case softirq length.

if we keep getting new interrupts in a flood, we'll also execute those
callbacks in a flood, that's why the number of callbacks executed must
be very small for every tasklet, the cost of the tasklet should be small
compared to the whole cost of the irq taking to hardware too, so I don't
see much problems with softirqs, if you don't get a flood of hw-irqs,
the callback load will be offloaded to ksoftirqd etc... softirqs are
also guaranteed to make progress despite not running  RT.  That's the
best for you.  eventd must run RT. And if you don't make your userspace
krcud RT you can run a box out of memory with a RT application, while if
you make it RT you'll again generate the latencies making krcud useless.

this is btw, why I implemented rcu_poll using softirqs, problem is that
softirqs are so low latency that we couldn't coalesce many callbacks
together to maximze icache and so we've to reach less quiescient points
per second to do the same work etc... so we delay it at the next irq,
that's fine, but if there's too much work to do, going back to the
softirq model like in rcu_poll sounds the natural way to go.
