Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272539AbTHEH0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272548AbTHEH0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:26:47 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:16034 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272539AbTHEH0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:26:38 -0400
Date: Tue, 5 Aug 2003 09:26:31 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030805072631.GC5876@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend: patch against test2-bk4.
Sanitize power management config menus, take two.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2003-07-14 09:38:20.000000000 +0200
+++ b/arch/i386/Kconfig	2003-07-27 13:57:09.000000000 +0200
@@ -797,11 +797,11 @@
 endmenu
 
 
-menu "Power management options (ACPI, APM)"
+menu "Power management support"
 	depends on !X86_VOYAGER
 
 config PM
-	bool "Power Management support"
+	bool "Power management support"
 	---help---
 	  "Power Management" means that parts of your computer are shut
 	  off or put into a power conserving "sleep" mode if they are not
@@ -820,34 +820,7 @@
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
-config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
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
+source "kernel/Kconfig.swsusp"
 
 source "drivers/acpi/Kconfig"
 
diff -urN a/arch/i386/kernel/cpu/cpufreq/Kconfig b/arch/i386/kernel/cpu/cpufreq/Kconfig
--- a/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-07-10 23:30:33.000000000 +0200
+++ b/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-07-27 13:50:30.000000000 +0200
@@ -2,10 +2,9 @@
 # CPU Frequency scaling
 #
 
-menu "CPU Frequency scaling"
-
 config CPU_FREQ
 	bool "CPU Frequency scaling"
+	depends on PM
 	help
 	  Clock scaling allows you to change the clock speed of CPUs on the
 	  fly. This is a nice method to save battery power on notebooks,
@@ -16,6 +15,8 @@
 
 	  If in doubt, say N.
 
+if CPU_FREQ
+
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_TABLE
@@ -162,4 +163,4 @@
 
 	  If in doubt, say N.
 
-endmenu
+endif
diff -urN a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2003-07-14 09:38:20.000000000 +0200
+++ b/arch/x86_64/Kconfig	2003-07-27 13:57:24.000000000 +0200
@@ -296,34 +296,7 @@
 	  sending the processor to limited sleep and saving power. However
 	  using ACPI will likely save more power.
 
-config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
-	---help---
-	  Enable the possibilty of suspending the machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. On the next
-	  boot, pass the 'resume=/path/to/your/swap/file' option and the kernel
-	  will detect the saved image, restore the memory from
-	  it, and then continue to run as before you suspended.
-	  If you don't want the previous state to continue, use the 'noresume'
-	  kernel option. However, note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
-
-	  Right now you may boot without resuming and then later resume but
-	  in the meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
-	  on disk won't match with saved ones.
-
-	  SMP is supported ``as-is''. There's code for it but doesn't work.
-	  There have been problems reported relating to SCSI.
-
-	  This option is close to getting stable. However there is still some
-	  absence of features.
-
-	  For more information take a look at Documentation/swsusp.txt.
+source "kernel/Kconfig.swsusp"
 
 source "drivers/acpi/Kconfig"
 
diff -urN a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig	2003-06-22 22:27:39.000000000 +0200
+++ b/drivers/acpi/Kconfig	2003-07-27 13:50:30.000000000 +0200
@@ -2,7 +2,7 @@
 # ACPI Configuration
 #
 
-menu "ACPI Support"
+if PM
 
 config ACPI
 	bool "ACPI Support" if X86
@@ -36,6 +36,8 @@
 	  available at:
 	  <http://www.acpi.info>
 
+if ACPI
+
 config ACPI_HT_ONLY
 	bool "CPU Enumeration Only"
 	depends on X86 && ACPI && X86_LOCAL_APIC
@@ -236,5 +238,6 @@
 	depends on IA64 && (!IA64_HP_SIM || IA64_SGI_SN)
 	default y
 
-endmenu
+endif
 
+endif
diff -urN a/kernel/Kconfig.swsusp b/kernel/Kconfig.swsusp
--- a/kernel/Kconfig.swsusp	1970-01-01 01:00:00.000000000 +0100
+++ b/kernel/Kconfig.swsusp	2003-07-27 14:13:26.000000000 +0200
@@ -0,0 +1,26 @@
+config SOFTWARE_SUSPEND
+	bool "Software Suspend (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && PM && SWAP
+	---help---
+	  Enable the possibility of suspending the machine.  This feature
+	  doesn't require APM.  You may suspend your machine by 'swsusp'
+	  or 'shutdown -z <time>' (with the appropriate patch for sysvinit).
+
+	  The suspend procedure will create an image that is saved in one
+	  of your active swap partitions (swap files are not supported).
+
+	  On the next boot, passing the kernel boot option
+	  'resume=/path/to/your/swap/partition' will cause the kernel
+	  to detect the saved image, restore system memory from it and
+	  then continue to run as before you suspended.  If you don't
+	  want the previous state restored, use the 'noresume' kernel
+	  boot option.  However, note that in this case your partitions
+	  will appear to be damaged and you will need to re-mkswap.
+
+	  You are not advised to boot without resuming and then resume
+	  later.  There is a high probability that buffers on disk won't
+	  match with the saved ones.
+
+	  SMP is NOT supported at this time.
+
+	  For more information take a look at Documentation/swsusp.txt.

