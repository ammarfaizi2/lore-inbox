Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVCSBZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVCSBZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 20:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVCSBZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 20:25:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:57301 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261616AbVCSBZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 20:25:34 -0500
Subject: Re: Real-life pci errors (Was: Re: PCI Error Recovery API
	Proposal. (WAS:: [PATCH/RFC]PCIErrorRecovery)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       Paul Mackerras <paulus@samba.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, ak@muc.de,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050319003532.GS498@austin.ibm.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024081326E8@orsmsx404.amr.corp.intel.com>
	 <20050318181005.GA30909@colo.lackof.org> <1111187582.1236.192.camel@gaston>
	 <20050319003532.GS498@austin.ibm.com>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 12:24:07 +1100
Message-Id: <1111195447.25179.205.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 18:35 -0600, Linas Vepstas wrote:
> On Sat, Mar 19, 2005 at 10:13:02AM +1100, Benjamin Herrenschmidt was heard to remark:
> > 
> > Additionally, in "real life", very few errors are cause by known errata.
> > If the drivers know about the errata, they usually already work around
> > them. Afaik, most of the errors are caused by transcient conditions on
> > the bus or the device, like a bit beeing flipped, or thermal
> > conditions... 
> 
> 
> Heh. Let me describe "real life" a bit more accurately.
> 
> We've been running with pci error detection enabled here for the last
> two years.  Based on this experience, the ballpark figures are:
> 
> 90% of all detected errors were device driver bugs coupled to 
>     pci card hardware errata

Well, this have been in-lab testing to fight driver bugs/errata on early
rlease kernels, I'm talking about the context of a released solution
with stable drivers/hw.

> 9% poorly seated pci cards (remove/reseat will make problem go away)
> 
> 1% transient/other.

Ok.

> We've seen *EVERY* and I mean *EVERY* device driver that we've put
> under stress tests (e.g. peak i/o rates for > 72 hours, e.g. 
> massive tcp/nfs traffic, massive disk i/o traffic, etc), *EVERY*
> driver tripped on an EEH error detect that was traced back to 
> a device driver bug.  Not to blame the drivers, a lot of these
> were related to pci card hardware/foirmware bugs.  For example, 
> I think grepping for "split completion" and "NAPI" in the 
> patches/errata for e100 and e1000 for the last year will reveal 
> some of the stuff that was found.  As far as I know,
> for every bug found, a patch made it into mainline.

Yah, those are a pain. But then, it isn't the context described by
Nguyen where the driver "knows" about the errata and how to recover.
It's the context of a bug where the driver does not know what's going on
and/or doesn't have the proper workaround. My point was more that there
are very few cases where a driver will have to do recovery of PCI error
in known cases where it actually expect an error to happen.

> As a rule, it seems that finding these device driver bugs was
> very hard; we had some people work on these for months, and in 
> the case of the e1000, we managed to get Intel engineers to fly
> out here and stare at PCI bus traces for a few days.  (Thanks Intel!)
> Ditto for Emulex.  For ipr, we had inhouse people.
> 
> So overall, PCI error detection did have the expected effect 
> (protecting the kernel from corruption, e.g. due to DMA's going 
> to wild addresses), but I don't think anybody expected that the
> vast majority would be software/hardware bugs, instead of transient 
> effects.
> 
> What's ironic in all of this is that by adding error recovery,
> device driver bugs will be able to hide more effectively ... 
> if there's a pci bus error due to a driver bug, the pci card
> will get rebooted, the kernel will burp for 3 seconds, and 
> things will keep going, and most sysadmins won't notice or 
> won't care.

Yes, but it will be logged at least, so we'll spot a lot of these during
our tests.

Ben.


