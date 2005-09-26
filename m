Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVIZOiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVIZOiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 10:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbVIZOiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 10:38:15 -0400
Received: from triton.rz.uni-saarland.de ([134.96.7.25]:17788 "EHLO
	triton.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S1751637AbVIZOiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 10:38:14 -0400
From: Michael Bellion <mbellion@hipac.org>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
Date: Mon, 26 Sep 2005 16:38:12 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com, jamal <hadi@cyberus.ca>
References: <200509260445.46740.mbellion@hipac.org> <4337DA7C.2000804@cs.aau.dk>
In-Reply-To: <4337DA7C.2000804@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261638.12731.mbellion@hipac.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (triton.rz.uni-saarland.de [134.96.7.25]); Mon, 26 Sep 2005 16:38:12 +0200 (CEST)
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.32.0.6; VDF 6.32.0.43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> I'm still not convinced by your approach. :-/

You really should have a closer look at nf-HiPAC so that you know what you are 
talking about!

Your Compact Filter takes a completely different approach than nf-HiPAC to 
build the data structure used in the kernel for the packet classification 
lookup.

Your Compact Filter uses a static compiler in user space. That compiler 
transforms the rule set into boolean expressions and than uses operations 
from predicate logic to optimize the rule set.
This has the big drawback that whenever only a single rule changes you have to 
recompile the complete lookup data structure. So this approach is clearly not 
suitable for scenarios depending on dynamic rule sets.

nf-HiPAC uses a completely different approach to build the lookup data 
structure in the kernel. It is based on geometry.
This approach allows completely dynamic updates. During an update of the rules 
only the required changes of the lookup data structure are made. The data 
structure is NOT rebuild from scratch. This guarantees that the packet 
processing is only affected to the least possible amount during updates.

Although nf-HiPAC and Compact Filter use completely different approaches and 
algorithms to build the lookup data structure it is important that you 
understand the following:
nf-HiPAC and Compact filter end up with a very very similar lookup data 
structure in the kernel.


> These experiments have to be updated but can you comment on this:
> http://www.cs.aau.dk/~mixxel/cf/experiments.html

The current version of the algorithm used in nf-HiPAC does not optimize 
certain aspects of the lookup data structure in order to increase the speed 
of dynamic rule set updates.
This means that the lookup data structure is larger than it really needs to be 
because it contains some unnecessary redundancy.
This explains your test results.
Compact Filter and nf-HiPAC perform the same when they are both able to keep 
their lookup data structure in the CPU caches and when they are both not able 
to do so anymore.
Compact Filter is currently able to perform better in the area where it is 
able to keep its data structure still in the caches while nf-HiPAC is not 
able to do so anymore.

Most aspects of your performance tests are quite nice (e.g. the generating the 
traffic by replaying a packet header trace).
But your performance tests have a serious flaw:
You construct your rule set by creating one rule for each entry in your packet 
header trace. This results in an completely artificial rule set that creates 
a lot of redundancy in the nf-HiPAC lookup data structure making it much 
larger than the Compact Filter data structure.

You have to understand that with real world rule sets the size of the computed 
lookup data structure will not be much different for Compact Filter and 
nf-HiPAC. This means that when you use real world rule sets there shouldn't 
be any noticeable difference in lookup performance betweeen Compact Filter 
and nf-HiPAC.

-----------------

I am currently working on a new improved version of the algorithm used in 
nf-HiPAC. The new algorithmic core will reduce memory usage while at the same 
time improving the running time of insert and delete operations. The lookup 
performance will be improved too, especially for bigger rulesets. The 
concepts and the design are already developed, but the implementation is 
still in its early stages.

The new algorithmic core will make sure that the lookup data structure in the 
kernel is always fully optimized while at the same time allowing very fast 
dynamic updates.

At that point Compact Filter will not be able to win in any performance test 
against  nf-HiPAC anymore, simply because there is no way to optimize the 
lookup data structure any further.

Regards,
    +---------------------------+
    |      Michael Bellion      |
    |   <mbellion@hipac.org>    |
    +---------------------------+







