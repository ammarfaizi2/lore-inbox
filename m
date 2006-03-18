Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWCRCCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWCRCCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 21:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932843AbWCRCCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 21:02:52 -0500
Received: from mga03.intel.com ([143.182.124.21]:7696 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751290AbWCRCCv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 21:02:51 -0500
X-IronPort-AV: i="4.03,106,1141632000"; 
   d="scan'208"; a="13353441:sNHT81737159"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Sat, 18 Mar 2006 10:02:45 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC266@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZJ8uRY84M1X2LHS4S2zg01RXuPJwAOGzaw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 18 Mar 2006 02:02:46.0289 (UTC) FILETIME=[0CF4C010:01C64A30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So, please try hack thermal.c by removing calls to _TMP.
>
>I did something like that before, by changing acpi_evaluate_integer()
>to return 3000 if it is asked for _TMP.  
>
>--- a/utils.c	2006-03-15 01:42:34.000000000 -0500
>+++ b/utils.c	2006-03-14 23:36:59.000000000 -0500
>@@ -270,7 +270,15 @@ acpi_evaluate_integer(acpi_handle handle
> 	memset(element, 0, sizeof(union acpi_object));
> 	buffer.length = sizeof(union acpi_object);
> 	buffer.pointer = element;
>-	status = acpi_evaluate_object(handle, pathname, 
>arguments, &buffer);
>+	if (strcmp(pathname, "_TMP") != 0)
>+	  status = acpi_evaluate_object(handle, pathname, 
>arguments, &buffer);
>+	else {
>+	  printk(KERN_INFO PREFIX "acpi_evaluate_integer: 
>Faking _TMP\n");
>+	  status = AE_OK;
>+	  element->type = ACPI_TYPE_INTEGER;
>+	  element->integer.value = 3000; /* 27 C, in deciKelvins */
>+	}
>+
> 	if (ACPI_FAILURE(status)) {
> 		acpi_util_eval_error(handle, pathname, status);
> 		return_ACPI_STATUS(status);
>
>
>The alternative, obvious change in thermal.c (diff below) turns out
>not to be a minimal change.  If acpi_thermal_get_temperature() returns
>with a failure, then most of the later methods in THM0 aren't
>executed, so one is actually commenting out much more than _TMP.
>
>Which is why I think the minimal change is the diff above to utils.c.
>With that change the system never hung.

Good, this is exactly what I wanted.  How many times you tested with
this
hack without hang?  If s3 hang really goes away , then probably you can
move on , and come up with a real patch that could go into the 2.6.16. 
What do you think? :-)

The short-term proper way could be:
1. add a global variable: acpi_in_suspend.
2. in acpi_pm_prepare:
	a.call acpi_os_wait_events_complete()
	b.set acpi_in_suspend = YES.
   in acpi_pm_finish :
	set acpi_in_suspend = NO.
3. in acpi_thermal_run:
	if (acpi_in_suspend == YES)
		do nothing.

The long-term proper way should be:
1. ACPI subsystem should stop invoking BIOS before Suspend except
for several necessary AML methods that are required to put 
the platform into S3 state.  Otherwise, un-tested BIOS code path 
could cause trouble to linux, because I assume such platform 
should have been tested under windows. 

Thanks,
Luming
 
