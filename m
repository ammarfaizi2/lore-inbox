Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbSLDUWq>; Wed, 4 Dec 2002 15:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbSLDUWq>; Wed, 4 Dec 2002 15:22:46 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:62728 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267070AbSLDUWn>; Wed, 4 Dec 2002 15:22:43 -0500
Date: Wed, 4 Dec 2002 21:29:08 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: Pavel Machek <pavel@suse.cz>, Jochen Hein <jochen@delphi.lan-ks.de>,
       <linux-kernel@vger.kernel.org>, <andrew.grover@intel.com>,
       <acpi-devel@lists.sourceforge.net>
Subject: Re: [2.5.50, ACPI] link error
In-Reply-To: <20021204135024.GA2544@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0212042051430.2113-100000@serv>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <20021204114114.GD309@elf.ucw.cz>
 <20021204135024.GA2544@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Dec 2002, Adrian Bunk wrote:

> In drivers/acpi/Config.in in 2.5.44:
> 
> <--   snip  -->
> 
> ...
> if [ "$CONFIG_ACPI_HT_ONLY" != "y" ]; then
>    bool     '  Sleep States' CONFIG_ACPI_SLEEP
> ...
>    define_bool CONFIG_ACPI_SLEEP $CONFIG_SOFTWARE_SUSPEND
> ...
> fi
> ...
> 
> <--  snip  -->
> 
> 
> This double definition was at least confusing, a simple
> 
>   dep_bool '  Sleep States' CONFIG_ACPI_SLEEP $CONFIG_SOFTWARE_SUSPEND
> 
> would have expressed it better.

It's not really the same and the first probably heavily confuses xconfig.
If CONFIG_SOFTWARE_SUSPEND can do without CONFIG_ACPI_SLEEP, the second 
version should work fine.

>  config ACPI_SLEEP
>  	bool "Sleep States"
> -	depends on X86 && ACPI && !ACPI_HT_ONLY
> +	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
>  	default SOFTWARE_SUSPEND
>  	---help---
>  	  This option adds support for ACPI suspend states. 

The default is probably not needed anymore.

> Another thing that seems to be suboptimal is that the question for 
> SOFTWARE_SUSPEND comes _after_ the question for ACPI_SLEEP, IOW someone 
> doing a "make config" to configure his kernel doesn't have a chance to 
> select ACPI_SLEEP.

That was only true with the old "make config". :)

> To fix this (and it seems to be logical) the 
> SOFTWARE_SUSPEND question should be moved to the "Power management 
> options" menu. The patch below tries to solve this and it makes ACPI 
> dependant on PM as the comments in PM indicate:
> - move "Software Suspend" to the "Power management options" menu above
>   the ACPI entry
> - let ACPI depend on PM

Is ACPI really only a PM thingie?

Anyway, I had a cleaned up drivers/acpi/Kconfig lying around. The ACPI 
config file was not really easy to convert automatically. I integrated 
your change from above, it would be nice if some could check if every 
still works as it should.

bye, Roman

--- linux/drivers/acpi/Kconfig	31 Oct 2002 13:26:48 -0000	1.1.1.1
+++ linux/drivers/acpi/Kconfig	4 Dec 2002 20:12:43 -0000
@@ -35,9 +35,11 @@ config ACPI
 	  available at:
 	  <http://www.acpi.info>
 
+if ACPI
+
 config ACPI_HT_ONLY
 	bool "CPU Enumeration Only"
-	depends on X86 && ACPI && X86_LOCAL_APIC
+	depends on X86_LOCAL_APIC
 	---help---
 	  This option enables limited ACPI support -- just enough to 
 	  enumerate processors from the ACPI Multiple APIC Description 
@@ -51,15 +53,12 @@ config ACPI_HT_ONLY
 	  There is no command-line option to disable this, but the kernel
 	  will fall back to the MPS table if the MADT is not present.
 
-config ACPI_BOOT
-	bool
-	depends on IA64 && (!IA64_HP_SIM || IA64_SGI_SN) || X86 && ACPI && !ACPI_HT_ONLY || X86 && ACPI
-	default y
+
+if X86 && !ACPI_HT_ONLY || IA64 && !IA64_HP_SIM
 
 config ACPI_SLEEP
 	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
-	default SOFTWARE_SUSPEND
+	depends on X86 && SOFTWARE_SUSPEND
 	---help---
 	  This option adds support for ACPI suspend states. 
 
@@ -78,7 +77,7 @@ config ACPI_SLEEP
 
 config ACPI_AC
 	tristate "AC Adapter"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
+	depends on X86
 	help
 	  This driver adds support for the AC Adapter object, which indicates
 	  whether a system is on AC, or not.  Typically, only mobile systems 
@@ -86,7 +85,7 @@ config ACPI_AC
 
 config ACPI_BATTERY
 	tristate "Battery"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
+	depends on X86
 	help
 	  This driver adds support for battery information through
 	  /proc/acpi/battery. If you have a mobile system with a battery, 
@@ -94,7 +93,6 @@ config ACPI_BATTERY
 
 config ACPI_BUTTON
 	tristate "Button"
-	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	help
 	  This driver registers for events based on buttons, such as the
 	  power, sleep, and lid switch.  In the future, a daemon will read
@@ -104,14 +102,12 @@ config ACPI_BUTTON
 
 config ACPI_FAN
 	tristate "Fan"
-	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	help
 	  This driver adds support for ACPI fan devices, allowing user-mode 
 	  applications to perform basic fan control (on, off, status).
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	help
 	  This driver installs ACPI as the idle handler for Linux, and uses
 	  ACPI C2 and C3 processor states to save power, on systems that
@@ -119,7 +115,7 @@ config ACPI_PROCESSOR
 
 config ACPI_PROCESSOR_PERF
 	bool "Processor Performance States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY && ACPI_PROCESSOR && CPU_FREQ
+	depends on X86 && ACPI_PROCESSOR && CPU_FREQ
 	help
 	  This driver adds support for CPU frequency scaling, if this is supported
 	  by the hardware and the BIOS. If you are compiling for a mobile system,
@@ -135,12 +131,12 @@ config ACPI_THERMAL
 	  may be damaged without it.
 
 config ACPI_NUMA
-	bool "NUMA support" if NUMA && (IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY)
-	default y if IA64 && IA64_SGI_SN
+	bool "NUMA support"
+	depends on NUMA
 
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
+	depends on X86
 	---help---
 	  This driver adds support for access to certain system settings
 	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
@@ -166,7 +162,6 @@ config ACPI_TOSHIBA
 
 config ACPI_DEBUG
 	bool "Debug Statements"
-	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	help
 	  The ACPI driver can optionally report errors with a great deal
 	  of verbosity. Saying Y enables these statements. This will increase
@@ -174,17 +169,15 @@ config ACPI_DEBUG
 
 config ACPI_BUS
 	bool
-	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	default y
 
 config ACPI_INTERPRETER
 	bool
-	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	default y
 
 config ACPI_EC
 	bool
-	depends on X86 && ACPI && !ACPI_HT_ONLY
+	depends on X86
 	default y
 	help
 	  This driver is required on some systems for the proper operation of
@@ -193,26 +186,35 @@ config ACPI_EC
 
 config ACPI_POWER
 	bool
-	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	default y
 
 config ACPI_PCI
 	bool
-	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	default PCI
 
 config ACPI_SYSTEM
 	bool
-	depends on IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY
 	default y
 	help
 	  This driver will enable your system to shut down using ACPI, and
 	  dump your ACPI DSDT table using /proc/acpi/dsdt.
 
+endif
+
+config ACPI_NUMA
+	depends IA64 && IA64_SGI_SN
+	default y
+
 config ACPI_EFI
 	bool
 	depends on IA64 && (!IA64_HP_SIM || IA64_SGI_SN)
 	default y
+
+config ACPI_BOOT
+	bool
+	default y
+
+endif
 
 endmenu
 

