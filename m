Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUJSGBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUJSGBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUJSGBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:01:48 -0400
Received: from smtp1.ensim.com ([65.164.64.254]:44852 "EHLO smtp1.ensim.com")
	by vger.kernel.org with ESMTP id S267971AbUJSF7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 01:59:55 -0400
From: Borislav Deianov <borislav@users.sourceforge.net>
Date: Mon, 18 Oct 2004 22:59:51 -0700
To: Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
Message-ID: <20041019055951.GI17013@aero.ensim.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 19 Oct 2004 05:59:00.0815 (UTC) FILETIME=[BAE485F0:01C4B5A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This is a Linux ACPI driver for the IBM ThinkPad laptops. It aims to
support various features of these laptops which are accessible through
the ACPI framework but not otherwise supported by the generic Linux
ACPI drivers.

For more information, see http://ibm-acpi.sf.net/

The attached patch is against 2.6.9-rc4-mm1.

Boris

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ibm-acpi-0.6.patch"

diff -Nur linux-2.6.9-rc4-mm1/Documentation/ibm-acpi.txt linux-2.6.9-rc4-mm1-ibm/Documentation/ibm-acpi.txt
--- linux-2.6.9-rc4-mm1/Documentation/ibm-acpi.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.9-rc4-mm1-ibm/Documentation/ibm-acpi.txt	2004-10-18 22:46:54.698292496 -0700
@@ -0,0 +1,474 @@
+		    IBM ThinkPad ACPI Extras Driver
+
+                            Version 0.6
+                          19 October 2004
+
+               Borislav Deianov <borislav@users.sf.net>
+		      http://ibm-acpi.sf.net/
+
+
+This is a Linux ACPI driver for the IBM ThinkPad laptops. It aims to
+support various features of these laptops which are accessible through
+the ACPI framework but not otherwise supported by the generic Linux
+ACPI drivers.
+
+
+Status
+------
+
+The features currently supported are the following (see below for
+detailed description):
+
+	- Fn key combinations
+	- Bluetooth enable and disable
+	- video output switching, expansion control	
+	- ThinkLight on and off
+	- limited docking and undocking
+	- UltraBay eject
+	- Experimental: CMOS control
+	- Experimental: LED control
+	- Experimental: ACPI sounds
+
+A compatibility table by model and feature is maintained on the web
+site, http://ibm-acpi.sf.net/. I appreciate any success or failure
+reports, especially if they add to or correct the compatibility table.
+Please include the following information in your report:
+
+	- ThinkPad model name
+	- a copy of your DSDT, from /proc/acpi/dsdt
+	- which driver features work and which don't
+	- the observed behavior of non-working features
+
+Any other comments or patches are also more than welcome.
+
+
+Installation
+------------
+
+If you are compiling this driver as included in the Linux kernel
+sources, simply enable the CONFIG_ACPI_IBM option (Power Management /
+ACPI / IBM ThinkPad Laptop Extras). The rest of this section describes
+how to install this driver when downloaded from the web site.
+
+First, you need to get a kernel with ACPI support up and running.
+Please refer to http://acpi.sourceforge.net/ for help with this
+step. How successful you will be depends a lot on you ThinkPad model,
+the kernel you are using and any additional patches applied. The
+kernel provided with your distribution may not be good enough. I
+needed to compile a 2.6.7 kernel with the 20040715 ACPI patch to get
+ACPI working reliably on my ThinkPad X40. Old ThinkPad models may not
+be supported at all.
+
+Assuming you have the basic ACPI support working (e.g. you can see the
+/proc/acpi directory), follow the following steps to install this
+driver:
+
+	- unpack the archive:
+
+		tar xzvf ibm-acpi-x.y.tar.gz; cd ibm-acpi-x.y
+
+	- compile the driver:
+
+		make
+
+	- install the module in your kernel modules directory:
+
+		make install
+
+	- load the module:
+
+		modprobe ibm_acpi
+
+After loading the module, check the "dmesg" output for any error messages.
+
+
+Features
+--------
+
+The driver creates the /proc/acpi/ibm directory. There is a file under
+that directory for each feature described below. Note that while the
+driver is still in the alpha stage, the exact proc file format and
+commands supported by the various features is guaranteed to change
+frequently.
+
+Driver Version -- /proc/acpi/ibm/driver
+--------------------------------------
+
+The driver name and version. No commands can be written to this file.
+
+Hot Keys -- /proc/acpi/ibm/hotkey
+---------------------------------
+
+Without this driver, only the Fn-F4 key (sleep button) generates an
+ACPI event. With the driver loaded, the hotkey feature enabled and the
+mask set (see below), the various hot keys generate ACPI events in the
+following format:
+
+	ibm/hotkey HKEY 00000080 0000xxxx
+
+The last four digits vary depending on the key combination pressed.
+All labeled Fn-Fx key combinations generate distinct events. In
+addition, the lid microswitch and some docking station buttons may
+also generate such events.
+
+The following commands can be written to this file:
+
+	echo enable > /proc/acpi/ibm/hotkey -- enable the hot keys feature
+	echo disable > /proc/acpi/ibm/hotkey -- disable the hot keys feature
+	echo 0xffff > /proc/acpi/ibm/hotkey -- enable all possible hot keys
+	echo 0x0000 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
+	... any other 4-hex-digit mask ...
+	echo reset > /proc/acpi/ibm/hotkey -- restore the original mask
+
+The bit mask allows some control over which hot keys generate ACPI
+events. Not all bits in the mask can be modified. Not all bits that
+can be modified do anything. Not all hot keys can be individually
+controlled by the mask. Most recent ThinkPad models honor the
+following bits (assuming the hot keys feature has been enabled):
+
+	key	bit	behavior when set	behavior when unset
+
+	Fn-F3			always generates ACPI event
+	Fn-F4			always generates ACPI event
+	Fn-F5	0010	generate ACPI event	enable/disable Bluetooth
+	Fn-F7	0040	generate ACPI event	switch LCD and external display
+	Fn-F8	0080	generate ACPI event	expand screen or none
+	Fn-F9	0100	generate ACPI event	none
+	Fn-F12			always generates ACPI event
+
+Some models do not support all of the above. For example, the T30 does
+not support Fn-F5 and Fn-F9. Other models do not support the mask at
+all. On those models, hot keys cannot be controlled individually.
+
+Note that enabling ACPI events for some keys prevents their default
+behavior. For example, if events for Fn-F5 are enabled, that key will
+no longer enable/disable Bluetooth by itself. This can still be done
+from an acpid handler for the ibm/hotkey event.
+
+Note also that not all Fn key combinations are supported through
+ACPI. For example, on the X40, the brightness, volume and "Access IBM"
+buttons do not generate ACPI events even with this driver. They *can*
+be used through the "ThinkPad Buttons" utility, see
+http://www.nongnu.org/tpb/
+
+Bluetooth -- /proc/acpi/ibm/bluetooth
+-------------------------------------
+
+This feature shows the presence and current state of a Bluetooth
+device. If Bluetooth is installed, the following commands can be used:
+
+	echo enable > /proc/acpi/ibm/bluetooth
+	echo disable > /proc/acpi/ibm/bluetooth
+
+Video output control -- /proc/acpi/ibm/video
+--------------------------------------------
+
+This feature allows control over the devices used for video output -
+LCD, CRT or DVI (if available). The following commands are available:
+
+	echo lcd_enable > /proc/acpi/ibm/video
+	echo lcd_disable > /proc/acpi/ibm/video
+	echo crt_enable > /proc/acpi/ibm/video
+	echo crt_disable > /proc/acpi/ibm/video
+	echo dvi_enable > /proc/acpi/ibm/video
+	echo dvi_disable > /proc/acpi/ibm/video
+	echo auto_enable > /proc/acpi/ibm/video
+	echo auto_disable > /proc/acpi/ibm/video
+	echo expand_toggle > /proc/acpi/ibm/video
+	echo video_switch > /proc/acpi/ibm/video
+
+Each video output device can be enabled or disabled individually.
+Reading /proc/acpi/ibm/video shows the status of each device.
+
+Automatic video switching can be enabled or disabled.  When automatic
+video switching is enabled, certain events (e.g. opening the lid,
+docking or undocking) cause the video output device to change
+automatically. While this can be useful, it also causes flickering
+and, on the X40, video corruption. By disabling automatic switching,
+the flickering or video corruption can be avoided.
+
+The video_switch command cycles through the available video outputs
+(it sumulates the behavior of Fn-F7).
+
+Video expansion can be toggled through this feature. This controls
+whether the display is expanded to fill the entire LCD screen when a
+mode with less than full resolution is used. Note that the current
+video expansion status cannot be determined through this feature.
+
+Note that on many models (particularly those using Radeon graphics
+chips) the X driver configures the video card in a way which prevents
+Fn-F7 from working. This also disables the video output switching
+features of this driver, as it uses the same ACPI methods as
+Fn-F7. Video switching on the console should still work.
+
+ThinkLight control -- /proc/acpi/ibm/light
+------------------------------------------
+
+The current status of the ThinkLight can be found in this file. A few
+models which do not make the status available will show it as
+"unknown". The available commands are:
+
+	echo on  > /proc/acpi/ibm/light
+	echo off > /proc/acpi/ibm/light
+
+Docking / Undocking -- /proc/acpi/ibm/dock
+------------------------------------------
+
+Docking and undocking (e.g. with the X4 UltraBase) requires some
+actions to be taken by the operating system to safely make or break
+the electrical connections with the dock.
+
+The docking feature of this driver generates the following ACPI events:
+
+	ibm/dock GDCK 00000003 00000001 -- eject request
+	ibm/dock GDCK 00000003 00000002 -- undocked
+	ibm/dock GDCK 00000000 00000003 -- docked
+
+NOTE: These events will only be generated if the laptop was docked
+when originally booted. This is due to the current lack of support for
+hot plugging of devices in the Linux ACPI framework. If the laptop was
+booted while not in the dock, the following message is shown in the
+logs: "ibm_acpi: dock device not present". No dock-related events are
+generated but the dock and undock commands described below still
+work. They can be executed manually or triggered by Fn key
+combinations (see the example acpid configuration files included in
+the driver tarball package available on the web site).
+
+When the eject request button on the dock is pressed, the first event
+above is generated. The handler for this event should issue the
+following command:
+
+	echo undock > /proc/acpi/ibm/dock
+
+After the LED on the dock goes off, it is safe to eject the laptop.
+Note: if you pressed this key by mistake, go ahead and eject the
+laptop, then dock it back in. Otherwise, the dock may not function as
+expected.
+
+When the laptop is docked, the third event above is generated. The
+handler for this event should issue the following command to fully
+enable the dock:
+
+	echo dock > /proc/acpi/ibm/dock
+
+The contents of the /proc/acpi/ibm/dock file shows the current status
+of the dock, as provided by the ACPI framework.
+
+The docking support in this driver does not take care of enabling or
+disabling any other devices you may have attached to the dock. For
+example, a CD drive plugged into the UltraBase needs to be disabled or
+enabled separately. See the provided example acpid configuration files
+for how this can be accomplished.
+
+There is no support yet for PCI devices that may be attached to a
+docking station, e.g. in the ThinkPad Dock II. The driver currently
+does not recognize, enable or disable such devices. This means that
+the only docking stations currently supported are the X-series
+UltraBase docks and "dumb" port replicators like the Mini Dock (the
+latter don't need any ACPI support, actually).
+
+UltraBay Eject -- /proc/acpi/ibm/bay
+------------------------------------
+
+Inserting or ejecting an UltraBay device requires some actions to be
+taken by the operating system to safely make or break the electrical
+connections with the device.
+
+This feature generates the following ACPI events:
+
+	ibm/bay MSTR 00000003 00000000 -- eject request
+	ibm/bay MSTR 00000001 00000000 -- eject lever inserted
+
+NOTE: These events will only be generated if the UltraBay was present
+when the laptop was originally booted (on the X series, the UltraBay
+is in the dock, so it may not be present if the laptop was undocked).
+This is due to the current lack of support for hot plugging of devices
+in the Linux ACPI framework. If the laptop was booted without the
+UltraBay, the following message is shown in the logs: "ibm_acpi: bay
+device not present". No bay-related events are generated but the eject
+command described below still works. It can be executed manually or
+triggered by a hot key combination.
+
+Sliding the eject lever generates the first event shown above. The
+handler for this event should take whatever actions are necessary to
+shut down the device in the UltraBay (e.g. call idectl), then issue
+the following command:
+
+	echo eject > /proc/acpi/ibm/bay
+
+After the LED on the UltraBay goes off, it is safe to pull out the
+device.
+
+When the eject lever is inserted, the second event above is
+generated. The handler for this event should take whatever actions are
+necessary to enable the UltraBay device (e.g. call idectl).
+
+The contents of the /proc/acpi/ibm/bay file shows the current status
+of the UltraBay, as provided by the ACPI framework.
+
+Experimental Features
+---------------------
+
+The following features are marked experimental because using them
+involves guessing the correct values of some parameters. Guessing
+incorrectly may have undesirable effects like crashing your
+ThinkPad. USE THESE WITH CAUTION! To activate them, you'll need to
+supply the experimental=1 parameter when loading the module.
+
+Experimental: CMOS control - /proc/acpi/ibm/cmos
+------------------------------------------------
+
+This feature is used internally by the ACPI firmware to control the
+ThinkLight on most newer ThinkPad models. It appears that it can also
+control LCD brightness, sounds volume and more, but only on some
+models.
+
+The commands are non-negative integer numbers:
+
+	echo 0 >/proc/acpi/ibm/cmos
+	echo 1 >/proc/acpi/ibm/cmos
+	echo 2 >/proc/acpi/ibm/cmos
+	...
+
+The range of numbers which are used internally by various models is 0
+to 21, but it's possible that numbers outside this range have
+interesting behavior. Here is the behavior on the X40 (tpb is the
+ThinkPad Buttons utility):
+
+	0 - no effect but tpb reports "Volume down"
+	1 - no effect but tpb reports "Volume up"
+	2 - no effect but tpb reports "Mute on"
+	3 - simulate pressing the "Access IBM" button
+	4 - LCD brightness up
+	5 - LCD brightness down
+	11 - toggle screen expansion
+	12 - ThinkLight on
+	13 - ThinkLight off
+	14 - no effect but tpb reports ThinkLight status change
+
+If you try this feature, please send me a report similar to the
+above. On models which allow control of LCD brightness or sound
+volume, I'd like to provide this functionality in an user-friendly
+way, but first I need a way to identify the models which this is
+possible.
+
+Experimental: LED control - /proc/acpi/ibm/LED
+----------------------------------------------
+
+Some of the LED indicators can be controlled through this feature. The
+available commands are:
+
+	echo <led number> on >/proc/acpi/ibm/led
+	echo <led number> off >/proc/acpi/ibm/led
+	echo <led number> blink >/proc/acpi/ibm/led
+
+The <led number> parameter is a non-negative integer. The range of LED
+numbers used internally by various models is 0 to 7 but it's possible
+that numbers outside this range are also valid. Here is the mapping on
+the X40:
+
+	0 - power
+	1 - battery (orange)
+	2 - battery (green)
+	3 - UltraBase dock
+	4 - UltraBay (in dock)
+	7 - standby
+
+All of the above can be turned on and off and can be made to blink.
+
+If you try this feature, please send me a report similar to the
+above. I'd like to provide this functionality in an user-friendly way,
+but first I need to identify the which numbers correspond to which
+LEDs on various models.
+
+Experimental: ACPI sounds - /proc/acpi/ibm/beep
+-----------------------------------------------
+
+The BEEP method is used internally by the ACPI firmware to provide
+audible alerts in various situtation. This feature allows the same
+sounds to be triggered manually.
+
+The commands are non-negative integer numbers:
+
+	echo 0 >/proc/acpi/ibm/beep
+	echo 1 >/proc/acpi/ibm/beep
+	echo 2 >/proc/acpi/ibm/beep
+	...
+
+The range of numbers which are used internally by various models is 0
+to 17, but it's possible that numbers outside this range are also
+valid. Here is the behavior on the X40:
+
+	2 - two beeps, pause, third beep
+	3 - single beep
+	4 - "unable"	
+	5 - single beep
+	6 - "AC/DC"
+	7 - high-pitched beep
+	9 - three short beeps
+	10 - very long beep
+	12 - low-pitched beep
+
+(I've only been able to identify a couple of them).
+
+If you try this feature, please send me a report similar to the
+above. I'd like to provide this functionality in an user-friendly way,
+but first I need to identify the which numbers correspond to which
+sounds on various models.
+
+
+Multiple Command, Module Parameters
+-----------------------------------
+
+Multiple commands can be written to the proc files in one shot by
+separating them with commas, for example:
+
+	echo enable,0xffff > /proc/acpi/ibm/hotkey
+	echo lcd_disable,crt_enable > /proc/acpi/ibm/video
+
+Commands can also be specified when loading the ibm_acpi module, for
+example:
+
+	modprobe ibm_acpi hotkey=enable,0xffff video=auto_disable
+
+
+Example Configuration
+---------------------
+
+The ACPI support in the kernel is intended to be used in conjunction
+with a user-space daemon, acpid. The configuration files for this
+daemon control what actions are taken in response to various ACPI
+events. An example set of configuration files are included in the
+config/ directory of the tarball package available on the web
+site. Note that these are provided for illustration purposes only and
+may need to be adapted to your particular setup.
+
+The following utility scripts are used by the example action
+scripts (included with ibm-acpi for completeness):
+
+	/usr/local/sbin/idectl -- from the hdparm source distribution,
+		see http://www.ibiblio.org/pub/Linux/system/hardware
+	/usr/local/sbin/laptop_mode -- from the Linux kernel source
+		distribution, see Documentation/laptop-mode.txt
+	/sbin/service -- comes with Redhat/Fedora distributions
+
+Toan T Nguyen <ntt@control.uchicago.edu> has written a SuSE powersave
+script for the X20, included in config/usr/sbin/ibm_hotkeys_X20
+
+Henrik Brix Andersen <brix@gentoo.org> has written a Gentoo ACPI event
+handler script for the X31. You can get the latest version from
+http://dev.gentoo.org/~brix/files/x31.sh
+
+David Schweikert <dws@ee.eth.ch> has written an alternative blank.sh
+script which works on Debian systems, included in
+configs/etc/acpi/actions/blank-debian.sh
+
+
+TODO
+----
+
+I'd like to implement the following features but haven't yet found the
+time and/or I don't yet know how to implement them:
+
+- UltraBay floppy drive support
+
diff -Nur linux-2.6.9-rc4-mm1/drivers/acpi/ibm_acpi.c linux-2.6.9-rc4-mm1-ibm/drivers/acpi/ibm_acpi.c
--- linux-2.6.9-rc4-mm1/drivers/acpi/ibm_acpi.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.9-rc4-mm1-ibm/drivers/acpi/ibm_acpi.c	2004-10-18 22:21:21.000000000 -0700
@@ -0,0 +1,1240 @@
+/*
+ *  ibm_acpi.c - IBM ThinkPad ACPI Extras
+ *
+ *
+ *  Copyright (C) 2004 Borislav Deianov
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Changelog:
+ *
+ *  2004-08-09	0.1	initial release, support for X series
+ *  2004-08-14	0.2	support for T series, X20
+ *			bluetooth enable/disable
+ *			hotkey events disabled by default
+ *			removed fan control, currently useless
+ *  2004-08-17	0.3	support for R40
+ *			lcd off, brightness control
+ *			thinklight on/off
+ *  2004-09-16	0.4	support for module parameters
+ *			hotkey mask can be prefixed by 0x
+ *			video output switching
+ *			video expansion control
+ *			ultrabay eject support
+ *			removed lcd brightness/on/off control, didn't work
+ *  2004-10-18	0.5	thinklight support on A21e, G40, R32, T20, T21, X20
+ *			proc file format changed
+ *			video_switch command
+ *			experimental cmos control
+ *			experimental led control
+ *			experimental acpi sounds
+ *  2004-10-19	0.6	use acpi_bus_register_driver() to claim HKEY device
+ */
+
+#define IBM_VERSION "0.6"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+
+#include <acpi/acpi_drivers.h>
+#include <acpi/acnamesp.h>
+
+#define IBM_NAME "ibm"
+#define IBM_DESC "IBM ThinkPad ACPI Extras"
+#define IBM_FILE "ibm_acpi"
+#define IBM_URL "http://ibm-acpi.sf.net/"
+
+#define IBM_DIR IBM_NAME
+#define IBM_CLASS IBM_NAME
+
+#define IBM_LOG IBM_FILE ": "
+#define IBM_ERR	   KERN_ERR    IBM_LOG
+#define IBM_NOTICE KERN_NOTICE IBM_LOG
+#define IBM_INFO   KERN_INFO   IBM_LOG
+#define IBM_DEBUG  KERN_DEBUG  IBM_LOG
+
+#define IBM_MAX_ACPI_ARGS 3
+
+#define __unused __attribute__ ((unused))
+
+static int experimental;
+module_param(experimental, int, 0);
+
+static acpi_handle root_handle = NULL;
+
+#define IBM_HANDLE(object, parent, paths...)			\
+	static acpi_handle  object##_handle;			\
+	static acpi_handle *object##_parent = &parent##_handle;	\
+	static char        *object##_paths[] = { paths }
+
+IBM_HANDLE(ec, root,
+	   "\\_SB.PCI0.ISA.EC",    /* A21e, T20, T21, X20 */
+	   "\\_SB.PCI0.LPC.EC",    /* all others */
+);
+
+IBM_HANDLE(vid, root, 
+	   "\\_SB.PCI0.VID",       /* A21e, G40, X30, X40 */
+	   "\\_SB.PCI0.AGP.VID",   /* all others */
+);
+
+IBM_HANDLE(cmos, root,
+	   "\\UCMS",               /* R50, R50p, R51, T4x, X31, X40 */
+	   "\\CMOS",               /* A3x, G40, R32, T23, T30, X22, X24, X30 */
+	   "\\CMS",                /* R40, R40e */
+);
+
+IBM_HANDLE(dock, root,
+	   "\\_SB.GDCK",           /* X30, X31, X40 */
+	   "\\_SB.PCI0.DOCK",      /* T20, T21, X20 */
+	   "\\_SB.PCI0.PCI1.DOCK", /* all others */
+);                                 /* A21e, G40, R32, R40, R40e */
+
+IBM_HANDLE(bay, root,
+	   "\\_SB.PCI0.IDE0.SCND.MSTR");      /* all except A21e */
+IBM_HANDLE(bayej, root,
+	   "\\_SB.PCI0.IDE0.SCND.MSTR._EJ0"); /* all except A21e, A31, A31p */
+
+IBM_HANDLE(lght, root, "\\LGHT");  /* A21e, T20, T21, X20 */
+IBM_HANDLE(hkey, ec,   "HKEY");    /* all */
+IBM_HANDLE(led,  ec,   "LED");     /* all except A21e, T20, T21, X20 */
+IBM_HANDLE(sysl, ec,   "SYSL");    /* A21e, T20, T21, X20 */
+IBM_HANDLE(bled, ec,   "BLED");    /* T20, T21, X20 */
+IBM_HANDLE(beep, ec,   "BEEP");    /* all models */
+
+struct ibm_struct {
+	char *name;
+
+	char *hid;
+	struct acpi_driver *driver;
+	
+	int  (*init)   (struct ibm_struct *);
+	int  (*read)   (struct ibm_struct *, char *);
+	int  (*write)  (struct ibm_struct *, char *);
+	void (*exit)   (struct ibm_struct *);
+
+	void (*notify) (struct ibm_struct *, u32);	
+	acpi_handle *handle;
+	int type;
+	struct acpi_device *device;
+
+	int driver_registered;
+	int proc_created;
+	int init_called;
+	int notify_installed;
+
+	int supported;
+	union {
+		struct {
+			int status;
+			int mask;
+		} hotkey;
+		struct {
+			int autoswitch;
+		} video;
+	} state;
+
+	int experimental;
+};
+
+struct proc_dir_entry *proc_dir = NULL;
+
+#define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
+#define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
+#define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
+
+static int acpi_evalf(acpi_handle handle,
+		      void *res, char *method, char *fmt, ...)
+{
+	char *fmt0 = fmt;
+        struct acpi_object_list	params;
+        union acpi_object	in_objs[IBM_MAX_ACPI_ARGS];
+        struct acpi_buffer	result;
+        union acpi_object	out_obj;
+        acpi_status		status;
+	va_list			ap;
+	char			res_type;
+	int			success;
+	int			quiet;
+
+	if (!*fmt) {
+		printk(IBM_ERR "acpi_evalf() called with empty format\n");
+		return 0;
+	}
+
+	if (*fmt == 'q') {
+		quiet = 1;
+		fmt++;
+	} else
+		quiet = 0;
+
+	res_type = *(fmt++);
+
+	params.count = 0;
+	params.pointer = &in_objs[0];
+
+	va_start(ap, fmt);
+	while (*fmt) {
+		char c = *(fmt++);
+		switch (c) {
+		case 'd':	/* int */
+			in_objs[params.count].integer.value = va_arg(ap, int);
+			in_objs[params.count++].type = ACPI_TYPE_INTEGER;
+			break;
+		/* add more types as needed */
+		default:
+			printk(IBM_ERR "acpi_evalf() called "
+			       "with invalid format character '%c'\n", c);
+			return 0;
+		}
+	}
+	va_end(ap);
+
+	result.length = sizeof(out_obj);
+	result.pointer = &out_obj;
+
+	status = acpi_evaluate_object(handle, method, &params, &result);
+
+	switch (res_type) {
+	case 'd':	/* int */
+		if (res)
+			*(int *)res = out_obj.integer.value;
+		success = status == AE_OK && out_obj.type == ACPI_TYPE_INTEGER;
+		break;
+	case 'v':	/* void */
+		success = status == AE_OK;
+		break;
+	/* add more types as needed */
+	default:
+		printk(IBM_ERR "acpi_evalf() called "
+		       "with invalid format character '%c'\n", res_type);
+		return 0;
+	}
+
+	if (!success && !quiet)
+		printk(IBM_ERR "acpi_evalf(%s, %s, ...) failed: %d\n",
+		       method, fmt0, status);
+
+	return success;
+}
+
+static void __unused acpi_print_int(acpi_handle handle, char *method)
+{
+	int i;
+
+	if (acpi_evalf(handle, &i, method, "d"))
+		printk(IBM_INFO "%s = 0x%x\n", method, i);
+	else
+		printk(IBM_ERR "error calling %s\n", method);
+}
+
+static char *next_cmd(char **cmds)
+{
+	char *start = *cmds;
+	char *end;
+
+	while ((end = strchr(start, ',')) && end == start)
+		start = end + 1;
+
+	if (!end)
+		return NULL;
+
+	*end = 0;
+	*cmds = end + 1;
+	return start;
+}
+
+static int driver_init(struct ibm_struct *ibm)
+{
+	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
+	printk(IBM_INFO "%s\n", IBM_URL);
+
+	return 0;
+}
+
+static int driver_read(struct ibm_struct *ibm, char *p)
+{
+	int len = 0;
+
+	len += sprintf(p + len, "driver:\t\t%s\n", IBM_DESC);
+	len += sprintf(p + len, "version:\t%s\n", IBM_VERSION);
+
+	return len;
+}
+
+static int hotkey_get(struct ibm_struct *ibm, int *status, int *mask)
+{
+	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
+		return -EIO;
+	if (ibm->supported) {
+		if (!acpi_evalf(hkey_handle, mask, "DHKN", "qd"))
+			return -EIO;
+	} else {
+		*mask = ibm->state.hotkey.mask;
+	}
+	return 0;
+}
+
+static int hotkey_set(struct ibm_struct *ibm, int status, int mask)
+{
+	int i;
+
+	if (!acpi_evalf(hkey_handle, NULL, "MHKC", "vd", status))
+		return -EIO;
+
+	if (!ibm->supported)
+		return 0;
+
+	for (i=0; i<32; i++) {
+		int bit = ((1 << i) & mask) != 0;
+		if (!acpi_evalf(hkey_handle, NULL, "MHKM", "vdd", i+1, bit))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int hotkey_init(struct ibm_struct *ibm)
+{
+	int ret;
+
+	ibm->supported = 1;
+	ret = hotkey_get(ibm,
+			 &ibm->state.hotkey.status,
+			 &ibm->state.hotkey.mask);
+	if (ret < 0) {
+		/* mask not supported on A21e, T20, T21, X20, X22, X24 */
+		ibm->supported = 0;
+		ret = hotkey_get(ibm,
+				 &ibm->state.hotkey.status,
+				 &ibm->state.hotkey.mask);
+	}
+
+	return ret;
+}	
+
+static int hotkey_read(struct ibm_struct *ibm, char *p)
+{
+	int status, mask;
+	int len = 0;
+
+	if (hotkey_get(ibm, &status, &mask) < 0)
+		return -EIO;
+
+	len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 0));
+	if (ibm->supported) {
+		len += sprintf(p + len, "mask:\t\t0x%04x\n", mask);
+		len += sprintf(p + len,
+			       "commands:\tenable, disable, reset, <mask>\n");
+	} else {
+		len += sprintf(p + len, "mask:\t\tnot supported\n");
+		len += sprintf(p + len, "commands:\tenable, disable, reset\n");
+	}
+
+	return len;
+}
+
+static int hotkey_write(struct ibm_struct *ibm, char *buf)
+{
+	int status, mask;
+	char *cmd;
+	int do_cmd = 0;
+
+	if (hotkey_get(ibm, &status, &mask) < 0)
+		return -ENODEV;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (strlencmp(cmd, "enable") == 0) {
+			status = 1;
+		} else if (strlencmp(cmd, "disable") == 0) {
+			status = 0;
+		} else if (strlencmp(cmd, "reset") == 0) {
+			status = ibm->state.hotkey.status;
+			mask   = ibm->state.hotkey.mask;
+		} else if (sscanf(cmd, "0x%x", &mask) == 1) {
+			/* mask set */
+		} else if (sscanf(cmd, "%x", &mask) == 1) {
+			/* mask set */
+		} else
+			return -EINVAL;
+		do_cmd = 1;
+	}
+
+	if (do_cmd && hotkey_set(ibm, status, mask) < 0)
+		return -EIO;
+
+	return 0;
+}	
+
+static void hotkey_exit(struct ibm_struct *ibm)
+{
+	hotkey_set(ibm, ibm->state.hotkey.status, ibm->state.hotkey.mask);
+}
+
+static void hotkey_notify(struct ibm_struct *ibm, u32 event)
+{
+	int hkey;
+
+	if (acpi_evalf(hkey_handle, &hkey, "MHKP", "d"))
+		acpi_bus_generate_event(ibm->device, event, hkey);
+	else {
+		printk(IBM_ERR "unknown hotkey event %d\n", event);
+		acpi_bus_generate_event(ibm->device, event, 0);
+	}	
+}
+
+static int bluetooth_init(struct ibm_struct *ibm)
+{
+	/* bluetooth not supported on A21e, G40, T20, T21, X20 */
+	ibm->supported = acpi_evalf(hkey_handle, NULL, "GBDC", "qv");
+
+	return 0;
+}
+
+static int bluetooth_status(struct ibm_struct *ibm)
+{
+	int status;
+
+	if (!ibm->supported || !acpi_evalf(hkey_handle, &status, "GBDC", "d"))
+		status = 0;
+
+	return status;
+}
+
+static int bluetooth_read(struct ibm_struct *ibm, char *p)
+{
+	int len = 0;
+	int status = bluetooth_status(ibm);
+
+	if (!ibm->supported)
+		len += sprintf(p + len, "status:\t\tnot supported\n");
+	else if (!(status & 1))
+		len += sprintf(p + len, "status:\t\tnot installed\n");
+	else {
+		len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 1));
+		len += sprintf(p + len, "commands:\tenable, disable\n");
+	}
+
+	return len;
+}
+
+static int bluetooth_write(struct ibm_struct *ibm, char *buf)
+{
+	int status = bluetooth_status(ibm);
+	char *cmd;
+	int do_cmd = 0;
+
+	if (!ibm->supported)
+		return -EINVAL;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (strlencmp(cmd, "enable") == 0) {
+			status |= 2;
+		} else if (strlencmp(cmd, "disable") == 0) {
+			status &= ~2;
+		} else
+			return -EINVAL;
+		do_cmd = 1;
+	}
+
+	if (do_cmd && !acpi_evalf(hkey_handle, NULL, "SBDC", "vd", status))
+	    return -EIO;
+
+	return 0;
+}
+
+static int video_init(struct ibm_struct *ibm)
+{
+	if (!acpi_evalf(vid_handle,
+			&ibm->state.video.autoswitch, "^VDEE", "d"))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int video_status(struct ibm_struct *ibm)
+{
+	int status = 0;
+	int i;
+
+	acpi_evalf(NULL, NULL, "\\VUPS", "vd", 1);
+	if (acpi_evalf(NULL, &i, "\\VCDC", "d"))
+		status |= 0x02 * i;
+
+	acpi_evalf(NULL, NULL, "\\VUPS", "vd", 0);
+	if (acpi_evalf(NULL, &i, "\\VCDL", "d"))
+		status |= 0x01 * i;
+	if (acpi_evalf(NULL, &i, "\\VCDD", "d"))
+		status |= 0x08 * i;
+
+	if (acpi_evalf(vid_handle, &i, "^VDEE", "d"))
+		status |= 0x10 * (i & 1);
+
+	return status;
+}
+
+static int video_read(struct ibm_struct *ibm, char *p)
+{
+	int status = video_status(ibm);
+	int len = 0;
+
+	len += sprintf(p + len, "lcd:\t\t%s\n", enabled(status, 0));
+	len += sprintf(p + len, "crt:\t\t%s\n", enabled(status, 1));
+	len += sprintf(p + len, "dvi:\t\t%s\n", enabled(status, 3));
+	len += sprintf(p + len, "auto:\t\t%s\n", enabled(status, 4));
+	len += sprintf(p + len, "commands:\tlcd_enable, lcd_disable, "
+		       "crt_enable, crt_disable\n");
+	len += sprintf(p + len, "commands:\tdvi_enable, dvi_disable, "
+		       "auto_enable, auto_disable\n");
+	len += sprintf(p + len, "commands:\tvideo_switch, expand_toggle\n");
+
+	return len;
+}
+
+static int video_write(struct ibm_struct *ibm, char *buf)
+{
+	char *cmd;
+	int enable, disable, status;
+
+	enable = disable = 0;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (strlencmp(cmd, "lcd_enable") == 0) {
+			enable |= 0x01;
+		} else if (strlencmp(cmd, "lcd_disable") == 0) {
+			disable |= 0x01;
+		} else if (strlencmp(cmd, "crt_enable") == 0) {
+			enable |= 0x02;
+		} else if (strlencmp(cmd, "crt_disable") == 0) {
+			disable |= 0x02;
+		} else if (strlencmp(cmd, "dvi_enable") == 0) {
+			enable |= 0x08;
+		} else if (strlencmp(cmd, "dvi_disable") == 0) {
+			disable |= 0x08;
+		} else if (strlencmp(cmd, "auto_enable") == 0) {
+			if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 1))
+				return -EIO;
+		} else if (strlencmp(cmd, "auto_disable") == 0) {
+			if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 0))
+				return -EIO;
+		} else if (strlencmp(cmd, "video_switch") == 0) {
+			int autoswitch;
+			if (!acpi_evalf(vid_handle, &autoswitch, "^VDEE", "d"))
+				return -EIO;
+			if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd", 1))
+				return -EIO;
+			if (!acpi_evalf(vid_handle, NULL, "VSWT", "v"))
+				return -EIO;
+			if (!acpi_evalf(vid_handle, NULL, "_DOS", "vd",
+					autoswitch))
+				return -EIO;
+		} else if (strlencmp(cmd, "expand_toggle") == 0) {
+			if (!acpi_evalf(NULL, NULL, "\\VEXP", "v"))
+				return -EIO;
+		} else
+			return -EINVAL;
+	}
+
+	if (enable || disable) {
+		status = (video_status(ibm) & 0x0f & ~disable) | enable;
+		if (!acpi_evalf(NULL, NULL, "\\VUPS", "vd", 0x80))
+			return -EIO;
+		if (!acpi_evalf(NULL, NULL, "\\VSDS", "vdd", status, 1))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static void video_exit(struct ibm_struct *ibm)
+{
+	acpi_evalf(vid_handle, NULL, "_DOS", "vd",
+		   ibm->state.video.autoswitch);
+}
+
+static int light_init(struct ibm_struct *ibm)
+{
+	/* kblt not supported on G40, R32, X20 */
+	ibm->supported = acpi_evalf(ec_handle, NULL, "KBLT", "qv");
+
+	return 0;
+}
+
+static int light_read(struct ibm_struct *ibm, char *p)
+{
+	int len = 0;
+	int status = 0;
+
+	if (ibm->supported) {
+		if (!acpi_evalf(ec_handle, &status, "KBLT", "d"))
+			return -EIO;
+		len += sprintf(p + len, "status:\t\t%s\n", onoff(status, 0));
+	} else
+		len += sprintf(p + len, "status:\t\tunknown\n");
+
+	len += sprintf(p + len, "commands:\ton, off\n");
+
+	return len;
+}
+
+static int light_write(struct ibm_struct *ibm, char *buf)
+{
+	int cmos_cmd, lght_cmd;
+	char *cmd;
+	int success;
+	
+	while ((cmd = next_cmd(&buf))) {
+		if (strlencmp(cmd, "on") == 0) {
+			cmos_cmd = 0x0c;
+			lght_cmd = 1;
+		} else if (strlencmp(cmd, "off") == 0) {
+			cmos_cmd = 0x0d;
+			lght_cmd = 0;
+		} else
+			return -EINVAL;
+		
+		success = cmos_handle ?
+			acpi_evalf(cmos_handle, NULL, NULL, "vd", cmos_cmd) :
+			acpi_evalf(lght_handle, NULL, NULL, "vd", lght_cmd);
+		if (!success)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int _sta(acpi_handle handle)
+{
+	int status;
+
+	if (!handle || !acpi_evalf(handle, &status, "_STA", "d"))
+		status = 0;
+
+	return status;
+}
+
+#define dock_docked() (_sta(dock_handle) & 1)
+
+static int dock_read(struct ibm_struct *ibm, char *p)
+{
+	int len = 0;
+	int docked = dock_docked();
+
+	if (!dock_handle)
+		len += sprintf(p + len, "status:\t\tnot supported\n");
+	else if (!docked)
+		len += sprintf(p + len, "status:\t\tundocked\n");
+	else {
+		len += sprintf(p + len, "status:\t\tdocked\n");
+		len += sprintf(p + len, "commands:\tdock, undock\n");
+	}
+
+	return len;
+}
+
+static int dock_write(struct ibm_struct *ibm, char *buf)
+{
+	char *cmd;
+
+	if (!dock_docked())
+		return -EINVAL;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (strlencmp(cmd, "undock") == 0) {
+			if (!acpi_evalf(dock_handle, NULL, "_DCK", "vd", 0))
+				return -EIO;
+			if (!acpi_evalf(dock_handle, NULL, "_EJ0", "vd", 1))
+				return -EIO;
+		} else if (strlencmp(cmd, "dock") == 0) {
+			if (!acpi_evalf(dock_handle, NULL, "_DCK", "vd", 1))
+				return -EIO;
+		} else
+			return -EINVAL;
+	}
+
+	return 0;
+}	
+
+static void dock_notify(struct ibm_struct *ibm, u32 event)
+{
+	int docked = dock_docked();
+
+	if (event == 3 && docked)
+		acpi_bus_generate_event(ibm->device, event, 1); /* button */
+	else if (event == 3 && !docked)
+		acpi_bus_generate_event(ibm->device, event, 2); /* undock */
+	else if (event == 0 && docked)
+		acpi_bus_generate_event(ibm->device, event, 3); /* dock */
+	else {
+		printk(IBM_ERR "unknown dock event %d, status %d\n",
+		       event, _sta(dock_handle));
+		acpi_bus_generate_event(ibm->device, event, 0); /* unknown */
+	}
+}
+
+#define bay_occupied() (_sta(bay_handle) & 1)
+
+static int bay_init(struct ibm_struct *ibm)
+{
+	/* bay not supported on A21e, G40, R32, R40e */
+	ibm->supported = bay_handle && bayej_handle &&
+		acpi_evalf(bay_handle, NULL, "_STA", "qv");
+
+	return 0;
+}
+
+static int bay_read(struct ibm_struct *ibm, char *p)
+{
+	int len = 0;
+	int occupied = bay_occupied();
+	
+	if (!ibm->supported)
+		len += sprintf(p + len, "status:\t\tnot supported\n");
+	else if (!occupied)
+		len += sprintf(p + len, "status:\t\tunoccupied\n");
+	else {
+		len += sprintf(p + len, "status:\t\toccupied\n");
+		len += sprintf(p + len, "commands:\teject\n");
+	}
+
+	return len;
+}
+
+static int bay_write(struct ibm_struct *ibm, char *buf)
+{
+	char *cmd;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (strlencmp(cmd, "eject") == 0) {
+			if (!ibm->supported ||
+			    !acpi_evalf(bay_handle, NULL, "_EJ0", "vd", 1))
+				return -EIO;
+		} else
+			return -EINVAL;
+	}
+
+	return 0;
+}	
+
+static void bay_notify(struct ibm_struct *ibm, u32 event)
+{
+	acpi_bus_generate_event(ibm->device, event, 0);
+}
+
+static int cmos_read(struct ibm_struct *ibm, char *p)
+{
+	int len = 0;
+
+	/* cmos not supported on A21e, T20, T21, X20 */
+	if (!cmos_handle)
+		len += sprintf(p + len, "status:\t\tnot supported\n");
+	else {
+		len += sprintf(p + len, "status:\t\tsupported\n");
+		len += sprintf(p + len, "commands:\t<int>\n");
+	}
+
+	return len;
+}
+
+static int cmos_write(struct ibm_struct *ibm, char *buf)
+{
+	char *cmd;
+	int cmos_cmd;
+
+	if (!cmos_handle)
+		return -EINVAL;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (sscanf(cmd, "%u", &cmos_cmd) == 1) {
+			/* cmos_cmd set */
+		} else
+			return -EINVAL;
+
+		if (!acpi_evalf(cmos_handle, NULL, NULL, "vd", cmos_cmd))
+			return -EIO;
+	}
+
+	return 0;
+}	
+		
+static int led_read(struct ibm_struct *ibm, char *p)
+{
+	int len = 0;
+
+	len += sprintf(p + len, "commands:\t"
+		       "<int> on, <int> off, <int> blink\n");
+
+	return len;
+}
+
+static int led_write(struct ibm_struct *ibm, char *buf)
+{
+	char *cmd;
+	unsigned int led;
+	int led_cmd, sysl_cmd, bled_a, bled_b;
+
+	if (!led_handle && !bled_handle)
+		return -EINVAL;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (sscanf(cmd, "%u", &led) != 1)
+			return -EINVAL;
+
+		if (strstr(cmd, "blink")) {
+			led_cmd = 0xc0;
+			sysl_cmd = 2;
+			bled_a = 2;
+			bled_b = 1;
+		} else if (strstr(cmd, "on")) {
+			led_cmd = 0x80;
+			sysl_cmd = 1;
+			bled_a = 2;
+			bled_b = 0;
+		} else if (strstr(cmd, "off")) {
+			led_cmd = sysl_cmd = bled_a = bled_b = 0;
+		} else
+			return -EINVAL;
+		
+		if (led_handle) {
+			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
+					led, led_cmd))
+				return -EIO;
+		} else if (led < 2) {
+			if (acpi_evalf(sysl_handle, NULL, NULL, "vdd",
+				       led, sysl_cmd))
+				return -EIO;
+		} else if (led == 2 && bled_handle) {
+			if (acpi_evalf(bled_handle, NULL, NULL, "vdd",
+				       bled_a, bled_b))
+				return -EIO;
+		} else
+			return -EINVAL;
+	}
+
+	return 0;
+}	
+		
+static int beep_read(struct ibm_struct *ibm, char *p)
+{
+	int len = 0;
+
+	len += sprintf(p + len, "commands:\t<int>\n");
+
+	return len;
+}
+
+static int beep_write(struct ibm_struct *ibm, char *buf)
+{
+	char *cmd;
+	int beep_cmd;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (sscanf(cmd, "%u", &beep_cmd) == 1) {
+			/* beep_cmd set */
+		} else
+			return -EINVAL;
+
+		if (!acpi_evalf(beep_handle, NULL, NULL, "vd", beep_cmd))
+			return -EIO;
+	}
+
+	return 0;
+}	
+		
+struct ibm_struct ibms[] = {
+	{
+		.name	= "driver",
+		.init	= driver_init,
+		.read	= driver_read,
+	},
+	{
+		.name	= "hotkey",
+		.hid	= "IBM0068",
+		.init	= hotkey_init,
+		.read	= hotkey_read,
+		.write	= hotkey_write,
+		.exit	= hotkey_exit,
+		.notify	= hotkey_notify,
+		.handle	= &hkey_handle,
+		.type	= ACPI_DEVICE_NOTIFY,
+	},
+	{
+		.name	= "bluetooth",
+		.init	= bluetooth_init,
+		.read	= bluetooth_read,
+		.write	= bluetooth_write,
+	},
+	{
+		.name	= "video",
+		.init	= video_init,
+		.read	= video_read,
+		.write	= video_write,
+		.exit	= video_exit,
+	},
+	{
+		.name	= "light",
+		.init	= light_init,
+		.read	= light_read,
+		.write	= light_write,
+	},
+	{
+		.name	= "dock",
+		.read	= dock_read,
+		.write	= dock_write,
+		.notify	= dock_notify,
+		.handle	= &dock_handle,
+		.type	= ACPI_SYSTEM_NOTIFY,
+	},
+	{
+		.name	= "bay",
+		.init	= bay_init,
+		.read	= bay_read,
+		.write	= bay_write,
+		.notify	= bay_notify,
+		.handle	= &bay_handle,
+		.type	= ACPI_SYSTEM_NOTIFY,
+	},
+	{
+		.name	= "cmos",
+		.read	= cmos_read,
+		.write	= cmos_write,
+		.experimental = 1,
+	},
+	{
+		.name	= "led",
+		.read	= led_read,
+		.write	= led_write,
+		.experimental = 1,
+	},
+	{
+		.name	= "beep",
+		.read	= beep_read,
+		.write	= beep_write,
+		.experimental = 1,
+	},
+};
+#define NUM_IBMS (sizeof(ibms)/sizeof(ibms[0]))
+
+static int dispatch_read(char *page, char **start, off_t off, int count,
+			 int *eof, void *data)
+{
+	struct ibm_struct *ibm = (struct ibm_struct *)data;
+	int len;
+	
+	if (!ibm || !ibm->read)
+		return -EINVAL;
+
+	len = ibm->read(ibm, page);
+	if (len < 0)
+		return len;
+
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
+static int dispatch_write(struct file *file, const char __user *userbuf,
+			  unsigned long count, void *data)
+{
+	struct ibm_struct *ibm = (struct ibm_struct *)data;
+	char *kernbuf;
+	int ret;
+
+	if (!ibm || !ibm->write)
+		return -EINVAL;
+
+	kernbuf = kmalloc(count + 2, GFP_KERNEL);
+	if (!kernbuf)
+		return -ENOMEM;
+
+        if (copy_from_user(kernbuf, userbuf, count)) {
+		kfree(kernbuf);
+                return -EFAULT;
+	}
+
+	kernbuf[count] = 0;
+	strcat(kernbuf, ",");
+	ret = ibm->write(ibm, kernbuf);
+	if (ret == 0)
+		ret = count;
+
+	kfree(kernbuf);
+
+        return ret;
+}
+
+static void dispatch_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct ibm_struct *ibm = (struct ibm_struct *)data;
+
+	if (!ibm || !ibm->notify)
+		return;
+
+	ibm->notify(ibm, event);
+}
+
+static int setup_notify(struct ibm_struct *ibm)
+{
+	acpi_status status;
+	int ret;
+
+	if (!*ibm->handle)
+		return 0;
+
+	ret = acpi_bus_get_device(*ibm->handle, &ibm->device);
+	if (ret < 0) {
+		printk(IBM_ERR "%s device not present\n", ibm->name);
+		return 0;
+	}
+
+	acpi_driver_data(ibm->device) = ibm;
+	sprintf(acpi_device_class(ibm->device), "%s/%s", IBM_NAME, ibm->name);
+
+	status = acpi_install_notify_handler(*ibm->handle, ibm->type,
+					     dispatch_notify, ibm);
+	if (ACPI_FAILURE(status)) {
+		printk(IBM_ERR "acpi_install_notify_handler(%s) failed: %d\n",
+		       ibm->name, status);
+		return -ENODEV;
+	}
+
+	ibm->notify_installed = 1;
+
+	return 0;
+}
+
+static int device_add(struct acpi_device *device)
+{
+	return 0;
+}
+
+static int register_driver(struct ibm_struct *ibm)
+{
+	int ret;
+
+	ibm->driver = kmalloc(sizeof(struct acpi_driver), GFP_KERNEL);
+	if (!ibm->driver) {
+		printk(IBM_ERR "kmalloc(ibm->driver) failed\n");
+		return -1;
+	}
+
+	memset(ibm->driver, 0, sizeof(struct acpi_driver));
+	sprintf(ibm->driver->name, "%s/%s", IBM_NAME, ibm->name);
+	ibm->driver->ids = ibm->hid;
+	ibm->driver->ops.add = &device_add;
+
+	ret = acpi_bus_register_driver(ibm->driver);
+	if (ret < 0) {
+		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
+		       ibm->hid, ret);
+		kfree(ibm->driver);
+	}
+
+	return ret;
+}
+
+static int ibm_init(struct ibm_struct *ibm)
+{
+	int ret;
+	struct proc_dir_entry *entry;
+
+	if (ibm->experimental && !experimental)
+		return 0;
+
+	if (ibm->hid) {
+		ret = register_driver(ibm);
+		if (ret < 0)
+			return ret;
+		ibm->driver_registered = 1;
+	}
+
+	if (ibm->init) {
+		ret = ibm->init(ibm);
+		if (ret != 0)
+			return ret;
+		ibm->init_called = 1;
+	}
+
+	entry = create_proc_entry(ibm->name, S_IFREG | S_IRUGO | S_IWUSR,
+				  proc_dir);
+	if (!entry) {
+		printk(IBM_ERR "unable to create proc entry %s\n", ibm->name);
+		return -ENODEV;
+	}
+	entry->owner = THIS_MODULE;
+	ibm->proc_created = 1;
+	
+	entry->data = ibm;
+	if (ibm->read)
+		entry->read_proc = &dispatch_read;
+	if (ibm->write)
+		entry->write_proc = &dispatch_write;
+
+	if (ibm->notify) {
+		ret = setup_notify(ibm);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void ibm_exit(struct ibm_struct *ibm)
+{
+	if (ibm->notify_installed)
+		acpi_remove_notify_handler(*ibm->handle, ibm->type,
+					   dispatch_notify);
+
+	if (ibm->proc_created)
+		remove_proc_entry(ibm->name, proc_dir);
+
+	if (ibm->init_called && ibm->exit)
+		ibm->exit(ibm);
+
+	if (ibm->driver_registered) {
+		acpi_bus_unregister_driver(ibm->driver);
+		kfree(ibm->driver);
+	}
+}
+
+static int ibm_handle_init(char *name,
+			   acpi_handle *handle, acpi_handle parent,
+			   char **paths, int num_paths, int required)
+{
+	int i;
+	acpi_status status;
+
+	for (i=0; i<num_paths; i++) {
+		status = acpi_get_handle(parent, paths[i], handle);
+		if (ACPI_SUCCESS(status))
+			return 0;
+	}
+	
+	if (required) {
+		printk(IBM_ERR "%s object not found\n", name);
+		return -1;
+	}
+
+	*handle = NULL;
+
+	return 0;
+}
+
+#define IBM_HANDLE_INIT_REQ(object) do {                                      \
+        if (ibm_handle_init(#object, &object##_handle, *object##_parent,      \
+		object##_paths, sizeof(object##_paths)/sizeof(char *), 1) < 0)\
+		return -ENODEV;                                               \
+} while (0)
+
+#define IBM_HANDLE_INIT(object)                                           \
+	ibm_handle_init(#object, &object##_handle, *object##_parent,      \
+		object##_paths, sizeof(object##_paths)/sizeof(char *), 0)
+
+
+static void ibm_param(char *feature, char *cmd)
+{
+	int i;
+
+	strcat(cmd, ",");
+	for (i=0; i<NUM_IBMS; i++)
+		if (strcmp(ibms[i].name, feature) == 0)
+			ibms[i].write(&ibms[i], cmd);
+}	
+
+#define IBM_PARAM(feature) do {					\
+	static char cmd[32];					\
+	module_param_string(feature, cmd, sizeof(cmd) - 1, 0);	\
+	ibm_param(#feature, cmd);				\
+} while (0)
+
+static void __exit acpi_ibm_exit(void)
+{
+	int i;
+
+	for (i=NUM_IBMS-1; i>=0; i--)
+		ibm_exit(&ibms[i]);
+
+	remove_proc_entry(IBM_DIR, acpi_root_dir);
+}
+
+static int __init acpi_ibm_init(void)
+{
+	int ret, i;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
+	if (!proc_dir) {
+		printk(IBM_ERR "unable to create proc dir %s", IBM_DIR);
+		return -ENODEV;
+	}
+	proc_dir->owner = THIS_MODULE;
+	
+	IBM_HANDLE_INIT_REQ(ec);
+	IBM_HANDLE_INIT_REQ(hkey);
+	IBM_HANDLE_INIT_REQ(vid);
+	IBM_HANDLE_INIT_REQ(cmos);
+	IBM_HANDLE_INIT(lght);
+	IBM_HANDLE_INIT(dock);
+	IBM_HANDLE_INIT(bay);
+	IBM_HANDLE_INIT(bayej);
+	IBM_HANDLE_INIT(led);
+	IBM_HANDLE_INIT(sysl);
+	IBM_HANDLE_INIT(bled);
+	IBM_HANDLE_INIT_REQ(beep);
+
+	if (!led_handle && !sysl_handle) {
+		printk(IBM_ERR "neither led nor sysl object found\n");
+		return -ENODEV;
+	}
+
+	for (i=0; i<NUM_IBMS; i++) {
+		ret = ibm_init(&ibms[i]);
+		if (ret < 0) {
+			acpi_ibm_exit();
+			return ret;
+		}
+	}
+
+	IBM_PARAM(hotkey);
+	IBM_PARAM(bluetooth);
+	IBM_PARAM(video);
+	IBM_PARAM(light);
+	IBM_PARAM(dock);
+	IBM_PARAM(bay);
+	IBM_PARAM(cmos);
+	IBM_PARAM(led);
+	IBM_PARAM(beep);
+
+	return 0;
+}
+
+module_init(acpi_ibm_init);
+module_exit(acpi_ibm_exit);
+
+MODULE_AUTHOR("Borislav Deianov");
+MODULE_DESCRIPTION(IBM_DESC);
+MODULE_LICENSE("GPL");
diff -Nur linux-2.6.9-rc4-mm1/drivers/acpi/Kconfig linux-2.6.9-rc4-mm1-ibm/drivers/acpi/Kconfig
--- linux-2.6.9-rc4-mm1/drivers/acpi/Kconfig	2004-10-18 17:19:33.000000000 -0700
+++ linux-2.6.9-rc4-mm1-ibm/drivers/acpi/Kconfig	2004-10-18 17:48:34.000000000 -0700
@@ -176,6 +176,20 @@
           something works not quite as expected, please use the mailing list
           available on the above page (acpi4asus-user@lists.sourceforge.net)
 
+config ACPI_IBM
+	tristate "IBM ThinkPad Laptop Extras"
+	depends on X86
+	depends on ACPI_INTERPRETER
+	default m
+	---help---
+	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
+	  support for Fn-Fx key combinations, Bluetooth control, video
+	  output switching, ThinkLight control, UltraBay eject and more.
+	  For more information about this driver see Documentation/ibm-acpi.txt
+	  and http://ibm-acpi.sf.net/ .
+
+	  If you have an IBM ThinkPad laptop, say Y or M here.
+          
 config ACPI_THINKPAD
 	tristate "Thinkpad Fn+Fx key driver"
 	depends on X86
diff -Nur linux-2.6.9-rc4-mm1/drivers/acpi/Makefile linux-2.6.9-rc4-mm1-ibm/drivers/acpi/Makefile
--- linux-2.6.9-rc4-mm1/drivers/acpi/Makefile	2004-10-18 17:19:33.000000000 -0700
+++ linux-2.6.9-rc4-mm1-ibm/drivers/acpi/Makefile	2004-10-18 17:20:44.000000000 -0700
@@ -46,6 +46,7 @@
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
+obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_THINKPAD)	+= thinkpad_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o

--GID0FwUMdk1T2AWN--
