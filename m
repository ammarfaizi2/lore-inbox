Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbTIFKxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 06:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTIFKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 06:53:08 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:61606 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265251AbTIFKwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 06:52:30 -0400
Date: Sat, 6 Sep 2003 12:51:36 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test4 - Watchdog patches - Documentation
Message-ID: <20030906125136.A9266@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.5-watchdog

This will update the following files:

 Documentation/pcwd-watchdog.txt          |  132 ----------
 Documentation/watchdog-api.txt           |  390 -------------------------------
 Documentation/watchdog.txt               |  113 --------
 Documentation/watchdog/pcwd-watchdog.txt |  134 ++++++++++
 Documentation/watchdog/watchdog-api.txt  |  390 +++++++++++++++++++++++++++++++
 Documentation/watchdog/watchdog.txt      |  115 +++++++++
 6 files changed, 639 insertions(+), 635 deletions(-)

through these ChangeSets:

<wim@iguana.be> (03/09/06 1.1180)
   [WATCHDOG] Documentation
   
   move all watchdog documentation into Documentation/watchdog/


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.5-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/Documentation/pcwd-watchdog.txt b/Documentation/pcwd-watchdog.txt
--- a/Documentation/pcwd-watchdog.txt	Sat Sep  6 12:47:30 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,134 +0,0 @@
-                     Berkshire Products PC Watchdog Card
-                   Support for ISA Cards  Revision A and C
-           Documentation and Driver by Ken Hollis <kenji@bitgate.com>
-
- The PC Watchdog is a card that offers the same type of functionality that
- the WDT card does, only it doesn't require an IRQ to run.  Furthermore,
- the Revision C card allows you to monitor any IO Port to automatically
- trigger the card into being reset.  This way you can make the card
- monitor hard drive status, or anything else you need.
-
- The Watchdog Driver has one basic role: to talk to the card and send
- signals to it so it doesn't reset your computer ... at least during
- normal operation.
-
- The Watchdog Driver will automatically find your watchdog card, and will
- attach a running driver for use with that card.  After the watchdog
- drivers have initialized, you can then talk to the card using the PC
- Watchdog program, available from http://ftp.bitgate.com/pcwd/.
-
- I suggest putting a "watchdog -d" before the beginning of an fsck, and
- a "watchdog -e -t 1" immediately after the end of an fsck.  (Remember
- to run the program with an "&" to run it in the background!)
-
- If you want to write a program to be compatible with the PC Watchdog
- driver, simply do the following:
-
--- Snippet of code --
-/*
- * Watchdog Driver Test Program
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <linux/pcwd.h>
-
-int fd;
-
-/*
- * This function simply sends an IOCTL to the driver, which in turn ticks
- * the PC Watchdog card to reset its internal timer so it doesn't trigger
- * a computer reset.
- */
-void keep_alive(void)
-{
-    int dummy;
-
-    ioctl(fd, WDIOC_KEEPALIVE, &dummy);
-}
-
-/*
- * The main program.  Run the program with "-d" to disable the card,
- * or "-e" to enable the card.
- */
-int main(int argc, char *argv[])
-{
-    fd = open("/dev/watchdog", O_WRONLY);
-
-    if (fd == -1) {
-	fprintf(stderr, "Watchdog device not enabled.\n");
-	fflush(stderr);
-	exit(-1);
-    }
-
-    if (argc > 1) {
-	if (!strncasecmp(argv[1], "-d", 2)) {
-	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_DISABLECARD);
-	    fprintf(stderr, "Watchdog card disabled.\n");
-	    fflush(stderr);
-	    exit(0);
-	} else if (!strncasecmp(argv[1], "-e", 2)) {
-	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_ENABLECARD);
-	    fprintf(stderr, "Watchdog card enabled.\n");
-	    fflush(stderr);
-	    exit(0);
-	} else {
-	    fprintf(stderr, "-d to disable, -e to enable.\n");
-	    fprintf(stderr, "run by itself to tick the card.\n");
-	    fflush(stderr);
-	    exit(0);
-	}
-    } else {
-	fprintf(stderr, "Watchdog Ticking Away!\n");
-	fflush(stderr);
-    }
-
-    while(1) {
-	keep_alive();
-	sleep(1);
-    }
-}
--- End snippet --
-
- Other IOCTL functions include:
-
-	WDIOC_GETSUPPORT
-		This returns the support of the card itself.  This
-		returns in structure "PCWDS" which returns:
-			options = WDIOS_TEMPPANIC
-				  (This card supports temperature)
-			firmware_version = xxxx
-				  (Firmware version of the card)
-
-	WDIOC_GETSTATUS
-		This returns the status of the card, with the bits of
-		WDIOF_* bitwise-anded into the value.  (The comments
-		are in linux/pcwd.h)
-
-	WDIOC_GETBOOTSTATUS
-		This returns the status of the card that was reported
-		at bootup.
-
-	WDIOC_GETTEMP
-		This returns the temperature of the card.  (You can also
-		read /dev/watchdog, which gives a temperature update
-		every second.)
-
-	WDIOC_SETOPTIONS
-		This lets you set the options of the card.  You can either
-		enable or disable the card this way.
-
-	WDIOC_KEEPALIVE
-		This pings the card to tell it not to reset your computer.
-
- And that's all she wrote!
-
- -- Ken Hollis
-    (kenji@bitgate.com)
-
-(This documentation may be out of date.  Check
- http://ftp.bitgate.com/pcwd/ for the absolute latest additions.)
diff -Nru a/Documentation/watchdog/pcwd-watchdog.txt b/Documentation/watchdog/pcwd-watchdog.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/watchdog/pcwd-watchdog.txt	Sat Sep  6 12:47:30 2003
@@ -0,0 +1,134 @@
+                     Berkshire Products PC Watchdog Card
+                   Support for ISA Cards  Revision A and C
+           Documentation and Driver by Ken Hollis <kenji@bitgate.com>
+
+ The PC Watchdog is a card that offers the same type of functionality that
+ the WDT card does, only it doesn't require an IRQ to run.  Furthermore,
+ the Revision C card allows you to monitor any IO Port to automatically
+ trigger the card into being reset.  This way you can make the card
+ monitor hard drive status, or anything else you need.
+
+ The Watchdog Driver has one basic role: to talk to the card and send
+ signals to it so it doesn't reset your computer ... at least during
+ normal operation.
+
+ The Watchdog Driver will automatically find your watchdog card, and will
+ attach a running driver for use with that card.  After the watchdog
+ drivers have initialized, you can then talk to the card using the PC
+ Watchdog program, available from http://ftp.bitgate.com/pcwd/.
+
+ I suggest putting a "watchdog -d" before the beginning of an fsck, and
+ a "watchdog -e -t 1" immediately after the end of an fsck.  (Remember
+ to run the program with an "&" to run it in the background!)
+
+ If you want to write a program to be compatible with the PC Watchdog
+ driver, simply do the following:
+
+-- Snippet of code --
+/*
+ * Watchdog Driver Test Program
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/pcwd.h>
+
+int fd;
+
+/*
+ * This function simply sends an IOCTL to the driver, which in turn ticks
+ * the PC Watchdog card to reset its internal timer so it doesn't trigger
+ * a computer reset.
+ */
+void keep_alive(void)
+{
+    int dummy;
+
+    ioctl(fd, WDIOC_KEEPALIVE, &dummy);
+}
+
+/*
+ * The main program.  Run the program with "-d" to disable the card,
+ * or "-e" to enable the card.
+ */
+int main(int argc, char *argv[])
+{
+    fd = open("/dev/watchdog", O_WRONLY);
+
+    if (fd == -1) {
+	fprintf(stderr, "Watchdog device not enabled.\n");
+	fflush(stderr);
+	exit(-1);
+    }
+
+    if (argc > 1) {
+	if (!strncasecmp(argv[1], "-d", 2)) {
+	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_DISABLECARD);
+	    fprintf(stderr, "Watchdog card disabled.\n");
+	    fflush(stderr);
+	    exit(0);
+	} else if (!strncasecmp(argv[1], "-e", 2)) {
+	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_ENABLECARD);
+	    fprintf(stderr, "Watchdog card enabled.\n");
+	    fflush(stderr);
+	    exit(0);
+	} else {
+	    fprintf(stderr, "-d to disable, -e to enable.\n");
+	    fprintf(stderr, "run by itself to tick the card.\n");
+	    fflush(stderr);
+	    exit(0);
+	}
+    } else {
+	fprintf(stderr, "Watchdog Ticking Away!\n");
+	fflush(stderr);
+    }
+
+    while(1) {
+	keep_alive();
+	sleep(1);
+    }
+}
+-- End snippet --
+
+ Other IOCTL functions include:
+
+	WDIOC_GETSUPPORT
+		This returns the support of the card itself.  This
+		returns in structure "PCWDS" which returns:
+			options = WDIOS_TEMPPANIC
+				  (This card supports temperature)
+			firmware_version = xxxx
+				  (Firmware version of the card)
+
+	WDIOC_GETSTATUS
+		This returns the status of the card, with the bits of
+		WDIOF_* bitwise-anded into the value.  (The comments
+		are in linux/pcwd.h)
+
+	WDIOC_GETBOOTSTATUS
+		This returns the status of the card that was reported
+		at bootup.
+
+	WDIOC_GETTEMP
+		This returns the temperature of the card.  (You can also
+		read /dev/watchdog, which gives a temperature update
+		every second.)
+
+	WDIOC_SETOPTIONS
+		This lets you set the options of the card.  You can either
+		enable or disable the card this way.
+
+	WDIOC_KEEPALIVE
+		This pings the card to tell it not to reset your computer.
+
+ And that's all she wrote!
+
+ -- Ken Hollis
+    (kenji@bitgate.com)
+
+(This documentation may be out of date.  Check
+ http://ftp.bitgate.com/pcwd/ for the absolute latest additions.)
diff -Nru a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/watchdog/watchdog-api.txt	Sat Sep  6 12:47:30 2003
@@ -0,0 +1,390 @@
+The Linux Watchdog driver API.
+
+Copyright 2002 Christer Weingel <wingel@nano-system.com>
+
+Some parts of this document are copied verbatim from the sbc60xxwdt
+driver which is (c) Copyright 2000 Jakob Oestergaard <jakob@ostenfeld.dk>
+
+This document describes the state of the Linux 2.4.18 kernel.
+
+Introduction:
+
+A Watchdog Timer (WDT) is a hardware circuit that can reset the
+computer system in case of a software fault.  You probably knew that
+already.
+
+Usually a userspace daemon will notify the kernel watchdog driver via the
+/dev/watchdog special device file that userspace is still alive, at
+regular intervals.  When such a notification occurs, the driver will
+usually tell the hardware watchdog that everything is in order, and
+that the watchdog should wait for yet another little while to reset
+the system.  If userspace fails (RAM error, kernel bug, whatever), the
+notifications cease to occur, and the hardware watchdog will reset the
+system (causing a reboot) after the timeout occurs.
+
+The Linux watchdog API is a rather AD hoc construction and different
+drivers implement different, and sometimes incompatible, parts of it.
+This file is an attempt to document the existing usage and allow
+future driver writers to use it as a reference.
+
+The simplest API:
+
+All drivers support the basic mode of operation, where the watchdog
+activates as soon as /dev/watchdog is opened and will reboot unless
+the watchdog is pinged within a certain time, this time is called the
+timeout or margin.  The simplest way to ping the watchdog is to write
+some data to the device.  So a very simple watchdog daemon would look
+like this:
+
+int main(int argc, const char *argv[]) {
+	int fd=open("/dev/watchdog",O_WRONLY);
+	if (fd==-1) {
+		perror("watchdog");
+		exit(1);
+	}
+	while(1) {
+		write(fd, "\0", 1);
+		sleep(10);
+	}
+}
+
+A more advanced driver could for example check that a HTTP server is
+still responding before doing the write call to ping the watchdog.
+
+When the device is closed, the watchdog is disabled.  This is not
+always such a good idea, since if there is a bug in the watchdog
+daemon and it crashes the system will not reboot.  Because of this,
+some of the drivers support the configuration option "Disable watchdog
+shutdown on close", CONFIG_WATCHDOG_NOWAYOUT.  If it is set to Y when
+compiling the kernel, there is no way of disabling the watchdog once
+it has been started.  So, if the watchdog dameon crashes, the system
+will reboot after the timeout has passed.
+
+Some other drivers will not disable the watchdog, unless a specific
+magic character 'V' has been sent /dev/watchdog just before closing
+the file.  If the userspace daemon closes the file without sending
+this special character, the driver will assume that the daemon (and
+userspace in general) died, and will stop pinging the watchdog without
+disabling it first.  This will then cause a reboot.
+
+The ioctl API:
+
+All conforming drivers also support an ioctl API.
+
+Pinging the watchdog using an ioctl:
+
+All drivers that have an ioctl interface support at least one ioctl,
+KEEPALIVE.  This ioctl does exactly the same thing as a write to the
+watchdog device, so the main loop in the above program could be
+replaced with:
+
+	while (1) {
+		ioctl(fd, WDIOC_KEEPALIVE, 0);
+		sleep(10);
+	}
+
+the argument to the ioctl is ignored.
+
+Setting and getting the timeout:
+
+For some drivers it is possible to modify the watchdog timeout on the
+fly with the SETTIMEOUT ioctl, those drivers have the WDIOF_SETTIMEOUT
+flag set in their option field.  The argument is an integer
+representing the timeout in seconds.  The driver returns the real
+timeout used in the same variable, and this timeout might differ from
+the requested one due to limitation of the hardware.
+
+    int timeout = 45;
+    ioctl(fd, WDIOC_SETTIMEOUT, &timeout);
+    printf("The timeout was set to %d seconds\n", timeout);
+
+This example might actually print "The timeout was set to 60 seconds"
+if the device has a granularity of minutes for its timeout.
+
+Starting with the Linux 2.4.18 kernel, it is possible to query the
+current timeout using the GETTIMEOUT ioctl.
+
+    ioctl(fd, WDIOC_GETTIMEOUT, &timeout);
+    printf("The timeout was is %d seconds\n", timeout);
+
+Envinronmental monitoring:
+
+All watchdog drivers are required return more information about the system,
+some do temperature, fan and power level monitoring, some can tell you
+the reason for the last reboot of the system.  The GETSUPPORT ioctl is
+available to ask what the device can do:
+
+	struct watchdog_info ident;
+	ioctl(fd, WDIOC_GETSUPPORT, &ident);
+
+the fields returned in the ident struct are:
+
+        identity		a string identifying the watchdog driver
+	firmware_version	the firmware version of the card if available
+	options			a flags describing what the device supports
+
+the options field can have the following bits set, and describes what
+kind of information that the GET_STATUS and GET_BOOT_STATUS ioctls can
+return.   [FIXME -- Is this correct?]
+
+	WDIOF_OVERHEAT		Reset due to CPU overheat
+
+The machine was last rebooted by the watchdog because the thermal limit was
+exceeded
+
+	WDIOF_FANFAULT		Fan failed
+
+A system fan monitored by the watchdog card has failed
+
+	WDIOF_EXTERN1		External relay 1
+
+External monitoring relay/source 1 was triggered. Controllers intended for
+real world applications include external monitoring pins that will trigger
+a reset.
+
+	WDIOF_EXTERN2		External relay 2
+
+External monitoring relay/source 2 was triggered
+
+	WDIOF_POWERUNDER	Power bad/power fault
+
+The machine is showing an undervoltage status
+
+	WDIOF_CARDRESET		Card previously reset the CPU
+
+The last reboot was caused by the watchdog card
+
+	WDIOF_POWEROVER		Power over voltage
+
+The machine is showing an overvoltage status. Note that if one level is
+under and one over both bits will be set - this may seem odd but makes
+sense.
+
+	WDIOF_KEEPALIVEPING	Keep alive ping reply
+
+The watchdog saw a keepalive ping since it was last queried.
+
+	WDIOF_SETTIMEOUT	Can set/get the timeout
+
+
+For those drivers that return any bits set in the option field, the
+GETSTATUS and GETBOOTSTATUS ioctls can be used to ask for the current
+status, and the status at the last reboot, respectively.  
+
+    int flags;
+    ioctl(fd, WDIOC_GETSTATUS, &flags);
+
+    or
+
+    ioctl(fd, WDIOC_GETBOOTSTATUS, &flags);
+
+Note that not all devices support these two calls, and some only
+support the GETBOOTSTATUS call.
+
+Some drivers can measure the temperature using the GETTEMP ioctl.  The
+returned value is the temperature in degrees farenheit.
+
+    int temperature;
+    ioctl(fd, WDIOC_GETTEMP, &temperature);
+
+Finally the SETOPTIONS ioctl can be used to control some aspects of
+the cards operation; right now the pcwd driver is the only one
+supporting thiss ioctl.
+
+    int options = 0;
+    ioctl(fd, WDIOC_SETOPTIONS, options);
+
+The following options are available:
+
+	WDIOS_DISABLECARD	Turn off the watchdog timer
+	WDIOS_ENABLECARD	Turn on the watchdog timer
+	WDIOS_TEMPPANIC		Kernel panic on temperature trip
+
+[FIXME -- better explanations]
+
+Implementations in the current drivers in the kernel tree:
+
+Here I have tried to summarize what the different drivers support and
+where they do strange things compared to the other drivers.
+
+acquirewdt.c -- Acquire Single Board Computer
+
+	This driver has a hardcoded timeout of 1 minute
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	GETSUPPORT returns KEEPALIVEPING.  GETSTATUS will return 1 if
+	the device is open, 0 if not.  [FIXME -- isn't this rather
+	silly?  To be able to use the ioctl, the device must be open
+	and so GETSTATUS will always return 1].
+
+advantechwdt.c -- Advantech Single Board Computer
+
+	Timeout that defaults to 60 seconds, supports SETTIMEOUT.
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	GETSUPPORT returns WDIOF_KEEPALIVEPING and WDIOF_SETTIMEOUT.
+	The GETSTATUS call returns if the device is open or not.
+	[FIXME -- silliness again?]
+	
+eurotechwdt.c -- Eurotech CPU-1220/1410
+
+	The timeout can be set using the SETTIMEOUT ioctl and defaults
+	to 60 seconds.
+
+	Also has a module parameter "ev", event type which controls
+	what should happen on a timeout, the string "int" or anything
+	else that causes a reboot.  [FIXME -- better description]
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	GETSUPPORT returns CARDRESET and WDIOF_SETTIMEOUT but
+	GETSTATUS is not supported and GETBOOTSTATUS just returns 0.
+
+i810-tco.c -- Intel 810 chipset
+
+	Also has support for a lot of other i8x0 stuff, but the
+	watchdog is one of the things.
+
+	The timeout is set using the module parameter "i810_margin",
+	which is in steps of 0.6 seconds where 2<i810_margin<64.  The
+	driver supports the SETTIMEOUT ioctl.
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT.
+
+	GETSUPPORT returns WDIOF_SETTIMEOUT.  The GETSTATUS call
+	returns some kind of timer value which ist not compatible with
+	the other drivers.  GETBOOT status returns some kind of
+	hardware specific boot status.  [FIXME -- describe this]
+
+ib700wdt.c -- IB700 Single Board Computer
+
+	Default timeout of 30 seconds and the timeout is settable
+	using the SETTIMEOUT ioctl.  Note that only a few timeout
+	values are supported.
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	GETSUPPORT returns WDIOF_KEEPALIVEPING and WDIOF_SETTIMEOUT.
+	The GETSTATUS call returns if the device is open or not.
+	[FIXME -- silliness again?]
+
+machzwd.c -- MachZ ZF-Logic
+
+	Hardcoded timeout of 10 seconds
+
+	Has a module parameter "action" that controls what happens
+	when the timeout runs out which can be 0 = RESET (default), 
+	1 = SMI, 2 = NMI, 3 = SCI.
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT and the magic character
+	'V' close handling.
+
+	GETSUPPORT returns WDIOF_KEEPALIVEPING, and the GETSTATUS call
+	returns if the device is open or not.  [FIXME -- silliness
+	again?]
+
+mixcomwd.c -- MixCom Watchdog
+
+	[FIXME -- I'm unable to tell what the timeout is]
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	GETSUPPORT returns WDIOF_KEEPALIVEPING, GETSTATUS returns if
+	the device is opened or not [FIXME -- I'm not really sure how
+	this works, there seems to be some magic connected to
+	CONFIG_WATCHDOG_NOWAYOUT]
+
+pcwd.c -- Berkshire PC Watchdog
+
+	Hardcoded timeout of 1.5 seconds
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	GETSUPPORT returns WDIOF_OVERHEAT|WDIOF_CARDRESET and both
+	GETSTATUS and GETBOOTSTATUS return something useful.
+
+	The SETOPTIONS call can be used to enable and disable the card
+	and to ask the driver to call panic if the system overheats.
+
+sbc60xxwdt.c -- 60xx Single Board Computer
+
+	Hardcoded timeout of 10 seconds
+
+	Does not support CONFIG_WATCHDOG_NOWAYOUT, but has the magic
+	character 'V' close handling.
+
+	No bits set in GETSUPPORT
+
+scx200.c -- National SCx200 CPUs
+
+	Not in the kernel yet.
+
+	The timeout is set using a module parameter "margin" which
+	defaults to 60 seconds.  The timeout can also be set using
+	SETTIMEOUT and read using GETTIMEOUT.
+
+	Supports a module parameter "nowayout" that is initialized
+	with the value of CONFIG_WATCHDOG_NOWAYOUT.  Also supports the
+	magic character 'V' handling.
+
+shwdt.c -- SuperH 3/4 processors
+
+	[FIXME -- I'm unable to tell what the timeout is]
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	GETSUPPORT returns WDIOF_KEEPALIVEPING, and the GETSTATUS call
+	returns if the device is open or not.  [FIXME -- silliness
+	again?]
+
+softdog.c -- Software watchdog
+
+	The timeout is set with the module parameter "soft_margin"
+	which defaults to 60 seconds, the timeout is also settable
+	using the SETTIMEOUT ioctl.
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	WDIOF_SETTIMEOUT bit set in GETSUPPORT
+
+w83877f_wdt.c -- W83877F Computer
+
+	Hardcoded timeout of 30 seconds
+
+	Does not support CONFIG_WATCHDOG_NOWAYOUT, but has the magic
+	character 'V' close handling.
+
+	No bits set in GETSUPPORT
+
+wdt.c -- ICS WDT500/501 ISA and
+wdt_pci.c -- ICS WDT500/501 PCI
+
+	Default timeout of 60 seconds.  The timeout is also settable
+        using the SETTIMEOUT ioctl.
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	GETSUPPORT returns with bits set depending on the actual
+	card. The WDT501 supports a lot of external monitoring, the
+	WDT500 much less.
+
+wdt285.c -- Footbridge watchdog
+
+	The timeout is set with the module parameter "soft_margin"
+	which defaults to 60 seconds.  The timeout is also settable
+	using the SETTIMEOUT ioctl.
+
+	Does not support CONFIG_WATCHDOG_NOWAYOUT
+
+	WDIOF_SETTIMEOUT bit set in GETSUPPORT
+
+wdt977.c -- Netwinder W83977AF chip
+
+	Hardcoded timeout of 3 minutes
+
+	Supports CONFIG_WATCHDOG_NOWAYOUT
+
+	Does not support any ioctls at all.
+
diff -Nru a/Documentation/watchdog/watchdog.txt b/Documentation/watchdog/watchdog.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/watchdog/watchdog.txt	Sat Sep  6 12:47:30 2003
@@ -0,0 +1,115 @@
+	Watchdog Timer Interfaces For The Linux Operating System
+
+		Alan Cox <alan@lxorguk.ukuu.org.uk>
+
+	     Custom Linux Driver And Program Development
+
+
+The following watchdog drivers are currently implemented:
+
+	ICS	WDT501-P
+	ICS	WDT501-P (no fan tachometer)
+	ICS	WDT500-P
+	Software Only
+	SA1100 Internal Watchdog
+	Berkshire Products PC Watchdog Revision A & C (by Ken Hollis)
+
+
+All six interfaces provide /dev/watchdog, which when open must be written
+to within a timeout or the machine will reboot. Each write delays the reboot
+time another timeout. In the case of the software watchdog the ability to 
+reboot will depend on the state of the machines and interrupts. The hardware
+boards physically pull the machine down off their own onboard timers and
+will reboot from almost anything.
+
+A second temperature monitoring interface is available on the WDT501P cards
+and some Berkshire cards. This provides /dev/temperature. This is the machine 
+internal temperature in degrees Fahrenheit. Each read returns a single byte 
+giving the temperature.
+
+The third interface logs kernel messages on additional alert events.
+
+Both software and hardware watchdog drivers are available in the standard
+kernel. If you are using the software watchdog, you probably also want
+to use "panic=60" as a boot argument as well.
+
+The wdt card cannot be safely probed for. Instead you need to pass
+wdt=ioaddr,irq as a boot parameter - eg "wdt=0x240,11".
+
+The SA1100 watchdog module can be configured with the "sa1100_margin"
+commandline argument which specifies timeout value in seconds.
+
+The i810 TCO watchdog modules can be configured with the "i810_margin"
+commandline argument which specifies the counter initial value. The counter
+is decremented every 0.6 seconds and default to 50 (30 seconds). Values can
+range between 3 and 63.
+
+The i810 TCO watchdog driver also implements the WDIOC_GETSTATUS and
+WDIOC_GETBOOTSTATUS ioctl()s. WDIOC_GETSTATUS returns the actual counter value
+and WDIOC_GETBOOTSTATUS returns the value of TCO2 Status Register (see Intel's
+documentation for the 82801AA and 82801AB datasheet). 
+
+Features
+--------
+		WDT501P		WDT500P		Software	Berkshire	i810 TCO	SA1100WD
+Reboot Timer	   X               X                X		    X               X               X
+External Reboot	   X	           X                o		    o               o               X
+I/O Port Monitor   o		   o		    o		    X               o               o
+Temperature	   X		   o		    o               X               o               o
+Fan Speed          X		   o		    o               o               o               o
+Power Under	   X               o                o               o               o               o
+Power Over         X               o                o               o               o               o
+Overheat           X               o                o               o               o               o
+
+The external event interfaces on the WDT boards are not currently supported.
+Minor numbers are however allocated for it.
+
+
+Example Watchdog Driver
+-----------------------
+
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+int main(int argc, const char *argv[])
+{
+	int fd=open("/dev/watchdog",O_WRONLY);
+	if(fd==-1)
+	{
+		perror("watchdog");
+		exit(1);
+	}
+	while(1)
+	{
+		write(fd,"\0",1);
+		fsync(fd);
+		sleep(10);
+	}
+}
+
+
+Contact Information
+
+People keep asking about the WDT watchdog timer hardware: The phone contacts
+for Industrial Computer Source are:
+ 
+Industrial Computer Source
+http://www.indcompsrc.com
+ICS Advent, San Diego
+6260 Sequence Dr.
+San Diego, CA 92121-4371
+Phone (858) 677-0877
+FAX: (858) 677-0895
+>
+ICS Advent Europe, UK
+Oving Road
+Chichester,
+West Sussex,
+PO19 4ET, UK
+Phone: 00.44.1243.533900
+
+
+and please mention Linux when enquiring.
+
+For full information about the PCWD cards see the pcwd-watchdog.txt document.
diff -Nru a/Documentation/watchdog-api.txt b/Documentation/watchdog-api.txt
--- a/Documentation/watchdog-api.txt	Sat Sep  6 12:47:30 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,390 +0,0 @@
-The Linux Watchdog driver API.
-
-Copyright 2002 Christer Weingel <wingel@nano-system.com>
-
-Some parts of this document are copied verbatim from the sbc60xxwdt
-driver which is (c) Copyright 2000 Jakob Oestergaard <jakob@ostenfeld.dk>
-
-This document describes the state of the Linux 2.4.18 kernel.
-
-Introduction:
-
-A Watchdog Timer (WDT) is a hardware circuit that can reset the
-computer system in case of a software fault.  You probably knew that
-already.
-
-Usually a userspace daemon will notify the kernel watchdog driver via the
-/dev/watchdog special device file that userspace is still alive, at
-regular intervals.  When such a notification occurs, the driver will
-usually tell the hardware watchdog that everything is in order, and
-that the watchdog should wait for yet another little while to reset
-the system.  If userspace fails (RAM error, kernel bug, whatever), the
-notifications cease to occur, and the hardware watchdog will reset the
-system (causing a reboot) after the timeout occurs.
-
-The Linux watchdog API is a rather AD hoc construction and different
-drivers implement different, and sometimes incompatible, parts of it.
-This file is an attempt to document the existing usage and allow
-future driver writers to use it as a reference.
-
-The simplest API:
-
-All drivers support the basic mode of operation, where the watchdog
-activates as soon as /dev/watchdog is opened and will reboot unless
-the watchdog is pinged within a certain time, this time is called the
-timeout or margin.  The simplest way to ping the watchdog is to write
-some data to the device.  So a very simple watchdog daemon would look
-like this:
-
-int main(int argc, const char *argv[]) {
-	int fd=open("/dev/watchdog",O_WRONLY);
-	if (fd==-1) {
-		perror("watchdog");
-		exit(1);
-	}
-	while(1) {
-		write(fd, "\0", 1);
-		sleep(10);
-	}
-}
-
-A more advanced driver could for example check that a HTTP server is
-still responding before doing the write call to ping the watchdog.
-
-When the device is closed, the watchdog is disabled.  This is not
-always such a good idea, since if there is a bug in the watchdog
-daemon and it crashes the system will not reboot.  Because of this,
-some of the drivers support the configuration option "Disable watchdog
-shutdown on close", CONFIG_WATCHDOG_NOWAYOUT.  If it is set to Y when
-compiling the kernel, there is no way of disabling the watchdog once
-it has been started.  So, if the watchdog dameon crashes, the system
-will reboot after the timeout has passed.
-
-Some other drivers will not disable the watchdog, unless a specific
-magic character 'V' has been sent /dev/watchdog just before closing
-the file.  If the userspace daemon closes the file without sending
-this special character, the driver will assume that the daemon (and
-userspace in general) died, and will stop pinging the watchdog without
-disabling it first.  This will then cause a reboot.
-
-The ioctl API:
-
-All conforming drivers also support an ioctl API.
-
-Pinging the watchdog using an ioctl:
-
-All drivers that have an ioctl interface support at least one ioctl,
-KEEPALIVE.  This ioctl does exactly the same thing as a write to the
-watchdog device, so the main loop in the above program could be
-replaced with:
-
-	while (1) {
-		ioctl(fd, WDIOC_KEEPALIVE, 0);
-		sleep(10);
-	}
-
-the argument to the ioctl is ignored.
-
-Setting and getting the timeout:
-
-For some drivers it is possible to modify the watchdog timeout on the
-fly with the SETTIMEOUT ioctl, those drivers have the WDIOF_SETTIMEOUT
-flag set in their option field.  The argument is an integer
-representing the timeout in seconds.  The driver returns the real
-timeout used in the same variable, and this timeout might differ from
-the requested one due to limitation of the hardware.
-
-    int timeout = 45;
-    ioctl(fd, WDIOC_SETTIMEOUT, &timeout);
-    printf("The timeout was set to %d seconds\n", timeout);
-
-This example might actually print "The timeout was set to 60 seconds"
-if the device has a granularity of minutes for its timeout.
-
-Starting with the Linux 2.4.18 kernel, it is possible to query the
-current timeout using the GETTIMEOUT ioctl.
-
-    ioctl(fd, WDIOC_GETTIMEOUT, &timeout);
-    printf("The timeout was is %d seconds\n", timeout);
-
-Envinronmental monitoring:
-
-All watchdog drivers are required return more information about the system,
-some do temperature, fan and power level monitoring, some can tell you
-the reason for the last reboot of the system.  The GETSUPPORT ioctl is
-available to ask what the device can do:
-
-	struct watchdog_info ident;
-	ioctl(fd, WDIOC_GETSUPPORT, &ident);
-
-the fields returned in the ident struct are:
-
-        identity		a string identifying the watchdog driver
-	firmware_version	the firmware version of the card if available
-	options			a flags describing what the device supports
-
-the options field can have the following bits set, and describes what
-kind of information that the GET_STATUS and GET_BOOT_STATUS ioctls can
-return.   [FIXME -- Is this correct?]
-
-	WDIOF_OVERHEAT		Reset due to CPU overheat
-
-The machine was last rebooted by the watchdog because the thermal limit was
-exceeded
-
-	WDIOF_FANFAULT		Fan failed
-
-A system fan monitored by the watchdog card has failed
-
-	WDIOF_EXTERN1		External relay 1
-
-External monitoring relay/source 1 was triggered. Controllers intended for
-real world applications include external monitoring pins that will trigger
-a reset.
-
-	WDIOF_EXTERN2		External relay 2
-
-External monitoring relay/source 2 was triggered
-
-	WDIOF_POWERUNDER	Power bad/power fault
-
-The machine is showing an undervoltage status
-
-	WDIOF_CARDRESET		Card previously reset the CPU
-
-The last reboot was caused by the watchdog card
-
-	WDIOF_POWEROVER		Power over voltage
-
-The machine is showing an overvoltage status. Note that if one level is
-under and one over both bits will be set - this may seem odd but makes
-sense.
-
-	WDIOF_KEEPALIVEPING	Keep alive ping reply
-
-The watchdog saw a keepalive ping since it was last queried.
-
-	WDIOF_SETTIMEOUT	Can set/get the timeout
-
-
-For those drivers that return any bits set in the option field, the
-GETSTATUS and GETBOOTSTATUS ioctls can be used to ask for the current
-status, and the status at the last reboot, respectively.  
-
-    int flags;
-    ioctl(fd, WDIOC_GETSTATUS, &flags);
-
-    or
-
-    ioctl(fd, WDIOC_GETBOOTSTATUS, &flags);
-
-Note that not all devices support these two calls, and some only
-support the GETBOOTSTATUS call.
-
-Some drivers can measure the temperature using the GETTEMP ioctl.  The
-returned value is the temperature in degrees farenheit.
-
-    int temperature;
-    ioctl(fd, WDIOC_GETTEMP, &temperature);
-
-Finally the SETOPTIONS ioctl can be used to control some aspects of
-the cards operation; right now the pcwd driver is the only one
-supporting thiss ioctl.
-
-    int options = 0;
-    ioctl(fd, WDIOC_SETOPTIONS, options);
-
-The following options are available:
-
-	WDIOS_DISABLECARD	Turn off the watchdog timer
-	WDIOS_ENABLECARD	Turn on the watchdog timer
-	WDIOS_TEMPPANIC		Kernel panic on temperature trip
-
-[FIXME -- better explanations]
-
-Implementations in the current drivers in the kernel tree:
-
-Here I have tried to summarize what the different drivers support and
-where they do strange things compared to the other drivers.
-
-acquirewdt.c -- Acquire Single Board Computer
-
-	This driver has a hardcoded timeout of 1 minute
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	GETSUPPORT returns KEEPALIVEPING.  GETSTATUS will return 1 if
-	the device is open, 0 if not.  [FIXME -- isn't this rather
-	silly?  To be able to use the ioctl, the device must be open
-	and so GETSTATUS will always return 1].
-
-advantechwdt.c -- Advantech Single Board Computer
-
-	Timeout that defaults to 60 seconds, supports SETTIMEOUT.
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	GETSUPPORT returns WDIOF_KEEPALIVEPING and WDIOF_SETTIMEOUT.
-	The GETSTATUS call returns if the device is open or not.
-	[FIXME -- silliness again?]
-	
-eurotechwdt.c -- Eurotech CPU-1220/1410
-
-	The timeout can be set using the SETTIMEOUT ioctl and defaults
-	to 60 seconds.
-
-	Also has a module parameter "ev", event type which controls
-	what should happen on a timeout, the string "int" or anything
-	else that causes a reboot.  [FIXME -- better description]
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	GETSUPPORT returns CARDRESET and WDIOF_SETTIMEOUT but
-	GETSTATUS is not supported and GETBOOTSTATUS just returns 0.
-
-i810-tco.c -- Intel 810 chipset
-
-	Also has support for a lot of other i8x0 stuff, but the
-	watchdog is one of the things.
-
-	The timeout is set using the module parameter "i810_margin",
-	which is in steps of 0.6 seconds where 2<i810_margin<64.  The
-	driver supports the SETTIMEOUT ioctl.
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT.
-
-	GETSUPPORT returns WDIOF_SETTIMEOUT.  The GETSTATUS call
-	returns some kind of timer value which ist not compatible with
-	the other drivers.  GETBOOT status returns some kind of
-	hardware specific boot status.  [FIXME -- describe this]
-
-ib700wdt.c -- IB700 Single Board Computer
-
-	Default timeout of 30 seconds and the timeout is settable
-	using the SETTIMEOUT ioctl.  Note that only a few timeout
-	values are supported.
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	GETSUPPORT returns WDIOF_KEEPALIVEPING and WDIOF_SETTIMEOUT.
-	The GETSTATUS call returns if the device is open or not.
-	[FIXME -- silliness again?]
-
-machzwd.c -- MachZ ZF-Logic
-
-	Hardcoded timeout of 10 seconds
-
-	Has a module parameter "action" that controls what happens
-	when the timeout runs out which can be 0 = RESET (default), 
-	1 = SMI, 2 = NMI, 3 = SCI.
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT and the magic character
-	'V' close handling.
-
-	GETSUPPORT returns WDIOF_KEEPALIVEPING, and the GETSTATUS call
-	returns if the device is open or not.  [FIXME -- silliness
-	again?]
-
-mixcomwd.c -- MixCom Watchdog
-
-	[FIXME -- I'm unable to tell what the timeout is]
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	GETSUPPORT returns WDIOF_KEEPALIVEPING, GETSTATUS returns if
-	the device is opened or not [FIXME -- I'm not really sure how
-	this works, there seems to be some magic connected to
-	CONFIG_WATCHDOG_NOWAYOUT]
-
-pcwd.c -- Berkshire PC Watchdog
-
-	Hardcoded timeout of 1.5 seconds
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	GETSUPPORT returns WDIOF_OVERHEAT|WDIOF_CARDRESET and both
-	GETSTATUS and GETBOOTSTATUS return something useful.
-
-	The SETOPTIONS call can be used to enable and disable the card
-	and to ask the driver to call panic if the system overheats.
-
-sbc60xxwdt.c -- 60xx Single Board Computer
-
-	Hardcoded timeout of 10 seconds
-
-	Does not support CONFIG_WATCHDOG_NOWAYOUT, but has the magic
-	character 'V' close handling.
-
-	No bits set in GETSUPPORT
-
-scx200.c -- National SCx200 CPUs
-
-	Not in the kernel yet.
-
-	The timeout is set using a module parameter "margin" which
-	defaults to 60 seconds.  The timeout can also be set using
-	SETTIMEOUT and read using GETTIMEOUT.
-
-	Supports a module parameter "nowayout" that is initialized
-	with the value of CONFIG_WATCHDOG_NOWAYOUT.  Also supports the
-	magic character 'V' handling.
-
-shwdt.c -- SuperH 3/4 processors
-
-	[FIXME -- I'm unable to tell what the timeout is]
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	GETSUPPORT returns WDIOF_KEEPALIVEPING, and the GETSTATUS call
-	returns if the device is open or not.  [FIXME -- silliness
-	again?]
-
-softdog.c -- Software watchdog
-
-	The timeout is set with the module parameter "soft_margin"
-	which defaults to 60 seconds, the timeout is also settable
-	using the SETTIMEOUT ioctl.
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	WDIOF_SETTIMEOUT bit set in GETSUPPORT
-
-w83877f_wdt.c -- W83877F Computer
-
-	Hardcoded timeout of 30 seconds
-
-	Does not support CONFIG_WATCHDOG_NOWAYOUT, but has the magic
-	character 'V' close handling.
-
-	No bits set in GETSUPPORT
-
-wdt.c -- ICS WDT500/501 ISA and
-wdt_pci.c -- ICS WDT500/501 PCI
-
-	Default timeout of 60 seconds.  The timeout is also settable
-        using the SETTIMEOUT ioctl.
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	GETSUPPORT returns with bits set depending on the actual
-	card. The WDT501 supports a lot of external monitoring, the
-	WDT500 much less.
-
-wdt285.c -- Footbridge watchdog
-
-	The timeout is set with the module parameter "soft_margin"
-	which defaults to 60 seconds.  The timeout is also settable
-	using the SETTIMEOUT ioctl.
-
-	Does not support CONFIG_WATCHDOG_NOWAYOUT
-
-	WDIOF_SETTIMEOUT bit set in GETSUPPORT
-
-wdt977.c -- Netwinder W83977AF chip
-
-	Hardcoded timeout of 3 minutes
-
-	Supports CONFIG_WATCHDOG_NOWAYOUT
-
-	Does not support any ioctls at all.
-
diff -Nru a/Documentation/watchdog.txt b/Documentation/watchdog.txt
--- a/Documentation/watchdog.txt	Sat Sep  6 12:47:30 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,115 +0,0 @@
-	Watchdog Timer Interfaces For The Linux Operating System
-
-		Alan Cox <alan@lxorguk.ukuu.org.uk>
-
-	     Custom Linux Driver And Program Development
-
-
-The following watchdog drivers are currently implemented:
-
-	ICS	WDT501-P
-	ICS	WDT501-P (no fan tachometer)
-	ICS	WDT500-P
-	Software Only
-	SA1100 Internal Watchdog
-	Berkshire Products PC Watchdog Revision A & C (by Ken Hollis)
-
-
-All six interfaces provide /dev/watchdog, which when open must be written
-to within a timeout or the machine will reboot. Each write delays the reboot
-time another timeout. In the case of the software watchdog the ability to 
-reboot will depend on the state of the machines and interrupts. The hardware
-boards physically pull the machine down off their own onboard timers and
-will reboot from almost anything.
-
-A second temperature monitoring interface is available on the WDT501P cards
-and some Berkshire cards. This provides /dev/temperature. This is the machine 
-internal temperature in degrees Fahrenheit. Each read returns a single byte 
-giving the temperature.
-
-The third interface logs kernel messages on additional alert events.
-
-Both software and hardware watchdog drivers are available in the standard
-kernel. If you are using the software watchdog, you probably also want
-to use "panic=60" as a boot argument as well.
-
-The wdt card cannot be safely probed for. Instead you need to pass
-wdt=ioaddr,irq as a boot parameter - eg "wdt=0x240,11".
-
-The SA1100 watchdog module can be configured with the "sa1100_margin"
-commandline argument which specifies timeout value in seconds.
-
-The i810 TCO watchdog modules can be configured with the "i810_margin"
-commandline argument which specifies the counter initial value. The counter
-is decremented every 0.6 seconds and default to 50 (30 seconds). Values can
-range between 3 and 63.
-
-The i810 TCO watchdog driver also implements the WDIOC_GETSTATUS and
-WDIOC_GETBOOTSTATUS ioctl()s. WDIOC_GETSTATUS returns the actual counter value
-and WDIOC_GETBOOTSTATUS returns the value of TCO2 Status Register (see Intel's
-documentation for the 82801AA and 82801AB datasheet). 
-
-Features
---------
-		WDT501P		WDT500P		Software	Berkshire	i810 TCO	SA1100WD
-Reboot Timer	   X               X                X		    X               X               X
-External Reboot	   X	           X                o		    o               o               X
-I/O Port Monitor   o		   o		    o		    X               o               o
-Temperature	   X		   o		    o               X               o               o
-Fan Speed          X		   o		    o               o               o               o
-Power Under	   X               o                o               o               o               o
-Power Over         X               o                o               o               o               o
-Overheat           X               o                o               o               o               o
-
-The external event interfaces on the WDT boards are not currently supported.
-Minor numbers are however allocated for it.
-
-
-Example Watchdog Driver
------------------------
-
-#include <stdio.h>
-#include <unistd.h>
-#include <fcntl.h>
-
-int main(int argc, const char *argv[])
-{
-	int fd=open("/dev/watchdog",O_WRONLY);
-	if(fd==-1)
-	{
-		perror("watchdog");
-		exit(1);
-	}
-	while(1)
-	{
-		write(fd,"\0",1);
-		fsync(fd);
-		sleep(10);
-	}
-}
-
-
-Contact Information
-
-People keep asking about the WDT watchdog timer hardware: The phone contacts
-for Industrial Computer Source are:
- 
-Industrial Computer Source
-http://www.indcompsrc.com
-ICS Advent, San Diego
-6260 Sequence Dr.
-San Diego, CA 92121-4371
-Phone (858) 677-0877
-FAX: (858) 677-0895
->
-ICS Advent Europe, UK
-Oving Road
-Chichester,
-West Sussex,
-PO19 4ET, UK
-Phone: 00.44.1243.533900
-
-
-and please mention Linux when enquiring.
-
-For full information about the PCWD cards see the pcwd-watchdog.txt document.
