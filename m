Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVLaLNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVLaLNn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVLaLNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:13:19 -0500
Received: from isilmar.linta.de ([213.239.214.66]:14039 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751326AbVLaLNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:13:12 -0500
Date: Sat, 31 Dec 2005 12:11:10 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>, len.brown@intel.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/4] ACPI C-States: bm_activity improvements
Message-ID: <20051231111110.GB9123@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>, len.brown@intel.com,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Pavel Machek <pavel@ucw.cz>,
	Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, linux-acpi@vger.kernel.org
References: <200512281718.14897.kernel@kolivas.org> <20051231110955.GA9123@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051231110955.GA9123@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not assume there was bus mastering activity if the idle handler didn't
get called, as there's only reason to not enter C3-type sleep if there is
bus master activity going on. Only for the "promotion" into C3-type sleep
bus mastering activity is taken into account, and there only current bus
mastering activity, and not pure guessing should lead to the decision on
whether to enter C3-type sleep or not.

Also, as bm_activity is a jiffy-based bitmask (bit 0: bus mastering activity
during this juffy, bit 31: bus mastering activity 31 jiffies ago), fix the
setting of bit 0, as it might be called multiple times within one jiffy.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
- *  Copyright (C) 2004       Dominik Brodowski <linux@brodo.de>
+ *  Copyright (C) 2004, 2005 Dominik Brodowski <linux@brodo.de>
  *  Copyright (C) 2004  Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
  *  			- Added processor hotplug support
  *  Copyright (C) 2005  Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
@@ -224,21 +224,15 @@ static void acpi_processor_idle(void)
 		u32 bm_status = 0;
 		unsigned long diff = jiffies - pr->power.bm_check_timestamp;
 
-		if (diff > 32)
-			diff = 32;
+		if (diff > 31)
+			diff = 31;
 
-		while (diff) {
-			/* if we didn't get called, assume there was busmaster activity */
-			diff--;
-			if (diff)
-				pr->power.bm_activity |= 0x1;
-			pr->power.bm_activity <<= 1;
-		}
+		pr->power.bm_activity <<= diff;
 
 		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
 				  &bm_status, ACPI_MTX_DO_NOT_LOCK);
 		if (bm_status) {
-			pr->power.bm_activity++;
+			pr->power.bm_activity |= 0x1;
 			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
 					  1, ACPI_MTX_DO_NOT_LOCK);
 		}
@@ -250,7 +244,7 @@ static void acpi_processor_idle(void)
 		else if (errata.piix4.bmisx) {
 			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
 			    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity++;
+				pr->power.bm_activity |= 0x1;
 		}
 
 		pr->power.bm_check_timestamp = jiffies;
