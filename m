Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVCRDpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVCRDpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 22:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVCRDop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 22:44:45 -0500
Received: from ozlabs.org ([203.10.76.45]:62180 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261461AbVCRDnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 22:43:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16954.18811.500766.244979@cargo.ozlabs.ibm.com>
Date: Fri, 18 Mar 2005 14:22:35 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@muc.de, Greg KH <greg@kroah.com>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: RE: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]
	PCIErrorRecovery)
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024080FDBA3@orsmsx404.amr.corp.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024080FDBA3@orsmsx404.amr.corp.intel.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nguyen, Tom L writes:

> Is EEH a PCI-SIG specification? Is EEH specs available in public?

No and no (not yet anyway).

> It seems that a PCI-PCI bridge per slot is hardware implementation
> specific. The fact that the PCI-PCI Bridge can isolate the slot is
> hardware feature specific.

Well, it's a common feature across all current IBM PPC64 machines.

> PCI Express AER driver uses similar concept of determining whether the
> driver is AER-aware or not except that PCI Express AER is independent
> from firmware support.

Don't worry about the firmware; the driver won't have to interact with
firmware itself, that's the job of the ppc64-specific platform code.

> Where does the platform code reside and where does it log the error?

By platform code I meant the code under the arch directory that knows
the details of the I/O topology of the machine, how to access the PCI
host bridges, etc.  How and where it logs the error is a platform
policy; on IBM ppc64 machines we have an error log daemon for this
purpose, which can do things like log the error to a file or send it
to another machine.

> In PCI Express if the driver is not AER-aware the fatal error message is
> reported by its upstream switch, the AER driver obtains comprehensive
> error information from the upstream switch (like EEH platform code
> obtains error information from the firmware). Since the driver is not
> AER-aware, the fatal error is reported to user to make a policy decision
> since the PCI Express does not have a hot-plug event for the slot like
> EEH platform. 

If there is a permanent failure of an upstream link, then maybe
generating unplug events for the devices below it would be a useful
thing to do.

> So it looks like the hot-plug capability of the driver is being used in
> lieu of specific callbacks to freeze and thaw IO in the case of a
> non-aware driver.  If the driver does not support hot-plug then the
> error is just logged.  Do you leave the slot isolated or perform error
> recovery anyway?

The choice is really to leave the slot isolated or to panic the
system.  Leaving the slot isolated risks having the driver loop in an
interrupt routine or deliver bad data to userspace, so we currently
panic the system.

> On a fatal error the interface is down.  No matter what the driver

Which interface do you mean here?

> supports (AER aware, EEH aware, unaware) all IO is likely to fail.
> Resetting a bus in a point-to-point environment like PCI Express or EEH
> (as you describe) should have little adverse effect.  The risk is the
> bus reset will cause a card reset and the driver must understand to
> re-initialize the card.  A link reset in PCI Express will not cause a
> card reset.  We assume the driver will reset its card if necessary.

How will the driver reset its card?

> In PCI Express the AER driver obtains fatal error information from the
> upstream switch driver. We can use the same API with message =
> PCIERR_ERROR_RECOVER to notify the endpoint driver, which is maybe
> unaware of the fatal error reported by its upstream device. Mostly the
> driver will respond with PCIERR_RESULT_NEED_RESET.

Sounds fine.

Paul.
