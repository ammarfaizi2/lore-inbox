Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWF1H1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWF1H1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWF1H1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:27:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:62323 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030428AbWF1H1x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:27:53 -0400
X-IronPort-AV: i="4.06,186,1149490800"; 
   d="scan'208"; a="57766359:sNHT219825753"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [1/4] ACPI C-States: accounting of sleep states
Date: Wed, 28 Jun 2006 03:27:47 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6DCECED@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [1/4] ACPI C-States: accounting of sleep states
Thread-Index: AcaT6Ur4nTzT5CPdTd2FO+AQAyOT4QGmwrKQ
From: "Brown, Len" <len.brown@intel.com>
To: "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Thomas Gleixner" <tglx@timesys.com>
Cc: "Con Kolivas" <kernel@kolivas.org>, "Ingo Molnar" <mingo@elte.hu>,
       "LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "john stultz" <johnstul@us.ibm.com>
X-OriginalArrivalTime: 28 Jun 2006 07:27:49.0320 (UTC) FILETIME=[5BCD9C80:01C69A84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied.
thanks,
-Len 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Dominik Brodowski
>Sent: Monday, June 19, 2006 5:29 PM
>To: Thomas Gleixner; Brown, Len
>Cc: Con Kolivas; Ingo Molnar; LKML; Andrew Morton; john stultz
>Subject: [1/4] ACPI C-States: accounting of sleep states
>
>Track the actual time spent in C-States (C2 upwards, we can't
>determine this for C1), not only the number of invocations. This is
>especially useful for dynamic ticks / "tickless systems", but is also
>of interest on normal systems, as any interrupt activity leads to
>C-States being exited, not only the timer interrupt.
>
>The time is being measured in PM timer ticks, so an increase 
>by one equals
>279 nanoseconds.
>
>Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
>---
>
> drivers/acpi/processor_idle.c |   10 ++++++----
> include/acpi/processor.h      |    1 +
> 2 files changed, 7 insertions(+), 4 deletions(-)
>
>3997a08ff5aa0553dfff81801c3690a5c91ac7bc
>diff --git a/drivers/acpi/processor_idle.c 
>b/drivers/acpi/processor_idle.c
>index 80fa434..4f166fa 100644
>--- a/drivers/acpi/processor_idle.c
>+++ b/drivers/acpi/processor_idle.c
>@@ -322,8 +322,6 @@ static void acpi_processor_idle(void)
> 		cx = &pr->power.states[ACPI_STATE_C1];
> #endif
> 
>-	cx->usage++;
>-
> 	/*
> 	 * Sleep:
> 	 * ------
>@@ -421,6 +419,9 @@ static void acpi_processor_idle(void)
> 		local_irq_enable();
> 		return;
> 	}
>+	cx->usage++;
>+	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
>+		cx->time += sleep_ticks;
> 
> 	next_state = pr->power.state;
> 
>@@ -1055,9 +1056,10 @@ static int acpi_processor_power_seq_show
> 		else
> 			seq_puts(seq, "demotion[--] ");
> 
>-		seq_printf(seq, "latency[%03d] usage[%08d]\n",
>+		seq_printf(seq, "latency[%03d] usage[%08d] 
>duration[%020llu]\n",
> 			   pr->power.states[i].latency,
>-			   pr->power.states[i].usage);
>+			   pr->power.states[i].usage,
>+			   pr->power.states[i].time);
> 	}
> 
>       end:
>diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>index badf027..ca0e031 100644
>--- a/include/acpi/processor.h
>+++ b/include/acpi/processor.h
>@@ -51,6 +51,7 @@ struct acpi_processor_cx {
> 	u32 latency_ticks;
> 	u32 power;
> 	u32 usage;
>+	u64 time;
> 	struct acpi_processor_cx_policy promotion;
> 	struct acpi_processor_cx_policy demotion;
> };
>-- 
>1.2.4
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
