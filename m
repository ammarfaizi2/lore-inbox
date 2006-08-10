Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWHJFcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWHJFcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWHJFcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:32:55 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:27114 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161034AbWHJFcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:32:54 -0400
Date: Thu, 10 Aug 2006 14:32:11 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>
Subject: [PATCH](memory hotplug) Repost remove useless message at boot time from 2.6.18-rc4.
Cc: keith mannthey <kmannth@us.ibm.com>, ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <20060804213230.D5D4.Y-GOTO@jp.fujitsu.com>
References: <20060804213230.D5D4.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060810142329.EB03.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I would like to repost this patch to remove noisy useless message at boot
time from 2.6.18-rc4.
(I said "-mm doesn't shows this message in previous post", but it was wrong.
 This messages are shown by -mm too.)

-------------------------
This is to remove noisy useless message at boot time from 2.6.18-rc4.
The message is a ton of
"ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device"

In my emulation, number of memory devices are not so many (only 6),
but, this messages are displayed 114 times.

It is showed by acpi_memory_register_notify_handler() which
is called by acpi_walk_namespace().

acpi_walk_namespace() parses all of ACPI's namespace and 
execute acpi_memory_register_notify_handler(). So, it is called for
all of the device which is defined in namespace. If
the parsing device is not memory, acpi_memhotplug ignores it
due to "no match" and will parse next device.
This is normal route.

But this message says it is exception. It is meaningless.

I tested this patch for 2.6.18-rc4 on my box with hot-add emulation.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
------


 drivers/acpi/acpi_memhotplug.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

Index: rc4test/drivers/acpi/acpi_memhotplug.c
===================================================================
--- rc4test.orig/drivers/acpi/acpi_memhotplug.c	2006-08-09 15:33:29.000000000 +0900
+++ rc4test/drivers/acpi/acpi_memhotplug.c	2006-08-09 16:26:29.000000000 +0900
@@ -484,10 +484,8 @@ acpi_memory_register_notify_handler(acpi
 
 
 	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
+	if (ACPI_FAILURE(status))
 		return AE_OK;	/* continue */
-	}
 
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 					     acpi_memory_device_notify, NULL);
@@ -503,10 +501,8 @@ acpi_memory_deregister_notify_handler(ac
 
 
 	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
+	if (ACPI_FAILURE(status))
 		return AE_OK;	/* continue */
-	}
 
 	status = acpi_remove_notify_handler(handle,
 					    ACPI_SYSTEM_NOTIFY,

-- 
Yasunori Goto 


