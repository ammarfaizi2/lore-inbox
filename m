Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWF1H2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWF1H2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWF1H2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:28:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:43556 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030438AbWF1H2T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:28:19 -0400
X-IronPort-AV: i="4.06,186,1149490800"; 
   d="scan'208"; a="90377099:sNHT28293748"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [3/4] ACPI C-States: only demote on current bus mastering activity
Date: Wed, 28 Jun 2006 03:28:12 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6DCECEF@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [3/4] ACPI C-States: only demote on current bus mastering activity
Thread-Index: AcaT6MPTRzqrkO0qTc62bn1iczaAqQGm576Q
From: "Brown, Len" <len.brown@intel.com>
To: "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Thomas Gleixner" <tglx@timesys.com>
Cc: "Con Kolivas" <kernel@kolivas.org>, "Ingo Molnar" <mingo@elte.hu>,
       "LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "john stultz" <johnstul@us.ibm.com>
X-OriginalArrivalTime: 28 Jun 2006 07:28:14.0696 (UTC) FILETIME=[6AEDAE80:01C69A84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied.
thanks,
-Len 

>-----Original Message-----
>From: Dominik Brodowski [mailto:linux@dominikbrodowski.net] 
>Sent: Monday, June 19, 2006 5:31 PM
>To: Thomas Gleixner; Brown, Len
>Cc: Con Kolivas; Ingo Molnar; LKML; Andrew Morton; john stultz
>Subject: [3/4] ACPI C-States: only demote on current bus 
>mastering activity
>
>Only if bus master activity is going on at the present, we should
>avoid entering C3-type sleep, as it might be a faulty 
>transition. As long
>as the bm_activity bitmask was based on the number of calls to the ACPI
>idle function, looking at previous moments made sense. Now, 
>with it being
>based on what happened this jiffy, looking at this jiffy should be
>sufficient.
>
>Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> drivers/acpi/processor_idle.c |    7 ++++---
> 1 files changed, 4 insertions(+), 3 deletions(-)
>
>Index: linux-2.6.16-rc5-dt/drivers/acpi/processor_idle.c
>===================================================================
>--- linux-2.6.16-rc5-dt.orig/drivers/acpi/processor_idle.c	
>2006-02-27 20:32:58.000000000 +1100
>+++ linux-2.6.16-rc5-dt/drivers/acpi/processor_idle.c	
>2006-02-27 20:32:59.000000000 +1100
>@@ -287,10 +287,10 @@ static void acpi_processor_idle(void)
> 		pr->power.bm_check_timestamp = jiffies;
> 
> 		/*
>-		 * Apply bus mastering demotion policy.  
>Automatically demote
>+		 * If bus mastering is or was active this jiffy, demote
> 		 * to avoid a faulty transition.  Note that the 
>processor
> 		 * won't enter a low-power state during this 
>call (to this
>-		 * funciton) but should upon the next.
>+		 * function) but should upon the next.
> 		 *
> 		 * TBD: A better policy might be to fallback to 
>the demotion
> 		 *      state (use it for this quantum only) istead of
>@@ -298,7 +298,8 @@ static void acpi_processor_idle(void)
> 		 *      qualification.  This may, however, introduce DMA
> 		 *      issues (e.g. floppy DMA transfer 
>overrun/underrun).
> 		 */
>-		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
>+		if ((pr->power.bm_activity & 0x1) &&
>+		    cx->demotion.threshold.bm) {
> 			local_irq_enable();
> 			next_state = cx->demotion.state;
> 			goto end;
>
