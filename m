Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSGIOt5>; Tue, 9 Jul 2002 10:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSGIOt4>; Tue, 9 Jul 2002 10:49:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36973 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315439AbSGIOtz>; Tue, 9 Jul 2002 10:49:55 -0400
Date: Tue, 9 Jul 2002 16:53:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: zwane@linuxpower.ca, jamagallon@able.es, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: pipe and af/unix latency differences between aa and jam on smp
Message-ID: <20020709145327.GC8878@dualathlon.random>
References: <20020709140558.GA21293@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020709140558.GA21293@rushmore>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 10:05:58AM -0400, rwhron@earthlink.net wrote:
> > *Local* Communication latencies in microseconds - smaller is better
> 
> > kernel                          Pipe    AF/Unix
> > -----------------------------  -------  -------
> > 2.4.19-pre7-jam6                29.513   42.369
> > 2.4.19-pre8-jam2                 7.697   15.274
> > 2.4.19-pre8-jam2-nowuos          7.739   14.929
> 
> > (last line says that wake-up-sync is not responsible...)
> 
> > Main changes between first two were irqbalance and ide6->ide10.
> 
> The system is scsi only.  pre7-jam6 and pre8-jam2 .config's were 
> identical.
> 
> > Could you try latest -rc1-aa2 ? It includes also irqbalance,
> 
> Based on Andrea'a diff logs, irqbalance appeared in 2.4.19pre10aa3.
> There are small differences between the pre10-jam2 and aa irqbalance
> patches.  One new datapoint with pre10-jam3:
> 
> *Local* Communication latencies in microseconds - smaller is better
> -------------------------------------------------------------------
> kernel                          Pipe    AF/Unix
> -----------------------------  -------  -------
> 2.4.19-pre10-jam2                7.877   16.699
> 2.4.19-pre10-jam3               33.133   66.825
> 2.4.19-pre10-aa2                34.208   62.732
> 2.4.19-pre10-aa4                33.941   70.216
> 2.4.19-rc1-aa1-1g-nio           34.989   52.704

now if this was AF_INET via ethernet I could imagine the irqbalance
making difference (or even irqrate even if irqrate should make no
difference until your hardware hits the limit of irqs it can handle).

but both pipe and afunix should not generate any irq load (other than
the IPI with the reschedule_task wakeups at least, but they're only
dependent on the scheduler, ipi delivery isn't influenced by the
irqrate/irqbalance patches). it's all trasmission in software internal
to the kernel, with no hardware events so no irq, so I would be very
surprised if the irqbalance or irqrate could make any difference. I
would look elsewere first at least.  No idea why you're looking at those
irq related patches for this workload.

At first glance I would say either it's a compiler issue that generates
some very inefficent code one way or the other (seems very unlikely but
cache effects can be quite huge in tight loops where a very small part
of the kernel is exercised), or it has something to do with schduler or
similar core non-irq related areas.

> 
> A config difference between pre10-jam2 and pre10-jam3 is:
> CONFIG_X86_SFENCE=y	# pre10-jam2
> pre10-jam2 was compiled with -Os and pre10-jam3 with -O2.
> 
> > Out of interest, is that a P4/Xeon?
> 
> Quad P3/Xeon 700 mhz with 1MB cache.
> 
> -- 
> Randy Hron
> http://home.earthlink.net/~rwhron/kernel/bigbox.html


Andrea
