Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUIUDCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUIUDCk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 23:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUIUDCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 23:02:40 -0400
Received: from mailhub.hp.com ([192.151.27.10]:2028 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S266839AbUIUDCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 23:02:34 -0400
Subject: RE: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject
	interfacesupport
From: Alex Williamson <alex.williamson@hp.com>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       acpi-devel@lists.sourceforge.net,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84059309EF@pdsmsx403>
References: <3ACA40606221794F80A5670F0AF15F84059309EF@pdsmsx403>
Content-Type: text/plain
Date: Mon, 20 Sep 2004 21:02:18 -0600
Message-Id: <1095735738.3920.29.camel@mythbox>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   This sounds like a good idea. To call the raw AML methods from
> User space, just need to solve the problem of argument passing.

   Solved, the driver I proposed takes an acpi_object_list for passing
arguments to the methods.  The kernel-userspace interface replaces the
pointers in these structures with offsets into the buffer (userspace
responsibility to pass in offsets, kernel responsibility to pass back
offsets).  I've modified the sysfs bin_file to allow ACPI object files
to have backing store on a per-open basis.  There are special commands
that can be written to the ACPI object files to evaluate attributes of
them.  Perhaps these could include some of the things we're looking for
here.

> But, some AML methods are risky to be called directly from user space,
> Not only because the side effect of its execution, but also because
> it could trigger potential AML method bug or interpreter bug, or even
> architectural defect.  All of these headache is due to the AML method
>  is NOT intended for being used by userspace program.

   I've made an attempt to hide the most obvious dangerous methods, but
undoubtedly, there will be some.  Why are we any more likely to hit an
AML method bug, interpreter bug or architectural bug by having a
userspace interface?  Because we can more easily exercise the code?  It
calls the same code paths a driver could.  The driver I propose for this
task does not require any additionally low-level ACPI functions to be
exported.  I think it's too much complexity in the kernel to abstract
every possible bit of data someone might find useful into kernel
drivers.

   Take a simple case of looking for a device with a specific _HID value
and wanting the _CRS data for it.  The _HID value part is easy, but add
all the smarts to parse the _CRS data into something human readable, and
code bloat gets huge.  Then throw in the problem of parsing vendor data
types, and you'll never get finished.  This is a real example.  The zx1
ia64 chipset can only be discovered through ACPI namespace.  It's
physical address is saved in a vendor resource descriptor.  We currently
have to do some pretty ugly stuff in X to take a reasonable guess a what
chipset we're using.  We need some mechanism to get this data in
userspace, and I don't see an approach better than offloading the
complicated data parsing into userspace.  Adding only the methods needed
to solve a specific problem sounds like a maintainability nightmare.
Thanks,

	Alex

