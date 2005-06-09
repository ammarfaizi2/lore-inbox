Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVFIQAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVFIQAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVFIQAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:00:38 -0400
Received: from fmr23.intel.com ([143.183.121.15]:23446 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262206AbVFIQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:00:19 -0400
Date: Thu, 9 Jun 2005 08:58:31 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>, Greg KH <gregkh@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050609085831.A14739@unix-os.sc.intel.com>
References: <20050608133226.GR23831@wotan.suse.de> <20050608090944.A4147@unix-os.sc.intel.com> <20050609141134.GE23831@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050609141134.GE23831@wotan.suse.de>; from ak@suse.de on Thu, Jun 09, 2005 at 04:11:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 04:11:34PM +0200, Andi Kleen wrote:
> On Wed, Jun 08, 2005 at 09:09:44AM -0700, Ashok Raj wrote:
> > On Wed, Jun 08, 2005 at 06:32:26AM -0700, Andi Kleen wrote:
> > > 
> > >    > I also see one minor weakness in the assumption that CPU Vectors
> > >    > are global. Both IA64/PARISC can support per-CPU Vector tables.
> > 
> > One thing to keep in mind is that since now we have support for CPU hotplug
> > we need to factor in cases when cpu is removed, the per-cpu vectors would
> > require migrating to a new cpu far interrupt target. Which would 
> > possibly require vector-sharing support as well in case the vector is used 
> > in all other cpus.
> 
> 
> Yes, it would need require vector migration. I suppose the way to 
> do this would be to not offline a CPU as long as there are devices
> that have interrupts refering to a CPU. And perhaps have some /sys
> file that prevents allocating new vectors to a specific CPU.
> 
> User space could then do:
> 
> 	Set sys file to prevent new vectors allocated to cpu FOO
> 	Read /proc/interrupts and unload all drivers who have vectors on CPU foo.
> 	Reload drivers. 
> 	Offline CPU.

Sounds way too complicated approach!

In current scheme we do in fixup_irqs() if a irq is bound to a cpu
we migrate it to another online cpu. 

disable(), reprogram new cpu destination (i.e new vector), and then re-enable

Even for MSI we do this via config cycle access, if set_msi_affinity()
works, then the re-program should work as well.

If you want to unload drivers, then apps would need to stop... this sounds
more like a M$ solution :-(, we are far better off to reboot in that case?
> 
> 
> BTW I suppose in many machines the problem would not occur
> because they do hotplug not on inidividual CPUs, but nodes
> which consist of CPUs,PCI busses etc.  On those you could
> fully avoid it by just making sure the devices on the PCI
> busses of a node only allocate interrupts on the local CPUs.
> Then to off line you would need to hot unplug the devices
> before offlining the CPUs anyways.
> From a NUMA optimization perspective that is a worthy
> goal anyways to avoid cross node traffic.
> 	
>

But if your entire Node needs to be offlined because a failure is happening
and you need to replace that node, you could offline all the cpu's which would
require irqs to go off node anyway until the node is replaced.

If its just a failing cpu, and you want to keep that off execution path, then 
with intr domains, and the 4-cpus in that node forming a domain, 
fixup_irqs() could pick another cpu within the same domain for that irq.

more like what zwane had proposed, but would require reprogramming msi's at
devices anyway. 

> > 
> >    on the topic, possibly under intr domains etc.. not too sure)
> 
> That is the plan.
> 
> >  - vector sharing
> 
> That doesnt help in the general case again I think.
> 
> e.g. to fully cover offlining of all CPus you would need to 
> share all vectors over all CPUs of all devices. But that totally
> defeats the original goal to get more than 255 vectors.

I could be wrong, but the idea is if you end up all vectors are used in
any other domain, then we could use vector sharing. Agreed sharing has 
performance issues, since we would end up sharing IRQS's, and chained intr
calls, but it might be the best you can do for RAS reasons. If downtime
is not preferred. (Longer term, maybe we could have some policy from
user space that could honor such requests and be able to customize..)

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
