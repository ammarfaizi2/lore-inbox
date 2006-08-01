Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWHAIZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWHAIZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWHAIZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:25:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62339 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750726AbWHAIZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:25:56 -0400
Date: Tue, 1 Aug 2006 01:25:33 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       suresh.b.siddha@intel.com, Simon.Derr@bull.net, steiner@sgi.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-Id: <20060801012533.4192c5b4.pj@sgi.com>
In-Reply-To: <20060731090440.A2311@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0>
	<20060731071242.GA31377@elte.hu>
	<20060731090440.A2311@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Ingo,

I believe Suresh is correct, and that the mainline no longer
has this bug.  So the patch that was buried in my report should
not be applied.


Suresh wrote:
> Paul can you please test the mainline code and confirm?

I have tested the mainline, 2.6.18-rc2-mm1, and I am now nearly certain
you are correct.  I did not see the failure.  There is a slim chance
that I botched the forward port of the tripwire code needed to catch
this bug efficiently, and so could have missed seeing the bug on that
account.

I will now try backporting the three patches you recommended for
systems on a release such as SLES10:

  sched: fix group power for allnodes_domains
  sched_domai: Allocate sched_group structures dynamically
  sched: build_sched_domains() fix

I wish you well on any further code improvements you have planned for
this code.  It's tough to understand, with such issues as many #ifdef's,
an interesting memory layout of the key sched domain arrays that I
didn't see described much in the comments, and a variety of memory
allocation calls that are tough to unravel on error.  Portions of
the code could use some more comments, explaining what is going on.
For example, I still haven't figured exactly what 'cpu_power' means.

The allocations of sched_group_allnodes, sched_group_phys and
sched_group_core are -big- on our ia64 SN2 systems (1024 CPUs),
and could fail once a system has been up for a while and is
getting memory tight and fragmented.

It is not obvious to me from the code or comments just how sched
domains are arranged on various large systems with hyper-threading
(SMT) and/or multiple cores (MC) and/or multiple processor packages
per node, and how scheduling is affected by all this.

This was about the third bug that has come by in it -- which I
in particular notice when it is someone playing with cpu_exclusive
cpusets who hits the bug.  Any kernel backtrace with 'cpuset' buried in
it tends to migrate to my inbox.  This latest bug was particularly
nasty, as is usually the case with random memory corruption bugs,
costing us a bunch of hours.

Good luck.

If you are aware of any other fixes/patches besides the above that us
big honkin numa iron SLES10 users need for reliable operation, let me
know.

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
