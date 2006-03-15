Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752056AbWCOGRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbWCOGRG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 01:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWCOGRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 01:17:05 -0500
Received: from fmr20.intel.com ([134.134.136.19]:41370 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752056AbWCOGRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 01:17:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Wed, 15 Mar 2006 14:16:02 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B32AA80@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZH81nAKta9OGGtR6mpQz040Tb/yQAAyxCQ
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
X-OriginalArrivalTime: 15 Mar 2006 06:16:05.0945 (UTC) FILETIME=[F16AF290:01C647F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Could you just comment out _TMP in kernel or in DSDT, 
>
>I think it needs both excisions: If I comment out just the kernel _TMP
>calls, the DSDT might slip one in through the interpreter.  If I
>comment out just the DSDT _TMP calls, then the kernel can still call
>_TMP.  So instead I modified acpi_evaluate_integer() to return 27 C
>(3000 dK) if it's ever asked for a temperature, without doing any
>actual work:
>
>--- utils.c.orig	2006-02-27 00:09:35.000000000 -0500
>+++ utils.c		2006-03-14 23:36:59.000000000 -0500
>@@ -270,7 +270,15 @@ acpi_evaluate_integer(acpi_handle handle
>   memset(element, 0, sizeof(union acpi_object));
>   buffer.length = sizeof(union acpi_object);
>   buffer.pointer = element;
>-  status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
>+  if (strcmp(pathname, "_TMP") != 0)
>+    status = acpi_evaluate_object(handle, pathname, 
>arguments, &buffer);
>+    else {
>+      printk(KERN_INFO PREFIX "acpi_evaluate_integer: Faking _TMP\n");
>+        status = AE_OK;
>+	   element->type = ACPI_TYPE_INTEGER;
>+	     element->integer.value = 3000; /* 27 C, in deciKelvins */
>+	     }
>+
>	if (ACPI_FAILURE(status)) {
>	   acpi_util_eval_error(handle, pathname, status);
>					return_ACPI_STATUS(status);
>
>This diff is in addition to the previous debugging changes to
>thermal.c.

If you do it in this way, all thermal zone's _TMP will be faked.
If you remove the real THM0._TMP, and fake a dummy THM0._TMP
in DSDT, and don't change anything in kernel, then if S3 works
well, I will be convinced that THM0._TMP was causing trouble.
Yes, I'm asking you to override DSDT for debugging. :-)
But, please make sure don't change other things in DSDT, otherwise
it still won't be trusted. :-)

Anyway, I'm studying THM0._TMP, and try to figure out how it is related
with EC. 

Thanks,
Luming
