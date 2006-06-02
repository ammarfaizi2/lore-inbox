Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWFBWFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWFBWFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWFBWFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:05:42 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:34975 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1750856AbWFBWFl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:05:41 -0400
X-ASG-Debug-ID: 1149285940-24504-11-2
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-ASG-Orig-Subj: RE: [PATCH 2.6.16.18] MSI: Proposed fix for MSI/MSI-X load failure
Subject: RE: [PATCH 2.6.16.18] MSI: Proposed fix for MSI/MSI-X load failure
Date: Fri, 2 Jun 2006 18:05:53 -0400
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD777C064F@nekter>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.16.18] MSI: Proposed fix for MSI/MSI-X load failure
Thread-Index: AcaGj7u4syuQWdpEQvOxr3+dhHrB4gAAGWxQ
From: "Ravinandan Arakali" <Ravinandan.Arakali@neterion.com>
To: "Rajesh Shah" <rajesh.shah@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       "Leonid Grossman" <Leonid.Grossman@neterion.com>,
       "Ananda Raju" <araju@pc.s2io.com>,
       "Sriram Rapuru" <Sriram.Rapuru@neterion.com>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh,
It's possible that the current behavior is by design but once the driver is loaded with MSI, you need a reboot to be able to load MSI-X. And vice versa. I found this rather restrictive.

I did test the fix multiple times. For eg. multiple load/unload iterations of
MSI followed by multiple load/unload of MSI-X followed by load/unload MSI. That way both transitions(MSI-to-MSI-X and vice versa) are tested.

Thanks,
Ravi

-----Original Message-----
From: Rajesh Shah [mailto:rajesh.shah@intel.com]
Sent: Friday, June 02, 2006 2:55 PM
To: Ravinandan Arakali
Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; Leonid
Grossman; Ananda Raju; Sriram Rapuru
Subject: Re: [PATCH 2.6.16.18] MSI: Proposed fix for MSI/MSI-X load
failure


On Fri, Jun 02, 2006 at 03:21:37PM -0400, Ravinandan Arakali wrote:
> 
> Symptoms:
> When a driver is loaded with MSI followed by MSI-X, the load fails indicating 
> that the MSI vector is still active. And vice versa.
> 
> Suspected rootcause:
> This happens inspite of driver calling free_irq() followed by 
> pci_disable_msi/pci_disable_msix. This appears to be a kernel bug 
> wherein the pci_disable_msi and pci_disable_msix calls do not 
> clear/unpopulate the msi_desc data structure that was populated 
> by pci_enable_msi/pci_enable_msix.
> 
The current MSI code actually does this deliberately, not by
accident. It's got a lot of complex code to track devices and
vectors and make sure an enable_msi -> disable -> enable sequence
gives a driver the same vector. It also has policies about
reserving vectors based on potential hotplug activity etc.
Frankly, I've never understood the need for such policies, and
am in the process of removing all of them.

> Proposed fix:
> Free the MSI vector in pci_disable_msi and all allocated MSI-X vectors 
> in pci_disable_msix.
> 
This will break the existing MSI policies. Once you take that away,
a whole lot of additional code and complexity can be removed too.
That's what I'm working on right now, but such a change is likely
too big for -stable.

So, I'm ok with this patch if it actually doesn't break MSI/MSI-X.
Did you try to repeatedly load/unload an MSI capable driver with
this patch? Did you repeatedly try to ifdown/ifup an Ethernet
driver that uses MSI? I'm not in a position to test this today, but
will try it out next week.

thanks,
Rajesh

