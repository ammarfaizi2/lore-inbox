Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVDFCUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVDFCUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 22:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVDFCUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 22:20:43 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:22945 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262080AbVDFCS0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 22:18:26 -0400
From: "Derek Cheung" <derek.cheung@sympatico.ca>
To: "'Greg KH'" <greg@kroah.com>, "'Andrew Morton'" <akpm@osdl.org>
Cc: <Linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Date: Tue, 5 Apr 2005 22:18:15 -0400
Message-ID: <003801c53a4e$e5df3d80$1501a8c0@Mainframe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20050405044836.GA17336@kroah.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Andrew,

Below please find the patch file I "diff" against Linux 2.6.11.6. It
contains the I2C adaptor for ColdFire 5282 CPU. Since most ColdFire CPU
shares the same I2C register set, the code can be easily adopted for
other ColdFire CPUs for I2C operations.

I have tested the code on a ColdFire 5282Lite CPU board
(http://www.axman.com/Pages/cml-5282LITE.html) running uClinux 2.6.9
with LM75 and DS1621 temperature sensor chips. As advised by David
McCullough, the code will be incorporated in the next uClinux release.

The patch contains:

linux/drivers/i2c/busses
 		i2c-mcf5282.c (new file)
 		i2c-mcf5282.h (new file)
 		Kconfig (modified)
 		Makefile (modified)
 
linux/include/asm-m68knommu
 		m528xsim.h (modified)

Please let me know if you have any questions.

Regards
Derek

Signed-off-by: Derek CL Cheung derek.cheung@sympatico.ca
=======================================================================

diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.c
linux_dev/drivers/i2c/busses/i2c-mcf5282.c
--- linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.c	1969-12-31
19:00:00.000000000 -0500
+++ linux_dev/drivers/i2c/busses/i2c-mcf5282.c	2005-04-05
19:21:55.000000000 -0400
@@ -0,0 +1,407 @@
+/*
+    i2c-mcf5282.c - Part of lm_sensors, Linux kernel modules for
hardware monitoring
+
+    Copyright (c) 2005, Derek CL Cheung <derek.cheung@sympatico.ca>
+
<http://www3.sympatico.ca/derek.cheung>
+
+    This program is free software; you can redistribute it and/or
modify
+    it under the terms of the GNU General Public License as published
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
+    v0.1 	26 March 2005
+        	Initial Release - developed on uClinux with 2.6.9 kernel
+
+
+    This I2C adaptor supports the ColdFire 5282 CPU I2C module. Since
most Coldfire
+    CPUs' I2C module use the same register set (e.g., MCF5249), the
code is very
+    portable and re-usable to other Coldfire CPUs.
+
+    The transmission frequency is set at about 100KHz for the 5282Lite
CPU board with
+    8MHz crystal. If the CPU board uses different system clock
frequency, you should
+    change the following line:
+                static int __init i2c_mcf5282_init(void)
+                {
+                                .........
+                        // Set transmission frequency 0x15 = ~100kHz
+                        *MCF5282_I2C_I2FDR = 0x15;
+                                ........
+                }
+
+    Remember to perform a dummy read to set the ColdFire CPU's I2C
module for read before
+    reading the actual byte from a device
+
+    The I2C_SM_BUS_BLOCK_DATA function are not yet ready but most
lm_senors do not care
+
+*/
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <asm/coldfire.h>
+#include <asm/m528xsim.h>
+#include <asm/types.h>
+#include "i2c-mcf5282.h"
+
+
+static struct i2c_algorithm mcf5282_algorithm = {
+	.name		= "MCF5282 I2C algorithm",
+	.id		= I2C_ALGO_SMBUS,
+	.smbus_xfer	= mcf5282_i2c_access,
+	.functionality	= mcf5282_func,
+};
+
+
+static struct i2c_adapter mcf5282_adapter = {
+	.owner		= THIS_MODULE,
+	.class          = I2C_CLASS_HWMON,
+	.algo		= &mcf5282_algorithm,
+	.name		= "MCF5282 I2C Adapter",
+};
+
+
+/*
+ *  read one byte data from the I2C bus
+ */
+static int mcf5282_read_data(u8 * const rxData, const enum I2C_ACK_TYPE
ackType) {
+
+        int timeout;
+
+	*MCF5282_I2C_I2CR &= ~MCF5282_I2C_I2CR_MTX;     	//
master receive mode
+
+	if (ackType == NACK)
+		*MCF5282_I2C_I2CR |= MCF5282_I2C_I2CR_TXAK;     //
generate NA
+	else
+                *MCF5282_I2C_I2CR &= ~MCF5282_I2C_I2CR_TXAK;    //
generate ACK
+
+
+	// read data from the I2C bus
+	*rxData = *MCF5282_I2C_I2DR; 
+
+	// printk(">>> %s I2DR data is %.2x \n", __FUNCTION__, *rxData);
+
+        // wait for data transfer to complete 
+        timeout = 500;
+        while (timeout-- && !(*MCF5282_I2C_I2SR &
MCF5282_I2C_I2SR_IIF))
+                udelay(1);
+        if (timeout <= 0) 
+                printk("%s - I2C IIF never set. Timeout is %d \n",
__FUNCTION__, timeout);
+        
+
+        // reset the interrupt bit 
+        *MCF5282_I2C_I2SR &= ~MCF5282_I2C_I2SR_IIF;
+
+	if (timeout <= 0 ) 
+                return -1;
+        else 
+                return 0;
+
+};
+
+
+/*
+ *  write one byte data onto the I2C bus
+ */
+static int mcf5282_write_data(const u8 txData) {
+	
+	int timeout;
+
+	timeout = 500;
+
+	*MCF5282_I2C_I2CR |= MCF5282_I2C_I2CR_MTX;	// I2C module
into TX mode
+	*MCF5282_I2C_I2DR = txData;			// send the data
+
+	// wait for data transfer to complete 
+        // rely on the interrupt handling bit 
+        timeout = 500;
+        while (timeout-- && !(*MCF5282_I2C_I2SR &
MCF5282_I2C_I2SR_IIF))
+                udelay(1);
+        if (timeout <=0) 
+                printk("%s - I2C IIF never set. Timeout is %d \n",
__FUNCTION__, timeout);
+        
+
+        // reset the interrupt bit
+        *MCF5282_I2C_I2SR &= ~MCF5282_I2C_I2SR_IIF;
+
+	if (timeout <= 0 ) 
+                return -1;
+        else 
+                return 0;
+
+};
+
+
+
+
+/*
+ *  Generate I2C start or repeat start signal
+ *  Combine the 7 bit target_address and the R/W bit and put it onto
the I2C bus
+ */
+static int mcf5282_i2c_start(const char read_write, const u16
target_address, const enum I2C_START_TYPE start_type) {
+
+	int timeout;		
+
+	// printk(">>> %s START TYPE %s \n", __FUNCTION__, start_type ==
FIRST_START ? "FIRST_START" : "REPEAT_START");
+
+	*MCF5282_I2C_I2CR |= MCF5282_I2C_I2CR_IEN;
+
+	if (start_type == FIRST_START) {
+  		// Make sure the I2C bus is idle 
+		timeout = 500;		// 500us timeout	
+        	while (timeout-- && (*MCF5282_I2C_I2SR &
MCF5282_I2C_I2SR_IBB)) 
+                	udelay(1);
+        	if (timeout <= 0) {
+                	printk("%s - I2C bus always busy in the past
500us timeout is %d \n", __FUNCTION__, timeout);
+                	goto check_rc;
+        	}
+		// generate a START and put the I2C module into MASTER
TX mode 
+		*MCF5282_I2C_I2CR |= (MCF5282_I2C_I2CR_MSTA |
MCF5282_I2C_I2CR_MTX);
+
+		// wait for bus busy to be set 
+        	timeout = 500;
+        	while (timeout-- && !(*MCF5282_I2C_I2SR &
MCF5282_I2C_I2SR_IBB))
+                	udelay(1);
+        	if (timeout <= 0) {
+                	printk("%s - I2C bus is never busy after START.
Timeout is %d \n", __FUNCTION__, timeout);
+                	goto check_rc;
+        	}
+
+	} else {
+		// this is repeat START 
+		udelay(500);	// need some delay before repeat start 
+		*MCF5282_I2C_I2CR |= (MCF5282_I2C_I2CR_MSTA |
MCF5282_I2C_I2CR_RSTA);    
+	}
+ 
+
+	// combine the R/W bit and the 7 bit target address and put it
onto the I2C bus
+	*MCF5282_I2C_I2DR = ((target_address & 0x7F) << 1) | (read_write
== I2C_SMBUS_WRITE ? 0x00 : 0x01);
+
+	// wait for bus transfer to complete 
+	// when one byte transfer is completed, IIF set at the faling
edge of the 9th clock 
+	timeout = 500;
+	while (timeout-- && !(*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IIF))
+		udelay(1);
+	if (timeout <= 0) 
+		printk("%s - I2C IIF never set. Timeout is %d \n",
__FUNCTION__, timeout);
+	
+
+check_rc:
+	// reset the interrupt bit 
+	*MCF5282_I2C_I2SR &= ~MCF5282_I2C_I2SR_IIF;
+
+	if (timeout <= 0) 
+		return -1;
+	else 
+		return 0;
+};
+
+
+/*
+ *  5282 SMBUS supporting functions
+ */
+
+static s32 mcf5282_i2c_access(struct i2c_adapter *adap, u16 addr, 
+			      unsigned short flags, char read_write, 
+			      u8 command, int size, union i2c_smbus_data
*data) 
+{
+	int i, len, rc = 0;
+        u8 rxData, tempRxData[2];
+	// u16 tempWord;
+
+#ifdef DEREK_DEBUG
+        dev_info(&adap->dev, "\n\n\n>>> %s was called with the
following parameters:\n", __FUNCTION__);
+        dev_info(&adap->dev, "addr = %.4x\n", addr);
+        dev_info(&adap->dev, "flags = %.4x\n", flags);
+        dev_info(&adap->dev, "read_write = %s\n", read_write ==
I2C_SMBUS_WRITE ? "write" : "read");
+        dev_info(&adap->dev, "command = %.2x\n", command);
+	dev_info(&adap->dev, "data = %.4x\n", data->word);
+	dev_info(&adap->dev, "size = %d\n", size);
+#endif
+
+        switch (size) {
+                case I2C_SMBUS_QUICK:
+			// dev_info(&adap->dev, "size = I2C_SMBUS_QUICK
\n");	
+			rc = mcf5282_i2c_start(read_write, addr,
FIRST_START); 	// generate START
+                        break;
+		case I2C_SMBUS_BYTE:
+			// dev_info(&adap->dev, "size = I2C_SMBUS_BYTE
\n");
+			rc = mcf5282_i2c_start(read_write, addr,
FIRST_START);
+			*MCF5282_I2C_I2CR |= MCF5282_I2C_I2CR_TXAK;
// generate NA
+			if (read_write == I2C_SMBUS_WRITE) 
+				rc += mcf5282_write_data(command);
+			else {
+				mcf5282_read_data(&rxData, NACK);
// dummy read 
+                                rc += mcf5282_read_data(&rxData, NACK);
+				data->byte = rxData;
+			}
+			*MCF5282_I2C_I2CR &= ~MCF5282_I2C_I2CR_TXAK;
// reset the ACK bit
+			break;
+        	case I2C_SMBUS_BYTE_DATA:
+			// dev_info(&adap->dev, "size =
I2C_SMBUS_BYTE_DATA \n");
+			rc = mcf5282_i2c_start(I2C_SMBUS_WRITE, addr,
FIRST_START);
+			rc += mcf5282_write_data(command);
+			if (read_write == I2C_SMBUS_WRITE) 
+				rc += mcf5282_write_data(data->byte);
+			else {	
+				// This is SMBus READ Byte Data Request.
Perform REPEAT START
+				rc += mcf5282_i2c_start(I2C_SMBUS_READ,
addr, REPEAT_START);
+				mcf5282_read_data(&rxData, ACK);
// dummy read
+				// Disable Acknowledge, generate STOP
after next byte transfer 
+				rc += mcf5282_read_data(&rxData, NACK);
+				data->byte = rxData;
+			}
+			*MCF5282_I2C_I2CR &= ~MCF5282_I2C_I2CR_TXAK;
// reset to normal ACk
+			break;
+                case I2C_SMBUS_PROC_CALL:
+			// dev_info(&adap->dev, "size =
I2C_SMBUS_PROC_CALL \n");
+        	case I2C_SMBUS_WORD_DATA:
+			dev_info(&adap->dev, "size = I2C_SMBUS_WORD_DATA
\n");
+			rc = mcf5282_i2c_start(I2C_SMBUS_WRITE, addr,
FIRST_START);
+			rc += mcf5282_write_data(command);
+			if (read_write == I2C_SMBUS_WRITE) {
+				rc += mcf5282_write_data(data->word &
0x00FF);
+				rc += mcf5282_write_data((data->word &
0x00FF) >> 8);
+			} else {	
+				// This is SMBUS READ WORD request.
Peform REPEAT START
+				rc += mcf5282_i2c_start(I2C_SMBUS_READ,
addr, REPEAT_START);
+				mcf5282_read_data(&rxData, ACK);
// dummy read
+				// Disable Acknowledge, generate STOP
after next byte transfer 
+				// read the MS byte from the device
+				rc += mcf5282_read_data(&rxData, NACK);
+				tempRxData[1] = rxData;	
+				// read the LS byte from the device	
+				rc += mcf5282_read_data(&rxData, NACK);
+				tempRxData[0] = rxData;
+				// the host driver expect little endian
convention. Swap the byte
+				data->word = (tempRxData[0] << 8) |
tempRxData[1];
+				// printk("SMBUS_WORD_DATA is %.4x \n",
data->word);
+			}
+			*MCF5282_I2C_I2CR &= ~MCF5282_I2C_I2CR_TXAK;
+			break;
+        	case I2C_SMBUS_BLOCK_DATA:
+                	// dev_info(&adap->dev, "size =
I2C_SMBUS_BLOCK_DATA\n");
+			// this is not yet ready!!!
+                	// if (read_write == I2C_SMBUS_WRITE) {
+                        //	dev_info(&adap->dev, "data = %.4x\n",
data->word);
+                        //	len = data->block[0];
+                        //	if (len < 0)
+                        //        	len = 0;
+                        //	if (len > 32)
+                        //        	len = 32;
+                        //	for (i = 1; i <= len; i++)
+                        //        	dev_info(&adap->dev,
"data->block[%d] = %.2x\n", i, data->block[i]); 
+			//} 
+			break; 
+		default:
+			printk("Unsupported I2C size \n");
+			rc = -1;
+			break;
+	};
+
+	// Generate a STOP and put I2C module into slave mode 
+	*MCF5282_I2C_I2CR &= ~MCF5282_I2C_I2CR_MSTA;
+
+	// restore interrupt 
+	*MCF5282_I2C_I2CR |= MCF5282_I2C_I2CR_IIEN;
+
+	if (rc < 0) 
+		return -1;
+	else
+        	return 0;
+};
+
+
+/*
+ *  List the SMBUS functions supported by this I2C adaptor
+ */
+static u32 mcf5282_func(struct i2c_adapter *adapter)
+{
+	return(I2C_FUNC_SMBUS_QUICK |
+	       I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_PROC_CALL |
+	       I2C_FUNC_SMBUS_BYTE_DATA |
+	       I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_BLOCK_DATA);
+};
+
+
+/*
+ *  Initalize the 5282 I2C module
+ *  Disable the 5282 I2C interrupt capability. Just use callback
+ */
+
+static int __init i2c_mcf5282_init(void)
+{
+	int retval;
+	u8  dummyRead;
+
+        // Initialize PASP0 and PASP1 to I2C functions - 5282 user
guide 26-19 	
+	// Port AS Pin Assignment Register (PASPAR) 			
+	//		PASPA1 = 11 = AS1 pin is I2C SDA 	
+	//		PASPA0 = 11 = AS0 pin is I2C SCL 
+        *MCF5282_GPIO_PASPAR |= 0x000F;		// u16
declaration
+
+    	// Set transmission frequency 0x15 = ~100kHz 
+    	*MCF5282_I2C_I2FDR = 0x15;
+
+	// set the 5282 I2C slave address thought we never use it 
+    	*MCF5282_I2C_I2ADR = 0x6A;
+
+    	// Enable I2C module and if IBB is set, do the special
initialzation
+	// procedures as are documented at the 5282 User Guide page
24-11
+    	*MCF5282_I2C_I2CR |= MCF5282_I2C_I2CR_IEN; 
+	if ((*MCF5282_I2C_I2SR & MCF5282_I2C_I2SR_IBB) == 1) {
+		printk("%s - do special 5282 I2C init procedures \n",
__FUNCTION__);
+		*MCF5282_I2C_I2CR = 0x00;
+		*MCF5282_I2C_I2CR = 0xA0;
+		dummyRead = *MCF5282_I2C_I2DR;
+		*MCF5282_I2C_I2SR = 0x00;
+		*MCF5282_I2C_I2CR = 0x00;
+	}
+	   
+	// default I2C mode is - slave and receive  
+	*MCF5282_I2C_I2CR &= ~(MCF5282_I2C_I2CR_MSTA |
MCF5282_I2C_I2CR_MTX);	
+
+	retval = i2c_add_adapter(&mcf5282_adapter);
+
+	if (retval < 0)
+		printk("%s - return code is: %d \n", __FUNCTION__,
retval);
+
+	return retval;
+};
+
+
+/*
+ *  I2C module exit function
+ */
+
+static void __exit i2c_mcf5282_exit(void)
+{
+	/* disable I2C and Interrupt */
+	*MCF5282_I2C_I2CR &= ~(MCF5282_I2C_I2CR_IEN |
MCF5282_I2C_I2CR_IIEN); 
+	i2c_del_adapter(&mcf5282_adapter);
+
+};
+
+
+MODULE_AUTHOR("Derek CL Cheung <derek.cheung@sympatico.ca>");
+MODULE_DESCRIPTION("MCF5282 I2C adaptor");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_mcf5282_init);
+module_exit(i2c_mcf5282_exit);
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.h
linux_dev/drivers/i2c/busses/i2c-mcf5282.h
--- linux-2.6.11.6/drivers/i2c/busses/i2c-mcf5282.h	1969-12-31
19:00:00.000000000 -0500
+++ linux_dev/drivers/i2c/busses/i2c-mcf5282.h	2005-04-05
19:22:00.000000000 -0400
@@ -0,0 +1,45 @@
+/*
+    i2c-mcf5282.h - header file for i2c-mcf5282.c
+
+    Copyright (c) 2005, Derek CL Cheung <derek.cheung@sympatico.ca>
+
<http://www3.sympatico.ca/derek.cheung>
+
+    This program is free software; you can redistribute it and/or
modify
+    it under the terms of the GNU General Public License as published
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
+                              u8 command, int size, union
i2c_smbus_data *data);
+static int mcf5282_write_data(const u8 data);
+static int mcf5282_i2c_start(const char read_write, const u16
target_address, const enum I2C_START_TYPE i2c_start);
+static int mcf5282_read_data(u8 * const rxData, const enum I2C_ACK_TYPE
ackType); 
+void dumpReg(char *, u16 addr, u8 data);
+
+/********************************************************************/
+#endif /*  __I2C_MCF5282_H__ */
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/Kconfig
linux_dev/drivers/i2c/busses/Kconfig
--- linux-2.6.11.6/drivers/i2c/busses/Kconfig	2005-03-25
22:28:29.000000000 -0500
+++ linux_dev/drivers/i2c/busses/Kconfig	2005-04-05
19:30:09.000000000 -0400
@@ -29,6 +29,16 @@ config I2C_ALI1563
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-ali1563.
 
+config I2C_MCF5282LITE
+        tristate "MCF5282Lite"
+        depends on I2C && EXPERIMENTAL
+        help
+          If you say yes to this option, support will be included for
the
+          I2C on the ColdFire MCF5282Lite Development Board
+
+          This driver can also be built as a module.  If so, the module
+          will be called i2c-mcf5282lite.
+
 config I2C_ALI15X3
 	tristate "ALI 15x3"
 	depends on I2C && PCI && EXPERIMENTAL
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/Kconfig.orig
linux_dev/drivers/i2c/busses/Kconfig.orig
--- linux-2.6.11.6/drivers/i2c/busses/Kconfig.orig	1969-12-31
19:00:00.000000000 -0500
+++ linux_dev/drivers/i2c/busses/Kconfig.orig	2005-04-05
19:09:18.000000000 -0400
@@ -0,0 +1,489 @@
+#
+# Sensor device configuration
+#
+
+menu "I2C Hardware Bus support"
+	depends on I2C
+
+config I2C_ALI1535
+	tristate "ALI 1535"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the SMB
+	  Host controller on Acer Labs Inc. (ALI) M1535 South Bridges.
The SMB
+	  controller is part of the 7101 device, which is an
ACPI-compliant
+	  Power Management Unit (PMU).
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-ali1535.
+
+config I2C_ALI1563
+	tristate "ALI 1563"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the SMB
+	  Host controller on Acer Labs Inc. (ALI) M1563 South Bridges.
The SMB
+	  controller is part of the 7101 device, which is an
ACPI-compliant
+	  Power Management Unit (PMU).
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-ali1563.
+
+config I2C_ALI15X3
+	tristate "ALI 15x3"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the
+	  Acer Labs Inc. (ALI) M1514 and M1543 motherboard I2C
interfaces.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-ali15x3.
+
+config I2C_AMD756
+	tristate "AMD 756/766/768/8111 and nVidia nForce"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the AMD
+	  756/766/768 mainboard I2C interfaces.  The driver also
includes
+	  support for the first (SMBus 1.0) I2C interface of the AMD
8111 and
+	  the nVidia nForce I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-amd756.
+
+config I2C_AMD756_S4882
+	tristate "SMBus multiplexing on the Tyan S4882"
+	depends on I2C_AMD756 && EXPERIMENTAL
+	help
+	  Enabling this option will add specific SMBus support for the
Tyan
+	  S4882 motherboard.  On this 4-CPU board, the SMBus is
multiplexed
+	  over 8 different channels, where the various memory module
EEPROMs
+	  and temperature sensors live.  Saying yes here will give you
access
+	  to these in addition to the trunk.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-amd756-s4882.
+
+config I2C_AMD8111
+	tristate "AMD 8111"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the
+	  second (SMBus 2.0) AMD 8111 mainboard I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-amd8111.
+
+config I2C_AU1550
+	tristate "Au1550 SMBus interface"
+	depends on I2C && SOC_AU1550
+	help
+	  If you say yes to this option, support will be included for
the
+	  Au1550 SMBus interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-au1550.
+
+config I2C_ELEKTOR
+	tristate "Elektor ISA card"
+	depends on I2C && ISA && BROKEN_ON_SMP
+	select I2C_ALGOPCF
+	help
+	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you
own
+	  such an adapter.
+
+	  This support is also available as a module.  If so, the module

+	  will be called i2c-elektor.
+
+config I2C_HYDRA
+	tristate "CHRP Apple Hydra Mac I/O I2C interface"
+	depends on I2C && PCI && PPC_CHRP && EXPERIMENTAL
+	select I2C_ALGOBIT
+	help
+	  This supports the use of the I2C interface in the Apple Hydra
Mac
+	  I/O chip on some CHRP machines (e.g. the LongTrail).  Say Y if
you
+	  have such a machine.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-hydra.
+
+config I2C_I801
+	tristate "Intel 801"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the Intel
+	  801 family of mainboard I2C interfaces.  Specifically, the
following
+	  versions of the chipset are supported:
+	    82801AA
+	    82801AB
+	    82801BA
+	    82801CA/CAM
+	    82801DB
+	    82801EB
+	    6300ESB
+	    ICH6
+	    ICH7
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-i801.
+
+config I2C_I810
+	tristate "Intel 810/815"
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
+	help
+	  If you say yes to this option, support will be included for
the Intel
+	  810/815 family of mainboard I2C interfaces.  Specifically, the

+	  following versions of the chipset is supported:
+	    i810AA
+	    i810AB
+	    i810E
+	    i815
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-i810.
+
+config I2C_IBM_IIC
+	tristate "IBM PPC 4xx on-chip I2C interface"
+	depends on IBM_OCP && I2C
+	help
+	  Say Y here if you want to use IIC peripheral found on 
+	  embedded IBM PPC 4xx based systems. 
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-ibm_iic.
+
+config I2C_IOP3XX
+	tristate "Intel IOP3xx and IXP4xx on-chip I2C interface"
+	depends on (ARCH_IOP3XX || ARCH_IXP4XX) && I2C
+	help
+	  Say Y here if you want to use the IIC bus controller on
+	  the Intel IOP3xx I/O Processors or IXP4xx Network Processors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-iop3xx.
+
+config I2C_ISA
+	tristate "ISA Bus support"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
i2c
+	  interfaces that are on the ISA bus.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-isa.
+
+config I2C_ITE
+	tristate "ITE I2C Adapter"
+	depends on I2C && MIPS_ITE8172
+	select I2C_ALGOITE
+	help
+	  This supports the ITE8172 I2C peripheral found on some MIPS
+	  systems. Say Y if you have one of these. You should also say Y
for
+	  the ITE I2C driver algorithm support above.
+
+	  This support is also available as a module.  If so, the module

+	  will be called i2c-ite.
+
+config I2C_IXP4XX
+	tristate "IXP4xx GPIO-Based I2C Interface"
+	depends on I2C && ARCH_IXP4XX
+	select I2C_ALGOBIT
+	help
+	  Say Y here if you have an Intel IXP4xx(420,421,422,425) based 
+	  system and are using GPIO lines for an I2C bus.
+
+	  This support is also available as a module. If so, the module
+	  will be called i2c-ixp4xx.
+
+config I2C_IXP2000
+	tristate "IXP2000 GPIO-Based I2C Interface"
+	depends on I2C && ARCH_IXP2000
+	select I2C_ALGOBIT
+	help
+	  Say Y here if you have an Intel IXP2000(2400, 2800, 2850)
based 
+	  system and are using GPIO lines for an I2C bus.
+
+	  This support is also available as a module. If so, the module
+	  will be called i2c-ixp2000.
+
+config I2C_KEYWEST
+	tristate "Powermac Keywest I2C interface"
+	depends on I2C && PPC_PMAC
+	help
+	  This supports the use of the I2C interface in the combo-I/O
+	  chip on recent Apple machines.  Say Y if you have such a
machine.
+
+	  This support is also available as a module.  If so, the module

+	  will be called i2c-keywest.
+
+config I2C_MPC
+	tristate "MPC107/824x/85xx/52xx"
+	depends on I2C && PPC
+	help
+	  If you say yes to this option, support will be included for
the
+	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245
and
+	  MPC85xx family processors. The driver may also work on 52xx
+	  family processors, though interrupts are known not to work.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mpc.
+
+config I2C_NFORCE2
+	tristate "Nvidia Nforce2"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the Nvidia
+	  Nforce2 family of mainboard I2C interfaces.
+	  This driver also supports the nForce3 Pro 150 MCP.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-nforce2.
+
+config I2C_PARPORT
+	tristate "Parallel port adapter"
+	depends on I2C && PARPORT
+	select I2C_ALGOBIT
+	help
+	  This supports parallel port I2C adapters such as the ones made
by
+	  Philips or Velleman, Analog Devices evaluation boards, and
more.
+	  Basically any adapter using the parallel port as an I2C bus
with
+	  no extra chipset is supported by this driver, or could be.
+
+	  This driver is a replacement for (and was inspired by) an
older
+	  driver named i2c-philips-par.  The new driver supports more
devices,
+	  and makes it easier to add support for new devices.
+	  
+	  Another driver exists, named i2c-parport-light, which doesn't
depend
+	  on the parport driver.  This is meant for embedded systems.
Don't say
+	  Y here if you intend to say Y or M there.
+
+	  This support is also available as a module.  If so, the module

+	  will be called i2c-parport.
+
+config I2C_PARPORT_LIGHT
+	tristate "Parallel port adapter (light)"
+	depends on I2C
+	select I2C_ALGOBIT
+	help
+	  This supports parallel port I2C adapters such as the ones made
by
+	  Philips or Velleman, Analog Devices evaluation boards, and
more.
+	  Basically any adapter using the parallel port as an I2C bus
with
+	  no extra chipset is supported by this driver, or could be.
+
+	  This driver is a light version of i2c-parport.  It doesn't
depend
+	  on the parport driver, and uses direct I/O access instead.
This
+	  might be prefered on embedded systems where wasting memory for
+	  the clean but heavy parport handling is not an option.  The
+	  drawback is a reduced portability and the impossibility to
+	  dasiy-chain other parallel port devices.
+	  
+	  Don't say Y here if you said Y or M to i2c-parport.  Saying M
to
+	  both is possible but both modules should not be loaded at the
same
+	  time.
+
+	  This support is also available as a module.  If so, the module

+	  will be called i2c-parport-light.
+
+config I2C_PIIX4
+	tristate "Intel PIIX4"
+	depends on I2C && PCI && EXPERIMENTAL && !64BIT
+	help
+	  If you say yes to this option, support will be included for
the Intel
+	  PIIX4 family of mainboard I2C interfaces.  Specifically, the
following
+	  versions of the chipset are supported:
+	    Intel PIIX4
+	    Intel 440MX
+	    Serverworks OSB4
+	    Serverworks CSB5
+	    Serverworks CSB6
+	    SMSC Victory66
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-piix4.
+
+config I2C_PROSAVAGE
+	tristate "S3/VIA (Pro)Savage"
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
+	help
+	  If you say yes to this option, support will be included for
the
+	  I2C bus and DDC bus of the S3VIA embedded Savage4 and
ProSavage8
+	  graphics processors.
+	  chipsets supported:
+	    S3/VIA KM266/VT8375 aka ProSavage8
+	    S3/VIA KM133/VT8365 aka Savage4
+
+	  This support is also available as a module.  If so, the module

+	  will be called i2c-prosavage.
+
+config I2C_RPXLITE
+	tristate "Embedded Planet RPX Lite/Classic support"
+	depends on (RPXLITE || RPXCLASSIC) && I2C
+	select I2C_ALGO8XX
+
+config I2C_S3C2410
+	tristate "S3C2410 I2C Driver"
+	depends on I2C && ARCH_S3C2410
+	help
+	  Say Y here to include support for I2C controller in the
+	  Samsung S3C2410 based System-on-Chip devices.
+
+config I2C_SAVAGE4
+	tristate "S3 Savage 4"
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
+	help
+	  If you say yes to this option, support will be included for
the 
+	  S3 Savage 4 I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-savage4.
+
+config I2C_SIBYTE
+	tristate "SiByte SMBus interface"
+	depends on SIBYTE_SB1xxx_SOC && I2C
+	help
+	  Supports the SiByte SOC on-chip I2C interfaces (2 channels).
+
+config SCx200_I2C
+	tristate "NatSemi SCx200 I2C using GPIO pins"
+	depends on SCx200_GPIO && I2C
+	select I2C_ALGOBIT
+	help
+	  Enable the use of two GPIO pins of a SCx200 processor as an
I2C bus.
+
+	  If you don't know what to do here, say N.
+
+	  This support is also available as a module.  If so, the module

+	  will be called scx200_i2c.
+
+config SCx200_I2C_SCL
+	int "GPIO pin used for SCL"
+	depends on SCx200_I2C
+	default "12"
+	help
+	  Enter the GPIO pin number used for the SCL signal.  This value
can
+	  also be specified with a module parameter.
+
+config SCx200_I2C_SDA
+	int "GPIO pin used for SDA"
+	depends on SCx200_I2C
+	default "13"
+	help
+	  Enter the GPIO pin number used for the SSA signal.  This value
can
+	  also be specified with a module parameter.
+
+config SCx200_ACB
+	tristate "NatSemi SCx200 ACCESS.bus"
+	depends on I2C && PCI
+	help
+	  Enable the use of the ACCESS.bus controllers of a SCx200
processor.
+
+	  If you don't know what to do here, say N.
+
+	  This support is also available as a module.  If so, the module

+	  will be called scx200_acb.
+
+config I2C_SIS5595
+	tristate "SiS 5595"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the 
+	  SiS5595 SMBus (a subset of I2C) interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis5595.
+
+config I2C_SIS630
+	tristate "SiS 630/730"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the 
+	  SiS630 and SiS730 SMBus (a subset of I2C) interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis630.
+
+config I2C_SIS96X
+	tristate "SiS 96x"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the SiS
+	  96x SMBus (a subset of I2C) interfaces.  Specifically, the
following
+	  chipsets are supported:
+	    645/961
+	    645DX/961
+	    645DX/962
+	    648/961
+	    650/961
+	    735
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis96x.
+
+config I2C_STUB
+	tristate "I2C/SMBus Test Stub"
+	depends on I2C && EXPERIMENTAL && 'm'
+	default 'n'
+	help
+	  This module may be useful to developers of SMBus client
drivers,
+	  especially for certain kinds of sensor chips.
+
+	  If you do build this module, be sure to read the notes and
warnings
+	  in <file:Documentation/i2c/i2c-stub>.
+
+	  If you don't know what to do here, definitely say N.
+
+config I2C_VIA
+	tristate "VIA 82C586B"
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
+	help
+	  If you say yes to this option, support will be included for
the VIA
+          82C586B I2C interface
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-via.
+
+config I2C_VIAPRO
+	tristate "VIA 82C596/82C686/823x"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for
the VIA
+	  82C596/82C686/823x I2C interfaces.  Specifically, the
following 
+	  chipsets are supported:
+	  82C596A/B
+	  82C686A/B
+	  8231
+	  8233
+	  8233A
+	  8235
+	  8237
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-viapro.
+
+config I2C_VOODOO3
+	tristate "Voodoo 3"
+	depends on I2C && PCI && EXPERIMENTAL
+	select I2C_ALGOBIT
+	help
+	  If you say yes to this option, support will be included for
the
+	  Voodoo 3 I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-voodoo3.
+
+config I2C_PCA_ISA
+	tristate "PCA9564 on an ISA bus"
+	depends on I2C
+	select I2C_ALGOPCA
+	help
+	  This driver supports ISA boards using the Philips PCA 9564
+	  Parallel bus to I2C bus controller
+	  
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-pca-isa.
+
+endmenu
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/Makefile
linux_dev/drivers/i2c/busses/Makefile
--- linux-2.6.11.6/drivers/i2c/busses/Makefile	2005-03-25
22:28:39.000000000 -0500
+++ linux_dev/drivers/i2c/busses/Makefile	2005-04-05
19:28:14.000000000 -0400
@@ -40,6 +40,8 @@ obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_I2C_MCF5282LITE)   += i2c-mcf5282.o
+
 
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG
diff -uprN -X dontdiff linux-2.6.11.6/drivers/i2c/busses/Makefile.orig
linux_dev/drivers/i2c/busses/Makefile.orig
--- linux-2.6.11.6/drivers/i2c/busses/Makefile.orig	1969-12-31
19:00:00.000000000 -0500
+++ linux_dev/drivers/i2c/busses/Makefile.orig	2005-04-05
19:09:18.000000000 -0400
@@ -0,0 +1,46 @@
+#
+# Makefile for the i2c bus drivers.
+#
+
+obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
+obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
+obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
+obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
+obj-$(CONFIG_I2C_AMD756_S4882)	+= i2c-amd756-s4882.o
+obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
+obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
+obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
+obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
+obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
+obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
+obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
+obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
+obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
+obj-$(CONFIG_I2C_ITE)		+= i2c-ite.o
+obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
+obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o
+obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
+obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
+obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
+obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
+obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
+obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
+obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
+obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
+obj-$(CONFIG_I2C_RPXLITE)	+= i2c-rpx.o
+obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
+obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
+obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
+obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
+obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
+obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
+obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
+obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
+obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
+obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
+obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
+obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+
+ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -uprN -X dontdiff linux-2.6.11.6/include/asm-m68knommu/m528xsim.h
linux_dev/include/asm-m68knommu/m528xsim.h
--- linux-2.6.11.6/include/asm-m68knommu/m528xsim.h	2005-03-25
22:28:13.000000000 -0500
+++ linux_dev/include/asm-m68knommu/m528xsim.h	2005-04-05
19:17:45.000000000 -0400
@@ -41,5 +41,117 @@
 #define	MCFSIM_DACR1		0x50		/* SDRAM base
address 1 */
 #define	MCFSIM_DMR1		0x54		/* SDRAM address
mask 1 */
 
+/*
+ *	Derek Cheung - 6 Feb 2005
+ *		add I2C and QSPI register definition using Freescale's
MCF5282
+ */
+/* set Port AS pin for I2C or UART */
+#define MCF5282_GPIO_PASPAR     (volatile u16 *) (MCF_IPSBAR +
0x00100056)
+
+/* Interrupt Mask Register Register Low */ 
+#define MCF5282_INTC0_IMRL      (volatile u32 *) (MCF_IPSBAR + 0x0C0C)
+/* Interrupt Control Register 7 */
+#define MCF5282_INTC0_ICR17     (volatile u8 *) (MCF_IPSBAR + 0x0C51)
+
+
+
+/*********************************************************************
+*
+* Inter-IC (I2C) Module
+*
+*********************************************************************/
+/* Read/Write access macros for general use */
+#define MCF5282_I2C_I2ADR       (volatile u8 *) (MCF_IPSBAR + 0x0300)
// Address 
+#define MCF5282_I2C_I2FDR       (volatile u8 *) (MCF_IPSBAR + 0x0304)
// Freq Divider
+#define MCF5282_I2C_I2CR        (volatile u8 *) (MCF_IPSBAR + 0x0308)
// Control
+#define MCF5282_I2C_I2SR        (volatile u8 *) (MCF_IPSBAR + 0x030C)
// Status
+#define MCF5282_I2C_I2DR        (volatile u8 *) (MCF_IPSBAR + 0x0310)
// Data I/O
+
+/* Bit level definitions and macros */
+#define MCF5282_I2C_I2ADR_ADDR(x)
(((x)&0x7F)<<0x01)
+
+#define MCF5282_I2C_I2FDR_IC(x)                         (((x)&0x3F))
+
+#define MCF5282_I2C_I2CR_IEN    (0x80)	// I2C enable
+#define MCF5282_I2C_I2CR_IIEN   (0x40)  // interrupt enable
+#define MCF5282_I2C_I2CR_MSTA   (0x20)  // master/slave mode
+#define MCF5282_I2C_I2CR_MTX    (0x10)  // transmit/receive mode
+#define MCF5282_I2C_I2CR_TXAK   (0x08)  // transmit acknowledge enable
+#define MCF5282_I2C_I2CR_RSTA   (0x04)  // repeat start
+
+#define MCF5282_I2C_I2SR_ICF    (0x80)  // data transfer bit
+#define MCF5282_I2C_I2SR_IAAS   (0x40)  // I2C addressed as a slave
+#define MCF5282_I2C_I2SR_IBB    (0x20)  // I2C bus busy
+#define MCF5282_I2C_I2SR_IAL    (0x10)  // aribitration lost
+#define MCF5282_I2C_I2SR_SRW    (0x04)  // slave read/write
+#define MCF5282_I2C_I2SR_IIF    (0x02)  // I2C interrupt
+#define MCF5282_I2C_I2SR_RXAK   (0x01)  // received acknowledge
+
+
+
+/*********************************************************************
+*
+* Queued Serial Peripheral Interface (QSPI) Module
+*
+*********************************************************************/
+/* Derek - 21 Feb 2005 */
+/* change to the format used in I2C */
+/* Read/Write access macros for general use */
+#define MCF5282_QSPI_QMR        MCF_IPSBAR + 0x0340
+#define MCF5282_QSPI_QDLYR      MCF_IPSBAR + 0x0344
+#define MCF5282_QSPI_QWR        MCF_IPSBAR + 0x0348
+#define MCF5282_QSPI_QIR        MCF_IPSBAR + 0x034C
+#define MCF5282_QSPI_QAR        MCF_IPSBAR + 0x0350
+#define MCF5282_QSPI_QDR        MCF_IPSBAR + 0x0354
+#define MCF5282_QSPI_QCR        MCF_IPSBAR + 0x0354
+
+/* Bit level definitions and macros */
+#define MCF5282_QSPI_QMR_MSTR                           (0x8000)
+#define MCF5282_QSPI_QMR_DOHIE                          (0x4000)
+#define MCF5282_QSPI_QMR_BITS_16                        (0x0000)
+#define MCF5282_QSPI_QMR_BITS_8                         (0x2000)
+#define MCF5282_QSPI_QMR_BITS_9                         (0x2400)
+#define MCF5282_QSPI_QMR_BITS_10                        (0x2800)
+#define MCF5282_QSPI_QMR_BITS_11                        (0x2C00)
+#define MCF5282_QSPI_QMR_BITS_12                        (0x3000)
+#define MCF5282_QSPI_QMR_BITS_13                        (0x3400)
+#define MCF5282_QSPI_QMR_BITS_14                        (0x3800)
+#define MCF5282_QSPI_QMR_BITS_15                        (0x3C00)
+#define MCF5282_QSPI_QMR_CPOL                           (0x0200)
+#define MCF5282_QSPI_QMR_CPHA                           (0x0100)
+#define MCF5282_QSPI_QMR_BAUD(x)                        (((x)&0x00FF))
+
+#define MCF5282_QSPI_QDLYR_SPE                          (0x80)
+#define MCF5282_QSPI_QDLYR_QCD(x)
(((x)&0x007F)<<8)
+#define MCF5282_QSPI_QDLYR_DTL(x)                       (((x)&0x00FF))
+
+#define MCF5282_QSPI_QWR_HALT                           (0x8000)
+#define MCF5282_QSPI_QWR_WREN                           (0x4000)
+#define MCF5282_QSPI_QWR_WRTO                           (0x2000)
+#define MCF5282_QSPI_QWR_CSIV                           (0x1000)
+#define MCF5282_QSPI_QWR_ENDQP(x)
(((x)&0x000F)<<8)
+#define MCF5282_QSPI_QWR_CPTQP(x)
(((x)&0x000F)<<4)
+#define MCF5282_QSPI_QWR_NEWQP(x)                       (((x)&0x000F))
+
+#define MCF5282_QSPI_QIR_WCEFB                          (0x8000)
+#define MCF5282_QSPI_QIR_ABRTB                          (0x4000)
+#define MCF5282_QSPI_QIR_ABRTL                          (0x1000)
+#define MCF5282_QSPI_QIR_WCEFE                          (0x0800)
+#define MCF5282_QSPI_QIR_ABRTE                          (0x0400)
+#define MCF5282_QSPI_QIR_SPIFE                          (0x0100)
+#define MCF5282_QSPI_QIR_WCEF                           (0x0008)
+#define MCF5282_QSPI_QIR_ABRT                           (0x0004)
+#define MCF5282_QSPI_QIR_SPIF                           (0x0001)
+
+#define MCF5282_QSPI_QAR_ADDR(x)                        (((x)&0x003F))
+
+#define MCF5282_QSPI_QDR_COMMAND(x)                     (((x)&0xFF00))
+#define MCF5282_QSPI_QCR_DATA(x)
(((x)&0x00FF)<<8)
+#define MCF5282_QSPI_QCR_CONT                           (0x8000)
+#define MCF5282_QSPI_QCR_BITSE                          (0x4000)
+#define MCF5282_QSPI_QCR_DT                             (0x2000)
+#define MCF5282_QSPI_QCR_DSCK                           (0x1000)
+#define MCF5282_QSPI_QCR_CS
(((x)&0x000F)<<8)
+
 
/***********************************************************************
*****/
 #endif	/* m528xsim_h */
diff -uprN -X dontdiff
linux-2.6.11.6/include/asm-m68knommu/m528xsim.h.orig
linux_dev/include/asm-m68knommu/m528xsim.h.orig
--- linux-2.6.11.6/include/asm-m68knommu/m528xsim.h.orig
1969-12-31 19:00:00.000000000 -0500
+++ linux_dev/include/asm-m68knommu/m528xsim.h.orig	2005-04-05
19:06:59.000000000 -0400
@@ -0,0 +1,45 @@
+/**********************************************************************
******/
+
+/*
+ *	m528xsim.h -- ColdFire 5280/5282 System Integration Module
support.
+ *
+ *	(C) Copyright 2003, Greg Ungerer (gerg@snapgear.com)
+ */
+
+/**********************************************************************
******/
+#ifndef	m528xsim_h
+#define	m528xsim_h
+/**********************************************************************
******/
+
+#include <linux/config.h>
+
+/*
+ *	Define the 5280/5282 SIM register set addresses.
+ */
+#define	MCFICM_INTC0		0x0c00		/* Base for
Interrupt Ctrl 0 */
+#define	MCFICM_INTC1		0x0d00		/* Base for
Interrupt Ctrl 0 */
+#define	MCFINTC_IPRH		0x00		/* Interrupt
pending 32-63 */
+#define	MCFINTC_IPRL		0x04		/* Interrupt
pending 1-31 */
+#define	MCFINTC_IMRH		0x08		/* Interrupt
mask 32-63 */
+#define	MCFINTC_IMRL		0x0c		/* Interrupt
mask 1-31 */
+#define	MCFINTC_INTFRCH		0x10		/* Interrupt
force 32-63 */
+#define	MCFINTC_INTFRCL		0x14		/* Interrupt
force 1-31 */
+#define	MCFINTC_IRLR		0x18		/* */
+#define	MCFINTC_IACKL		0x19		/* */
+#define	MCFINTC_ICR0		0x40		/* Base ICR
register */
+
+#define	MCFINT_VECBASE		64		/* Vector base
number */
+#define	MCFINT_UART0		13		/* Interrupt
number for UART0 */
+#define	MCFINT_PIT1		55		/* Interrupt
number for PIT1 */
+
+/*
+ *	SDRAM configuration registers.
+ */
+#define	MCFSIM_DCR		0x44		/* SDRAM control
*/
+#define	MCFSIM_DACR0		0x48		/* SDRAM base
address 0 */
+#define	MCFSIM_DMR0		0x4c		/* SDRAM address
mask 0 */
+#define	MCFSIM_DACR1		0x50		/* SDRAM base
address 1 */
+#define	MCFSIM_DMR1		0x54		/* SDRAM address
mask 1 */
+
+/**********************************************************************
******/
+#endif	/* m528xsim_h */




-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: April 5, 2005 12:49 AM
To: Derek Cheung
Subject: Re: I2C adaptor for ColdFire 5282 CPU

On Mon, Apr 04, 2005 at 09:18:36PM -0400, Derek Cheung wrote:
> Hi Greg,
> 
> Enclosed please find the ColdFire 5282 adaptor code that David has
just
> incorporated into the uClinux distribution. The files in the ZIP file
> are very self-contained as follows:
> 
> uClinux/linux-2.6.x/drivers/i2c/busses
> 		i2c-mcf5282.c
> 		i2c-mcf5282.mod.c
> 		i2c-mcf5282.h
> 		Kconfig
> 		Makefile
> 
> uClinux/linux-2.6.x/include/asm-m68knommu
> 		m528xsim.h
> 
> David advised me to send it to you (I2C Linux maintainer) for
> incorporation into the latest Linux kernel.
> 
> Please let me know if you have any questions.

I'm sorry, but I can't apply a .zip file directly by using patch :)

Take a look at Documenation/SubmittingPatches, and resend these, in
plain text form, with the proper Signed-off-by: line, and cc: the
sensors mailing list so that others there can comment on the code.

Also, the mod.c file isn't needed, as it is automatically generated by
the build process :)

thanks,

greg k-h

