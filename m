Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVCRCHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVCRCHv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 21:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVCRCHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 21:07:51 -0500
Received: from fmr19.intel.com ([134.134.136.18]:50323 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261426AbVCRCHg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 21:07:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI Error Recovery API Proposal. (WAS::  [PATCH/RFC] PCIErrorRecovery)
Date: Thu, 17 Mar 2005 10:53:46 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024080FDC40@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Error Recovery API Proposal. (WAS::  [PATCH/RFC] PCIErrorRecovery)
Thread-Index: AcUqoHGZl5+wV23yQV6S2YEaSn419QAf7WYQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "Linas Vepstas" <linas@austin.ibm.com>,
       "Hidetoshi Seto" <seto.hidetoshi@jp.fujitsu.com>,
       "Greg KH" <greg@kroah.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <ak@muc.de>, "Paul Mackerras" <paulus@samba.org>,
       "linuxppc64-dev" <linuxppc64-dev@ozlabs.org>,
       <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 17 Mar 2005 18:53:48.0695 (UTC) FILETIME=[A760D270:01C52B22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 16, 2005 7:20 PM Benjamin Herrenschmidt wrote:
>> What mechanism (message??) is used to perform the bus and/or link
>> level reset?  For PCI Express the reset is performed by the upstream
>> port driver.  My API takes this into account.  Are you assuming the
PCI
>> device on the bus does the reset or will there be a PCI bus driver
that
>> will do the reset?  How will the PCI error handling code initiate a
>> reset?
>
>The "caller", that is the error management framework. I'm defining the
>API at the driver level, not the implementation at the core level.
>
>For example, on IBM pSeries with PCI-Express, we will probably not have
>an AER driver. This will be all dealt by the firmware which will mimmic
>that to the existing EEH error management. We'll have the same API to
do
>the reset that we have today for resetting a slot.

We decided to implement PCI Express error handling based on the PCI
Express specification in a platform independent manner.  This allows any
platform that implements PCI Express AER per the PCI SIG specification
can take advantage of the advanced features, much like SHPC hot-plug or
PCI Express hot-plug implementations.

>You may have noticed in general that I didn't either define who is
>callign those callbacks. It's all implicit that this is done by
platform
>error management code. For example, on ppc64, even the recovery step
>requires action from the platform since the slot has been physically
>isolated. After we have notified all drivers  with the "error detected"
>callback, if we decide we can try the "recover" step (all drivers
>returned they could try it and we decided the error wasn't too fatal)
we
>will call the firmware to re-enable IOs on the slot and call the
>"recover" step.

For PCI Express the endpoint device driver can take recovery action on
its own, depending on the nature of the error so long as it does not
affect the upstream device.  This can include endpoint device resets.
We expect the driver to do this upon error notification, if possible.
In PCI Express since the driver will have the most knowledge regarding
the error it will have the best ability to do device dependent recovery
and IO retry.  If its recovery fails then the AER driver will ask the
upstream device driver to perform the link reset.  Since this is more of
a side effect an explicit call to recover is not necessary.  However, we
understand and agree that it is needed to support the general error
recovery cases for PCI.

To support the AER driver calling an upstream device to initiate a reset
of the link we need a specific callback since the driver doing the reset
is not the driver who got the error.  In the case of general PCI this
could be useful if a PCI bus driver were available to support the
callback for a bridge device.  This would also support specific error
recovery calls to reset an endpoint adapter.  We need a call to request
a driver to perform a reset on a link or device.  

Thanks,
Long
