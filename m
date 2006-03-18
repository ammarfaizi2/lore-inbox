Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWCRPKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWCRPKl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWCRPKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:10:41 -0500
Received: from mga03.intel.com ([143.182.124.21]:16461 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932392AbWCRPKj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:10:39 -0500
X-IronPort-AV: i="4.03,106,1141632000"; 
   d="scan'208"; a="13395597:sNHT169392104"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Sat, 18 Mar 2006 23:10:32 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC268@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZKmfzUa0Bhp+hMQH63w39+eBJM1AAATzQw
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
X-OriginalArrivalTime: 18 Mar 2006 15:10:33.0863 (UTC) FILETIME=[1AA02970:01C64A9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Hmm,  probably, you need to do :
>>
>> 4. in acpi_thermal_notify,
>>       if (acpi_in_suspend == YES)
>>               do nothing.
>
>I've just tested that.  It suspended twice without problem, which made
>me think the problem was solved.  But it hung on the third suspend!

I'm NOT surprised about that hung, because kernel thread kacpid 
is a kernel worker thread that has flag PF_NOFREEZE, that means
kacpid won't be freezed.  I tried to freeze kacpid, but end up with 
this conclusion.  From my understanding, for safety concern,
kernel worker thread should be freezed. Because, kacpid could
invoke AML methods that we are trying to avoid during suspend.

Please try additional ugly hack
 5. in acpi_os_queue_for_execution:
	if(acpi_in_suspend == YES)
		do nothing.

Also, please add acpi_debug_layer=0x10 acpi_debug_leve=0x10 
boot option, then you can observe what methods were executed
before suspend.

Thanks,
Luming
