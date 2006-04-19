Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWDSRvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWDSRvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWDSRvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:51:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:18299 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750999AbWDSRvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:51:20 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="25867979:sNHT51401420"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/3] acpi: dock driver
Date: Wed, 19 Apr 2006 10:51:18 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4200B79@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/3] acpi: dock driver
Thread-Index: AcZj13I5o0Sb9+JOQeKfiOHh1j3yRgAANC0w
From: "Moore, Robert" <robert.moore@intel.com>
To: "Patrick Mochel" <mochel@linux.intel.com>,
       "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: "Prarit Bhargava" <prarit@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, <greg@kroah.com>,
       <linux-acpi@vger.kernel.org>, <pcihpd-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <arjan@linux.intel.com>,
       <muneda.takahiro@jp.fujitsu.com>, <pavel@ucw.cz>, <temnota@kmv.ru>
X-OriginalArrivalTime: 19 Apr 2006 17:51:19.0236 (UTC) FILETIME=[DCEF4840:01C663D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Architecturally, this was the design of ACPICA -- that anything
OS-dependent would be written in whatever format/style/exception
model/threading model/blah as the host OS.

We even discussed having an interface layer in order to translate
incoming requests (to ACPICA) from the host drivers to ACPICA requests,
and then translate the output (such as exception codes) back to the host
format, but we ended up deciding that this was overkill. 

I certainly agree that it is not a good idea to mix exception code
spaces.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Patrick Mochel
> Sent: Wednesday, April 19, 2006 10:28 AM
> To: Accardi, Kristen C
> Cc: Prarit Bhargava; Andrew Morton; Brown, Len; greg@kroah.com; linux-
> acpi@vger.kernel.org; pcihpd-discuss@lists.sourceforge.net; linux-
> kernel@vger.kernel.org; arjan@linux.intel.com;
> muneda.takahiro@jp.fujitsu.com; pavel@ucw.cz; temnota@kmv.ru
> Subject: Re: [patch 1/3] acpi: dock driver
> 
> On Wed, Apr 19, 2006 at 10:08:57AM -0700, Kristen Accardi wrote:
> > On Tue, 2006-04-18 at 15:54 -0700, Patrick Mochel wrote:
> 
> > > > +acpi_status
> > > > +register_hotplug_dock_device(acpi_handle handle,
> acpi_notify_handler handler,
> > > > +			     void *context)
> > >
> > > If this is called from outside drivers/acpi/, you should return an
int
> with a
> > > real errno value. The AE_* values shouldn't be used outside of the
> ACPI CA.
> > >
> >
> > Really?  We use these all over the place in drivers/pci/hotplug.  In
> > fact, you kinda have to use them if you are calling certain acpi
> > symbols, since they return these types.
> >
> > For example, here are some functions will return acpi_status that we
use
> > in hotplug land.
> >
> > pci_osc_control_set()
> > acpi_run_oshp()
> > acpi_walk_namespace requires its use.
> 
> Well, it's one thing to use a function that returns a non-standard
error-
> value,
> but it's another to add more functions that do. :-)
> 
> > I felt that by returning acpi_status I was being consistent with how
> > other acpi calls acted.  Is this another example of the iceberg that
Len
> > was talking about in a previous email?? (ugh.)
> 
> I believe so.
> 
> We have a standard, well-defined error namespace that lives in
> include/*/errno.h.
> ACPI defines its own error namespace because it must be portable, and
even
> though
> most OSes will define the standard errno values, some do not, so it
cannot
> assume that it will be there. I'm not sure why the choice was to
redefine
> similar
> error values instead of reusing the errno values, but that's moot at
this
> point..
> 
> The only place where the ACPI error values need to be used is in the
ACPI
> CA. The
> functions exposed to the OS from the CA will return AE_* because the
same
> source
> runs everywhere. However, Linux-specific code doesn't need to do that.
It
> is free
> to use Linux-specific error reporting (except in the OSL layer that
the CA
> uses,
> because it is expecting well-defined return values, as specified in
the CA
> Programmers Reference).
> 
> My standpoint is that Linux-specific code should not be using any ACPI
> CAisms at
> all because since the code is Linux-specific, it doesn't need to be
> portable in
> the same manner that the CA is. This is true for all of
drivers/acpi/*.c,
> with the
> exception of drivers/acpi/osl.c, but even some of that source can be
> cleaned up
> to be more Linux-friendly.
> 
> Further rationale is that there is no way to enforce the CAisms in
Linux-
> specific
> code. You will frequently find mixed return values. Sometimes a
function
> is
> declared as
> 
> 	acpi_status acpi_foo()
> 
> and return -1 and 0. Or vice versa.
> 
> The ACPI drivers were initially written in the same style that the CA
was
> written,
> which makes it confusing when you look at them. But, they don't need
to be
> that
> way. They can look like real Linux drivers and become a lot more
> palatable.
> 
> Eventually, all of the CAisms should be pushed down to the thin layer
that
> sits
> above the interpreter. All exported functions should return ints, and
> those that
> deal directly with the CA interface should simply translate the AE_*
error
> values into an errno return.
> 
> Thanks,
> 
> 
> 	Pat
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
