Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274613AbRIVKXW>; Sat, 22 Sep 2001 06:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274685AbRIVKXM>; Sat, 22 Sep 2001 06:23:12 -0400
Received: from [150.101.91.33] ([150.101.91.33]:45071 "EHLO
	gemini.foursticks.com.au") by vger.kernel.org with ESMTP
	id <S274613AbRIVKW4>; Sat, 22 Sep 2001 06:22:56 -0400
To: esr@thyrsus.com
cc: pschulz@foursticks.com, linux-kernel@vger.kernel.org
Subject: Patch for cml2-1.8.2 on 2.4.9
Date: Sat, 22 Sep 2001 19:53:01 +0930
From: Paul Schulz <pschulz@foursticks.com.au>
Message-Id: <E15kjw5-0007b5-00@gemini.foursticks.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ESR, (and the linux-kernel list)

The following is a patch which works around some errors after
cml2-1.8.2 is applied to 2.4.9.  It:

  - removes some errors caused by the bluetooth configuration 
    (needs to be fixed)
  - comments out come IDE lines causing problems
    (needs to be fixed)
  - add lines to Makefile which removes cml files on 'distclean' and '.config' 
    (helped in preparing patch)

There is still the following warning when 'make menuconfig' is run:

"config.out", line 221: bad token `BLK_DEV_ADMA' while expecting symbol.

Paul

-----------------------------------------------------------------------------

diff -aPur linux-2.4.9-cml2/Makefile linux/Makefile
--- linux-2.4.9-cml2/Makefile	Sat Sep 22 17:57:30 2001
+++ linux/Makefile	Sat Sep 22 18:51:13 2001
@@ -416,7 +416,9 @@
 distclean: mrproper
 	rm -f core `find . \( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
-		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f -print` TAGS tags
+		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f -print` TAGS tags \
+		.config config.out rules.out \
+		scripts/cml.pyo scripts/cmlsystem.pyo
 
 backup: mrproper
 	cd .. && tar cf - linux/ | gzip -9 > backup.gz
diff -aPur linux-2.4.9-cml2/drivers/block/rules.cml linux/drivers/block/rules.cml
--- linux-2.4.9-cml2/drivers/block/rules.cml	Sat Sep 22 17:57:30 2001
+++ linux/drivers/block/rules.cml	Sat Sep 22 18:18:55 2001
@@ -15,7 +15,7 @@
 unless ARCH_S390==n suppress BLK_DEV_FD PARIDE
 unless ZORRO suppress BLK_DEV_BUDDHA AMIGA_Z2RAM
 unless ISAPNP==y suppress BLK_DEV_ISAPNP
-unless IDE suppress ide_blockdevs
+#unless IDE suppress ide_blockdevs
 unless PCI suppress BLK_DEV_RZ1000 BLK_DEV_IDEPCI 
 			BLK_CPQ_DA BLK_CPQ_CISS_DA BLK_DEV_DAC960
 unless MCA suppress BLK_DEV_PS2
@@ -26,7 +26,7 @@
 unless CONFIG_8xx suppress BLK_DEV_MPC8xx_IDE
 
 unless NET suppress dependent BLK_DEV_NBD
-unless IDE suppress dependent ide_blockdevs
+#unless IDE suppress dependent ide_blockdevs
 
 
 require DASD_ECKD <= DASD
diff -aPur linux-2.4.9-cml2/net/rules.cml linux/net/rules.cml
--- linux-2.4.9-cml2/net/rules.cml	Sat Sep 22 17:57:30 2001
+++ linux/net/rules.cml	Sat Sep 22 18:17:43 2001
@@ -31,7 +31,7 @@
 	WAN_ROUTER? NET_FASTROUTE NET_HW_FLOWCONTROL
 	NET_SCHED 	{netsched} # NET_PROFILE
 	IRDA?		{irda}
-	BLUEZ? 		{bluetooth}
+#	BLUEZ? 		{bluetooth}
 	NETDEVICES	{net_drivers atm}
 
 # PPP
diff -aPur linux-2.4.9-cml2/rules.cml linux/rules.cml
--- linux-2.4.9-cml2/rules.cml	Sat Sep 22 17:57:30 2001
+++ linux/rules.cml	Sat Sep 22 18:13:47 2001
@@ -23,7 +23,7 @@
 source "net/ipv6/rules.cml"
 source "net/sched/rules.cml"
 source "net/irda/rules.cml"
-source "net/bluetooth/rules.cml"
+#source "net/bluetooth/rules.cml"
 
 source "drivers/net/irda/rules.cml"
 source "drivers/net/rules.cml"
@@ -59,7 +59,7 @@
 source "drivers/ieee1394/rules.cml"
 source "drivers/acpi/rules.cml"
 source "drivers/macintosh/rules.cml"
-source "drivers/net/bluetooth/rules.cml"
+#source "drivers/net/bluetooth/rules.cml"
 
 source "arch/i386/rules.cml"
 source "arch/alpha/rules.cml"
diff -aPur linux-2.4.9-cml2/symbols.cml linux/symbols.cml
--- linux-2.4.9-cml2/symbols.cml	Sat Sep 22 17:57:30 2001
+++ linux/symbols.cml	Sat Sep 22 18:24:08 2001
@@ -14374,15 +14374,15 @@
 #
 # Bluetooth support
 #
-BLUEZ			'Bluetooth subsystem support'
-
-BLUEZ_L2CAP		'L2CAP protocol support'
-
-BLUEZ_HCIUSB		'HCI USB driver'
-
-BLUEZ_HCIUART		'HCI UART driver'
-
-BLUEZ_HCIEMU		'HCI EMU (virtual device) driver'
+#BLUEZ			'Bluetooth subsystem support'
+#
+#BLUEZ_L2CAP		'L2CAP protocol support'
+#
+#BLUEZ_HCIUSB		'HCI USB driver'
+#
+#BLUEZ_HCIUART		'HCI UART driver'#
+#
+#BLUEZ_HCIEMU		'HCI EMU (virtual device) driver'
 
 #
 # Input core
@@ -17825,8 +17825,8 @@
 atm			'ATM drivers'
 ax25			'AX.25 network device drivers'
 block_devices		'Block devices'
-bluetooth		'Bluetooth support'
-bluetooth_drivers	'Blutooth drivers'
+#bluetooth		'Bluetooth support'
+#bluetooth_drivers	'Blutooth drivers'
 buses			'System buses and controller types' text
 Specify the buses, disk controllers, and internal interconnection standards
 that you want your kernel to support.
