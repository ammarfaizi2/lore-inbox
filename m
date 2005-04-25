Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVDYX1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVDYX1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVDYX1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:27:37 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:25770 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261227AbVDYX1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:27:22 -0400
Date: Mon, 25 Apr 2005 19:23:31 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, alexn@dsv.su.se, greg@kroah.com,
       gud@eth.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
       cramerj@intel.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425232330.GG27771@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Alan Stern <stern@rowland.harvard.edu>, alexn@dsv.su.se,
	greg@kroah.com, gud@eth.net, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
	cramerj@intel.com, linux-usb-devel@lists.sourceforge.net
References: <1114458325.983.17.camel@localhost.localdomain> <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org> <20050425145831.48f27edb.akpm@osdl.org> <20050425221326.GC15366@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425221326.GC15366@redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 06:13:27PM -0400, Dave Jones wrote:
> On Mon, Apr 25, 2005 at 02:58:31PM -0700, Andrew Morton wrote:
>  > Alan Stern <stern@rowland.harvard.edu> wrote:
>  > >
>  > > On Mon, 25 Apr 2005, Alexander Nyberg wrote:
>  > > 
>  > > > Not sure what you mean by "make kexec work nicer" but if it is because
>  > > > some devices don't work after a kexec I have some objections.
>  > > 
>  > > That was indeed the reason, at least in my case.  The newly-rebooted
>  > > kernel doesn't work too well when there are active devices, with no driver
>  > > loaded, doing DMA and issuing IRQs because they were never shut down.
>  > 
>  > I have vague memories of this being discussed at some length last year. 
>  > Nothing comprehensive came of it, except that perhaps the kdump code should
>  > spin with irqs off for a couple of seconds so the DMA and IRQs stop.
>  > 
>  > (Ongoing DMA is not a problem actually, because the kdump kernel won't be
>  > using that memory anyway)
> 
> Actually, some cpufreq drivers *should* do their speed transitions with
> all PCI mastering disabled. The lack of any infrastructure to quiesce drivers
> and prevent new DMA transactions from occuring whilst the transition occurs
> means that currently.. we don't.  So +1 for any driver model work that
> may lead to something we can use here.
> 
> This is the main reason the longhaul cpufreq driver is currently busted.
> That it ever worked at all is a miracle.
> 
> 		Dave

I've been considering for a while that, in addition to ->probe and ->remove, we
have the following:

"struct device" -->
->attach - binds to the device and allocates data structures
->probe - detects and sets up the hardware
->start - begins transactions (like DMA)
->stop - stops transactions
->remove - prepares the hardware for no driver control
->detach - frees stuff and unbinds the device

->start and ->stop would be optional, and only used where they apply.

->probe and ->remove would be useful for resource rebalancing

Power management functions could (and usually should) manually call some of
these.  Also this would be useful for error recovery and restarting devices.

Still, cpufreq seems like a difficult problem.  What's to prevent,
hypothetically, an SMP system from stoping a device while the upper class
layer tries to use it.  If the class level locks control of the device, then
DMA can't be stopped.  Also, attempting to stop device activity may fail
if the driver decides it's not possible.

Thanks,
Adam
