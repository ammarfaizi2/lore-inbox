Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVLDMYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVLDMYr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 07:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVLDMYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 07:24:47 -0500
Received: from isilmar.linta.de ([213.239.214.66]:30948 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750709AbVLDMYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 07:24:46 -0500
Date: Sun, 4 Dec 2005 13:24:34 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       Adam Belay <abelay@novell.com>, Daniel Petrini <d.pensator@gmail.com>,
       vatsa@in.ibm.com, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: fix cpufreq-ondemand by accounting skipped ticks as idle ticks [Was: [PATCH] i386 no idle HZ aka Dynticks 051203]
Message-ID: <20051204122434.GB9503@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
	Adam Belay <abelay@novell.com>,
	Daniel Petrini <d.pensator@gmail.com>, vatsa@in.ibm.com,
	Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200512041737.07996.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512041737.07996.kernel@kolivas.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Account ticks skipped dynamically as idle ticks.

This allows the ondemand cpufreq governor to work correctly with dyntick.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: working-tree/arch/i386/kernel/dyn-tick.c
===================================================================
--- working-tree.orig/arch/i386/kernel/dyn-tick.c
+++ working-tree/arch/i386/kernel/dyn-tick.c
@@ -19,6 +19,7 @@
 #include <linux/dyn-tick.h>
 #include <linux/timer.h>
 #include <linux/irq.h>
+#include <linux/kernel_stat.h>
 #include <asm/apic.h>
 #include <asm/dyn-tick.h>
 
@@ -109,6 +110,8 @@ void dyn_tick_interrupt(struct pt_regs *
 			do_timer(regs);
 		if (cpu_has_local_apic())
 			enable_pit_timer();
+		if (lost)
+			kstat_cpu(cpu).cpustat.idle += (lost - 1);
 	}
 	cpu_clear(cpu, nohz_cpu_mask);
 	spin_unlock(&dyn_tick->lock);
