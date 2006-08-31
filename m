Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWHaXGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWHaXGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWHaXGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:06:31 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:51674 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964811AbWHaXGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:06:30 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: kmannth@us.ibm.com
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Thu, 31 Aug 2006 17:06:59 -0600
User-Agent: KMail/1.9.1
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com> <200608310248.29861.len.brown@intel.com> <1157042913.7859.31.camel@keithlap>
In-Reply-To: <1157042913.7859.31.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311707.00817.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 10:48, keith mannthey wrote:
> On Thu, 2006-08-31 at 02:48 -0400, Len Brown wrote:
> > On Tuesday 29 August 2006 16:04, Moore, Robert wrote:
> > > As far as the unknown exception,
> > > 
> > > >[    9.392729]  [<c0246fb6>] acpi_ut_status_exit+0x31/0x5e
> > > >[    9.393453]  [<c0243352>] acpi_walk_resources+0x10e/0x11b
> > > >[    9.394174]  [<c025697e>] acpi_motherboard_add+0x22/0x31
> > > 
> > > I would guess that the callback routine for walk_resources is returning
> > > a non-zero status value which is causing an immediate abort of the walk
> > > with that value -- and the value is bogus.
> 
>   Before I put this check in acpi_motherboard_add always attached itself
> to any resource type. I simply changed it so if the type is not
> ACPI_RESOURCE_TYPE_IO or ACPI_RESOURCE_TYPE_FIXED_IO it doesn't attach
> and can continue to find the correct device to attach to.
> 
>   Perhaps the motherboard device needs to attach to more device types?  
> 
>   It was suggest by acpi folks to return -EINVAL.  Should something else
> be returned? 

Problem 1: acpi_reserve_io_ranges() needs to return an acpi_status
like AE_OK or AE_CTRL_TERMINATE, not a -EINVAL.

Problem 2: I don't understand how your patch works.  An ACPI device
has a list of resources it uses.  Are you saying that claiming all
the IO port resources of a PNP0C01 or PNP0C02 device causes the ACPI
memory hotplug driver to fail?

Is there some conflict between those PNP0C01 resources and the
resources of a hotplug memory device?  Can you figure out exactly
what the conflict is by disassembling the DSDT for those devices?

We should understand this better before introducing special cases
to the motherboard driver.  We should be able to trust the ACPI
description of the motherboard resources.  The motherboard driver
currently claims only I/O port resources, but it really should
claim MMIO resources as well.

> > http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patch
> > 
> > From: Keith Mannthey <kmannth@us.ibm.com>
> > ...
> > Make ACPI motherboard driver not attach to devices/handles it dosen't expect.
> > Fix a bug where the motherboard driver attached to hot-add memory event and
> > caused the add memory call to fail.
> > 
> > Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
> > Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> > Cc: Andi Kleen <ak@muc.de>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> > diff -puN drivers/acpi/motherboard.c~hot-add-mem-x86_64-acpi-motherboard-fix drivers/acpi/motherboard.c
> > --- a/drivers/acpi/motherboard.c~hot-add-mem-x86_64-acpi-motherboard-fix
> > +++ a/drivers/acpi/motherboard.c
> > @@ -87,6 +87,7 @@ static acpi_status acpi_reserve_io_range
> >  		}
> >  	} else {
> >  		/* Memory mapped IO? */
> > +		 return -EINVAL;
> >  	}
> >  
> >  	if (requested_res)
> > @@ -96,11 +97,16 @@ static acpi_status acpi_reserve_io_range
> >  
> >  static int acpi_motherboard_add(struct acpi_device *device)
> >  {
> > +	acpi_status status;
> >  	if (!device)
> >  		return -EINVAL;
> > -	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> > +
> > +	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> >  			    acpi_reserve_io_ranges, NULL);
> >  
> > +	if (ACPI_FAILURE(status))
> > +		return -ENODEV;
> > +
> >  	return 0;
> >  }
