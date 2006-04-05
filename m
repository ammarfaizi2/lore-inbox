Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWDEDDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDEDDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 23:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWDEDDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 23:03:54 -0400
Received: from mga03.intel.com ([143.182.124.21]:56636 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750833AbWDEDDw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 23:03:52 -0400
X-IronPort-AV: i="4.03,165,1141632000"; 
   d="scan'208"; a="19235471:sNHT22944537"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Wed, 5 Apr 2006 11:03:47 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD118FD44@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZXs/2bzH5bifY+S7OSl3EcSv42YwApe0PA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>, <linux-acpi@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 05 Apr 2006 03:03:48.0756 (UTC) FILETIME=[8F645D40:01C6585D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>diff -r ac486e270597 -r abd89292c539 drivers/acpi/osl.c
>--- a/drivers/acpi/osl.c	Sat Mar 18 08:35:34 2006 -0500
>+++ b/drivers/acpi/osl.c	Thu Mar 30 10:59:57 2006 -0500
>@@ -634,6 +634,8 @@ static void acpi_os_execute_deferred(voi
> 	return_VOID;
> }
> 
>+extern int acpi_in_suspend;
>+
> acpi_status
> acpi_os_queue_for_execution(u32 priority,
> 			    acpi_osd_exec_callback function, 
>void *context)
>@@ -643,6 +645,8 @@ acpi_os_queue_for_execution(u32 priority
> 	struct work_struct *task;
> 
> 	ACPI_FUNCTION_TRACE("os_queue_for_execution");
>+	if (acpi_in_suspend)	/* in case kacpid is causing 
>the queue */
>+		return_ACPI_STATUS(AE_OK);

The request will be dropped silently , So, it sounds ugly.
At least, you need to put some warning here. 
The long-term solution is to fix the invoker to NOT ask 
kacpid to invoke AML methods during suspend-resume period.

> 
> 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
> 			  "Scheduling function [%p(%p)] for 
>deferred execution.\n",
>diff -r ac486e270597 -r abd89292c539 drivers/acpi/sleep/main.c
>--- a/drivers/acpi/sleep/main.c	Sat Mar 18 08:35:34 2006 -0500
>+++ b/drivers/acpi/sleep/main.c	Thu Mar 30 10:59:57 2006 -0500
>@@ -19,6 +19,12 @@
> #include <acpi/acpi_drivers.h>
> #include "sleep.h"
> 
>+/* for functions putting machine to sleep to know that we're
>+   suspending, so that they can careful about what AML methods they
>+   invoke (to avoid trying untested BIOS code paths) */
>+int acpi_in_suspend;
>+EXPORT_SYMBOL(acpi_in_suspend);
>+
> u8 sleep_states[ACPI_S_STATE_COUNT];
> 
> static struct pm_ops acpi_pm_ops;
>@@ -55,6 +61,8 @@ static int acpi_pm_prepare(suspend_state
> 		printk("acpi_pm_prepare does not support %d 
>\n", pm_state);
> 		return -EPERM;
> 	}
>+	acpi_os_wait_events_complete(NULL);
>+	acpi_in_suspend = TRUE;
> 	return acpi_sleep_prepare(acpi_state);

There is race condition here.
Probably, it should be :
	acpi_in_suspend = TURE;
	acpi_os_wait_events_complete(NULL);

> }
> 
>@@ -132,6 +140,7 @@ static int acpi_pm_finish(suspend_state_
> 	u32 acpi_state = acpi_suspend_states[pm_state];
> 
> 	acpi_leave_sleep_state(acpi_state);
>+	acpi_in_suspend = FALSE;
> 	acpi_disable_wakeup_device(acpi_state);
> 
> 	/* reset firmware waking vector */
>diff -r ac486e270597 -r abd89292c539 drivers/acpi/thermal.c
>--- a/drivers/acpi/thermal.c	Sat Mar 18 08:35:34 2006 -0500
>+++ b/drivers/acpi/thermal.c	Thu Mar 30 10:59:57 2006 -0500
>@@ -79,6 +79,8 @@ static int tzp;
> static int tzp;
> module_param(tzp, int, 0);
> MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 
>1/10 seconds.\n");
>+
>+extern int acpi_in_suspend;
> 
> static int acpi_thermal_add(struct acpi_device *device);
> static int acpi_thermal_remove(struct acpi_device *device, int type);
>@@ -683,6 +685,8 @@ static void acpi_thermal_run(unsigned lo
> static void acpi_thermal_run(unsigned long data)
> {
> 	struct acpi_thermal *tz = (struct acpi_thermal *)data;
>+	if (acpi_in_suspend)	/* thermal methods might cause a hang */
>+		return_VOID;	/* so don't do them */

If you fixed kacpid, then this part could be removed.

> 	if (!tz->zombie)
> 		acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
> 					    acpi_thermal_check, 
>(void *)data);
>@@ -705,6 +709,8 @@ static void acpi_thermal_check(void *dat
> 
> 	state = tz->state;
> 
>+	if (acpi_in_suspend)
>+		return_VOID;

Could it cause trouble to caller?

> 	result = acpi_thermal_get_temperature(tz);
> 	if (result)
> 		return_VOID;
>@@ -1224,6 +1230,9 @@ static void acpi_thermal_notify(acpi_han
> 	struct acpi_device *device = NULL;
> 
> 	ACPI_FUNCTION_TRACE("acpi_thermal_notify");
>+
>+	if (acpi_in_suspend)	/* thermal methods might cause a hang */
>+		return_VOID;	/* so don't do them */

Could it cause trouble to caller?

> 
> 	if (!tz)
> 		return_VOID;
