Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUDNQ2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUDNQ2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:28:00 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64984
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264265AbUDNQ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:27:02 -0400
Date: Wed, 14 Apr 2004 18:27:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
Message-ID: <20040414162700.GS2150@dualathlon.random>
References: <1130000.1081841981@[10.10.2.4]> <20040413005111.71c7716d.akpm@osdl.org> <120240000.1081903082@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120240000.1081903082@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 05:38:02PM -0700, Martin J. Bligh wrote:
> >> UP Athlon 2100+ with 512Mb of RAM. Rebooted clean before each test
> >> then did "make clean; make vmlinux; make clean". Then I timed a
> >> "make -j 256 vmlinux" to get some testing under mem pressure. 
> >> 
> >> I was trying to test the overhead of objrmap under memory pressure,
> >> but it seems it's actually distinctly negative overhead - rather pleasing
> >> really ;-) 
> >> 
> >> 2.6.5
> >> 225.18user 30.05system 6:33.72elapsed 64%CPU (0avgtext+0avgdata 0maxresident)k
> >> 0inputs+0outputs (37590major+2604444minor)pagefaults 0swaps
> >> 
> >> 2.6.5-anon_mm
> >> 224.53user 26.00system 5:29.08elapsed 76%CPU (0avgtext+0avgdata 0maxresident)k
> >> 0inputs+0outputs (29127major+2577211minor)pagefaults 0swaps
> > 
> > A four second reduction in system time caused a one minute reduction in
> > runtime?  Pull the other one ;)
> > 
> > Average of five runs, please...
> 
> You're right - it's rather variable. Still doesn't look bad though.
> 
> 2.6.5
> Average elapsed = 6:11
> 224.92user 30.15system 5:44.19elapsed 74%CPU (0avgtext+0avgdata 0maxresident)k
> 225.04user 30.23system 6:02.49elapsed 70%CPU (0avgtext+0avgdata 0maxresident)k
> 225.28user 29.60system 5:48.22elapsed 73%CPU (0avgtext+0avgdata 0maxresident)k
> 225.81user 31.75system 6:42.38elapsed 64%CPU (0avgtext+0avgdata 0maxresident)k
> 225.23user 30.20system 6:40.48elapsed 63%CPU (0avgtext+0avgdata 0maxresident)k
> 
> 2.6.5-anon_mm
> Average elapsed = 5:43
> 224.34user 25.43system 4:51.23elapsed 85%CPU (0avgtext+0avgdata 0maxresident)k
> 224.23user 25.93system 5:00.79elapsed 83%CPU (0avgtext+0avgdata 0maxresident)k
> 224.39user 26.36system 5:37.71elapsed 74%CPU (0avgtext+0avgdata 0maxresident)k
> 225.65user 27.13system 6:28.00elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
> 225.14user 27.26system 6:39.61elapsed 63%CPU (0avgtext+0avgdata 0maxresident)k
> 
> I've kicked off the -aa tree tests - will post them later tonight.

As expected the 6 second difference was nothing compared the the noise,
though I'd be curious to see an average number.

the degradation of runtimes is interesting, runtimes should go downs not
up after more unused stuff is pushed into swap and so more ram is free
at every new start of the workload.

BTW, I've no idea idea why you used an UP machine for this, (plus if you
can load kde on it it'd be better because kde is extremely smart at
optimizing the ram usage with cow anonymous memory, the thing anon-vma
can optimize and anonmm not, plus kde may use even mremap on this
anonymous ram, and the very single reason it was impossible for me to
take anonmm in production is that there's no way I can preodict which
critical app is using mremap on anonymous COW memory to save ram). You
definitely should use your 32-way booted with mem=512m to run this test
or there's no way you'll ever botice the additional boost in scalability
that anon-vma provides compared to anonmm, and that anonmm will never be
able to reach.
