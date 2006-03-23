Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWCWJKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWCWJKR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWCWJKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:10:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:24623 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751394AbWCWJKO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:10:14 -0500
X-IronPort-AV: i="4.03,121,1141632000"; 
   d="scan'208"; a="15334356:sNHT194295822"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Thu, 23 Mar 2006 17:10:00 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B4692FA@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZOQtBTmKUOxVwsQ++AyGpkbwBiLAAEEveg
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
X-OriginalArrivalTime: 23 Mar 2006 09:10:02.0675 (UTC) FILETIME=[917F9030:01C64E59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Good, then the hang should be caused by:
>
>			     Store (Arg0, HCSL)
>			     Store (ShiftLeft (Arg1, 0x01), HMAD)
>			     Store (Arg2, HMCM)
>			     Store (0x0B, HMPR)
>
>   Could you add this at the beginning of this block:
>	   Store (Arg0,  Debug)
>   And add this at the end of this block:
>	   Store( HMPR, Debug)
>
>I added those two lines to the DSDT with only THM0 zone, but with
>nothing else commented out.  Below are the dmesgs for one sleep-wake
>cycle, plus an 'acpi -t'.  I thought it would hang if I did one more
>cycle, but it didn't.  So I tried five more, and it was fine too.
>
>Then I reset /proc/acpi/acpi_debug_layer to 0x10 (the boot paramater is
>acpi_dbg_layer although the /proc file is acpi_debug_layer), and
>unloaded and reloaded the thermal module.  And it hung in the 
>(expected)
>two cycles.  I've seen this behavior before: It won't hang with lots of
>debugging turned on, but it does hang with less debugging.  Strange!

Hmmm, then I cannot get the ec access log for hang case?!

	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address
[%02x]\n",
			  *data, address));

Does it mean we need to slow down  acpi_ec_intr_read/write ?
Could you try to insert acpi_os_stall (100)  after  ACPI_DEBUG_PRINT
statement
both in acpi_ec_intr_read/write.
