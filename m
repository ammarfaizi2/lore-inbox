Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVLMI2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVLMI2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVLMIZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:3204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932559AbVLMIZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:00 -0500
Date: Tue, 13 Dec 2005 00:22:59 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dsd@gentoo.org, venkatesh.pallipadi@intel.com, len.brown@intel.com
Subject: [patch 12/26] ACPI: Add support for FADT P_LVL2_UP flag
Message-ID: <20051213082259.GM5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="acpi-add-support-for-fadt-p_lvl2_up-flag.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
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

--- linux-2.6.14.3.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.14.3/drivers/acpi/processor_idle.c
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
