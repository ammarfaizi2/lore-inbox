Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUCZF1a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263948AbUCZF1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:27:30 -0500
Received: from fmr01.intel.com ([192.55.52.18]:49806 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263944AbUCZF1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:27:13 -0500
Subject: Re: [BUG 2.6.5-rc2-bk5 and 2.6.5-rc2-mm3] ACPI seems to be broken
From: Len Brown <len.brown@intel.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcel Holtmann <marcel@holtmann.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Rik van Ballegooijen <sleightofmind@xs4all.nl>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F6523@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F6523@hdsmsx402.hd.intel.com>
Content-Type: multipart/mixed; boundary="=-V6htaBMAzI06OTMadD6T"
Organization: 
Message-Id: <1080278805.755.157.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Mar 2004 00:26:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V6htaBMAzI06OTMadD6T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)
> 
> > ACPI: SCI (IRQ22) allocation failed
> >  ACPI-0133: *** Error: Unable to install System Control Interrupt
> Handler, AE_NOT_ACQUIRED
> > ACPI: Unable to start the ACPI Interpreter

> working this issue here:
> http://bugzilla.kernel.org/show_bug.cgi?id=2366

Can somebody with hardware that exhibits this problem
apply the following 1-liner patch to the latest tree
and send me your dmesg and /proc/interrupts,
or attach it to the bug report?
(sorry for the wrap, attachment is non-wrapped).

===== drivers/acpi/bus.c 1.40 vs edited =====
--- 1.40/drivers/acpi/bus.c	Tue Mar 23 01:32:11 2004
+++ edited/drivers/acpi/bus.c	Thu Mar 25 23:50:41 2004
@@ -623,7 +623,8 @@
 		 * now that acpi_fadt is initialized,
 		 * update it with result from INT_SRC_OVR parsing
 		 */
-		acpi_fadt.sci_int = acpi_sci_override_gsi;
+		printk("acpi_fadt.sci_int %d acpi_sci_override_gsi %d\n",
+			acpi_fadt.sci_int, acpi_sci_override_gsi);
 	}
 #endif
 

In this example, this will claim IRQ9 for APIC INITIN 0-22
while traditionally we've called this IRQ22.

This brings up the bigger question of what an IRQ or GSI is...
in PIC mode they are wires on the PIC.
In APIC mode you sort of aggregate all the IOAPICS into
one linear list and call the GSI the logical INITIN number.
So why do we call the timer interrupt IRQ0 in this mode
when it is really connected to INTIN 2?  If we're consistent
with that then we should call the SCI IRQ9 instead of IRQ22...

In MSI mode, the GSI is the vector number on the CPU,
unless it is for one of the legacy IRQs, in which case
/proc/interrupts shows the PIC IRQ#.

confusing.

-Len


--=-V6htaBMAzI06OTMadD6T
Content-Disposition: attachment; filename=bus.patch
Content-Type: text/plain; name=bus.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/acpi/bus.c 1.40 vs edited =====
--- 1.40/drivers/acpi/bus.c	Tue Mar 23 01:32:11 2004
+++ edited/drivers/acpi/bus.c	Thu Mar 25 23:50:41 2004
@@ -623,7 +623,8 @@
 		 * now that acpi_fadt is initialized,
 		 * update it with result from INT_SRC_OVR parsing
 		 */
-		acpi_fadt.sci_int = acpi_sci_override_gsi;
+		printk("acpi_fadt.sci_int %d acpi_sci_override_gsi %d\n",
+			acpi_fadt.sci_int, acpi_sci_override_gsi);
 	}
 #endif
 

--=-V6htaBMAzI06OTMadD6T--

