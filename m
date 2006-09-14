Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWINQgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWINQgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWINQgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:36:15 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:152 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750993AbWINQgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:36:13 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception  code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Thu, 14 Sep 2006 10:36:06 -0600
User-Agent: KMail/1.9.1
Cc: kmannth@us.ibm.com, "Moore, Robert" <robert.moore@intel.com>,
       Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com> <200609130851.16028.bjorn.helgaas@hp.com> <1158202876.20560.14.camel@sli10-conroe.sh.intel.com>
In-Reply-To: <1158202876.20560.14.camel@sli10-conroe.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141036.07599.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 September 2006 21:01, Shaohua Li wrote:
> On Wed, 2006-09-13 at 22:51 +0800, Bjorn Helgaas wrote:
> > I think that your SSDT is valid.  I can't point to a specific
> > reference in the spec, but I think the "try _HID first, then try
> > _CID" strategy is clearly the intent.  Otherwise, there would be
> > no reason to separate _HID from _CID.

> The spec actually doesn't mention PNP0C01/PNP0C02. It's hard to say this
> is valid or invalid. 

This problem is more general than just Keith's situation.  This
could happen with any device that has both _HID and _CID.  As
soon as you have both _HID and _CID, you can have a driver that
claims the _HID and another that claims the _CID.

The spec obviously anticipates this situation, which is why I
think the SSDT is valid from the ACPI spec point of view.

Now, if you have some definition of the programming model of
PNP0C01/PNP0C02, and the memory device doesn't conform to that
model, then I would agree that the SSDT is invalid.  But I
don't know where a PNP0C01/PNP0C02 programming model is defined.

The linux driver does nothing more than reserve the resources
of the device, so it doesn't use any programming model at all.
The memory device (in fact, any ACPI device at all) trivially
conforms to this "null programming model."

> The 'try _HID first then _CID' has another downside. It highly depends
> on the driver is loaded first and then load the device. See motherboard
> driver loads first and the mem hotplug driver isn't loaded, in this
> situation if you scan the mem hotplug device, the mechanism will fail as
> the two pass search will still bind motherboard driver to the device.

I agree, this is a problem that will have to be resolved.  And it's
really not just an ACPI problem.  A PCI driver can claim devices based
on a class or a vendor/device/subvendor/subdevice with wildcards.
Another driver can claim devices with a specific vendor/device/etc.
Some devices may match with both drivers.

PCI has a /sys/bus/pci/driver/XXX/{bind,unbind} mechanism to cause a
driver to release a device and bind another driver to it.  Maybe we
could do something similar for ACPI. 

Bjorn
