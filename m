Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbUCPDEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 22:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbUCPDDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 22:03:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:20399 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262895AbUCPACV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:21 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913922333@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:32 -0800
Message-Id: <10793913923994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.15, 2004/02/23 16:40:03-08:00, khali@linux-fr.org

[PATCH] I2C: update for sysfs-interface documentation


 Documentation/i2c/sysfs-interface |  192 ++++++++++++++++++++++++--------------
 1 files changed, 123 insertions(+), 69 deletions(-)


diff -Nru a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-interface
--- a/Documentation/i2c/sysfs-interface	Mon Mar 15 14:36:29 2004
+++ b/Documentation/i2c/sysfs-interface	Mon Mar 15 14:36:29 2004
@@ -3,22 +3,44 @@
 
 The libsensors library offers an interface to the raw sensors data
 through the sysfs interface. See libsensors documentation and source for
-more further information.
+more further information. As of writing this document, libsensors
+(from lm_sensors 2.8.3) is heavily chip-dependant. Adding or updating
+support for any given chip requires modifying the library's code.
+This is because libsensors was written for the procfs interface
+older kernel modules were using, which wasn't standardized enough.
+Recent versions of libsensors (from lm_sensors 2.8.2 and later) have
+support for the sysfs interface, though.
+
+The new sysfs interface was designed to be as chip-independant as
+possible.
+
+Note that motherboards vary widely in the connections to sensor chips.
+There is no standard that ensures, for example, that the second
+temperature sensor is connected to the CPU, or that the second fan is on
+the CPU. Also, some values reported by the chips need some computation
+before they make full sense. For example, most chips can only measure
+voltages between 0 and +4V. Other voltages are scaled back into that
+range using external resistors. Since the values of these resistors
+can change from motherboard to motherboard, the conversions cannot be
+hard coded into the driver and have to be done in user space.
+
+For this reason, even if we aim at a chip-independant libsensors, it will
+still require a configuration file (e.g. /etc/sensors.conf) for proper
+values conversion, labeling of inputs and hiding of unused inputs.
 
 An alternative method that some programs use is to access the sysfs
 files directly. This document briefly describes the standards that the
 drivers follow, so that an application program can scan for entries and
-access this data in a simple and consistent way.
+access this data in a simple and consistent way. That said, such programs
+will have to implement conversion, labeling and hiding of inputs. For
+this reason, it is still not recommended to bypass the library.
 
 If you are developing a userspace application please send us feedback on
 this standard.
 
-Note that motherboards vary widely in the connections to sensor chips.
-There is no standard that ensures, for example, that the second
-temperature sensor is connected to the CPU, or that the second fan is on
-the CPU. Therefore, programs must provide a facility for the user to
-label or bind /proc entries for display.  Sensor chips often have unused
-inputs that should be ignored by user programs.
+Note that this standard isn't completely established yet, so it is subject
+to changes, even important ones. One more reason to use the library instead
+of accessing sysfs files directly.
 
 Each chip gets its own directory in the sysfs /sys/devices tree.  To
 find all sensor chips, it is easier to follow the symlinks from
@@ -28,6 +50,15 @@
 of the values, you should divide by the specified value.
 
 There is only one value per file, unlike the older /proc specification.
+The common scheme for files naming is: <type>_<item><number>. Usual
+types for sensor chips are "in" (voltage), "temp" (temperature) and
+"fan" (fan). Usual items are "input" (measured value), "max" (high
+threshold, "min" (low threshold). Numbering usually starts from 1,
+except for voltages which start from 0 (because most data sheets use
+this). A number is always used for elements that can be present more
+than once, even if there is a single element of the given type on the
+specific chip. Other files do not refer to a specific element, so
+they have a simple name, and no number.
 
 Alarms are direct indications read from the chips. The drivers do NOT
 make comparisons of readings to thresholds. This allows violations
@@ -38,59 +69,9 @@
 
 -------------------------------------------------------------------------
 
-sysfs entries are as follows:
-
-
-Entry		Function
------		--------
-alarms		Alarm bitmask.
-		Read only.
-		Integer representation of one to four bytes.
-		A '1' bit means an alarm.
-		Chips should be programmed for 'comparator' mode so that
-		the alarm will 'come back' after you read the register
-		if it is still valid.
-		Generally a direct representation of a chip's internal
-		alarm registers; there is no standard for the position
-		of individual bits.
-		Bits are defined in kernel/include/sensors.h.
-
-beep_enable	Beep/interrupt enable
-		0 to disable.
-		1 to enable.
-		Read/Write
-
-beep_mask	Bitmask for beep.
-		Same format as 'alarms' with the same bit locations.
-		Read only.
-
-curr_max[1-n]	Current max value
-		Fixed point XXXXX, divide by 1000 to get Amps.
-		Read/Write.
-
-curr_min[1-n]	Current min value.
-		Fixed point XXXXX, divide by 1000 to get Amps.
-		Read/Write.
-
-curr_input[1-n]	Current input value
-		Fixed point XXXXX, divide by 1000 to get Amps.
-		Read only.
-
-eeprom		Raw EEPROM data in binary form.
-		Read only.
-
-fan_min[1-3]	Fan minimum value
-		Integer value indicating RPM
-		Read/Write.
-
-fan_input[1-3]	Fan input value.
-		Integer value indicating RPM
-		Read only.
-
-fan_div[1-3]	Fan divisor.
-		Integers in powers of two (1,2,4,8,16,32,64,128).
-		Some chips only support values 1,2,4,8.
-		See doc/fan-divisors for details.
+************
+* Voltages *
+************
 
 in_min[0-8]	Voltage min value.
 		Fixed point value in form XXXX.  Divide by 1000 to get
@@ -126,6 +107,37 @@
 			in_*7	varies
 			in_*8	varies
 
+vid		CPU core voltage.
+		Read only.
+		Fixed point value in form XXXX corresponding to CPU core
+		voltage as told to the sensor chip.  Divide by 1000 to
+		get Volts.  Not always correct.
+
+vrm		Voltage Regulator Module version number. 
+		Read only.
+		Two digit number (XX), first is major version, second is
+		minor version.
+		Affects the way the driver calculates the core voltage from
+		the vid pins. See doc/vid for details.
+
+
+********
+* Fans *
+********
+
+fan_min[1-3]	Fan minimum value
+		Integer value indicating RPM
+		Read/Write.
+
+fan_input[1-3]	Fan input value.
+		Integer value indicating RPM
+		Read only.
+
+fan_div[1-3]	Fan divisor.
+		Integers in powers of two (1,2,4,8,16,32,64,128).
+		Some chips only support values 1,2,4,8.
+		See doc/fan-divisors for details.
+
 pwm[1-3]	Pulse width modulation fan control.
 		Integer 0 - 255
 		Read/Write
@@ -138,6 +150,11 @@
 		1 to turn on
 		Read/Write
 
+
+****************
+* Temperatures *
+****************
+
 sensor[1-3]	Sensor type selection.
 		Integers 1,2,3, or thermistor Beta value (3435)
 		Read/Write.
@@ -177,15 +194,51 @@
 		itself, for example the thermal diode inside the CPU or
 		a thermistor nearby.
 
-vid		CPU core voltage.
+
+************
+* Currents *
+************
+
+Note that no known chip provides current measurements as of writing,
+so this part is theoretical, so to say.
+
+curr_max[1-n]	Current max value
+		Fixed point XXXXX, divide by 1000 to get Amps.
+		Read/Write.
+
+curr_min[1-n]	Current min value.
+		Fixed point XXXXX, divide by 1000 to get Amps.
+		Read/Write.
+
+curr_input[1-n]	Current input value
+		Fixed point XXXXX, divide by 1000 to get Amps.
 		Read only.
-		Fixed point value in form XXXX corresponding to CPU core
-		voltage as told to the sensor chip.  Divide by 1000 to
-		get Volts.  Not always correct.
 
-vrm		Voltage Regulator Module version number. 
+
+*********
+* Other *
+*********
+
+alarms		Alarm bitmask.
+		Read only.
+		Integer representation of one to four bytes.
+		A '1' bit means an alarm.
+		Chips should be programmed for 'comparator' mode so that
+		the alarm will 'come back' after you read the register
+		if it is still valid.
+		Generally a direct representation of a chip's internal
+		alarm registers; there is no standard for the position
+		of individual bits.
+		Bits are defined in kernel/include/sensors.h.
+
+beep_enable	Beep/interrupt enable
+		0 to disable.
+		1 to enable.
+		Read/Write
+
+beep_mask	Bitmask for beep.
+		Same format as 'alarms' with the same bit locations.
+		Read only.
+
+eeprom		Raw EEPROM data in binary form.
 		Read only.
-		Two digit number (XX), first is major version, second is
-		minor version.
-		Affects the way the driver calculates the core voltage from
-		the vid pins. See doc/vid for details.

