Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVD1Ij6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVD1Ij6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVD1Ihm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:37:42 -0400
Received: from fmr19.intel.com ([134.134.136.18]:28566 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261543AbVD1IcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:32:24 -0400
Subject: Re: [PATCH 6/6]suspend/resume SMP support
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20050428004108.3c670bf2.akpm@osdl.org>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	 <20050428002254.461fcf32.akpm@osdl.org>
	 <1114673297.26367.3.camel@sli10-desk.sh.intel.com>
	 <20050428004108.3c670bf2.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1114676961.26367.12.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 16:29:22 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 15:41, Andrew Morton wrote:
> 
> But does setting CONFIG_ACPI_SLEEP cause kernel/power/smp.o to be actually
> compiled and linked?  I don't think so?
> 
> Anyway, please send a tested fix.
Ha, this one should be ok. Only IA32 support SMP suspend now.

Thanks,
Shaohua

---

 linux-2.6.11-root/drivers/acpi/Kconfig    |    2 +-
 linux-2.6.11-root/include/linux/suspend.h |    2 +-
 linux-2.6.11-root/kernel/power/Kconfig    |    6 +++++-
 linux-2.6.11-root/kernel/power/Makefile   |    6 +++---
 4 files changed, 10 insertions(+), 6 deletions(-)

diff -puN kernel/power/Makefile~kconfig kernel/power/Makefile
--- linux-2.6.11/kernel/power/Makefile~kconfig	2005-04-28 15:47:44.862281448 +0800
+++ linux-2.6.11-root/kernel/power/Makefile	2005-04-28 16:12:04.285415408 +0800
@@ -3,9 +3,9 @@ ifeq ($(CONFIG_PM_DEBUG),y)
 EXTRA_CFLAGS	+=	-DDEBUG
 endif
 
-swsusp-smp-$(CONFIG_SMP)	+= smp.o
-
 obj-y				:= main.o process.o console.o pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o $(swsusp-smp-y) disk.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o
+
+obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff -puN kernel/power/Kconfig~kconfig kernel/power/Kconfig
--- linux-2.6.11/kernel/power/Kconfig~kconfig	2005-04-28 15:48:45.195109464 +0800
+++ linux-2.6.11-root/kernel/power/Kconfig	2005-04-28 16:24:22.821140912 +0800
@@ -28,7 +28,7 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP && (HOTPLUG_CPU || !SMP)
+	depends on EXPERIMENTAL && PM && SWAP && (SUSPEND_SMP || !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
@@ -72,3 +72,7 @@ config PM_STD_PARTITION
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
+config SUSPEND_SMP
+	bool
+	depends on HOTPLUG_CPU && X86 && PM
+	default y
diff -puN drivers/acpi/Kconfig~kconfig drivers/acpi/Kconfig
--- linux-2.6.11/drivers/acpi/Kconfig~kconfig	2005-04-28 15:52:38.148695136 +0800
+++ linux-2.6.11-root/drivers/acpi/Kconfig	2005-04-28 15:53:01.707113712 +0800
@@ -57,7 +57,7 @@ if ACPI_INTERPRETER
 
 config ACPI_SLEEP
 	bool "Sleep States (EXPERIMENTAL)"
-	depends on X86 && (!SMP || HOTPLUG_CPU)
+	depends on X86 && (!SMP || SUSPEND_SMP)
 	depends on EXPERIMENTAL
 	default y
 	---help---
diff -puN include/linux/suspend.h~kconfig include/linux/suspend.h
--- linux-2.6.11/include/linux/suspend.h~kconfig	2005-04-28 15:53:50.261732288 +0800
+++ linux-2.6.11-root/include/linux/suspend.h	2005-04-28 15:54:12.928286448 +0800
@@ -58,7 +58,7 @@ static inline int software_suspend(void)
 }
 #endif
 
-#ifdef CONFIG_HOTPLUG_CPU
+#ifdef CONFIG_SUSPEND_SMP
 extern void disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
 #else
_


