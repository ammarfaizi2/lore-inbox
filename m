Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVCRSIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVCRSIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVCRSIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:08:46 -0500
Received: from colo.lackof.org ([198.49.126.79]:33219 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262014AbVCRSIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:08:36 -0500
Date: Fri, 18 Mar 2005 11:10:05 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, ak@muc.de,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]PCIErrorRecovery)
Message-ID: <20050318181005.GA30909@colo.lackof.org>
References: <C7AB9DA4D0B1F344BF2489FA165E5024081326E8@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024081326E8@orsmsx404.amr.corp.intel.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 09:24:02AM -0800, Nguyen, Tom L wrote:
> >Likewise, with EEH the device driver could take recovery action on its
> >own.  But we don't want to end up with multiple sets of recovery code
> >in drivers, if possible.  Also we want the recovery code to be as
> >simple as possible, otherwise driver authors will get it wrong.
> 
> Drivers own their devices register sets.  Therefore if there are any
> vendor unique actions that can be taken by the driver to recovery we
> expect the driver to do so.
...

All drivers also need to cleanup driver state if they can't
simply recover (and restart pending IOs). ie they need to release
DMA resources and return suitable errors for pending requests.


> >I would see the AER driver as being included in the "platform" code.
> >The AER driver would be be closely involved in the recovery process.
> 
> Our goal is to have the AER driver be part of the general code base
> because it is based on a PCI SIG specification that can be implemented
> across all architectures.   

To the driver writer, it's all "platform" code.
Folks who maintain PCI (and other) services differentiate between
"generic" and "arch/platform" specific. Think first like a driver
writer and then worry about if/how that can be divided between platform
generic and platform/arch specific code.

Even PCI-Express has *some* arch specific component. At a minimum each
architecture has it's own chipset and firmware to deal with
for PCI Express bus discovery and initialization. But driver writers
don't have to worry about that and they shouldn't for error
recovery either.

> For a FATAL error the link is "unreliable".  This means MMIO operations
> may or may not succeed.  That is why the reset is performed by the
> upstream port driver.  The interface to that is reliable.  A reset of an
> upstream port will propagate to all downstream links.  So we need an
> interface to the bus/port driver to request a reset on its downstream
> link.  We don't want the AER driver writing port bus driver bridge
> control registers.  We are trying to keep the ownership of the devices
> register read/write within the domain of the devices driver.  In our
> case the port bus driver.

A port bus driver does NOT sound like a normal device driver.
If PCI Express defines a standard register set for a bridge
device (like PCI COnfig space for PCI-PCI Bridges), then I
don't see a problem with PCI-Express error handling code mucking
with those registers. Look at how PCI-PCI bridges are supported
today and which bits of code poke registers on PCI-PCI Bridges.

hth,
grant
