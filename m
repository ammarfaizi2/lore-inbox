Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWIACmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWIACmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 22:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWIACmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 22:42:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:25442 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750808AbWIACmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 22:42:49 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,196,1154934000"; 
   d="scan'208"; a="119033436:sNHT71699124"
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception
	code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
From: Shaohua Li <shaohua.li@intel.com>
To: kmannth@us.ibm.com
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>,
       "Moore, Robert" <robert.moore@intel.com>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1157073592.5649.29.camel@keithlap>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
	 <200608310248.29861.len.brown@intel.com>
	 <1157042913.7859.31.camel@keithlap>
	 <200608311707.00817.bjorn.helgaas@hp.com>
	 <1157073592.5649.29.camel@keithlap>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 10:39:06 +0800
Message-Id: <1157078346.2782.24.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 09:19 +0800, keith mannthey wrote:
> On Thu, 2006-08-31 at 17:06 -0600, Bjorn Helgaas wrote: 
> > On Thursday 31 August 2006 10:48, keith mannthey wrote: 
> > > On Thu, 2006-08-31 at 02:48 -0400, Len Brown wrote: 
> > > > On Tuesday 29 August 2006 16:04, Moore, Robert wrote: 
> > > > > As far as the unknown exception, 
> > > > >  
> > > > > >[    9.392729]  [<c0246fb6>] acpi_ut_status_exit+0x31/0x5e 
> > > > > >[    9.393453]  [<c0243352>] acpi_walk_resources+0x10e/0x11b 
> > > > > >[    9.394174]  [<c025697e>] acpi_motherboard_add+0x22/0x31 
> > > > >  
> > > > > I would guess that the callback routine for walk_resources is
> returning 
> > > > > a non-zero status value which is causing an immediate abort of
> the walk 
> > > > > with that value -- and the value is bogus. 
> > >  
> > >   Before I put this check in acpi_motherboard_add always attached
> itself 
> > > to any resource type. I simply changed it so if the type is not 
> > > ACPI_RESOURCE_TYPE_IO or ACPI_RESOURCE_TYPE_FIXED_IO it doesn't
> attach 
> > > and can continue to find the correct device to attach to. 
> > >  
> > >   Perhaps the motherboard device needs to attach to more device
> types?   
> > >  
> > >   It was suggest by acpi folks to return -EINVAL.  Should
> something else 
> > > be returned?  
> >  
> > Problem 1: acpi_reserve_io_ranges() needs to return an acpi_status 
> > like AE_OK or AE_CTRL_TERMINATE, not a -EINVAL.
> 
> Sure great sounds.  I understand AE_OK is a 0 return so I can change
> it 
> to AE_CTRL_TERMINATE.  I don't want  acpi_reserve_io_ranges to return
> a 
> happy state when if finds a resource type is doesn't know.   
>   
> > Problem 2: I don't understand how your patch works.  An ACPI device 
> > has a list of resources it uses.  Are you saying that claiming all 
> > the IO port resources of a PNP0C01 or PNP0C02 device causes the
> ACPI 
> > memory hotplug driver to fail? 
> >  
>   I don't know a whole heck of a lot about ACPI but let me try and 
> explain the situation as best I can. I will attach my SSDT as well. 
> Memory devices are PNP0C80. 
> 
>    What the acpi_memory_device_driver is loaded in the system and you
> do 
> a hot-add event the following call path takes place...
> 
> acpi_memory_get_device 
>   acpi_bus_add 
>     acpi_add_single_object 
>       acpi_bus_find_driver 
>         acpi_bus_driver_init 
>           driver->ops.add
> 
>   The problem is the motherboard driver driver->ops.add is called
> before 
> my memory device is scanned and it ALWASY returns AE_OK. Such that
> the 
> device that is passed back up to that acpi_memory_get_device is NOT
> the 
> memory_device_driver but this motherboard device and the add fails 
> bigtime.  I need acpi_find_bus_driver to return to me the 
> acpi_memory_device_driver not the motherboard driver.  
> 
>   It seems pretty sane to be to have the add 
> 
> > Is there some conflict between those PNP0C01 resources and the 
> > resources of a hotplug memory device?  Can you figure out exactly 
> > what the conflict is by disassembling the DSDT for those devices?
> 
> Kame (who helped me greatly in tracking down the source my troubles) 
> thinks that the root cause is that the device (my memory_device) has 
> both a _HID and _CID. The driver for _HID is different for _CID and
> the 
> driver for _CID is found before _HID and I pass the wrong device up
> the 
> chain. 
> 
> > We should understand this better before introducing special cases 
> > to the motherboard driver.  We should be able to trust the ACPI 
> > description of the motherboard resources.  The motherboard driver 
> > currently claims only I/O port resources, but it really should 
> > claim MMIO resources as well.
> 
> The design of my patch is to make the motherboard driver return 
> something other than 0 when it's driver->ops.add is called with
> resource 
> types that are not what it expects.  
> 
> This way the scan if acpi_bus_find_driver will fine the correct acpi 
> device. 
> 
> Also see   
> http://sourceforge.net/mailarchive/forum.php? 
> thread_id=15282420&forum_id=223
> 
> I don't claim this is the ACPI correct solution and am welcome to any 
> input that fixes my issue: acpi_bus_find_driver returning the
> incorrect 
> driver for a given handle.    
Then the issue is your device _CID returned PNP0C01 or PNP0C02. Is this
intended? Can we change the BIOS?

Thanks,
Shaohua
