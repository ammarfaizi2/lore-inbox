Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbVLWWug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbVLWWug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbVLWWty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:49:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:3792 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161107AbVLWWtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:32 -0500
Date: Fri, 23 Dec 2005 14:47:37 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, venkatesh.pallipadi@intel.com
Subject: [patch 01/19] ACPI: Add support for FADT P_LVL2_UP flag
Message-ID: <20051223224737.GA19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="acpi-add-support-for-fadt-p_lvl2_up-flag.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

[ACPI] Add support for FADT P_LVL2_UP flag
which tells us if C2 is valid for UP-only, or SMP.

As there is no separate bit for C3,  use P_LVL2_UP
bit to cover both C2 and C3.

http://bugzilla.kernel.org/show_bug.cgi?id=5165

(cherry picked from 28b86b368af3944eb383078fc5797caf2dc8ce44 commit)

Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/acpi/processor_idle.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- linux-2.6.14.4.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.14.4/drivers/acpi/processor_idle.c
@@ -261,6 +261,16 @@ static void acpi_processor_idle(void)
 
 	cx->usage++;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	/*
+	 * Check for P_LVL2_UP flag before entering C2 and above on
+	 * an SMP system. We do it here instead of doing it at _CST/P_LVL
+	 * detection phase, to work cleanly with logical CPU hotplug.
+	 */
+	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+	    !pr->flags.has_cst && acpi_fadt.plvl2_up)
+		cx->type = ACPI_STATE_C1;
+#endif
 	/*
 	 * Sleep:
 	 * ------
@@ -527,6 +537,15 @@ static int acpi_processor_get_power_info
 	pr->power.states[ACPI_STATE_C0].valid = 1;
 	pr->power.states[ACPI_STATE_C1].valid = 1;
 
+#ifndef CONFIG_HOTPLUG_CPU
+	/*
+	 * Check for P_LVL2_UP flag before entering C2 and above on
+	 * an SMP system.
+	 */
+	if ((num_online_cpus() > 1) && acpi_fadt.plvl2_up)
+		return_VALUE(-ENODEV);
+#endif
+
 	/* determine C2 and C3 address from pblk */
 	pr->power.states[ACPI_STATE_C2].address = pr->pblk + 4;
 	pr->power.states[ACPI_STATE_C3].address = pr->pblk + 5;

--
