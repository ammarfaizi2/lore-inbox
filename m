Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVBOW4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVBOW4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVBOWxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:53:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:6019 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261936AbVBOWw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:52:26 -0500
Date: Tue, 15 Feb 2005 16:51:52 -0600
From: Robin Holt <holt@sgi.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Robin Holt <holt@sgi.com>, ": Paul Jackson" <pj@sgi.com>,
       haveblue@us.ibm.com, raybry@sgi.com, taka@valinux.co.jp,
       hugh@veritas.com, akpm@osdl.org, marcello@cyclades.com,
       raybry@austin.rr.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration -- sys_page_migrate
Message-ID: <20050215225152.GA26753@lnx-holt.americas.sgi.com>
References: <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com> <1108242262.6154.39.camel@localhost> <20050214135221.GA20511@lnx-holt.americas.sgi.com> <1108407043.6154.49.camel@localhost> <20050214220148.GA11832@lnx-holt.americas.sgi.com> <20050215074906.01439d4e.pj@sgi.com> <20050215162135.GA22646@lnx-holt.americas.sgi.com> <20050215083529.2f80c294.pj@sgi.com> <20050215185943.GA24401@lnx-holt.americas.sgi.com> <16914.28795.316835.291470@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16914.28795.316835.291470@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 08:58:19AM +1100, Peter Chubb wrote:
> >>>>> "Robin" == Robin Holt <holt@sgi.com> writes:
> 
> Robin> On Tue, Feb 15, 2005 at 08:35:29AM -0800, Paul Jackson wrote:
> >> What about the suggestion I had that you sort of skipped over,
> >> which amounted to changing the system call from a node array to
> >> just one node:
> >> 
> >> sys_page_migrate(pid, va_start, va_end, count, old_nodes,
> >> new_nodes);
> >> 
> >> to:
> >> 
> >> sys_page_migrate(pid, va_start, va_end, old_node, new_node);
> >> 
> >> Doesn't that let you do all you need to?  Is it insane too?
> 
> Robin> Migration could be done in most cases and would only fall apart
> Robin> when there are overlapping node lists and no nodes available as
> Robin> temp space and we are not moving large chunks of data.
> 
> A possibly stupid suggestion: 
> 
> Can page migration be done lazily, instead of all at once?  Move the
> process, mark its pages as candidates for migration, and when 
> the page faults, decide whether to copy across or not...
> 
> That way you only copy the pages the process is using, and only copy
> each page once.  It makes copy for replication easier in some future
> incarnation, too, because the same basic infrastructure can be used.

I would agree that lazy might be possible, but then we need to keep track
of the desired destination and can not rely upon first touch as that
will likely result in scrambling the memory of the application.

I have been very lax in describing how a typical MPI application works.
This method has been in place for years and is commonly accepted practice.

In the MPI model, a set of large mappings are done by the first process.
It then forks x number of worker threads which touch their chunk of
memory and rendezvous with the other workers.  Once all workers have
redezvoused, they are allowed to start their processing.  A typical
worker thread will reference their memory set 85-97% of the time and
reference other memory sets in a read-only fashion the other part
of the time.

It is important to performance that the worker threads memory remains
as close to its cpu as possible.  Any time the memory is on a different
node, the performance of that thread degrades (memory is further away)
and performance of the other thread is hindered (its memory controller
is more busy) and the read portions of the neighbor threads to both
of the afor mentioned worker threads is hindered as there is more
NUMA activity.  Given all that, there is a common concept in MPI called
a barrier where when worker threads complete a work set, they awaken
threads waiting at the barrier associated with the work set.  As a
result of this wait, by slowing down a single thread you can have a
cascade effect which slows down the entire application significantly
as barriers are missed.

Because of all this discussion, memory placement needs be thought of
as relative to the worker threads and maintained relatively consistent
before and after the migration.

Another issue with making it a lazy migrate is the real impetus for
this is to free up memory on a node so a job can be stopped on one
node, migrated to a different node and thereby free up the original
node for a second job which would not fit with the original job
taking up a section of the machine which would cause the other
job to perform too poorly.

Sorry for the long rambling explanation.  I guess I will try to
break this into smaller chunks on the upcoming discussion on the
linux-mm list.

Thanks,
Robin
