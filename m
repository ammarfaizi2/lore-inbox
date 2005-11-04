Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVKDUOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVKDUOl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 15:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVKDUOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 15:14:40 -0500
Received: from bender.bawue.de ([193.7.176.20]:49352 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1750847AbVKDUOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 15:14:39 -0500
Date: Fri, 4 Nov 2005 21:12:13 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20051104201213.GA24914@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a processor idle module for AMD SMP 760MP(X) based systems.
The patch was originally written by Tony Lindgren and has been around
since 2002.  It enables C2 mode on AMD SMP systems and thus saves
about 70 - 90 W of energy in the idle mode compared to the default idle
mode.  The idle function has been rewritten and is now free of locking
issues and is independent from the number of CPUs.  The impact
from this module on the system clock and on i/o transfer rates has
been reduced.

This patch can also be found at
http://www.sommrey.de/amd76x_pm/amd76x_pm-2.6.14-1.patch

Signed-off-by: Joerg Sommrey <jo@sommrey.de>


diff -Nru linux-2.6.14/Documentation/amd76x_pm.txt linux-2.6.14-jo/Documentation/amd76x_pm.txt
--- linux-2.6.14/Documentation/amd76x_pm.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-jo/Documentation/amd76x_pm.txt	2005-11-04 20:36:29.000000000 +0100
@@ -0,0 +1,341 @@
+	ACPI style power management for SMP AMD-760MP(X) based systems
+	==============================================================
+
+For use until the ACPI project catches up. :-)
+
+Using this module saves about 70 - 90W of energy in the idle mode compared
+to the default idle mode. Waking up from the idle mode is fast to keep the
+system response time good. Currently no CPU load calculation is done, the
+system exits the idle mode after every C2 call.
+
+Known issues:
+-------------
+- Currently there's a bug somewhere where the reading the
+  P_LVL2 for the first time causes the system to sleep instead of 
+  idling. This means that you need to hit the power button once to
+  wake the system after loading the module for the first time after
+  reboot. After that the system idles as supposed.
+  (Only observed on Tony's system.)
+
+- On kernel up to and including 2.6.13 there might appear a weird
+  keyboard repeating after an uptime of 1-2 days.  This seems to
+  coincide with IRQ 0 being routed to CPU1: setting smp_affinity to 1 for
+  IRQ 0 soon after booting circumvents the problem.  On 2.6.14 interrupt
+  routing has changed and I didn't watch the problem anymore.
+
+- There might be reduced throughput of disk or network devices.  See
+  below for how to configure the "irq rate watcher" to avoid this.
+
+- I have a report of occasional hard lockups that might be caused by
+  amd76x_pm.
+
+Influenced by Vcool, and LVCool. Rewrote everything from scratch to
+use the PCI features in Linux, and to support SMP systems.
+
+Currently tested amongst others on a TYAN S2460 (760MP) system (Tony), an
+ASUS A7M266-D (760MPX) system (Johnathan) and a TYAN S2466 (760MPX)
+system (Jo). Adding support for other Athlon SMP or single processor
+systems should be easy if desired.  
+
+The file /sys/devices/pci0000:00/0000:00:00.0/C2_cnt shows the number of
+C2 calls since module load.
+
+There are some parameters for tuning the behaviour of amd76x_pm:
+lazy_idle, spin_idle, watch_irqs, watch_int and min_C1
+
+lazy_idle and spin_idle are closely related:
+
+- lazy_idle defines the number of idle calls into amd76x_smp_idle that are
+  needed to *enable* C2 mode.  This parameter is the maximum loop counter
+  for an outer loop with interrupts enabled that guarantees low latencies. 
+  The default for lazy_idle is 512.
+
+- spin_idle defines the maximum number of spin cycles in an inner idle loop
+  where one CPU waits for all others to get into C2-enabled mode. When all
+  CPUs are in C2-enable mode they (more ore less) simultaneously *enter* C2
+  mode. In this inner loop interrupts are disabled.  The loop is left
+  immediatly if there is something waiting to be scheduled.  The default
+  for spin_idle is 2*lazy_idle.
+
+lazy_idle and spin_idle define a "rubber measure" for the idling
+behaviour: lazy_idle defines the minimum "idling" needed to enter C2 and
+spin_idle defines when to give up.
+
+Low values for lazy_idle and high values for spin_idle give better
+cooling.  Higher values for lazy_idle simply give less cooling.  spin_idle
+is a kind of emergency break to leave C2-enable mode if CPUs don't
+synchronize.
+
+irq rate watcher:
+-----------------
+Interrupts are disabled in C2 mode.  The CPUs are woken up by timer
+interrups or by NMIs.  This causes a high interrupt latency for other
+interrupts that leads to a significant reduction in io or network
+throughput.  There has been introduced a "irq rate watcher" to reduce
+this effect.  If the irq rate watcher detects that an interrupt has a
+rate above a given limit, C2 idling is disabled and a low latency C1
+idling mode is used instead. The parameters watch_irqs, watch_int and
+min_C1 control this irq rate watcher:
+
+- watch_irqs defines which interrupts are to be watched and optionally
+  at which interrupt rate C2 mode shall be disabled.  The syntax for 
+  watch_irqs is irq1[:rate1],irq2[:rate2],...  The rate is measured in
+  interrupts per second and defaults to 128.  There is no default for
+  watch_irqs.  To enable the irq rate watcher you must specify this
+  parameter.  Enter the interrupts used by disk controllers or network
+  adapters here.
+  
+- watch_int defines the time interval (in milliseconds) at which the
+  interrupt rate is checked.  Too low values may result in an overhead
+  and too high values cause the C1 mode to "kick in" later.  The default
+  for watch_int is 1 second.
+
+- min_C1 defines the mininum number of check intervals with low
+  interrupt rates that are needed to leave the forced C1 mode.
+
+All parameters lazy_idle, spin_idle, watch_irqs and watch_int may be
+given as module parameters to amd76x_pm.  Furthermore, they may be
+queried or changed via their sysfs entries in
+/sys/module/amd76x_pm/parameters.  (The file location in sysfs has
+changed from earlier versions!)
+
+Setting watch_int to zero or removing all interrupts from watch_irqs
+causes the irq rate watcher to stop.  The module needs to be reloaded to
+start the watcher again.
+
+NB: In the past there was a major impact from amd76x_pm on the system
+clock stability.  At least on my box this effect has been reduced
+noticable.  This is caused by two changes:
+
+- The redesign of the idle function lead to a reduced time spent in
+  amd76x_smp_idle() and this propably caused lower latencies.
+  
+- The introduction of the irq rate watcher significantly reduced
+  latencies under load.
+
+Some hints on tuning lazy_idle and spin_idle:
+Watch the rate of C2 calls per second.  Anything below HZ seems to be
+completely useless.  Start with a moderate low value for lazy_idle, e.g.
+2^5 and a very high value for spin_idle, e.g. 2^20.  Then double lazy_idle
+until you see a significant increase in core temperature or C2 rate. 
+Go back to the last "good" value.  Then halve spin_idle until you see
+a decrease in C2 rate or a raising core temperature again and go back
+to the previous value.  There's a small program c2rate.c attached at the
+end of this file that you may use to watch the C2 rate.  The rtc driver
+must be enabled to use it.
+
+There is an -extra patch available that adds some optional features:
+- C3 idling: this works but is not well tested.
+- normal throttling: untested for a long time.
+- Power On Suspend: very experimental and untested.
+
+This software is licensed under GNU General Public License Version 2 
+as specified in file COPYING in the Linux kernel source tree main 
+directory.
+
+Copyright (C) 2002 - 2005	Johnathan Hicks <thetech@folkwolf.net>
+				Tony Lindgren <tony@atomide.com>
+				Joerg Sommrey <jo@sommrey.de>
+
+History:
+
+  20020702 - amd-smp-idle: Tony Lindgren <tony@atomide.com>
+Influenced by Vcool, and LVCool. Rewrote everything from scratch to
+use the PCI features in Linux, and to support SMP systems. Provides
+C2 idling on SMP AMD-760MP systems.
+
+  20020722: JH
+  	I adapted Tony's code for the AMD-765/766 southbridge and adapted it
+  	according to the AMD-768 data sheet to provide the same capability for
+  	SMP AMD-760MPX systems. Posted to acpi-devel list.
+  	
+  20020722: Alan Cox
+  	Replaces non-functional amd76x_pm code in -ac tree.
+  	
+  20020730: JH
+  	Added ability to do normal throttling (the non-thermal kind), C3 idling
+  	and Power On Suspend (S1 sleep). It would be very easy to tie swsusp
+  	into activate_amd76x_SLP(). C3 idling doesn't happen yet; see my note
+  	in amd76x_smp_idle(). I've noticed that when NTH and idling are both
+  	enabled, my hardware locks and requires a hard reset, so I have
+  	#ifndefed around the idle loop setting to prevent this. POS locks it up
+  	too, both ought to be fixable. I've also noticed that idling and NTH
+  	make some interference that is picked up by the onboard sound chip on
+  	my ASUS A7M266-D motherboard.
+
+  20030601: Pasi Savolainen
+     Simple port to 2.5
+     Added sysfs interface for making nice graphs with mrtg.
+     Look for /sys/devices/pci0/00:00.0/C2_cnt & lazy_idle (latter writable)
+
+  20050601: Joerg Sommrey (jo)
+     2.6 stuff
+     redesigned amd76x_smp_idle.  The algorithm is basically the same
+        but the implementation has changed.  This part is now independent
+        from the number of CPUs and data is locked against concurrent
+        updates from different CPUs.
+     use _smp_processor_id()
+     use cpu_idle_wait()
+     NTH and POS code not touched and not tested.
+
+  20050621: jo
+     separated C3, NTH and POS code into extra patch
+
+  20050812: jo
+     rewritten amd76x_smp_idle completely. It's much simpler now but
+     does a good job - the KISS approach.  Introduced a new tunable
+     spin_idle.
+
+  20050819: jo
+     new irq rate watcher task that forces C1-idling if irq-rate exceeds a
+     given limit.
+
+  20050820: jo
+     make all modules parameters r/w in sysfs.
+
+  20050906: jo
+     avoid some local_irq_disable/enable
+  
+TODO: Thermal throttling (TTH).
+	 /proc interface for normal throttling level.
+	 /proc interface for POS.
+
+---- c2rate.c ---- snip here ----------------------------------------
+/* c2rate.c
+ * usage: c2rate [interval]
+ * interval is the time in seconds between two calculations and defaults
+ * to 16
+ * You may #define C3 if you're playing with C3 mode.
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <linux/rtc.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+
+#define C2_CNT "/sys/devices/pci0000:00/0000:00:00.0/C2_cnt"
+#define C3_CNT "/sys/devices/pci0000:00/0000:00:00.0/C3_cnt"
+// #define C3
+int fd;
+
+void
+disable_rtc(void) {
+	int retval;
+	/* Disable alarm interrupts */
+	retval = ioctl(fd, RTC_UIE_OFF, 0);
+	if (retval == -1) {
+		perror("ioctl(RTC_UIE_OFF)");
+		_exit(errno);
+	}
+	close(fd);
+}
+
+int
+main(int argc, char **argv)
+{
+	int retval;
+	unsigned long data;
+	char idlebuffer[64];
+	int idlefd;
+	ssize_t bytes;
+	unsigned long  lastcount;
+	unsigned long  irqcount;
+	unsigned long c2_old, c2_new;
+#ifdef C3
+	unsigned long c3_old, c3_new;
+#endif
+	int rate = 0;
+	int firstloop = 1;
+
+	if(argc > 1)
+		rate = atoi(argv[1]);
+	if (rate <= 0)
+		rate = 16;
+
+	fd = open ("/dev/rtc", O_RDONLY);
+
+	if (fd ==  -1) {
+		perror("/dev/rtc");
+		exit(errno);
+	}
+
+	/* Set the alarm to every second */
+
+	retval = ioctl(fd, RTC_UIE_ON, 0);
+	if (retval == -1) {
+		perror("ioctl(RTC_UIE_ON)");
+		exit(errno);
+	}
+	atexit(disable_rtc);
+
+	irqcount = 0;
+	while (1) {
+		/* This blocks until the alarm ring causes an interrupt */
+		retval = read(fd, &data, sizeof data);
+		if (retval == -1) {
+			perror("read");
+			exit(errno);
+		}
+		if (firstloop) {
+			idlebuffer[0] = '\0';
+			idlefd = open(C2_CNT, O_RDONLY);
+			if (idlefd != -1) {
+				bytes = read(idlefd, idlebuffer, sizeof idlebuffer);
+				close(idlefd);
+				idlebuffer[bytes] = '\0';
+			}
+			c2_old = strtoul(idlebuffer, NULL, 10);
+#ifdef C3
+			idlebuffer[0] = '\0';
+			idlefd = open(C3_CNT, O_RDONLY);
+			if (idlefd != -1) {
+				bytes = read(idlefd, idlebuffer, sizeof idlebuffer);
+				close(idlefd);
+				idlebuffer[bytes] = '\0';
+			}
+			c3_old = strtoul(idlebuffer, NULL, 10);
+#endif
+			firstloop = 0;
+			continue;
+		}
+		lastcount = data >> 8;
+		irqcount += lastcount;
+
+		if (irqcount >= rate) {
+			idlebuffer[0] = '\0';
+			idlefd = open(C2_CNT, O_RDONLY);
+			if (idlefd != -1) {
+				bytes = read(idlefd, idlebuffer, sizeof idlebuffer);
+				close(idlefd);
+				idlebuffer[bytes] = '\0';
+			}
+			c2_new = strtoul(idlebuffer, NULL, 10);
+#ifdef C3
+			idlebuffer[0] = '\0';
+			idlefd = open(C3_CNT, O_RDONLY);
+			if (idlefd != -1) {
+				bytes = read(idlefd, idlebuffer, sizeof idlebuffer);
+				close(idlefd);
+				idlebuffer[bytes] = '\0';
+			}
+			c3_new = strtoul(idlebuffer, NULL, 10);
+			printf("%lu\t%lu\n", (c2_new - c2_old) / irqcount,
+					(c3_new - c3_old) / irqcount);
+			c3_old = c3_new;
+#else
+			printf("%lu\n", (c2_new - c2_old) / irqcount);
+#endif
+			c2_old = c2_new;
+			irqcount = 0;
+		}
+
+	}
+	
+	return 0;
+
+} /* end main */
+---- c2rate.c ---- snip here ----------------------------------------
diff -Nru linux-2.6.14/drivers/acpi/Kconfig linux-2.6.14-jo/drivers/acpi/Kconfig
--- linux-2.6.14/drivers/acpi/Kconfig	2005-10-28 23:51:12.000000000 +0200
+++ linux-2.6.14-jo/drivers/acpi/Kconfig	2005-11-04 20:35:58.000000000 +0100
@@ -341,4 +341,18 @@
 		$>modprobe acpi_memhotplug 
 endif	# ACPI
 
+config AMD76X_PM
+        tristate "AMD76x Native Power Management support"
+        default n
+        depends on X86 && PCI
+        ---help---
+          This driver enables Power Management on AMD760MP & AMD760MPX chipsets.          This is about same as ACPI C2, except that ACPI folks don't do SMP ATM.
+          See Documentation/amd76x_pm.txt for further details.
+
+          To compile this driver as a module ( = code which can be inserted in
+          and removed from the running kernel whenever you want), say M
+          here.  The module will be called amd76x_pm.
+
+          If unsure, say N.
+
 endmenu
diff -Nru linux-2.6.14/drivers/acpi/Kconfig.orig linux-2.6.14-jo/drivers/acpi/Kconfig.orig
--- linux-2.6.14/drivers/acpi/Kconfig.orig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-jo/drivers/acpi/Kconfig.orig	2005-10-28 23:51:12.000000000 +0200
@@ -0,0 +1,344 @@
+#
+# ACPI Configuration
+#
+
+menu "ACPI (Advanced Configuration and Power Interface) Support"
+	depends on !X86_VISWS
+	depends on !IA64_HP_SIM
+	depends on IA64 || X86
+
+config ACPI
+	bool "ACPI Support"
+	depends on IA64 || X86
+	select PM
+	select PCI
+
+	default y
+	---help---
+	  Advanced Configuration and Power Interface (ACPI) support for 
+	  Linux requires an ACPI compliant platform (hardware/firmware),
+	  and assumes the presence of OS-directed configuration and power
+	  management (OSPM) software.  This option will enlarge your 
+	  kernel by about 70K.
+
+	  Linux ACPI provides a robust functional replacement for several 
+	  legacy configuration and power management interfaces, including
+	  the Plug-and-Play BIOS specification (PnP BIOS), the 
+	  MultiProcessor Specification (MPS), and the Advanced Power 
+	  Management (APM) specification.  If both ACPI and APM support 
+	  are configured, whichever is loaded first shall be used.
+
+	  The ACPI SourceForge project contains the latest source code, 
+	  documentation, tools, mailing list subscription, and other 
+	  information.  This project is available at:
+	  <http://sourceforge.net/projects/acpi>
+
+	  Linux support for ACPI is based on Intel Corporation's ACPI
+	  Component Architecture (ACPI CA).  For more information see:
+	  <http://developer.intel.com/technology/iapc/acpi>
+
+	  ACPI is an open industry specification co-developed by Compaq, 
+	  Intel, Microsoft, Phoenix, and Toshiba.  The specification is 
+	  available at:
+	  <http://www.acpi.info>
+
+if ACPI
+
+config ACPI_SLEEP
+	bool "Sleep States"
+	depends on X86 && (!SMP || SUSPEND_SMP)
+	depends on PM
+	default y
+	---help---
+	  This option adds support for ACPI suspend states. 
+
+	  With this option, you will be able to put the system "to sleep". 
+	  Sleep states are low power states for the system and devices. All
+	  of the system operating state is saved to either memory or disk
+	  (depending on the state), to allow the system to resume operation
+	  quickly at your request.
+
+	  Although this option sounds really nifty, barely any of the device
+	  drivers have been converted to the new driver model and hence few
+	  have proper power management support. 
+
+	  This option is not recommended for anyone except those doing driver
+	  power management development.
+
+config ACPI_SLEEP_PROC_FS
+	bool
+	depends on ACPI_SLEEP && PROC_FS
+	default y
+
+config ACPI_SLEEP_PROC_SLEEP
+	bool "/proc/acpi/sleep (deprecated)"
+	depends on ACPI_SLEEP_PROC_FS
+	default n
+	---help---
+	  Create /proc/acpi/sleep
+	  Deprecated by /sys/power/state
+
+config ACPI_AC
+	tristate "AC Adapter"
+	depends on X86
+	default y
+	help
+	  This driver adds support for the AC Adapter object, which indicates
+	  whether a system is on AC, or not. If you have a system that can
+	  switch between A/C and battery, say Y.
+
+config ACPI_BATTERY
+	tristate "Battery"
+	depends on X86
+	default y
+	help
+	  This driver adds support for battery information through
+	  /proc/acpi/battery. If you have a mobile system with a battery, 
+	  say Y.
+
+config ACPI_BUTTON
+	tristate "Button"
+	default y
+	help
+	  This driver handles events on the power, sleep and lid buttons.
+	  A daemon reads /proc/acpi/event and perform user-defined actions
+	  such as shutting down the system.  This is necessary for
+	  software controlled poweroff.
+
+config ACPI_VIDEO
+	tristate "Video"
+	depends on X86
+	default y
+	help
+	  This driver implement the ACPI Extensions For Display Adapters
+	  for integrated graphics devices on motherboard, as specified in
+	  ACPI 2.0 Specification, Appendix B, allowing to perform some basic
+	  control like defining the video POST device, retrieving EDID information
+	  or to setup a video output, etc.
+	  Note that this is an ref. implementation only.  It may or may not work
+	  for your integrated video device.
+
+config ACPI_HOTKEY
+	tristate "Generic Hotkey (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on X86
+	default n
+	help
+	  Experimental consolidated hotkey driver.
+	  If you are unsure, say N.
+
+config ACPI_FAN
+	tristate "Fan"
+	default y
+	help
+	  This driver adds support for ACPI fan devices, allowing user-mode 
+	  applications to perform basic fan control (on, off, status).
+
+config ACPI_PROCESSOR
+	tristate "Processor"
+	default y
+	help
+	  This driver installs ACPI as the idle handler for Linux, and uses
+	  ACPI C2 and C3 processor states to save power, on systems that
+	  support it.  It is required by several flavors of cpufreq
+	  Performance-state drivers.
+
+config ACPI_HOTPLUG_CPU
+	bool
+	depends on ACPI_PROCESSOR && HOTPLUG_CPU
+	select ACPI_CONTAINER
+	default y
+
+config ACPI_THERMAL
+	tristate "Thermal Zone"
+	depends on ACPI_PROCESSOR
+	default y
+	help
+	  This driver adds support for ACPI thermal zones.  Most mobile and
+	  some desktop systems support ACPI thermal zones.  It is HIGHLY
+	  recommended that this option be enabled, as your processor(s)
+	  may be damaged without it.
+
+config ACPI_NUMA
+	bool "NUMA support"
+	depends on NUMA
+	depends on (IA64 || X86_64)
+	default y if IA64_GENERIC || IA64_SGI_SN2
+
+config ACPI_ASUS
+        tristate "ASUS/Medion Laptop Extras"
+	depends on X86
+	default y
+        ---help---
+          This driver provides support for extra features of ACPI-compatible
+          ASUS laptops. As some of Medion laptops are made by ASUS, it may also
+          support some Medion laptops (such as 9675 for example).  It makes all
+          the extra buttons generate standard ACPI events that go through
+          /proc/acpi/events, and (on some models) adds support for changing the
+          display brightness and output, switching the LCD backlight on and off,
+          and most importantly, allows you to blink those fancy LEDs intended
+          for reporting mail and wireless status.
+
+	  Note: display switching code is currently considered EXPERIMENTAL,
+	  toying with these values may even lock your machine.
+          
+          All settings are changed via /proc/acpi/asus directory entries. Owner
+          and group for these entries can be set with asus_uid and asus_gid
+          parameters.
+          
+          More information and a userspace daemon for handling the extra buttons
+          at <http://sourceforge.net/projects/acpi4asus/>.
+          
+          If you have an ACPI-compatible ASUS laptop, say Y or M here. This
+          driver is still under development, so if your laptop is unsupported or
+          something works not quite as expected, please use the mailing list
+          available on the above page (acpi4asus-user@lists.sourceforge.net)
+          
+config ACPI_IBM
+	tristate "IBM ThinkPad Laptop Extras"
+	depends on X86
+	default y
+	---help---
+	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
+	  support for Fn-Fx key combinations, Bluetooth control, video
+	  output switching, ThinkLight control, UltraBay eject and more.
+	  For more information about this driver see <file:Documentation/ibm-acpi.txt>
+	  and <http://ibm-acpi.sf.net/> .
+
+	  If you have an IBM ThinkPad laptop, say Y or M here.
+
+config ACPI_TOSHIBA
+	tristate "Toshiba Laptop Extras"
+	depends on X86
+	default y
+	---help---
+	  This driver adds support for access to certain system settings
+	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
+	  their lack of a BIOS setup menu and APM support.
+
+	  On these machines, all system configuration is handled through the
+	  ACPI.  This driver is required for access to controls not covered
+	  by the general ACPI drivers, such as LCD brightness, video output,
+	  etc.
+
+	  This driver differs from the non-ACPI Toshiba laptop driver (located
+	  under "Processor type and features") in several aspects.
+	  Configuration is accessed by reading and writing text files in the
+	  /proc tree instead of by program interface to /dev.  Furthermore, no
+	  power management functions are exposed, as those are handled by the
+	  general ACPI drivers.
+
+	  More information about this driver is available at
+	  <http://memebeam.org/toys/ToshibaAcpiDriver>.
+
+	  If you have a legacy free Toshiba laptop (such as the Libretto L1
+	  series), say Y.
+
+config ACPI_CUSTOM_DSDT
+	bool "Include Custom DSDT"
+	depends on !STANDALONE
+	default n 
+	help
+	  Thist option is to load a custom ACPI DSDT
+	  If you don't know what that is, say N.
+
+config ACPI_CUSTOM_DSDT_FILE
+	string "Custom DSDT Table file to include"
+	depends on ACPI_CUSTOM_DSDT
+	default ""
+	help
+	  Enter the full path name to the file wich includes the AmlCode declaration.
+
+config ACPI_BLACKLIST_YEAR
+	int "Disable ACPI for systems before Jan 1st this year" if X86
+	default 0
+	help
+	  enter a 4-digit year, eg. 2001 to disable ACPI by default
+	  on platforms with DMI BIOS date before January 1st that year.
+	  "acpi=force" can be used to override this mechanism.
+
+	  Enter 0 to disable this mechanism and allow ACPI to
+	  run by default no matter what the year.  (default)
+
+config ACPI_DEBUG
+	bool "Debug Statements"
+	default n
+	help
+	  The ACPI driver can optionally report errors with a great deal
+	  of verbosity. Saying Y enables these statements. This will increase
+	  your kernel size by around 50K.
+
+config ACPI_EC
+	bool
+	depends on X86
+	default y
+	help
+	  This driver is required on some systems for the proper operation of
+	  the battery and thermal drivers.  If you are compiling for a 
+	  mobile system, say Y.
+
+config ACPI_POWER
+	bool
+	default y
+
+config ACPI_SYSTEM
+	bool
+	default y
+	help
+	  This driver will enable your system to shut down using ACPI, and
+	  dump your ACPI DSDT table using /proc/acpi/dsdt.
+
+config X86_PM_TIMER
+	bool "Power Management Timer Support"
+	depends on X86
+	depends on !X86_64
+	default y
+	help
+	  The Power Management Timer is available on all ACPI-capable,
+	  in most cases even if ACPI is unusable or blacklisted.
+
+	  This timing source is not affected by powermanagement features
+	  like aggressive processor idling, throttling, frequency and/or
+	  voltage scaling, unlike the commonly used Time Stamp Counter
+	  (TSC) timing source.
+
+	  So, if you see messages like 'Losing too many ticks!' in the
+	  kernel logs, and/or you are using this on a notebook which
+	  does not yet have an HPET, you should say "Y" here.
+
+config ACPI_CONTAINER
+	tristate "ACPI0004,PNP0A05 and PNP0A06 Container Driver (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU || ACPI_HOTPLUG_IO)
+	 ---help---
+	  This allows _physical_ insertion and removal of CPUs and memory.
+	  This can be useful, for example, on NUMA machines that support
+	  ACPI based physical hotplug of nodes, or non-NUMA machines that
+	  support physical cpu/memory hot-plug.
+
+	  If one selects "m", this driver can be loaded with
+	  "modprobe acpi_container".
+
+config ACPI_HOTPLUG_MEMORY
+	tristate "Memory Hotplug"
+	depends on ACPI
+	depends on MEMORY_HOTPLUG
+	default n
+	help
+	  This driver adds supports for ACPI Memory Hotplug.  This driver
+	  provides support for fielding notifications on ACPI memory
+	  devices (PNP0C80) which represent memory ranges that may be
+	  onlined or offlined during runtime.  
+
+	  Enabling this driver assumes that your platform hardware
+	  and firmware have support for hot-plugging physical memory. If
+	  your system does not support physically adding or ripping out 
+	  memory DIMMs at some platfrom defined granularity (individually 
+	  or as a bank) at runtime, then you need not enable this driver.
+
+	  If one selects "m," this driver can be loaded using the following
+	  command: 
+		$>modprobe acpi_memhotplug 
+endif	# ACPI
+
+endmenu
diff -Nru linux-2.6.14/drivers/acpi/Makefile linux-2.6.14-jo/drivers/acpi/Makefile
--- linux-2.6.14/drivers/acpi/Makefile	2005-10-28 23:51:12.000000000 +0200
+++ linux-2.6.14-jo/drivers/acpi/Makefile	2005-11-04 20:35:58.000000000 +0100
@@ -57,3 +57,8 @@
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-y				+= scan.o motherboard.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
+
+#
+# not really ACPI thing, until they handle SMP.
+#
+obj-$(CONFIG_AMD76X_PM)               += amd76x_pm.o
diff -Nru linux-2.6.14/drivers/acpi/Makefile.orig linux-2.6.14-jo/drivers/acpi/Makefile.orig
--- linux-2.6.14/drivers/acpi/Makefile.orig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-jo/drivers/acpi/Makefile.orig	2005-10-28 23:51:12.000000000 +0200
@@ -0,0 +1,59 @@
+#
+# Makefile for the Linux ACPI interpreter
+# 
+
+export ACPI_CFLAGS
+
+ACPI_CFLAGS	:= -Os
+
+ifdef CONFIG_ACPI_DEBUG
+  ACPI_CFLAGS	+= -DACPI_DEBUG_OUTPUT
+endif
+
+EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
+
+#
+# ACPI Boot-Time Table Parsing
+#
+obj-y				+= tables.o
+obj-y				+= blacklist.o
+
+#
+# ACPI Core Subsystem (Interpreter)
+#
+obj-y				+= osl.o utils.o \
+				   dispatcher/ events/ executer/ hardware/ \
+				   namespace/ parser/ resources/ tables/ \
+				   utilities/
+
+#
+# ACPI Bus and Device Drivers
+#
+processor-objs	+= processor_core.o processor_throttling.o \
+				processor_idle.o processor_thermal.o
+ifdef CONFIG_CPU_FREQ
+processor-objs	+= processor_perflib.o			
+endif
+
+obj-y				+= sleep/
+obj-y				+= bus.o glue.o
+obj-$(CONFIG_ACPI_AC) 		+= ac.o
+obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
+obj-$(CONFIG_ACPI_BUTTON)	+= button.o
+obj-$(CONFIG_ACPI_EC)		+= ec.o
+obj-$(CONFIG_ACPI_FAN)		+= fan.o
+obj-$(CONFIG_ACPI_VIDEO)	+= video.o 
+obj-$(CONFIG_ACPI_HOTKEY)	+= hotkey.o
+obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
+obj-$(CONFIG_ACPI_POWER)	+= power.o
+obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
+obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
+obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
+obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
+obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
+obj-$(CONFIG_ACPI_NUMA)		+= numa.o
+obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
+obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
+obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
+obj-y				+= scan.o motherboard.o
+obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
diff -Nru linux-2.6.14/drivers/acpi/amd76x_pm.c linux-2.6.14-jo/drivers/acpi/amd76x_pm.c
--- linux-2.6.14/drivers/acpi/amd76x_pm.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-jo/drivers/acpi/amd76x_pm.c	2005-11-04 20:36:19.000000000 +0100
@@ -0,0 +1,647 @@
+/*
+ * ACPI style PM for SMP AMD-760MP(X) based systems.
+ * For use until the ACPI project catches up. :-)
+ *
+ * Copyright (C) 2002 - 2005	Johnathan Hicks <thetech@folkwolf.net>
+ * 				Tony Lindgren <tony@atomide.com>
+ * 				Joerg Sommrey <jo@sommrey.de>
+ *
+ *    <Notes from 20020722-ac revision>
+ *
+ * Processor idle mode module for AMD SMP 760MP(X) based systems
+ *
+ * Copyright (C) 2002 Tony Lindgren <tony@atomide.com>
+ *                    Johnathan Hicks (768 support)
+ *
+ * Using this module saves about 70 - 90W of energy in the idle mode compared
+ * to the default idle mode. Waking up from the idle mode is fast to keep the
+ * system response time good. Currently no CPU load calculation is done, the
+ * system exits the idle mode if the idle function runs twice on the same
+ * processor in a row. This only works on SMP systems, but maybe the idle mode
+ * enabling can be integrated to ACPI to provide C2 mode at some point.
+ *
+ * NOTE: Currently there's a bug somewhere where the reading the
+ *       P_LVL2 for the first time causes the system to sleep instead of 
+ *       idling. This means that you need to hit the power button once to
+ *       wake the system after loading the module for the first time after
+ *       reboot. After that the system idles as supposed.
+ *
+ *
+ * Influenced by Vcool, and LVCool. Rewrote everything from scratch to
+ * use the PCI features in Linux, and to support SMP systems.
+ * 
+ * Currently only tested on a TYAN S2460 (760MP) system (Tony) and an
+ * ASUS A7M266-D (760MPX) system (Johnathan). Adding support for other Athlon
+ * SMP or single processor systems should be easy if desired.
+ *
+ * This software is licensed under GNU General Public License Version 2 
+ * as specified in file COPYING in the Linux kernel source tree main 
+ * directory.
+ * 
+ *   </Notes from 20020722-ac revision>
+ */
+
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/version.h>
+#include <asm/atomic.h>
+#include <linux/kernel.h>
+#include <linux/workqueue.h>
+#include <linux/jiffies.h>
+#include <linux/kernel_stat.h>
+
+#include <linux/amd76x_pm.h>
+
+#define VERSION	"20050906"
+
+// #define AMD76X_LOG_C1 1
+
+extern void default_idle(void);
+static void amd76x_smp_idle(void);
+static int amd76x_pm_main(void);
+
+static unsigned long lazy_idle = 0;
+static unsigned long spin_idle = 0;
+static unsigned long watch_int = 0;
+static unsigned long min_C1 = AMD76X_MIN_C1;
+
+static int show_watch_irqs(char *, struct kernel_param *);
+static int set_watch_irqs(const char *, struct kernel_param *);
+
+module_param(lazy_idle, long, S_IRUGO | S_IWUSR);
+
+MODULE_PARM_DESC(lazy_idle,
+		"\tnumber of idle cycles before entering power saving mode");
+
+module_param(spin_idle, long, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(spin_idle,
+		"\tnumber of spin cycles to wait for other CPUs to become idle");
+
+module_param(watch_int, long, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(watch_int,
+		"\twatch interval (in milliseconds) for interrupts");
+
+module_param_call(watch_irqs, set_watch_irqs, show_watch_irqs,
+	NULL, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(watch_irqs,
+		"\tlist of irqs (and optional their limit per second) that "
+		"cause fallback to C1 mode. "
+		"Syntax: irq0[:limit0],irq1[:limit1],...");
+
+module_param(min_C1, long, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(min_C1,
+		"\tminimum irq rate watch intervals spent in C1 mode");
+
+MODULE_AUTHOR("Tony Lindgren, Johnathan Hicks, Joerg Sommrey, others");
+MODULE_DESCRIPTION("ACPI style power management for SMP AMD-760MP(X) "
+		"based systems, version " VERSION);
+
+
+static struct pci_dev *pdev_nb;
+static struct pci_dev *pdev_sb;
+
+struct PM_cfg {
+	unsigned int status_reg;
+	unsigned int C2_reg;
+	unsigned int slp_reg;
+	unsigned int resume_reg;
+	void (*orig_idle) (void);
+	void (*curr_idle) (void);
+};
+
+static struct PM_cfg amd76x_pm_cfg __cacheline_aligned_in_smp;
+
+struct idle_stat {
+	atomic_t num_idle;
+};
+
+static struct idle_stat amd76x_stat __cacheline_aligned_in_smp = {
+	.num_idle = ATOMIC_INIT(0),
+};
+
+struct cpu_stat {
+	int idle_count;
+	int C2_cnt;
+	int _fill[2];
+};
+
+static struct cpu_stat prs[NR_CPUS] __cacheline_aligned_in_smp;
+
+struct watch_item {
+	int irq;
+	int count;
+	int limit;
+	int _fill;
+};
+
+static struct irqwatch {
+	int force_C1;
+	int schedule;
+	int _fill[2];
+	struct watch_item item[AMD76X_WATCH_MAX];
+} irqwatch __cacheline_aligned_in_smp = {
+	.force_C1 = 0,
+	.schedule = 0,
+	.item = {{-1, 0}}
+};
+
+static struct work_struct work;
+static void watch_irq(void *);
+
+static DECLARE_WORK(work, watch_irq, NULL);
+
+static struct pci_device_id  __devinitdata amd_nb_tbl[] = {
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FE_GATE_700C, PCI_ANY_ID,
+		PCI_ANY_ID,},
+	{0,}
+};
+
+static struct pci_device_id  __devinitdata amd_sb_tbl[] = {
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413, PCI_ANY_ID,
+		PCI_ANY_ID,},
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7443, PCI_ANY_ID,
+		PCI_ANY_ID,},
+	{0,}
+};
+
+/*
+ * Configures the AMD-762 northbridge to support PM calls
+ */
+static int
+config_amd762(int enable)
+{
+	unsigned int regdword;
+
+	/* Enable STPGNT in BIU Status/Control for cpu0 */
+	pci_read_config_dword(pdev_nb, 0x60, &regdword);
+	regdword |= (1 << 17);
+	pci_write_config_dword(pdev_nb, 0x60, regdword);
+
+	/* Enable STPGNT in BIU Status/Control for cpu1 */
+	pci_read_config_dword(pdev_nb, 0x68, &regdword);
+	regdword |= (1 << 17);
+	pci_write_config_dword(pdev_nb, 0x68, regdword);
+
+	/* DRAM refresh enable */
+	pci_read_config_dword(pdev_nb, 0x58, &regdword);
+	regdword &= ~(1 << 19);
+	pci_write_config_dword(pdev_nb, 0x58, regdword);
+
+	/* Self refresh enable */
+	pci_read_config_dword(pdev_nb, 0x70, &regdword);
+	regdword |= (1 << 18);
+	pci_write_config_dword(pdev_nb, 0x70, regdword);
+
+	return 0;
+}
+
+
+/*
+ * Get the base PMIO address and set the pm registers in amd76x_pm_cfg.
+ */
+static void
+amd76x_get_PM(void)
+{
+	unsigned int regdword;
+
+	/* Get the address for pm status, P_LVL2, etc */
+	pci_read_config_dword(pdev_sb, 0x58, &regdword);
+	regdword &= 0xff80;
+	amd76x_pm_cfg.status_reg = (regdword + 0x00);
+	amd76x_pm_cfg.slp_reg =    (regdword + 0x04);
+	amd76x_pm_cfg.C2_reg =     (regdword + 0x14);
+	amd76x_pm_cfg.resume_reg = (regdword + 0x16); /* N/A for 768 */
+}
+
+
+/*
+ * En/Disable PMIO and configure W4SG & STPGNT.
+ */
+static int
+config_PMIO_amd76x(int is_766, int enable)
+{
+	unsigned char regbyte;
+
+	/* Clear W4SG, and set PMIOEN, if using a 765/766 set STPGNT as well.
+	 * AMD-766: C3A41; page 59 in AMD-766 doc
+	 * AMD-768: DevB:3x41C; page 94 in AMD-768 doc */
+	pci_read_config_byte(pdev_sb, 0x41, &regbyte);
+	if(enable) {
+		regbyte |= ((is_766 << 1) | (1 << 7));
+	}
+	pci_write_config_byte(pdev_sb, 0x41, regbyte);
+	return 0;
+}
+
+/*
+ * C2 idle support for AMD-766.
+ */
+static void
+config_amd766_C2(int enable)
+{
+	unsigned int regdword;
+
+	/* Set C2 options in C3A50, page 63 in AMD-766 doc */
+	pci_read_config_dword(pdev_sb, 0x50, &regdword);
+	if(enable) {
+		regdword &= ~((DCSTOP_EN | CPUSTP_EN | PCISTP_EN | SUSPND_EN |
+					CPURST_EN) << C2_REGS);
+		regdword |= (STPCLK_EN	/* ~ 20 Watt savings max */
+			 |  CPUSLP_EN)	/* Additional ~ 70 Watts max! */
+			 << C2_REGS;
+	}
+	else
+		regdword &= ~((STPCLK_EN | CPUSLP_EN) << C2_REGS);
+	pci_write_config_dword(pdev_sb, 0x50, regdword);
+}
+
+/*
+ * Configures the 765 & 766 southbridges.
+ */
+static int
+config_amd766(int enable)
+{
+	amd76x_get_PM();
+	config_PMIO_amd76x(1, 1);
+	config_amd766_C2(enable);
+
+	return 0;
+}
+
+
+/*
+ * C2 idling support for AMD-768.
+ */
+static void
+config_amd768_C2(int enable)
+{
+	unsigned char regbyte;
+
+	/* Set C2 options in DevB:3x4F, page 100 in AMD-768 doc */
+	pci_read_config_byte(pdev_sb, 0x4F, &regbyte);
+	if(enable)
+		regbyte |= C2EN;
+	else
+		regbyte ^= C2EN;
+	pci_write_config_byte(pdev_sb, 0x4F, regbyte);
+}
+
+/*
+ * Configures the 768 southbridge to support idle calls, and gets
+ * the processor idle call register location.
+ */
+static int
+config_amd768(int enable)
+{
+	amd76x_get_PM();
+
+	config_PMIO_amd76x(0, 1);
+
+	config_amd768_C2(enable);
+
+	return 0;
+}
+
+/*
+ * Idle loop for single processor systems
+ */
+void
+amd76x_up_idle(void)
+{
+	/* ACPI knows how to do C2 on SMP when cpu_count < 2
+	 * we really shouldn't end up here anyway. 
+	 */
+	amd76x_pm_cfg.orig_idle();
+}
+
+/*
+ * Idle loop for SMP systems
+ *
+ * Locking is done using atomic_t variables, no spin locks needed.
+ *
+ */
+static void
+amd76x_smp_idle(void)
+{
+	int cpu;
+	int i;
+	int num_online;
+
+	cpu = raw_smp_processor_id();
+	if (unlikely(irqwatch.force_C1)) {
+		local_irq_disable();
+		prs[cpu].idle_count = 0;
+		safe_halt();
+		return;
+	}
+
+	/* Spin inside (outer) idle loop until lazy_idle cycles
+	 * are reached.
+	 */
+	if (likely(++prs[cpu].idle_count <= lazy_idle)) {
+		return;
+	}
+
+	local_irq_disable();
+
+	/* Now we are ready do go C2. */
+	atomic_inc(&amd76x_stat.num_idle);
+	num_online = num_online_cpus();
+
+	/* Spin inside inner loop until either
+	 * - spin_idle cycles are reached
+	 * - there is work
+	 * - all CPUs are idle
+	 */
+	for (i = 0; i < spin_idle; i++) {
+		if (unlikely(need_resched()))
+			break;
+
+		smp_mb();
+		if (unlikely(atomic_read(&amd76x_stat.num_idle) ==
+					num_online)) {
+			/* Invoke C2 */
+			prs[cpu].C2_cnt++;
+			inb(amd76x_pm_cfg.C2_reg);
+			smp_mb();
+			atomic_dec(&amd76x_stat.num_idle);
+			prs[cpu].idle_count = 0;
+			local_irq_enable();
+			return;
+		}
+	}
+
+	smp_mb();
+	atomic_dec(&amd76x_stat.num_idle);
+	prs[cpu].idle_count = 0;
+	local_irq_enable();
+}
+
+/*
+ *   sysfs support, RW
+ */
+static int
+show_watch_irqs(char *buf, struct kernel_param *kp)
+{
+	int i;
+	ssize_t ret = 0;
+	for (i = 0; i < AMD76X_WATCH_MAX && irqwatch.item[i].irq != -1 ; i++) {
+		if (i > 0)
+			ret += sprintf(buf + ret, ",");
+		ret += sprintf(buf + ret, "%d:%d",
+			irqwatch.item[i].irq,
+			irqwatch.item[i].limit);
+	}
+	return ret;
+}
+
+static int
+set_watch_irqs(const char *val, struct kernel_param *kp)
+{
+	const char *s;
+	char *e;
+	long irq, limit;
+	int i;
+	
+	for (i = 0, s = val; i < AMD76X_WATCH_MAX && s && *s; i++) {
+		irq = simple_strtol(s, &e, 0);
+		if (e == s)
+			break;
+		if (*e == ':') {
+			s = e + 1;
+			limit = simple_strtol(s, &e, 0);
+		} else
+			limit = AMD76X_WATCH_LIM;
+		if (irq >= 0)
+			irqwatch.item[i].irq = irq;
+		else {
+			irqwatch.item[i].irq = -1;
+			break;
+		}
+		irqwatch.item[i].limit = limit;
+		irqwatch.item[i].count = 0;
+		if (*e == ',')
+			s = e + 1;
+		else
+			s = e;
+	}
+	if (i < AMD76X_WATCH_MAX)
+		irqwatch.item[i].irq = -1;
+	if (irqwatch.item[0].irq != -1) {
+		irqwatch.schedule = 1;
+		printk(KERN_INFO "amd76x_pm: irq rate watcher parms:\n");
+		for (i = 0; i < AMD76X_WATCH_MAX && irqwatch.item[i].irq != -1; i++)
+			printk(KERN_INFO
+			"amd76x_pm: irq %d: limit = %d/s\n",
+				irqwatch.item[i].irq,
+				irqwatch.item[i].limit);
+	} else
+		printk(KERN_INFO "amd76x_pm: irq rate watcher disabled.\n");
+
+	return 0;
+}
+
+static ssize_t 
+show_C2_cnt (struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	unsigned int C2_cnt = 0;
+	int i;
+
+	for_each_online_cpu(i)
+		C2_cnt += prs[i].C2_cnt;
+	return sprintf(buf,"%u\n", C2_cnt);  
+}
+
+static DEVICE_ATTR(C2_cnt, S_IRUGO,
+		   show_C2_cnt, NULL);
+
+static void
+setup_watch(void)
+{
+	if (watch_int <= 0)
+		watch_int = AMD76X_WATCH_INT;
+	if (irqwatch.item[0].irq != -1 && watch_int) {
+		schedule_work(&work);
+		printk(KERN_INFO "amd76x_pm: irq rate watcher started. "
+				"watch_int = %lu ms, min_C1 = %lu\n",
+				watch_int, min_C1);
+	} else
+		printk(KERN_INFO "amd76x_pm: irq rate watcher disabled.\n");
+}
+
+static void
+watch_irq(void *parm)
+{
+	int i;
+	int irq_cnt;
+	int force_C1 = 0;
+
+	for (i = 0; i < AMD76X_WATCH_MAX && irqwatch.item[i].irq != -1; i++) {
+		irq_cnt = kstat_irqs(irqwatch.item[i].irq);
+		if ((irq_cnt - irqwatch.item[i].count) * 1000 >
+				irqwatch.item[i].limit * watch_int) {
+			force_C1 = 1;
+		}
+		irqwatch.item[i].count = irq_cnt;
+	}
+
+#ifdef AMD76X_LOG_C1
+        if (force_C1 && !irqwatch.force_C1)
+                printk(KERN_INFO "amd76x_pm: C1 on\n");
+        if (!force_C1 && irqwatch.force_C1 == 1)
+                printk(KERN_INFO "amd76x_pm: C1 off\n");
+#endif
+
+	if (force_C1)
+		irqwatch.force_C1 = min_C1;
+	else if (irqwatch.force_C1)
+		irqwatch.force_C1--;
+
+	if (irqwatch.schedule && watch_int > 0)
+		schedule_delayed_work(&work,
+			msecs_to_jiffies(watch_int));
+	else
+		printk(KERN_INFO "amd76x_pm: irq rate watcher stopped.\n");
+}
+
+
+/*
+ * Finds and initializes the bridges, and then sets the idle function
+ */
+static int
+amd76x_pm_main(void)
+{
+	int i;
+
+	amd76x_pm_cfg.orig_idle = 0;
+	if(lazy_idle == 0)
+	    lazy_idle = AMD76X_LAZY_IDLE;
+	printk(KERN_INFO "amd76x_pm: lazy_idle = %lu\n", lazy_idle);
+	if(spin_idle == 0)
+		spin_idle = 2 * lazy_idle;
+	printk(KERN_INFO "amd76x_pm: spin_idle = %lu\n", spin_idle);
+
+	/* Find southbridge */
+	pdev_sb = NULL;
+	while((pdev_sb = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_sb)) != NULL) {
+		if(pci_match_id(amd_sb_tbl, pdev_sb) != NULL)
+			goto found_sb;
+	}
+	printk(KERN_ERR "amd76x_pm: Could not find southbridge\n");
+	return -ENODEV;
+
+ found_sb:
+
+	/* Find northbridge */
+	pdev_nb = NULL;
+	while((pdev_nb = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev_nb)) != NULL) {
+		if(pci_match_id(amd_nb_tbl, pdev_nb) != NULL)
+			goto found_nb;
+	}
+	printk(KERN_ERR "amd76x_pm: Could not find northbridge\n");
+	return -ENODEV;
+
+ found_nb:	
+	
+	/* Init southbridge */
+	switch (pdev_sb->device) {
+	case PCI_DEVICE_ID_AMD_VIPER_7413:	/* AMD-765 or 766 */
+		config_amd766(1);
+		break;
+	case PCI_DEVICE_ID_AMD_VIPER_7443:	/* AMD-768 */
+		config_amd768(1);
+		break;
+	default:
+		printk(KERN_ERR "amd76x_pm: No southbridge to initialize\n");		
+		break;
+	}
+
+	/* Init northbridge and queue the new idle function */
+	if(!pdev_nb) {
+		printk("amd76x_pm: No northbridge found.\n");
+		return -ENODEV;
+	}
+	switch (pdev_nb->device) {
+	case PCI_DEVICE_ID_AMD_FE_GATE_700C:	/* AMD-762 */
+		config_amd762(1);
+		amd76x_pm_cfg.curr_idle = amd76x_smp_idle;
+		break;
+	default:
+		printk(KERN_ERR "amd76x_pm: No northbridge to initialize\n");
+		break;
+	}
+
+	if(num_online_cpus() == 1) {
+		amd76x_pm_cfg.curr_idle = amd76x_up_idle;
+		printk(KERN_ERR "amd76x_pm: UP machine detected. ACPI is your friend.\n");
+	}
+	if (!amd76x_pm_cfg.curr_idle) {
+		printk(KERN_ERR "amd76x_pm: Idle function not changed\n");
+		return 1;
+	}
+
+	for (i = 0; i < NR_CPUS; i++) {
+		prs[i].idle_count = 0;
+		prs[i].C2_cnt = 0;
+	}
+
+	amd76x_pm_cfg.orig_idle = pm_idle;
+	pm_idle = amd76x_pm_cfg.curr_idle;
+
+	wmb();
+	
+	/* sysfs */
+	device_create_file(&pdev_nb->dev, &dev_attr_C2_cnt);
+
+	setup_watch();
+
+	return 0;
+}
+
+
+static int __init
+amd76x_pm_init(void)
+{
+	printk(KERN_INFO "amd76x_pm: Version %s loaded.\n", VERSION);
+	return amd76x_pm_main();
+}
+
+
+static void __exit
+amd76x_pm_cleanup(void)
+{
+	int i;
+	unsigned int C2_cnt = 0;
+	
+	pm_idle = amd76x_pm_cfg.orig_idle;
+
+	cpu_idle_wait();
+
+
+	/* This isn't really needed. */
+	for_each_online_cpu(i) {
+		C2_cnt += prs[i].C2_cnt;
+	}
+	printk(KERN_INFO "amd76x_pm: %u C2 calls\n", C2_cnt);
+	
+	/* remove sysfs */
+	device_remove_file(&pdev_nb->dev, &dev_attr_C2_cnt);
+
+	irqwatch.schedule = 0;
+        flush_scheduled_work();
+        cancel_delayed_work(&work);
+        flush_scheduled_work();
+}
+
+
+MODULE_LICENSE("GPL");
+module_init(amd76x_pm_init);
+module_exit(amd76x_pm_cleanup);
diff -Nru linux-2.6.14/include/linux/amd76x_pm.h linux-2.6.14-jo/include/linux/amd76x_pm.h
--- linux-2.6.14/include/linux/amd76x_pm.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-jo/include/linux/amd76x_pm.h	2005-11-04 20:35:58.000000000 +0100
@@ -0,0 +1,63 @@
+/* 
+ * Begin 765/766
+ */
+/* C2/C3/POS options in C3A50, page 63 in AMD-766 doc */
+#define ZZ_CACHE_EN	1
+#define DCSTOP_EN	(1 << 1)
+#define STPCLK_EN	(1 << 2)
+#define CPUSTP_EN	(1 << 3)
+#define PCISTP_EN	(1 << 4)
+#define CPUSLP_EN	(1 << 5)
+#define SUSPND_EN	(1 << 6)
+#define CPURST_EN	(1 << 7)
+
+#define C2_REGS		0
+#define C3_REGS		8
+#define POS_REGS	16	
+/*
+ * End 765/766
+ */
+
+
+/*
+ * Begin 768
+ */
+/* C2/C3 options in DevB:3x4F, page 100 in AMD-768 doc */
+#define C2EN		1
+#define C3EN		(1 << 1)
+#define ZZ_C3EN		(1 << 2)
+#define CSLP_C3EN	(1 << 3)
+#define CSTP_C3EN	(1 << 4)
+
+/* POS options in DevB:3x50, page 101 in AMD-768 doc */
+#define POSEN	1
+#define CSTP	(1 << 2)
+#define PSTP	(1 << 3)
+#define ASTP	(1 << 4)
+#define DCSTP	(1 << 5)
+#define CSLP	(1 << 6)
+#define SUSP	(1 << 8)
+#define MSRSM	(1 << 14)
+#define PITRSM	(1 << 15)
+
+/* NTH options DevB:3x40, pg 93 of 768 doc */
+#define NTPER(x) (x << 3)
+#define THMINEN(x) (x << 4)
+
+/*
+ * End 768
+ */
+
+/* NTH activate. PM10, pg 110 of 768 doc, pg 70 of 766 doc */
+#define NTH_RATIO(x) (x << 1)
+#define NTH_EN (1 << 4)
+
+/* Sleep state. PM04, pg 109 of 768 doc, pg 69 of 766 doc */
+#define SLP_EN (1 << 13)
+#define SLP_TYP(x) (x << 10)
+
+#define AMD76X_LAZY_IDLE 512
+#define AMD76X_WATCH_INT 500
+#define AMD76X_WATCH_LIM 128
+#define AMD76X_WATCH_MAX 8
+#define AMD76X_MIN_C1 2
