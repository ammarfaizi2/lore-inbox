Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVDFCf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVDFCf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 22:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVDFCf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 22:35:29 -0400
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:32494 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262081AbVDFCd1 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 22:33:27 -0400
From: "Derek Cheung" <derek.cheung@sympatico.ca>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <greg@kroah.com>, <Linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Date: Tue, 5 Apr 2005 22:33:22 -0400
Message-ID: <003901c53a51$0093b7d0$1501a8c0@Mainframe>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003A_01C53A2F.798217D0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20050405192157.4b6de7bd.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_003A_01C53A2F.798217D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks Andrew. Enclosed please find the patch file.

Regards, 
Derek

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: April 5, 2005 10:22 PM
To: Derek Cheung
Cc: greg@kroah.com; Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 - I2C adaptor for ColdFire 5282 CPU

"Derek Cheung" <derek.cheung@sympatico.ca> wrote:
>
>  Below please find the patch file I "diff" against Linux 2.6.11.6. It
>  contains the I2C adaptor for ColdFire 5282 CPU. Since most ColdFire
CPU
>  shares the same I2C register set, the code can be easily adopted for
>  other ColdFire CPUs for I2C operations.
> 
>  I have tested the code on a ColdFire 5282Lite CPU board
>  (http://www.axman.com/Pages/cml-5282LITE.html) running uClinux 2.6.9
>  with LM75 and DS1621 temperature sensor chips. As advised by David
>  McCullough, the code will be incorporated in the next uClinux
release.
> 
>  The patch contains:
> 
>  linux/drivers/i2c/busses
>   		i2c-mcf5282.c (new file)
>   		i2c-mcf5282.h (new file)
>   		Kconfig (modified)
>   		Makefile (modified)
>   
>  linux/include/asm-m68knommu
>   		m528xsim.h (modified)
> 
>  Please let me know if you have any questions.

The patch was very wordwrapped by your email client.  Please fix that up
(first email the patch to yourself and test that the result still
applies OK) or
resend as an email attachment.

Thanks.

------=_NextPart_000_003A_01C53A2F.798217D0
Content-Type: application/octet-stream;
	name="linux_patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux_patch"

diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.c =
linux_dev/drivers/i2c/busses/i2c-mcf5282.c=0A=
--- linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.c	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/i2c-mcf5282.c	2005-04-05 =
19:21:55.000000000 -0400=0A=
@@ -0,0 +1,407 @@=0A=
+/*=0A=
+    i2c-mcf5282.c - Part of lm_sensors, Linux kernel modules for =
hardware monitoring=0A=
+=0A=
+    Copyright (c) 2005, Derek CL Cheung <derek.cheung@sympatico.ca>=0A=
+					<http://www3.sympatico.ca/derek.cheung>=0A=
+=0A=
+    This program is free software; you can redistribute it and/or modify=0A=
+    it under the terms of the GNU General Public License as published by=0A=
+    the Free Software Foundation; either version 2 of the License, or=0A=
+    (at your option) any later version.=0A=
+=0A=
+    This program is distributed in the hope that it will be useful,=0A=
+    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
+    GNU General Public License for more details.=0A=
+=0A=
+    You should have received a copy of the GNU General Public License=0A=
+    along with this program; if not, write to the Free Software=0A=
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+=0A=
+    Changes:=0A=
+    v0.1 	26 March 2005=0A=
+        	Initial Release - developed on uClinux with 2.6.9 kernel=0A=
+=0A=
+=0A=
+    This I2C adaptor supports the ColdFire 5282 CPU I2C module. Since =
most Coldfire=0A=
+    CPUs' I2C module use the same register set (e.g., MCF5249), the =
code is very=0A=
+    portable and re-usable to other Coldfire CPUs.=0A=
+=0A=
+    The transmission frequency is set at about 100KHz for the 5282Lite =
CPU board with=0A=
+    8MHz crystal. If the CPU board uses different system clock =
frequency, you should=0A=
+    change the following line:=0A=
+                static int __init i2c_mcf5282_init(void)=0A=
+                {=0A=
+                                .........=0A=
+                        // Set transmission frequency 0x15 =3D ~100kHz=0A=
+                        *MCF5282_I2C_I2FDR =3D 0x15;=0A=
+                                ........=0A=
+                }=0A=
+=0A=
+    Remember to perform a dummy read to set the ColdFire CPU's I2C =
module for read before=0A=
+    reading the actual byte from a device=0A=
+=0A=
+    The I2C_SM_BUS_BLOCK_DATA function are not yet ready but most =
lm_senors do not care=0A=
+=0A=
+*/=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/string.h>=0A=
+#include <asm/coldfire.h>=0A=
+#include <asm/m528xsim.h>=0A=
+#include <asm/types.h>=0A=
+#include "i2c-mcf5282.h"=0A=
+=0A=
+=0A=
+static struct i2c_algorithm mcf5282_algorithm =3D {=0A=
+	.name		=3D "MCF5282 I2C algorithm",=0A=
+	.id		=3D I2C_ALGO_SMBUS,=0A=
+	.smbus_xfer	=3D mcf5282_i2c_access,=0A=
+	.functionality	=3D mcf5282_func,=0A=
+};=0A=
+=0A=
+=0A=
+static struct i2c_adapter mcf5282_adapter =3D {=0A=
+	.owner		=3D THIS_MODULE,=0A=
+	.class          =3D I2C_CLASS_HWMON,=0A=
+	.algo		=3D &mcf5282_algorithm,=0A=
+	.name		=3D "MCF5282 I2C Adapter",=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  read one byte data from the I2C bus=0A=
+ */=0A=
+static int mcf5282_read_data(u8 * const rxData, const enum I2C_ACK_TYPE =
ackType) {=0A=
+=0A=
+        int timeout;=0A=
+=0A=
+	*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_MTX;     	// master receive =
mode=0A=
+=0A=
+	if (ackType =3D=3D NACK)=0A=
+		*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_TXAK;     // generate NA=0A=
+	else=0A=
+                *MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_TXAK;    // =
generate ACK=0A=
+=0A=
+=0A=
+	// read data from the I2C bus=0A=
+	*rxData =3D *MCF5282_I2C_I2DR; =0A=
+=0A=
+	// printk(">>> %s I2DR data is %.2x \n", __FUNCTION__, *rxData);=0A=
+=0A=
+        // wait for data transfer to complete =0A=
+        timeout =3D 500;=0A=
+        while (timeout-- && !(*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IIF))=0A=
+                udelay(1);=0A=
+        if (timeout <=3D 0) =0A=
+                printk("%s - I2C IIF never set. Timeout is %d \n", =
__FUNCTION__, timeout);=0A=
+        =0A=
+=0A=
+        // reset the interrupt bit =0A=
+        *MCF5282_I2C_I2SR &=3D ~MCF5282_I2C_I2SR_IIF;=0A=
+=0A=
+	if (timeout <=3D 0 ) =0A=
+                return -1;=0A=
+        else =0A=
+                return 0;=0A=
+=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  write one byte data onto the I2C bus=0A=
+ */=0A=
+static int mcf5282_write_data(const u8 txData) {=0A=
+	=0A=
+	int timeout;=0A=
+=0A=
+	timeout =3D 500;=0A=
+=0A=
+	*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_MTX;	// I2C module into TX mode=0A=
+	*MCF5282_I2C_I2DR =3D txData;			// send the data=0A=
+=0A=
+	// wait for data transfer to complete =0A=
+        // rely on the interrupt handling bit =0A=
+        timeout =3D 500;=0A=
+        while (timeout-- && !(*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IIF))=0A=
+                udelay(1);=0A=
+        if (timeout <=3D0) =0A=
+                printk("%s - I2C IIF never set. Timeout is %d \n", =
__FUNCTION__, timeout);=0A=
+        =0A=
+=0A=
+        // reset the interrupt bit=0A=
+        *MCF5282_I2C_I2SR &=3D ~MCF5282_I2C_I2SR_IIF;=0A=
+=0A=
+	if (timeout <=3D 0 ) =0A=
+                return -1;=0A=
+        else =0A=
+                return 0;=0A=
+=0A=
+};=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+/*=0A=
+ *  Generate I2C start or repeat start signal=0A=
+ *  Combine the 7 bit target_address and the R/W bit and put it onto =
the I2C bus=0A=
+ */=0A=
+static int mcf5282_i2c_start(const char read_write, const u16 =
target_address, const enum I2C_START_TYPE start_type) {=0A=
+=0A=
+	int timeout;		=0A=
+=0A=
+	// printk(">>> %s START TYPE %s \n", __FUNCTION__, start_type =3D=3D =
FIRST_START ? "FIRST_START" : "REPEAT_START");=0A=
+=0A=
+	*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_IEN;=0A=
+=0A=
+	if (start_type =3D=3D FIRST_START) {=0A=
+  		// Make sure the I2C bus is idle =0A=
+		timeout =3D 500;		// 500us timeout	=0A=
+        	while (timeout-- && (*MCF5282_I2C_I2SR & =
MCF5282_I2C_I2SR_IBB)) =0A=
+                	udelay(1);=0A=
+        	if (timeout <=3D 0) {=0A=
+                	printk("%s - I2C bus always busy in the past 500us =
timeout is %d \n", __FUNCTION__, timeout);=0A=
+                	goto check_rc;=0A=
+        	}=0A=
+		// generate a START and put the I2C module into MASTER TX mode =0A=
+		*MCF5282_I2C_I2CR |=3D (MCF5282_I2C_I2CR_MSTA | MCF5282_I2C_I2CR_MTX);=0A=
+=0A=
+		// wait for bus busy to be set =0A=
+        	timeout =3D 500;=0A=
+        	while (timeout-- && !(*MCF5282_I2C_I2SR & =
MCF5282_I2C_I2SR_IBB))=0A=
+                	udelay(1);=0A=
+        	if (timeout <=3D 0) {=0A=
+                	printk("%s - I2C bus is never busy after START. =
Timeout is %d \n", __FUNCTION__, timeout);=0A=
+                	goto check_rc;=0A=
+        	}=0A=
+=0A=
+	} else {=0A=
+		// this is repeat START =0A=
+		udelay(500);	// need some delay before repeat start =0A=
+		*MCF5282_I2C_I2CR |=3D (MCF5282_I2C_I2CR_MSTA | =
MCF5282_I2C_I2CR_RSTA);    =0A=
+	}=0A=
+ =0A=
+=0A=
+	// combine the R/W bit and the 7 bit target address and put it onto =
the I2C bus=0A=
+	*MCF5282_I2C_I2DR =3D ((target_address & 0x7F) << 1) | (read_write =
=3D=3D I2C_SMBUS_WRITE ? 0x00 : 0x01);=0A=
+=0A=
+	// wait for bus transfer to complete =0A=
+	// when one byte transfer is completed, IIF set at the faling edge of =
the 9th clock =0A=
+	timeout =3D 500;=0A=
+	while (timeout-- && !(*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IIF))=0A=
+		udelay(1);=0A=
+	if (timeout <=3D 0) =0A=
+		printk("%s - I2C IIF never set. Timeout is %d \n", __FUNCTION__, =
timeout);=0A=
+	=0A=
+=0A=
+check_rc:=0A=
+	// reset the interrupt bit =0A=
+	*MCF5282_I2C_I2SR &=3D ~MCF5282_I2C_I2SR_IIF;=0A=
+=0A=
+	if (timeout <=3D 0) =0A=
+		return -1;=0A=
+	else =0A=
+		return 0;=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  5282 SMBUS supporting functions=0A=
+ */=0A=
+=0A=
+static s32 mcf5282_i2c_access(struct i2c_adapter *adap, u16 addr, =0A=
+			      unsigned short flags, char read_write, =0A=
+			      u8 command, int size, union i2c_smbus_data *data) =0A=
+{=0A=
+	int i, len, rc =3D 0;=0A=
+        u8 rxData, tempRxData[2];=0A=
+	// u16 tempWord;=0A=
+=0A=
+#ifdef DEREK_DEBUG=0A=
+        dev_info(&adap->dev, "\n\n\n>>> %s was called with the =
following parameters:\n", __FUNCTION__);=0A=
+        dev_info(&adap->dev, "addr =3D %.4x\n", addr);=0A=
+        dev_info(&adap->dev, "flags =3D %.4x\n", flags);=0A=
+        dev_info(&adap->dev, "read_write =3D %s\n", read_write =3D=3D =
I2C_SMBUS_WRITE ? "write" : "read");=0A=
+        dev_info(&adap->dev, "command =3D %.2x\n", command);=0A=
+	dev_info(&adap->dev, "data =3D %.4x\n", data->word);=0A=
+	dev_info(&adap->dev, "size =3D %d\n", size);=0A=
+#endif=0A=
+=0A=
+        switch (size) {=0A=
+                case I2C_SMBUS_QUICK:=0A=
+			// dev_info(&adap->dev, "size =3D I2C_SMBUS_QUICK \n");	=0A=
+			rc =3D mcf5282_i2c_start(read_write, addr, FIRST_START); 	// =
generate START=0A=
+                        break;=0A=
+		case I2C_SMBUS_BYTE:=0A=
+			// dev_info(&adap->dev, "size =3D I2C_SMBUS_BYTE \n");=0A=
+			rc =3D mcf5282_i2c_start(read_write, addr, FIRST_START);=0A=
+			*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_TXAK;     	// generate NA=0A=
+			if (read_write =3D=3D I2C_SMBUS_WRITE) =0A=
+				rc +=3D mcf5282_write_data(command);=0A=
+			else {=0A=
+				mcf5282_read_data(&rxData, NACK);		// dummy read =0A=
+                                rc +=3D mcf5282_read_data(&rxData, =
NACK);=0A=
+				data->byte =3D rxData;=0A=
+			}=0A=
+			*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_TXAK;		// reset the ACK bit=0A=
+			break;=0A=
+        	case I2C_SMBUS_BYTE_DATA:=0A=
+			// dev_info(&adap->dev, "size =3D I2C_SMBUS_BYTE_DATA \n");=0A=
+			rc =3D mcf5282_i2c_start(I2C_SMBUS_WRITE, addr, FIRST_START);=0A=
+			rc +=3D mcf5282_write_data(command);=0A=
+			if (read_write =3D=3D I2C_SMBUS_WRITE) =0A=
+				rc +=3D mcf5282_write_data(data->byte);=0A=
+			else {	=0A=
+				// This is SMBus READ Byte Data Request. Perform REPEAT START=0A=
+				rc +=3D mcf5282_i2c_start(I2C_SMBUS_READ, addr, REPEAT_START);=0A=
+				mcf5282_read_data(&rxData, ACK);                // dummy read=0A=
+				// Disable Acknowledge, generate STOP after next byte transfer =0A=
+				rc +=3D mcf5282_read_data(&rxData, NACK);=0A=
+				data->byte =3D rxData;=0A=
+			}=0A=
+			*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_TXAK;		// reset to normal =
ACk=0A=
+			break;=0A=
+                case I2C_SMBUS_PROC_CALL:=0A=
+			// dev_info(&adap->dev, "size =3D I2C_SMBUS_PROC_CALL \n");=0A=
+        	case I2C_SMBUS_WORD_DATA:=0A=
+			dev_info(&adap->dev, "size =3D I2C_SMBUS_WORD_DATA \n");=0A=
+			rc =3D mcf5282_i2c_start(I2C_SMBUS_WRITE, addr, FIRST_START);=0A=
+			rc +=3D mcf5282_write_data(command);=0A=
+			if (read_write =3D=3D I2C_SMBUS_WRITE) {=0A=
+				rc +=3D mcf5282_write_data(data->word & 0x00FF);=0A=
+				rc +=3D mcf5282_write_data((data->word & 0x00FF) >> 8);=0A=
+			} else {	=0A=
+				// This is SMBUS READ WORD request. Peform REPEAT START=0A=
+				rc +=3D mcf5282_i2c_start(I2C_SMBUS_READ, addr, REPEAT_START);=0A=
+				mcf5282_read_data(&rxData, ACK);        // dummy read=0A=
+				// Disable Acknowledge, generate STOP after next byte transfer =0A=
+				// read the MS byte from the device=0A=
+				rc +=3D mcf5282_read_data(&rxData, NACK);=0A=
+				tempRxData[1] =3D rxData;	=0A=
+				// read the LS byte from the device	=0A=
+				rc +=3D mcf5282_read_data(&rxData, NACK);=0A=
+				tempRxData[0] =3D rxData;=0A=
+				// the host driver expect little endian convention. Swap the byte=0A=
+				data->word =3D (tempRxData[0] << 8) | tempRxData[1];=0A=
+				// printk("SMBUS_WORD_DATA is %.4x \n", data->word);=0A=
+			}=0A=
+			*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_TXAK;=0A=
+			break;=0A=
+        	case I2C_SMBUS_BLOCK_DATA:=0A=
+                	// dev_info(&adap->dev, "size =3D =
I2C_SMBUS_BLOCK_DATA\n");=0A=
+			// this is not yet ready!!!=0A=
+                	// if (read_write =3D=3D I2C_SMBUS_WRITE) {=0A=
+                        //	dev_info(&adap->dev, "data =3D %.4x\n", =
data->word);=0A=
+                        //	len =3D data->block[0];=0A=
+                        //	if (len < 0)=0A=
+                        //        	len =3D 0;=0A=
+                        //	if (len > 32)=0A=
+                        //        	len =3D 32;=0A=
+                        //	for (i =3D 1; i <=3D len; i++)=0A=
+                        //        	dev_info(&adap->dev, =
"data->block[%d] =3D %.2x\n", i, data->block[i]); =0A=
+			//} =0A=
+			break; =0A=
+		default:=0A=
+			printk("Unsupported I2C size \n");=0A=
+			rc =3D -1;=0A=
+			break;=0A=
+	};=0A=
+=0A=
+	// Generate a STOP and put I2C module into slave mode =0A=
+	*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_MSTA;=0A=
+=0A=
+	// restore interrupt =0A=
+	*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_IIEN;=0A=
+=0A=
+	if (rc < 0) =0A=
+		return -1;=0A=
+	else=0A=
+        	return 0;=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  List the SMBUS functions supported by this I2C adaptor=0A=
+ */=0A=
+static u32 mcf5282_func(struct i2c_adapter *adapter)=0A=
+{=0A=
+	return(I2C_FUNC_SMBUS_QUICK |=0A=
+	       I2C_FUNC_SMBUS_BYTE |=0A=
+	       I2C_FUNC_SMBUS_PROC_CALL |=0A=
+	       I2C_FUNC_SMBUS_BYTE_DATA |=0A=
+	       I2C_FUNC_SMBUS_WORD_DATA |=0A=
+	       I2C_FUNC_SMBUS_BLOCK_DATA);=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  Initalize the 5282 I2C module=0A=
+ *  Disable the 5282 I2C interrupt capability. Just use callback=0A=
+ */=0A=
+=0A=
+static int __init i2c_mcf5282_init(void)=0A=
+{=0A=
+	int retval;=0A=
+	u8  dummyRead;=0A=
+=0A=
+        // Initialize PASP0 and PASP1 to I2C functions - 5282 user =
guide 26-19 	=0A=
+	// Port AS Pin Assignment Register (PASPAR) 			=0A=
+	//		PASPA1 =3D 11 =3D AS1 pin is I2C SDA 	=0A=
+	//		PASPA0 =3D 11 =3D AS0 pin is I2C SCL =0A=
+        *MCF5282_GPIO_PASPAR |=3D 0x000F;		// u16 declaration=0A=
+=0A=
+    	// Set transmission frequency 0x15 =3D ~100kHz =0A=
+    	*MCF5282_I2C_I2FDR =3D 0x15;=0A=
+=0A=
+	// set the 5282 I2C slave address thought we never use it =0A=
+    	*MCF5282_I2C_I2ADR =3D 0x6A;=0A=
+=0A=
+    	// Enable I2C module and if IBB is set, do the special =
initialzation=0A=
+	// procedures as are documented at the 5282 User Guide page 24-11=0A=
+    	*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_IEN; =0A=
+	if ((*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IBB) =3D=3D 1) {=0A=
+		printk("%s - do special 5282 I2C init procedures \n", __FUNCTION__);=0A=
+		*MCF5282_I2C_I2CR =3D 0x00;=0A=
+		*MCF5282_I2C_I2CR =3D 0xA0;=0A=
+		dummyRead =3D *MCF5282_I2C_I2DR;=0A=
+		*MCF5282_I2C_I2SR =3D 0x00;=0A=
+		*MCF5282_I2C_I2CR =3D 0x00;=0A=
+	}=0A=
+	   =0A=
+	// default I2C mode is - slave and receive  =0A=
+	*MCF5282_I2C_I2CR &=3D ~(MCF5282_I2C_I2CR_MSTA | =
MCF5282_I2C_I2CR_MTX);	=0A=
+=0A=
+	retval =3D i2c_add_adapter(&mcf5282_adapter);=0A=
+=0A=
+	if (retval < 0)=0A=
+		printk("%s - return code is: %d \n", __FUNCTION__, retval);=0A=
+=0A=
+	return retval;=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  I2C module exit function=0A=
+ */=0A=
+=0A=
+static void __exit i2c_mcf5282_exit(void)=0A=
+{=0A=
+	/* disable I2C and Interrupt */=0A=
+	*MCF5282_I2C_I2CR &=3D ~(MCF5282_I2C_I2CR_IEN | =
MCF5282_I2C_I2CR_IIEN); =0A=
+	i2c_del_adapter(&mcf5282_adapter);=0A=
+=0A=
+};=0A=
+=0A=
+=0A=
+MODULE_AUTHOR("Derek CL Cheung <derek.cheung@sympatico.ca>");=0A=
+MODULE_DESCRIPTION("MCF5282 I2C adaptor");=0A=
+MODULE_LICENSE("GPL");=0A=
+=0A=
+module_init(i2c_mcf5282_init);=0A=
+module_exit(i2c_mcf5282_exit);=0A=
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.h =
linux_dev/drivers/i2c/busses/i2c-mcf5282.h=0A=
--- linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/i2c-mcf5282.h	2005-04-05 =
19:22:00.000000000 -0400=0A=
@@ -0,0 +1,45 @@=0A=
+/*
+    i2c-mcf5282.h - header file for i2c-mcf5282.c
+
+    Copyright (c) 2005, Derek CL Cheung <derek.cheung@sympatico.ca>
+                                        =
<http://www3.sympatico.ca/derek.cheung>
+
+    This program is free software; you can redistribute it and/or =
modify
+    it under the terms of the GNU General Public License as published =
by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+    Changes:
+    v0.1	26 March 2005
+        	Initial Release - developed on uClinux with 2.6.9 kernel
+
+*/
+
+
+#ifndef __I2C_MCF5282_H__
+#define __I2C_MCF5282_H__
+
+enum I2C_START_TYPE { FIRST_START, REPEAT_START };
+enum I2C_ACK_TYPE { ACK, NACK};
+
+/* Function prototypes */
+static u32 mcf5282_func(struct i2c_adapter *adapter);
+static s32 mcf5282_i2c_access(struct i2c_adapter *adap, u16 address,
+                              unsigned short flags, char read_write,
+                              u8 command, int size, union =
i2c_smbus_data *data);
+static int mcf5282_write_data(const u8 data);
+static int mcf5282_i2c_start(const char read_write, const u16 =
target_address, const enum I2C_START_TYPE i2c_start);
+static int mcf5282_read_data(u8 * const rxData, const enum I2C_ACK_TYPE =
ackType);=20
+void dumpReg(char *, u16 addr, u8 data);
+
+/********************************************************************/
+#endif /*  __I2C_MCF5282_H__ */
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/Kconfig =
linux_dev/drivers/i2c/busses/Kconfig=0A=
--- linux-2.6.11.6/drivers/i2c/busses/Kconfig	2005-03-25 =
22:28:29.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/Kconfig	2005-04-05 19:30:09.000000000 =
-0400=0A=
@@ -29,6 +29,16 @@ config I2C_ALI1563=0A=
 	  This driver can also be built as a module.  If so, the module=0A=
 	  will be called i2c-ali1563.=0A=
 =0A=
+config I2C_MCF5282LITE=0A=
+        tristate "MCF5282Lite"=0A=
+        depends on I2C && EXPERIMENTAL=0A=
+        help=0A=
+          If you say yes to this option, support will be included for =
the=0A=
+          I2C on the ColdFire MCF5282Lite Development Board=0A=
+=0A=
+          This driver can also be built as a module.  If so, the module=0A=
+          will be called i2c-mcf5282lite.=0A=
+=0A=
 config I2C_ALI15X3=0A=
 	tristate "ALI 15x3"=0A=
 	depends on I2C && PCI && EXPERIMENTAL=0A=
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/Kconfig.orig =
linux_dev/drivers/i2c/busses/Kconfig.orig=0A=
--- linux-2.6.11.6/drivers/i2c/busses/Kconfig.orig	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/Kconfig.orig	2005-04-05 =
19:09:18.000000000 -0400=0A=
@@ -0,0 +1,489 @@=0A=
+#=0A=
+# Sensor device configuration=0A=
+#=0A=
+=0A=
+menu "I2C Hardware Bus support"=0A=
+	depends on I2C=0A=
+=0A=
+config I2C_ALI1535=0A=
+	tristate "ALI 1535"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the SMB=0A=
+	  Host controller on Acer Labs Inc. (ALI) M1535 South Bridges.  The SMB=0A=
+	  controller is part of the 7101 device, which is an ACPI-compliant=0A=
+	  Power Management Unit (PMU).=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-ali1535.=0A=
+=0A=
+config I2C_ALI1563=0A=
+	tristate "ALI 1563"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the SMB=0A=
+	  Host controller on Acer Labs Inc. (ALI) M1563 South Bridges.  The SMB=0A=
+	  controller is part of the 7101 device, which is an ACPI-compliant=0A=
+	  Power Management Unit (PMU).=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-ali1563.=0A=
+=0A=
+config I2C_ALI15X3=0A=
+	tristate "ALI 15x3"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the=0A=
+	  Acer Labs Inc. (ALI) M1514 and M1543 motherboard I2C interfaces.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-ali15x3.=0A=
+=0A=
+config I2C_AMD756=0A=
+	tristate "AMD 756/766/768/8111 and nVidia nForce"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the AMD=0A=
+	  756/766/768 mainboard I2C interfaces.  The driver also includes=0A=
+	  support for the first (SMBus 1.0) I2C interface of the AMD 8111 and=0A=
+	  the nVidia nForce I2C interface.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-amd756.=0A=
+=0A=
+config I2C_AMD756_S4882=0A=
+	tristate "SMBus multiplexing on the Tyan S4882"=0A=
+	depends on I2C_AMD756 && EXPERIMENTAL=0A=
+	help=0A=
+	  Enabling this option will add specific SMBus support for the Tyan=0A=
+	  S4882 motherboard.  On this 4-CPU board, the SMBus is multiplexed=0A=
+	  over 8 different channels, where the various memory module EEPROMs=0A=
+	  and temperature sensors live.  Saying yes here will give you access=0A=
+	  to these in addition to the trunk.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-amd756-s4882.=0A=
+=0A=
+config I2C_AMD8111=0A=
+	tristate "AMD 8111"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the=0A=
+	  second (SMBus 2.0) AMD 8111 mainboard I2C interface.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-amd8111.=0A=
+=0A=
+config I2C_AU1550=0A=
+	tristate "Au1550 SMBus interface"=0A=
+	depends on I2C && SOC_AU1550=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the=0A=
+	  Au1550 SMBus interface.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-au1550.=0A=
+=0A=
+config I2C_ELEKTOR=0A=
+	tristate "Elektor ISA card"=0A=
+	depends on I2C && ISA && BROKEN_ON_SMP=0A=
+	select I2C_ALGOPCF=0A=
+	help=0A=
+	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own=0A=
+	  such an adapter.=0A=
+=0A=
+	  This support is also available as a module.  If so, the module =0A=
+	  will be called i2c-elektor.=0A=
+=0A=
+config I2C_HYDRA=0A=
+	tristate "CHRP Apple Hydra Mac I/O I2C interface"=0A=
+	depends on I2C && PCI && PPC_CHRP && EXPERIMENTAL=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  This supports the use of the I2C interface in the Apple Hydra Mac=0A=
+	  I/O chip on some CHRP machines (e.g. the LongTrail).  Say Y if you=0A=
+	  have such a machine.=0A=
+=0A=
+	  This support is also available as a module.  If so, the module=0A=
+	  will be called i2c-hydra.=0A=
+=0A=
+config I2C_I801=0A=
+	tristate "Intel 801"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the Intel=0A=
+	  801 family of mainboard I2C interfaces.  Specifically, the following=0A=
+	  versions of the chipset are supported:=0A=
+	    82801AA=0A=
+	    82801AB=0A=
+	    82801BA=0A=
+	    82801CA/CAM=0A=
+	    82801DB=0A=
+	    82801EB=0A=
+	    6300ESB=0A=
+	    ICH6=0A=
+	    ICH7=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-i801.=0A=
+=0A=
+config I2C_I810=0A=
+	tristate "Intel 810/815"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the Intel=0A=
+	  810/815 family of mainboard I2C interfaces.  Specifically, the =0A=
+	  following versions of the chipset is supported:=0A=
+	    i810AA=0A=
+	    i810AB=0A=
+	    i810E=0A=
+	    i815=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-i810.=0A=
+=0A=
+config I2C_IBM_IIC=0A=
+	tristate "IBM PPC 4xx on-chip I2C interface"=0A=
+	depends on IBM_OCP && I2C=0A=
+	help=0A=
+	  Say Y here if you want to use IIC peripheral found on =0A=
+	  embedded IBM PPC 4xx based systems. =0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-ibm_iic.=0A=
+=0A=
+config I2C_IOP3XX=0A=
+	tristate "Intel IOP3xx and IXP4xx on-chip I2C interface"=0A=
+	depends on (ARCH_IOP3XX || ARCH_IXP4XX) && I2C=0A=
+	help=0A=
+	  Say Y here if you want to use the IIC bus controller on=0A=
+	  the Intel IOP3xx I/O Processors or IXP4xx Network Processors.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-iop3xx.=0A=
+=0A=
+config I2C_ISA=0A=
+	tristate "ISA Bus support"=0A=
+	depends on I2C && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for i2c=0A=
+	  interfaces that are on the ISA bus.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-isa.=0A=
+=0A=
+config I2C_ITE=0A=
+	tristate "ITE I2C Adapter"=0A=
+	depends on I2C && MIPS_ITE8172=0A=
+	select I2C_ALGOITE=0A=
+	help=0A=
+	  This supports the ITE8172 I2C peripheral found on some MIPS=0A=
+	  systems. Say Y if you have one of these. You should also say Y for=0A=
+	  the ITE I2C driver algorithm support above.=0A=
+=0A=
+	  This support is also available as a module.  If so, the module =0A=
+	  will be called i2c-ite.=0A=
+=0A=
+config I2C_IXP4XX=0A=
+	tristate "IXP4xx GPIO-Based I2C Interface"=0A=
+	depends on I2C && ARCH_IXP4XX=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  Say Y here if you have an Intel IXP4xx(420,421,422,425) based =0A=
+	  system and are using GPIO lines for an I2C bus.=0A=
+=0A=
+	  This support is also available as a module. If so, the module=0A=
+	  will be called i2c-ixp4xx.=0A=
+=0A=
+config I2C_IXP2000=0A=
+	tristate "IXP2000 GPIO-Based I2C Interface"=0A=
+	depends on I2C && ARCH_IXP2000=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  Say Y here if you have an Intel IXP2000(2400, 2800, 2850) based =0A=
+	  system and are using GPIO lines for an I2C bus.=0A=
+=0A=
+	  This support is also available as a module. If so, the module=0A=
+	  will be called i2c-ixp2000.=0A=
+=0A=
+config I2C_KEYWEST=0A=
+	tristate "Powermac Keywest I2C interface"=0A=
+	depends on I2C && PPC_PMAC=0A=
+	help=0A=
+	  This supports the use of the I2C interface in the combo-I/O=0A=
+	  chip on recent Apple machines.  Say Y if you have such a machine.=0A=
+=0A=
+	  This support is also available as a module.  If so, the module =0A=
+	  will be called i2c-keywest.=0A=
+=0A=
+config I2C_MPC=0A=
+	tristate "MPC107/824x/85xx/52xx"=0A=
+	depends on I2C && PPC=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the=0A=
+	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and=0A=
+	  MPC85xx family processors. The driver may also work on 52xx=0A=
+	  family processors, though interrupts are known not to work.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-mpc.=0A=
+=0A=
+config I2C_NFORCE2=0A=
+	tristate "Nvidia Nforce2"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the =
Nvidia=0A=
+	  Nforce2 family of mainboard I2C interfaces.=0A=
+	  This driver also supports the nForce3 Pro 150 MCP.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-nforce2.=0A=
+=0A=
+config I2C_PARPORT=0A=
+	tristate "Parallel port adapter"=0A=
+	depends on I2C && PARPORT=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  This supports parallel port I2C adapters such as the ones made by=0A=
+	  Philips or Velleman, Analog Devices evaluation boards, and more.=0A=
+	  Basically any adapter using the parallel port as an I2C bus with=0A=
+	  no extra chipset is supported by this driver, or could be.=0A=
+=0A=
+	  This driver is a replacement for (and was inspired by) an older=0A=
+	  driver named i2c-philips-par.  The new driver supports more devices,=0A=
+	  and makes it easier to add support for new devices.=0A=
+	  =0A=
+	  Another driver exists, named i2c-parport-light, which doesn't depend=0A=
+	  on the parport driver.  This is meant for embedded systems. Don't say=0A=
+	  Y here if you intend to say Y or M there.=0A=
+=0A=
+	  This support is also available as a module.  If so, the module =0A=
+	  will be called i2c-parport.=0A=
+=0A=
+config I2C_PARPORT_LIGHT=0A=
+	tristate "Parallel port adapter (light)"=0A=
+	depends on I2C=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  This supports parallel port I2C adapters such as the ones made by=0A=
+	  Philips or Velleman, Analog Devices evaluation boards, and more.=0A=
+	  Basically any adapter using the parallel port as an I2C bus with=0A=
+	  no extra chipset is supported by this driver, or could be.=0A=
+=0A=
+	  This driver is a light version of i2c-parport.  It doesn't depend=0A=
+	  on the parport driver, and uses direct I/O access instead.  This=0A=
+	  might be prefered on embedded systems where wasting memory for=0A=
+	  the clean but heavy parport handling is not an option.  The=0A=
+	  drawback is a reduced portability and the impossibility to=0A=
+	  dasiy-chain other parallel port devices.=0A=
+	  =0A=
+	  Don't say Y here if you said Y or M to i2c-parport.  Saying M to=0A=
+	  both is possible but both modules should not be loaded at the same=0A=
+	  time.=0A=
+=0A=
+	  This support is also available as a module.  If so, the module =0A=
+	  will be called i2c-parport-light.=0A=
+=0A=
+config I2C_PIIX4=0A=
+	tristate "Intel PIIX4"=0A=
+	depends on I2C && PCI && EXPERIMENTAL && !64BIT=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the Intel=0A=
+	  PIIX4 family of mainboard I2C interfaces.  Specifically, the =
following=0A=
+	  versions of the chipset are supported:=0A=
+	    Intel PIIX4=0A=
+	    Intel 440MX=0A=
+	    Serverworks OSB4=0A=
+	    Serverworks CSB5=0A=
+	    Serverworks CSB6=0A=
+	    SMSC Victory66=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-piix4.=0A=
+=0A=
+config I2C_PROSAVAGE=0A=
+	tristate "S3/VIA (Pro)Savage"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the=0A=
+	  I2C bus and DDC bus of the S3VIA embedded Savage4 and ProSavage8=0A=
+	  graphics processors.=0A=
+	  chipsets supported:=0A=
+	    S3/VIA KM266/VT8375 aka ProSavage8=0A=
+	    S3/VIA KM133/VT8365 aka Savage4=0A=
+=0A=
+	  This support is also available as a module.  If so, the module =0A=
+	  will be called i2c-prosavage.=0A=
+=0A=
+config I2C_RPXLITE=0A=
+	tristate "Embedded Planet RPX Lite/Classic support"=0A=
+	depends on (RPXLITE || RPXCLASSIC) && I2C=0A=
+	select I2C_ALGO8XX=0A=
+=0A=
+config I2C_S3C2410=0A=
+	tristate "S3C2410 I2C Driver"=0A=
+	depends on I2C && ARCH_S3C2410=0A=
+	help=0A=
+	  Say Y here to include support for I2C controller in the=0A=
+	  Samsung S3C2410 based System-on-Chip devices.=0A=
+=0A=
+config I2C_SAVAGE4=0A=
+	tristate "S3 Savage 4"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the =0A=
+	  S3 Savage 4 I2C interface.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-savage4.=0A=
+=0A=
+config I2C_SIBYTE=0A=
+	tristate "SiByte SMBus interface"=0A=
+	depends on SIBYTE_SB1xxx_SOC && I2C=0A=
+	help=0A=
+	  Supports the SiByte SOC on-chip I2C interfaces (2 channels).=0A=
+=0A=
+config SCx200_I2C=0A=
+	tristate "NatSemi SCx200 I2C using GPIO pins"=0A=
+	depends on SCx200_GPIO && I2C=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.=0A=
+=0A=
+	  If you don't know what to do here, say N.=0A=
+=0A=
+	  This support is also available as a module.  If so, the module =0A=
+	  will be called scx200_i2c.=0A=
+=0A=
+config SCx200_I2C_SCL=0A=
+	int "GPIO pin used for SCL"=0A=
+	depends on SCx200_I2C=0A=
+	default "12"=0A=
+	help=0A=
+	  Enter the GPIO pin number used for the SCL signal.  This value can=0A=
+	  also be specified with a module parameter.=0A=
+=0A=
+config SCx200_I2C_SDA=0A=
+	int "GPIO pin used for SDA"=0A=
+	depends on SCx200_I2C=0A=
+	default "13"=0A=
+	help=0A=
+	  Enter the GPIO pin number used for the SSA signal.  This value can=0A=
+	  also be specified with a module parameter.=0A=
+=0A=
+config SCx200_ACB=0A=
+	tristate "NatSemi SCx200 ACCESS.bus"=0A=
+	depends on I2C && PCI=0A=
+	help=0A=
+	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.=0A=
+=0A=
+	  If you don't know what to do here, say N.=0A=
+=0A=
+	  This support is also available as a module.  If so, the module =0A=
+	  will be called scx200_acb.=0A=
+=0A=
+config I2C_SIS5595=0A=
+	tristate "SiS 5595"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the =0A=
+	  SiS5595 SMBus (a subset of I2C) interface.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-sis5595.=0A=
+=0A=
+config I2C_SIS630=0A=
+	tristate "SiS 630/730"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the =0A=
+	  SiS630 and SiS730 SMBus (a subset of I2C) interface.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-sis630.=0A=
+=0A=
+config I2C_SIS96X=0A=
+	tristate "SiS 96x"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the SiS=0A=
+	  96x SMBus (a subset of I2C) interfaces.  Specifically, the following=0A=
+	  chipsets are supported:=0A=
+	    645/961=0A=
+	    645DX/961=0A=
+	    645DX/962=0A=
+	    648/961=0A=
+	    650/961=0A=
+	    735=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-sis96x.=0A=
+=0A=
+config I2C_STUB=0A=
+	tristate "I2C/SMBus Test Stub"=0A=
+	depends on I2C && EXPERIMENTAL && 'm'=0A=
+	default 'n'=0A=
+	help=0A=
+	  This module may be useful to developers of SMBus client drivers,=0A=
+	  especially for certain kinds of sensor chips.=0A=
+=0A=
+	  If you do build this module, be sure to read the notes and warnings=0A=
+	  in <file:Documentation/i2c/i2c-stub>.=0A=
+=0A=
+	  If you don't know what to do here, definitely say N.=0A=
+=0A=
+config I2C_VIA=0A=
+	tristate "VIA 82C586B"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the VIA=0A=
+          82C586B I2C interface=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-via.=0A=
+=0A=
+config I2C_VIAPRO=0A=
+	tristate "VIA 82C596/82C686/823x"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the VIA=0A=
+	  82C596/82C686/823x I2C interfaces.  Specifically, the following =0A=
+	  chipsets are supported:=0A=
+	  82C596A/B=0A=
+	  82C686A/B=0A=
+	  8231=0A=
+	  8233=0A=
+	  8233A=0A=
+	  8235=0A=
+	  8237=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-viapro.=0A=
+=0A=
+config I2C_VOODOO3=0A=
+	tristate "Voodoo 3"=0A=
+	depends on I2C && PCI && EXPERIMENTAL=0A=
+	select I2C_ALGOBIT=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the=0A=
+	  Voodoo 3 I2C interface.=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-voodoo3.=0A=
+=0A=
+config I2C_PCA_ISA=0A=
+	tristate "PCA9564 on an ISA bus"=0A=
+	depends on I2C=0A=
+	select I2C_ALGOPCA=0A=
+	help=0A=
+	  This driver supports ISA boards using the Philips PCA 9564=0A=
+	  Parallel bus to I2C bus controller=0A=
+	  =0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-pca-isa.=0A=
+=0A=
+endmenu=0A=
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/Makefile =
linux_dev/drivers/i2c/busses/Makefile=0A=
--- linux-2.6.11.6/drivers/i2c/busses/Makefile	2005-03-25 =
22:28:39.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/Makefile	2005-04-05 19:28:14.000000000 =
-0400=0A=
@@ -40,6 +40,8 @@ obj-$(CONFIG_I2C_VIAPRO)	+=3D i2c-viapro.o=0A=
 obj-$(CONFIG_I2C_VOODOO3)	+=3D i2c-voodoo3.o=0A=
 obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o=0A=
 obj-$(CONFIG_SCx200_I2C)	+=3D scx200_i2c.o=0A=
+obj-$(CONFIG_I2C_MCF5282LITE)   +=3D i2c-mcf5282.o=0A=
+=0A=
 =0A=
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)=0A=
 EXTRA_CFLAGS +=3D -DDEBUG=0A=
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/Makefile.orig =
linux_dev/drivers/i2c/busses/Makefile.orig=0A=
--- linux-2.6.11.6/drivers/i2c/busses/Makefile.orig	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/Makefile.orig	2005-04-05 =
19:09:18.000000000 -0400=0A=
@@ -0,0 +1,46 @@=0A=
+#=0A=
+# Makefile for the i2c bus drivers.=0A=
+#=0A=
+=0A=
+obj-$(CONFIG_I2C_ALI1535)	+=3D i2c-ali1535.o=0A=
+obj-$(CONFIG_I2C_ALI1563)	+=3D i2c-ali1563.o=0A=
+obj-$(CONFIG_I2C_ALI15X3)	+=3D i2c-ali15x3.o=0A=
+obj-$(CONFIG_I2C_AMD756)	+=3D i2c-amd756.o=0A=
+obj-$(CONFIG_I2C_AMD756_S4882)	+=3D i2c-amd756-s4882.o=0A=
+obj-$(CONFIG_I2C_AMD8111)	+=3D i2c-amd8111.o=0A=
+obj-$(CONFIG_I2C_AU1550)	+=3D i2c-au1550.o=0A=
+obj-$(CONFIG_I2C_ELEKTOR)	+=3D i2c-elektor.o=0A=
+obj-$(CONFIG_I2C_HYDRA)		+=3D i2c-hydra.o=0A=
+obj-$(CONFIG_I2C_I801)		+=3D i2c-i801.o=0A=
+obj-$(CONFIG_I2C_I810)		+=3D i2c-i810.o=0A=
+obj-$(CONFIG_I2C_IBM_IIC)	+=3D i2c-ibm_iic.o=0A=
+obj-$(CONFIG_I2C_IOP3XX)	+=3D i2c-iop3xx.o=0A=
+obj-$(CONFIG_I2C_ISA)		+=3D i2c-isa.o=0A=
+obj-$(CONFIG_I2C_ITE)		+=3D i2c-ite.o=0A=
+obj-$(CONFIG_I2C_IXP2000)	+=3D i2c-ixp2000.o=0A=
+obj-$(CONFIG_I2C_IXP4XX)	+=3D i2c-ixp4xx.o=0A=
+obj-$(CONFIG_I2C_KEYWEST)	+=3D i2c-keywest.o=0A=
+obj-$(CONFIG_I2C_MPC)		+=3D i2c-mpc.o=0A=
+obj-$(CONFIG_I2C_NFORCE2)	+=3D i2c-nforce2.o=0A=
+obj-$(CONFIG_I2C_PARPORT)	+=3D i2c-parport.o=0A=
+obj-$(CONFIG_I2C_PARPORT_LIGHT)	+=3D i2c-parport-light.o=0A=
+obj-$(CONFIG_I2C_PCA_ISA)	+=3D i2c-pca-isa.o=0A=
+obj-$(CONFIG_I2C_PIIX4)		+=3D i2c-piix4.o=0A=
+obj-$(CONFIG_I2C_PROSAVAGE)	+=3D i2c-prosavage.o=0A=
+obj-$(CONFIG_I2C_RPXLITE)	+=3D i2c-rpx.o=0A=
+obj-$(CONFIG_I2C_S3C2410)	+=3D i2c-s3c2410.o=0A=
+obj-$(CONFIG_I2C_SAVAGE4)	+=3D i2c-savage4.o=0A=
+obj-$(CONFIG_I2C_SIBYTE)	+=3D i2c-sibyte.o=0A=
+obj-$(CONFIG_I2C_SIS5595)	+=3D i2c-sis5595.o=0A=
+obj-$(CONFIG_I2C_SIS630)	+=3D i2c-sis630.o=0A=
+obj-$(CONFIG_I2C_SIS96X)	+=3D i2c-sis96x.o=0A=
+obj-$(CONFIG_I2C_STUB)		+=3D i2c-stub.o=0A=
+obj-$(CONFIG_I2C_VIA)		+=3D i2c-via.o=0A=
+obj-$(CONFIG_I2C_VIAPRO)	+=3D i2c-viapro.o=0A=
+obj-$(CONFIG_I2C_VOODOO3)	+=3D i2c-voodoo3.o=0A=
+obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o=0A=
+obj-$(CONFIG_SCx200_I2C)	+=3D scx200_i2c.o=0A=
+=0A=
+ifeq ($(CONFIG_I2C_DEBUG_BUS),y)=0A=
+EXTRA_CFLAGS +=3D -DDEBUG=0A=
+endif=0A=
diff -uprN -X dontdiff linux-2.6.11.6/include/asm-m68knommu/m528xsim.h =
linux_dev/include/asm-m68knommu/m528xsim.h=0A=
--- linux-2.6.11.6/include/asm-m68knommu/m528xsim.h	2005-03-25 =
22:28:13.000000000 -0500=0A=
+++ linux_dev/include/asm-m68knommu/m528xsim.h	2005-04-05 =
19:17:45.000000000 -0400=0A=
@@ -41,5 +41,117 @@=0A=
 #define	MCFSIM_DACR1		0x50		/* SDRAM base address 1 */=0A=
 #define	MCFSIM_DMR1		0x54		/* SDRAM address mask 1 */=0A=
 =0A=
+/*=0A=
+ *	Derek Cheung - 6 Feb 2005=0A=
+ *		add I2C and QSPI register definition using Freescale's MCF5282=0A=
+ */=0A=
+/* set Port AS pin for I2C or UART */=0A=
+#define MCF5282_GPIO_PASPAR     (volatile u16 *) (MCF_IPSBAR + =
0x00100056)=0A=
+=0A=
+/* Interrupt Mask Register Register Low */ =0A=
+#define MCF5282_INTC0_IMRL      (volatile u32 *) (MCF_IPSBAR + 0x0C0C)=0A=
+/* Interrupt Control Register 7 */=0A=
+#define MCF5282_INTC0_ICR17     (volatile u8 *) (MCF_IPSBAR + 0x0C51)=0A=
+=0A=
+=0A=
+=0A=
+/*********************************************************************=0A=
+*=0A=
+* Inter-IC (I2C) Module=0A=
+*=0A=
+*********************************************************************/=0A=
+/* Read/Write access macros for general use */=0A=
+#define MCF5282_I2C_I2ADR       (volatile u8 *) (MCF_IPSBAR + 0x0300) =
// Address =0A=
+#define MCF5282_I2C_I2FDR       (volatile u8 *) (MCF_IPSBAR + 0x0304) =
// Freq Divider=0A=
+#define MCF5282_I2C_I2CR        (volatile u8 *) (MCF_IPSBAR + 0x0308) =
// Control=0A=
+#define MCF5282_I2C_I2SR        (volatile u8 *) (MCF_IPSBAR + 0x030C) =
// Status=0A=
+#define MCF5282_I2C_I2DR        (volatile u8 *) (MCF_IPSBAR + 0x0310) =
// Data I/O=0A=
+=0A=
+/* Bit level definitions and macros */=0A=
+#define MCF5282_I2C_I2ADR_ADDR(x)                       =
(((x)&0x7F)<<0x01)=0A=
+=0A=
+#define MCF5282_I2C_I2FDR_IC(x)                         (((x)&0x3F))=0A=
+=0A=
+#define MCF5282_I2C_I2CR_IEN    (0x80)	// I2C enable=0A=
+#define MCF5282_I2C_I2CR_IIEN   (0x40)  // interrupt enable=0A=
+#define MCF5282_I2C_I2CR_MSTA   (0x20)  // master/slave mode=0A=
+#define MCF5282_I2C_I2CR_MTX    (0x10)  // transmit/receive mode=0A=
+#define MCF5282_I2C_I2CR_TXAK   (0x08)  // transmit acknowledge enable=0A=
+#define MCF5282_I2C_I2CR_RSTA   (0x04)  // repeat start=0A=
+=0A=
+#define MCF5282_I2C_I2SR_ICF    (0x80)  // data transfer bit=0A=
+#define MCF5282_I2C_I2SR_IAAS   (0x40)  // I2C addressed as a slave=0A=
+#define MCF5282_I2C_I2SR_IBB    (0x20)  // I2C bus busy=0A=
+#define MCF5282_I2C_I2SR_IAL    (0x10)  // aribitration lost=0A=
+#define MCF5282_I2C_I2SR_SRW    (0x04)  // slave read/write=0A=
+#define MCF5282_I2C_I2SR_IIF    (0x02)  // I2C interrupt=0A=
+#define MCF5282_I2C_I2SR_RXAK   (0x01)  // received acknowledge=0A=
+=0A=
+=0A=
+=0A=
+/*********************************************************************=0A=
+*=0A=
+* Queued Serial Peripheral Interface (QSPI) Module=0A=
+*=0A=
+*********************************************************************/=0A=
+/* Derek - 21 Feb 2005 */=0A=
+/* change to the format used in I2C */=0A=
+/* Read/Write access macros for general use */=0A=
+#define MCF5282_QSPI_QMR        MCF_IPSBAR + 0x0340=0A=
+#define MCF5282_QSPI_QDLYR      MCF_IPSBAR + 0x0344=0A=
+#define MCF5282_QSPI_QWR        MCF_IPSBAR + 0x0348=0A=
+#define MCF5282_QSPI_QIR        MCF_IPSBAR + 0x034C=0A=
+#define MCF5282_QSPI_QAR        MCF_IPSBAR + 0x0350=0A=
+#define MCF5282_QSPI_QDR        MCF_IPSBAR + 0x0354=0A=
+#define MCF5282_QSPI_QCR        MCF_IPSBAR + 0x0354=0A=
+=0A=
+/* Bit level definitions and macros */=0A=
+#define MCF5282_QSPI_QMR_MSTR                           (0x8000)=0A=
+#define MCF5282_QSPI_QMR_DOHIE                          (0x4000)=0A=
+#define MCF5282_QSPI_QMR_BITS_16                        (0x0000)=0A=
+#define MCF5282_QSPI_QMR_BITS_8                         (0x2000)=0A=
+#define MCF5282_QSPI_QMR_BITS_9                         (0x2400)=0A=
+#define MCF5282_QSPI_QMR_BITS_10                        (0x2800)=0A=
+#define MCF5282_QSPI_QMR_BITS_11                        (0x2C00)=0A=
+#define MCF5282_QSPI_QMR_BITS_12                        (0x3000)=0A=
+#define MCF5282_QSPI_QMR_BITS_13                        (0x3400)=0A=
+#define MCF5282_QSPI_QMR_BITS_14                        (0x3800)=0A=
+#define MCF5282_QSPI_QMR_BITS_15                        (0x3C00)=0A=
+#define MCF5282_QSPI_QMR_CPOL                           (0x0200)=0A=
+#define MCF5282_QSPI_QMR_CPHA                           (0x0100)=0A=
+#define MCF5282_QSPI_QMR_BAUD(x)                        (((x)&0x00FF))=0A=
+=0A=
+#define MCF5282_QSPI_QDLYR_SPE                          (0x80)=0A=
+#define MCF5282_QSPI_QDLYR_QCD(x)                       =
(((x)&0x007F)<<8)=0A=
+#define MCF5282_QSPI_QDLYR_DTL(x)                       (((x)&0x00FF))=0A=
+=0A=
+#define MCF5282_QSPI_QWR_HALT                           (0x8000)=0A=
+#define MCF5282_QSPI_QWR_WREN                           (0x4000)=0A=
+#define MCF5282_QSPI_QWR_WRTO                           (0x2000)=0A=
+#define MCF5282_QSPI_QWR_CSIV                           (0x1000)=0A=
+#define MCF5282_QSPI_QWR_ENDQP(x)                       =
(((x)&0x000F)<<8)=0A=
+#define MCF5282_QSPI_QWR_CPTQP(x)                       =
(((x)&0x000F)<<4)=0A=
+#define MCF5282_QSPI_QWR_NEWQP(x)                       (((x)&0x000F))=0A=
+=0A=
+#define MCF5282_QSPI_QIR_WCEFB                          (0x8000)=0A=
+#define MCF5282_QSPI_QIR_ABRTB                          (0x4000)=0A=
+#define MCF5282_QSPI_QIR_ABRTL                          (0x1000)=0A=
+#define MCF5282_QSPI_QIR_WCEFE                          (0x0800)=0A=
+#define MCF5282_QSPI_QIR_ABRTE                          (0x0400)=0A=
+#define MCF5282_QSPI_QIR_SPIFE                          (0x0100)=0A=
+#define MCF5282_QSPI_QIR_WCEF                           (0x0008)=0A=
+#define MCF5282_QSPI_QIR_ABRT                           (0x0004)=0A=
+#define MCF5282_QSPI_QIR_SPIF                           (0x0001)=0A=
+=0A=
+#define MCF5282_QSPI_QAR_ADDR(x)                        (((x)&0x003F))=0A=
+=0A=
+#define MCF5282_QSPI_QDR_COMMAND(x)                     (((x)&0xFF00))=0A=
+#define MCF5282_QSPI_QCR_DATA(x)                        =
(((x)&0x00FF)<<8)=0A=
+#define MCF5282_QSPI_QCR_CONT                           (0x8000)=0A=
+#define MCF5282_QSPI_QCR_BITSE                          (0x4000)=0A=
+#define MCF5282_QSPI_QCR_DT                             (0x2000)=0A=
+#define MCF5282_QSPI_QCR_DSCK                           (0x1000)=0A=
+#define MCF5282_QSPI_QCR_CS                             =
(((x)&0x000F)<<8)=0A=
+=0A=
 =
/************************************************************************=
****/=0A=
 #endif	/* m528xsim_h */=0A=
diff -uprN -X dontdiff =
linux-2.6.11.6/include/asm-m68knommu/m528xsim.h.orig =
linux_dev/include/asm-m68knommu/m528xsim.h.orig=0A=
--- linux-2.6.11.6/include/asm-m68knommu/m528xsim.h.orig	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ linux_dev/include/asm-m68knommu/m528xsim.h.orig	2005-04-05 =
19:06:59.000000000 -0400=0A=
@@ -0,0 +1,45 @@=0A=
+/***********************************************************************=
*****/=0A=
+=0A=
+/*=0A=
+ *	m528xsim.h -- ColdFire 5280/5282 System Integration Module support.=0A=
+ *=0A=
+ *	(C) Copyright 2003, Greg Ungerer (gerg@snapgear.com)=0A=
+ */=0A=
+=0A=
+/***********************************************************************=
*****/=0A=
+#ifndef	m528xsim_h=0A=
+#define	m528xsim_h=0A=
+/***********************************************************************=
*****/=0A=
+=0A=
+#include <linux/config.h>=0A=
+=0A=
+/*=0A=
+ *	Define the 5280/5282 SIM register set addresses.=0A=
+ */=0A=
+#define	MCFICM_INTC0		0x0c00		/* Base for Interrupt Ctrl 0 */=0A=
+#define	MCFICM_INTC1		0x0d00		/* Base for Interrupt Ctrl 0 */=0A=
+#define	MCFINTC_IPRH		0x00		/* Interrupt pending 32-63 */=0A=
+#define	MCFINTC_IPRL		0x04		/* Interrupt pending 1-31 */=0A=
+#define	MCFINTC_IMRH		0x08		/* Interrupt mask 32-63 */=0A=
+#define	MCFINTC_IMRL		0x0c		/* Interrupt mask 1-31 */=0A=
+#define	MCFINTC_INTFRCH		0x10		/* Interrupt force 32-63 */=0A=
+#define	MCFINTC_INTFRCL		0x14		/* Interrupt force 1-31 */=0A=
+#define	MCFINTC_IRLR		0x18		/* */=0A=
+#define	MCFINTC_IACKL		0x19		/* */=0A=
+#define	MCFINTC_ICR0		0x40		/* Base ICR register */=0A=
+=0A=
+#define	MCFINT_VECBASE		64		/* Vector base number */=0A=
+#define	MCFINT_UART0		13		/* Interrupt number for UART0 */=0A=
+#define	MCFINT_PIT1		55		/* Interrupt number for PIT1 */=0A=
+=0A=
+/*=0A=
+ *	SDRAM configuration registers.=0A=
+ */=0A=
+#define	MCFSIM_DCR		0x44		/* SDRAM control */=0A=
+#define	MCFSIM_DACR0		0x48		/* SDRAM base address 0 */=0A=
+#define	MCFSIM_DMR0		0x4c		/* SDRAM address mask 0 */=0A=
+#define	MCFSIM_DACR1		0x50		/* SDRAM base address 1 */=0A=
+#define	MCFSIM_DMR1		0x54		/* SDRAM address mask 1 */=0A=
+=0A=
+/***********************************************************************=
*****/=0A=
+#endif	/* m528xsim_h */=0A=

------=_NextPart_000_003A_01C53A2F.798217D0--

