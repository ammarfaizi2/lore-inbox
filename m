Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWFSVfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWFSVfy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWFSVfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:35:54 -0400
Received: from isilmar.linta.de ([213.239.214.66]:35011 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932510AbWFSVfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:35:53 -0400
Date: Mon, 19 Jun 2006 23:29:38 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Gleixner <tglx@timesys.com>, len.brown@intel.com
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>
Subject: [2/4] ACPI C-States: bm_activity improvements
Message-ID: <20060619212938.GB12338@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Gleixner <tglx@timesys.com>, len.brown@intel.com,
	Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	john stultz <johnstul@us.ibm.com>
References: <1150643426.27073.17.camel@localhost.localdomain> <200606191521.05508.kernel@kolivas.org> <20060619122606.GA19451@elte.hu> <200606200003.26008.kernel@kolivas.org> <1150747611.29299.77.camel@localhost.localdomain> <20060619205718.GA26332@isilmar.linta.de> <20060619212852.GA12338@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619212852.GA12338@dominikbrodowski.de>
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

---

 drivers/acpi/processor_idle.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

2e1b29fabc1085e1ab5b05dcac5d59e82c633668
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4f166fa..29470e1 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
- *  Copyright (C) 2004       Dominik Brodowski <linux@brodo.de>
+ *  Copyright (C) 2004, 2005 Dominik Brodowski <linux@brodo.de>
  *  Copyright (C) 2004  Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
  *  			- Added processor hotplug support
  *  Copyright (C) 2005  Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
@@ -261,21 +261,15 @@ static void acpi_processor_idle(void)
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
@@ -287,7 +281,7 @@ static void acpi_processor_idle(void)
 		else if (errata.piix4.bmisx) {
 			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
 			    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity++;
+				pr->power.bm_activity |= 0x1;
 		}
 
 		pr->power.bm_check_timestamp = jiffies;
-- 
1.2.4

