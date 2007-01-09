Return-Path: <linux-kernel-owner+w=401wt.eu-S932438AbXAIWGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbXAIWGY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbXAIWGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:06:23 -0500
Received: from tomts13.bellnexxia.net ([209.226.175.34]:41429 "EHLO
	tomts13-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932438AbXAIWGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:06:22 -0500
Date: Tue, 9 Jan 2007 17:06:16 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] local_t : Documentation
Message-ID: <20070109220616.GA30535@Krystal>
References: <20061221001545.GP28643@Krystal> <20061223093358.GF3960@ucw.cz> <20070109031446.GA29426@Krystal> <20070109130110.8934c29f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20070109130110.8934c29f.akpm@osdl.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:52:47 up 139 days, 19:00,  5 users,  load average: 0.13, 0.27, 0.32
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> On Mon, 8 Jan 2007 22:14:46 -0500
> Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > +* How to use local atomic operations
> > +
> > +#include <linux/percpu.h>
> > +#include <asm/local.h>
> > +
> > +static DEFINE_PER_CPU(local_t, counters) = LOCAL_INIT(0);
> > +
> > +
> > +* Counting
> > +
> > +In preemptible context, use get_cpu_var() and put_cpu_var() around local atomic
> > +operations : it makes sure that preemption is disabled around write access to
> > +the per cpu variable. For instance :
> > +
> > +	local_inc(&get_cpu_var(counters));
> > +	put_cpu_var(counters);
> 
> Confused.  The whole point behind local_t is that we can do
> atomic-wrt-interrupts inc and dec on them.
> 
> Consequently, as atomic-wrt-interrupts means atomic-wrt-preemption, there
> is no need to do a preempt_disable() around local_inc() and local_dec().
> 

Hi Andrew,

Not exactly : the increment operation is atomic, but not the selection of the
local variable. local_inc(&__get_cpu_var()) implies the following sequence 
of operations :

1 - Get the variable copy corresponding to the currently running CPU.
2 - atomically increment the variable.

It would be wrong to be scheduled on another CPU between 1 and 2, because the
atomic increment should only be done by the CPU "owner" of the local variable,
as the local atomic increment is not atomic wrt other CPUs.

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
