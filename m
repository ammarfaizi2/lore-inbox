Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbTJJTCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTJJTCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:02:46 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:42882
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263119AbTJJTCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:02:43 -0400
Date: Fri, 10 Oct 2003 15:01:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Tim Hockin <thockin@hockin.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>, G?bor L?n?rt <lgb@lgb.hu>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Fabian.Frederick@prov-liege.be
Subject: Re: 2.7 thoughts
Message-ID: <Pine.LNX.4.53.0310101459110.15705@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003, William Lee Irwin III wrote:

> On Fri, Oct 10, 2003 at 07:47:23AM -0700, William Lee Irwin III wrote:
> >> You need at least enough warning to get out of critical sections (e.g.
> >> holding a spinlock) and dump registers out to memory. i.e. as long as it
> >> takes to schedule out whatever's currently running on the thing.
> 
> On Fri, Oct 10, 2003 at 11:03:20AM -0700, Tim Hockin wrote:
> > I've got a patch against RedHat's 2.4.x kernel with some version of O(1)
> > scheduler that migrates all processes off a CPU and makes it ineleigible to
> > run new tasks.  When the syscall returns, it is safe to remove the CPU.
> > Processes that are running or sleeping and can be migrated elsewhere are
> > migrated.  Running processes that have set_cpus_allowed to ONLY the
> > processor in question are marked TASK_UNRUNNABLE and moved off the runqueue.
> > Sleeping processes that have set_cpus_allowed to ONLY the processor in
> > question are left unmolested until they wake up, at which point they will be
> > marked UNRUNNABLE.
> > It was done to allow software to bring CPUs on/offline, but it should work
> > for this.  IRQs not done yet, either.
> 
> I think there is some generalized cpu hotplug stuff that's gone in that
> direction already, though I don't know any details. The bits about non-
> cooperative offlining were very interesting to hear, though.

The task migration is one of the easier bits, there is a hive of other 
problems which crop up in the various subsystems, the current patchset 
does very well however, Tim perhaps you'd like to help out? 

For interrupts we simple set interrupt affinity mask on the interrupt 
controller whilst the processor is still online, quiesce, 
local_irq_disable. The wait period is to make sure that interrupts which 
are already queued get handled before we completely disable interrupt 
processing, although it could do with some verification to make sure 
there aren't any lingering vectors.
