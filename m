Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVLDNBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVLDNBl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 08:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVLDNBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 08:01:41 -0500
Received: from isilmar.linta.de ([213.239.214.66]:1685 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932202AbVLDNBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 08:01:40 -0500
Date: Sun, 4 Dec 2005 13:55:12 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       Adam Belay <abelay@novell.com>, Daniel Petrini <d.pensator@gmail.com>,
       vatsa@in.ibm.com, acpi-devel@lists.sourceforge.net
Subject: busmaster and C-States [Was: [PATCH] i386 no idle HZ aka Dynticks 051203]
Message-ID: <20051204125512.GA9501@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
	Adam Belay <abelay@novell.com>,
	Daniel Petrini <d.pensator@gmail.com>, vatsa@in.ibm.com,
	acpi-devel@lists.sourceforge.net
References: <200512041737.07996.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512041737.07996.kernel@kolivas.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of Con Koliva's approach to fix dyntick and the busmaster logic in
the ACPI idle handler (see
http://ck.kolivas.org/patches/dyn-ticks/split-out/dyntick-busmaster_support.patch
) I propose this different patch as a replacement. Its
skipped_since_bm_check() is broken, as it returns the number of ticks we
hope to go to sleep for _now_, not how long we slept last time.

Some test result:
ck:
   *C2:                  type[C2] promotion[C3] demotion[C1] latency[001]
        usage[00066141] time[00000000001817309417]
    C3:                  type[C3] promotion[--] demotion[C2] latency[085]
        usage[00005760] time[00000000000138436523]
At average, sleeping for 7 ticks when in C2
At average, sleeping for 6 ticks when in C3
me:
    C2:                  type[C2] promotion[C3] demotion[C1] latency[001]
usage[00143551] time[00000000002930357624]
   *C3:                  type[C3] promotion[--] demotion[C2] latency[085]
usage[00079181] time[00000000002733459218]
At average, sleeping for 5 ticks when in C2
At average, sleeping for 9 ticks when in C3


Not perfect yet (but see the next patch), but better.


Only avoid entering C3-type sleep if there is bus master activity at the
moment. 

Also, bus mastering activity going on while we slept can be ignored.
Therefore, adjust the bm_check_timestamp accordingly.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -256,7 +256,7 @@ static void acpi_processor_idle(void)
 		pr->power.bm_check_timestamp = jiffies;
 
 		/*
-		 * Apply bus mastering demotion policy.  Automatically demote
+		 * If bus mastering is active, automatically demote
 		 * to avoid a faulty transition.  Note that the processor
 		 * won't enter a low-power state during this call (to this
 		 * funciton) but should upon the next.
@@ -267,7 +267,7 @@ static void acpi_processor_idle(void)
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
-		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
+		if (bm_status && cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
 			goto end;
@@ -391,6 +391,10 @@ static void acpi_processor_idle(void)
 		cx->time += (PM_TIMER_FREQUENCY / (2 * HZ));
 	}
 
+	if (pr->flags.bm_check)
+		pr->power.bm_check_timestamp += sleep_ticks /
+			(PM_TIMER_FREQUENCY / HZ);
+
 	next_state = pr->power.state;
 
 	/*
