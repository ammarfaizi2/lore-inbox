Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTIVXq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTIVXoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:44:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:8097 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262458AbTIVXap convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:45 -0400
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <10642734211077@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734213872@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:21 -0700
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.7, 2003/09/15 16:53:41-07:00, mporter@kernel.crashing.org

[PATCH] I2C: New PPC4xx I2C driver

This updates the current 2.6 PPC 4xx driver to the rewritten version
we have in the PPC development tree.  It is cleaner, has less bugs,
and has more features.


 drivers/i2c/i2c-algo-ibm_ocp.c |  900 -----------------------------------------
 drivers/i2c/i2c-algo-ibm_ocp.h |   55 --
 drivers/i2c/Kconfig            |    8 
 drivers/i2c/Makefile           |    1 
 drivers/i2c/i2c-ibm_iic.c      |  729 +++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-ibm_iic.h      |  124 +++++
 6 files changed, 856 insertions(+), 961 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Sep 22 16:15:04 2003
+++ b/drivers/i2c/Kconfig	Mon Sep 22 16:15:04 2003
@@ -203,13 +203,9 @@
 	tristate "Embedded Planet RPX Lite/Classic suppoort"
 	depends on (RPXLITE || RPXCLASSIC) && I2C_ALGO8XX
 
-config I2C_IBM_OCP_ALGO
-	tristate "IBM on-chip I2C Algorithm"
+config I2C_IBM_IIC
+	tristate "IBM IIC I2C"
 	depends on IBM_OCP && I2C
-
-config I2C_IBM_OCP_ADAP
-	tristate "IBM on-chip I2C Adapter"
-	depends on I2C_IBM_OCP_ALGO
 
 config I2C_IOP3XX
 	tristate "Intel XScale IOP3xx on-chip I2C interface"
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Mon Sep 22 16:15:04 2003
+++ b/drivers/i2c/Makefile	Mon Sep 22 16:15:04 2003
@@ -16,6 +16,7 @@
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
+obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
 obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-y				+= busses/ chips/
diff -Nru a/drivers/i2c/i2c-algo-ibm_ocp.c b/drivers/i2c/i2c-algo-ibm_ocp.c
--- a/drivers/i2c/i2c-algo-ibm_ocp.c	Mon Sep 22 16:15:04 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,900 +0,0 @@
-/*
-   -------------------------------------------------------------------------
-   i2c-algo-ibm_ocp.c i2c driver algorithms for IBM PPC 405 adapters	    
-   -------------------------------------------------------------------------
-      
-   Ian DaSilva, MontaVista Software, Inc.
-   idasilva@mvista.com or source@mvista.com
-
-   Copyright 2000 MontaVista Software Inc.
-
-   Changes made to support the IIC peripheral on the IBM PPC 405
-
-
-   ---------------------------------------------------------------------------
-   This file was highly leveraged from i2c-algo-pcf.c, which was created
-   by Simon G. Vogl and Hans Berglund:
-
-
-     Copyright (C) 1995-1997 Simon G. Vogl
-                   1998-2000 Hans Berglund
-
-   With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and 
-   Frodo Looijaard <frodol@dds.nl> ,and also from Martin Bailey
-   <mbailey@littlefeet-inc.com>
-
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-   ---------------------------------------------------------------------------
-
-   History: 01/20/12 - Armin
-   	akuster@mvista.com
-   	ported up to 2.4.16+	
-
-   Version 02/03/25 - Armin
-       converted to ocp format
-       removed commented out or #if 0 code
-       added Gérard Basler's fix to iic_combined_transaction() such that it 
-       returns the number of successfully completed transfers .
-*/
-
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-ibm_ocp.h>
-#include <asm/ocp.h>
-
-
-/* ----- global defines ----------------------------------------------- */
-#define DEB(x) if (i2c_debug>=1) x
-#define DEB2(x) if (i2c_debug>=2) x
-#define DEB3(x) if (i2c_debug>=3) x /* print several statistical values*/
-#define DEBPROTO(x) if (i2c_debug>=9) x;
- 	/* debug the protocol by showing transferred bits */
-#define DEF_TIMEOUT 5
-
-
-/* ----- global variables ---------------------------------------------	*/
-
-
-/* module parameters:
- */
-static int i2c_debug=0;
-
-/* --- setting states on the bus with the right timing: ---------------	*/
-
-#define iic_outb(adap, reg, val) adap->setiic(adap->data, (int) &(reg), val)
-#define iic_inb(adap, reg) adap->getiic(adap->data, (int) &(reg))
-
-#define IICO_I2C_SDAHIGH	0x0780
-#define IICO_I2C_SDALOW		0x0781
-#define IICO_I2C_SCLHIGH	0x0782
-#define IICO_I2C_SCLLOW		0x0783
-#define IICO_I2C_LINEREAD	0x0784
-
-#define IIC_SINGLE_XFER		0
-#define IIC_COMBINED_XFER	1
-
-#define IIC_ERR_LOST_ARB        -2
-#define IIC_ERR_INCOMPLETE_XFR  -3
-#define IIC_ERR_NACK            -1
-
-/* --- other auxiliary functions --------------------------------------	*/
-
-
-//
-// Description: Puts this process to sleep for a period equal to timeout 
-//
-static inline void iic_sleep(unsigned long timeout)
-{
-	schedule_timeout( timeout * HZ);
-}
-
-
-//
-// Description: This performs the IBM PPC 405 IIC initialization sequence
-// as described in the PPC405GP data book.
-//
-static int iic_init (struct i2c_algo_iic_data *adap)
-{
-	struct iic_regs *iic;	
-	struct iic_ibm *adap_priv_data = adap->data;
-	unsigned short	retval;
-	iic = (struct iic_regs *) adap_priv_data->iic_base;
-
-        /* Clear master low master address */
-        iic_outb(adap,iic->lmadr, 0);
-
-        /* Clear high master address */
-        iic_outb(adap,iic->hmadr, 0);
-
-        /* Clear low slave address */
-        iic_outb(adap,iic->lsadr, 0);
-
-        /* Clear high slave address */
-        iic_outb(adap,iic->hsadr, 0);
-
-        /* Clear status */
-        iic_outb(adap,iic->sts, 0x0a);
-
-        /* Clear extended status */
-        iic_outb(adap,iic->extsts, 0x8f);
-
-        /* Set clock division */
-        iic_outb(adap,iic->clkdiv, 0x04);
-
-	retval = iic_inb(adap, iic->clkdiv);
-	DEB(printk("iic_init: CLKDIV register = %x\n", retval));
-
-        /* Enable interrupts on Requested Master Transfer Complete */
-        iic_outb(adap,iic->intmsk, 0x01);
-
-        /* Clear transfer count */
-        iic_outb(adap,iic->xfrcnt, 0x0);
-
-        /* Clear extended control and status */
-        iic_outb(adap,iic->xtcntlss, 0xf0);
-
-        /* Set mode control (flush master data buf, enable hold SCL, exit */
-        /* unknown state.                                                 */
-        iic_outb(adap,iic->mdcntl, 0x47);
-
-        /* Clear control register */
-        iic_outb(adap,iic->cntl, 0x0);
-
-        DEB2(printk(KERN_DEBUG "iic_init: Initialized IIC on PPC 405\n"));
-        return 0;
-}
-
-
-//
-// Description: After we issue a transaction on the IIC bus, this function
-// is called.  It puts this process to sleep until we get an interrupt from
-// from the controller telling us that the transaction we requested in complete.
-//
-static int wait_for_pin(struct i2c_algo_iic_data *adap, int *status) 
-{
-
-	int timeout = DEF_TIMEOUT;
-	int retval;
-	struct iic_regs *iic;
-	struct iic_ibm *adap_priv_data = adap->data;
-	iic = (struct iic_regs *) adap_priv_data->iic_base;
-
-
-	*status = iic_inb(adap, iic->sts);
-#ifndef STUB_I2C
-
-	while (timeout-- && (*status & 0x01)) {
-	   adap->waitforpin(adap->data);
-	   *status = iic_inb(adap, iic->sts);
-	}
-#endif
-	if (timeout <= 0) {
-	   /* Issue stop signal on the bus, and force an interrupt */
-           retval = iic_inb(adap, iic->cntl);
-           iic_outb(adap, iic->cntl, retval | 0x80);
-           /* Clear status register */
-	   iic_outb(adap, iic->sts, 0x0a);
-	   /* Exit unknown bus state */
-	   retval = iic_inb(adap, iic->mdcntl);
-	   iic_outb(adap, iic->mdcntl, (retval | 0x02));
-
-	   // Check the status of the controller.  Does it still see a
-	   // pending transfer, even though we've tried to stop any
-	   // ongoing transaction?
-           retval = iic_inb(adap, iic->sts);
-           retval = retval & 0x01;
-           if(retval) {
-	      // The iic controller is hosed.  It is not responding to any
-	      // of our commands.  We have already tried to force it into
-	      // a known state, but it has not worked.  Our only choice now
-	      // is a soft reset, which will clear all registers, and force
-	      // us to re-initialize the controller.
-	      /* Soft reset */
-              iic_outb(adap, iic->xtcntlss, 0x01);
-              udelay(500);
-              iic_init(adap);
-	      /* Is the pending transfer bit in the sts reg finally cleared? */
-              retval = iic_inb(adap, iic->sts);
-              retval = retval & 0x01;
-              if(retval) {
-                 printk(KERN_CRIT "The IIC Controller is hosed.  A processor reset is required\n");
-              }
-	      // For some reason, even though the interrupt bit in this
-	      // register was set during iic_init, it didn't take.  We
-	      // need to set it again.  Don't ask me why....this is just what
-	      // I saw when testing timeouts.
-              iic_outb(adap, iic->intmsk, 0x01);
-           }
-	   return(-1);
-	}
-	else
-	   return(0);
-}
-
-
-//------------------------------------
-// Utility functions
-//
-
-
-//
-// Description: Look at the status register to see if there was an error
-// in the requested transaction.  If there is, look at the extended status
-// register and determine the exact cause.
-//
-int analyze_status(struct i2c_algo_iic_data *adap, int *error_code)
-{
-   int ret;
-   struct iic_regs *iic;
-   struct iic_ibm *adap_priv_data = adap->data;
-   iic = (struct iic_regs *) adap_priv_data->iic_base;
-
-	
-   ret = iic_inb(adap, iic->sts);
-   if(ret & 0x04) {
-      // Error occurred
-      ret = iic_inb(adap, iic->extsts);
-      if(ret & 0x04) {
-         // Lost arbitration
-         *error_code =  IIC_ERR_LOST_ARB;
-      }
-      if(ret & 0x02) {
-         // Incomplete transfer
-         *error_code = IIC_ERR_INCOMPLETE_XFR;
-      }
-      if(ret & 0x01) {
-         // Master transfer aborted by a NACK during the transfer of the 
-	 // address byte
-         *error_code = IIC_ERR_NACK;
-      }
-      return -1;
-   }
-   return 0;
-}
-
-
-//
-// Description: This function is called by the upper layers to do the
-// grunt work for a master send transaction
-//
-static int iic_sendbytes(struct i2c_adapter *i2c_adap,const char *buf,
-                         int count, int xfer_flag)
-{
-	struct iic_regs *iic;
-	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
-	struct iic_ibm *adap_priv_data = adap->data;
-	int wrcount, status, timeout;
-	int loops, remainder, i, j;
-	int ret, error_code;
-  	iic = (struct iic_regs *) adap_priv_data->iic_base;
-
- 
-	if( count == 0 ) return 0;
-	wrcount = 0;
-	loops =  count / 4;
-	remainder = count % 4;
-
-	if((loops > 1) && (remainder == 0)) {
-	   for(i=0; i<(loops-1); i++) {
-       	      //
-   	      // Write four bytes to master data buffer
-	      //
-	      for(j=0; j<4; j++) {
-   	         iic_outb(adap, iic->mdbuf, 
-	         buf[wrcount++]);
-  	      }
-	      //
-	      // Issue command to IICO device to begin transmission
-	      //
-	      iic_outb(adap, iic->cntl, 0x35);
-	      //
-	      // Wait for transmission to complete.  When it does, 
-	      //loop to the top of the for statement and write the 
-	      // next four bytes.
-	      //
-	      timeout = wait_for_pin(adap, &status);
-	      if(timeout < 0) {
-	         //
-	         // Error handling
-	         //
-                 //printk(KERN_ERR "Error: write timeout\n");
-                 return wrcount;
-	      }
-	      ret = analyze_status(adap, &error_code);
-	      if(ret < 0) {
-                 if(error_code == IIC_ERR_INCOMPLETE_XFR) {
-                    // Return the number of bytes transferred
-                    ret = iic_inb(adap, iic->xfrcnt);
-                    ret = ret & 0x07;
-                    return (wrcount-4+ret);
-                 }
-                 else return error_code;
-              }
-           }
-	}
-	else if((loops >= 1) && (remainder > 0)){
-	   //printk(KERN_DEBUG "iic_sendbytes: (loops >= 1)\n");
-	   for(i=0; i<loops; i++) {
-              //
-              // Write four bytes to master data buffer
-              //
-              for(j=0; j<4; j++) {
-                 iic_outb(adap, iic->mdbuf,
-                 buf[wrcount++]);
-              }
-              //
-              // Issue command to IICO device to begin transmission
-              //
-              iic_outb(adap, iic->cntl, 0x35);
-              //
-              // Wait for transmission to complete.  When it does,
-              //loop to the top of the for statement and write the
-              // next four bytes.
-              //
-              timeout = wait_for_pin(adap, &status);
-              if(timeout < 0) {
-                 //
-                 // Error handling
-                 //
-                 //printk(KERN_ERR "Error: write timeout\n");
-                 return wrcount;
-              }
-              ret = analyze_status(adap, &error_code);
-              if(ret < 0) {
-                 if(error_code == IIC_ERR_INCOMPLETE_XFR) {
-                    // Return the number of bytes transferred
-                    ret = iic_inb(adap, iic->xfrcnt);
-                    ret = ret & 0x07;
-                    return (wrcount-4+ret);
-                 }
-                 else return error_code;
-              }
-           }
-        }
-
-	//printk(KERN_DEBUG "iic_sendbytes: expedite write\n");
-	if(remainder == 0) remainder = 4;
-	// remainder = remainder - 1;
-	//
-	// Write the remaining bytes (less than or equal to 4)
-	//
-	for(i=0; i<remainder; i++) {
-	   iic_outb(adap, iic->mdbuf, buf[wrcount++]);
-	   //printk(KERN_DEBUG "iic_sendbytes:  data transferred = %x, wrcount = %d\n", buf[wrcount-1], (wrcount-1));
-	}
-        //printk(KERN_DEBUG "iic_sendbytes: Issuing write\n");
-
-        if(xfer_flag == IIC_COMBINED_XFER) {
-           iic_outb(adap, iic->cntl, (0x09 | ((remainder-1) << 4)));
-        }
-	else {
-           iic_outb(adap, iic->cntl, (0x01 | ((remainder-1) << 4)));
-        }
-	DEB2(printk(KERN_DEBUG "iic_sendbytes: Waiting for interrupt\n"));
-	timeout = wait_for_pin(adap, &status);
-        if(timeout < 0) {
-       	   //
-           // Error handling
-           //
-           //printk(KERN_ERR "Error: write timeout\n");
-           return wrcount;
-        }
-        ret = analyze_status(adap, &error_code);
-        if(ret < 0) {
-           if(error_code == IIC_ERR_INCOMPLETE_XFR) {
-              // Return the number of bytes transferred
-              ret = iic_inb(adap, iic->xfrcnt);
-              ret = ret & 0x07;
-              return (wrcount-4+ret);
-           }
-           else return error_code;
-        }
-	DEB2(printk(KERN_DEBUG "iic_sendbytes: Got interrupt\n"));
-	return wrcount;
-}
-
-
-//
-// Description: Called by the upper layers to do the grunt work for
-// a master read transaction.
-//
-static int iic_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count, int xfer_type)
-{
-	struct iic_regs *iic;
-	int rdcount=0, i, status, timeout;
-	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
-	struct iic_ibm *adap_priv_data = adap->data;
-	int loops, remainder, j;
-        int ret, error_code;
-	iic = (struct iic_regs *) adap_priv_data->iic_base;
-
-	if(count == 0) return 0;
-	loops = count / 4;
-	remainder = count % 4;
-
-	//printk(KERN_DEBUG "iic_readbytes: loops = %d, remainder = %d\n", loops, remainder);
-
-	if((loops > 1) && (remainder == 0)) {
-	//printk(KERN_DEBUG "iic_readbytes: (loops > 1) && (remainder == 0)\n");
-	   for(i=0; i<(loops-1); i++) {
-	      //
-              // Issue command to begin master read (4 bytes maximum)
-              //
-	      //printk(KERN_DEBUG "--->Issued read command\n");
-	      iic_outb(adap, iic->cntl, 0x37);
-	      //
-              // Wait for transmission to complete.  When it does,
-              // loop to the top of the for statement and write the
-              // next four bytes.
-              //
-	      //printk(KERN_DEBUG "--->Waiting for interrupt\n");
-              timeout = wait_for_pin(adap, &status);
-              if(timeout < 0) {
-	         // Error Handler
-		 //printk(KERN_ERR "Error: read timed out\n");
-                 return rdcount;
-	      }
-              //printk(KERN_DEBUG "--->Got interrupt\n");
-
-              ret = analyze_status(adap, &error_code);
-	      if(ret < 0) {
-                 if(error_code == IIC_ERR_INCOMPLETE_XFR)
-                    return rdcount;
-                 else
-                    return error_code;
-              }
-
-	      for(j=0; j<4; j++) {
-                 // Wait for data to shuffle to top of data buffer
-                 // This value needs to optimized.
-		 udelay(1);
-	         buf[rdcount] = iic_inb(adap, iic->mdbuf);
-	         rdcount++;
-		 //printk(KERN_DEBUG "--->Read one byte\n");
-              }
-           }
-	}
-
-	else if((loops >= 1) && (remainder > 0)){
-	//printk(KERN_DEBUG "iic_readbytes: (loops >=1) && (remainder > 0)\n");
-	   for(i=0; i<loops; i++) {
-              //
-              // Issue command to begin master read (4 bytes maximum)
-              //
-              //printk(KERN_DEBUG "--->Issued read command\n");
-              iic_outb(adap, iic->cntl, 0x37);
-              //
-              // Wait for transmission to complete.  When it does,
-              // loop to the top of the for statement and write the
-              // next four bytes.
-              //
-              //printk(KERN_DEBUG "--->Waiting for interrupt\n");
-              timeout = wait_for_pin(adap, &status);
-              if(timeout < 0) {
-                 // Error Handler
-                 //printk(KERN_ERR "Error: read timed out\n");
-                 return rdcount;
-              }
-              //printk(KERN_DEBUG "--->Got interrupt\n");
-
-              ret = analyze_status(adap, &error_code);
-              if(ret < 0) {
-                 if(error_code == IIC_ERR_INCOMPLETE_XFR)
-                    return rdcount;
-                 else
-                    return error_code;
-              }
-
-              for(j=0; j<4; j++) {
-                 // Wait for data to shuffle to top of data buffer
-                 // This value needs to optimized.
-                 udelay(1);
-                 buf[rdcount] = iic_inb(adap, iic->mdbuf);
-                 rdcount++;
-                 //printk(KERN_DEBUG "--->Read one byte\n");
-              }
-           }
-        }
-
-	//printk(KERN_DEBUG "iic_readbytes: expedite read\n");
-	if(remainder == 0) remainder = 4;
-	DEB2(printk(KERN_DEBUG "iic_readbytes: writing %x to IICO_CNTL\n", (0x03 | ((remainder-1) << 4))));
-
-	if(xfer_type == IIC_COMBINED_XFER) {
-	   iic_outb(adap, iic->cntl, (0x0b | ((remainder-1) << 4)));
-        }
-        else {
-	   iic_outb(adap, iic->cntl, (0x03 | ((remainder-1) << 4)));
-        }
-	DEB2(printk(KERN_DEBUG "iic_readbytes: Wait for pin\n"));
-        timeout = wait_for_pin(adap, &status);
-	DEB2(printk(KERN_DEBUG "iic_readbytes: Got the interrupt\n"));
-        if(timeout < 0) {
-           // Error Handler
-	   //printk(KERN_ERR "Error: read timed out\n");
-           return rdcount;
-        }
-
-        ret = analyze_status(adap, &error_code);
-        if(ret < 0) {
-           if(error_code == IIC_ERR_INCOMPLETE_XFR)
-              return rdcount;
-           else
-              return error_code;
-        }
-
-	//printk(KERN_DEBUG "iic_readbyte: Begin reading data buffer\n");
-	for(i=0; i<remainder; i++) {
-	   buf[rdcount] = iic_inb(adap, iic->mdbuf);
-	   // printk(KERN_DEBUG "iic_readbytes:  Character read = %x\n", buf[rdcount]);
-           rdcount++;
-	}
-
-	return rdcount;
-}
-
-
-//
-// Description:  This function implements combined transactions.  Combined
-// transactions consist of combinations of reading and writing blocks of data.
-// Each transfer (i.e. a read or a write) is separated by a repeated start
-// condition.
-//
-static int iic_combined_transaction(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num) 
-{
-   int i;
-   struct i2c_msg *pmsg;
-   int ret;
-
-   DEB2(printk(KERN_DEBUG "Beginning combined transaction\n"));
-	for(i=0; i < num; i++) {
-		pmsg = &msgs[i];
-		if(pmsg->flags & I2C_M_RD) {
-
-			// Last read or write segment needs to be terminated with a stop
-			if(i < num-1) {
-				DEB2(printk(KERN_DEBUG "This one is a read\n"));
-			}
-			else {
-				DEB2(printk(KERN_DEBUG "Doing the last read\n"));
-			}
-			ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, (i < num-1) ? IIC_COMBINED_XFER : IIC_SINGLE_XFER);
-
-			if (ret != pmsg->len) {
-				DEB2(printk("i2c-algo-ppc405.o: fail: "
-							"only read %d bytes.\n",ret));
-				return i;
-			}
-			else {
-				DEB2(printk("i2c-algo-ppc405.o: read %d bytes.\n",ret));
-			}
-		}
-		else if(!(pmsg->flags & I2C_M_RD)) {
-
-			// Last read or write segment needs to be terminated with a stop
-			if(i < num-1) {
-				DEB2(printk(KERN_DEBUG "This one is a write\n"));
-			}
-			else {
-				DEB2(printk(KERN_DEBUG "Doing the last write\n"));
-			}
-			ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, (i < num-1) ? IIC_COMBINED_XFER : IIC_SINGLE_XFER);
-
-			if (ret != pmsg->len) {
-				DEB2(printk("i2c-algo-ppc405.o: fail: "
-							"only wrote %d bytes.\n",ret));
-				return i;
-			}
-			else {
-				DEB2(printk("i2c-algo-ppc405.o: wrote %d bytes.\n",ret));
-			}
-		}
-	}
- 
-	return num;
-}
-
-
-//
-// Description: Whenever we initiate a transaction, the first byte clocked
-// onto the bus after the start condition is the address (7 bit) of the
-// device we want to talk to.  This function manipulates the address specified
-// so that it makes sense to the hardware when written to the IIC peripheral.
-//
-// Note: 10 bit addresses are not supported in this driver, although they are
-// supported by the hardware.  This functionality needs to be implemented.
-//
-static inline int iic_doAddress(struct i2c_algo_iic_data *adap,
-                                struct i2c_msg *msg, int retries) 
-{
-	struct iic_regs *iic;
-	unsigned short flags = msg->flags;
-	unsigned char addr;
-	struct iic_ibm *adap_priv_data = adap->data;
-	iic = (struct iic_regs *) adap_priv_data->iic_base;
-
-//
-// The following segment for 10 bit addresses needs to be ported
-//
-/* Ten bit addresses not supported right now
-	if ( (flags & I2C_M_TEN)  ) { 
-		// a ten bit address
-		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
-		// try extended address code...
-		ret = try_address(adap, addr, retries);
-		if (ret!=1) {
-			printk(KERN_ERR "iic_doAddress: died at extended address code.\n");
-			return -EREMOTEIO;
-		}
-		// the remaining 8 bit address
-		iic_outb(adap,msg->addr & 0x7f);
-		// Status check comes here
-		if (ret != 1) {
-			printk(KERN_ERR "iic_doAddress: died at 2nd address code.\n");
-			return -EREMOTEIO;
-		}
-		if ( flags & I2C_M_RD ) {
-			i2c_repstart(adap);
-			// okay, now switch into reading mode
-			addr |= 0x01;
-			ret = try_address(adap, addr, retries);
-			if (ret!=1) {
-				printk(KERN_ERR "iic_doAddress: died at extended address code.\n");
-				return -EREMOTEIO;
-			}
-		}
-	} else ----------> // normal 7 bit address
-
-Ten bit addresses not supported yet */
-
-	addr = ( msg->addr << 1 );
-	if (flags & I2C_M_RD )
-		addr |= 1;
-	if (flags & I2C_M_REV_DIR_ADDR )
-		addr ^= 1;
-	//
-	// Write to the low slave address
-	//
-	iic_outb(adap, iic->lmadr, addr);
-	//
-	// Write zero to the high slave register since we are
-	// only using 7 bit addresses
-	//
-	iic_outb(adap, iic->hmadr, 0);
-
-	return 0;
-}
-
-
-//
-// Description: Prepares the controller for a transaction (clearing status
-// registers, data buffers, etc), and then calls either iic_readbytes or
-// iic_sendbytes to do the actual transaction.
-//
-static int iic_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], 
-		    int num)
-{
-	struct iic_regs *iic;
-	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
-	struct iic_ibm *adap_priv_data = adap->data;
-	struct i2c_msg *pmsg;
-	int i = 0;
-	int ret;
-	iic = (struct iic_regs *) adap_priv_data->iic_base;
-
-	pmsg = &msgs[i];
-
-	//
-	// Clear status register
-	//
-	DEB2(printk(KERN_DEBUG "iic_xfer: iic_xfer: Clearing status register\n"));
-	iic_outb(adap, iic->sts, 0x0a);
-
-	//
-	// Wait for any pending transfers to complete
-	//
-	DEB2(printk(KERN_DEBUG "iic_xfer: Waiting for any pending transfers to complete\n"));
-	while((ret = iic_inb(adap, iic->sts)) == 0x01) {
-		;
-	}
-
-	//
-	// Flush master data buf
-	//
-	DEB2(printk(KERN_DEBUG "iic_xfer: Clearing master data buffer\n"));		
-	ret = iic_inb(adap, iic->mdcntl);
-	iic_outb(adap, iic->mdcntl, ret | 0x40);
-
-	//
-	// Load slave address
-	//
-	DEB2(printk(KERN_DEBUG "iic_xfer: Loading slave address\n"));
-	ret = iic_doAddress(adap, pmsg, i2c_adap->retries);
-
-        //
-        // Check to see if the bus is busy
-        //
-        ret = iic_inb(adap, iic->extsts);
-        // Mask off the irrelevent bits
-        ret = ret & 0x70;
-        // When the bus is free, the BCS bits in the EXTSTS register are 0b100
-        if(ret != 0x40) return IIC_ERR_LOST_ARB;
-
-	//
-	// Combined transaction (read and write)
-	//
-	if(num > 1) {
-           DEB2(printk(KERN_DEBUG "iic_xfer: Call combined transaction\n"));
-           ret = iic_combined_transaction(i2c_adap, msgs, num);
-        }
-	//
-	// Read only
-	//
-	else if((num == 1) && (pmsg->flags & I2C_M_RD)) {
-	   //
-	   // Tell device to begin reading data from the  master data 
-	   //
-	   DEB2(printk(KERN_DEBUG "iic_xfer: Call adapter's read\n"));
-	   ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER);
-	} 
-        //
-	// Write only
-	//
-	else if((num == 1 ) && (!(pmsg->flags & I2C_M_RD))) {
-	   //
-	   // Write data to master data buffers and tell our device
-	   // to begin transmitting
-	   //
-	   DEB2(printk(KERN_DEBUG "iic_xfer: Call adapter's write\n"));
-	   ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER);
-	}	
-
-	return ret;   
-}
-
-
-//
-// Description: Implements device specific ioctls.  Higher level ioctls can
-// be found in i2c-core.c and are typical of any i2c controller (specifying
-// slave address, timeouts, etc).  These ioctls take advantage of any hardware
-// features built into the controller for which this algorithm-adapter set
-// was written.  These ioctls allow you to take control of the data and clock
-// lines on the IBM PPC 405 IIC controller and set the either high or low,
-// similar to a GPIO pin.
-//
-static int algo_control(struct i2c_adapter *adapter, 
-	unsigned int cmd, unsigned long arg)
-{
-	struct iic_regs *iic;
-	struct i2c_algo_iic_data *adap = adapter->algo_data;
-	struct iic_ibm *adap_priv_data = adap->data;
-	int ret=0;
-	int lines;
-	iic = (struct iic_regs *) adap_priv_data->iic_base;
-
-	lines = iic_inb(adap, iic->directcntl);
-
-	if (cmd == IICO_I2C_SDAHIGH) {
-	      lines = lines & 0x01;
-	      if( lines ) lines = 0x04;
-	      else lines = 0;
-	      iic_outb(adap, iic->directcntl,(0x08|lines));
-	}
-	else if (cmd == IICO_I2C_SDALOW) {
-	      lines = lines & 0x01;
-	      if( lines ) lines = 0x04;
-              else lines = 0;
-              iic_outb(adap, iic->directcntl,(0x00|lines));
-	}
-	else if (cmd == IICO_I2C_SCLHIGH) {
-              lines = lines & 0x02;
-              if( lines ) lines = 0x08;
-              else lines = 0;
-              iic_outb(adap, iic->directcntl,(0x04|lines));
-	}
-	else if (cmd == IICO_I2C_SCLLOW) {
-              lines = lines & 0x02;
-	      if( lines ) lines = 0x08;
-              else lines = 0;
-              iic_outb(adap, iic->directcntl,(0x00|lines));
-	}
-	else if (cmd == IICO_I2C_LINEREAD) {
-	      ret = lines;
-	}
-	return ret;
-}
-
-
-static u32 iic_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING; 
-}
-
-
-/* -----exported algorithm data: -------------------------------------	*/
-
-static struct i2c_algorithm iic_algo = {
-	.name		= "IBM on-chip IIC algorithm",
-	.id		= I2C_ALGO_OCP,
-	.master_xfer	= iic_xfer,
-	.algo_control	= algo_control,
-	.functionality	= iic_func,
-};
-
-/* 
- * registering functions to load algorithms at runtime 
- */
-
-
-//
-// Description: Register bus structure
-//
-int i2c_ocp_add_bus(struct i2c_adapter *adap)
-{
-	struct i2c_algo_iic_data *iic_adap = adap->algo_data;
-
-	DEB2(printk(KERN_DEBUG "i2c-algo-iic.o: hw routines for %s registered.\n",
-	            adap->name));
-
-	/* register new adapter to i2c module... */
-
-	adap->id |= iic_algo.id;
-	adap->algo = &iic_algo;
-
-	adap->timeout = 100;	/* default values, should	*/
-	adap->retries = 3;		/* be replaced by defines	*/
-
-	iic_init(iic_adap);
-	i2c_add_adapter(adap);
-	return 0;
-}
-
-
-//
-// Done
-//
-int i2c_ocp_del_bus(struct i2c_adapter *adap)
-{
-	return i2c_del_adapter(adap);
-}
-
-
-EXPORT_SYMBOL(i2c_ocp_add_bus);
-EXPORT_SYMBOL(i2c_ocp_del_bus);
-
-//
-// The MODULE_* macros resolve to nothing if MODULES is not defined
-// when this file is compiled.
-//
-MODULE_AUTHOR("MontaVista Software <www.mvista.com>");
-MODULE_DESCRIPTION("PPC 405 iic algorithm");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(i2c_debug,"i");
-
-MODULE_PARM_DESC(i2c_debug,
-        "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
-
diff -Nru a/drivers/i2c/i2c-algo-ibm_ocp.h b/drivers/i2c/i2c-algo-ibm_ocp.h
--- a/drivers/i2c/i2c-algo-ibm_ocp.h	Mon Sep 22 16:15:04 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,55 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-algo-ibm_ocp.h i2c driver algorithms for IBM PPC 405 IIC adapters         */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 1995-97 Simon G. Vogl
-                   1998-99 Hans Berglund
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                */
-/* ------------------------------------------------------------------------- */
-
-/* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
-   Frodo Looijaard <frodol@dds.nl> */
-
-/* Modifications by MontaVista Software, August 2000
-   Changes made to support the IIC peripheral on the IBM PPC 405 */
-
-#ifndef I2C_ALGO_IIC_H
-#define I2C_ALGO_IIC_H 1
-
-/* --- Defines for pcf-adapters ---------------------------------------	*/
-#include <linux/i2c.h>
-
-struct i2c_algo_iic_data {
-	struct iic_regs *data;		/* private data for lolevel routines	*/
-	void (*setiic) (void *data, int ctl, int val);
-	int  (*getiic) (void *data, int ctl);
-	int  (*getown) (void *data);
-	int  (*getclock) (void *data);
-	void (*waitforpin) (void *data);     
-
-	/* local settings */
-	int udelay;
-	int mdelay;
-	int timeout;
-};
-
-
-#define I2C_IIC_ADAP_MAX	16
-
-
-int i2c_ocp_add_bus(struct i2c_adapter *);
-int i2c_ocp_del_bus(struct i2c_adapter *);
-
-#endif /* I2C_ALGO_IIC_H */
diff -Nru a/drivers/i2c/i2c-ibm_iic.c b/drivers/i2c/i2c-ibm_iic.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/i2c-ibm_iic.c	Mon Sep 22 16:15:04 2003
@@ -0,0 +1,729 @@
+/*
+ * drivers/i2c/i2c-ibm_iic.c
+ *
+ * Support for the IIC peripheral on IBM PPC 4xx
+ *
+ * Copyright (c) 2003 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * Based on original work by 
+ * 	Ian DaSilva  <idasilva@mvista.com>
+ *      Armin Kuster <akuster@mvista.com>
+ * 	Matt Porter  <mporter@mvista.com>
+ *
+ *      Copyright 2000-2003 MontaVista Software Inc.
+ *
+ * Original driver version was highly leveraged from i2c-elektor.c
+ *
+ *   	Copyright 1995-97 Simon G. Vogl
+ *                1998-99 Hans Berglund
+ *
+ *   	With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> 
+ *	and even Frodo Looijaard <frodol@dds.nl>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <asm/ocp.h>
+#include <asm/ibm4xx.h>
+
+#include "i2c-ibm_iic.h"
+
+#define DRIVER_VERSION "2.0"
+
+MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
+MODULE_LICENSE("GPL");
+
+static int iic_scan = 0;
+MODULE_PARM(iic_scan, "i");
+MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
+
+static int iic_force_poll = 0;
+MODULE_PARM(iic_force_poll, "i");
+MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
+
+static int iic_force_fast = 0;
+MODULE_PARM(iic_force_fast, "i");
+MODULE_PARM_DESC(iic_fast_poll, "Force fast mode (400 kHz)");
+
+#define DBG_LEVEL 0
+
+#ifdef DBG
+#undef DBG
+#endif
+
+#ifdef DBG2
+#undef DBG2
+#endif
+
+#if DBG_LEVEL > 0
+#  define DBG(x...)	printk(KERN_DEBUG "ibm-iic" ##x)
+#else
+#  define DBG(x...)	((void)0)
+#endif
+#if DBG_LEVEL > 1
+#  define DBG2(x...) 	DBG( ##x )
+#else
+#  define DBG2(x...) 	((void)0)
+#endif
+#if DBG_LEVEL > 2
+static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	printk(KERN_DEBUG "ibm-iic%d: %s\n", dev->idx, header);
+	printk(KERN_DEBUG "  cntl     = 0x%02x, mdcntl = 0x%02x\n"
+	       KERN_DEBUG "  sts      = 0x%02x, extsts = 0x%02x\n"
+	       KERN_DEBUG "  clkdiv   = 0x%02x, xfrcnt = 0x%02x\n"
+	       KERN_DEBUG "  xtcntlss = 0x%02x, directcntl = 0x%02x\n",
+		in_8(&iic->cntl), in_8(&iic->mdcntl), in_8(&iic->sts), 
+		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt), 
+		in_8(&iic->xtcntlss), in_8(&iic->directcntl));
+}
+#  define DUMP_REGS(h,dev)	dump_iic_regs((h),(dev))
+#else
+#  define DUMP_REGS(h,dev)	((void)0)
+#endif
+
+/* Enable/disable interrupt generation */
+static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int enable)
+{
+	out_8(&dev->vaddr->intmsk, enable ? INTRMSK_EIMTC : 0);
+}
+ 
+/*
+ * Initialize IIC interface.
+ */
+static void iic_dev_init(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+
+	DBG("%d: init\n", dev->idx);
+	
+	/* Clear master address */
+	out_8(&iic->lmadr, 0);
+	out_8(&iic->hmadr, 0);
+
+	/* Clear slave address */
+	out_8(&iic->lsadr, 0);
+	out_8(&iic->hsadr, 0);
+
+	/* Clear status & extended status */
+	out_8(&iic->sts, STS_SCMP | STS_IRQA);
+	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA
+			    | EXTSTS_ICT | EXTSTS_XFRA);
+
+	/* Set clock divider */
+	out_8(&iic->clkdiv, dev->clckdiv);
+
+	/* Clear transfer count */
+	out_8(&iic->xfrcnt, 0);
+
+	/* Clear extended control and status */
+	out_8(&iic->xtcntlss, XTCNTLSS_SRC | XTCNTLSS_SRS | XTCNTLSS_SWC
+			    | XTCNTLSS_SWS);
+
+	/* Clear control register */
+	out_8(&iic->cntl, 0);
+	
+	/* Enable interrupts if possible */
+	iic_interrupt_mode(dev, dev->irq >= 0);
+
+	/* Set mode control */
+	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
+			    | (dev->fast_mode ? MDCNTL_FSM : 0));
+
+	DUMP_REGS("iic_init", dev);
+}
+
+/* 
+ * Reset IIC interface
+ */
+static void iic_dev_reset(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	int i;
+	u8 dc;
+	
+	DBG("%d: soft reset\n", dev->idx);
+	DUMP_REGS("reset", dev);
+	
+    	/* Place chip in the reset state */
+	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
+	
+	/* Check if bus is free */
+	dc = in_8(&iic->directcntl);	
+	if (!DIRCTNL_FREE(dc)){
+		DBG("%d: trying to regain bus control\n", dev->idx);
+	
+		/* Try to set bus free state */
+		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);	
+	
+		/* Wait until we regain bus control */
+		for (i = 0; i < 100; ++i){
+			dc = in_8(&iic->directcntl);
+			if (DIRCTNL_FREE(dc))
+				break;
+			
+			/* Toggle SCL line */
+			dc ^= DIRCNTL_SCC;
+			out_8(&iic->directcntl, dc);
+			udelay(10);
+			dc ^= DIRCNTL_SCC;
+			out_8(&iic->directcntl, dc);
+			
+			/* be nice */
+			cond_resched();
+		}
+	}
+	
+	/* Remove reset */
+	out_8(&iic->xtcntlss, 0);
+	
+	/* Reinitialize interface */
+	iic_dev_init(dev);
+}
+
+/*
+ * IIC interrupt handler
+ */
+static irqreturn_t iic_handler(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
+	volatile struct iic_regs* iic = dev->vaddr;
+	
+	DBG2("%d: irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n", 
+	     dev->idx, in_8(&iic->sts), in_8(&iic->extsts));
+	
+	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
+	out_8(&iic->sts, STS_IRQA | STS_SCMP);
+	wake_up_interruptible(&dev->wq);
+	
+	return IRQ_HANDLED;
+}
+
+/*
+ * Get master transfer result and clear errors if any.
+ * Returns the number of actually transferred bytes or error (<0)
+ */
+static int iic_xfer_result(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;	
+	
+	if (unlikely(in_8(&iic->sts) & STS_ERR)){
+		DBG("%d: xfer error, EXTSTS = 0x%02x\n", dev->idx, 
+			in_8(&iic->extsts));
+				
+		/* Clear errors and possible pending IRQs */
+		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | 
+			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
+			
+		/* Flush master data buffer */
+		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
+		
+		/* Is bus free?
+		 * If error happened during combined xfer
+		 * IIC interface is usually stuck in some strange
+		 * state, the only way out - soft reset.
+		 */
+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+			DBG("%d: bus is stuck, resetting\n", dev->idx);
+			iic_dev_reset(dev);
+		}
+		return -EREMOTEIO;
+	}
+	else
+		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
+}
+
+/*
+ * Try to abort active transfer.
+ */
+static void iic_abort_xfer(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	unsigned long x;
+	
+	DBG("%d: iic_abort_xfer\n", dev->idx);
+	
+	out_8(&iic->cntl, CNTL_HMT);
+	
+	/*
+	 * Wait for the abort command to complete.
+	 * It's not worth to be optimized, just poll (timeout >= 1 tick)
+	 */
+	x = jiffies + 2;
+	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+		if (time_after(jiffies, x)){
+			DBG("%d: abort timeout, resetting...\n", dev->idx);
+			iic_dev_reset(dev);
+			return;
+		}
+		schedule();
+	}
+
+	/* Just to clear errors */
+	iic_xfer_result(dev);
+}
+
+/*
+ * Wait for master transfer to complete.
+ * It puts current process to sleep until we get interrupt or timeout expires.
+ * Returns the number of transferred bytes or error (<0)
+ */
+static int iic_wait_for_tc(struct ibm_iic_private* dev){
+	
+	volatile struct iic_regs *iic = dev->vaddr;
+	int ret = 0;
+	
+	if (dev->irq >= 0){
+		/* Interrupt mode */
+		wait_queue_t wait;
+    		init_waitqueue_entry(&wait, current);
+		
+		add_wait_queue(&dev->wq, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (in_8(&iic->sts) & STS_PT)
+			schedule_timeout(dev->adap.timeout * HZ);
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&dev->wq, &wait);
+		
+		if (unlikely(signal_pending(current))){
+			DBG("%d: wait interrupted\n", dev->idx);
+			ret = -ERESTARTSYS;
+		} else if (unlikely(in_8(&iic->sts) & STS_PT)){
+			DBG("%d: wait timeout\n", dev->idx);
+			ret = -ETIMEDOUT;
+		}
+	}
+	else {
+		/* Polling mode */
+		unsigned long x = jiffies + dev->adap.timeout * HZ;
+		
+		while (in_8(&iic->sts) & STS_PT){
+			if (unlikely(time_after(jiffies, x))){
+				DBG("%d: poll timeout\n", dev->idx);
+				ret = -ETIMEDOUT;
+				break;
+			}
+		
+			if (unlikely(signal_pending(current))){
+				DBG("%d: poll interrupted\n", dev->idx);
+				ret = -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}	
+	}
+	
+	if (unlikely(ret < 0))
+		iic_abort_xfer(dev);
+	else
+		ret = iic_xfer_result(dev);
+	
+	DBG2("%d: iic_wait_for_tc -> %d\n", dev->idx, ret);
+	
+	return ret;
+}
+
+/*
+ * Low level master transfer routine
+ */
+static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm, 
+			  int combined_xfer)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	char* buf = pm->buf;
+	int i, j, loops, ret = 0;
+	int len = pm->len;
+
+	u8 cntl = (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
+	if (pm->flags & I2C_M_RD)
+		cntl |= CNTL_RW;
+	
+	loops = (len + 3) / 4;
+	for (i = 0; i < loops; ++i, len -= 4){
+		int count = len > 4 ? 4 : len;
+		u8 cmd = cntl | ((count - 1) << CNTL_TCT_SHIFT);
+		
+		if (!(cntl & CNTL_RW))
+			for (j = 0; j < count; ++j)
+				out_8((volatile u8*)&iic->mdbuf, *buf++);
+		
+		if (i < loops - 1)
+			cmd |= CNTL_CHT;
+		else if (combined_xfer)
+			cmd |= CNTL_RPST;
+		
+		DBG2("%d: xfer_bytes, %d, CNTL = 0x%02x\n", dev->idx, count, cmd);
+		
+		/* Start transfer */
+		out_8(&iic->cntl, cmd);
+		
+		/* Wait for completion */
+		ret = iic_wait_for_tc(dev);
+
+		if (unlikely(ret < 0))
+			break;
+		else if (unlikely(ret != count)){
+			DBG("%d: xfer_bytes, requested %d, transfered %d\n", 
+				dev->idx, count, ret);
+			
+			/* If it's not a last part of xfer, abort it */
+			if (combined_xfer || (i < loops - 1))
+    				iic_abort_xfer(dev);
+				
+			ret = -EREMOTEIO;
+			break;				
+		}
+		
+		if (cntl & CNTL_RW)
+			for (j = 0; j < count; ++j)
+				*buf++ = in_8((volatile u8*)&iic->mdbuf);
+	}
+	
+	return ret > 0 ? 0 : ret;
+}
+
+/*
+ * Set target slave address for master transfer
+ */
+static inline void iic_address(struct ibm_iic_private* dev, struct i2c_msg* msg)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	u16 addr = msg->addr;
+	
+	DBG2("%d: iic_address, 0x%03x (%d-bit)\n", dev->idx, 
+		addr, msg->flags & I2C_M_TEN ? 10 : 7);
+	
+	if (msg->flags & I2C_M_TEN){
+	    out_8(&iic->cntl, CNTL_AMD);
+	    out_8(&iic->lmadr, addr);
+	    out_8(&iic->hmadr, 0xf0 | ((addr >> 7) & 0x06));
+	}
+	else {
+	    out_8(&iic->cntl, 0);
+	    out_8(&iic->lmadr, addr << 1);
+	}
+}
+
+static inline int iic_invalid_address(const struct i2c_msg* p)
+{
+	return (p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN) && (p->addr > 0x7f));
+}
+
+static inline int iic_address_neq(const struct i2c_msg* p1, 
+				  const struct i2c_msg* p2)
+{
+	return (p1->addr != p2->addr) 
+		|| ((p1->flags & I2C_M_TEN) != (p2->flags & I2C_M_TEN));
+} 
+
+/*
+ * Generic master transfer entrypoint. 
+ * Returns the number of processed messages or error (<0)
+ */
+static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+    	struct ibm_iic_private* dev = (struct ibm_iic_private*)(i2c_get_adapdata(adap));
+	volatile struct iic_regs *iic = dev->vaddr;
+	int i, ret = 0;
+	
+	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
+	
+	if (!num)
+		return 0;
+	
+	/* Check the sanity of the passed messages.
+	 * Uhh, generic i2c layer is more suitable place for such code...
+	 */
+	if (unlikely(iic_invalid_address(&msgs[0]))){
+		DBG("%d: invalid address 0x%03x (%d-bit)\n", dev->idx, 
+			msgs[0].addr, msgs[0].flags & I2C_M_TEN ? 10 : 7);
+		return -EINVAL;
+	}		
+	for (i = 0; i < num; ++i){
+		if (unlikely(msgs[i].len <= 0)){
+			DBG("%d: invalid len %d in msg[%d]\n", dev->idx, 
+				msgs[i].len, i);
+			return -EINVAL;
+		}
+		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))){
+			DBG("%d: invalid addr in msg[%d]\n", dev->idx, i);
+			return -EINVAL;
+		}
+	}
+	
+	/* Check bus state */
+	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE)){
+		DBG("%d: iic_xfer, bus is not free\n", dev->idx);
+		
+		/* Usually it means something serious has happend.
+		 * We *cannot* have unfinished previous transfer
+		 * so it doesn't make any sense to try to stop it.
+		 * Probably we were not able to recover from the 
+		 * previous error.
+		 * The only *reasonable* thing I can think of here
+		 * is soft reset.  --ebs
+		 */
+		iic_dev_reset(dev);
+		
+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
+			return -EREMOTEIO;
+		}
+	} 
+	else {
+		/* Flush master data buffer (just in case) */
+		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
+	}
+	
+	/* Load slave address */
+	iic_address(dev, &msgs[0]);
+	
+	/* Do real transfer */
+    	for (i = 0; i < num && !ret; ++i)
+		ret = iic_xfer_bytes(dev, &msgs[i], i < num - 1);
+
+	return ret < 0 ? ret : num;
+}
+
+static u32 iic_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
+}
+
+static struct i2c_algorithm iic_algo = {
+	.name 		= "IBM IIC algorithm",
+	.id   		= I2C_ALGO_OCP,
+	.master_xfer 	= iic_xfer,
+	.smbus_xfer	= NULL,
+	.slave_send	= NULL,
+	.slave_recv	= NULL,
+	.algo_control	= NULL,
+	.functionality	= iic_func
+};
+
+/*
+ * Scan bus for valid 7-bit addresses (ie things that ACK on 1 byte read)
+ * We only scan range [0x08 - 0x77], all other addresses are reserved anyway
+ */
+static void __devinit iic_scan_bus(struct ibm_iic_private* dev)
+{
+	int found = 0;
+	char dummy;
+	struct i2c_msg msg = {
+		.buf   = &dummy,
+		.len   = sizeof(dummy),
+		.flags = I2C_M_RD
+	};
+	
+	printk(KERN_INFO "ibm-iic%d: scanning bus...\n" KERN_INFO, dev->idx);
+	
+	for (msg.addr = 8; msg.addr < 0x78; ++msg.addr)
+		if (iic_xfer(&dev->adap, &msg, 1) == 1){
+			++found;
+			printk(" 0x%02x", msg.addr);
+		}
+
+	printk("%sibm-iic%d: %d device(s) detected\n", 
+		found ? "\n" KERN_INFO : "", dev->idx, found);
+}
+
+/*
+ * Calculates IICx_CLCKDIV value for a specific OPB clock frequency
+ */
+static inline u8 iic_clckdiv(unsigned int opb)
+{
+	/* Compatibility kludge, should go away after all cards
+	 * are fixed to fill correct value for opbfreq.
+	 * Previous driver version used hardcoded divider value 4,
+	 * it corresponds to OPB frequency from the range (40, 50] MHz
+	 */
+	if (!opb){
+		printk(KERN_WARNING "ibm-iic: using compatibility value for OPB freq,"
+			" fix your board specific setup\n");
+		opb = 50000000;
+	}
+
+	/* Convert to MHz */
+	opb /= 1000000;
+	
+	if (opb < 20 || opb > 150){
+		printk(KERN_CRIT "ibm-iic: invalid OPB clock frequency %u MHz\n",
+			opb);
+		opb = opb < 20 ? 20 : 150;
+	}
+	return (u8)((opb + 9) / 10 - 1);
+}
+
+/*
+ * Register single IIC interface
+ */
+static int __devinit iic_probe(struct ocp_device *ocp){
+
+	struct ibm_iic_private* dev;
+	struct i2c_adapter* adap;
+	int ret;
+	bd_t* bd = (bd_t*)&__res;
+	
+	if (!(dev = kmalloc(sizeof(*dev), GFP_KERNEL))){
+		printk(KERN_CRIT "ibm-iic: failed to allocate device data\n");
+		return -ENOMEM;
+	}
+
+	memset(dev, 0, sizeof(*dev));
+	dev->idx = ocp->num;
+	ocp_set_drvdata(ocp, dev);
+	
+	if (!(dev->vaddr = ioremap(ocp->paddr, sizeof(struct iic_regs)))){
+		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
+			dev->idx);
+		ret = -ENXIO;
+		goto fail2;
+	}
+	
+	init_waitqueue_head(&dev->wq);
+
+	dev->irq = iic_force_poll ? -1 : ocp->irq;
+	if (dev->irq >= 0){
+		/* Disable interrupts until we finish intialization,
+		   assumes level-sensitive IRQ setup...
+		 */
+		iic_interrupt_mode(dev, 0);
+		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
+			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n", 
+				dev->idx, dev->irq);
+			/* Fallback to the polling mode */	
+			dev->irq = -1;
+		}
+	}
+	
+	if (dev->irq < 0)
+		printk(KERN_WARNING "ibm-iic%d: using polling mode\n", 
+			dev->idx);
+		
+	/* Board specific settings */
+	BUG_ON(dev->idx >= sizeof(bd->bi_iic_fast) / sizeof(bd->bi_iic_fast[0]));
+	dev->fast_mode = iic_force_fast ? 1 : bd->bi_iic_fast[dev->idx];
+	
+	/* clckdiv is the same for *all* IIC interfaces, 
+	 * but I'd rather make a copy than introduce another global. --ebs
+	 */
+	dev->clckdiv = iic_clckdiv(bd->bi_opb_busfreq);
+	DBG("%d: clckdiv = %d\n", dev->idx, dev->clckdiv);
+	
+	/* Initialize IIC interface */
+	iic_dev_init(dev);
+	
+	/* Register it with i2c layer */
+	adap = &dev->adap;
+	strcpy(adap->dev.name, "IBM IIC");
+	i2c_set_adapdata(adap, dev);
+	adap->id = I2C_HW_OCP | iic_algo.id;
+	adap->algo = &iic_algo;
+	adap->client_register = NULL;
+	adap->client_unregister = NULL;
+	adap->timeout = 1;
+	adap->retries = 1;
+
+	if ((ret = i2c_add_adapter(adap)) != 0){
+		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
+			dev->idx);
+		goto fail;
+	}
+	
+	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
+		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
+
+	/* Scan bus if requested by user */
+	if (iic_scan)
+		iic_scan_bus(dev);
+
+	return 0;
+
+fail:	
+	if (dev->irq >= 0){
+		iic_interrupt_mode(dev, 0);
+		free_irq(dev->irq, dev);
+	}	
+
+	iounmap((void*)dev->vaddr);
+fail2:	
+	ocp_set_drvdata(ocp, 0);
+	kfree(dev);	
+	return ret;
+}
+
+/*
+ * Cleanup initialized IIC interface
+ */
+static void __devexit iic_remove(struct ocp_device *ocp)
+{
+	struct ibm_iic_private* dev = (struct ibm_iic_private*)ocp_get_drvdata(ocp);
+	BUG_ON(dev == NULL);
+	if (i2c_del_adapter(&dev->adap)){
+		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
+			dev->idx);
+		/* That's *very* bad, just shutdown IRQ ... */
+		if (dev->irq >= 0){
+		    iic_interrupt_mode(dev, 0);	
+		    free_irq(dev->irq, dev);
+		    dev->irq = -1;
+		}
+	} else {
+		if (dev->irq >= 0){
+		    iic_interrupt_mode(dev, 0);	
+		    free_irq(dev->irq, dev);
+		}
+		iounmap((void*)dev->vaddr);
+		kfree(dev);
+	}
+}
+
+static struct ocp_device_id ibm_iic_ids[] __devinitdata = 
+{
+	{ .vendor = OCP_VENDOR_IBM, .device = OCP_FUNC_IIC },
+	{ .vendor = OCP_VENDOR_INVALID }
+};
+
+MODULE_DEVICE_TABLE(ocp, ibm_iic_ids);
+
+static struct ocp_driver ibm_iic_driver =
+{
+	.name 		= "ocp_iic",
+	.id_table	= ibm_iic_ids,
+	.probe		= iic_probe,
+	.remove		= __devexit_p(iic_remove),
+#if defined(CONFIG_PM)
+	.suspend	= NULL,
+	.resume		= NULL,
+#endif
+};
+
+static int __init iic_init(void)
+{
+	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
+	return ocp_module_init(&ibm_iic_driver);
+}
+
+static void __exit iic_exit(void)
+{
+	ocp_unregister_driver(&ibm_iic_driver);
+}
+
+module_init(iic_init);
+module_exit(iic_exit);
diff -Nru a/drivers/i2c/i2c-ibm_iic.h b/drivers/i2c/i2c-ibm_iic.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/i2c-ibm_iic.h	Mon Sep 22 16:15:04 2003
@@ -0,0 +1,124 @@
+/*
+ * drivers/i2c/i2c-ibm_iic.h
+ *
+ * Support for the IIC peripheral on IBM PPC 4xx
+ * 
+ * Copyright (c) 2003 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * Based on original work by 
+ * 	Ian DaSilva  <idasilva@mvista.com>
+ *      Armin Kuster <akuster@mvista.com>
+ * 	Matt Porter  <mporter@mvista.com>
+ *
+ *      Copyright 2000-2003 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifndef __I2C_IBM_IIC_H_
+#define __I2C_IBM_IIC_H_
+
+#include <linux/config.h>
+#include <linux/i2c.h> 
+
+struct iic_regs {
+	u16 mdbuf;
+	u16 sbbuf;
+	u8 lmadr;
+	u8 hmadr;
+	u8 cntl;
+	u8 mdcntl;
+	u8 sts;
+	u8 extsts;
+	u8 lsadr;
+	u8 hsadr;
+	u8 clkdiv;
+	u8 intmsk;
+	u8 xfrcnt;
+	u8 xtcntlss;
+	u8 directcntl;
+};
+
+struct ibm_iic_private {
+	struct i2c_adapter adap;
+	volatile struct iic_regs *vaddr;
+	wait_queue_head_t wq;
+	int idx;
+	int irq;
+	int fast_mode;
+	u8  clckdiv;
+};
+
+/* IICx_CNTL register */
+#define CNTL_HMT	0x80
+#define CNTL_AMD	0x40
+#define CNTL_TCT_MASK	0x30
+#define CNTL_TCT_SHIFT	4
+#define CNTL_RPST	0x08
+#define CNTL_CHT	0x04 
+#define CNTL_RW		0x02
+#define CNTL_PT		0x01
+
+/* IICx_MDCNTL register */
+#define MDCNTL_FSDB	0x80
+#define MDCNTL_FMDB	0x40
+#define MDCNTL_EGC	0x20
+#define MDCNTL_FSM	0x10
+#define MDCNTL_ESM	0x08
+#define MDCNTL_EINT	0x04
+#define MDCNTL_EUBS	0x02
+#define MDCNTL_HSCL	0x01
+
+/* IICx_STS register */
+#define STS_SSS		0x80
+#define STS_SLPR	0x40
+#define STS_MDBS	0x20
+#define STS_MDBF	0x10
+#define STS_SCMP	0x08
+#define STS_ERR		0x04
+#define STS_IRQA	0x02
+#define STS_PT		0x01
+
+/* IICx_EXTSTS register */
+#define EXTSTS_IRQP	0x80
+#define EXTSTS_BCS_MASK	0x70
+#define   EXTSTS_BCS_FREE  0x40
+#define EXTSTS_IRQD	0x08
+#define EXTSTS_LA	0x04
+#define EXTSTS_ICT	0x02
+#define EXTSTS_XFRA	0x01
+
+/* IICx_INTRMSK register */
+#define INTRMSK_EIRC	0x80
+#define INTRMSK_EIRS	0x40
+#define INTRMSK_EIWC	0x20
+#define INTRMSK_EIWS	0x10
+#define INTRMSK_EIHE	0x08
+#define INTRMSK_EIIC	0x04
+#define INTRMSK_EITA	0x02
+#define INTRMSK_EIMTC	0x01
+
+/* IICx_XFRCNT register */
+#define XFRCNT_MTC_MASK	0x07
+
+/* IICx_XTCNTLSS register */
+#define XTCNTLSS_SRC	0x80
+#define XTCNTLSS_SRS	0x40
+#define XTCNTLSS_SWC	0x20
+#define XTCNTLSS_SWS	0x10
+#define XTCNTLSS_SRST	0x01
+
+/* IICx_DIRECTCNTL register */
+#define DIRCNTL_SDAC	0x08
+#define DIRCNTL_SCC	0x04
+#define DIRCNTL_MSDA	0x02
+#define DIRCNTL_MSC	0x01
+
+/* Check if we really control the I2C bus and bus is free */
+#define DIRCTNL_FREE(v)	(((v) & 0x0f) == 0x0f)
+
+#endif /* __I2C_IBM_IIC_H_ */

