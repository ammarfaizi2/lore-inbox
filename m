Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUJBTRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUJBTRw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 15:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUJBTRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 15:17:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45957 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267515AbUJBTRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 15:17:48 -0400
Date: Sat, 2 Oct 2004 12:14:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041002121430.3c99c833.pj@sgi.com>
In-Reply-To: <415EF069.7090902@watson.ibm.com>
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
	<415ED4A4.1090001@watson.ibm.com>
	<20041002105305.2caf97ae.pj@sgi.com>
	<415EF069.7090902@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus wrote:
> 
> A minimal quote from your website :-)

Ok - now I see what you're saying.

Let me expound a bit on this line, from a different perspective.

While big NUMA boxes provide the largest available single system image
boxes available currently, they have their complications.  The bus and
cache structures and geometry are complex and multilayered.

For more modest, more homogenous systems, one can benefit from putting
CKRM controllers (I hope I'm using this term correctly here) on things
like memory pages, cpu cycles, disk i/o, and network i/o in order to
provide a fairly rich degree of control over what share of resources
each application class receives, and obtain both efficient and
controlled balance of resource usage.

But for the big NUMA configuration, running some of our customers most
performance critical applications, one cannot achieve the desired
performance by trying to control all the layers of cache and bus, in
complex geometries, with their various interactions.

So instead one ends up using an orthogonal (thanks, Hubertus) and
simpler mechanism - physical isolation(*).  These nodes, and all their
associated hardware, are dedicated to the sole use of this critical
application.  There is still sometimes non-trivial work done, for a
given application, to tune its performance, but by removing (well, at
least radically reducing) the interactions of other unknown applications
on the same hardware resources, the tuning of the critical application
now becomes a practical, solvable task.

In corporate organizations, this resembles the difference between having
separate divisions with their own P&L statements, kept at arms length
for all but a few common corporate services [cpusets], versus the more
dynamic trade-offs made within a single division, moving limited
resources back and forth in order to meet changing and sometimes
conflicting objectives in accordance with the priorities dictated by
upper management [CKRM].

 (*) Well, not physical isolation in the sense of unplugging the
     interconnect cables.  Rather logical isolation of big chunks
     of the physical hardware.  And not pure 100% isolation, as
     would come from running separate kernel images, but minimal
     controlled isolation, with the ability to keep out anything
     that causes interference if it doesn't need to be there, on
     those particular CPUs and Memory Nodes.

     And our customers _do_ want to manage these logically isolated
     chunks as named "virtual computers" with system managed permissions
     and integrity (such as the system-wide attribute of "Exclusive"
     ownership of a CPU or Memory by one cpuset, and a robust ability
     to list all tasks currently in a cpuset).  This is a genuine user
     requirement to my understanding, apparently contrary to Andrew's.

The above is not the only use of cpusets - there's also providing
a base for ports of PBS and LSF workload managers (which if I recall
correctly arose from earlier HPC environments similar to the one
I described above), and there's the work being done by Bull and NEC,
which can better be spoken to by representives of those companies.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
