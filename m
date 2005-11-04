Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVKDRo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVKDRo6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKDRo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:44:58 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:25527
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750764AbVKDRo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:44:57 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Fri, 4 Nov 2005 11:44:26 -0600
User-Agent: KMail/1.8
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <1130917338.14475.133.camel@localhost> <200511040950.59942.rob@landley.net> <200511041818.04397.blaisorblade@yahoo.it>
In-Reply-To: <200511041818.04397.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041144.27762.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 11:18, Blaisorblade wrote:
> > Oh well, bench it when it happens.  (And in any case, it needs a tunable
> > to beat the page cache into submission or there's no free memory to give
> > back.
>
> I couldn't parse your sentence. The allocation will free memory like when
> memory is needed.

If you've got a daemon running in the virtual system to hand back memory to 
the host, then you don't need a tuneable.

What I was thinking is that if we get prezeroing infrastructure that can use 
various prezeroing accelerators (as has been discussed but I don't believe 
merged), then a logical prezeroing accelerator for UML would be calling 
madvise on the host system.  This has the advantage of automatically giving 
back to the host system any memory that's not in use, but would require some 
way to tell kswapd or some such that keeping around lots of prezeroed memory 
is preferable to keeping around lots of page cache.

In my case, I have a workload that can mostly work with 32-48 megs of ram, but 
it spikes up to 256 at one point.  Right now, I'm telling UML mem=64 megs and 
the feeding it a 256 swap file on ubd, but this is hideously inefficient when 
it actually tries to use this swap file.  (And since the host system is 
running a 2.6.10 kernel, there's a five minute period during each build where 
things on my desktop actually freeze for 15-30 seconds at a time.  And this 
is on a laptop with 512 megs of ram.  I think it's because the disk is so 
overwhelmed, and some things (like vim's .swp file, and something similar in 
kmail's composer) do a gratuitous fsync...

> However look at /proc/sys/vm/swappiness

Setting swappiness to 0 triggers the OOM killer on 2.6.14 for a load that 
completes with swappiness at 60.  I mentioned this on the list a little while 
ago and some people asked for copies of my test script...

> or use Con Kolivas's patches to find new tunable and policies.

The daemon you mentioned is an alternative, but I'm not quite sure how rapid 
the daemon's reaction is going to be to potential OOM situations when 
something suddenly wants an extra 200 megs...

Rob
