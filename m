Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUJCPlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUJCPlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 11:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUJCPlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 11:41:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:235 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267548AbUJCPli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 11:41:38 -0400
Date: Sun, 3 Oct 2004 08:39:36 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041003083936.7c844ec3.pj@sgi.com>
In-Reply-To: <821020000.1096814205@[10.10.2.4]>
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
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> Matt had proposed having a separate sched_domain tree for each cpuset, which
> made a lot of sense, but seemed harder to do in practice because "exclusive"
> in cpusets doesn't really mean exclusive at all.

See my comments on this from yesterday on this thread.

I suspect we don't want a distinct sched_domain for each cpuset, but
rather a sched_domain for each of several entire subtrees of the cpuset
hierarchy, such that every CPU is in exactly one such sched domain, even
though it be in several cpusets in that sched_domain.  Perhaps each
cpuset in such a subtree points to the same reference counted
sched_domain, or perhaps each cpuset except the one at the root of the
subtree has a flag set, telling the scheduler to search up the cpuset
tree to find a sched_domain.  Probably the former, for performance
reasons.

As I can see even my own eyes glazing over trying to read what I just
wrote, let me give an example.

Let's say we have a 256 CPU system.  At the top level, we divide it into
five non-overlapping cpusets, of sizes 64, 64, 32, 28 and 4.  Each of
these five cpusets has its sched_domain, except the third one, of 32 CPUs.
That one is subdivided into 4 cpusets, of 8 CPUs each, non-overlapping,
each of the four with its own sched_domain.

[Aside - granted this is topologically equivalent to the flattened
partitioning into the eight cpusets of sizes 64, 64, 8, 8, 8, 8, 28 and
4.  Perhaps the 32 CPUs were farmed out to the Professor of Eccentric
Economics, who has permission to manage his 32 CPUs and divide them
further, but who lacks permission to modify the top layer of the cpuset
hierarchy.]

So we have eight cpusets, non-overlapping and covering the entire
system, each with its own sched_domain.  Now within those cpusets,
for various application reasons, further subdivisions occur.  But
no more sched_domains are created, and the existing sched_domains
apply to all tasks attached to any cpuset in their cpuset subtree.

On the other topic you raise, of the meaning (or lack thereof) of
"exclusive".  Perhaps "exclusive" should not a property of a node in
this tree, but rather a property of a node under a certain covering or
mapping.  You note we need a map from the range of CPUs to the domain
sched_domain's, specifying for each CPU its unique sched_domain.  And we
might have some other map on these same CPUs or Memory Nodes for other
purposes.  I am afraid I've forgotten too much of my math from long long
ago to state this with exactly the right terms.  But I can imagine
adding a little bit more code to cpusets, that kept a small list of such
mappings over the domains of CPUs and Memory Nodes, and that validated,
on each cpuset change, that each mapping preserved whatever properties
of covering and non-overlapping that it was marked for.  One of these
mappings could be into the range of sched_domains and be marked for both
covering and non-overlapping.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
