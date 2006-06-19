Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWFSVfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWFSVfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWFSVfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:35:55 -0400
Received: from isilmar.linta.de ([213.239.214.66]:36291 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932506AbWFSVfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:35:53 -0400
Date: Mon, 19 Jun 2006 23:31:28 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Gleixner <tglx@timesys.com>, len.brown@intel.com
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>
Subject: [3/4] ACPI C-States: only demote on current bus mastering activity
Message-ID: <20060619213128.GC12338@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Gleixner <tglx@timesys.com>, len.brown@intel.com,
	Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	john stultz <johnstul@us.ibm.com>
References: <1150643426.27073.17.camel@localhost.localdomain> <200606191521.05508.kernel@kolivas.org> <20060619122606.GA19451@elte.hu> <200606200003.26008.kernel@kolivas.org> <1150747611.29299.77.camel@localhost.localdomain> <20060619205718.GA26332@isilmar.linta.de> <20060619212852.GA12338@dominikbrodowski.de> <20060619212938.GB12338@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619212938.GB12338@dominikbrodowski.de>
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

 drivers/acpi/processor_idle.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc5-dt/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.16-rc5-dt.orig/drivers/acpi/processor_idle.c	2006-02-27 20:32:58.000000000 +1100
+++ linux-2.6.16-rc5-dt/drivers/acpi/processor_idle.c	2006-02-27 20:32:59.000000000 +1100
@@ -287,10 +287,10 @@ static void acpi_processor_idle(void)
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
@@ -298,7 +298,8 @@ static void acpi_processor_idle(void)
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
-		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
+		if ((pr->power.bm_activity & 0x1) &&
+		    cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
 			goto end;
