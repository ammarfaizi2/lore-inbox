Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTJJW0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTJJW0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:26:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:43919 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263150AbTJJW0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:26:32 -0400
Date: Fri, 10 Oct 2003 15:34:35 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Karol Kozimor <sziwan@hell.org.pl>
cc: acpi-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [PM][ACPI] /proc/acpi/alarm halfway working
In-Reply-To: <20030927234630.GA32525@hell.org.pl>
Message-ID: <Pine.LNX.4.44.0310101532550.3605-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've just tested 2.6.0-test5-mm4, it seems that the /proc/acpi/alarm
> has ceased to deadlock my laptop and actually started to work as
> expected. The only drawback is:
> #v+
> irq 9: nobody cared!

Sorry it's taken so long to reply, but I've finally had a chance to track 
this down. Could you try the following patch and let me know if it fixes 
the problem for you? 

Thanks,


	Pat

===== drivers/acpi/utilities/utglobal.c 1.28 vs edited =====
--- 1.28/drivers/acpi/utilities/utglobal.c	Sun Jul 13 16:07:33 2003
+++ edited/drivers/acpi/utilities/utglobal.c	Thu Oct  9 14:27:16 2003
@@ -358,7 +358,7 @@
 	/* ACPI_EVENT_GLOBAL        */  {ACPI_BITREG_GLOBAL_LOCK_STATUS,    ACPI_BITREG_GLOBAL_LOCK_ENABLE,  ACPI_BITMASK_GLOBAL_LOCK_STATUS,    ACPI_BITMASK_GLOBAL_LOCK_ENABLE},
 	/* ACPI_EVENT_POWER_BUTTON  */  {ACPI_BITREG_POWER_BUTTON_STATUS,   ACPI_BITREG_POWER_BUTTON_ENABLE, ACPI_BITMASK_POWER_BUTTON_STATUS,   ACPI_BITMASK_POWER_BUTTON_ENABLE},
 	/* ACPI_EVENT_SLEEP_BUTTON  */  {ACPI_BITREG_SLEEP_BUTTON_STATUS,   ACPI_BITREG_SLEEP_BUTTON_ENABLE, ACPI_BITMASK_SLEEP_BUTTON_STATUS,   ACPI_BITMASK_SLEEP_BUTTON_ENABLE},
-	/* ACPI_EVENT_RTC           */  {ACPI_BITREG_RT_CLOCK_STATUS,       ACPI_BITREG_RT_CLOCK_ENABLE,     0,                                  0},
+	/* ACPI_EVENT_RTC           */  {ACPI_BITREG_RT_CLOCK_STATUS,       ACPI_BITREG_RT_CLOCK_ENABLE,	ACPI_BITMASK_RT_CLOCK_STATUS,	ACPI_BITMASK_RT_CLOCK_ENABLE},
 };
 
 /*****************************************************************************
===== drivers/acpi/sleep/proc.c 1.7 vs edited =====
--- 1.7/drivers/acpi/sleep/proc.c	Wed Sep 10 09:27:28 2003
+++ edited/drivers/acpi/sleep/proc.c	Fri Oct 10 10:05:36 2003
@@ -1,3 +1,4 @@
+#include <linux/interrupt.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/suspend.h>
@@ -370,6 +371,14 @@
 };
 
 
+static u32 rtc_handler(void * context)
+{
+	acpi_set_register(ACPI_BITREG_RT_CLOCK_STATUS, 1, ACPI_MTX_LOCK);
+	acpi_set_register(ACPI_BITREG_RT_CLOCK_ENABLE, 0, ACPI_MTX_LOCK);
+	return IRQ_HANDLED;
+}
+
+
 static int acpi_sleep_proc_init(void)
 {
 	struct proc_dir_entry	*entry = NULL;
@@ -385,6 +394,8 @@
 		S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_alarm_fops;
+
+	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
 	return 0;
 }
 

