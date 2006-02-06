Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWBFTPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWBFTPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWBFTPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:15:20 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:47283 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932273AbWBFTPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:15:19 -0500
Date: Mon, 6 Feb 2006 19:15:06 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Make DMI code store chassis type
Message-ID: <20060206191506.GA17395@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch had a typo, so here's a fixed one. This patch stores 
the chassis type of the hardware, making it easier to determine whether 
a piece of hardware from a manufacturer is a laptop. This information is 
not 100% reliable - some vendors insert bogus values, but most of the 
big ones are fairly accurate.

Signed-Off-By: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
index 58516e2..e555588 100644
--- a/arch/i386/kernel/dmi_scan.c
+++ b/arch/i386/kernel/dmi_scan.c
@@ -30,6 +30,50 @@ static char * __init dmi_string(struct d
 	return str;
 }
 
+static char * __init dmi_chassis_type(struct dmi_header *dm, u8 s)
+{
+	char *str = "";
+	static const char *type[]={
+                "Other", /* 0x01 */
+                "Unknown",
+                "Desktop",
+                "Low Profile Desktop",
+                "Pizza Box",
+                "Mini Tower",
+                "Tower",
+                "Portable",
+                "Laptop",
+                "Notebook",
+                "Hand Held",
+                "Docking Station",
+                "All In One",
+                "Sub Notebook",
+                "Space-saving",
+                "Lunch Box",
+                "Main Server Chassis", /* master.mif says System */
+                "Expansion Chassis",
+                "Sub Chassis",
+                "Bus Expansion Chassis",
+                "Peripheral Chassis",
+                "RAID Chassis",
+                "Rack Mount Chassis",
+                "Sealed-case PC",
+                "Multi-system" /* 0x19 */
+        };
+
+        if(s>=0x01 && s<=0x19) {
+		str = alloc_bootmem(strlen(type[code-0x01]));
+		if (str != NULL)
+			strcpy(str, type[code-0x01]);
+		else
+			printk(KERN_ERR "dmi_chassis_type: out of memory.\n");
+
+                return str;
+	}
+
+	return NULL;
+}
+
 /*
  *	We have to be cautious here. We have seen BIOSes with DMI pointers
  *	pointing to completely the wrong place for example
@@ -93,7 +137,11 @@ static void __init dmi_save_ident(struct
 	if (dmi_ident[slot])
 		return;
 
-	p = dmi_string(dm, d[string]);
+	if (slot == DMI_CHASSIS_TYPE)
+		p = dmi_chassis_type(string & 0x7f);
+	else
+		p = dmi_string(dm, d[string]);
+
 	if (p == NULL)
 		return;
 
@@ -176,6 +224,11 @@ static void __init dmi_decode(struct dmi
 		dmi_save_ident(dm, DMI_BOARD_NAME, 5);
 		dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
 		break;
+	case 3:         /* Chassis Information */
+		dmi_save_ident(dm, DMI_CHASSIS_VENDOR, 4);
+		dmi_save_ident(dm, DMI_CHASSIS_TYPE, 5);
+		break;
+		
 	case 10:	/* Onboard Devices Information */
 		dmi_save_devices(dm);
 		break;
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 05f4132..5f425a7 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -15,6 +15,8 @@ enum dmi_field {
 	DMI_BOARD_VENDOR,
 	DMI_BOARD_NAME,
 	DMI_BOARD_VERSION,
+	DMI_CHASSIS_VENDOR,
+	DMI_CHASSIS_TYPE,
 	DMI_STRING_MAX,
 };
 

-- 
Matthew Garrett | mjg59@srcf.ucam.org
