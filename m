Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVCRRY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVCRRY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVCRRY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:24:58 -0500
Received: from fmr17.intel.com ([134.134.136.16]:43184 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261995AbVCRRYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:24:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]PCIErrorRecovery)
Date: Fri, 18 Mar 2005 09:24:02 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024081326E8@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]PCIErrorRecovery)
Thread-Index: AcUrbx9GAm0oAQboQtazaw+VtE0PaAAb2ABg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Hidetoshi Seto" <seto.hidetoshi@jp.fujitsu.com>,
       "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>, <ak@muc.de>,
       "linuxppc64-dev" <linuxppc64-dev@ozlabs.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 18 Mar 2005 17:24:04.0360 (UTC) FILETIME=[487A4080:01C52BDF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 17, 2005 8:01 PM Paul Mackerras wrote:
> Does the PCI Express AER specification define an API for drivers?

No. That is why we agree a general API that works for all platforms.

>Likewise, with EEH the device driver could take recovery action on its
>own.  But we don't want to end up with multiple sets of recovery code
>in drivers, if possible.  Also we want the recovery code to be as
>simple as possible, otherwise driver authors will get it wrong.

Drivers own their devices register sets.  Therefore if there are any
vendor unique actions that can be taken by the driver to recovery we
expect the driver to do so.  For example, if the drivers see "xyz" error
and there is a known errata and workaround that involves resetting some
registers on the card.  From our perspective we see drivers taking care
of their own cards but the AER driver and your platform code will take
care of the bus/link interfaces.

>I would see the AER driver as being included in the "platform" code.
>The AER driver would be be closely involved in the recovery process.

Our goal is to have the AER driver be part of the general code base
because it is based on a PCI SIG specification that can be implemented
across all architectures.   

>What is the state of a link during the time between when an error is
>detected and when a link reset is done?  Is the link usable?  What
>happens if you try to do a MMIO read from a device downstream of the
>link?

For a FATAL error the link is "unreliable".  This means MMIO operations
may or may not succeed.  That is why the reset is performed by the
upstream port driver.  The interface to that is reliable.  A reset of an
upstream port will propagate to all downstream links.  So we need an
interface to the bus/port driver to request a reset on its downstream
link.  We don't want the AER driver writing port bus driver bridge
control registers.  We are trying to keep the ownership of the devices
register read/write within the domain of the devices driver.  In our
case the port bus driver.

Thanks,
Long
