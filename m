Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUJDAsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUJDAsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 20:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUJDAsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 20:48:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13772 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268283AbUJDAsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 20:48:17 -0400
Date: Sun, 3 Oct 2004 17:45:39 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041003174539.1652ea2b.pj@sgi.com>
In-Reply-To: <834330000.1096847619@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
>
> Mmmm. The fundamental problem I think we ran across (just whilst pondering,
> not in code) was that some things (eg ... init) are bound to ALL cpus (or
> no cpus, depending how you word it); i.e. they're created before the cpusets
> are, and are a member of the grand-top-level-uber-master-thingummy.
> 
> How do you service such processes? That's what I meant by the exclusive
> domains aren't really exclusive. 

I move 'em.  I have user code that identifies the kernel threads whose
cpus_allowed is a superset of cpus_online_map, and I put them in a nice
little padded cell with init and the classic Unix daemons, called the
'bootcpuset'.

The tasks whose cpus_allowed is a strict _subset_ of cpus_online_map
need to be where they are.  These are things like the migration helper
threads, one for each cpu.  They get a license to violate cpuset
boundaries.

I will probably end up submitting a patch at some point, that changes
two lines, one in ____call_usermodehelper() and one in kthread(), from
setting the cpus_allowed on certain kernel threads to CPU_MASK_ALL, so
that instead these lines set that cpus_allowed to a new mask, a kernel
global variable that can be read and written via the cpuset api.  But
other than that, I don't need anymore kernel hooks than I already have,
and even now, I can get everything that's causing me any grief pinned
into the bootcpuset.


> But that's the problem ... I think there are *always* cpusets that overlap.
> Which is sad (fixable?) because it breaks lots of intelligent things we
> could do. 

So with my bootcpuset, the problem is reduced, to a few tasks per CPU,
such as the migration threads, which must remain pinned on their one CPU
(or perhaps on just the CPUs local to one Memory Node).  These tasks
remain in the root cpuset, which by the scheme we're contemplating,
doesn't get a sched_domain in the fancier configurations.

Yup - you're right - these tasks will also want the scheduler to give
them CPU time when they need it.  Hmmm ... logically this violates our
nice schemes, but seems that we are down to such a small exception case
that there must be some primitive way to workaround this.

We basically need to keep a list of the 4 or 5 per-cpu kernel threads,
and whenever we repartition the sched_domains, make sure that each such
kernel thread is bound to whatever sched_domain happens to be covering
that cpu.  If we just wrote the code, and quit trying to find a grand
unifying theory to explain it consistently with the rest of our design,
it would probably work just fine.

The cpuset code would have to be careful, when it came time to list the
tasks attached to a cpuset (Workload Manager software is fond of this
call) _not_ to list these indigenous (not "migrant" !) worker threads.
And when listing the tasks in the root cpuset, _do_ include them.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
