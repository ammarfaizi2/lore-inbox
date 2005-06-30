Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbVF3VQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbVF3VQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 17:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbVF3VPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 17:15:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:26078 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263035AbVF3VHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 17:07:55 -0400
Date: Thu, 30 Jun 2005 16:07:48 -0500
To: Andi Kleen <ak@muc.de>, sfr@canb.auug.org.au
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com,
       linux-laptop@vger.kernel.org, mochel@transmeta.com, pavel@suse.cz
Subject: Re: PCI Power management (was: Re: [PATCH 4/13]: PCI Err: e100 ethernet driver recovery
Message-ID: <20050630210748.GZ28499@austin.ibm.com>
References: <20050628235848.GA6376@austin.ibm.com> <1120009619.5133.228.camel@gaston> <20050629155954.GH28499@austin.ibm.com> <20050629165828.GA73550@muc.de> <20050630203931.GY28499@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630203931.GY28499@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hm,

Scratch the idea I outline below, seems like its not a good idea.

I'm reading the e100, e1000 and the ixgb power management code, and they
go through all sorts of steps I don't need to do for PCI device reset.
There's no clear abstraction that would serve both needs.

On Thu, Jun 30, 2005 at 03:39:31PM -0500, Linas Vepstas was heard to remark:
> On Wed, Jun 29, 2005 at 06:58:29PM +0200, Andi Kleen was heard to remark:
> > > Yep, OK. Pushig the timer would in fact break if the device was marked
> > > perm disabled.
> > 
> > I think for network drivers you should just write a generic error handler
> > (perhaps in net/core/dev.c) that calls the watchdog handler. 
> > Then all drivers could be easily converted without much code duplication.
> 
> Well, there's no watchdog per-se in "struct net_device" -- are you
> suggesting I add one?
> 
> It looks like I can almost create generic handlers for net devices; 
> looks like calling netdev->stop() is enough to handle the error
> detection. 
> 
> However, a generic bringup would need to call pci_enable_device(), 
> and net/core/dev.c does not include pci.h so I can't really do it 
> there.  Other than that, a generic recovry routine looks like it might
> be possible; I'll have to experiment; its hard to tell by reading code.
> 
> This might be the wrong paradigm, though.  The pci error recovery 
> routines are *almost identical* to the power-management suspend/resume
> routines.  From what I can tell, the only real difference is that 
> I want to not actually turn off/on the power. 
> 
> Thus, the right thing to do might be to split up the 
> struct pci_dev->suspend() and pci_dev->resume() calls into
> 
>    suspend()
>    poweroff()
>    poweron()
>    resume()
> 
> and then have the generic pci error recovery routines call
> suspend/resume only, skipping the poweroff-on calls.  Does that 
> sound good?
> 
> I'm not sure I can pull this off without having someone from 
> the power-management world throw a brick at me.
> 
> --linas
> 
> 
