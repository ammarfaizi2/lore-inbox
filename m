Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTJCMku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 08:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTJCMku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 08:40:50 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:47834 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263732AbTJCMkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 08:40:45 -0400
To: Andreas Hauser <andy-lkml@splashground.de>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       xen-devel@lists.sourceforge.net, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
In-reply-to: Your message of "Fri, 03 Oct 2003 13:53:55 +0200."
             <20031003115355.GA16436@splashground.de> 
Date: Fri, 03 Oct 2003 13:40:44 +0100
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1A5PEi-0000Jv-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was more thinking of running Xen on one node of a cluster,
> using it as the management tool.
> Each user gets his own VM on the master node,
> and can only access that.
> A real value would be if one could use the
> cluster resources from within a e.g. freebsd guest.
> 
> So the question would be, can the processes of the
> guest OS be migrated to to other nodes?
> (openmosix can only migrate the userspace part of a process)

Suspend/resume migration of guest OSes is on the "todo" list. Its
not hard, but we haven't gotten around to it.

See below for my reply to Jacob Gorm Hansen as to what needs
doing. Jacob did the NomadBIOS work, which is cool stuff, and has
many similar issues to suspend/resume in Xen.

Cheers,
Ian

---

> last year myself and a friend implemented the NomadBIOS system, a
> microkernel-based project similar in ambition to Xen, but with the
> ability to migrate guests quickly between host-machines. 
> 
> Do you plan to implement guest migration in Xen, or do you see any
> reasons why it might be difficult to do?

It's on our list of things to do, but haven't quiet got around to.

Our plan is to have the code that does the suspend/resume run in
domain 0 (the privileged domain), where it can memory map the
physical memory of other domains to read/write, and has easy
access to the disk/network etc.

The one complication with doing this on Xen is that since we
deliberately expose real resources, it's likely that the set of
physical 'machine' pages available to the domain when it is
resumed will be different from when it was suspended.

Hence, we need to re-write the OS's page tables to reflect the
change. This is actually quite straight forward since Xen already
needs to track which pages contain page directories/tables.

However, it's also necessary to update the OS's "mem_map"
structure (or equivalent) to reflect the new 'physical' to
'machine' page mapping.  This is obviously highly OS specific. We
could do this with a simple stub function in the OS, or we could
make the domain0 'resume' program OS specific. We haven't decided
which approach we prefer.  Having some some limited co-operation
from the guest OS in suspend/resume is quite sensible anyway, as
you need it to rerun DHCP etc anyway.

We'd probably modify the guest OS to cause it to evict the entire
buffer cache before asking for a suspend, to minimize the state.

Volunteers welcome ;-)

Cheers,
Ian
