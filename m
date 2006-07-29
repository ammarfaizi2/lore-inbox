Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWG2Mzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWG2Mzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 08:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWG2Mzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 08:55:31 -0400
Received: from [72.14.214.197] ([72.14.214.197]:52447 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932133AbWG2Mza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 08:55:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oh8mystMW0sZl0insa3etF8gPIwBO7GYFXTPanmt1B8glVLK1SYPuc4C7zrb/IXc1Bbkuw8lAkg8LKz0KuRUTLY+Tb2z8xeHPZuuS3BkqGBktOeTZ7Pkd1CzTaRfA3aiILctXpBuzMrB/dXtzae2Igd80le+x1k7ByZ8/tvGwKc=
Message-ID: <41840b750607290555j3e46aab4vb28efdebea2cc9a8@mail.gmail.com>
Date: Sat, 29 Jul 2006 15:55:27 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DMI: Decode and save OEM String information
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Matt Domsch" <Matt_Domsch@dell.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Henrique de Moraes Holschuh" <hmh@debian.org>
In-Reply-To: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This teaches dmi_decode() how to decode and save OEM Strings (type 11)
DMI information, which is currently discarded silently. Existing code
using DMI is not affected. Follows the "System Management BIOS
(SMBIOS) Specification" (http://www.dmtf.org/standards/smbios),
and also the userspace dmidecode.c code.

OEM Strings are the only safe way to identify some hardware, e.g., the
ThinkPad embedded controller used by the soon-to-be-submitted tp_smapi
driver. This will also let us eliminate the long whitelist in the mainline
hdaps driver (in a future patch).

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
Reposting with better error handling, improved description and a
Signed-off-by.

If there's any problem with acceptance please let me know, since
I'm working on additional patches that will depend on this DMI
information.

To test this patch, run the following kernel code after boot:
	#include <linux/dmi.h>
	...
	struct dmi_device *dev = NULL;
	while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, NULL, dev))) {
		printk(KERN_DEBUG "DMI OEM string: '%s'\n", dev->name);
	}
This will printk all DMI OEM strings (if any), so you can compare it to
# dmidecode | grep -A5 'OEM Strings'


 drivers/firmware/dmi_scan.c |   23 +++++++++++++++++++++++
 include/linux/dmi.h         |    3 ++-
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index b9e3886..04f1597 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -123,6 +123,26 @@ static void __init dmi_save_devices(stru
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
+			printk(KERN_ERR
+			   "dmi_save_oem_strings_devices: out of memory.\n");
+			break;
+		}
+
+		dev->type = DMI_DEV_TYPE_OEM_STRING;
+		dev->name = dmi_string(dm, i);
+		dev->device_data = NULL;

 		list_add(&dev->list, &dmi_devices);
 	}
@@ -181,6 +201,9 @@ static void __init dmi_decode(struct dmi
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
