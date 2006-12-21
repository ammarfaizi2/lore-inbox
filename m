Return-Path: <linux-kernel-owner+w=401wt.eu-S1423125AbWLUXas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423125AbWLUXas (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423129AbWLUXar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:30:47 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:53438 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423125AbWLUXar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:30:47 -0500
Date: Fri, 22 Dec 2006 00:29:52 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joe Perches <joe@perches.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: my handy-dandy, "coding style" script
In-Reply-To: <1166741599.27218.7.camel@localhost>
Message-ID: <Pine.LNX.4.61.0612220019260.3720@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain> 
 <20061219164146.GI25461@redhat.com>  <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
  <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>  <4589BC6E.7040209@tmr.com>
  <Pine.LNX.4.61.0612212151450.3720@yvahk01.tjqt.qr> <1166741599.27218.7.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 21 2006 14:53, Joe Perches wrote:
>On Thu, 2006-12-21 at 21:52 +0100, Jan Engelhardt wrote:
>> http://lkml.org/lkml/2006/9/30/208
>
>@@ -1302,7 +1302,7 @@ static int acpi_battery_add(struct acpi_
> 		battery->init_state = 1;
> 	}
> 
>-	(void)sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
>+	sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
>
>These casts can eliminate "return value unused" warnings.

But only when functions are tagged __must_check, and sprintf is not. 
cmpxchg is one where (void) is 'needed', __as I wrote__ in a cxgb3 
comment.

After applying this patch, there are no additional warnings:

00:19 ichi:/erk/kernel/linux-2.6.20-rc1 > make drivers/acpi/sbs.o
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC [M]  drivers/acpi/sbs.o
00:21 ichi:/erk/kernel/linux-2.6.20-rc1 > grep MUST .config
CONFIG_ENABLE_MUST_CHECK=y

akpm, please include.

---

Remove some unnecessary (void) casts.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.20-rc1/drivers/acpi/sbs.c
===================================================================
--- linux-2.6.20-rc1.orig/drivers/acpi/sbs.c
+++ linux-2.6.20-rc1/drivers/acpi/sbs.c
@@ -1160,14 +1160,14 @@ acpi_battery_write_alarm(struct file *fi
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "acpi_battery_set_alarm() failed\n"));
-		(void)acpi_battery_set_alarm(battery, old_alarm);
+		acpi_battery_set_alarm(battery, old_alarm);
 		goto end;
 	}
 	result = acpi_battery_get_alarm(battery);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "acpi_battery_get_alarm() failed\n"));
-		(void)acpi_battery_set_alarm(battery, old_alarm);
+		acpi_battery_set_alarm(battery, old_alarm);
 		goto end;
 	}
 
@@ -1302,7 +1302,7 @@ static int acpi_battery_add(struct acpi_
 		battery->init_state = 1;
 	}
 
-	(void)sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
+	sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
 
 	result = acpi_sbs_generic_add_fs(&battery->battery_entry,
 					 acpi_battery_dir,
@@ -1485,7 +1485,7 @@ static int acpi_sbs_update_run(struct ac
 		}
 
 		if (old_battery_present != new_battery_present) {
-			(void)sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
+			sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
 			result = acpi_sbs_generate_event(sbs->device,
 							 ACPI_SBS_BATTERY_NOTIFY_STATUS,
 							 new_battery_present,
@@ -1498,7 +1498,7 @@ static int acpi_sbs_update_run(struct ac
 			}
 		}
 		if (old_remaining_capacity != battery->state.remaining_capacity) {
-			(void)sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
+			sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
 			result = acpi_sbs_generate_event(sbs->device,
 							 ACPI_SBS_BATTERY_NOTIFY_STATUS,
 							 new_battery_present,


