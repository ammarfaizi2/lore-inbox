Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBBTwH>; Fri, 2 Feb 2001 14:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRBBTv5>; Fri, 2 Feb 2001 14:51:57 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129047AbRBBTu5>;
	Fri, 2 Feb 2001 14:50:57 -0500
Message-ID: <20010202155341.A149@bug.ucw.cz>
Date: Fri, 2 Feb 2001 15:53:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: andrew.grover@intel.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Better battery info/status files
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes units, and makes format tag: value. Please apply.
								Pavel

--- clean/drivers/acpi/cmbatt.c	Wed Jan 31 16:14:26 2001
+++ linux/drivers/acpi/cmbatt.c	Thu Feb  1 10:55:31 2001
@@ -246,38 +254,32 @@
 		goto end;
 	}
 
-	if (info->last_full_capacity == ACPI_BATT_UNKNOWN)
-		p += sprintf(p, "Unknown last full capacity\n");
-	else
-		p += sprintf(p, "Last Full Capacity %x %s /hr\n", 
+	if (info->last_full_capacity != ACPI_BATT_UNKNOWN)
+		p += sprintf(p, "Last Full Capacity: %d %sh\n", 
 		     info->last_full_capacity, batt_list[batt_num].power_unit);
 
-	if (info->design_capacity == ACPI_BATT_UNKNOWN)
-		p += sprintf(p, "Unknown Design Capacity\n");
-	else
-		p += sprintf(p, "Design Capacity %x %s /hr\n", 
+	if (info->design_capacity != ACPI_BATT_UNKNOWN)
+		p += sprintf(p, "Design Capacity:    %d %sh\n", 
 		     info->design_capacity, batt_list[batt_num].power_unit);
 	
 	if (info->battery_technology)
-		p += sprintf(p, "Secondary Battery Technology\n");
+		p += sprintf(p, "Battery Technology: Secondary\n");
 	else
-		p += sprintf(p, "Primary Battery Technology\n");
+		p += sprintf(p, "Battery Technology: Primary\n");
 	
-	if (info->design_voltage == ACPI_BATT_UNKNOWN)
-		p += sprintf(p, "Unknown Design Voltage\n");
-	else
-		p += sprintf(p, "Design Voltage %x mV\n", 
+	if (info->design_voltage != ACPI_BATT_UNKNOWN)
+		p += sprintf(p, "Design Voltage:     %d mV\n", 
 		     info->design_voltage);
 	
-	p += sprintf(p, "Design Capacity Warning %d\n",
-		info->design_capacity_warning);
-	p += sprintf(p, "Design Capacity Low %d\n",
-		info->design_capacity_low);
-	p += sprintf(p, "Battery Capacity Granularity 1 %d\n",
+	p += sprintf(p, "Design Capacity Warning:    %d %sh\n",
+		info->design_capacity_warning, batt_list[batt_num].power_unit);
+	p += sprintf(p, "Design Capacity Low:        %d %sh\n",
+		info->design_capacity_low, batt_list[batt_num].power_unit);
+	p += sprintf(p, "Battery Capacity Granularity 1: %d\n",
 		info->battery_capacity_granularity_1);
-	p += sprintf(p, "Battery Capacity Granularity 2 %d\n",
+	p += sprintf(p, "Battery Capacity Granularity 2: %d\n",
 		info->battery_capacity_granularity_2);
-	p += sprintf(p, "model number %s\nserial number %s\nbattery type %s\nOEM info %s\n",
+	p += sprintf(p, "Model number; %s\nSerial number: %s\nBattery type: %s\nOEM info: %s\n",
 		info->model_number,info->serial_number,
 		info->battery_type,info->oem_info);
 end:
@@ -308,40 +310,29 @@
 		goto end;
 	}
 
-	printk("getting batt status\n");
-
 	if (acpi_get_battery_status(batt_list[batt_num].handle, &status) != AE_OK) {
 		printk(KERN_ERR "Cmbatt: acpi_get_battery_status failed\n");
 		goto end;
 	}
 
-	p += sprintf(p, "Remaining Capacity: %x\n", status.remaining_capacity);
+	p += sprintf(p, "Battery discharging:        %s\n",
+		     (status.state & 0x1)?"yes":"no");
+	p += sprintf(p, "Battery charging:           %s\n",
+		     (status.state & 0x2)?"yes":"no");
+	p += sprintf(p, "Battery critically low:     %s\n",
+		     (status.state & 0x4)?"yes":"no");
+
+	if (status.present_rate != ACPI_BATT_UNKNOWN)
+		p += sprintf(p, "Battery rate:               %d %s\n",
+			status.present_rate, batt_list[batt_num].power_unit);
 
-	if (status.state & 0x1)
-		p += sprintf(p, "Battery discharging\n");
-	if (status.state & 0x2)
-		p += sprintf(p, "Battery charging\n");
-	if (status.state & 0x4)
-		p += sprintf(p, "Battery critically low\n");
-
-	if (status.present_rate == ACPI_BATT_UNKNOWN)
-		p += sprintf(p, "Battery rate unknown\n");
-	else
-		p += sprintf(p, "Battery rate %x\n",
-			status.present_rate);
-
-	if (status.remaining_capacity == ACPI_BATT_UNKNOWN)
-		p += sprintf(p, "Battery capacity unknown\n");
-	else
-		p += sprintf(p, "Battery capacity %x %s\n",
+	if (status.remaining_capacity != ACPI_BATT_UNKNOWN)
+		p += sprintf(p, "Battery capacity:           %d %sh\n",
 			status.remaining_capacity, batt_list[batt_num].power_unit);
 
-	if (status.present_voltage == ACPI_BATT_UNKNOWN)
-		p += sprintf(p, "Battery voltage unknown\n");
-	else
-		p += sprintf(p, "Battery voltage %x volts\n",
+	if (status.present_voltage != ACPI_BATT_UNKNOWN)
+		p += sprintf(p, "Battery voltage:            %d mV\n",
 			status.present_voltage);
-
 end:
 
 	len = (p - page);

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
