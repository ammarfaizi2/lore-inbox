Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266600AbRGLVCY>; Thu, 12 Jul 2001 17:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266603AbRGLVCP>; Thu, 12 Jul 2001 17:02:15 -0400
Received: from [194.213.32.142] ([194.213.32.142]:24836 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266595AbRGLVCD>;
	Thu, 12 Jul 2001 17:02:03 -0400
Message-ID: <20010711220215.A167@bug.ucw.cz>
Date: Wed, 11 Jul 2001 22:02:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: andrew.grover@intel.com,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Thermal extensions/cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans up existing thermal code a bit, plus implements usefull
info file, plus implements way to force fan on/off and force
throttling. [If it conflicts with patch you already applied, let
me know and I'll produce better version.]

Please apply,
								Pavel

--- clean/drivers/acpi/ospm/thermal/tz_osl.c	Sun Jul  8 23:26:35 2001
+++ linux/drivers/acpi/ospm/thermal/tz_osl.c	Tue Jul 10 22:04:45 2001
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <asm/uaccess.h>
 #include <acpi.h>
 #include "tz.h"
 
@@ -36,7 +37,7 @@
 MODULE_AUTHOR("Andrew Grover");
 MODULE_DESCRIPTION("ACPI Component Architecture (CA) - Thermal Zone Driver");
 
-int TZP = 0;
+int TZP = 30;
 MODULE_PARM(TZP, "i");
 MODULE_PARM_DESC(TZP, "Thermal zone polling frequency, in 1/10 seconds.\n");
 
@@ -64,17 +65,50 @@
 	int 			*eof, 
 	void			*context)
 {
-	TZ_CONTEXT		*thermal_zone = NULL;
+	TZ_CONTEXT		*tz = NULL;
+	TZ_THRESHOLD            *threshold = NULL;
 	char			*p = page;
 	int 			len = 0;
+	int			i;
 
 	if (!context || (off != 0)) {
 		goto end;
 	}
 
-	thermal_zone = (TZ_CONTEXT*)context;
+	tz = (TZ_CONTEXT*)context;
+
+	p += sprintf(p, "Polling Frequency:       ");
+	switch (tz->policy.polling_freq) {
+	case 0:
+		p += sprintf(p, "n/a\n");
+		break;
+	default:
+		p += sprintf(p, "%d ds\n", tz->policy.polling_freq);
+		break;
+	}
+
+	p += sprintf(p, "Thresholds:              ");
+
+	for (i = 0; i < tz->policy.threshold_list.count; i++) {
+
+		threshold = &(tz->policy.threshold_list.thresholds[i]);
+
+		switch (threshold->type) {
+
+		case TZ_THRESHOLD_CRITICAL:
+			p += sprintf(p, "Critical: %d dK ", threshold->temperature);
+			break;
+
+		case TZ_THRESHOLD_PASSIVE:
+			p += sprintf(p, "Passive: TC1=%d TC2=%d TSP=%d %d dK ", tz->policy.passive.tc1, tz->policy.passive.tc2, tz->policy.passive.tsp, tz->policy.passive.threshold->temperature);
+			break;
 
-	p += sprintf(p, "<TBD>\n");
+		case TZ_THRESHOLD_ACTIVE:
+			p += sprintf(p, "Active[%d]: %d dK ", threshold->index, threshold->temperature);
+			break;
+		}
+	}
+	p +=  sprintf(p, "\n");
 
 end:
 	len = (p - page);
@@ -113,8 +147,8 @@
 
 	thermal_zone = (TZ_CONTEXT*)context;
 
-	p += sprintf(p, "Temperature:             %d (1/10th degrees Kelvin)\n", 
-		thermal_zone->policy.temperature);
+	p += sprintf(p, "Temperature:             %d dK\n", 
+		thermal_zone->policy.temperature );
 
 	p += sprintf(p, "State:                   ");
 	if (thermal_zone->policy.state & TZ_STATE_ACTIVE) {
@@ -127,7 +161,7 @@
 		p += sprintf(p, "critical ");
 	}
 	if (thermal_zone->policy.state == 0) {
-		p += sprintf(p, "ok ");
+		p += sprintf(p, "ok");
 	}
 	p += sprintf(p, "\n");
 
@@ -150,7 +184,7 @@
 		p += sprintf(p, "n/a\n");
 		break;
 	default:
-		p += sprintf(p, "%d (1/10th seconds)\n", thermal_zone->policy.polling_freq);
+		p += sprintf(p, "%d ds\n", thermal_zone->policy.polling_freq);
 		break;
 	}
 
@@ -165,6 +199,53 @@
 	return(len);
 }
 
+static void
+do_fan(TZ_CONTEXT *tz, u32 on)
+{
+	TZ_THRESHOLD            *active = NULL;
+	u32                     i = 0;
+
+	for (i = 0; i < TZ_MAX_ACTIVE_THRESHOLDS; i++) {
+		if (!(active = tz->policy.active.threshold[i]))
+			break;
+		tz_policy_active_do(tz, active, on);
+	}
+}
+
+int
+tz_osl_proc_write_status(struct file *file, const char *buffer,
+			 unsigned long count, void *context)
+{
+	TZ_CONTEXT		*tz = NULL;
+	int 			len = 0;
+	char buf[256], buf2[256];
+
+	tz = (TZ_CONTEXT*)context;
+
+	if (count > 250)
+		return -EPERM;
+	if (copy_from_user(buf, buffer, count))
+		return -EFAULT;
+	buf[count] = 0;
+	printk("osl_write_status: %s...", buf);
+	if (!strcmp(buf, "dec"))
+		tz_policy_passive_do(tz, PR_PERF_DEC);
+	if (!strcmp(buf, "inc"))
+		tz_policy_passive_do(tz, PR_PERF_INC);
+	if (!strncmp(buf, "limit", 5)) {
+		char *s;
+		int i = simple_strtoul(buf+5, &s, 0);
+		tz_policy_passive_do(tz, i);
+	}
+	if (!strcmp(buf, "fanon"))
+		do_fan(tz, ACPI_STATE_D0);
+	if (!strcmp(buf, "fanoff"))
+		do_fan(tz, ACPI_STATE_D3);
+		
+	return -EL3RST;
+}
+
+
 
 /****************************************************************************
  *
@@ -176,7 +257,7 @@
 tz_osl_add_device(
 	TZ_CONTEXT		*thermal_zone)
 {
-	struct proc_dir_entry	*proc_entry = NULL;
+	struct proc_dir_entry	*proc_entry = NULL, *proc;
 
 	if (!thermal_zone) {
 		return(AE_BAD_PARAMETER);
@@ -185,15 +266,19 @@
 	printk("Thermal Zone: found\n");
 
 	proc_entry = proc_mkdir(thermal_zone->uid, tz_proc_root);
-	if (!proc_entry) {
+	if (!proc_entry)
 		return(AE_ERROR);
-	}
 
-	create_proc_read_entry(TZ_PROC_STATUS, S_IFREG | S_IRUGO, 
+	proc = create_proc_read_entry(TZ_PROC_STATUS, S_IFREG | S_IRUGO, 
 		proc_entry, tz_osl_proc_read_status, (void*)thermal_zone);
+	if (!proc)
+		return(AE_ERROR);
+	proc->write_proc = tz_osl_proc_write_status;
 
-	create_proc_read_entry(TZ_PROC_INFO, S_IFREG | S_IRUGO, 
+	proc = create_proc_read_entry(TZ_PROC_INFO, S_IFREG | S_IRUGO, 
 		proc_entry, tz_osl_proc_read_info, (void*)thermal_zone);
+	if (!proc)
+		return(AE_ERROR);
 
 	return(AE_OK);
 }
--- clean/drivers/acpi/ospm/thermal/tzpolicy.c	Sun Jul  8 23:26:35 2001
+++ linux/drivers/acpi/ospm/thermal/tzpolicy.c	Tue Jul 10 00:08:15 2001
@@ -59,6 +59,8 @@
  *                              Internal Functions
  ****************************************************************************/
 
+
+/* FIXME: Should not this call pr_perf_set_limit? */
 ACPI_STATUS
 set_performance_limit (
 	BM_HANDLE               device_handle,
@@ -75,7 +77,8 @@
 
 	status = bm_request(&request);
 
 	if (ACPI_FAILURE(status)) {
+		printk(KERN_CRIT "Unable to set performance limit to %d\n", flag);
 		return status;
 	}
 	else {
@@ -125,6 +130,17 @@
  *
  ****************************************************************************/
 
+void
+tz_policy_passive_do(TZ_CONTEXT *tz, u32 flag)
+{
+	TZ_PASSIVE_POLICY	*passive = NULL;
+	u32			i = 0;
+
+	passive = &(tz->policy.passive);
+	for (i=0; i<passive->threshold->cooling_devices.count; i++)
+		set_performance_limit(passive->threshold->cooling_devices.handles[i], flag);
+}
+
 ACPI_STATUS
 tz_policy_passive(
 	TZ_CONTEXT		*tz)
@@ -161,26 +177,16 @@
 		 * Decrease thermal performance limit on all passive
 		 * cooling devices (processors).
 		 */
-		if (trend > 0) {
-			for (i=0; i<passive->threshold->cooling_devices.count; i++) {
-				set_performance_limit(
-					passive->threshold->cooling_devices.handles[i],
-					PR_PERF_DEC);
-			}
-		}
+		if (trend > 0)
+			tz_policy_passive_do(tz, PR_PERF_DEC);
 		/*
 		 * Cooling Off?
 		 * ------------
 		 * Increase thermal performance limit on all passive
 		 * cooling devices (processors).
 		 */
-		else if (trend < 0) {
-			for (i=0; i<passive->threshold->cooling_devices.count; i++) {
-				set_performance_limit(
-					passive->threshold->cooling_devices.handles[i],
-					PR_PERF_INC);
-			}
-		}
+		else if (trend < 0)
+			tz_policy_passive_do(tz, PR_PERF_INC);
 	}
 
 	return(AE_OK);
@@ -199,6 +205,21 @@
  *
  ****************************************************************************/
 
+void
+tz_policy_active_do(TZ_CONTEXT *tz, TZ_THRESHOLD *active, u32 state)
+{
+	u32                     j = 0;
+	ACPI_STATUS             status = AE_OK;
+
+	printk("Setting active cooling: %d\n", state);
+
+	for (j = 0; j < active->cooling_devices.count; j++) {
+		status = bm_set_device_power_state(active->cooling_devices.handles[j], state);
+		if (!ACPI_SUCCESS(status))
+			printk(KERN_CRIT "ACPI: Failed to turn active cooling on/off.\n");
+	}
+}
+
 ACPI_STATUS
 tz_policy_active(
 	TZ_CONTEXT              *tz)
@@ -212,11 +233,8 @@
 	}
 
 	for (i = 0; i < TZ_MAX_ACTIVE_THRESHOLDS; i++) {
-
-		active = tz->policy.active.threshold[i];
-		if (!active) {
+		if (!(active = tz->policy.active.threshold[i]))
 			break;
-		}
 
 		/*
 		 * Above Threshold?
@@ -226,19 +244,7 @@
 		 */
 		if ((tz->policy.temperature >= active->temperature) &&
 			(active->cooling_state != TZ_COOLING_ENABLED)) {
-
-			for (j = 0; j < active->cooling_devices.count; j++) {
-
-				status = bm_set_device_power_state(
-					active->cooling_devices.handles[j],
-					ACPI_STATE_D0);
-
-				if (ACPI_SUCCESS(status)) {
-				}
-				else {
-				}
-			}
-
+			tz_policy_active_do(tz, active, ACPI_STATE_D0);
 			active->cooling_state = TZ_COOLING_ENABLED;
 		}
 		/*
@@ -251,19 +257,7 @@
 		 * during the first pass.
 		 */
 		else if (active->cooling_state != TZ_COOLING_DISABLED) {
-
-			for (j = 0; j < active->cooling_devices.count; j++) {
-
-				status = bm_set_device_power_state(
-					active->cooling_devices.handles[j],
-					ACPI_STATE_D3);
-
-				if (ACPI_SUCCESS(status)) {
-				}
-				else {
-				}
-			}
-
+			tz_policy_active_do(tz, active, ACPI_STATE_D3);
 			active->cooling_state = TZ_COOLING_DISABLED;
 		}
 	}
@@ -330,12 +324,13 @@
 	if ((tz->policy.critical.threshold) &&
 		(tz->policy.temperature >= tz->policy.critical.threshold->temperature)) {
 		tz->policy.state |= TZ_STATE_CRITICAL;
+		printk(KERN_CRIT "ACPI: CPU temperature critical\n");
 	}
 
 	/* Passive? */
 	if ((tz->policy.passive.threshold) &&
 		(tz->policy.temperature >= tz->policy.passive.threshold->temperature)) {
 		tz->policy.state |= TZ_STATE_PASSIVE;
 	}
 
 	/* Active? */


								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
