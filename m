Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUHFIfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUHFIfB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268050AbUHFIei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:34:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62882 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268100AbUHFIci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:32:38 -0400
Date: Fri, 6 Aug 2004 01:31:59 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@osdl.org, hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de,
       lse-tech@lists.sourceforge.net, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20040806013159.7507e926.pj@sgi.com>
In-Reply-To: <247790000.1091762644@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805101038.3740.52850.89920@sam.engr.sgi.com>
	<256150000.1091739330@flay>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> Sorry, it's just a little difficult to dive into a large
> patch without a higher level idea ...

No need to apologize.  I welcome your review.  I was well aware that the
next step for this patch was the "why would I want this ..." explanation.
Let me know if there is more I can explain.


> I don't think the kernel should have to deal with that
> [cpu and node number virtualization] stuff.

I agree, now.


> The other thing that seems to glare at me is the overlap
> between what you have here and PAGG/CKRM.  Does
> either cpusets depend on PAGG/CKRM or vice versa? 

None of these three, cpusets, PAGG or CKRM depend on the other, with the
possible exception that perhaps CKRM could make use of PAGG (whether it
does or not, or whether it should, I don't know - ask them).

Cpusets control _where_ a process can run and allocate.  The central
construct of cpusets is essentially a "soft partition" -- a set of CPUs
and Memory Nodes.  These can be arranged in a hierarchy, with names,
permissions, a couple of control bits.  Tasks can be moved between
cpusets, as allowed by the permission model.  You can attach a task to a
different cpuset if (1) you can access that cpuset (search permission to
some directory beneath /dev/cpuset), (2) write that cpusets "tasks"
file, and (3) have essentially kill rights on the task being placed.

Just as your basic file system provides a hierarchical model for
organizing your data files (places to put data), similarly cpusets
provides a hierarchical model for organizing the nodes on your big numa
box (places to run tasks).

CKRM tracks _how_ much of various interesting resouces tasks are using,
both measuring and limiting such usage.  It provides a way to manage
some of the shared system resources, such as CPU time, memory pages, I/O
and incoming network bandwith based on user defined groups of tasks
called classes (quoting from http://ckrm.sourceforge.net/ ;).  Unlike
cpusets and most of the rest of the kernel, CKRM doesn't just manage
individual tasks, one task at a time, but manages based on a dynamically
determined resource class it assigns to various kernel objects in
addition to tasks.

Cpusets provides a rich model of just the CPU and Memory resources, but
only manages tasks, using the traditional simple task pointer to a
shared reference counted object.

CKRM provides a rich structure for classifying a variety of kernel
objects, not just tasks, and managing their use, but it doesn't have a
particularly fancy model of any one of these resources (so far as I
know anyway ...).

PAGG is a just a mechanism that is useful for job accouting and resource
management.  It's just the hooks - for an inescapable job container and
hooks for loadable modules to be called on key events in the life of
tasks in that container, such as fork and exit.  PAGG provides a useful
mechanism for certain kinds of resource management and system accounting
modules, but is itself not a resource manager.

Hopefully, I haven't misrepresented CKRM and PAGG too much.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
