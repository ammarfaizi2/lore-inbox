Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVCYMzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVCYMzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 07:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCYMzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 07:55:41 -0500
Received: from fmr19.intel.com ([134.134.136.18]:35299 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261610AbVCYMzd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 07:55:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.12-rc1-mm3: box hangs solid on resume from disk while resuming device drivers
Date: Fri, 25 Mar 2005 20:54:13 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575017EDC38@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.12-rc1-mm3: box hangs solid on resume from disk while resuming device drivers
Thread-Index: AcUxLfFKZDDJOWFoSCS5dJTFqHnEzwAC5WhA
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, "Andrew Morton" <akpm@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>,
       "Pavel Machek" <pavel@suse.cz>
X-OriginalArrivalTime: 25 Mar 2005 12:54:17.0690 (UTC) FILETIME=[C15CABA0:01C53139]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>On Friday, 25 of March 2005 09:21, Andrew Morton wrote:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-
>rc1/2.6.12-rc1-mm3/
>>
>> - Mainly a bunch of fixes relative to 2.6.12-rc1-mm2.
>
>First, rmmod works again (thanks ;-)).
>
>> - Again, we'd like people who have had recent DRM and USB resume
problems
>to
>>   test and report, please.
>
>My box is still hanged solid on resume (swsusp) by the drivers:
>
>ohci_hcd
>ehci_hcd
>yenta_socket
>
>possibly others, too.  To avoid this, I had to revert the following
patch
>from
>the Len's tree:
>
>diff -Naru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>--- a/drivers/acpi/pci_link.c	2005-03-24 04:57:27 -08:00
>+++ b/drivers/acpi/pci_link.c	2005-03-24 04:57:27 -08:00
>@@ -72,10 +72,12 @@
> 	u8			active;			/* Current IRQ
*/
> 	u8			edge_level;		/* All IRQs */
> 	u8			active_high_low;	/* All IRQs */
>-	u8			initialized;
> 	u8			resource_type;
> 	u8			possible_count;
> 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>+	u8			initialized:1;
>+	u8			suspend_resume:1;
>+	u8			reserved:6;
> };
>
> struct acpi_pci_link {
>@@ -530,6 +532,10 @@
>
> 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
>
>+	if (link->irq.suspend_resume) {
>+		acpi_pci_link_set(link, link->irq.active);
>+		link->irq.suspend_resume = 0;
>+	}
> 	if (link->irq.initialized)
> 		return_VALUE(0);

How about just remove below line:
>+		acpi_pci_link_set(link, link->irq.active);

Thanks,
Shaohua
