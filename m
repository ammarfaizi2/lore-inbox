Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVFVGWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVFVGWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVFVGT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:19:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:41372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262809AbVFVFWJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:09 -0400
Cc: R.Marek@sh.cvut.cz
Subject: [PATCH] I2C: documentation update 1/3
In-Reply-To: <11194174662573@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:46 -0700
Message-Id: <1119417466764@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: documentation update 1/3

This patch just changes the extension of Documentation/i2c/chips/smsc47b397.txt
to none - to conform with naming in i2c subsystem directory.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2bf34a1ca9d570dd4fab4d95c4de82d873ecf718
tree 293f1c49c9b0f6bf9421905ef1c475c28ed3d496
parent 72cd799544f2b36c2f07ceaeed6d984cb130d4f3
author R.Marek@sh.cvut.cz <R.Marek@sh.cvut.cz> Thu, 26 May 2005 12:42:11 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:02 -0700

 Documentation/i2c/chips/smsc47b397     |  146 ++++++++++++++++++++++++++++++++
 Documentation/i2c/chips/smsc47b397.txt |  146 --------------------------------
 2 files changed, 146 insertions(+), 146 deletions(-)

diff --git a/Documentation/i2c/chips/smsc47b397 b/Documentation/i2c/chips/smsc47b397
new file mode 100644
--- /dev/null
+++ b/Documentation/i2c/chips/smsc47b397
@@ -0,0 +1,146 @@
+November 23, 2004
+
+The following specification describes the SMSC LPC47B397-NC sensor chip
+(for which there is no public datasheet available).  This document was
+provided by Craig Kelly (In-Store Broadcast Network) and edited/corrected
+by Mark M. Hoffman <mhoffman@lightlink.com>.
+
+* * * * *
+
+Methods for detecting the HP SIO and reading the thermal data on a dc7100.
+
+The thermal information on the dc7100 is contained in the SIO Hardware Monitor
+(HWM).  The information is accessed through an index/data pair.  The index/data
+pair is located at the HWM Base Address + 0 and the HWM Base Address + 1.  The
+HWM Base address can be obtained from Logical Device 8, registers 0x60 (MSB)
+and 0x61 (LSB).  Currently we are using 0x480 for the HWM Base Address and
+0x480 and 0x481 for the index/data pair.
+
+Reading temperature information.
+The temperature information is located in the following registers:
+Temp1		0x25	(Currently, this reflects the CPU temp on all systems).
+Temp2		0x26
+Temp3		0x27
+Temp4		0x80
+
+Programming Example
+The following is an example of how to read the HWM temperature registers:
+MOV	DX,480H
+MOV	AX,25H
+OUT	DX,AL
+MOV	DX,481H
+IN	AL,DX
+
+AL contains the data in hex, the temperature in Celsius is the decimal
+equivalent.
+
+Ex: If AL contains 0x2A, the temperature is 42 degrees C.
+
+Reading tach information.
+The fan speed information is located in the following registers:
+		LSB	MSB
+Tach1		0x28	0x29	(Currently, this reflects the CPU
+				fan speed on all systems).
+Tach2		0x2A	0x2B
+Tach3		0x2C	0x2D
+Tach4		0x2E	0x2F
+
+Important!!!
+Reading the tach LSB locks the tach MSB.
+The LSB Must be read first.
+
+How to convert the tach reading to RPM.
+The tach reading (TCount) is given by:  (Tach MSB * 256) + (Tach LSB)
+The SIO counts the number of 90kHz (11.111us) pulses per revolution.
+RPM = 60/(TCount * 11.111us)
+
+Example:
+Reg 0x28 = 0x9B
+Reg 0x29 = 0x08
+
+TCount = 0x89B = 2203
+
+RPM = 60 / (2203 * 11.11111 E-6) = 2451 RPM
+
+Obtaining the SIO version.
+
+CONFIGURATION SEQUENCE
+To program the configuration registers, the following sequence must be followed:
+1. Enter Configuration Mode
+2. Configure the Configuration Registers
+3. Exit Configuration Mode.
+
+Enter Configuration Mode
+To place the chip into the Configuration State The config key (0x55) is written
+to the CONFIG PORT (0x2E).
+
+Configuration Mode
+In configuration mode, the INDEX PORT is located at the CONFIG PORT address and
+the DATA PORT is at INDEX PORT address + 1.
+
+The desired configuration registers are accessed in two steps:
+a.	Write the index of the Logical Device Number Configuration Register
+	(i.e., 0x07) to the INDEX PORT and then write the number of the
+	desired logical device to the DATA PORT.
+
+b.	Write the address of the desired configuration register within the
+	logical device to the INDEX PORT and then write or read the config-
+	uration register through the DATA PORT.
+
+Note: If accessing the Global Configuration Registers, step (a) is not required.
+
+Exit Configuration Mode
+To exit the Configuration State the write 0xAA to the CONFIG PORT (0x2E).
+The chip returns to the RUN State.  (This is important).
+
+Programming Example
+The following is an example of how to read the SIO Device ID located at 0x20
+
+; ENTER CONFIGURATION MODE
+MOV	DX,02EH
+MOV	AX,055H
+OUT	DX,AL
+; GLOBAL CONFIGURATION  REGISTER
+MOV	DX,02EH
+MOV	AL,20H
+OUT	DX,AL
+; READ THE DATA
+MOV	DX,02FH
+IN	AL,DX
+; EXIT CONFIGURATION MODE
+MOV	DX,02EH
+MOV	AX,0AAH
+OUT	DX,AL
+
+The registers of interest for identifying the SIO on the dc7100 are Device ID
+(0x20) and Device Rev  (0x21).
+
+The Device ID will read 0X6F
+The Device Rev currently reads 0x01
+
+Obtaining the HWM Base Address.
+The following is an example of how to read the HWM Base Address located in
+Logical Device 8.
+
+; ENTER CONFIGURATION MODE
+MOV	DX,02EH
+MOV	AX,055H
+OUT	DX,AL
+; CONFIGURE REGISTER CRE0,
+; LOGICAL DEVICE 8
+MOV	DX,02EH
+MOV	AL,07H
+OUT	DX,AL ;Point to LD# Config Reg
+MOV	DX,02FH
+MOV	AL, 08H
+OUT	DX,AL;Point to Logical Device 8
+;
+MOV	DX,02EH
+MOV	AL,60H
+OUT	DX,AL	; Point to HWM Base Addr MSB
+MOV	DX,02FH
+IN	AL,DX	; Get MSB of HWM Base Addr
+; EXIT CONFIGURATION MODE
+MOV	DX,02EH
+MOV	AX,0AAH
+OUT	DX,AL
diff --git a/Documentation/i2c/chips/smsc47b397.txt b/Documentation/i2c/chips/smsc47b397.txt
deleted file mode 100644
--- a/Documentation/i2c/chips/smsc47b397.txt
+++ /dev/null
@@ -1,146 +0,0 @@
-November 23, 2004
-
-The following specification describes the SMSC LPC47B397-NC sensor chip
-(for which there is no public datasheet available).  This document was
-provided by Craig Kelly (In-Store Broadcast Network) and edited/corrected
-by Mark M. Hoffman <mhoffman@lightlink.com>.
-
-* * * * *
-
-Methods for detecting the HP SIO and reading the thermal data on a dc7100.
-
-The thermal information on the dc7100 is contained in the SIO Hardware Monitor
-(HWM).  The information is accessed through an index/data pair.  The index/data
-pair is located at the HWM Base Address + 0 and the HWM Base Address + 1.  The
-HWM Base address can be obtained from Logical Device 8, registers 0x60 (MSB)
-and 0x61 (LSB).  Currently we are using 0x480 for the HWM Base Address and
-0x480 and 0x481 for the index/data pair.
-
-Reading temperature information.
-The temperature information is located in the following registers:
-Temp1		0x25	(Currently, this reflects the CPU temp on all systems).
-Temp2		0x26
-Temp3		0x27
-Temp4		0x80
-
-Programming Example
-The following is an example of how to read the HWM temperature registers:
-MOV	DX,480H
-MOV	AX,25H
-OUT	DX,AL
-MOV	DX,481H
-IN	AL,DX
-
-AL contains the data in hex, the temperature in Celsius is the decimal
-equivalent.
-
-Ex: If AL contains 0x2A, the temperature is 42 degrees C.
-
-Reading tach information.
-The fan speed information is located in the following registers:
-		LSB	MSB
-Tach1		0x28	0x29	(Currently, this reflects the CPU
-				fan speed on all systems).
-Tach2		0x2A	0x2B
-Tach3		0x2C	0x2D
-Tach4		0x2E	0x2F
-
-Important!!!
-Reading the tach LSB locks the tach MSB.
-The LSB Must be read first.
-
-How to convert the tach reading to RPM.
-The tach reading (TCount) is given by:  (Tach MSB * 256) + (Tach LSB)
-The SIO counts the number of 90kHz (11.111us) pulses per revolution.
-RPM = 60/(TCount * 11.111us)
-
-Example:
-Reg 0x28 = 0x9B
-Reg 0x29 = 0x08
-
-TCount = 0x89B = 2203
-
-RPM = 60 / (2203 * 11.11111 E-6) = 2451 RPM
-
-Obtaining the SIO version.
-
-CONFIGURATION SEQUENCE
-To program the configuration registers, the following sequence must be followed:
-1. Enter Configuration Mode
-2. Configure the Configuration Registers
-3. Exit Configuration Mode.
-
-Enter Configuration Mode
-To place the chip into the Configuration State The config key (0x55) is written
-to the CONFIG PORT (0x2E). 
-
-Configuration Mode
-In configuration mode, the INDEX PORT is located at the CONFIG PORT address and
-the DATA PORT is at INDEX PORT address + 1.
-
-The desired configuration registers are accessed in two steps: 
-a.	Write the index of the Logical Device Number Configuration Register
-	(i.e., 0x07) to the INDEX PORT and then write the number of the
-	desired logical device to the DATA PORT.
-
-b.	Write the address of the desired configuration register within the
-	logical device to the INDEX PORT and then write or read the config-
-	uration register through the DATA PORT.  
-
-Note: If accessing the Global Configuration Registers, step (a) is not required.
-
-Exit Configuration Mode
-To exit the Configuration State the write 0xAA to the CONFIG PORT (0x2E).
-The chip returns to the RUN State.  (This is important).
-
-Programming Example
-The following is an example of how to read the SIO Device ID located at 0x20
-
-; ENTER CONFIGURATION MODE   
-MOV	DX,02EH
-MOV	AX,055H
-OUT	DX,AL
-; GLOBAL CONFIGURATION  REGISTER 
-MOV	DX,02EH
-MOV	AL,20H
-OUT	DX,AL 
-; READ THE DATA
-MOV	DX,02FH
-IN	AL,DX
-; EXIT CONFIGURATION MODE     
-MOV	DX,02EH
-MOV	AX,0AAH
-OUT	DX,AL
-
-The registers of interest for identifying the SIO on the dc7100 are Device ID
-(0x20) and Device Rev  (0x21).
-
-The Device ID will read 0X6F
-The Device Rev currently reads 0x01
-
-Obtaining the HWM Base Address.
-The following is an example of how to read the HWM Base Address located in
-Logical Device 8.
-
-; ENTER CONFIGURATION MODE   
-MOV	DX,02EH
-MOV	AX,055H
-OUT	DX,AL
-; CONFIGURE REGISTER CRE0,   
-; LOGICAL DEVICE 8           
-MOV	DX,02EH
-MOV	AL,07H
-OUT	DX,AL ;Point to LD# Config Reg
-MOV	DX,02FH
-MOV	AL, 08H
-OUT	DX,AL;Point to Logical Device 8
-;
-MOV	DX,02EH 
-MOV	AL,60H
-OUT	DX,AL	; Point to HWM Base Addr MSB
-MOV	DX,02FH
-IN	AL,DX	; Get MSB of HWM Base Addr
-; EXIT CONFIGURATION MODE     
-MOV	DX,02EH
-MOV	AX,0AAH
-OUT	DX,AL

