Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTJ0IWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 03:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTJ0IWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 03:22:13 -0500
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:25336 "EHLO
	earth-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S261304AbTJ0IWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 03:22:10 -0500
Date: Mon, 27 Oct 2003 00:22:07 -0800 (PST)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: alex.williamson@hp.com
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       shaohua.li@intel.com, len.brown@intel.com, jon@nanocrew.net
Subject: Re: [BUG] test9 ACPI bad: scheduling while atomic!
Message-ID: <Pine.GSO.4.58.0310262327040.19469@clyde>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>    On an Omnibook 500 running test9, removing AC power causes an
> immediate hang.  This laptop is getting a little old and I have to force
> on ACPI support, but this did not happen with test8.  The bug and panic

I have this problem as well, on a Sony Vaio, model PCG-571L.

> are shown below.  It looks like the AML associated with the AC event is
> trying to do an AML_SLEEP_OP.  Since this is called while in the
> interrupt handler, and the eventual call to acpi_os_sleep() sets the
> current state to interruptible... boom.  One simple, but terribly ugly,
> workaround is to make acpi_os_sleep() call acpi_os_stall() if
> in_atomic() is true (patch below).  Hopefully there's a better way to
> fix this.  Somehow the interpreter really needs to drop interrupt
> context before it starts making calls like this.  Thanks,

This problem stems from the changes in revision 1.26 of drivers/acpi/ec.c.
They come from a patch Shaohua Li submitted for kernel bug 1171 at
bugme.osdl.org.  That patch can cause acpi_ec_gpe_query to run in interrupt
context, whereas before it always ran from a workqueue.  It does non-interrupt
like things, like sleeping and kmalloc'ing with GFP_KERNEL.

This was obvious on my system because it has no ECDT table, and as such
acpi_ec_gpe_query was _always_ running in interrupt context, whereas with an
ECDT it would only do so for a brief time during boot, and the problem would be
much more subtle.  That's probably why nobody noticed this in earlier tests.

I reversed cset 1.1337.43.3 as follows, and that fixed the problem:

bk export -tpatch -r1.1337.43.3 | patch -p1 -R

I can't figure out why that patch fixed the oops in bug 1171.  It was a hook
into the ec address space handler, not the gpe handler, that led to the oops,
yet the patch seems to only modify gpe-related code.  Perhaps you could explain,
Shaohua?

I'd guess the T40 oops results from the ACPI_MEM_FREE on line 305 of
drivers/acpi/events/evregion.c freeing already-freed memory.  I'm actually not
sure why that free is even there.  I also can't figure why only SMP-configured
kernels exhibited the problem.  If someone has the problem hardware, I am
willing to debug it, however.

The errant patch does address what seems to be a race condition that could play
out as follows:

1) The early ECDT probe locates an ECDT and registers a handler for the relevant
GPE and address space.

2) An IRQ triggers acpi_ec_gpe_handler, which schedules acpi_ec_gpe_query.

3) ACPI scans for devices and adds the "real" embedded controller device,
freeing the (temporary) context of the old GPE query handler.

4) Queue runs acpi_ec_gpe_query with a context that has already been kfree'd,
causing it to fail.

It seems rather theoretical, but perhaps we could fix it with a patch like the
following.  I tested it for kicks and didn't hit any problems, but I'm afraid it
risks more problems than it solves.  Thoughts?

--- 1.27/drivers/acpi/ec.c	Mon Oct 27 03:50:57 2003
+++ edited/drivers/acpi/ec.c	Mon Oct 27 03:51:57 2003
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/delay.h>
+#include <linux/workqueue.h>
 #include <linux/proc_fs.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
@@ -593,6 +594,10 @@
 			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);

 		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);
+
+		/* Clear any pending GPE queries before freeing the context for
+		   their handlers */
+		flush_scheduled_work();

 		kfree(ec_ecdt);
 	}


