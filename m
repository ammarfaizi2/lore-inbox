Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263686AbUECNR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUECNR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 09:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUECNR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 09:17:59 -0400
Received: from zero.aec.at ([193.170.194.10]:54541 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263686AbUECNR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 09:17:56 -0400
To: Zoltan.Menyhart@bull.net
cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA API - wish list
References: <1QAMU-4gf-15@gated-at.bofh.it> <1RLdk-29R-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 03 May 2004 15:17:52 +0200
In-Reply-To: <1RLdk-29R-11@gated-at.bofh.it> (Zoltan Menyhart's message of
 "Mon, 03 May 2004 15:00:14 +0200")
Message-ID: <m3k6zttzsv.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org> writes:

> The work load manager / load balancer can negotiate other resource
> assignment at any time with the application.
> The work load manager / load balancer is free to move a collection of
> resources from some NUMA domains to others, provided the application's
> requirements are still met. (No hard binding.)

IMHO these are hard research topics that will need considerable
more work to be automated, if they will ever work automated at all.
The main problem is that you several conflicting goals: you 
want to use all available CPU power, all available memory,
all available memory bandwidth and the best average memory latency.
They all conflict.

First: basically any more advanced automatic schemes will
require to go all the way to a full workload manager 
that can move around memory later, because it is near impossible
to get even two of these goals right in advance.

I first tried to develop a NUMA scheduler "homenode scheduler" that
attempted to do a lot of this automatically.  I then realized that it
is just too hard to do and it never worked very well. That is why I
changed gears and just started with a simple API to let the user tell
the kernel what he wants.

The advantage of this is that a lot of complexity is avoided; 
e.g. the NUMA API avoids any need to move memory around.

Now if somebody comes up with a good design for a workload manager and
does all the experiments needed to validate it then it could be later
added. But defering NUMA optimization efforts until this considerable
task is solved (if it even can be solved) would be a big mistake IMHO.

> Billing is done accordingly :-)
>
> As you do not need to know anything about SCSI LUNs, sector IDs, phy-
> sical memory maps or the other applications when you compile your kernel,  
> why should an application care for HW NUMA details ?

There is a big difference between these and NUMA. 

LUNs, sectors, physical memory are all hidden for correctness. For 
that virtualization is fine, because performance is secondary 
after correctness.

But NUMA knowledge is purely for optimization. And for optimization
purposes you want to avoid virtualization layers, because they get
in the way of your optimization efforts.

When a human does NUMA optimization they usually want to work near the
bare hardware.  And if your dream of a automatic workload manager ever
worked it would also work on the bare hardware.

-Andi

