Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUCaWxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUCaWxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:53:12 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46756
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262650AbUCaWxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:53:04 -0500
Date: Thu, 1 Apr 2004 00:52:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040331225259.GT2143@dualathlon.random>
References: <20040329222926.GF3808@dualathlon.random> <200403302005.AAA00466@yakov.inr.ac.ru> <20040330211450.GI3808@dualathlon.random> <20040330133000.098761e2.davem@redhat.com> <20040330213742.GL3808@dualathlon.random> <20040331171023.GA4543@in.ibm.com> <16491.4593.718724.277551@robur.slu.se> <20040331203750.GB4543@in.ibm.com> <20040331212817.GQ2143@dualathlon.random> <16491.18384.536778.338660@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16491.18384.536778.338660@robur.slu.se>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 12:36:00AM +0200, Robert Olsson wrote:
> 
> Andrea Arcangeli writes:
> 
>  > Maybe the problem is simply that NAPI should be tuned more aggressively,
>  > it may have to poll for a longer time before giving up.
> 
>  It cannot poll much more... 20 Million packets were injected in total
>  there were 250 RX irq's. Most from my ssh sessions. There are some TX 
>  interrupts... it's another story

I didn't focus much on the irq count, but now that I look at it, it
looks like the biggest source of softirq in irq context is the timer
irq, not the network irq. That explains the problem and why NAPI
couldn't avoid the softirq load in irq context, NAPI avoids the network
irqs, but the softirqs keeps running in irq context.

So lowering HZ to 100 should mitigate the problem significantly.

But I feel like we should change the softirq code so that the irqexit
runs only the softirq setup by the current (or nested) irq handler. This
way the timer irq will stop executing the softirqs posted by the network
stack and it may very well fix the problem completely. This definitely
will help fairness too.

>  Packet flooding is just our way to generate load and kernel locking must 
>  work with and without irq's. As far as I understand the real problem is 
>  when do_softirq is run from irqexit etc.

yes, but it's run from the _timer_ irq as far as I can tell.  Changing
the softirq code so that the irqexit only processes softirqs posted in
the irq handlers should fix it.

>  If we tag the different do_softirq sources (look in my testpatch) we can 
>  control the softirqs better. For example; do_softirq's from irqexit etc 
>  could be given low a "max_restart" this to move processing to ksoftird 
>  maybe even dynamic.

max_restart is needed exactly to avoid irqexit load to be offloaded to
regular kernel context, so that's basically saying that we should
disable max_restart but that's not a good solution for some non-NAPI
workload.
