Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTKVLsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 06:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTKVLsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 06:48:25 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:26632 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262221AbTKVLsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 06:48:21 -0500
Date: Sat, 22 Nov 2003 12:49:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Christer Weinigel <christer@weinigel.se>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Bernd Schubert <bernd-schubert@web.de>,
       Aschwin Marsman <aschwin@marsman.org>
Subject: [PATCH 2.4] SCx200 config
Message-Id: <20031122124930.4bbae500.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christer, hi all,

As I was working on other I2C stuff, I came across the SCx200 driver
configration options, and it doesn't look correct. I could find three
threads where users (CC'd) are complaining about that:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103960396800992&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=105586728225277&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=106103689410136&w=2

As I understand it, CONFIG_SCx200 and CONFIG_SCx200_GPIO are almost the
same thing in 2.4, since the SCx200 support is limited to GPIO. But
CONFIG_SCx200 doesn't seem to be defined anywhere, while it is
used in various places (Documentation/Configure.help,
drivers/char/Config.in, drivers/i2c/Config.in).

I was about to suggest that we could get rid of CONFIG_SCx200_GPIO
completely, and use CONFIG_SCx200 everywhere, but it looks like some
drivers (drivers/char/scx200_wdt.c, drivers/i2c/scx200_acb.c) need only
scx200.o, not scx200_gpio.o, so we need to really define CONFIG_SCx200
and CONFIG_SCx200_GPIO separately (with the second depending on the
first, of course).

Also, the CONFIG_SCx200_GPIO entry in Documentation/Configure.help looks
like it would apply to CONFIG_SCx200_I2C instead, which has no help text
for now. This means that CONFIG_SCx200_GPIO needs a new help text.

Last, the dependencies for CONFIG_SCx200_ACB seem to be wrong. It
doesn't actually depend on CONFIG_I2C_ALGOBIT (only CONFIG_I2C), so it
should be moved outside of the 'if [ "$CONFIG_I2C_ALGOBIT" != "n" ]'
block. This is indeed the first thing I noticed, then I started digging
and found the other problems.

The following patch fixes it all. I tested that the configration
dependencies behave as intended, and also made sure everything would
still compile (as modules).

Christer (and others), if you could please take a look and confirm that
I got it correctly, I'd send it to Marcelo. Help texts may need
rewording, proposals welcome. Also, we might consider reordering the
options a bit, because for now CONFIG_SCx200 and CONFIG_SCx200_GPIO are
after the I2C and Watchdog menus, where the dependencies on them are.
Having to go back that way might confuse the user.

Comments welcome.

diff -ru linux-2.4.23-rc3/Documentation/Configure.help linux-2.4.23-rc3-k1/Documentation/Configure.help
--- linux-2.4.23-rc3/Documentation/Configure.help	Sat Nov 22 09:09:35 2003
+++ linux-2.4.23-rc3-k1/Documentation/Configure.help	Sat Nov 22 12:32:56 2003
@@ -28113,6 +28113,13 @@
   This support is also available as a module.  If compiled as a
   module, it will be called scx200.o.
 
+NatSemi SCx200 GPIO support
+CONFIG_SCx200_GPIO
+  Enable the use of GPIO pins of a SCx200 processor.
+
+  This support is also available as a module.  If compiled as a
+  module, it will be called scx200_gpio.o.
+
 NatSemi SCx200 Watchdog
 CONFIG_SCx200_WDT
   Enable the built-in watchdog timer support on the National 
@@ -28264,7 +28271,7 @@
   If compiled as a module, it will be called uclinux.o.
 
 NatSemi SCx200 I2C using GPIO pins
-CONFIG_SCx200_GPIO
+CONFIG_SCx200_I2C
   Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
 
   If you don't know what to do here, say N.
diff -ru linux-2.4.23-rc3/drivers/char/Config.in linux-2.4.23-rc3-k1/drivers/char/Config.in
--- linux-2.4.23-rc3/drivers/char/Config.in	Sat Nov 22 09:09:36 2003
+++ linux-2.4.23-rc3-k1/drivers/char/Config.in	Sat Nov 22 12:27:12 2003
@@ -244,7 +244,7 @@
    tristate '  Mixcom Watchdog' CONFIG_MIXCOMWD 
    tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
    dep_tristate '  SC1200 Watchdog Timer (EXPERIMENTAL)' CONFIG_SC1200_WDT $CONFIG_EXPERIMENTAL
-   tristate '  NatSemi SCx200 Watchdog' CONFIG_SCx200_WDT
+   dep_tristate '  NatSemi SCx200 Watchdog' CONFIG_SCx200_WDT $CONFIG_SCx200
    tristate '  Software Watchdog' CONFIG_SOFT_WATCHDOG
    tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
    tristate '  WDT Watchdog timer' CONFIG_WDT
@@ -268,7 +268,8 @@
    fi
    tristate 'NetWinder flash support' CONFIG_NWFLASH
 fi
-dep_tristate 'NatSemi SCx200 GPIO Support' CONFIG_SCx200_GPIO $CONFIG_SCx200
+dep_tristate 'NatSemi SCx200 Support' CONFIG_SCx200
+dep_tristate '  NatSemi SCx200 GPIO Support' CONFIG_SCx200_GPIO $CONFIG_SCx200
 
 if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_SGI_SN2" = "y" ] ; then
    bool 'SGI SN2 fetchop support' CONFIG_FETCHOP
diff -ru linux-2.4.23-rc3/drivers/char/Makefile linux-2.4.23-rc3-k1/drivers/char/Makefile
--- linux-2.4.23-rc3/drivers/char/Makefile	Sat Nov 22 09:09:36 2003
+++ linux-2.4.23-rc3-k1/drivers/char/Makefile	Sat Nov 22 12:17:28 2003
@@ -274,7 +274,8 @@
 obj-$(CONFIG_DZ) += dz.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
-obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o scx200.o
+obj-$(CONFIG_SCx200) += scx200.o
+obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
 
 # Only one watchdog can succeed. We probe the hardware watchdog
 # drivers first, then the softdog driver.  This means if your hardware
diff -ru linux-2.4.23-rc3/drivers/i2c/Config.in linux-2.4.23-rc3-k1/drivers/i2c/Config.in
--- linux-2.4.23-rc3/drivers/i2c/Config.in	Mon Aug 25 13:44:41 2003
+++ linux-2.4.23-rc3-k1/drivers/i2c/Config.in	Sat Nov 22 12:24:52 2003
@@ -13,13 +13,14 @@
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
       dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
-      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_SCx200 $CONFIG_I2C_ALGOBIT
+      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_SCx200_GPIO $CONFIG_I2C_ALGOBIT
       if [ "$CONFIG_SCx200_I2C" != "n" ]; then
          int  '    GPIO pin used for SCL' CONFIG_SCx200_I2C_SCL 12
          int  '    GPIO pin used for SDA' CONFIG_SCx200_I2C_SDA 13
       fi
-      dep_tristate '  NatSemi SCx200 ACCESS.bus' CONFIG_SCx200_ACB $CONFIG_I2C
    fi
+
+   dep_tristate 'NatSemi SCx200 ACCESS.bus' CONFIG_SCx200_ACB $CONFIG_SCx200 $CONFIG_I2C
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOPCF" != "n" ]; then


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
