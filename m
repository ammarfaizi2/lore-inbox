Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVENMrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVENMrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 08:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVENMq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 08:46:56 -0400
Received: from mail.donpac.ru ([80.254.111.2]:5539 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262755AbVENMo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 08:44:57 -0400
Subject: [PATCH 2.6.12-rc4-mm1 1/3] DMI, move ACPI sleep quirk
In-Reply-To: <11160746954181@donpac.ru>
Date: Sat, 14 May 2005 16:44:56 +0400
Message-Id: <11160746962011@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch moves ACPI sleep quirk out of dmi_scan.c

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/acpi/sleep.c |   26 ++++++++++++++++++++++++++
 arch/i386/kernel/dmi_scan.c   |   16 ----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff -urdpNX dontdiff linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/acpi/sleep.c linux-2.6.12-rc4-mm1/arch/i386/kernel/acpi/sleep.c
--- linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/acpi/sleep.c	2005-05-04 14:00:09.000000000 +0400
+++ linux-2.6.12-rc4-mm1/arch/i386/kernel/acpi/sleep.c	2005-05-04 15:00:03.000000000 +0400
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
+#include <linux/dmi.h>
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
@@ -91,3 +92,28 @@ static int __init acpi_sleep_setup(char 
 
 
 __setup("acpi_sleep=", acpi_sleep_setup);
+
+
+static __init int reset_videomode_after_s3(struct dmi_system_id *d)
+{
+	acpi_video_flags |= 2;
+	return 0;
+}
+
+static __initdata struct dmi_system_id acpisleep_dmi_table[] = {
+	{	/* Reset video mode after returning from ACPI S3 sleep */
+		.callback = reset_videomode_after_s3,
+		.ident = "Toshiba Satellite 4030cdt",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
+		},
+	},
+};
+
+static int __init acpisleep_dmi_init(void)
+{
+	dmi_check_system(acpisleep_dmi_table);
+	return 0;
+}
+
+core_initcall(acpisleep_dmi_init);
diff -urdpNX dontdiff linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.12-rc4-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/dmi_scan.c	2005-05-04 14:59:28.000000000 +0400
+++ linux-2.6.12-rc4-mm1/arch/i386/kernel/dmi_scan.c	2005-05-04 15:00:04.000000000 +0400
@@ -177,16 +177,6 @@ static __init int broken_toshiba_keyboar
 }
 
 
-#ifdef CONFIG_ACPI_SLEEP
-static __init int reset_videomode_after_s3(struct dmi_blacklist *d)
-{
-	/* See acpi_wakeup.S */
-	extern long acpi_video_flags;
-	acpi_video_flags |= 2;
-	return 0;
-}
-#endif
-
 
 /*
  *	Process the DMI blacklists
@@ -204,12 +194,6 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
-#ifdef CONFIG_ACPI_SLEEP
-	{ reset_videomode_after_s3, "Toshiba Satellite 4030cdt", { /* Reset video mode after returning from ACPI S3 sleep */
-			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
-			NO_MATCH, NO_MATCH, NO_MATCH
-			} },
-#endif
 
 	{ NULL, }
 };

