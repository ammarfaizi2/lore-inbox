Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVAYMOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVAYMOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVAYMOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:14:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8916 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261896AbVAYMOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:14:35 -0500
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com>
	<m1sm4phpor.fsf@ebiederm.dsl.xmission.com>
	<20050125094350.GA6372@ip68-4-98-123.oc.oc.cox.net>
	<m1brbdhl3l.fsf@ebiederm.dsl.xmission.com>
	<20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jan 2005 05:12:43 -0700
In-Reply-To: <20050125104904.GB5906@ip68-4-98-123.oc.oc.cox.net>
Message-ID: <m13bwphflw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could you try this patch on your system with acpi that
is having problems.

The patch needs some work before it goes into a mainline kernel
as I have hacked the call to acpi_power_off_prepare into roughly
the proper position in the call chain instead of use a proper
hook.  But I can't quickly find an existing hook in the proper
location.

Eric

diff -uNr linux-2.6.11-rc1-mm1-nokexec/drivers/acpi/sleep/poweroff.c linux-2.6.11-rc1-mm1-acpi-power-off-shuffle/drivers/acpi/sleep/poweroff.c
--- linux-2.6.11-rc1-mm1-nokexec/drivers/acpi/sleep/poweroff.c	Fri Jan  7 12:53:50 2005
+++ linux-2.6.11-rc1-mm1-acpi-power-off-shuffle/drivers/acpi/sleep/poweroff.c	Tue Jan 25 05:05:06 2005
@@ -7,18 +7,34 @@
 
 #include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <acpi/acpi_bus.h>
 #include <linux/sched.h>
 #include "sleep.h"
 
+static void acpi_power_off_prepare(void)
+{
+	if (system_state == SYSTEM_POWER_OFF) {
+		acpi_wakeup_gpe_poweroff_prepare();
+		acpi_enter_sleep_state_prep(ACPI_STATE_S5);
+	}
+}
+
+void do_acpi_power_off_prepare(void)
+{
+	if (!acpi_disabled) {
+		apci_power_offf_prepare();
+	}
+}
+
 static void
 acpi_power_off (void)
 {
 	printk("%s called\n",__FUNCTION__);
+#if 0 /* This should be made redundant by other patches.. */
 	/* Some SMP machines only can poweroff in boot CPU */
 	set_cpus_allowed(current, cpumask_of_cpu(0));
-	acpi_wakeup_gpe_poweroff_prepare();
-	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
+#endif
 	ACPI_DISABLE_IRQS();
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
diff -uNr linux-2.6.11-rc1-mm1-nokexec/drivers/base/power/shutdown.c linux-2.6.11-rc1-mm1-acpi-power-off-shuffle/drivers/base/power/shutdown.c
--- linux-2.6.11-rc1-mm1-nokexec/drivers/base/power/shutdown.c	Mon Oct 18 15:54:37 2004
+++ linux-2.6.11-rc1-mm1-acpi-power-off-shuffle/drivers/base/power/shutdown.c	Tue Jan 25 05:06:09 2005
@@ -62,6 +62,12 @@
 	}
 	up_write(&devices_subsys.rwsem);
 
+#if 1
+	{
+		extern void do_acpi_power_off_prepare(void);
+		do_acpi_power_off_prepare();
+	}
+#endif
 	sysdev_shutdown();
 }
 
