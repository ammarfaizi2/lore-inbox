Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264498AbUEJCTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUEJCTa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 22:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbUEJCTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 22:19:30 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:22992 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264498AbUEJCSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 22:18:11 -0400
Date: Mon, 10 May 2004 11:17:22 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
In-reply-to: <m34qqshx31.fsf@averell.firstfloor.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, lhns-devel@lists.sourceforge.net
Message-id: <20040510111722.29524459.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <1TfLX-4M4-9@gated-at.bofh.it>
 <m34qqshx31.fsf@averell.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2004 21:10:58 +0200
Andi Kleen <ak@muc.de> wrote:

> Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com> writes:
> 
> Hallo,
> >
> > Where, "node" is a container device that contains CPU, memory,
> > and/or I/O devices.  The definition of "node" is different from one
> > of "NUMA node".
> 
> This does not really fit well into the Linux/Unix philosophy to do one thing
> with one mechanism and do it well, and keep policy in user space.

Policy could be moved in user space as you mentioned.

> Better would be to do individual mechanisms to hot plug these various
> things; and if you feel the need to combine them e.g. for administrative
> purposes do this in user space.
 
"node hotplug" of LHNS is not just a controller to invoke CPU,
memory, IO hotplug with a policy.  It does hotplug a container
device also.  When a container device is attached to the system,
it should be detected by someone.  Node hotplug (kernel) can do it.

> > Why?
> > ====
> > Someone might think like "Why don't we invoke CPU, memory, IO
> > hotplug individually without node hotplug?".  However, CPU, 
> > memory, and IO hotplug cannot remove a node (container device)
> > from the system physically.  That's a node hotplug's job.  Also,
> 
> You can remove them physically as soon as all the hardware
> in it is removed. There can be many more things than you listed
> anyways on such a "node"; lprocesses which are bound to the CPU 
> of the node (which need to be killed) or device drivers bound 
> to slots on the node (which need to be shutdown). I do not think it 
> makes much sense to attempt to combine all these at kernel level; 
> that is more a job for a shell script. The bad experience with
> the current sysfs power management hierarchy shows that the kernel
> is a poor place to attempt this.

As you mentioned, there can be many more things.  However,
the examples you showed should be handled by individual hotplug.
For instance, the processes bound to a certain CPU should be
handled by CPU hotplug when node hotplug invokes CPU hotplug.
Also, the device drivers bound to slots should be detached by
IO hotplug.  Node hotplug is supposed to take care of a container
device and just invoke individual hotplugs for other devices.
Node hotplug doesn't break any policy of each hotplug (CPU,
memory, IO, etc).

Shell script could handle hot-removal of container hotplug, but
detecting an added container device needs to be done in kernel
level.

> > when hotplug request occurs on a node, node hotplug searchs
> > resouces on the node, and invokes CPU, memory, and IO hotplug
> > in proper order.   Actually, the order is very important.  For instance,
> > when hot-adding a NUMA node, memory should be added first
> > so that CPUs could allocate data in the memory while the CPUs is
> > being added.  Otherwise, CPUs need to allocate it in other memory
> > on other node.  This might cause performance issue.
> 
> This order can be also easily done in user space.

Yes.
 
> This has the advantage that if there is some reason to 
> add CPUs without memory (or memory without CPUs or PCI slots 
> without anything) it will just work too. It is not clear
> that your "lump everything mechanism into one" can handle all
> that. Most likely you would need to add lots of special
> cases to it to handle all this. Separate mechanisms can
> do this cleaner.

Yes. The cases (combination of hardware) would increase.
However, I don't think there would be that many today.

> Admittedly there would still need to be some coordination in case you
> would want to remove a whole building block of your machine like 
> you said. An nice way to do this would be to add an atomic "to be removed"
> state to the individual unregister mechanisms that prevents the 
> device from being reregistered until removed.

I agree.  Actually, I already prepare the "to be removed" state in
node hotplug, it's not used yet though:)  It's also necessary for
individual hotplug as you mentioned.
 
> > Design
> > ======
> > ACPI is used to do some hardware manipulation.
> 
> That will not work as a portable mechanism. Most linux ports 
> including some that support NUMA and hotplug do not have ACPI.
> 
> Rather you could do an layer to do this which is implemented
> in the architecture. Then all ACPi supporting architectures could
> use a common implementation and the other architectures their own.
> The design of this layer would need some discussion first to
> make sure it does not have too many assumptions from your 
> system that would not hold on others.

Are you saying here that platform-independent and dependent
codes should be separated so that the independent part could
be implemented by any other platform (firmware) in their own
style?  If so, I agree and some discussion are necessary :)

Thanks,
Kei
