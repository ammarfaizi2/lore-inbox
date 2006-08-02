Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWHBG6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWHBG6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWHBG6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:58:31 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59551 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751111AbWHBG6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:58:30 -0400
Date: Tue, 1 Aug 2006 23:57:52 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       Simon.Derr@bull.net, steiner@sgi.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-Id: <20060801235752.28519bda.pj@sgi.com>
In-Reply-To: <20060731101542.A2817@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0>
	<20060731071242.GA31377@elte.hu>
	<20060731090440.A2311@unix-os.sc.intel.com>
	<20060731095429.d2b8801d.pj@sgi.com>
	<20060731101542.A2817@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> Basically SLES10 has to backport all these patches:
> 
> sched: fix group power for allnodes_domains
> sched_domai: Allocate sched_group structures dynamically
> sched: build_sched_domains() fix


A few questions on this, centered around the question of which dynamic
sched domain patches we should backport to SLES10.

Readers not seriously interested in sched domains on 2.6.16.* kernels
will probably want to ignore this post.


Is the first of the above three patches the one needed to fix the "big
numa dynamic sched domain memory corruption" that started off this
thread?  I'd test that theory now, but someone else is using my test
machine tonight.

The second of these three, "Allocate sched_group structures
dynamically," doesn't apply cleanly, because it depends on the
free_sched_groups() code added in another patch:

  sched_domain-handle-kmalloc-failure.patch

This patch in turn seems to have some important fixes and followups
in a couple other patches, listed below ...

Which of the following would you recommend I advise SUSE do for SLES10:

 1) Backport the "Allocate sched_group structures dynamically" 
    patch (removing the free_sched_groups() related pieces, and
    changing the "goto error" statements back to "break"), staying
    with just your above recommended set of three patches, or

 2) Also take the sched_domain-handle-kmalloc-failure.patch and its
    immediate followups, resulting in the following patch set:

	sched-fix-group-power-for-allnodes_domains.patch
	sched_domain-handle-kmalloc-failure.patch
	sched_domain-handle-kmalloc-failure-fix.patch
	sched_domain-dont-use-gfp_atomic.patch
	sched_domain-use-kmalloc_node.patch
	sched_domain-allocate-sched_group-structures-dynamically.patch
	sched-build_sched_domains-fix.patch

 3) Just take the first patch in this set, as it (I'm guessing) is
    the one needed to fix the immediate problem -- the memory
    corruption.


Cetainly the patchset in (2) applies more cleanly than (1), and it sure
seems to me like all these patches are fixing things we would want to
fix in SLES10.

Was there a reason you did not include these additional patches in your
recommendations for patches to backport to SLES10?

Any other patches I really should consider?  If so, why?

If you recommend (2), then can you offer a clean description of bug(s)
fixed, including symptoms and potential severity, and how fixed, for
each of the patches in that proposed patchset?  SUSE won't be much
interested in fixes unless they have a clear description of the pain
they will encounter if they don't take the fix.  The existing patch
header comments don't particularly spell that out.  They say what
changed, but not much of the why nor what kind of hurt one is in
without the change.

Also do you have any way to test whichever patch set you recommend on
other systems?  I can test on my big honkin numa iron (100's of CPUs,
NUMA yes, SMT no, MC no), but SUSE will want to know that this stuff
worked on more ordinary systems and SMT (hyperthread) and MC
(multicore) systems.

Sorry for all the questions ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
