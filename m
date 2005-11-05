Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVKEQbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVKEQbj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbVKEQbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:31:38 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11318
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751255AbVKEQbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:31:38 -0500
Date: Sat, 5 Nov 2005 17:31:35 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: disable tsc with seccomp
Message-ID: <20051105163134.GC14064@opteron.random>
References: <20051105134727.GF18861@opteron.random> <200511051637.44432.ak@suse.de> <20051105160720.GB14064@opteron.random> <200511051712.09280.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511051712.09280.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 05:12:09PM +0100, Andi Kleen wrote:
> It is normally on on all x86-64 systems.

Can the performance counters be disabled for seccomp only right?

> I definitely don't want any code like this in the context switch. It is 
> critical and I don't want to pollute fast paths with stuff like this
> that nobody needs.

287 registered CPUShare users will appreciate to compute more securely
thanks to this feature (about 10 up at any given time), and once I start
allowing transactions I hope much more users will need this (it's not
finished yet). 

We have in the kernel lots of features that slowdown a bit and that
benefit only a part of the userbase. Even kmap only benefits people with
>1G of ram. Even the security_* api in the syscalls only benefit a part
of the userbase. There are infinite other examples. The point is that
none of this is measurable, _especially_ this one in the context switch,
context switches aren't as frequent as syscalls! It's only two
cachelines at every context switch, and they might be hot already since
we're mangling over the task struct of the prev/next regardless of my
patch. If something we could discuss how to pack the seccomp structure
in the task structure so that it's already hot. But calling my feature
"pollution" seems a bit exaggerated to me.

Plus Andrew would have never allowed it to go in, if this could have
impacted performance, you also should know this can't slowdown anything
and you're just talking about theory.

Of course if 1000 other people also adds their feature to the context
switch then it might become measurable, but this is the first time we
had to change the context switch to add more security on per-task basis,
so I don't see it happening any time soon. Plus if it happens we can
implement some technique to share the same cacheline for multiple
purposes so it remains a fixed cost (like an hook). If you tell me how
to use an hook today that avoids me to touch two cachelines in the
context switch fast path, let me know, I don't see it.
