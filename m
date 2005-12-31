Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVLaLNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVLaLNj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVLaLNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:13:20 -0500
Received: from isilmar.linta.de ([213.239.214.66]:17623 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751332AbVLaLNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:13:14 -0500
Date: Sat, 31 Dec 2005 12:12:21 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>, len.brown@intel.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org
Subject: [PATCH 3/4] ACPI C-States: accounting of sleep times
Message-ID: <20051231111221.GD9123@dominikbrodowski.de>
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

Also track the actual time spent in C-States (C2 upwards, we can't
determine this for C1), not only the number of invocations. This is
especially useful for dynamic ticks / "tickless systems", but is also
of interest on normal systems, as any interrupt activity leads to
C-States being exited, not only the timer interrupt.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -280,8 +280,6 @@ static void acpi_processor_idle(void)
 		cx = &pr->power.states[ACPI_STATE_C1];
 #endif
 
-	cx->usage++;
-
 	/*
 	 * Sleep:
 	 * ------
@@ -379,6 +377,9 @@ static void acpi_processor_idle(void)
 		local_irq_enable();
 		return;
 	}
+	cx->usage++;
+	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
+		cx->time += sleep_ticks;
 
 	next_state = pr->power.state;
 
@@ -993,9 +994,10 @@ static int acpi_processor_power_seq_show
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
Index: working-tree/include/acpi/processor.h
===================================================================
--- working-tree.orig/include/acpi/processor.h
+++ working-tree/include/acpi/processor.h
@@ -51,6 +51,7 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
+	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };
