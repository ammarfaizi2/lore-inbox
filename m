Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267420AbSLEU64>; Thu, 5 Dec 2002 15:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbSLEU5p>; Thu, 5 Dec 2002 15:57:45 -0500
Received: from [195.39.17.254] ([195.39.17.254]:15876 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267420AbSLEU5D>;
	Thu, 5 Dec 2002 15:57:03 -0500
Date: Wed, 4 Dec 2002 13:59:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp & acpi_sleep: configuration issues
Message-ID: <20021204125954.GA8199@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This moves CONFIG_SOFTWARE_SUSPEND where it belongs, and makes
ACPI_SLEEP depend on it to prevent compile problems. Please apply,

							Pavel

--- clean/arch/i386/Kconfig	2002-11-29 21:16:30.000000000 +0100
+++ linux-swsusp/arch/i386/Kconfig	2002-11-29 21:29:34.000000000 +0100
@@ -789,8 +789,6 @@
 
 menu "Power management options (ACPI, APM)"
 
-source "drivers/acpi/Kconfig"
-
 config PM
 	bool "Power Management support"
 	---help---
@@ -811,6 +809,37 @@
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
+config SOFTWARE_SUSPEND
+	bool "Software Suspend (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && PM
+	---help---
+	  Enable the possibilty of suspendig machine. It doesn't need APM.
+	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
+	  (patch for sysvinit needed). 
+
+	  It creates an image which is saved in your active swaps. By the next
+	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
+	  detect the saved image, restore the memory from
+	  it and then it continues to run as before you've suspended.
+	  If you don't want the previous state to continue use the 'noresume'
+	  kernel option. However note that your partitions will be fsck'd and
+	  you must re-mkswap your swap partitions/files.
+
+	  Right now you may boot without resuming and then later resume but
+	  in meantime you cannot use those swap partitions/files which were
+	  involved in suspending. Also in this case there is a risk that buffers
+	  on disk won't match with saved ones.
+
+	  SMP is supported ``as-is''. There's a code for it but doesn't work.
+	  There have been problems reported relating SCSI.
+
+	  This option is about getting stable. However there is still some
+	  absence of features.
+
+	  For more information take a look at Documentation/swsusp.txt.
+
+source "drivers/acpi/Kconfig"
+
 config APM
 	tristate "Advanced Power Management BIOS support"
 	depends on PM
@@ -1516,35 +1545,6 @@
 
 menu "Kernel hacking"
 
-config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM
-	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
-	  detect the saved image, restore the memory from
-	  it and then it continues to run as before you've suspended.
-	  If you don't want the previous state to continue use the 'noresume'
-	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
-
-	  Right now you may boot without resuming and then later resume but
-	  in meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
-	  on disk won't match with saved ones.
-
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
-	  For more information take a look at Documentation/swsusp.txt.
-
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
--- clean/drivers/acpi/Kconfig	2002-11-01 00:37:09.000000000 +0100
+++ linux-swsusp/drivers/acpi/Kconfig	2002-11-23 21:16:32.000000000 +0100
@@ -58,8 +58,7 @@
 
 config ACPI_SLEEP
 	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
-	default SOFTWARE_SUSPEND
+	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
 	---help---
 	  This option adds support for ACPI suspend states. 
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
