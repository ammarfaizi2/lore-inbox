Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVLFGLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVLFGLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 01:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVLFGLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 01:11:42 -0500
Received: from isilmar.linta.de ([213.239.214.66]:3457 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S964880AbVLFGLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 01:11:41 -0500
Date: Tue, 6 Dec 2005 07:11:39 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
       Daniel Petrini <d.pensator@gmail.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH] i386 No Idle HZ aka dynticks v051205
Message-ID: <20051206061139.GA691@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>,
	linux list <linux-kernel@vger.kernel.org>,
	ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
	vatsa@in.ibm.com, Daniel Petrini <d.pensator@gmail.com>,
	acpi-devel@lists.sourceforge.net
References: <200512051154.45500.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512051154.45500.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please merge this patch also into your dyntick patchset. Upon further
refleciton, we shouldn't be _this_ aggressive to enter C3-type sleep if
there was bus mastering activity this jiffy.

Signed-off-by: Dominik Brodowski	<linux@dominikbrodowski.net>

Index: working-tree/drivers/acpi/processor_idle.c
===================================================================
--- working-tree.orig/drivers/acpi/processor_idle.c
+++ working-tree/drivers/acpi/processor_idle.c
@@ -260,7 +260,7 @@ static void acpi_processor_idle(void)
 		pr->power.bm_check_timestamp = jiffies;
 
 		/*
-		 * If bus mastering is active, automatically demote
+		 * If bus mastering is or was active this jiffy, demote
 		 * to avoid a faulty transition.  Note that the processor
 		 * won't enter a low-power state during this call (to this
 		 * function) but should upon the next.
@@ -271,7 +271,8 @@ static void acpi_processor_idle(void)
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
-		if (bm_status && cx->demotion.threshold.bm) {
+		if ((pr->power.bm_activity & 0x01) &&
+		    cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
 			if (dyn_tick_enabled())
