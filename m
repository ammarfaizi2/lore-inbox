Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWFSVgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWFSVgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWFSVf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:35:57 -0400
Received: from isilmar.linta.de ([213.239.214.66]:38595 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932542AbWFSVfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:35:54 -0400
Date: Mon, 19 Jun 2006 23:28:52 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Gleixner <tglx@timesys.com>, len.brown@intel.com
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>
Subject: [1/4] ACPI C-States: accounting of sleep states
Message-ID: <20060619212852.GA12338@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Gleixner <tglx@timesys.com>, len.brown@intel.com,
	Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	john stultz <johnstul@us.ibm.com>
References: <1150643426.27073.17.camel@localhost.localdomain> <200606191521.05508.kernel@kolivas.org> <20060619122606.GA19451@elte.hu> <200606200003.26008.kernel@kolivas.org> <1150747611.29299.77.camel@localhost.localdomain> <20060619205718.GA26332@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619205718.GA26332@isilmar.linta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Track the actual time spent in C-States (C2 upwards, we can't
determine this for C1), not only the number of invocations. This is
especially useful for dynamic ticks / "tickless systems", but is also
of interest on normal systems, as any interrupt activity leads to
C-States being exited, not only the timer interrupt.

The time is being measured in PM timer ticks, so an increase by one equals
279 nanoseconds.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/acpi/processor_idle.c |   10 ++++++----
 include/acpi/processor.h      |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

3997a08ff5aa0553dfff81801c3690a5c91ac7bc
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 80fa434..4f166fa 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -322,8 +322,6 @@ static void acpi_processor_idle(void)
 		cx = &pr->power.states[ACPI_STATE_C1];
 #endif
 
-	cx->usage++;
-
 	/*
 	 * Sleep:
 	 * ------
@@ -421,6 +419,9 @@ static void acpi_processor_idle(void)
 		local_irq_enable();
 		return;
 	}
+	cx->usage++;
+	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
+		cx->time += sleep_ticks;
 
 	next_state = pr->power.state;
 
@@ -1055,9 +1056,10 @@ static int acpi_processor_power_seq_show
 		else
 			seq_puts(seq, "demotion[--] ");
 
-		seq_printf(seq, "latency[%03d] usage[%08d]\n",
+		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020llu]\n",
 			   pr->power.states[i].latency,
-			   pr->power.states[i].usage);
+			   pr->power.states[i].usage,
+			   pr->power.states[i].time);
 	}
 
       end:
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index badf027..ca0e031 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -51,6 +51,7 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
+	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };
-- 
1.2.4

