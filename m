Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTIKMJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 08:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbTIKMJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 08:09:55 -0400
Received: from colin2.muc.de ([193.149.48.15]:1034 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261250AbTIKMJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 08:09:52 -0400
Date: 11 Sep 2003 14:09:56 +0200
Date: Thu, 11 Sep 2003 14:09:56 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: dada1 <dada1@cosmosbay.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Network buffer hang was Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911120956.GB7751@colin2.muc.de>
References: <uqD5.3BI.3@gated-at.bofh.it> <m3iso0arlx.fsf@averell.firstfloor.org> <0a5801c37821$54eb8180$890010ac@edumazet> <20030911051121.GA7751@colin2.muc.de> <0a7701c37829$c4bdef40$890010ac@edumazet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7701c37829$c4bdef40$890010ac@edumazet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 07:58:46AM +0200, dada1 wrote:
> 
> >
> > I don't have any. But it would be very similar to the in kernel checking
> > code (see the is_prefetch function in my patches). Just you feed it
> > the fields from sigcontext in the signal handler and replace __get_user
> > with a normal memory access.
> 
> OK will try... but how test it... sounds not easy.

>From your description of the symptoms it sounds like a waste of time.

> 
> Well, the program is using more than 2Go ram... the core is not written to
> disk as the machine hangs just *after*

These bug doesn't cause kernel hangs, just "ordinary" segfaults

(unless the kernel triggers it, but that happens only very rarely)

> >
> > If it is a different instruction it is unrelated.
> >
> > It would also only happen when you prefetch ever on unmapped addresses.
> 
> NULL for example ?

Yes, NULL would work. But only when there are byte sized reads of parts
of the prefetched memory that are not aligned to the cache line size
and hit the second part of a cache line and happens exactly the in
the right timing window after the prefetch

(see Richard's description - it really is quite hard to trigger) 


> 
> Typical example of code ;
> 
> T_cell *ptr, *next ;
> for (ptr = list.head ; ptr != NULL ; ptr = next) {
>    next = ptr->next ;
>    prefetch(next) ;
>    some_work(ptr) ;
>    }
> 
> I may replace NULL by &FakeMappedData   (allways present in memory)

That's certainly safer, but slightly slower (need one more register in
the loop)

If it doesn't trigger I would probably not bother.


> 
> >
> > That sounds like an unrelated issue.
> >
> > When user space crashes on this the kernel is unaffected.
> 
> This is not a kernel crash. But total freeze as all memory is used by
> network buffers, in no more than 10 seconds.

Ok, but then you have to diagnose this freeze. I'm not sure why you
think it must be this prefetch thingy. If the prefetch issue was
hit then you would just get a normal segfault, not a kernel hang.

e.g. you could write some kind of reduced test case for it and
post it to the netdev mailing list (netdev@oss.sgi.com) 

I'm cc'ing it for you.

> This application receive smalls TCP messages (about 30 bytes), but the
> network stacks allocates 4KB buffers to store this little messages.

Most drivers only allocate MTU size in their receive ring
(normally 1.5K on ethernet). This is rounded to 2K by  the memory allocator.

But most drivers support a rx_copybreak parameter. When the received
packet is smaller than rx_copybreak it is copied to a freshly allocated
buffer with the right size.

In addition the 2.4 stack also supports garbage collection in the TCP
receive buffers. This means even when a driver doesn't do the rx_copybreak
trick and the receive queue of a socket fills up it will copy the data
to fresh, right sized packets by itself.

Another limit for this scenario is that the network stack has internal
limits that supposed to avoid this. These are: each socket has a 
fixed receive buffer size and when more data arrives (including packet
metadata and normal wastage) than the receive buffer allows then it is
still dropped. In addition TCP has a global memory limit that also kicks 
in. And the network stack has a global queue limit that prevents
too much data to be queued from the driver to the higher level
parts (/proc/sys/net/core/netdev_max_backlog). Sometimes the queueing
can also be controlled on the driver level with driver specific
knobs.

This all can be tuned by sysctls in /proc/sys. See Documentation/networking/
ip-sysctl.txt for more details. 

Also the latest 2.6 kernel finally has a writable /proc/sys/vm/min_free_kbytes
again. This controls the amount of memory kept free for interrupts.
Increase that.

> I posted a test application some days ago about this problem and got no
> answers/feedback.

Did you post it to netdev?  On linux-kernel such things get often
lost in the noise.

Also I would contact the driver maintainer, it could be really a driver
Issue.

-Andi

