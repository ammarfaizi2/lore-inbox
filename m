Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWCJUoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWCJUoW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 15:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWCJUoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 15:44:22 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:63981 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S932219AbWCJUoW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 15:44:22 -0500
Message-Id: <441181020200003600001533@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 10 Mar 2006 13:37:06 -0700
From: "Doug Thompson" <dthompson@lnxi.com>
To: <arjan@infradead.org>
Cc: <greg@kroah.com>, <gregkh@kroah.com>,
       <bluesmoke-devel@lists.sourceforge.net>, <dsp@llnl.gov>,
       "Doug Thompson" <dthompson@lnxi.com>, <torvalds@osdl.org>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>,
       <rdunlap@xenotime.net>
Subject: Re: [PATCH] EDAC: core EDAC support code
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 19:33 +0000, Arjan van de Ven  wrote:
> On Fri, 2006-03-10 at 11:07 -0800, Dave Peterson wrote:
> > On Friday 10 March 2006 09:58, Arjan van de Ven wrote:
> > > > I'd be curious to hear people's opinions on the following idea:
> > > > move the PCI bus parity error checking functionality from EDAC
> > > > to the PCI subsystem.
> > >
> > > I can see the point on at least moving all the infrastructure there.
> > > The actual call to run it... maybe. that's more debatable I suppose.
> > 
> > Regarding the actual call to run it, I guess it depends on which of
> > the following you prefer:
> > 
> >     Scenario A
> >     ----------
> >     A more decentralized layout.  Here, the controls that govern the
> >     error handling behavior for a given category of hardware (a
> >     category might be "PCI devices" or "devices that use bus
> >     technology XYZ") are grouped together with other stuff for that
> >     category.
> 

I guess it might be useful to express what the original purpose of EDAC
we (Thayne, Eric, etc) were working toward. Arjan you express it
correctly.

We aimed to develop a central place to report all (or almost all)
hardware errors: starting with ECC errors, then added PCI parity errors.
And to do this in a consistent manner so that harvesting and reaping
that error info can become easier and more useful. (EDAC has a common
printk format as well).

Currently the ownership of that feature is the edac_mc module. It is the
one which creates the /sys/devices/system/edac directory and in turn the
'mc' and 'pci' directories.

When we move the PCI Parity checking code to the PCI subsystem it would
be good to maintain that directory layout. 

One way to do that is to make the edac_mc CORE a part of the kernel and
no longer a module. (This would also help on the kobject reference
counter issue).  Then the PCI Parity subsystem code would register
itself after the EDAC CORE code.

doug t


> this would basically make edac a place to report "help something went to
> the gutter". Sure. I see that useful. 
> 
> In fact there are 3 layers then
> 
> 1) low level "do check" function
> 
> 2) per bus code that calls the do check functions and whatever is needed
> for bus checks
> 
> 3) "EDAC" central command, which basically gathers all failure reports
> and does something with them (push them to userspace or implement the
> userspace chosen policy (panic/reboot/etc))
> 
> 
> having 1) separate from 2) is useful, it means that drivers can do
> synchronous checks in addition to the checks in 2) which will tend to be
> asynchronous....
> 
> 
> 

