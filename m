Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUE1Wy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUE1Wy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUE1Wyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:54:55 -0400
Received: from colin2.muc.de ([193.149.48.15]:3603 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263979AbUE1Wya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:54:30 -0400
Date: 29 May 2004 00:54:26 +0200
Date: Sat, 29 May 2004 00:54:26 +0200
From: Andi Kleen <ak@muc.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andi Kleen <ak@muc.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <20040528225426.GA89095@colin2.muc.de>
References: <7F740D512C7C1046AB53446D372001730182BC35@scsmsx402.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001730182BC35@scsmsx402.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 03:05:48PM -0700, Nakajima, Jun wrote:
> >At least the AMD chipsets found in most Opteron boxes need software
> >balancing too.
> 
> Actually lowest priority delivery works on P4 and AMD (I did not tested
> it on AMD, though), if we _update_ TPR. But I don't recommend that,

True. I remember there was even a patch for that from James C. long ago.
I considered at one point to add it to x86-64, but ended up 
not doing anything and just recommending irqbalanced.

[I didn't test it neither, so no guarantee TPR really works on AMD]

> instead we should implement the similar or optimized behavior in
> software because "soft TPR" can be more efficient and scalable. And I
> think this is something in my mind, and I think the kernel should do it.

I'm not convinced of that. At least the current i386 implemention
is basically a kernel thread that wakes up regularly, reads some
statistics and then updates the APIC.

There is not much reason this cannot be done in user space, and
user space has the advantage that more advanced heuristics (which
I'm sure will be there) can be more easily implemented.

And handling all interrupts at CPU #0 during early boot up is 
not really an issue.

An kernel implementation may make sense when you're doing something
really dynamic: e.g. not just a timer, but dynamically redirecting
network interrupts to the CPU the process who will read from the
socket runs on. Obviously it would need kernel support for that, since
user space could not keep up with such a high sampling rate. But that's
future research work (if it can be even done generically at all)
and I don't see it on the radar screen anytime soon. We first need to solve
the NUMA scheduling problem, which is already hard enough ;-) 

And for the simpler heuristics that don't need real time updates
user space is probably better.

-Andi

