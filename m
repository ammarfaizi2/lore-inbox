Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTJCJTZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 05:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbTJCJTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 05:19:25 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:58311 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263653AbTJCJTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 05:19:11 -0400
To: John Bradford <john@grabjohn.com>
cc: karim@opersys.com, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
In-Reply-To: Your message of "Fri, 03 Oct 2003 09:19:58 BST."
             <200310030819.h938JwQi000411@81-2-122-30.bradfords.org.uk> 
Date: Fri, 03 Oct 2003 10:19:06 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1A5M5a-00057S-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You might find that that's a dis-advantage as you scale up.  Rather
> than having CPU sit idle waiting for whoever paid for it to put it to
> use, companies offering virtual servers would probably prefer to
> oversubscribe the resources they've got, much like bandwidth is
> contended on a DSL line.
> 
> For example, say you have an 8-way box running virtual servers.
> Rather than sell each customer 1 cpu, let them burst to all 8 when
> they need it.  Only when the load would exceed 100% do yo need to give
> precedence to those who paid more.  You can sell a virtual 8 way
> machine to 8 customers, as long as they realise that it is contended.
> Web servers are often idle 90% of the time, but you want the best
> performance when they're not.
> 
> Sharing resources such as network cards is also likely to be vital for
> this to be scalable to any degree.

I should probably make it clear exactly how resources are muxed in the
current version of Xen. 

 CPU: We use a proportional fair-share scheduler (Borrowed Virtual
 Time). Guests can be be given different scheduler weights ---
 if reservations are being handed out then admission control is
 required to ensure that a given guest's fair share doesn't fall below
 its guaranteed minimum.

 Memory: Each guest is allocated a share of memory when it is started
 up. This is configurable per guest. Furthermore, a guest can request
 more memory, or give some memory back, according to current load (we
 implement a "balloon driver" as described by Waldspurger in a paper
 he presented at OSDI 2002).  

 Network + disk: Currently each domain gets a fair share (we use a
 round-robin scheduler). We plan to implement weighted share r.s.n.

We're interested in exploring reservation-based schedulers but, apart
from memory, resources currently aren't statically segregated.

Xen provides an excellent base for trying out new strategies for
resource sharing. Deploying new schedulers is not that hard --- it
just requires more man power than we have right now!

> Both of those points, as well as virtual local networking, are what
> make Z/Series boxes attractive for a lot of applications.

In fact, one of our main aims is to provide zseries-style
virtualization on x86 hardware! We've got a fair way towards this, but
we're not fully there yet :-)

> What is the performance penalty of running an X86-Xeno port of an OS
> natively on the hardware?  Some distributions may not be prepared to
> support it in addition to native X86, but if they can make X86-Xeno
> their main architecture...

Right, another good point. The performance penalty on a range of
system benchmarks (including SPEC WEB99) shows that there's up to
around 5% overhead for running x86-xen. This is far far less than any
other virtualization of x86 that is capable of running full OSes.

So yes: we envisage Xen being a next-gen replacement BIOS, in that it
could be installed on a machine and would then be responsible for
booting and supervising all OSes running on that machine. Device
drivers would be written according to a well-defined interface,
implemented within Xen, or within isolated "domains" running atop of
Xen. This kind of fits with the previous observation -- we want
zseries for x86 :-)

 -- Keir
