Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVBVT2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVBVT2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVBVT2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:28:54 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:47278 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261453AbVBVT1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:27:52 -0500
Message-ID: <421B87B6.6060509@acm.org>
Date: Tue, 22 Feb 2005 13:27:50 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] IPMI documentation updates
Content-Type: multipart/mixed;
 boundary="------------050804030000070402030506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050804030000070402030506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------050804030000070402030506
Content-Type: text/plain;
 name="ipmi-docs-updates.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-docs-updates.diff"

This cleans up the IPMI documentation to fix some problems and
make it more accurate for the current drivers.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc4/Documentation/IPMI.txt
===================================================================
--- linux-2.6.11-rc4.orig/Documentation/IPMI.txt
+++ linux-2.6.11-rc4/Documentation/IPMI.txt
@@ -25,9 +25,10 @@
 Configuration
 -------------
 
-The LinuxIPMI driver is modular, which means you have to pick several
+The Linux IPMI driver is modular, which means you have to pick several
 things to have it work right depending on your hardware.  Most of
-these are available in the 'Character Devices' menu.
+these are available in the 'Character Devices' menu then the IPMI
+menu.
 
 No matter what, you must pick 'IPMI top-level message handler' to use
 IPMI.  What you do beyond that depends on your needs and hardware.
@@ -35,33 +36,30 @@
 The message handler does not provide any user-level interfaces.
 Kernel code (like the watchdog) can still use it.  If you need access
 from userland, you need to select 'Device interface for IPMI' if you
-want access through a device driver.  Another interface is also
-available, you may select 'IPMI sockets' in the 'Networking Support'
-main menu.  This provides a socket interface to IPMI.  You may select
-both of these at the same time, they will both work together.
-
-The driver interface depends on your hardware.  If you have a board
-with a standard interface (These will generally be either "KCS",
-"SMIC", or "BT", consult your hardware manual), choose the 'IPMI SI
-handler' option.  A driver also exists for direct I2C access to the
-IPMI management controller.  Some boards support this, but it is
-unknown if it will work on every board.  For this, choose 'IPMI SMBus
-handler', but be ready to try to do some figuring to see if it will
-work.
+want access through a device driver.
 
-There is also a KCS-only driver interface supplied, but it is
-depracated in favor of the SI interface.
+The driver interface depends on your hardware.  If your system
+properly provides the SMBIOS info for IPMI, the driver will detect it
+and just work.  If you have a board with a standard interface (These
+will generally be either "KCS", "SMIC", or "BT", consult your hardware
+manual), choose the 'IPMI SI handler' option.  A driver also exists
+for direct I2C access to the IPMI management controller.  Some boards
+support this, but it is unknown if it will work on every board.  For
+this, choose 'IPMI SMBus handler', but be ready to try to do some
+figuring to see if it will work on your system if the SMBIOS/APCI
+information is wrong or not present.  It is fairly safe to have both
+these enabled and let the drivers auto-detect what is present.
 
 You should generally enable ACPI on your system, as systems with IPMI
-should have ACPI tables describing them.
+can have ACPI tables describing them.
 
 If you have a standard interface and the board manufacturer has done
 their job correctly, the IPMI controller should be automatically
-detect (via ACPI or SMBIOS tables) and should just work.  Sadly, many
-boards do not have this information.  The driver attempts standard
-defaults, but they may not work.  If you fall into this situation, you
-need to read the section below named 'The SI Driver' on how to
-hand-configure your system.
+detected (via ACPI or SMBIOS tables) and should just work.  Sadly,
+many boards do not have this information.  The driver attempts
+standard defaults, but they may not work.  If you fall into this
+situation, you need to read the section below named 'The SI Driver' or
+"The SMBus Driver" on how to hand-configure your system.
 
 IPMI defines a standard watchdog timer.  You can enable this with the
 'IPMI Watchdog Timer' config option.  If you compile the driver into
@@ -73,6 +71,18 @@
 Cards' menu, enable 'Watchdog Timer Support', and enable the option
 'Disable watchdog shutdown on close'.
 
+IPMI systems can often be powered off using IPMI commands.  Select
+'IPMI Poweroff' to do this.  The driver will auto-detect if the system
+can be powered off by IPMI.  It is safe to enable this even if your
+system doesn't support this option.  This works on ATCA systems, the
+Radisys CPI1 card, and any IPMI system that supports standard chassis
+management commands.
+
+If you want the driver to put an event into the event log on a panic,
+enable the 'Generate a panic event to all BMCs on a panic' option.  If
+you want the whole panic string put into the event log using OEM
+events, enable the 'Generate OEM events containing the panic string'
+option.
 
 Basic Design
 ------------
@@ -80,7 +90,7 @@
 The Linux IPMI driver is designed to be very modular and flexible, you
 only need to take the pieces you need and you can use it in many
 different ways.  Because of that, it's broken into many chunks of
-code.  These chunks are:
+code.  These chunks (by module name) are:
 
 ipmi_msghandler - This is the central piece of software for the IPMI
 system.  It handles all messages, message timing, and responses.  The
@@ -93,18 +103,26 @@
 driver, each open file for this device ties in to the message handler
 as an IPMI user.
 
-ipmi_si - A driver for various system interfaces.  This supports
-KCS, SMIC, and may support BT in the future.  Unless you have your own
-custom interface, you probably need to use this.
+ipmi_si - A driver for various system interfaces.  This supports KCS,
+SMIC, and BT interfaces.  Unless you have an SMBus interface or your
+own custom interface, you probably need to use this.
 
 ipmi_smb - A driver for accessing BMCs on the SMBus. It uses the
 I2C kernel driver's SMBus interfaces to send and receive IPMI messages
 over the SMBus.
 
-af_ipmi - A network socket interface to IPMI.  This doesn't take up
-a character device in your system.
-
-Note that the KCS-only interface ahs been removed.
+ipmi_watchdog - IPMI requires systems to have a very capable watchdog
+timer.  This driver implements the standard Linux watchdog timer
+interface on top of the IPMI message handler.
+
+ipmi_poweroff - Some systems support the ability to be turned off via
+IPMI commands.
+
+These are all individually selectable via configuration options.
+
+Note that the KCS-only interface has been removed.  The af_ipmi driver
+is no longer supported and has been removed because it was impossible
+to do 32 bit emulation on 64-bit kernels with it.
 
 Much documentation for the interface is in the include files.  The
 IPMI include files are:
@@ -425,7 +443,7 @@
 	addr=<adapter1>,<i2caddr1>[,<adapter2>,<i2caddr2>[,...]]
 	dbg=<flags1>,<flags2>...
         slave_addrs=<addr1>,<addr2>,...
-	[defaultprobe=1] [dbg_probe=1]
+	[defaultprobe=0] [dbg_probe=1]
 
 The addresses are specified in pairs, the first is the adapter ID and the
 second is the I2C address on that adapter.
@@ -540,3 +558,47 @@
 device to close it, or the timer will not stop.  This is a new semantic
 for the driver, but makes it consistent with the rest of the watchdog
 drivers in Linux.
+
+
+Panic Timeouts
+--------------
+
+The OpenIPMI driver supports the ability to put semi-custom and custom
+events in the system event log if a panic occurs.  if you enable the
+'Generate a panic event to all BMCs on a panic' option, you will get
+one event on a panic in a standard IPMI event format.  If you enable
+the 'Generate OEM events containing the panic string' option, you will
+also get a bunch of OEM events holding the panic string.
+
+
+The field settings of the events are:
+* Generator ID: 0x21 (kernel)
+* EvM Rev: 0x03 (this event is formatting in IPMI 1.0 format)
+* Sensor Type: 0x20 (OS critical stop sensor)
+* Sensor #: The first byte of the panic string (0 if no panic string)
+* Event Dir | Event Type: 0x6f (Assertion, sensor-specific event info)
+* Event Data 1: 0xa1 (Runtime stop in OEM bytes 2 and 3)
+* Event data 2: second byte of panic string
+* Event data 3: third byte of panic string
+See the IPMI spec for the details of the event layout.  This event is
+always sent to the local management controller.  It will handle routing
+the message to the right place
+
+Other OEM events have the following format:
+Record ID (bytes 0-1): Set by the SEL.
+Record type (byte 2): 0xf0 (OEM non-timestamped)
+byte 3: The slave address of the card saving the panic
+byte 4: A sequence number (starting at zero)
+The rest of the bytes (11 bytes) are the panic string.  If the panic string
+is longer than 11 bytes, multiple messages will be sent with increasing
+sequence numbers.
+
+Because you cannot send OEM events using the standard interface, this
+function will attempt to find an SEL and add the events there.  It
+will first query the capabilities of the local management controller.
+If it has an SEL, then they will be stored in the SEL of the local
+management controller.  If not, and the local management controller is
+an event generator, the event receiver from the local management
+controller will be queried and the events sent to the SEL on that
+device.  Otherwise, the events go nowhere since there is nowhere to
+send them.

--------------050804030000070402030506--
