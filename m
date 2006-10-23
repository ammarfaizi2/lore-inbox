Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWJWGAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWJWGAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWJWGAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:00:38 -0400
Received: from mga05.intel.com ([192.55.52.89]:56661 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751545AbWJWGAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:00:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,341,1157353200"; 
   d="scan'208"; a="6587909:sNHT19481841"
Date: Sun, 22 Oct 2006 22:40:03 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, dino@in.ibm.com, akpm@osdl.org,
       mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-ID: <20061022224002.C2526@unix-os.sc.intel.com>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com> <20061020210422.GA29870@in.ibm.com> <20061022201824.267525c9.pj@sgi.com> <453C4E22.9000308@yahoo.com.au> <20061022225108.21716614.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061022225108.21716614.pj@sgi.com>; from pj@sgi.com on Sun, Oct 22, 2006 at 10:51:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 10:51:08PM -0700, Paul Jackson wrote:
> Nick wrote:
> > A cool option would be to determine the partitions according to the
> > disjoint set of unions of cpus_allowed masks of all tasks. I see this
> > getting computationally expensive though, probably O(tasks*CPUs)... I
> > guess that isn't too bad.
> 
> Yeah - if that would work, from the practical perspective of providing
> us with a useful partitioning (get those humongous sched domains carved
> down to a reasonable size) then that would be cool.
> 
> I'm guessing that in practice, it would be annoying to use.  One would
> end up with stray tasks that happened to be sitting in one of the bigger
> cpusets and that did not have their cpus_allowed narrowed, stopping us
> from getting a useful partitioning.  Perhaps anilliary tasks associated
> with the batch scheduler, or some paused tasks in an inactive job that
> were it active would need load balancing across a big swath of cpus.
> These would be tasks that we really didn't need to load balance, but they
> would appear as if they needed it because of their fat cpus_allowed.
> 
> Users (admins) would have to hunt down these tasks that were getting in
> the way of a nice partitioning and whack their cpus_allowed down to
> size.
> 
> So essentially, one would end up with another userspace API, backdoor
> again.  Like those magic doors in the libraries of wealthy protagonists
> in mystery novels, where you have to open a particular book and pull
> the lamp cord to get the door to appear and open.

Also we need to be careful with malicious users partitioning the systems wrongly
based on the cpus_allowed for their tasks.

> 
> Automatic chokes and transmissions are great - if they work.  If not,
> give me a knob and a stick.
> 
> ===
> 
> Another idea for a cpuset-based API to this ...
> 
> From our internal perspective, it's all about getting the sched domain
> partitions cut down to a reasonable size, for performance reasons.

we need consider resource partitioning too..  and this is where
google interests are probably coming from?

> 
> But from the users perspective, the deal we are asking them to
> consider is to trade in fully automatic, all tasks across all cpus,
> load balancing, in turn for better performance.
> 
> Big system admins would often be quite happy to mark the top cpuset
> as "no need to load balance tasks in this cpuset."  They would
> take responsibility for moving any non-trivial, unpinned tasks into
> lower cpusets (or not be upset if something left behind wasn't load
> balancing.)
> 
> And the batch scheduler would be quite happy to mark its top cpuset as
> "no need to load balance".  It could mark any cpusets holding inactive
> jobs the same way.
> 
> This "no need to load balance" flag would be advisory.  The kernel
> might load balance anyway.  For example if the batch scheduler were
> running under a top cpuset that was -not- so marked, we'd still have
> to load balance everyone.  The batch scheduler wouldn't care.  It would
> have done its duty, to mark which of its cpusets didn't need balancing.
> 
> All we need from them is the ok to not load balance certain cpusets,
> and the rest is easy enough.  If they give us such ok on enough of the
> big cpusets, we give back a nice performance improvement.
> 
