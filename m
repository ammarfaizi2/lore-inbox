Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTJWE1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 00:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTJWE1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 00:27:18 -0400
Received: from mail3.mx.voyager.net ([216.93.66.202]:29452 "EHLO
	mail3.mx.voyager.net") by vger.kernel.org with ESMTP
	id S261659AbTJWE1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 00:27:15 -0400
Message-ID: <3F97596F.3E1A6F23@megsinet.net>
Date: Wed, 22 Oct 2003 23:30:39 -0500
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.0-test8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test8 ISAPNP ne.c initialization
References: <Pine.LNX.4.10.10009211329001.1627-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------2F713DCA7B4EC81E21957377"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F713DCA7B4EC81E21957377
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

 The level of isapnp_init was moved to after apci sometime ago.  Since it is now
 after net_dev_init, ISA PNP NICs fail to initialized at boot.  This is particularily
 problematic for NFS root filesystems like mine, or none modular systems.
 I've been patching my kernel since at least 2.5.65 with the attached...

 This fix allows ISA PNP NIC cards to work during net_dev_init, and still
 leaves isapnp_init after apci_init, though I don't know if it is the right
 thing todo, it works for me...

Comments from Alan Cox a long while back:
>We must initialise ACPI before ISAPnP because we need PCI and ACPI to
>know what system resources we must not hit. How about moving the
>net_dev_init to later?

Here is the ordering of initcall from System.map file w/ my changes
on 2.6.0-test8.

c044a700 t __initcall_acpi_pci_link_init
c044a704 t __initcall_acpi_power_init
c044a708 t __initcall_acpi_system_init
c044a70c t __initcall_acpi_event_init
c044a710 t __initcall_acpi_scan_init
c044a714 t __initcall_pnp_init
c044a718 t __initcall_pnp_system_init
c044a71c t __initcall_device_init
c044a720 t __initcall_as_slab_setup
c044a724 t __initcall_deadline_slab_setup
c044a728 t __initcall_input_init
c044a72c t __initcall_i2c_init
c044a730 t __initcall_pci_acpi_init
c044a734 t __initcall_pci_legacy_init
c044a738 t __initcall_pcibios_irq_init
c044a73c t __initcall_pcibios_init
c044a740 t __initcall_isapnp_init
c044a744 t __initcall_chr_dev_init
c044a748 t __initcall_net_dev_init
c044a74c t __initcall_i8259A_init_sysfs
c044a750 t __initcall_init_timer_sysfs
c044a754 t __initcall_time_init_device


I assume System.map is the place to see initcall ordering?

Martin
--------------2F713DCA7B4EC81E21957377
Content-Type: text/plain; charset=us-ascii;
 name="test8.isapnp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test8.isapnp.patch"

--- linux-2.6.0-test8.virgin/drivers/pnp/isapnp/core.c	Sat Sep 27 23:17:52 2003
+++ linux-2.6.0-test8/drivers/pnp/isapnp/core.c	Sat Sep 27 23:20:18 2003
@@ -1160,7 +1160,7 @@
 	return 0;
 }
 
-device_initcall(isapnp_init);
+fs_initcall(isapnp_init);
 
 /* format is: noisapnp */
 
--- linux-2.6.0-test8.virgin/net/core/dev.c	Sat Oct 18 09:36:27 2003
+++ linux-2.6.0-test8/net/core/dev.c	Wed Oct 22 23:22:57 2003
@@ -3018,7 +3018,7 @@
 	return rc;
 }
 
-subsys_initcall(net_dev_init);
+fs_initcall(net_dev_init);
 
 EXPORT_SYMBOL(__dev_get);
 EXPORT_SYMBOL(__dev_get_by_flags);

--------------2F713DCA7B4EC81E21957377--

