Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbTI2Esz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 00:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTI2Esz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 00:48:55 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:36113 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S262801AbTI2Esq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 00:48:46 -0400
Subject: [PATCH] 2..6.0-bk6 /drivers/acpi/* ACPI printf fixes - save 1.3KB
From: Joe Perches <joe@perches.com>
To: torvalds@osdl.org
Cc: andrew.grover@intel.com, paul.s.diefenbaugh@intel.com,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064810106.29230.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 28 Sep 2003 21:35:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change formats strings to use less code&data space & apms->amps typo fix

diff -urN a/drivers/acpi/ac.c b/drivers/acpi/ac.c
--- a/drivers/acpi/ac.c	2003-09-08 12:50:02.000000000 -0700
+++ b/drivers/acpi/ac.c	2003-09-28 10:19:56.000000000 -0700
@@ -124,18 +124,9 @@
 		return 0;
 	}
 
-	seq_puts(seq, "state:                   ");
-	switch (ac->state) {
-	case ACPI_AC_STATUS_OFFLINE:
-		seq_puts(seq, "off-line\n");
-		break;
-	case ACPI_AC_STATUS_ONLINE:
-		seq_puts(seq, "on-line\n");
-		break;
-	default:
-		seq_puts(seq, "unknown\n");
-		break;
-	}
+	seq_printf(seq,"%-25s%s\n","state:",
+		   ac->state==ACPI_AC_STATUS_OFFLINE ? "off-line" :
+		   ac->state==ACPI_AC_STATUS_ONLINE ? "on-line" : "unknown");
 
 	return 0;
 }
diff -urN a/drivers/acpi/battery.c b/drivers/acpi/battery.c
--- a/drivers/acpi/battery.c	2003-09-08 12:50:19.000000000 -0700
+++ b/drivers/acpi/battery.c	2003-09-28 11:59:15.000000000 -0700
@@ -51,6 +51,8 @@
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
 #define ACPI_BATTERY_UNITS_WATTS	"mW"
 #define ACPI_BATTERY_UNITS_AMPS		"mA"
+#define ACPI_BATTERY_UNITS_WATTHOURS	"mWh"
+#define ACPI_BATTERY_UNITS_AMPHOURS	"mAh"
 
 
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
@@ -98,7 +100,7 @@
 
 struct acpi_battery_flags {
 	u8			present:1;	/* Bay occupied? */
-	u8			power_unit:1;	/* 0=watts, 1=apms */
+	u8			power_unit:1;	/* 0=watts, 1=amps */
 	u8			alarm:1;	/* _BTP present? */
 	u8			reserved:5;
 };
@@ -354,7 +356,7 @@
 	int			result = 0;
 	struct acpi_battery	*battery = (struct acpi_battery *) data;
 	struct acpi_battery_info *bif = NULL;
-	char			*units = "?";
+	char			*unithours;
 	char			*p = page;
 	int			len = 0;
 
@@ -364,9 +366,9 @@
 		goto end;
 
 	if (battery->flags.present)
-		p += sprintf(p, "present:                 yes\n");
+		p += sprintf(p, "%-25s%s\n", "present:", "yes");
 	else {
-		p += sprintf(p, "present:                 no\n");
+		p += sprintf(p, "%-25s%s\n", "present:", "no");
 		goto end;
 	}
 
@@ -378,53 +380,53 @@
 		goto end;
 	}
 
-	units = bif->power_unit ? ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS;
+	unithours = bif->power_unit ? ACPI_BATTERY_UNITS_AMPHOURS : ACPI_BATTERY_UNITS_WATTHOURS;
 					
 	if (bif->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
-		p += sprintf(p, "design capacity:         unknown\n");
+		p += sprintf(p, "%-25s%s\n", "design capacity:", "unknown");
 	else
-		p += sprintf(p, "design capacity:         %d %sh\n",
-			(u32) bif->design_capacity, units);
+		p += sprintf(p, "%-25s%d %s\n", "design capacity:",
+			(u32) bif->design_capacity, unithours);
 
 	if (bif->last_full_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
-		p += sprintf(p, "last full capacity:      unknown\n");
+		p += sprintf(p, "%-25s%s\n", "last full capacity:", "unknown");
 	else
-		p += sprintf(p, "last full capacity:      %d %sh\n",
-			(u32) bif->last_full_capacity, units);
+		p += sprintf(p, "%-25s%d %s\n", "last full capacity:",
+			(u32) bif->last_full_capacity, unithours);
 
 	switch ((u32) bif->battery_technology) {
 	case 0:
-		p += sprintf(p, "battery technology:      non-rechargeable\n");
+		p += sprintf(p, "%-25s%s\n", "battery technology:", "non-rechargeable");
 		break;
 	case 1:
-		p += sprintf(p, "battery technology:      rechargeable\n");
+		p += sprintf(p, "%-25s%s\n", "battery technology:", "rechargeable");
 		break;
 	default:
-		p += sprintf(p, "battery technology:      unknown\n");
+		p += sprintf(p, "%-25s%s\n", "battery technology:", "unknown");
 		break;
 	}
 
 	if (bif->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
-		p += sprintf(p, "design voltage:          unknown\n");
+		p += sprintf(p, "%-25s%s\n", "design voltage:", "unknown");
 	else
-		p += sprintf(p, "design voltage:          %d mV\n",
+		p += sprintf(p, "%-25s%d mV\n", "design voltage:",
 			(u32) bif->design_voltage);
 	
-	p += sprintf(p, "design capacity warning: %d %sh\n",
-		(u32) bif->design_capacity_warning, units);
-	p += sprintf(p, "design capacity low:     %d %sh\n",
-		(u32) bif->design_capacity_low, units);
-	p += sprintf(p, "capacity granularity 1:  %d %sh\n",
-		(u32) bif->battery_capacity_granularity_1, units);
-	p += sprintf(p, "capacity granularity 2:  %d %sh\n",
-		(u32) bif->battery_capacity_granularity_2, units);
-	p += sprintf(p, "model number:            %s\n",
+	p += sprintf(p, "%-25s%d %s\n", "design capacity warning:",
+		(u32) bif->design_capacity_warning, unithours);
+	p += sprintf(p, "%-25s%d %s\n", "design capacity low:",
+		(u32) bif->design_capacity_low, unithours);
+	p += sprintf(p, "%-25s%d %s\n", "capacity granularity 1:",
+		(u32) bif->battery_capacity_granularity_1, unithours);
+	p += sprintf(p, "%-25s%d %s\n", "capacity granularity 2:",
+		(u32) bif->battery_capacity_granularity_2, unithours);
+	p += sprintf(p, "%-25s%s\n", "model number:",
 		bif->model_number);
-	p += sprintf(p, "serial number:           %s\n",
+	p += sprintf(p, "%-25s%s\n", "serial number:",
 		bif->serial_number);
-	p += sprintf(p, "battery type:            %s\n",
+	p += sprintf(p, "%-25s%s\n", "battery type:",
 		bif->battery_type);
-	p += sprintf(p, "OEM info:                %s\n",
+	p += sprintf(p, "%-25s%s\n", "OEM info:",
 		bif->oem_info);
 
 end:
@@ -453,7 +455,8 @@
 	int			result = 0;
 	struct acpi_battery	*battery = (struct acpi_battery *) data;
 	struct acpi_battery_status *bst = NULL;
-	char			*units = "?";
+	char			*units;
+	char			*unithours;
 	char			*p = page;
 	int			len = 0;
 
@@ -463,15 +466,16 @@
 		goto end;
 
 	if (battery->flags.present)
-		p += sprintf(p, "present:                 yes\n");
+		p += sprintf(p, "%-25s%s\n", "present:", "yes");
 	else {
-		p += sprintf(p, "present:                 no\n");
+		p += sprintf(p, "%-25s%s\n", "present:", "no");
 		goto end;
 	}
 
 	/* Battery Units */
 
 	units = battery->flags.power_unit ? ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS;
+	unithours = battery->flags.power_unit ? ACPI_BATTERY_UNITS_AMPHOURS : ACPI_BATTERY_UNITS_WATTHOURS;
 
 	/* Battery Status (_BST) */
 
@@ -482,35 +486,35 @@
 	}
 
 	if (!(bst->state & 0x04))
-		p += sprintf(p, "capacity state:          ok\n");
+		p += sprintf(p, "%-25s%s\n", "capacity state:", "ok");
 	else
-		p += sprintf(p, "capacity state:          critical\n");
+		p += sprintf(p, "%-25s%s\n", "capacity state:", "critical");
 
 	if ((bst->state & 0x01) && (bst->state & 0x02))
-		p += sprintf(p, "charging state:          charging/discharging\n");
+		p += sprintf(p, "%-25s%s\n", "charging state:", "charging/discharging");
 	else if (bst->state & 0x01)
-		p += sprintf(p, "charging state:          discharging\n");
+		p += sprintf(p, "%-25s%s\n", "charging state:", "discharging");
 	else if (bst->state & 0x02)
-		p += sprintf(p, "charging state:          charging\n");
+		p += sprintf(p, "%-25s%s\n", "charging state:", "charging");
 	else
-		p += sprintf(p, "charging state:          unknown\n");
+		p += sprintf(p, "%-25s%s\n", "charging state:", "unknown");
 
 	if (bst->present_rate == ACPI_BATTERY_VALUE_UNKNOWN)
-		p += sprintf(p, "present rate:            unknown\n");
+		p += sprintf(p, "%-25s%s\n", "present rate:", "unknown");
 	else
-		p += sprintf(p, "present rate:            %d %s\n",
+		p += sprintf(p, "%-25s%d %s\n", "present rate:",
 			(u32) bst->present_rate, units);
 
 	if (bst->remaining_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
-		p += sprintf(p, "remaining capacity:      unknown\n");
+		p += sprintf(p, "%-25s%s\n", "remaining capacity:", "unknown");
 	else
-		p += sprintf(p, "remaining capacity:      %d %sh\n",
-			(u32) bst->remaining_capacity, units);
+		p += sprintf(p, "%-25s%d %s\n", "remaining capacity:",
+			(u32) bst->remaining_capacity, unithours);
 
 	if (bst->present_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
-		p += sprintf(p, "present voltage:         unknown\n");
+		p += sprintf(p, "%-25s%s\n", "present voltage:", "unknown");
 	else
-		p += sprintf(p, "present voltage:         %d mV\n",
+		p += sprintf(p, "%-25s%d mV\n", "present voltage:",
 			(u32) bst->present_voltage);
 
 end:
@@ -537,7 +541,7 @@
 	void			*data)
 {
 	struct acpi_battery	*battery = (struct acpi_battery *) data;
-	char			*units = "?";
+	char			*unithours;
 	char			*p = page;
 	int			len = 0;
 
@@ -553,15 +557,14 @@
 
 	/* Battery Units */
 	
-	units = battery->flags.power_unit ? ACPI_BATTERY_UNITS_AMPS : ACPI_BATTERY_UNITS_WATTS;
+	unithours = battery->flags.power_unit ? ACPI_BATTERY_UNITS_AMPHOURS : ACPI_BATTERY_UNITS_WATTHOURS;
 
 	/* Battery Alarm */
 
-	p += sprintf(p, "alarm:                   ");
 	if (!battery->alarm)
-		p += sprintf(p, "unsupported\n");
+		p += sprintf(p, "%-25s%s\n", "alarm:", "unsupported");
 	else
-		p += sprintf(p, "%d %sh\n", (u32) battery->alarm, units);
+		p += sprintf(p, "%-25s%d %s\n", "alarm:", (u32) battery->alarm, unithours);
 
 end:
 	len = (p - page);
diff -urN a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c	2003-09-08 12:50:22.000000000 -0700
+++ b/drivers/acpi/thermal.c	2003-09-28 12:15:41.000000000 -0700
@@ -776,7 +776,7 @@
 	if (!tz)
 		goto end;
 
-	seq_puts(seq, "state:                   ");
+	seq_printf(seq, "%-25s", "state:");
 
 	if (!tz->state.critical && !tz->state.hot && !tz->state.passive && !tz->state.active)
 		seq_puts(seq, "ok\n");
@@ -816,7 +816,7 @@
 	if (result)
 		goto end;
 
-	seq_printf(seq, "temperature:             %ld C\n", 
+	seq_printf(seq, "%-25s%ld C\n","temperature:", 
 		KELVIN_TO_CELSIUS(tz->temperature));
 
 end:
@@ -841,21 +841,21 @@
 		goto end;
 
 	if (tz->trips.critical.flags.valid)
-		seq_printf(seq, "critical (S5):           %ld C\n",
+		seq_printf(seq, "%-25s%ld C\n", "critical (S5):",
 			KELVIN_TO_CELSIUS(tz->trips.critical.temperature));
 
 	if (tz->trips.hot.flags.valid)
-		seq_printf(seq, "hot (S4):                %ld C\n",
+		seq_printf(seq, "%-25s%ld C\n", "hot (S4):",
 			KELVIN_TO_CELSIUS(tz->trips.hot.temperature));
 
 	if (tz->trips.passive.flags.valid) {
-		seq_printf(seq, "passive:                 %ld C: tc1=%lu tc2=%lu tsp=%lu devices=",
+		seq_printf(seq, "%-25s%ld C: tc1=%lu tc2=%lu tsp=%lu", "passive:",
 			KELVIN_TO_CELSIUS(tz->trips.passive.temperature),
 			tz->trips.passive.tc1,
 			tz->trips.passive.tc2, 
 			tz->trips.passive.tsp);
+		seq_puts(seq, " devices=");
 		for (j=0; j<tz->trips.passive.devices.count; j++) {
-
 			seq_printf(seq, "0x%p ", tz->trips.passive.devices.handles[j]);
 		}
 		seq_puts(seq, "\n");
@@ -864,8 +864,9 @@
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (!(tz->trips.active[i].flags.valid))
 			break;
-		seq_printf(seq, "active[%d]:               %ld C: devices=",
+		seq_printf(seq, "active[%d]:               %ld C:",
 			i, KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
+		seq_puts(seq, " devices=");
 		for (j = 0; j < tz->trips.active[i].devices.count; j++) 
 			seq_printf(seq, "0x%p ",
 				tz->trips.active[i].devices.handles[j]);
@@ -937,8 +938,7 @@
 		goto end;
 	}
 
-	seq_printf(seq, "cooling mode:            %s\n",
-		tz->cooling_mode?"passive":"active");
+	seq_printf(seq, "%-25s%s\n", "cooling mode:", tz->cooling_mode ? "passive" : "active");
 
 end:
 	return 0;
@@ -998,7 +998,7 @@
 		goto end;
 	}
 
-	seq_printf(seq, "polling frequency:       %lu seconds\n",
+	seq_printf(seq, "%-25s%lu seconds\n", "polling frequency:",
 		(tz->polling_frequency / 10));
 
 end:


