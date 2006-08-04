Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161192AbWHDMiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbWHDMiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 08:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161189AbWHDMiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 08:38:25 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25743 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161188AbWHDMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 08:38:23 -0400
Date: Fri, 04 Aug 2006 21:37:34 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: akpm@osdl.org
Subject: [PATCH](memory hotplug) remove useless message at boot time from 2.6.18-rc3.
Cc: keith mannthey <kmannth@us.ibm.com>, ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060804213230.D5D4.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to remove noisy useless message at boot time from 2.6.18-rc3.
(-mm doesn't shows this message. I don't know why.)

The message is a ton of 
"ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device"

It is showed by acpi_memory_register_notify_handler() which
is called by acpi_walk_namespace().

acpi_walk_namespace() parses all of ACPI's namespace and 
executes acpi_memory_register_notify_handler(). So, it is called for
all of the device which is defined in namespace. Even if
the parsing device is not memory, it is normal route.
So, this message is useless.

I tested this patch for 2.6.18-rc3 on my box with hot-add emulation.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
------

 drivers/acpi/acpi_memhotplug.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

Index: hotmemtest1/drivers/acpi/acpi_memhotplug.c
===================================================================
--- hotmemtest1.orig/drivers/acpi/acpi_memhotplug.c	2006-08-03 20:00:58.000000000 +0900
+++ hotmemtest1/drivers/acpi/acpi_memhotplug.c	2006-08-04 21:06:52.000000000 +0900
@@ -487,10 +487,8 @@ acpi_memory_register_notify_handler(acpi
 
 
 	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
+	if (ACPI_FAILURE(status))
 		return AE_OK;	/* continue */
-	}
 
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 					     acpi_memory_device_notify, NULL);
@@ -506,10 +504,8 @@ acpi_memory_deregister_notify_handler(ac
 
 
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


