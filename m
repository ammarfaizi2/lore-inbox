Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUEGUjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUEGUjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUEGUiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:38:21 -0400
Received: from zero.aec.at ([193.170.194.10]:39950 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263731AbUEGUhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:37:47 -0400
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
References: <1TfLX-4M4-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 07 May 2004 21:10:58 +0200
In-Reply-To: <1TfLX-4M4-9@gated-at.bofh.it> (Keiichiro Tokunaga's message of
 "Fri, 07 May 2004 17:50:09 +0200")
Message-ID: <m34qqshx31.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com> writes:

Hallo,
>
> Where, "node" is a container device that contains CPU, memory,
> and/or I/O devices.  The definition of "node" is different from one
> of "NUMA node".

This does not really fit well into the Linux/Unix philosophy to do one thing
with one mechanism and do it well, and keep policy in user space.

Better would be to do individual mechanisms to hot plug these various
things; and if you feel the need to combine them e.g. for administrative
purposes do this in user space.


> Why?
> ====
> Someone might think like "Why don't we invoke CPU, memory, IO
> hotplug individually without node hotplug?".  However, CPU, 
> memory, and IO hotplug cannot remove a node (container device)
> from the system physically.  That's a node hotplug's job.  Also,

You can remove them physically as soon as all the hardware
in it is removed. There can be many more things than you listed
anyways on such a "node"; lprocesses which are bound to the CPU 
of the node (which need to be killed) or device drivers bound 
to slots on the node (which need to be shutdown). I do not think it 
makes much sense to attempt to combine all these at kernel level; 
that is more a job for a shell script. The bad experience with
the current sysfs power management hierarchy shows that the kernel
is a poor place to attempt this.

> when hotplug request occurs on a node, node hotplug searchs
> resouces on the node, and invokes CPU, memory, and IO hotplug
> in proper order.   Actually, the order is very important.  For instance,
> when hot-adding a NUMA node, memory should be added first
> so that CPUs could allocate data in the memory while the CPUs is
> being added.  Otherwise, CPUs need to allocate it in other memory
> on other node.  This might cause performance issue.

This order can be also easily done in user space.

This has the advantage that if there is some reason to 
add CPUs without memory (or memory without CPUs or PCI slots 
without anything) it will just work too. It is not clear
that your "lump everything mechanism into one" can handle all
that. Most likely you would need to add lots of special
cases to it to handle all this. Separate mechanisms can
do this cleaner.

Admittedly there would still need to be some coordination in case you
would want to remove a whole building block of your machine like 
you said. An nice way to do this would be to add an atomic "to be removed"
state to the individual unregister mechanisms that prevents the 
device from being reregistered until removed.

> Design
> ======
> ACPI is used to do some hardware manipulation.

That will not work as a portable mechanism. Most linux ports 
including some that support NUMA and hotplug do not have ACPI.

Rather you could do an layer to do this which is implemented
in the architecture. Then all ACPi supporting architectures could
use a common implementation and the other architectures their own.
The design of this layer would need some discussion first to
make sure it does not have too many assumptions from your 
system that would not hold on others.

-Andi

