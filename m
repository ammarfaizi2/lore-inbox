Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263224AbTDCAJ7>; Wed, 2 Apr 2003 19:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263217AbTDCAJv>; Wed, 2 Apr 2003 19:09:51 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:54716 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263224AbTDCACP> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:15 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289592403@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <10493289593135@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:59 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1010, 2003/04/02 15:39:28-08:00, greg@kroah.com

i2c: remove old proc documentation and add sysfs file documentation


 Documentation/i2c/proc-interface  |   53 -----------
 Documentation/i2c/sysfs-interface |  177 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+), 53 deletions(-)


diff -Nru a/Documentation/i2c/proc-interface b/Documentation/i2c/proc-interface
--- a/Documentation/i2c/proc-interface	Wed Apr  2 16:00:02 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,53 +0,0 @@
-i2c-core is the core i2c module (surprise!) which offers general routines on
-which other modules build. You will find that all i2c-related modules depend
-on this module, so it will (need to) be loaded whenever another i2c-related 
-module is loaded. Seen from the outside, the most interesting is the /proc 
-interface. Note that there is no corresponding sysctl interface!
-
-/proc/bus/i2c
-=============
-
-Whenever i2c-core is loaded, you will find a file /proc/bus/i2c, which lists
-all currently registered I2C adapters. Each line contains exactly one
-I2C adapter. Each line has the following format: "i2c-%d\t%9s\t%-32s't%-32s\n",
-which works out to four columns separated by tabs. Note that the file
-will be empty, if no adapters are registered at all.
-
-Adapters are numbered from 0 upwards. The first column contains the number
-of the adapter, for example "i2c-4" for adapter 4. The name listed is also
-the name of the /proc file which lists all devices attached to it, and
-of the /dev file which corresponds to this adapter.
-
-The second column documents what kind of adapter this is. Some adapters
-understand the full I2C protocol, others only a subset called SMBus,
-and yet others are some kind of pseudo-adapters that do not understand
-i2c at all. Possible values in here are "i2c", "smbus", "i2c/smbus"
-and "dummy". Because the SMBus protocol can be fully emulated by i2c
-adapters, if you see "i2c" here, SMBus is supported too. There may
-be some future adapters which support both specific SMBus commands and
-general I2C, and they will display "i2c/smbus".
-
-The third and fourth column are respectively the algorithm and adapter
-name of this adapter. Each adapter is associated with an algorithm,
-and several adapters can share the same algorithm. The combination of
-algorithm name and adapter name should be unique for an adapter, but
-you can't really count on that yet.
-
-
-/proc/bus/i2c-*
-===============
-
-Each registered adapter gets its own file in /proc/bus/, which lists
-the devices registered to the adapter. Each line in such a file contains
-one registered device. Each line has the following format:
-"%02x\t%-32s\t%-32s\n", which works out to three columns separated by
-tabs. Note that this file can be empty, if no devices are found on 
-the adapter.
-
-The first column contains the (hexadecimal) address of the client. As 
-only 7-bit addresses are supported at this moment, two digits are
-enough. 
-
-The second and third column are respectively the client name and the
-driver name of this client. Each client is associated with a driver,
-and several clients can share the same driver.
diff -Nru a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-interface
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/i2c/sysfs-interface	Wed Apr  2 16:00:02 2003
@@ -0,0 +1,177 @@
+Naming and data format standards for sysfs files
+------------------------------------------------
+
+The libsensors library offers an interface to the raw sensors data
+through the sysfs interface. See libsensors documentation and source for
+more further information.
+
+An alternative method that some programs use is to access the sysfs
+files directly. This document briefly describes the standards that the
+drivers follow, so that an application program can scan for entries and
+access this data in a simple and consistent way.
+
+If you are developing a userspace application please send us feedback on
+this standard.
+
+Note that motherboards vary widely in the connections to sensor chips.
+There is no standard that ensures, for example, that the second
+temperature sensor is connected to the CPU, or that the second fan is on
+the CPU. Therefore, programs must provide a facility for the user to
+label or bind /proc entries for display.  Sensor chips often have unused
+inputs that should be ignored by user programs.
+
+Each chip gets its own directory in the sysfs /sys/devices tree.  To
+find all sensor chips, it is easier to follow the symlinks from
+/sys/i2c/devices/
+
+All sysfs values are fixed point numbers.  To get the true value of some
+of the values, you should divide by the specified value.
+
+There is only one value per file, unlike the older /proc specification.
+
+Alarms are direct indications read from the chips. The drivers do NOT
+make comparisons of readings to thresholds. This allows violations
+between readings to be caught and alarmed. The exact definition of an
+alarm (for example, whether a threshold must be met or must be exceeded
+to cause an alarm) is chip-dependent.
+
+
+-------------------------------------------------------------------------
+
+sysfs entries are as follows:
+
+
+Entry		Function
+-----		--------
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
+curr_max[1-n]	Current max value
+		Fixed point XXXXX, divide by 1000 to get Amps.
+		Read/Write.
+
+curr_min[1-n]	Current min or hysteresis value.
+		Preferably a hysteresis value, reported as a absolute
+		current, NOT a delta from the max value.
+		Fixed point XXXXX, divide by 1000 to get Amps.
+		Read/Write.
+
+curr_input[1-n]	Current input value
+		Fixed point XXXXX, divide by 1000 to get Amps.
+		Read only.
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
+in_min[0-8]	Voltage min value.
+		Fixed point value in form XXXX.  Divide by 1000 to get
+		Volts.
+		Read/Write
+		
+in_max[0-8]	Voltage max value.
+		Fixed point value in form XXXX.  Divide by 1000 to get
+		Volts.
+		Read/Write
+		
+in_input[0-8]	Voltage input value.
+		Fixed point value in form XXXX.  Divide by 1000 to get
+		Volts.
+		Read only
+		Actual voltage depends on the scaling resistors on the
+		motherboard, as recommended in the chip datasheet.
+		This varies by chip and by motherboard.
+		Because of this variation, values are generally NOT scaled
+		by the chip driver, and must be done by the application.
+		However, some drivers (notably lm87 and via686a)
+		do scale, with various degrees of success.
+		These drivers will output the actual voltage.
+		First two values are read/write and third is read only.
+		Typical usage:
+			in_*0	CPU #1 voltage (not scaled)
+			in_*1	CPU #1 voltage (not scaled)
+			in_*2	3.3V nominal (not scaled)
+			in_*3	5.0V nominal (scaled)
+			in_*4	12.0V nominal (scaled)
+			in_*5	-12.0V nominal (scaled)
+			in_*6	-5.0V nominal (scaled)
+			in_*7	varies
+			in_*8	varies
+
+pwm[1-3]	Pulse width modulation fan control.
+		Integer 0 - 255
+		Read/Write
+		255 is max or 100%.
+		Corresponds to the fans 1-3.
+
+pwm_enable[1-3] pwm enable
+		not always present even if pwm* is.
+		0 to turn off
+		1 to turn on
+		Read/Write
+
+sensor[1-3]	Sensor type selection.
+		Integers 1,2,3, or thermistor Beta value (3435)
+		Read/Write.
+
+temp_max[1-3]	Temperature max value.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.
+		Read/Write value.
+
+temp_min[1-3]	Temperature min or hysteresis value.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.  This is preferably a
+		hysteresis value, reported as a absolute temperature,
+		NOT a delta from the max value.
+		Read/Write value.
+
+temp_input[1-3] Temperature input value.
+		Read only value.
+
+		If there are multiple temperature sensors, temp_*1 is
+		generally the sensor inside the chip itself, generally
+		reported as "motherboard temperature".  temp_*2 and
+		temp_*3 are generally sensors external to the chip
+		itself, for example the thermal diode inside the CPU or
+		a thermistor nearby.
+
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

