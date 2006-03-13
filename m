Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWCNADQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWCNADQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCNADQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:03:16 -0500
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:50134 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S932129AbWCNADN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:03:13 -0500
Date: Mon, 13 Mar 2006 15:58:48 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: John Levon <levon@movementarian.org>
Cc: William Cohen <wcohen@nc.rr.com>,
       oprofile-list <oprofile-list@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net, perfmon@napali.hpl.hp.com
Subject: Re: [Perfctr-devel] 2.6.16-rc5 perfmon2 new code base + libpfm with Montecito support
Message-ID: <20060313235848.GI32683@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060308155311.GD13168@frankl.hpl.hp.com> <4415BC45.1010601@nc.rr.com> <20060313185500.GB32683@frankl.hpl.hp.com> <4415C4E9.5070702@nc.rr.com> <20060313210127.GA13453@totally.trollied.org> <20060313210354.GG32683@frankl.hpl.hp.com> <20060313232057.GA16582@totally.trollied.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313232057.GA16582@totally.trollied.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

On Mon, Mar 13, 2006 at 11:20:57PM +0000, John Levon wrote:
> On Mon, Mar 13, 2006 at 01:03:54PM -0800, Stephane Eranian wrote:
> 
> > > 1) the event names are synchronised so we don't need massive duplication
> > 
> > The kernel perfmon2 interface does not know anything about event names.
> 
> Well, it sounded like Will was proposing extra event directories.

I think Will was trying to solve the register naming differences.
I do not know how you deal with this in ophelp.

> > > 2) that "start a thread on each CPU" API is fixed to be sane
> >
> > Please develop on this point some more.
> 
> The kernel interface should just let me say "I want this setup on all
> CPUs" and do the IPIs for me.
> 
That's is because you are assuming a model were you always want to monitor
all CPUs each time and measure the same thing everywhere.  This does not
always makes sense in large configurations. You may want to only monitor
a subset of CPUs or you may want to monitor different things on different
CPUs at the same time, for instance because they handle different workloads
or interrupts.

When it comes to sampling, I think you will agree with me that the kernel level 
sampling buffer must be per-cpu. I think this is also how you manage
it in OProfile. I think it also makes sense to process the buffer locally for
cache affinity reasons for instance. Keep monitoring overhead minimum by exploiting
locality. I think (correct me if I am wrong) in Oprofile you somehow merge the
per-cpu buffers into a single buffer which is then read via read() by user level
applications. For some measurements merging is not necessarily what is needed.

In your model, I would have to pass a bitmap of CPUs to monitor, then internally
the kernel would have propagate the setup via IPI and maintain a context per-cpu.
Then upon return, it would have to pass information as to how to mmap the per-cpu
buffers. You have a choice of doing one mmap() per buffer or to do
a single large mmap() covering the possibly discountiguous physical pages 
backing each per-cpu buffer. In either case, it would make sense to ensure
that the thread processing each buffer runs on the CPU where the samples
have been collected to minimize cache traffic which is very important on NUMA
machines. Typically on those machines, every effort is made to keep all memory
accesses local, I do not see why this would not also apply to profiling.

Note that in the new perfmon code base, you do not have to create one thread
per monitored CPU. All you need to do is to ensure that the thread runs on
the CPU it needs to access when issuing perfmon2 calls causing actual PMU 
HW accesses. A single thread can very well control lots of context bound to
different threads or CPU.

But again, I am always open to discussions/proposals on this.

-- 
-Stephane
