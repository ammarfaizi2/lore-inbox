Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263193AbUJ2B5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUJ2B5f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbUJ2Byw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:54:52 -0400
Received: from fmr06.intel.com ([134.134.136.7]:63924 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263177AbUJ2ASu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:18:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Why ACPI is in the kernel, notes from 2001
Date: Thu, 28 Oct 2004 17:17:27 -0700
Message-ID: <37F890616C995246BE76B3E6B2DBE05502764E54@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why ACPI is in the kernel, notes from 2001
Thread-Index: AcS9AizHiNcYvFbkSRCi4wuqqHGf0AAND0dwAAVaLIA=
From: "Moore, Robert" <robert.moore@intel.com>
To: "Moore, Robert" <robert.moore@intel.com>, "Theodore Ts'o" <tytso@mit.edu>,
       "Brown, Len" <len.brown@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>
Cc: "Yu, Luming" <luming.yu@intel.com>, "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Alex Williamson" <alex.williamson@hp.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 29 Oct 2004 00:17:29.0604 (UTC) FILETIME=[AD4F5C40:01C4BD4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's some notes from 2001:

Why ACPI is in the kernel

ACPI and the AML interpreter are required very early during kernel
initialization, before the device drivers are loaded.  Control methods
are executed by the interpreter at this time (such as all device _INI
methods).

ACPI owns the ACPI hardware and ACPI interrupt (SCI), and therefore this
part of the ACPI subsystem is similar to a device driver.

Control methods that are executed via the AML interpreter are allowed
direct access to all of physical memory, all I/O space, and all PCI
configuration space (via Operation Regions.)

Device drivers such as the Embedded Controller, Battery, and Thermal use
ACPI services and execute AML control methods during their operation.

Device driver callback routines are invoked directly from the AML
interpreter when the ASL Notify operation is executed.

ACPI and the AML interpreter cannot be paged out.  How do you wake up
the disk used for paging?  Not a good idea for other device drivers to
depend on code that may be paged out.

Also,

As of May 2000, the AML interpreter was in acpid! Shortly after that, we
made a conscious decision to move it into the driver for the reasons
above.  The code may be large (for Linux), but it is necessary and must
remain resident (it is non-pageable).

Bob

> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
> admin@lists.sourceforge.net] On Behalf Of Moore, Robert
> Sent: Thursday, October 28, 2004 2:42 PM
> To: Theodore Ts'o; Brown, Len; Grover, Andrew; Therien, Guy
> Cc: Yu, Luming; Bjorn Helgaas; Alex Williamson; linux-kernel; acpi-
> devel@lists.sourceforge.net
> Subject: [ACPI] RE: Userspace ACPI interpreter
> 
> 
> I've been working on the ACPI CA project for over 6 years, and trust
me,
> this has been tried before.  There are significant reasons for having
> the interpreter in the kernel.
> 
> You don't really want to page out the interpreter when you are using
it
> for things like suspend/resume, thermal control, and many other
things.
> 
> I think we have a list around somewhere with many of the reasons, I
will
> look for it.
> 
> Bob
> 
> 
> > -----Original Message-----
> > From: Theodore Ts'o [mailto:tytso@thunk.org] On Behalf Of Theodore
> Ts'o
> > Sent: Thursday, October 28, 2004 8:24 AM
> > To: Brown, Len
> > Cc: Yu, Luming; Bjorn Helgaas; Moore, Robert; Alex Williamson;
linux-
> > kernel; acpi-devel@lists.sourceforge.net
> > Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC]
> dev_acpi:
> > support for userspace access to acpi)
> >
> > On Thu, Oct 28, 2004 at 01:37:52AM -0400, Len Brown wrote:
> > > One way to experiment with a user-mode ACPI interpreter would be
to
> > > continue to use the kernel-mode interpreter for boot up , and cut
> over
> > > to the user-mode interpreter at /sbin/init.  The kernel-mode
> interpreter
> > > could be sent the way of free_initmem() which is called just
before
> > > /sbin/init is invoked.
> >
> > Is there a significant advantage to doing having a user-mode ACPI
> > interpreter?  The only advantage I can think of is that the ACPI
> > interpreter could now live in pageable memory.  Are there any
others?
> >
> > 					- Ted
> 
> 
> -------------------------------------------------------
> This Newsletter Sponsored by: Macrovision
> For reliable Linux application installations, use the industry's
leading
> setup authoring tool, InstallShield X. Learn more and evaluate
> today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
