Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWGEUId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWGEUId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWGEUIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:08:32 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:17559 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S965013AbWGEUIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:08:32 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Konstantin Karasyov <konstantin.a.karasyov@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: regression / [PATCH] ACPI: fix fan/thermal resume
Date: Wed, 5 Jul 2006 22:09:08 +0200
User-Agent: KMail/1.7.2
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, Pavel Machek <pavel@suse.cz>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607052209.09066.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-03.tornado.cablecom.ch 1377;
	Body=7 Fuz1=7 Fuz2=7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

found another smallish but annoying regression...description/patch below.
@intel: please add signed-off-by lines and forward to Linus before 2.6.18 if you argee.
@akpm: one round or so in -mm?

thanks, rgds
-daniel

----------------

[PATCH] ACPI fix fan/thermal resume

the acpi driver suspend/resume patches that went in recently caused a regression
on my box (toshiba tecra 8000 laptop): after resume from swsusp the fan turns on
keeping blowing cold air out of my notebook. before the patches, the fan was off
and would only make noise when required. it's the same thing described in
bugzilla.kernel.org #5000. the acpi suspend/resume patches or at least parts of
them originate in this bug. now the last patch in the report (attach id 8438)
actually fixes the problem - for me and the reporter. this is a trimmed down
version of that patch.

From: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Len Brown <len.brown@intel.com>
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 503c0b9..fdba487 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1359,13 +1359,28 @@ static int acpi_thermal_remove(struct ac
 static int acpi_thermal_resume(struct acpi_device *device, int state)
 {
 	struct acpi_thermal *tz = NULL;
+	int i;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
 	tz = (struct acpi_thermal *)acpi_driver_data(device);
 
-	acpi_thermal_check(tz);
+	acpi_thermal_get_temperature(tz);
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (tz->trips.active[i].flags.valid) {
+ 			tz->temperature = tz->trips.active[i].temperature;
+			tz->trips.active[i].flags.enabled = 0;
+
+			acpi_thermal_active(tz);
+
+			tz->state.active |= tz->trips.active[i].flags.enabled;
+			tz->state.active_index = i;
+		}
+	}
+
+ 	acpi_thermal_check(tz);
 
 	return AE_OK;
 }
