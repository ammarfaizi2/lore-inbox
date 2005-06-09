Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVFIOLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVFIOLk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 10:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVFIOLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 10:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:51851 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262402AbVFIOLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 10:11:36 -0400
Date: Thu, 9 Jun 2005 16:11:34 +0200
From: Andi Kleen <ak@suse.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <ak@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050609141134.GE23831@wotan.suse.de>
References: <20050608133226.GR23831@wotan.suse.de> <20050608090944.A4147@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608090944.A4147@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 09:09:44AM -0700, Ashok Raj wrote:
> On Wed, Jun 08, 2005 at 06:32:26AM -0700, Andi Kleen wrote:
> > 
> >    > I also see one minor weakness in the assumption that CPU Vectors
> >    > are global. Both IA64/PARISC can support per-CPU Vector tables.
> 
> One thing to keep in mind is that since now we have support for CPU hotplug
> we need to factor in cases when cpu is removed, the per-cpu vectors would
> require migrating to a new cpu far interrupt target. Which would 
> possibly require vector-sharing support as well in case the vector is used 
> in all other cpus.


Yes, it would need require vector migration. I suppose the way to 
do this would be to not offline a CPU as long as there are devices
that have interrupts refering to a CPU. And perhaps have some /sys
file that prevents allocating new vectors to a specific CPU.

User space could then do:

	Set sys file to prevent new vectors allocated to cpu FOO
	Read /proc/interrupts and unload all drivers who have vectors on CPU foo.
	Reload drivers. 
	Offline CPU.


BTW I suppose in many machines the problem would not occur
because they do hotplug not on inidividual CPUs, but nodes
which consist of CPUs,PCI busses etc.  On those you could
fully avoid it by just making sure the devices on the PCI
busses of a node only allocate interrupts on the local CPUs.
Then to off line you would need to hot unplug the devices
before offlining the CPUs anyways.
>From a NUMA optimization perspective that is a worthy
goal anyways to avoid cross node traffic.
	
	
> 
> Possibly irq balancer might need to be revisited as well, and potentially
> might trigger some sharing needs.

IRQ balancer is in user space on x86-64.

> A combination of 
>  - Not allocating IRQs to pins not used (Which Natalie from Unisys
>    submitted) 
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=111656957923038&w=2

That is already queued, but doesnt help in the general case.

>  - per-cpu vector tables (long back i remember seeing some post from sgi
>    on the topic, possibly under intr domains etc.. not too sure)

That is the plan.

>  - vector sharing

That doesnt help in the general case again I think.

e.g. to fully cover offlining of all CPus you would need to 
share all vectors over all CPUs of all devices. But that totally
defeats the original goal to get more than 255 vectors.

-Andi
