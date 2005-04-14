Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVDNBPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVDNBPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 21:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDNBPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 21:15:07 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:40184 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261249AbVDNBNK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 21:13:10 -0400
From: "Derek Cheung" <derek.cheung@sympatico.ca>
To: "'Greg KH'" <greg@kroah.com>, "'Randy.Dunlap'" <rddunlap@osdl.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <Linux-kernel@vger.kernel.org>, <sensors@stimpy.netroedge.com>
Subject: RE: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Date: Wed, 13 Apr 2005 21:12:53 -0400
Message-ID: <001d01c5408f$18238850$1501a8c0@Mainframe>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001E_01C5406D.9111E850"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
In-Reply-To: <20050411200318.GA25550@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_001E_01C5406D.9111E850
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

OK, hope this patch can satisfy everyone :-)

The following is the diffstat of the enclosed patch file:

 drivers/i2c/busses/Kconfig       |   10 
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-mcf5282.c |  414
+++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mcf5282.h |   46 ++++
 include/asm-m68knommu/m528xsim.h |   42 +++
 5 files changed, 513 insertions(+)

I did:

a) remove all trailing spaces in the files
b) re-align the switch statement
c) change a return statement
d) change some white space intents to TABs
e) insert a break for the I2C_SMBUS_PROC_CALL, thanks for spotting it
f) fix the mcf5282lite wording in Kconfig

I did not:

g) use the ioremap. This is because Coldfire is a CPU without MMU and
there is no difference between virtual and physical memory. In fact, the
ioremap routine in the m68knommu is simply a stub routine that returns
the input address argument for compatibility reason. Also, all other
Coldfire CPU include files such as the m5307sim.h uses the volatile
declaration method. 
So, I hope this is acceptable to the Linux kernel maintainers

Please let me know if there is any question.

Regards
Derek


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: April 11, 2005 4:03 PM
To: Derek Cheung
Cc: 'Randy.Dunlap'; 'Andrew Morton'; Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 - I2C adaptor for ColdFire 5282 CPU

On Sun, Apr 10, 2005 at 12:47:42PM -0400, Derek Cheung wrote:
> Enclosed please find the updated patch that incorporates changes for
all
> the comments I received.

You did not cc: the sensors mailing list, nor fix all of the coding
style issues.

> The volatile declaration in the m528xsim.h is needed because the
> declaration refers to the ColdFire 5282 register mapping.

Shouldn't you be calling ioremap, and not directly accessing a specific
register location through a pointer?  That's how all other arches do
this.

thanks,

greg k-h

------=_NextPart_000_001E_01C5406D.9111E850
Content-Type: application/octet-stream;
	name="linux_patch_submit3"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux_patch_submit3"

diff -uprN -X dontdiff-osdl =
linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.c =
linux_dev/drivers/i2c/busses/i2c-mcf5282.c=0A=
--- linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.c	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/i2c-mcf5282.c	2005-04-13 =
18:15:12.000000000 -0400=0A=
@@ -0,0 +1,414 @@=0A=
+/*=0A=
+    i2c-mcf5282.c - Part of lm_sensors, Linux kernel modules for =
hardware=0A=
+		    monitoring=0A=
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
+    v0.1	26 March 2005=0A=
+		Initial Release - developed on uClinux with 2.6.9 kernel=0A=
+    v0.2	11 April 2005=0A=
+		Coding style changes=0A=
+=0A=
+    This I2C adaptor supports the ColdFire 5282 CPU I2C module. Since =
most=0A=
+    Coldfire CPUs' I2C module use the same register set (e.g., MCF5249),=0A=
+    the code is very portable and re-usable for other Coldfire CPUs.=0A=
+=0A=
+    The transmission frequency is set at about 100KHz for the 5282Lite =
CPU=0A=
+    board with 8MHz crystal. If the CPU board uses different system =
clock=0A=
+    frequency, you should change the following line:=0A=
+		static int __init i2c_mcf5282_init(void)=0A=
+		{=0A=
+				.........=0A=
+			// Set transmission frequency 0x15 =3D ~100kHz=0A=
+			*MCF5282_I2C_I2FDR =3D 0x15;=0A=
+				........=0A=
+		}=0A=
+=0A=
+    Remember to perform a dummy read to set the ColdFire CPU's I2C =
module before=0A=
+    reading the actual byte from a device on the I2C bus.=0A=
+=0A=
+    The I2C_SM_BUS_BLOCK_DATA function are not yet ready but most =
lm_senors=0A=
+    do not care=0A=
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
+static struct i2c_algorithm mcf5282_algorithm =3D {=0A=
+	.name		=3D "MCF5282 I2C algorithm",=0A=
+	.id		=3D I2C_ALGO_SMBUS,=0A=
+	.smbus_xfer	=3D mcf5282_i2c_access,=0A=
+	.functionality	=3D mcf5282_func,=0A=
+};=0A=
+=0A=
+static struct i2c_adapter mcf5282_adapter =3D {=0A=
+	.owner		=3D THIS_MODULE,=0A=
+	.class		=3D I2C_CLASS_HWMON,=0A=
+	.algo		=3D &mcf5282_algorithm,=0A=
+	.name		=3D "MCF5282 I2C Adapter",=0A=
+};=0A=
+=0A=
+/*=0A=
+ *  read one byte data from the I2C bus=0A=
+ */=0A=
+static int mcf5282_read_data(u8 * const rxData,=0A=
+			     const enum I2C_ACK_TYPE ackType) {=0A=
+=0A=
+	int timeout;=0A=
+=0A=
+	*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_MTX;    /* master receive =
mode */=0A=
+=0A=
+	if (ackType =3D=3D NACK)=0A=
+		*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_TXAK;   /* generate NA  */=0A=
+	else=0A=
+		*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_TXAK;  /* generate ACK */=0A=
+=0A=
+	/* read data from the I2C bus */=0A=
+	*rxData =3D *MCF5282_I2C_I2DR;=0A=
+=0A=
+	/* printk(KERN_DEBUG "%s I2DR is %.2x \n", __FUNCTION__, *rxData); */=0A=
+=0A=
+	/* wait for data transfer to complete */=0A=
+	timeout =3D 500;=0A=
+	while (timeout-- && !(*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IIF))=0A=
+		udelay(1);=0A=
+	if (timeout <=3D 0)=0A=
+		printk(KERN_WARNING "%s - I2C IIF never set \n", __FUNCTION__);=0A=
+=0A=
+	/* reset the interrupt bit */=0A=
+	*MCF5282_I2C_I2SR &=3D ~MCF5282_I2C_I2SR_IIF;=0A=
+=0A=
+	if (timeout <=3D 0)=0A=
+		return -1;=0A=
+	else=0A=
+		return 0;=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  write one byte data onto the I2C bus=0A=
+ */=0A=
+static int mcf5282_write_data(const u8 txData) {=0A=
+=0A=
+	int timeout;=0A=
+=0A=
+	timeout =3D 500;=0A=
+=0A=
+	*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_MTX; /* I2C module into TX =
mode */=0A=
+	*MCF5282_I2C_I2DR =3D txData;		   /* send the data	      */=0A=
+=0A=
+	/* wait for data transfer to complete=0A=
+	   rely on the interrupt handling bit */=0A=
+	timeout =3D 500;=0A=
+	while (timeout-- && !(*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IIF))=0A=
+		udelay(1);=0A=
+	if (timeout <=3D 0)=0A=
+		printk(KERN_DEBUG "%s - I2C IIF never set \n", __FUNCTION__);=0A=
+=0A=
+	/* reset the interrupt bit */=0A=
+	*MCF5282_I2C_I2SR &=3D ~MCF5282_I2C_I2SR_IIF;=0A=
+=0A=
+	if (timeout <=3D 0)=0A=
+		return -1;=0A=
+	else=0A=
+		return 0;=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  Generate I2C start or repeat start signal=0A=
+ *  Combine the 7 bit target_address and the R/W bit and put it onto =
the I2C bus=0A=
+ */=0A=
+static int mcf5282_i2c_start(const char read_write, const u16 =
target_address,=0A=
+			     const enum I2C_START_TYPE start_type) {=0A=
+=0A=
+	int timeout;=0A=
+=0A=
+	/* printk(KERN_DEBUG ">>> %s START TYPE %s \n", __FUNCTION__,=0A=
+		start_type =3D=3D FIRST_START ? "FIRST_START" : "REPEAT_START"); */=0A=
+=0A=
+	*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_IEN;=0A=
+=0A=
+	if (start_type =3D=3D FIRST_START) {=0A=
+		/* Make sure the I2C bus is idle */=0A=
+		timeout =3D 500;		/* 500us timeout */=0A=
+		while (timeout-- && (*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IBB))=0A=
+			udelay(1);=0A=
+		if (timeout <=3D 0) {=0A=
+			printk(KERN_WARNING "%s - I2C bus is busy in the \=0A=
+			       past 500us \n", __FUNCTION__);=0A=
+			goto check_rc;=0A=
+		}=0A=
+		/* generate a START & put the I2C module into MASTER TX mode */=0A=
+		*MCF5282_I2C_I2CR |=3D (MCF5282_I2C_I2CR_MSTA |=0A=
+				      MCF5282_I2C_I2CR_MTX);=0A=
+=0A=
+		/* wait for bus busy to be set */=0A=
+		timeout =3D 500;=0A=
+		while (timeout-- && !(*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IBB))=0A=
+			udelay(1);=0A=
+		if (timeout <=3D 0) {=0A=
+			printk(KERN_WARNING "%s - I2C bus is never busy after \=0A=
+				START \n", __FUNCTION__);=0A=
+			goto check_rc;=0A=
+		}=0A=
+	} else {=0A=
+		/* this is repeat START */=0A=
+		udelay(500);	/* need some delay before repeat start */=0A=
+		*MCF5282_I2C_I2CR |=3D (MCF5282_I2C_I2CR_MSTA |=0A=
+				      MCF5282_I2C_I2CR_RSTA);=0A=
+	}=0A=
+=0A=
+	/* combine the R/W bit and the 7 bit target address and=0A=
+	   put it onto the I2C bus */=0A=
+	*MCF5282_I2C_I2DR =3D ((target_address & 0x7F) << 1) |=0A=
+			     (read_write =3D=3D I2C_SMBUS_WRITE ? 0x00 : 0x01);=0A=
+=0A=
+	/* wait for bus transfer to complete=0A=
+	   when one byte transfer is completed, IIF set at the faling edge=0A=
+	   of the 9th clock */=0A=
+	timeout =3D 500;=0A=
+	while (timeout-- && !(*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IIF))=0A=
+		udelay(1);=0A=
+	if (timeout <=3D 0)=0A=
+		printk(KERN_WARNING "%s - I2C IIF never set \n", __FUNCTION__);=0A=
+=0A=
+check_rc:=0A=
+	/* reset the interrupt bit */=0A=
+	*MCF5282_I2C_I2SR &=3D ~MCF5282_I2C_I2SR_IIF;=0A=
+=0A=
+	if (timeout <=3D 0)=0A=
+		return -1;=0A=
+	else=0A=
+		return 0;=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  5282 SMBUS supporting functions=0A=
+ */=0A=
+=0A=
+static s32 mcf5282_i2c_access(struct i2c_adapter *adap, u16 addr,=0A=
+			      unsigned short flags, char read_write,=0A=
+			      u8 command, int size, union i2c_smbus_data *data)=0A=
+{=0A=
+	int rc =3D 0;=0A=
+	u8 rxData, tempRxData[2];=0A=
+=0A=
+	switch (size) {=0A=
+	case I2C_SMBUS_QUICK:=0A=
+		/* dev_info(&adap->dev, "size =3D I2C_SMBUS_QUICK \n"); */=0A=
+		/* generate an I2C start */=0A=
+		rc =3D mcf5282_i2c_start(read_write, addr, FIRST_START);=0A=
+		break;=0A=
+	case I2C_SMBUS_BYTE:=0A=
+		/* dev_info(&adap->dev, "size =3D I2C_SMBUS_BYTE \n"); */=0A=
+		rc =3D mcf5282_i2c_start(read_write, addr, FIRST_START);=0A=
+		/* generate NA */=0A=
+		*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_TXAK;=0A=
+		if (read_write =3D=3D I2C_SMBUS_WRITE)=0A=
+			rc +=3D mcf5282_write_data(command);=0A=
+		else {=0A=
+			/* dummy read */=0A=
+			mcf5282_read_data(&rxData, NACK);=0A=
+			rc +=3D mcf5282_read_data(&rxData, NACK);=0A=
+			data->byte =3D rxData;=0A=
+		}=0A=
+		/* reset the ACK bit */=0A=
+		*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_TXAK;=0A=
+		break;=0A=
+	case I2C_SMBUS_BYTE_DATA:=0A=
+		/* dev_info(&adap->dev, "size =3D I2C_SMBUS_BYTE_DATA \n"); */=0A=
+		rc =3D mcf5282_i2c_start(I2C_SMBUS_WRITE, addr, FIRST_START);=0A=
+		rc +=3D mcf5282_write_data(command);=0A=
+		if (read_write =3D=3D I2C_SMBUS_WRITE)=0A=
+			rc +=3D mcf5282_write_data(data->byte);=0A=
+		else {=0A=
+			/* This is SMBus READ Byte Data Request.=0A=
+			   Perform REPEAT START */=0A=
+			rc +=3D mcf5282_i2c_start(I2C_SMBUS_READ, addr,=0A=
+						REPEAT_START);=0A=
+			/* dummy read */=0A=
+			mcf5282_read_data(&rxData, ACK);=0A=
+			/* Disable Acknowledge, generate STOP after=0A=
+			   next byte transfer */=0A=
+			rc +=3D mcf5282_read_data(&rxData, NACK);=0A=
+			data->byte =3D rxData;=0A=
+		}=0A=
+		/* reset to normal ACK */=0A=
+		*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_TXAK;=0A=
+		break;=0A=
+	case I2C_SMBUS_PROC_CALL:=0A=
+		/* dev_info(&adap->dev, "size =3D I2C_SMBUS_PROC_CALL \n"); */=0A=
+		printk(KERN_WARNING "Not support I2C_SMBUS_PROC_CALL yet \n");=0A=
+		rc =3D -2;=0A=
+		break;=0A=
+	case I2C_SMBUS_WORD_DATA:=0A=
+		/* dev_info(&adap->dev, "I2C_SMBUS_WORD_DATA \n"); */=0A=
+		rc =3D mcf5282_i2c_start(I2C_SMBUS_WRITE, addr, FIRST_START);=0A=
+		rc +=3D mcf5282_write_data(command);=0A=
+		if (read_write =3D=3D I2C_SMBUS_WRITE) {=0A=
+			rc +=3D mcf5282_write_data(data->word & 0x00FF);=0A=
+			rc +=3D mcf5282_write_data((data->word & 0x00FF) >> 8);=0A=
+		} else {=0A=
+			/* This is SMBUS READ WORD request.=0A=
+			   Peform REPEAT START */=0A=
+			rc +=3D mcf5282_i2c_start(I2C_SMBUS_READ, addr,=0A=
+				REPEAT_START);=0A=
+			/* dummy read */=0A=
+			mcf5282_read_data(&rxData, ACK);=0A=
+			/* Disable Acknowledge, generate STOP=0A=
+			   after next byte transfer */=0A=
+			/* read the MS byte from the device */=0A=
+			rc +=3D mcf5282_read_data(&rxData, NACK);=0A=
+			tempRxData[1] =3D rxData;=0A=
+			/* read the LS byte from the device */=0A=
+			rc +=3D mcf5282_read_data(&rxData, NACK);=0A=
+			tempRxData[0] =3D rxData;=0A=
+			/* the host driver expect little endian=0A=
+			   convention. Swap the byte */=0A=
+			data->word =3D (tempRxData[0] << 8) | tempRxData[1];=0A=
+			/* printk(KERN_DEBUG "SMBUS_WORD_DATA %.4x \n",=0A=
+				data->word); */=0A=
+		}=0A=
+		*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_TXAK;=0A=
+		break;=0A=
+	case I2C_SMBUS_BLOCK_DATA:=0A=
+#if NOT_READY_YET=0A=
+		dev_info(&adap->dev, "size =3D I2C_SMBUS_BLOCK_DATA\n");=0A=
+		if (read_write =3D=3D I2C_SMBUS_WRITE) {=0A=
+			dev_info(&adap->dev, "data =3D %.4x\n", data->word);=0A=
+			len =3D data->block[0];=0A=
+			if (len < 0)=0A=
+				len =3D 0;=0A=
+			if (len > 32)=0A=
+				len =3D 32;=0A=
+			for (i =3D 1; i <=3D len; i++)=0A=
+				dev_info(&adap->dev, "data->block[%d] \=0A=
+				=3D %.2x\n", i, data->block[i]);=0A=
+		}=0A=
+#endif=0A=
+		break;=0A=
+	default:=0A=
+		printk(KERN_WARNING "Unsupported I2C size \n");=0A=
+		rc =3D -1;=0A=
+		break;=0A=
+	};=0A=
+=0A=
+	/* Generate a STOP and put I2C module into slave mode */=0A=
+	*MCF5282_I2C_I2CR &=3D ~MCF5282_I2C_I2CR_MSTA;=0A=
+=0A=
+	/* restore interrupt */=0A=
+	*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_IIEN;=0A=
+=0A=
+	return rc;=0A=
+};=0A=
+=0A=
+=0A=
+/*=0A=
+ *  List the SMBUS functions supported by this I2C adaptor=0A=
+ */=0A=
+static u32 mcf5282_func(struct i2c_adapter *adapter)=0A=
+{=0A=
+	return I2C_FUNC_SMBUS_QUICK |=0A=
+	       I2C_FUNC_SMBUS_BYTE |=0A=
+	       I2C_FUNC_SMBUS_PROC_CALL |=0A=
+	       I2C_FUNC_SMBUS_BYTE_DATA |=0A=
+	       I2C_FUNC_SMBUS_WORD_DATA |=0A=
+	       I2C_FUNC_SMBUS_BLOCK_DATA;=0A=
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
+	/* Initialize PASP0 and PASP1 to I2C functions - 5282 user guide 26-19=0A=
+	   Port AS Pin Assignment Register (PASPAR)=0A=
+			PASPA1 =3D 11 =3D AS1 pin is I2C SDA=0A=
+			PASPA0 =3D 11 =3D AS0 pin is I2C SCL */=0A=
+	/* u16 declaration */=0A=
+	*MCF5282_GPIO_PASPAR |=3D 0x000F;=0A=
+=0A=
+	/* Set transmission frequency 0x15 =3D ~100kHz */=0A=
+	*MCF5282_I2C_I2FDR =3D 0x15;=0A=
+=0A=
+	/* set the 5282 I2C slave address thought we never use it */=0A=
+	*MCF5282_I2C_I2ADR =3D 0x6A;=0A=
+=0A=
+	/* Enable I2C module and if IBB is set, do the special initialzation=0A=
+	   procedures as are documented at the 5282 User Guide page 24-11 */=0A=
+	*MCF5282_I2C_I2CR |=3D MCF5282_I2C_I2CR_IEN;=0A=
+	if ((*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IBB) =3D=3D 1) {=0A=
+		/* printk(KERN_DEBUG "5282 I2C init procedures \n"); */=0A=
+		*MCF5282_I2C_I2CR =3D 0x00;=0A=
+		*MCF5282_I2C_I2CR =3D 0xA0;=0A=
+		dummyRead =3D *MCF5282_I2C_I2DR;=0A=
+		*MCF5282_I2C_I2SR =3D 0x00;=0A=
+		*MCF5282_I2C_I2CR =3D 0x00;=0A=
+	}=0A=
+=0A=
+	/* default I2C mode is - slave and receive */=0A=
+	*MCF5282_I2C_I2CR &=3D ~(MCF5282_I2C_I2CR_MSTA | MCF5282_I2C_I2CR_MTX);=0A=
+=0A=
+	retval =3D i2c_add_adapter(&mcf5282_adapter);=0A=
+=0A=
+	if (retval < 0)=0A=
+		printk(KERN_WARNING "%s - return code is: %d \n", __FUNCTION__,=0A=
+		       retval);=0A=
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
+	*MCF5282_I2C_I2CR &=3D ~(MCF5282_I2C_I2CR_IEN | MCF5282_I2C_I2CR_IIEN);=0A=
+	i2c_del_adapter(&mcf5282_adapter);=0A=
+};=0A=
+=0A=
+=0A=
+MODULE_AUTHOR("Derek CL Cheung <derek.cheung@sympatico.ca>");=0A=
+MODULE_DESCRIPTION("MCF5282 I2C adaptor");=0A=
+MODULE_LICENSE("GPL");=0A=
+=0A=
+module_init(i2c_mcf5282_init);=0A=
+module_exit(i2c_mcf5282_exit);=0A=
diff -uprN -X dontdiff-osdl =
linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.h =
linux_dev/drivers/i2c/busses/i2c-mcf5282.h=0A=
--- linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/i2c-mcf5282.h	2005-04-12 =
20:45:00.000000000 -0400=0A=
@@ -0,0 +1,46 @@=0A=
+/*=0A=
+    i2c-mcf5282.h - header file for i2c-mcf5282.c=0A=
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
+    v0.1	26 March 2005=0A=
+		Initial Release - developed on uClinux with 2.6.9 kernel=0A=
+=0A=
+*/=0A=
+=0A=
+=0A=
+#ifndef __I2C_MCF5282_H__=0A=
+#define __I2C_MCF5282_H__=0A=
+=0A=
+enum I2C_START_TYPE { FIRST_START, REPEAT_START };=0A=
+enum I2C_ACK_TYPE { ACK, NACK };=0A=
+=0A=
+/* Function prototypes */=0A=
+static u32 mcf5282_func(struct i2c_adapter *adapter);=0A=
+static s32 mcf5282_i2c_access(struct i2c_adapter *adap, u16 address,=0A=
+			      unsigned short flags, char read_write,=0A=
+			      u8 command, int size, union i2c_smbus_data *data);=0A=
+static int mcf5282_write_data(const u8 data);=0A=
+static int mcf5282_i2c_start(const char read_write, const u16 =
target_address,=0A=
+			     const enum I2C_START_TYPE i2c_start);=0A=
+static int mcf5282_read_data(u8 * const rxData,=0A=
+			     const enum I2C_ACK_TYPE ackType);=0A=
+=0A=
+/********************************************************************/=0A=
+#endif /*  __I2C_MCF5282_H__ */=0A=
diff -uprN -X dontdiff-osdl linux-2.6.11.6/drivers/i2c/busses/Kconfig =
linux_dev/drivers/i2c/busses/Kconfig=0A=
--- linux-2.6.11.6/drivers/i2c/busses/Kconfig	2005-03-25 =
22:28:29.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/Kconfig	2005-04-12 20:45:24.000000000 =
-0400=0A=
@@ -39,6 +39,16 @@ config I2C_ALI15X3=0A=
 	  This driver can also be built as a module.  If so, the module=0A=
 	  will be called i2c-ali15x3.=0A=
 =0A=
+config I2C_MCF5282=0A=
+	tristate "MCF5282"=0A=
+	depends on I2C && EXPERIMENTAL=0A=
+	help=0A=
+	  If you say yes to this option, support will be included for the=0A=
+	  I2C on the ColdFire MCF5282Lite Development Board=0A=
+=0A=
+	  This driver can also be built as a module.  If so, the module=0A=
+	  will be called i2c-mcf5282.=0A=
+=0A=
 config I2C_AMD756=0A=
 	tristate "AMD 756/766/768/8111 and nVidia nForce"=0A=
 	depends on I2C && PCI && EXPERIMENTAL=0A=
diff -uprN -X dontdiff-osdl linux-2.6.11.6/drivers/i2c/busses/Makefile =
linux_dev/drivers/i2c/busses/Makefile=0A=
--- linux-2.6.11.6/drivers/i2c/busses/Makefile	2005-03-25 =
22:28:39.000000000 -0500=0A=
+++ linux_dev/drivers/i2c/busses/Makefile	2005-04-13 18:52:03.000000000 =
-0400=0A=
@@ -40,6 +40,7 @@ obj-$(CONFIG_I2C_VIAPRO)	+=3D i2c-viapro.o=0A=
 obj-$(CONFIG_I2C_VOODOO3)	+=3D i2c-voodoo3.o=0A=
 obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o=0A=
 obj-$(CONFIG_SCx200_I2C)	+=3D scx200_i2c.o=0A=
+obj-$(CONFIG_I2C_MCF5282)	+=3D i2c-mcf5282.o=0A=
 =0A=
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)=0A=
 EXTRA_CFLAGS +=3D -DDEBUG=0A=
diff -uprN -X dontdiff-osdl =
linux-2.6.11.6/include/asm-m68knommu/m528xsim.h =
linux_dev/include/asm-m68knommu/m528xsim.h=0A=
--- linux-2.6.11.6/include/asm-m68knommu/m528xsim.h	2005-03-25 =
22:28:13.000000000 -0500=0A=
+++ linux_dev/include/asm-m68knommu/m528xsim.h	2005-04-12 =
19:49:51.000000000 -0400=0A=
@@ -41,5 +41,47 @@=0A=
 #define	MCFSIM_DACR1		0x50		/* SDRAM base address 1 */=0A=
 #define	MCFSIM_DMR1		0x54		/* SDRAM address mask 1 */=0A=
 =0A=
+=0A=
+/*********************************************************************=0A=
+*=0A=
+* I2C Module=0A=
+* Derek Cheung - 21 Feb 2005=0A=
+* Register definition for ColdFire 5282=0A=
+*=0A=
+*********************************************************************/=0A=
+/* set Port AS pin for I2C or UART */=0A=
+#define MCF5282_GPIO_PASPAR     (volatile u16 *) (MCF_IPSBAR + =
0x00100056)=0A=
+=0A=
+/* Interrupt Mask Register Register Low */=0A=
+#define MCF5282_INTC0_IMRL      (volatile u32 *) (MCF_IPSBAR + 0x0C0C)=0A=
+=0A=
+/* Interrupt Control Register 7 */=0A=
+#define MCF5282_INTC0_ICR17     (volatile u8 *) (MCF_IPSBAR + 0x0C51)=0A=
+=0A=
+/*********************************************************************=0A=
+* Inter-IC (I2C) Module Specify Register definition=0A=
+*********************************************************************/=0A=
+/* Read/Write access macros for general use */=0A=
+#define MCF5282_I2C_I2ADR  (volatile u8 *) (MCF_IPSBAR + 0x0300) /* =
Address */=0A=
+#define MCF5282_I2C_I2FDR  (volatile u8 *) (MCF_IPSBAR + 0x0304) /* F =
Divider */=0A=
+#define MCF5282_I2C_I2CR   (volatile u8 *) (MCF_IPSBAR + 0x0308) /* =
Control */=0A=
+#define MCF5282_I2C_I2SR   (volatile u8 *) (MCF_IPSBAR + 0x030C) /* =
Status */=0A=
+#define MCF5282_I2C_I2DR   (volatile u8 *) (MCF_IPSBAR + 0x0310) /* =
Data I/O */=0A=
+=0A=
+#define MCF5282_I2C_I2CR_IEN    (0x80)	/* I2C enable */=0A=
+#define MCF5282_I2C_I2CR_IIEN   (0x40)  /* interrupt enable */=0A=
+#define MCF5282_I2C_I2CR_MSTA   (0x20)  /* master/slave mode */=0A=
+#define MCF5282_I2C_I2CR_MTX    (0x10)  /* transmit/receive mode */=0A=
+#define MCF5282_I2C_I2CR_TXAK   (0x08)  /* transmit acknowledge enable =
*/=0A=
+#define MCF5282_I2C_I2CR_RSTA   (0x04)  /* repeat start */=0A=
+=0A=
+#define MCF5282_I2C_I2SR_ICF    (0x80)  /* data transfer bit */=0A=
+#define MCF5282_I2C_I2SR_IAAS   (0x40)  /* I2C addressed as a slave */=0A=
+#define MCF5282_I2C_I2SR_IBB    (0x20)  /* I2C bus busy */=0A=
+#define MCF5282_I2C_I2SR_IAL    (0x10)  /* aribitration lost */=0A=
+#define MCF5282_I2C_I2SR_SRW    (0x04)  /* slave read/write */=0A=
+#define MCF5282_I2C_I2SR_IIF    (0x02)  /* I2C interrupt */=0A=
+#define MCF5282_I2C_I2SR_RXAK   (0x01)  /* received acknowledge */=0A=
+=0A=
 =
/************************************************************************=
****/=0A=
 #endif	/* m528xsim_h */=0A=

------=_NextPart_000_001E_01C5406D.9111E850--

