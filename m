Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVF2RMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVF2RMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVF2RIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:08:54 -0400
Received: from hell.org.pl ([62.233.239.4]:14096 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262609AbVF2REH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:04:07 -0400
Date: Wed, 29 Jun 2005 19:03:52 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] video.c: properly remove notify handlers
Message-ID: <20050629170352.GA11807@hell.org.pl>
Mail-Followup-To: acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The video driver doesn't properly remove all the notify handlers on module
unload. This has a side effect of subdevices failing to register on module
reload, but sudden death looms if the handlers trigger after the module is
unloaded (not that I've seen such a machine, but still). Please apply.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl

Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>

--- a/drivers/acpi/video.c	2005-04-26 00:43:38.000000000 +0200
+++ b/drivers/acpi/video.c	2005-06-29 18:02:04.000000000 +0200
@@ -1666,6 +1666,7 @@
 acpi_video_bus_put_one_device(
 	struct acpi_video_device	*device)
 {
+	acpi_status status;
 	struct acpi_video_bus *video;
 
 	ACPI_FUNCTION_TRACE("acpi_video_bus_put_one_device");
@@ -1680,6 +1681,12 @@
 	up(&video->sem);
 	acpi_video_device_remove_fs(device->dev);
 
+	status = acpi_remove_notify_handler(device->handle,
+		ACPI_DEVICE_NOTIFY, acpi_video_device_notify);
+	if (ACPI_FAILURE(status))
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error removing notify handler\n"));
+
 	return_VALUE(0);
 }
 
