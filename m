Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWG0NrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWG0NrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWG0NrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:47:03 -0400
Received: from hu-out-0102.google.com ([72.14.214.193]:57880 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161078AbWG0NrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:47:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=suyRAJ+DbEscMN5K49/uKx+AqUOV98340rGKNXhRKzMF3b5pT5kj7+sFrO+qMoqkViaAgP8jtDRq7SXl8zeXHC7TXiRXcmsOSkxI5Lw+J1oCoieDoROlFcbr4O7m5fd/W70InyB4OvvzJfmDSq0aZqxGrgArxqjjhJhd/EV+uqo=
Message-ID: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
Date: Thu, 27 Jul 2006 16:47:00 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] DMI: Decode and save OEM String information
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Matt Domsch" <Matt_Domsch@dell.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Henrique de Moraes Holschuh" <hmh@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This teachs dmi_decode() how to to save OEM Strings (type 11) information.
OEM Strings are  the only safe way to identify some hardware, e.g., the ThinkPad
embedded controller used by the soon-to-be-submitted tp_smapi driver.

Follows the "System Management BIOS (SMBIOS) Specification"
(http://www.dmtf.org/standards/smbios), and also the userspace
dmidecode.c code.

---
 drivers/firmware/dmi_scan.c |   21 +++++++++++++++++++++
 include/linux/dmi.h         |    3 ++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index b9e3886..d1add3f 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -123,6 +123,24 @@ static void __init dmi_save_devices(stru
 		dev->type = *d++ & 0x7f;
 		dev->name = dmi_string(dm, *d);
 		dev->device_data = NULL;
+		list_add(&dev->list, &dmi_devices);
+	}
+}
+
+static void __init dmi_save_oem_strings_devices(struct dmi_header *dm)
+{
+	int i, count = *(u8 *)(dm + 1);
+	struct dmi_device *dev;
+
+	for (i = 1; i <= count; i++) {
+		dev = dmi_alloc(sizeof(*dev));
+		if (!dev) {
+			break;
+		}
+
+		dev->type = DMI_DEV_TYPE_OEM_STRING;
+		dev->name = dmi_string(dm, i);
+		dev->device_data = NULL;

 		list_add(&dev->list, &dmi_devices);
 	}
@@ -181,6 +199,9 @@ static void __init dmi_decode(struct dmi
 	case 10:	/* Onboard Devices Information */
 		dmi_save_devices(dm);
 		break;
+	case 11:	/* OEM Strings */
+		dmi_save_oem_strings_devices(dm);
+		break;
 	case 38:	/* IPMI Device Information */
 		dmi_save_ipmi_device(dm);
 	}
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index b2cd207..38dc403 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -27,7 +27,8 @@ enum dmi_device_type {
 	DMI_DEV_TYPE_ETHERNET,
 	DMI_DEV_TYPE_TOKENRING,
 	DMI_DEV_TYPE_SOUND,
-	DMI_DEV_TYPE_IPMI = -1
+	DMI_DEV_TYPE_IPMI = -1,
+	DMI_DEV_TYPE_OEM_STRING = -2
 };

 struct dmi_header {
