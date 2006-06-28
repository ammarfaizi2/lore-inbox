Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbWF1H2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWF1H2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWF1H2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:28:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:43623 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030454AbWF1H2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:28:09 -0400
X-IronPort-AV: i="4.06,186,1149490800"; 
   d="scan'208"; a="57766509:sNHT72646651"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2/4] ACPI C-States: bm_activity improvements
Date: Wed, 28 Jun 2006 03:27:57 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6DCECEE@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2/4] ACPI C-States: bm_activity improvements
Thread-Index: AcaT6NL+v+PH59OCRYyPANrNAHyS7gGm4kFw
From: "Brown, Len" <len.brown@intel.com>
To: "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Thomas Gleixner" <tglx@timesys.com>
Cc: "Con Kolivas" <kernel@kolivas.org>, "Ingo Molnar" <mingo@elte.hu>,
       "LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "john stultz" <johnstul@us.ibm.com>
X-OriginalArrivalTime: 28 Jun 2006 07:27:59.0383 (UTC) FILETIME=[61CD1A70:01C69A84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied.
thanks,
-Len 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Dominik Brodowski
>Sent: Monday, June 19, 2006 5:30 PM
>To: Thomas Gleixner; Brown, Len
>Cc: Con Kolivas; Ingo Molnar; LKML; Andrew Morton; john stultz
>Subject: [2/4] ACPI C-States: bm_activity improvements
>
>Do not assume there was bus mastering activity if the idle 
>handler didn't
>get called, as there's only reason to not enter C3-type sleep 
>if there is
>bus master activity going on. Only for the "promotion" into 
>C3-type sleep
>bus mastering activity is taken into account, and there only 
>current bus
>mastering activity, and not pure guessing should lead to the 
>decision on
>whether to enter C3-type sleep or not.
>
>Also, as bm_activity is a jiffy-based bitmask (bit 0: bus 
>mastering activity
>during this juffy, bit 31: bus mastering activity 31 jiffies 
>ago), fix the
>setting of bit 0, as it might be called multiple times within 
>one jiffy.
>
>Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
>---
>
> drivers/acpi/processor_idle.c |   18 ++++++------------
> 1 files changed, 6 insertions(+), 12 deletions(-)
>
>2e1b29fabc1085e1ab5b05dcac5d59e82c633668
>diff --git a/drivers/acpi/processor_idle.c 
>b/drivers/acpi/processor_idle.c
>index 4f166fa..29470e1 100644
>--- a/drivers/acpi/processor_idle.c
>+++ b/drivers/acpi/processor_idle.c
>@@ -3,7 +3,7 @@
>  *
>  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
>  *  Copyright (C) 2001, 2002 Paul Diefenbaugh 
><paul.s.diefenbaugh@intel.com>
>- *  Copyright (C) 2004       Dominik Brodowski <linux@brodo.de>
>+ *  Copyright (C) 2004, 2005 Dominik Brodowski <linux@brodo.de>
>  *  Copyright (C) 2004  Anil S Keshavamurthy 
><anil.s.keshavamurthy@intel.com>
>  *  			- Added processor hotplug support
>  *  Copyright (C) 2005  Venkatesh Pallipadi 
><venkatesh.pallipadi@intel.com>
>@@ -261,21 +261,15 @@ static void acpi_processor_idle(void)
> 		u32 bm_status = 0;
> 		unsigned long diff = jiffies - 
>pr->power.bm_check_timestamp;
> 
>-		if (diff > 32)
>-			diff = 32;
>+		if (diff > 31)
>+			diff = 31;
> 
>-		while (diff) {
>-			/* if we didn't get called, assume 
>there was busmaster activity */
>-			diff--;
>-			if (diff)
>-				pr->power.bm_activity |= 0x1;
>-			pr->power.bm_activity <<= 1;
>-		}
>+		pr->power.bm_activity <<= diff;
> 
> 		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
> 				  &bm_status, ACPI_MTX_DO_NOT_LOCK);
> 		if (bm_status) {
>-			pr->power.bm_activity++;
>+			pr->power.bm_activity |= 0x1;
> 			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
> 					  1, ACPI_MTX_DO_NOT_LOCK);
> 		}
>@@ -287,7 +281,7 @@ static void acpi_processor_idle(void)
> 		else if (errata.piix4.bmisx) {
> 			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
> 			    || (inb_p(errata.piix4.bmisx + 
>0x0A) & 0x01))
>-				pr->power.bm_activity++;
>+				pr->power.bm_activity |= 0x1;
> 		}
> 
> 		pr->power.bm_check_timestamp = jiffies;
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
