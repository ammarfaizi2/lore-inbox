Return-Path: <linux-kernel-owner+w=401wt.eu-S1161292AbXAMFuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161292AbXAMFuu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 00:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161294AbXAMFuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 00:50:50 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:38907 "EHLO
	tomts16-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161292AbXAMFut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 00:50:49 -0500
Date: Sat, 13 Jan 2007 00:45:34 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Ingo Molnar <mingo@redhat.com>, Douglas Niehaus <niehaus@eecs.ku.edu>,
       systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4] Linux Kernel Markers
Message-ID: <20070113054534.GA27017@Krystal>
References: <20061220235216.GA28643@Krystal> <OFAB3D8A6C.1643F2D3-ON80257262.000581E4-80257262.00088F04@uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <OFAB3D8A6C.1643F2D3-ON80257262.000581E4-80257262.00088F04@uk.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:27:26 up 143 days, 34 min,  3 users,  load average: 2.64, 1.02, 0.59
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

* Richard J Moore (richardj_moore@uk.ibm.com) wrote:
> 
> 
> Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote on 20/12/2006
> 23:52:16:
> 
> > Hi,
> >
> > You will find, in the following posts, the latest revision of the Linux
> Kernel
> > Markers. Due to the need some tracing projects (LTTng, SystemTAP) has of
> this
> > kind of mechanism, it could be nice to consider it for mainstream
> inclusion.
> >
> > The following patches apply on 2.6.20-rc1-git7.
> >
> > Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> 
> Mathiue, FWIW I like this idea. A few years ago I implemented something
> similar, but that had no explicit clients. Consequently I made my hooks
> code more generalized than is needed in practice. I do remember that Karim
> reworked the LTT instrumentation to use hooks and it worked fine.
> 

Yes, I think some features you implemented in GKHI, like chained calls to
multiple probes, should be implemented in a "probe management module" which
would be built on top of the marker infrastructure. One of my goal is to
concentrate on having the core right so that, afterward, building on top of it
will be easy.

> You've got the same optimizations for x86 by modifying an instruction's
> immediate operand and thus avoiding a d-cache hit. The only real caveat is
> the need to avoid the unsynchronised cross modification erratum. Which
> means that all processors will need to issue a serializing operation before
> executing a Marker whose state is changed. How is that handled?
> 

Good catch. I thought that modifying only 1 byte would spare us from this
errata, but looking at it in detail tells me than it's not the case.

I see three different ways to address the problem :
1 - Adding some synchronization code in the marker and using
    synchronize_sched().
2 - Using an IPI to make other CPUs busy loop while we change the code and then
    execute a serializing instruction (iret, cpuid...).
3 - First write an int3 instead of the instruction's first byte. The handler
    would do the following :
    int3_handler :
      single-step the original instruction.
      iret

    Secondly, we call an IPI that does a smp_processor_id() on each CPU and
    wait for them to complete. It will make sure we execute a synchronizing
    instruction on every CPU even if we do not execute the trap handler.

    Then, we write the new 2 bytes instruction atomically instead of the int3
    and immediate value.


I exclude (1) because of the performance impact, (2) because it does not deal
with NMIs. It leaves (3). Does it make sense ?


> One additional thing we did, which might be useful at some future point,
> was adding a /proc interface. We reflected the current instrumentation
> though /proc and gave the status of each hook. We even talked about being
> able to enable or disabled instrumentation by writing to /proc but I don't
> think we ever implemented this.
> 

Adding a /proc output to list the active probes and their
callback will be tribial to add to the markers. I think the probe management
module should have its /proc file too to list the chains of connected handlers
once we get there.

> It's high time we settled the issue of instrumentation. It gets my vote,
> 
> Good luck!
> 
> Richard
> 

Thanks,

Mathieu

> - -
> Richard J Moore
> IBM Linux Technology Centre
> 

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
