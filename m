Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWDSSUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWDSSUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWDSSUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:20:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:61869 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751129AbWDSST7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:19:59 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25091328:sNHT51762466"
Subject: Re: [patch 1/3] acpi: dock driver
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Patrick Mochel <mochel@linux.intel.com>
Cc: Prarit Bhargava <prarit@sgi.com>, Andrew Morton <akpm@osdl.org>,
       len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz,
       temnota@kmv.ru
In-Reply-To: <20060419172816.GA14304@linux.intel.com>
References: <20060412221027.472109000@intel.com>
	 <1144880322.11215.44.camel@whizzy> <20060412222735.38aa0f58.akpm@osdl.org>
	 <1145054985.29319.51.camel@whizzy> <44410360.6090003@sgi.com>
	 <1145383396.10783.32.camel@whizzy> <20060418225427.GE4556@linux.intel.com>
	 <1145466537.21185.24.camel@whizzy> <20060419172816.GA14304@linux.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Apr 2006 11:28:42 -0700
Message-Id: <1145471322.21185.55.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 19 Apr 2006 18:19:43.0333 (UTC) FILETIME=[D4A7D950:01C663DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:28 -0700, Patrick Mochel wrote:
> On Wed, Apr 19, 2006 at 10:08:57AM -0700, Kristen Accardi wrote:
> > On Tue, 2006-04-18 at 15:54 -0700, Patrick Mochel wrote:
> 
> > > > +acpi_status
> > > > +register_hotplug_dock_device(acpi_handle handle, acpi_notify_handler handler,
> > > > +			     void *context)
> > > 
> > > If this is called from outside drivers/acpi/, you should return an int with a 
> > > real errno value. The AE_* values shouldn't be used outside of the ACPI CA. 
> > > 
> > 
> > Really?  We use these all over the place in drivers/pci/hotplug.  In
> > fact, you kinda have to use them if you are calling certain acpi
> > symbols, since they return these types.
> > 
> > For example, here are some functions will return acpi_status that we use
> > in hotplug land.
> > 
> > pci_osc_control_set() 
> > acpi_run_oshp()
> > acpi_walk_namespace requires its use.
> 
> Well, it's one thing to use a function that returns a non-standard error-value,
> but it's another to add more functions that do. :-) 
> 
> > I felt that by returning acpi_status I was being consistent with how
> > other acpi calls acted.  Is this another example of the iceberg that Len
> > was talking about in a previous email?? (ugh.)
> 
> I believe so. 
> 
> We have a standard, well-defined error namespace that lives in include/*/errno.h.
> ACPI defines its own error namespace because it must be portable, and even though
> most OSes will define the standard errno values, some do not, so it cannot 
> assume that it will be there. I'm not sure why the choice was to redefine similar
> error values instead of reusing the errno values, but that's moot at this point..
> 
> The only place where the ACPI error values need to be used is in the ACPI CA. The
> functions exposed to the OS from the CA will return AE_* because the same source
> runs everywhere. However, Linux-specific code doesn't need to do that. It is free
> to use Linux-specific error reporting (except in the OSL layer that the CA uses,
> because it is expecting well-defined return values, as specified in the CA 
> Programmers Reference). 
> 
> My standpoint is that Linux-specific code should not be using any ACPI CAisms at
> all because since the code is Linux-specific, it doesn't need to be portable in 
> the same manner that the CA is. This is true for all of drivers/acpi/*.c, with the
> exception of drivers/acpi/osl.c, but even some of that source can be cleaned up
> to be more Linux-friendly.
> 
> Further rationale is that there is no way to enforce the CAisms in Linux-specific
> code. You will frequently find mixed return values. Sometimes a function is 
> declared as 
> 
> 	acpi_status acpi_foo()
> 
> and return -1 and 0. Or vice versa. 
> 
> The ACPI drivers were initially written in the same style that the CA was written,
> which makes it confusing when you look at them. But, they don't need to be that
> way. They can look like real Linux drivers and become a lot more palatable. 
> 
> Eventually, all of the CAisms should be pushed down to the thin layer that sits 
> above the interpreter. All exported functions should return ints, and those that
> deal directly with the CA interface should simply translate the AE_* error
> values into an errno return. 
> 
> Thanks,
> 
> 
> 	Pat

Well, I will certainly change the dock code, but pulling this stuff out
of the hotplug drivers will take longer since it would require changing
the offending acpi interfaces.  
