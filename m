Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVGZSVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVGZSVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGZSS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:18:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63879 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262013AbVGZSS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:18:29 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 23/23] acpi: Don't call acpi_sleep_prepare from
 acpi_power_off
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com>
	<m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com>
	<m1br4pcva4.fsf_-_@ebiederm.dsl.xmission.com>
	<m17jfdcv79.fsf_-_@ebiederm.dsl.xmission.com>
	<m13bq1cv3k.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y87tbgeo.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0ihbg85.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pst5bg5u.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ll3tbg2r.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hdehbfwa.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5p5bft6.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xztbfr9.fsf_-_@ebiederm.dsl.xmission.com>
	<m14qahbfk7.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zms9a0wv.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 12:17:52 -0600
In-Reply-To: <m1zms9a0wv.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 12:16:00 -0600")
Message-ID: <m1vf2xa0tr.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that all of the code paths that call acpi_power_off
have been modified to call either call kernel_power_off
(which calls apci_sleep_prepare by way of acpi_shutdown)
or to call acpi_sleep_prepare directly it is redundant to call
acpi_sleep_prepare from acpi_power_off.

So simplify the code and simply don't call acpi_sleep_prepare.

In addition there is a little error handling done so if we
can't register the acpi class we don't hook pm_power_off.

I think I have done the right thing with the CONFIG_PM define
but I'm not certain.  Can this code even be compiled if
CONFIG_PM is false?

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 drivers/acpi/sleep/poweroff.c |   33 ++++++++++++---------------------
 1 files changed, 12 insertions(+), 21 deletions(-)

415ee58560128bb4f90f8252c189bdf489d1f0d3
diff --git a/drivers/acpi/sleep/poweroff.c b/drivers/acpi/sleep/poweroff.c
--- a/drivers/acpi/sleep/poweroff.c
+++ b/drivers/acpi/sleep/poweroff.c
@@ -19,8 +19,6 @@
 
 int acpi_sleep_prepare(u32 acpi_state)
 {
-	/* Flag to do not allow second time invocation for S5 state */
-	static int shutdown_prepared = 0;
 #ifdef CONFIG_ACPI_SLEEP
 	/* do we have a wakeup address for S2 and S3? */
 	/* Here, we support only S4BIOS, those we set the wakeup address */
@@ -38,27 +36,23 @@ int acpi_sleep_prepare(u32 acpi_state)
 	acpi_enable_wakeup_device_prep(acpi_state);
 #endif
 	if (acpi_state == ACPI_STATE_S5) {
-		/* Check if we were already called */
-		if (shutdown_prepared)
-			return 0;
 		acpi_wakeup_gpe_poweroff_prepare();
-		shutdown_prepared = 1;
 	}
 	acpi_enter_sleep_state_prep(acpi_state);
 	return 0;
 }
 
+#ifdef CONFIG_PM
+
 void acpi_power_off(void)
 {
+	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	printk("%s called\n", __FUNCTION__);
-	acpi_sleep_prepare(ACPI_STATE_S5);
 	local_irq_disable();
 	/* Some SMP machines only can poweroff in boot CPU */
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
-#ifdef CONFIG_PM
-
 static int acpi_shutdown(struct sys_device *x)
 {
 	return acpi_sleep_prepare(ACPI_STATE_S5);
@@ -74,8 +68,6 @@ static struct sys_device device_acpi = {
 	.cls = &acpi_sysclass,
 };
 
-#endif
-
 static int acpi_poweroff_init(void)
 {
 	if (!acpi_disabled) {
@@ -85,19 +77,18 @@ static int acpi_poweroff_init(void)
 		status =
 		    acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
 		if (ACPI_SUCCESS(status)) {
-			pm_power_off = acpi_power_off;
-#ifdef CONFIG_PM
-			{
-				int error;
-				error = sysdev_class_register(&acpi_sysclass);
-				if (!error)
-					error = sysdev_register(&device_acpi);
-				return error;
-			}
-#endif
+			int error;
+			error = sysdev_class_register(&acpi_sysclass);
+			if (!error)
+				error = sysdev_register(&device_acpi);
+			if (!error)
+				pm_power_off = acpi_power_off;
+			return error;
 		}
 	}
 	return 0;
 }
 
 late_initcall(acpi_poweroff_init);
+
+#endif /* CONFIG_PM */
