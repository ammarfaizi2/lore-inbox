Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUJGT6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUJGT6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUJGT6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:58:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59851 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268043AbUJGTyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:54:47 -0400
Date: Thu, 7 Oct 2004 12:52:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@aracnet.com, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041007125237.767e3a26.pj@sgi.com>
In-Reply-To: <20041007112531.674413f1.akpm@osdl.org>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	<58780000.1097004886@flay>
	<20041005172808.64d3cc2b.pj@sgi.com>
	<1193270000.1097025361@[10.10.2.4]>
	<20041005190852.7b1fd5b5.pj@sgi.com>
	<1097103580.4907.84.camel@arrakis>
	<20041007015107.53d191d4.pj@sgi.com>
	<Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>
	<1250810000.1097160595@[10.10.2.4]>
	<20041007105425.02e26dd8.pj@sgi.com>
	<20041007112531.674413f1.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> I'd be interested to know why this all cannot be done by a
> userspace daemon/server thing.

The biggest stumbling block was the binding of task to cpuset, the
task->cpuset pointer.  I doubt you would accept a patch to the kernel
that called out to my daemon on every fork and exit, to update this
binding.  We require a robust answer to the question of which tasks are
in a cpuset.  And the loop to read this back out, which scans each task
to see if it points to a particular cpuset, would be significantly less
atomic than it is now, if it had to be done, one task at a time, from
user space.

A second stumbling block, which perhaps you can recommend some way to
deal with, is permissions.  What's the recommended way for this daemon
to verify the authority of the requesting process?

Also the other means to poke the affinity masks, sched_setaffinity,
mbind and set_mempolicy, need to be constrained to respect cpuset
boundaries and honor exclusion.  I doubt you want them calling out to a
user daemon either.

And the memory affinity mask, mems_allowed, seems to require updating
within the current task context.  Perhaps someone else is smart enough
to see an alternative, but I could not find a safe way to update this
from outside the current context.  So it's updated on the path going
into __alloc_pages().  I doubt you want a patch that calls out to my
daemon on each call into __alloc_pages().

We also need to begin correct placement earlier in the boot process
than when a user daemon could start.  It's important to get init
and the early shared libraries placed.  This part has reasons of
its own to be pre-init.  I am able to do this in user space today,
because the kernel has cpuset support, but I'd have to fold at
least this much back into the kernel otherwise.

And of course the hooks I added to __alloc_pages, to only allow
allocations from nodes in the tasks mems_allowed, would still be needed,
in some form, just as the already existing schedulers check for
cpus_allowed are needed, in some form (perhaps less blunt).

The hook in the sched code to offline a cpu needs to know what else is
allowed in a tasks cpuset so it can honor the cpuset boundary, if
possible, when migrating the task off the departing cpu.  Would you want
this code calling out to a user daemon to determine what cpu to use
next?

The cpuset file system seems like an excellent way to present a system
wide hierarchical name space.  I guess that this could be done as a
mount handled by my user space daemon, but using vfs for this sure
seemed sweet at the time.

There's a Linus quote I'm trying to remember ... something about while
kernels have an important role in providing hardware access, their
biggest job is in providing a coherent view of system wide resources. 
Does this ring a bell?  I haven't been able to recall enough of the
actual wording to google it.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
