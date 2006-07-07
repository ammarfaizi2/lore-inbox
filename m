Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWGGQdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWGGQdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWGGQdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:33:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:32302 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932208AbWGGQdU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:33:20 -0400
X-IronPort-AV: i="4.06,218,1149490800"; 
   d="scan'208"; a="94692390:sNHT16835189"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] sleeping function called from invalid context during resume
Date: Fri, 7 Jul 2006 12:32:41 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF5EB@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] sleeping function called from invalid context during resume
Thread-Index: AcaheKrAwG6dLP16R0+Gn310zAzdmwAaX77g
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <johnstul@us.ibm.com>, <linux-kernel@vger.kernel.org>, <pavel@suse.cz>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 07 Jul 2006 16:33:04.0913 (UTC) FILETIME=[0588B010:01C6A1E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> >I got the following on my laptop w/ 2.6.18-rc1.
>> >
>> >thanks
>> >-john
>> >
>> >Stopping tasks:
>> >================================================================
>> >=======================|
>> >pnp: Device 00:0b disabled.
>> >ACPI: PCI interrupt for device 0000:02:01.0 disabled
>> >ACPI: PCI interrupt for device 0000:00:1f.5 disabled
>> >ACPI: PCI interrupt for device 0000:00:1d.7 disabled
>> >ACPI: PCI interrupt for device 0000:00:1d.2 disabled
>> >ACPI: PCI interrupt for device 0000:00:1d.1 disabled
>> >ACPI: PCI interrupt for device 0000:00:1d.0 disabled
>> >Intel machine check architecture supported.
>> >Intel machine check reporting enabled on CPU#0.
>> >Back to C!
>> >BUG: sleeping function called from invalid context at mm/slab.c:2882
>> >in_atomic():0, irqs_disabled():1
>> > [<c0103d59>] show_trace_log_lvl+0x149/0x170
>> > [<c01052ab>] show_trace+0x1b/0x20
>> > [<c01052d4>] dump_stack+0x24/0x30
>> > [<c0116e51>] __might_sleep+0xa1/0xc0
>> > [<c0165cb5>] kmem_cache_zalloc+0xa5/0xc0
>> > [<c0264b5a>] acpi_os_acquire_object+0x11/0x41
>> 
>> yep, the new slab for objects makes this path immune to
>> the acpi_in_resume hack in acpi_os_allocate()
>
>hm.  Linus's new suspend/resume thing seems to have a 
>two-phase suspend,
>but not, afaict, a two-phase resume.  If it did, and if the 
>second resume
>phase were to run with IRQs enabled then we should be able to 
>address this
>appropriately.
>
>> I think we need to get rid of the acpi_in_resume hack
>> and use system_state != SYSTEM_RUNNING to address this.
>
>Well if hacks are OK it'd actually be reliable to do
>
>	/* comment goes here */
>	kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
>
>because the irqs_disabled() thing happens for well-defined reasons. 
>Certainly that's better than looking at system_state (and I 
>don't think we
>leave SYSTEM_RUNNING during suspend/resume anyway).

If system_state != SYSTEM_RUNNING on resume, theen __might_sleep()
would not have spit out the dump_stack() above.

This is exactly like boot -- we are bringing up the system
and we need to configure interrupts, which runs AML,
which calls kmalloc in a variety of ways, all of which call
__might_sleep.

It seems simplest to have resume admit that it is like boot
and that the early allocations with interrupts off simply
must succeed or it is game-off.

-Len
