Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTEENIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTEENIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:08:10 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:33928 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S262175AbTEENID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:08:03 -0400
Subject: Kernel hot-swap using Kexec, BProc and CC/SMP Clusters.
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Larry McVoy <lm@bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052140733.2163.93.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 05 May 2003 07:18:55 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This posting was sent yesterday but had a forbidden subject line,
borrowed from a Jonathan Swift short story (A Modest Proposal).  Here it
is again, with apologies to those on the cc list for the duplicate.

The subject of loading a new kernel without restarting surfaces from
time to time and has come up again on linux-kernel,
http://marc.theaimsgroup.com/?l=linux-kernel&m=105198997207784&w=2
so here are my thoughts on the matter.  Comments, alternatives and
reasons why this can't or shouldn't be done are all welcome.  Especially
comments about how this could or should be done differently.

Here is yet another road-map for changing the kernel on a machine while
minimizing the disruption to user processes.  This method has the
advantage that all of the major pieces here have either been proposed or
are in various stages of development.  However, the glue that holds it
all together does not yet exist in any form, as far as I am aware. At
least the major pieces all have merits of their own, regardless of
whether they are used together as described here.

Some disclaimers up front:  This may be over-engineered, not possible,
or just a horrible way to accomplish something no one really needs. 
This method would only work on a two-way or greater SMP box, and may not
be feasible on 32-bit arches due to the difficulty (or impossibility) of
squeezing more than one kernel into ZONE_NORMAL at the same time,
although it's possible that techniques relevant to using very large
amounts of memory (like page clustering on NUMA) could be adapted to
come to the rescue here.  Piece C) may be much easier on 64-bit arches
for that reason, and hopefully 32-bit systems will take the place of
16-bit systems in our vague memories before the decade is out.  Better
to plan ahead now.

The major pieces are:

A) Kexec, now in 2.5.68-mm4.  Kexec provides a way of Linux loading
Linux.  The relieving hot-swap kernel might be given command line
arguments to come up not tweaking/probing any hardware and to not run
init. Information normally gained from hardware probes would be made
available from the still running old kernel (or designated leader in the
case of multiple old kernels on multiple nodes).  The new kernel might
be told on which CPU or set of CPUs on which to boot, or there might be
some way for the appropriate CPU or set of CPUs to be reliably detected.

B) BProc, implemented for 2.4 but not in mainline and not yet ported to
2.5.  Beowulf Distributed Process Space (BProc) is described here:
http://bproc.sourceforge.net/  and is used to manage this 1024-node
machine: http://www.lanl.gov/projects/pink/ which is located a few miles
down the road from where I work on much more pedestrian projects. In
addition to managing user processes across machines in a traditional
cluster, perhaps this could be developed to manage processes across
nodes in a CC-cluster (and to transfer the functionality of the Master
BProc Node to another), which brings us to C).

C) Cache coherent clustering proposed by Larry McVoy, described here:
http://www.bitmover.com/ml/slide01.html and rather long threads
on linux-kernel start here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100751282125562&w=2 and
http://marc.theaimsgroup.com/?l=linux-kernel&m=100752000911911&w=2

This was proposed as a way to scale Linux to machines with large numbers
of CPUs.  With advances in multiple chip on die and more extreme
hyper-threading, Linux may some day have to deal with, for example, a
512 CPU system.  Think of a CC-cluster of 32 nodes of 16 CPUs each, with
a separate kernel running each node. Obviously, there are many very
difficult issues (like how the kernels interact and don't interfere with
one another over i/o buses, etc) to be solved, so this piece is nowhere
near being implemented, at least as far as I know.  Many major problems
with this have been pointed out before, so this could turn out to be
infeasible.  I hope that is not the case. The degenerate case is a
two-way box with separate kernels on each CPU.

Putting these three pieces together, we could hot-swap the kernel, with
user processes being minimally affected and external connections perhaps
not even noticing.

For the simplest case of a dual-CPU box:

1) One of the CPUs is halted and declared unavailable.  The user
processes now have only one CPU on which to run, but this disruption
will be temporary.

2) Using Kexec, the new kernel is booted by the old kernel on the halted
CPU, with command line arguments to come up in a relieving mode, not
probing hardware, not running init, getting necessary hardware
configuration details from the old kernel.  The new kernel also has to
come up shoe-horned into the same space as the old kernel in a
CC-cluster mode (this is the acknowledged really hard part again).

3) Once up as a separate and autonomous kernel, the new kernel checks to
see that it is properly configured for the hardware which it has just
been told about and presents its qualifications to the old kernel.  If
it passes these tests, the old kernel uses BProc to transfer all user
processes to the new kernel.  A human analog for this exists in the
formal transfer of authority between the on-coming and off-going officer
of the deck on a naval vessel:

New kernel: "I am ready to relieve you" 
	(After assessing the situation. This would include
	determining  which file systems and drivers were needed, which
	modules need to be loaded, etc. and perhaps which daemons
	need to be running prior to user process transfer)

Old kernel: "I am ready to be relieved" 
        (After assessing the relief's ability to take over. Same
	as above, but a double check on the new kernel's configuration. 
	If either of these two steps fail, the kernel-swap is aborted,
	the old kernel tells the new kernel to shutdown and takes back
	control of the halted CPU.)

New kernel: "I relieve you"
        (user processes and daemons are now transferred with BProc)

Old kernel: "I stand relieved"
        (all user processes are verified to be successfully transferred)

Now the old kernel can exit (or be told to shutdown properly). 

4) The new kernel assimilates the CPU on which the old kernel was
running (resistance is futile), marks it as available and user processes
and then new kernel can now be scheduled on it.  The hot-swap of kernels
is now complete and for this simple case, the system is back to a
regular single SMP kernel. The CC-cluster configuration was just an
intermediate step.

Since the new kernel doesn't have to probe any hardware, this hot-swap
could in principle be very fast, so the time that the system's
capability is degraded could be very short, on the order of a few
seconds or less.  For a 2-CPU system, this temporary degradation would
be at least 50%.  For the extreme case of the 512 CPU system with 32
nodes, the new kernels could be brought up on one node at at time, so
the degradation might be as little as 1/32 or 3%.

The interfaces for doing all this should probably remain stable during a
major release cycle, so that any properly configured 2.8.x kernel would
be able to hot-swap with any other properly configured 2.8.x kernel. 
The earliest that this could be done is 2.7.something, but perhaps even
later, judging from all the problems identified in the cc/smp cluster
threads.

Perhaps a brief note about why a kernel hot-swap is even desired might
be in order here.  As systems become more and more complex (and
therefore important), their boot times seem to increase.  My experience
with production systems is that taking them down for even a short time
can be hard to schedule.  Rebooting for a needed upgrade with even a
well-tested vendor-kernel is a hard sell sometimes.  Yes, I know that
these are issues which are orthogonal to this discussion, but having the
ability to install a new kernel with almost no disruption to the
customer could be worth it for some customers.

Simpler and easier strategies for almost accomplishing a hot-swap
involving user process check-pointing have been suggested, but those
involve a short duration halting of the system.  If the gain of a
no-halt hot-swap is worth the considerable pain, then perhaps this
road-map is worth investigating further.

If you made it this far, thanks in advance for reading this to the end.

Steven



