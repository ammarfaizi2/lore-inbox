Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWGJTDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWGJTDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbWGJTDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:03:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:40036 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422771AbWGJTDH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:03:07 -0400
X-IronPort-AV: i="4.06,225,1149490800"; 
   d="scan'208"; a="95813326:sNHT16578464"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [linux-pm] [BUG] sleeping function called from invalid context during resume
Date: Mon, 10 Jul 2006 15:02:47 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ED008C@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [BUG] sleeping function called from invalid context during resume
Thread-Index: AcakNM1M7NjG3GAhSxm8xcurC0HI9QAHBoDg
From: "Brown, Len" <len.brown@intel.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Andrew Morton" <akpm@osdl.org>,
       <johnstul@us.ibm.com>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2006 19:02:49.0394 (UTC) FILETIME=[6FF0F120:01C6A453]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>... a similar fix needs to be made in
drivers/acpi/osl.c:acpi_os_wait_semaphore().
>If interrupts are disabled the timeout argument should be set to 0, so
that the 
>routine will call down_trylock() instead of down() or
schedule_timeout_interruptible().

We used to have a hack in acpi_os_wait_semaphore():

if (in_atomic())
	timeout = 0;

But we deleted it upon ACPICA 20060608 when the
ACPICA locks that were used at interrupt-time were
converted to be Linux spin-locks.

Now it is still conceivable that during resume before interrutps are
re-enabled,
the PCI interrupt link devices run AML and go to acquire an AML mutex
with
a timeout.  However, we are single threaded at that point, so it isn't
possible for them to acquire the mutex -- timeout or not.

I don't like the looks of the "workaround" above -- it makes the code
confusing.

I'd be open to putting a BUG_ON() in the sleep case if interrupts are
not enabled.

Is there another case that you can think of?

-Len
