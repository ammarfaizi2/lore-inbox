Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266282AbVBDXoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266282AbVBDXoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbVBDXoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:44:54 -0500
Received: from fmr23.intel.com ([143.183.121.15]:13536 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S264486AbVBDXmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:42:13 -0500
Date: Fri, 4 Feb 2005 15:41:59 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH][i386] HPET setup, duplicate HPET_T0_CMP needed for some platforms
Message-ID: <20050204154159.A4402@unix-os.sc.intel.com>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com> <20050203213026.GF3181@wotan.suse.de> <20050204200238.GA5510@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050204200238.GA5510@ucw.cz>; from vojtech@suse.cz on Fri, Feb 04, 2005 at 09:02:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the issue with HPET on some platforms.

According to Vojtech Pavlik:

The first write after writing TN_SETVAL to the config register sets the
counter value, the second write sets the threshold.

When you only do the first write you never set the threshold and
interrupts won't be generated properly.

Thanks to John Stultz and Andrew Walrond for reporting, root causing 
the issue and verifying this fix.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>


--- linux-2.6.10/arch/i386/kernel/time_hpet.c.org	2005-02-04 12:04:09.000000000 -0800
+++ linux-2.6.10/arch/i386/kernel/time_hpet.c	2005-02-04 18:01:25.000000000 -0800
@@ -81,6 +81,11 @@ static int hpet_timer_stop_set_go(unsign
 	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC |
 	       HPET_TN_SETVAL | HPET_TN_32BIT;
 	hpet_writel(cfg, HPET_T0_CFG);
+	/* 
+	 * Some systems seems to need two writes to HPET_T0_CMP, 
+	 * to get interrupts working
+	 */
+	hpet_writel(tick, HPET_T0_CMP);
 	hpet_writel(tick, HPET_T0_CMP);
 
 	/*
