Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVCQSeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVCQSeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 13:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVCQSeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 13:34:09 -0500
Received: from fmr20.intel.com ([134.134.136.19]:7615 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261993AbVCQSd7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 13:33:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC] PCIErrorRecovery)
Date: Thu, 17 Mar 2005 10:33:12 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024080FDBA3@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC] PCIErrorRecovery)
Thread-Index: AcUqpFb1plKq8vm7SJChroKKqaehOwAeUt6A
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Hidetoshi Seto" <seto.hidetoshi@jp.fujitsu.com>,
       "Greg KH" <greg@kroah.com>, <ak@muc.de>,
       "linuxppc64-dev" <linuxppc64-dev@ozlabs.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 17 Mar 2005 18:33:13.0620 (UTC) FILETIME=[C7375540:01C52B1F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 16, 2005 7:52 PM Paul Mackerras wrote:
>> We need some PCI
>> based error flows to understand the details of the flow so we can
>> develop an interface compatible with both.
>
>Here is a basic outline of what happens with EEH (Enhanced Error
>Handling) on IBM PPC64 platforms.  This applies to PCI, PCI-X and
>PCI-Express devices.

Is EEH a PCI-SIG specification? Is EEH specs available in public?

>We have a PCI-PCI bridge per slot.  The bridge (and the PCI fabric
>generally) look for errors such as address parity errors,
>out-of-bounds DMA accesses by the device, or anything that would
>normally cause SERR to be set.  If such an error occurs, the bridge
>immediately isolates the device, meaning that writes by the CPU to the
>device are discarded, reads by the CPU are returned with all 1s data,
>and DMA accesses by the device are blocked.

It seems that a PCI-PCI bridge per slot is hardware implementation
specific. The fact that the PCI-PCI Bridge can isolate the slot is
hardware feature specific.

>What happens at the driver level depends on whether the driver is
>EEH-aware or not.  (This description is more what we would like to
>have rather than what is necessarily implemented at present).

PCI Express AER driver uses similar concept of determining whether the
driver is AER-aware or not except that PCI Express AER is independent
from firmware support.

>If the driver is not EEH-aware but is hot-plug capable, then the
>platform code will notice that reads from the device are returning all
>1s and query firmware about the state of the slot.  Firmware will
>indicate that the slot has been isolated.  Platform code can obtain
>more specific information about the error from firmware and log it.
>Then, platform code will generate a hot-unplug event for the slot.
>After the driver has cleaned up and notified higher levels that its
>device has gone away, platform code will call firmware to reset and
>unisolate the slot, and then generate a hotplug event to tell the
>driver that it can use the device - but as far as the driver is
>concerned, it is a new device.

Where does the platform code reside and where does it log the error?

In PCI Express if the driver is not AER-aware the fatal error message is
reported by its upstream switch, the AER driver obtains comprehensive
error information from the upstream switch (like EEH platform code
obtains error information from the firmware). Since the driver is not
AER-aware, the fatal error is reported to user to make a policy decision
since the PCI Express does not have a hot-plug event for the slot like
EEH platform. 

So it looks like the hot-plug capability of the driver is being used in
lieu of specific callbacks to freeze and thaw IO in the case of a
non-aware driver.  If the driver does not support hot-plug then the
error is just logged.  Do you leave the slot isolated or perform error
recovery anyway?

On a fatal error the interface is down.  No matter what the driver
supports (AER aware, EEH aware, unaware) all IO is likely to fail.
Resetting a bus in a point-to-point environment like PCI Express or EEH
(as you describe) should have little adverse effect.  The risk is the
bus reset will cause a card reset and the driver must understand to
re-initialize the card.  A link reset in PCI Express will not cause a
card reset.  We assume the driver will reset its card if necessary.

>If the driver is EEH-aware, then we use the API that Ben has
>proposed.  Platform code can either reset the slot (by calling
>firmware) or not, depending on what the driver asks for, and also
>depending on any other information the platform code has available to
>it, such as specific information about the error that has occurred.
>Platform code then unisolates the slot and then informs the driver
>that it can reinitialize the device and restart any transfers that
>were in progress.

In PCI Express the AER driver obtains fatal error information from the
upstream switch driver. We can use the same API with message =
PCIERR_ERROR_RECOVER to notify the endpoint driver, which is maybe
unaware of the fatal error reported by its upstream device. Mostly the
driver will respond with PCIERR_RESULT_NEED_RESET.

>Ben's API is aimed at supporting the code flows that we need for EEH
>as well as those needed for recovery from errors on PCI Express.  Part
>of the reason for not just requiring the driver to do everything
>itself is that a slot isolation event can affect multiple drivers,
>because the card in the slot could have a PCI-PCI bridge with multiple
>devices behind it.  Thus the recovery process potentially requires a
>degree of coordination between multiple drivers, and Ben's API
>addresses that.  The same coordination could be required on PCI
>Express, if I understand correctly, because a fault on an upstream
>link could affect many devices downstream of that link.

Yes the same case applies to PCI Express upstream links.  So halting IO
is desired when other devices are affected.

Thanks,
Long
