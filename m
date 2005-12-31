Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVLaLNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVLaLNO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVLaLNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:13:13 -0500
Received: from isilmar.linta.de ([213.239.214.66]:10455 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751327AbVLaLNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:13:12 -0500
Date: Sat, 31 Dec 2005 12:11:50 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>, len.brown@intel.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/4] ACPI C-States: bm_activity handling improvement
Message-ID: <20051231111150.GC9123@dominikbrodowski.de>
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

Only if bus master activity is going on at the present, we should
avoid entering C3-type sleep, as it might be a faulty transition. As long
as the bm_activity bitmask was based on the number of calls to the ACPI
idle function, looking at previous moments made sense. Now, with it being
based on what happened this jiffy, looking at this jiffy should be
sufficient.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -250,10 +250,10 @@ static void acpi_processor_idle(void)
 		pr->power.bm_check_timestamp = jiffies;
 
 		/*
-		 * Apply bus mastering demotion policy.  Automatically demote
+		 * If bus mastering is or was active this jiffy, demote
 		 * to avoid a faulty transition.  Note that the processor
 		 * won't enter a low-power state during this call (to this
-		 * funciton) but should upon the next.
+		 * function) but should upon the next.
 		 *
 		 * TBD: A better policy might be to fallback to the demotion
 		 *      state (use it for this quantum only) istead of
@@ -261,7 +261,8 @@ static void acpi_processor_idle(void)
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
-		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
+		if ((pr->power.bm_activity & 0x1) &&
+		    cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
 			goto end;
