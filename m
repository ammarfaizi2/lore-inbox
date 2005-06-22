Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVFVGWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVFVGWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVFVGVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:21:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:34204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262805AbVFVFWI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:08 -0400
Cc: grant_lkml@dodo.com.au
Subject: [PATCH] I2C: add adm9240 driver documentation
In-Reply-To: <1119417467964@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:47 -0700
Message-Id: <1119417467970@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: add adm9240 driver documentation

This patch adds adm9240 driver doc, with thanks to Rudolf Marek
for review.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Acked-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a0ef14837a2298a4748e2a3e8e206f086dd3b21a
tree 78e06fec1c9f157b4c51ca3f4c1f3d142a0a45ca
parent eb071cbbc38efa4b1d707f540de2ec6283ab0894
author Grant Coady <grant_lkml@dodo.com.au> Fri, 03 Jun 2005 10:05:19 +1000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:03 -0700

 Documentation/i2c/chips/adm9240 |  177 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 177 insertions(+), 0 deletions(-)

diff --git a/Documentation/i2c/chips/adm9240 b/Documentation/i2c/chips/adm9240
new file mode 100644
--- /dev/null
+++ b/Documentation/i2c/chips/adm9240
@@ -0,0 +1,177 @@
+Kernel driver adm9240
+=====================
+
+Supported chips:
+  * Analog Devices ADM9240
+    Prefix: 'adm9240'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: Publicly available at the Analog Devices website
+    http://www.analog.com/UploadedFiles/Data_Sheets/79857778ADM9240_0.pdf
+
+  * Dallas Semiconductor DS1780
+    Prefix: 'ds1780'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: Publicly available at the Dallas Semiconductor (Maxim) website
+    http://pdfserv.maxim-ic.com/en/ds/DS1780.pdf
+
+  * National Semiconductor LM81
+    Prefix: 'lm81'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: Publicly available at the National Semiconductor website
+    http://www.national.com/ds.cgi/LM/LM81.pdf
+
+Authors:
+    Frodo Looijaard <frodol@dds.nl>,
+    Philip Edelbrock <phil@netroedge.com>,
+    Michiel Rook <michiel@grendelproject.nl>,
+    Grant Coady <gcoady@gmail.com> with guidance
+        from Jean Delvare <khali@linux-fr.org>
+
+Interface
+---------
+The I2C addresses listed above assume BIOS has not changed the
+chip MSB 5-bit address. Each chip reports a unique manufacturer
+identification code as well as the chip revision/stepping level.
+
+Description
+-----------
+[From ADM9240] The ADM9240 is a complete system hardware monitor for
+microprocessor-based systems, providing measurement and limit comparison
+of up to four power supplies and two processor core voltages, plus
+temperature, two fan speeds and chassis intrusion. Measured values can
+be read out via an I2C-compatible serial System Management Bus, and values
+for limit comparisons can be programmed in over the same serial bus. The
+high speed successive approximation ADC allows frequent sampling of all
+analog channels to ensure a fast interrupt response to any out-of-limit
+measurement.
+
+The ADM9240, DS1780 and LM81 are register compatible, the following
+details are common to the three chips. Chip differences are described
+after this section.
+
+
+Measurements
+------------
+The measurement cycle
+
+The adm9240 driver will take a measurement reading no faster than once
+each two seconds. User-space may read sysfs interface faster than the
+measurement update rate and will receive cached data from the most
+recent measurement.
+
+ADM9240 has a very fast 320us temperature and voltage measurement cycle
+with independent fan speed measurement cycles counting alternating rising
+edges of the fan tacho inputs.
+
+DS1780 measurement cycle is about once per second including fan speed.
+
+LM81 measurement cycle is about once per 400ms including fan speed.
+The LM81 12-bit extended temperature measurement mode is not supported.
+
+Temperature
+-----------
+On chip temperature is reported as degrees Celsius as 9-bit signed data
+with resolution of 0.5 degrees Celsius. High and low temperature limits
+are 8-bit signed data with resolution of one degree Celsius.
+
+Temperature alarm is asserted once the temperature exceeds the high limit,
+and is cleared when the temperature falls below the temp1_max_hyst value.
+
+Fan Speed
+---------
+Two fan tacho inputs are provided, the ADM9240 gates an internal 22.5kHz
+clock via a divider to an 8-bit counter. Fan speed (rpm) is calculated by:
+
+rpm = (22500 * 60) / (count * divider)
+
+Automatic fan clock divider
+
+  * User sets 0 to fan_min limit
+    - low speed alarm is disabled
+    - fan clock divider not changed
+    - auto fan clock adjuster enabled for valid fan speed reading
+
+  * User sets fan_min limit too low
+    - low speed alarm is enabled
+    - fan clock divider set to max
+    - fan_min set to register value 254 which corresponds
+      to 664 rpm on adm9240
+    - low speed alarm will be asserted if fan speed is
+      less than minimum measurable speed
+    - auto fan clock adjuster disabled
+
+  * User sets reasonable fan speed
+    - low speed alarm is enabled
+    - fan clock divider set to suit fan_min
+    - auto fan clock adjuster enabled: adjusts fan_min
+
+  * User sets unreasonably high low fan speed limit
+    - resolution of the low speed limit may be reduced
+    - alarm will be asserted
+    - auto fan clock adjuster enabled: adjusts fan_min
+
+    * fan speed may be displayed as zero until the auto fan clock divider
+      adjuster brings fan speed clock divider back into chip measurement
+      range, this will occur within a few measurement cycles.
+
+Analog Output
+-------------
+An analog output provides a 0 to 1.25 volt signal intended for an external
+fan speed amplifier circuit. The analog output is set to maximum value on
+power up or reset. This doesn't do much on the test Intel SE440BX-2.
+
+Voltage Monitor
+
+Voltage (IN) measurement is internally scaled:
+
+    nr  label       nominal     maximum   resolution
+                      mV          mV         mV
+    0   +2.5V        2500        3320       13.0
+    1   Vccp1        2700        3600       14.1
+    2   +3.3V        3300        4380       17.2
+    3     +5V        5000        6640       26.0
+    4    +12V       12000       15940       62.5
+    5   Vccp2        2700        3600       14.1
+
+The reading is an unsigned 8-bit value, nominal voltage measurement is
+represented by a reading of 192, being 3/4 of the measurement range.
+
+An alarm is asserted for any voltage going below or above the set limits.
+
+The driver reports and accepts voltage limits scaled to the above table.
+
+VID Monitor
+-----------
+The chip has five inputs to read the 5-bit VID and reports the mV value
+based on detected CPU type.
+
+Chassis Intrusion
+-----------------
+An alarm is asserted when the CI pin goes active high. The ADM9240
+Datasheet has an example of an external temperature sensor driving
+this pin. On an Intel SE440BX-2 the Chassis Intrusion header is
+connected to a normally open switch.
+
+The ADM9240 provides an internal open drain on this line, and may output
+a 20 ms active low pulse to reset an external Chassis Intrusion latch.
+
+Clear the CI latch by writing value 1 to the sysfs chassis_clear file.
+
+Alarm flags reported as 16-bit word
+
+    bit     label               comment
+    ---     -------------       --------------------------
+     0      +2.5 V_Error        high or low limit exceeded
+     1      VCCP_Error          high or low limit exceeded
+     2      +3.3 V_Error        high or low limit exceeded
+     3      +5 V_Error          high or low limit exceeded
+     4      Temp_Error          temperature error
+     6      FAN1_Error          fan low limit exceeded
+     7      FAN2_Error          fan low limit exceeded
+     8      +12 V_Error         high or low limit exceeded
+     9      VCCP2_Error         high or low limit exceeded
+    12      Chassis_Error       CI pin went high
+
+Remaining bits are reserved and thus undefined. It is important to note
+that alarm bits may be cleared on read, user-space may latch alarms and
+provide the end-user with a method to clear alarm memory.

