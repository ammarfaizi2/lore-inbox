Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266140AbUFXQek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUFXQek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUFXQek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:34:40 -0400
Received: from fmr12.intel.com ([134.134.136.15]:54158 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S266145AbUFXQeW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:34:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]2.6.7 MSI-X Update
Date: Thu, 24 Jun 2004 09:29:47 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240584453D@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.7 MSI-X Update
Thread-Index: AcRZvMSlgtGQjYAOTC6fHpfJ+MOkQQARTNKQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>,
       "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: <ak@muc.de>, <akpm@osdl.org>, <greg@kroah.com>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>, <eli@mellanox.co.il>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 24 Jun 2004 16:29:49.0500 (UTC) FILETIME=[7822C7C0:01C45A08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ON Thursday, June 24, 2004 Roland Dreier wrote:
>    Roland> I could imagine hardware where the driver does not know
>    Roland> exactly how many vectors it will use until it starts up.
>    Roland> As a hypothetical example, imagine some storage networking
>    Roland> host adapter that supports an interrupt vector per storage
>    Roland> target.  The driver does not know how many vectors it will
>    Roland> actually use until it has logged into the storage fabric;
>    Roland> in fact, the driver may want to keep some vectors "in
>    Roland> reserve" in case a new target is added to the fabric
>    Roland> later.
>
>    Roland> I think it would be better to preserve maximum flexibility
>    Roland> for devices and drivers, and not mandate that every
>    Roland> allocated MSI-X vector is always used.
>
>    Zwane> The MSI subsystem should at most reserve and the driver
>    Zwane> make a request.  There may be a limit per PCI device as
>    Zwane> specified by the MSI subsystem for some reason or
>    Zwane> other. Isn't this what we're all saying?
>
>No, Long is actually saying that a driver must actually call
>request_irq() on all the vectors that it is allocated.  I am saying
>that this requirement is too stringent, since there may be devices and
>drivers that cannot predict exactly how many MSI-X vectors they will
>use during driver initialization.

That is what we're all saying.

>    Roland> It seems in the code right now you are able to tell if any
>    Roland> MSI-X vectors are hooked, since you wait for the last
>    Roland> vector to be unhooked to disable MSI-X.  I would just have
>    Roland> it be a WARN_ON() (or maybe BUG_ON()) if a driver calls
>    Roland> pci_disable_msix() without calling free_irq for all its
>    Roland> MSI-X vectors.
>
>    Roland> Right now there is an issue if a driver is unloaded
>    Roland> without freeing all its IRQs -- the device will be left in
>    Roland> MSI-X mode and can not be recovered without rebooting.
>
>    Zwane> This sounds like a case of bad driver bug generally the
>    Zwane> kernel would oops when the ISR text gets unloaded. What
>    Zwane> kind of behaviour do you expect here?
>
>Yes, I agree, it is a bad driver bug if the driver is unloaded without
>doing free_irq() on all the vectors it has done request_irq() on.
>However, with Long's API, there is a problem if for example a device
>driver does pci_enable_msix() and is allocated 2 vectors, then
>correctly does request_irq()/free_irq() on one vector and doesn't
>touch the second vector, and then is unloaded.  The device will be
>left with MSI-X enabled and leak its vectors.

It's very convincing. The addition of the pci_disable_msi() and 
pci_disable_msix() functions are what is needed to handle this issue.

Thanks,
Long
