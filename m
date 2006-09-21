Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWIUA1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWIUA1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWIUA1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:27:11 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:9917 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750818AbWIUA1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:27:09 -0400
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception 
	code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Shaohua Li <shaohua.li@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1158285122.20560.38.camel@sli10-conroe.sh.intel.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com>
	 <4132.24.9.204.52.1157682479.squirrel@mail.cce.hp.com>
	 <1158110859.6047.27.camel@keithlap>
	 <200609130851.16028.bjorn.helgaas@hp.com>
	 <1158202876.20560.14.camel@sli10-conroe.sh.intel.com>
	 <1158256505.5660.22.camel@keithlap>
	 <1158285122.20560.38.camel@sli10-conroe.sh.intel.com>
Content-Type: multipart/mixed; boundary="=-Cg3WmT7nt0Bh7PTBHrnM"
Organization: Linux Technology Center IBM
Date: Wed, 20 Sep 2006 17:27:05 -0700
Message-Id: <1158798426.5659.23.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Cg3WmT7nt0Bh7PTBHrnM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-09-15 at 09:52 +0800, Shaohua Li wrote:
> On Thu, 2006-09-14 at 10:55 -0700, keith mannthey wrote:
> > On Thu, 2006-09-14 at 11:01 +0800, Shaohua Li wrote:
> > > On Wed, 2006-09-13 at 22:51 +0800, Bjorn Helgaas wrote:
> > > > On Tuesday 12 September 2006 19:27, keith mannthey wrote:
> > > > > On Thu, 2006-09-07 at 20:27 -0600, Bjorn Helgaas wrote:
> > > > > > > On Thu, 2006-09-07 at 09:25 -0600, Bjorn Helgaas wrote:
> > 
> > > > I think that your SSDT is valid.  I can't point to a specific
> > > > reference in the spec, but I think the "try _HID first, then try
> > > > _CID" strategy is clearly the intent.  Otherwise, there would be
> > > > no reason to separate _HID from _CID.
> > > The spec actually doesn't mention PNP0C01/PNP0C02. It's hard to say this
> > > is valid or invalid. 
> > 
> > Lets work on the assumption it is valid until someone points out in a
> > spec that says it isn't. 
> > 
> > > The 'try _HID first then _CID' has another downside. It highly depends
> > > on the driver is loaded first and then load the device. See motherboard
> > > driver loads first and the mem hotplug driver isn't loaded, in this
> > > situation if you scan the mem hotplug device, the mechanism will fail as
> > > the two pass search will still bind motherboard driver to the device.
> > Any solution depends on the mem hotplug device being loaded.  This
> > doesn't appear to be _HID before _CID specific issue .  
> > 
> > > If you take the two pass search, I have a feeling this will make acpi
> > > never be able to convert Linux driver model.
> > 
> > I am not trying to break forward work but what I do want is a solution
> > to my problem. 
> > 
> > > If you really want to workaround the issue, I prefer have a blacklist or
> > > something to let ACPI not use the _CID for your device, but please don't
> > > mess the ACPI core itself.
> > 
> > My fist pass to fix the problem was I guess a hack of sorts that caused
> > others problems (motherboard add return != 0 on unknown devices).  I
> > don't want another Keith grown hack that breaks other people. 
> > 
> > Can you elaborate on what you think would be safe way to do what you
> > propose since the ACPI core (can't/won't?) be fixed? I can imagine a
> > couple of different ways to fix this but I would like some feedback
> > before I go off and work on the 3rd pass of this fix. 

Ok off I went.... 

> > 1.  Make the memory device get scanned before the motherboard device
> > somehow.  Implicitly reorder the devices in the list. Perhaps a priority
> > sorted of sorts to have _HID device always before _CID devices during
> > the scan? 
> This will change the scan order of ACPI device, and sounds too hack to me.

  ACPI driver only has name with no _HID _CID contest.  The handle reads
the name space to fill in the device.    There is no way to explicitly
order the list correctly for all cases as we are trying to reorder the
driver list.
  
  I looked into making the memory device dynamically change itself to
not contain a _CID (thus changing the namespace) but it got pretty ugly.
This is perhaps doable but a little on the ugly side.  

  So I just flip the order of the device list for all cases in a simple
patch.  This is a total hack and workaround for just my current
situation.   


> > 3.  Some special blacklist of the motherboard device on my specific
> > system. 

Uhh this looks to require a whole new black list infrastructure?

Any more ideas????

Thanks,
  Keith 

Signed-off-by: Keith Mannthey <kmannth@us.ibm.com>


--=-Cg3WmT7nt0Bh7PTBHrnM
Content-Disposition: attachment; filename=patch-acpi-scanfix-v2
Content-Type: text/plain; name=patch-acpi-scanfix-v2; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.17/drivers/acpi/scan.c	2006-09-20 13:58:06.000000000 -0700
+++ linux-2.6.18-rc6-mm2-works/drivers/acpi/scan.c	2006-09-20 11:31:33.000000000 -0700
@@ -601,7 +601,7 @@
 		return -ENODEV;
 
 	spin_lock(&acpi_device_lock);
-	list_add_tail(&driver->node, &acpi_bus_drivers);
+	list_add(&driver->node, &acpi_bus_drivers);
 	spin_unlock(&acpi_device_lock);
 	acpi_driver_attach(driver);
 

--=-Cg3WmT7nt0Bh7PTBHrnM--

