Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318133AbSHIDUp>; Thu, 8 Aug 2002 23:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318135AbSHIDUp>; Thu, 8 Aug 2002 23:20:45 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:61313 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318133AbSHIDTc>; Thu, 8 Aug 2002 23:19:32 -0400
Message-ID: <3D53359B.BC5980FB@attbi.com>
Date: Thu, 08 Aug 2002 23:23:07 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 3/4] 2.5.30 i2c updates
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Please apply the following four patches that update
2.5.30 with these I2C changes:
o Support for SMBus 2.0 PEC Packet Error Checking
o New adapter-i2c-frodo for SA 1110 board
o New adapter-i2c-rpx for embeded MPC8XX
o Replace depreciated cli()&sti() with spin_{un}lock_irq()
o Updated documentation
Thanks,
Albert
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/include/linux/i2c-algo-8xx.h  2002-06-11 22:29:54.000000000 -0400
@@ -0,0 +1,43 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-algo-8xx.h i2c driver algorithms for MPX8XX CPM                      */
+/*
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
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
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                */
+/* ------------------------------------------------------------------------- */
+
+/* $Id: i2c-algo-8xx.h,v 1.3 2002/06/12 02:29:54 mds Exp $ */
+
+#ifndef I2C_ALGO_8XX_H
+#define I2C_ALGO_8XX_H 1
+
+#include <linux/i2c.h>
+
+struct i2c_algo_8xx_data {
+       uint dp_addr;
+       int reloc;
+       volatile i2c8xx_t *i2c;
+       volatile iic_t  *iip;
+       volatile cpm8xx_t *cp;
+
+       int     (*setisr) (int irq,
+                          void (*func)(void *, void *),
+                          void *data);
+
+       u_char  temp[513];
+};
+
+int i2c_8xx_add_bus(struct i2c_adapter *);
+int i2c_8xx_del_bus(struct i2c_adapter *);
+
+#endif /* I2C_ALGO_8XX_H */
--- linux-2.5.26/drivers/i2c/i2c-algo-bit.c.orig        2002-07-05 19:42:28.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-bit.c    2002-07-07 20:41:49.000000000 -0400
@@ -21,7 +21,7 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.c,v 1.34 2001/11/19 18:45:02 mds Exp $ */
+/* $Id: i2c-algo-bit.c,v 1.37 2002/07/08 00:41:49 mds Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -143,7 +148,7 @@
        /* scl, sda may not be high */
        DEBPROTO(printk(" Sr "));
        setsda(adap,1);
-       setscl(adap,1);
+       sclhi(adap);
        udelay(adap->udelay);
        
        sdalo(adap);
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-ibm_ocp.c        2002-07-03 21:00:38.000000000 -0400
@@ -0,0 +1,966 @@
+/*
+   -------------------------------------------------------------------------
+   i2c-algo-ibm_ocp.c i2c driver algorithms for IBM PPC 405 adapters       
+   -------------------------------------------------------------------------
+      
+   Ian DaSilva, MontaVista Software, Inc.
+   idasilva@mvista.com or source@mvista.com
+
+   Copyright 2000 MontaVista Software Inc.
+
+   Changes made to support the IIC peripheral on the IBM PPC 405
+
+
+   ---------------------------------------------------------------------------
+   This file was highly leveraged from i2c-algo-pcf.c, which was created
+   by Simon G. Vogl and Hans Berglund:
+
+
+     Copyright (C) 1995-1997 Simon G. Vogl
+                   1998-2000 Hans Berglund
+
+   With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and 
+   Frodo Looijaard <frodol@dds.nl> ,and also from Martin Bailey
+   <mbailey@littlefeet-inc.com>
+
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
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
+   ---------------------------------------------------------------------------
+
+   History: 01/20/12 - Armin
+       akuster@mvista.com
+       ported up to 2.4.16+    
+
+   Version 02/03/25 - Armin
+       converted to ocp format
+       removed commented out or #if 0 code
+       added Gérard Basler's fix to iic_combined_transaction() such that it 
+       returns the number of successfully completed transfers .
+*/
+
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+
+#include <linux/i2c.h>
+#include "i2c-algo-ibm_ocp.h"
+//ACC#include <asm/ocp.h>
+
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
+
+
+/* ----- global defines ----------------------------------------------- */
+#define DEB(x) if (i2c_debug>=1) x
+#define DEB2(x) if (i2c_debug>=2) x
+#define DEB3(x) if (i2c_debug>=3) x /* print several statistical values*/
+#define DEBPROTO(x) if (i2c_debug>=9) x;
+       /* debug the protocol by showing transferred bits */
+#define DEF_TIMEOUT 5
+
+/* debugging - slow down transfer to have a look at the data ..        */
+/* I use this with two leds&resistors, each one connected to sda,scl   */
+/* respectively. This makes sure that the algorithm works. Some chips   */
+/* might not like this, as they have an internal timeout of some mils  */
+/*
+#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
+                        if (need_resched) schedule();
+*/
+
+
+/* ----- global variables ---------------------------------------------        */
+
+#ifdef SLO_IO
+       int jif;
+#endif
+
+/* module parameters:
+ */
+static int i2c_debug=0;
+static int iic_scan=0; /* have a look at what's hanging 'round         */
+
+/* --- setting states on the bus with the right timing: ---------------        */
+
+#define iic_outb(adap, reg, val) adap->setiic(adap->data, (int) &(reg), val)
+#define iic_inb(adap, reg) adap->getiic(adap->data, (int) &(reg))
+
+#define IICO_I2C_SDAHIGH       0x0780
+#define IICO_I2C_SDALOW                0x0781
+#define IICO_I2C_SCLHIGH       0x0782
+#define IICO_I2C_SCLLOW                0x0783
+#define IICO_I2C_LINEREAD      0x0784
+
+#define IIC_SINGLE_XFER                0
+#define IIC_COMBINED_XFER      1
+
+#define IIC_ERR_LOST_ARB        -2
+#define IIC_ERR_INCOMPLETE_XFR  -3
+#define IIC_ERR_NACK            -1
+
+/* --- other auxiliary functions --------------------------------------        */
+
+
+//
+// Description: Puts this process to sleep for a period equal to timeout 
+//
+static inline void iic_sleep(unsigned long timeout)
+{
+       schedule_timeout( timeout * HZ);
+}
+
+
+//
+// Description: This performs the IBM PPC 405 IIC initialization sequence
+// as described in the PPC405GP data book.
+//
+static int iic_init (struct i2c_algo_iic_data *adap)
+{
+       struct iic_regs *iic;   
+       struct iic_ibm *adap_priv_data = adap->data;
+       unsigned short  retval;
+       iic = (struct iic_regs *) adap_priv_data->iic_base;
+
+        /* Clear master low master address */
+        iic_outb(adap,iic->lmadr, 0);
+
+        /* Clear high master address */
+        iic_outb(adap,iic->hmadr, 0);
+
+        /* Clear low slave address */
+        iic_outb(adap,iic->lsadr, 0);
+
+        /* Clear high slave address */
+        iic_outb(adap,iic->hsadr, 0);
+
+        /* Clear status */
+        iic_outb(adap,iic->sts, 0x0a);
+
+        /* Clear extended status */
+        iic_outb(adap,iic->extsts, 0x8f);
+
+        /* Set clock division */
+        iic_outb(adap,iic->clkdiv, 0x04);
+
+       retval = iic_inb(adap, iic->clkdiv);
+       DEB(printk("iic_init: CLKDIV register = %x\n", retval));
+
+        /* Enable interrupts on Requested Master Transfer Complete */
+        iic_outb(adap,iic->intmsk, 0x01);
+
+        /* Clear transfer count */
+        iic_outb(adap,iic->xfrcnt, 0x0);
+
+        /* Clear extended control and status */
+        iic_outb(adap,iic->xtcntlss, 0xf0);
+
+        /* Set mode control (flush master data buf, enable hold SCL, exit */
+        /* unknown state.                                                 */
+        iic_outb(adap,iic->mdcntl, 0x47);
+
+        /* Clear control register */
+        iic_outb(adap,iic->cntl, 0x0);
+
+        DEB2(printk(KERN_DEBUG "iic_init: Initialized IIC on PPC 405\n"));
+        return 0;
+}
+
+
+//
+// Description: After we issue a transaction on the IIC bus, this function
+// is called.  It puts this process to sleep until we get an interrupt from
+// from the controller telling us that the transaction we requested in complete.
+//
+static int wait_for_pin(struct i2c_algo_iic_data *adap, int *status) 
+{
+
+       int timeout = DEF_TIMEOUT;
+       int retval;
+       struct iic_regs *iic;
+       struct iic_ibm *adap_priv_data = adap->data;
+       iic = (struct iic_regs *) adap_priv_data->iic_base;
+
+
+       *status = iic_inb(adap, iic->sts);
+#ifndef STUB_I2C
+
+       while (timeout-- && (*status & 0x01)) {
+          adap->waitforpin(adap->data);
+          *status = iic_inb(adap, iic->sts);
+       }
+#endif
+       if (timeout <= 0) {
+          /* Issue stop signal on the bus, and force an interrupt */
+           retval = iic_inb(adap, iic->cntl);
+           iic_outb(adap, iic->cntl, retval | 0x80);
+           /* Clear status register */
+          iic_outb(adap, iic->sts, 0x0a);
+          /* Exit unknown bus state */
+          retval = iic_inb(adap, iic->mdcntl);
+          iic_outb(adap, iic->mdcntl, (retval | 0x02));
+
+          // Check the status of the controller.  Does it still see a
+          // pending transfer, even though we've tried to stop any
+          // ongoing transaction?
+           retval = iic_inb(adap, iic->sts);
+           retval = retval & 0x01;
+           if(retval) {
+             // The iic controller is hosed.  It is not responding to any
+             // of our commands.  We have already tried to force it into
+             // a known state, but it has not worked.  Our only choice now
+             // is a soft reset, which will clear all registers, and force
+             // us to re-initialize the controller.
+             /* Soft reset */
+              iic_outb(adap, iic->xtcntlss, 0x01);
+              udelay(500);
+              iic_init(adap);
+             /* Is the pending transfer bit in the sts reg finally cleared? */
+              retval = iic_inb(adap, iic->sts);
+              retval = retval & 0x01;
+              if(retval) {
+                 printk(KERN_CRIT "The IIC Controller is hosed.  A processor reset is required\n");
+              }
+             // For some reason, even though the interrupt bit in this
+             // register was set during iic_init, it didn't take.  We
+             // need to set it again.  Don't ask me why....this is just what
+             // I saw when testing timeouts.
+              iic_outb(adap, iic->intmsk, 0x01);
+           }
+          return(-1);
+       }
+       else
+          return(0);
+}
+
+
+//------------------------------------
+// Utility functions
+//
+
+
+//
+// Description: Look at the status register to see if there was an error
+// in the requested transaction.  If there is, look at the extended status
+// register and determine the exact cause.
+//
+int analyze_status(struct i2c_algo_iic_data *adap, int *error_code)
+{
+   int ret;
+   struct iic_regs *iic;
+   struct iic_ibm *adap_priv_data = adap->data;
+   iic = (struct iic_regs *) adap_priv_data->iic_base;
+
+       
+   ret = iic_inb(adap, iic->sts);
+   if(ret & 0x04) {
+      // Error occurred
+      ret = iic_inb(adap, iic->extsts);
+      if(ret & 0x04) {
+         // Lost arbitration
+         *error_code =  IIC_ERR_LOST_ARB;
+      }
+      if(ret & 0x02) {
+         // Incomplete transfer
+         *error_code = IIC_ERR_INCOMPLETE_XFR;
+      }
+      if(ret & 0x01) {
+         // Master transfer aborted by a NACK during the transfer of the 
+        // address byte
+         *error_code = IIC_ERR_NACK;
+      }
+      return -1;
+   }
+   return 0;
+}
+
+
+//
+// Description: This function is called by the upper layers to do the
+// grunt work for a master send transaction
+//
+static int iic_sendbytes(struct i2c_adapter *i2c_adap,const char *buf,
+                         int count, int xfer_flag)
+{
+       struct iic_regs *iic;
+       struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
+       struct iic_ibm *adap_priv_data = adap->data;
+       int wrcount, status, timeout;
+       int loops, remainder, i, j;
+       int ret, error_code;
+       iic = (struct iic_regs *) adap_priv_data->iic_base;
+
+ 
+       if( count == 0 ) return 0;
+       wrcount = 0;
+       loops =  count / 4;
+       remainder = count % 4;
+
+       if((loops > 1) && (remainder == 0)) {
+          for(i=0; i<(loops-1); i++) {
+                     //
+             // Write four bytes to master data buffer
+             //
+             for(j=0; j<4; j++) {
+                iic_outb(adap, iic->mdbuf, 
+                buf[wrcount++]);
+             }
+             //
+             // Issue command to IICO device to begin transmission
+             //
+             iic_outb(adap, iic->cntl, 0x35);
+             //
+             // Wait for transmission to complete.  When it does, 
+             //loop to the top of the for statement and write the 
+             // next four bytes.
+             //
+             timeout = wait_for_pin(adap, &status);
+             if(timeout < 0) {
+                //
+                // Error handling
+                //
+                 //printk(KERN_ERR "Error: write timeout\n");
+                 return wrcount;
+             }
+             ret = analyze_status(adap, &error_code);
+             if(ret < 0) {
+                 if(error_code == IIC_ERR_INCOMPLETE_XFR) {
+                    // Return the number of bytes transferred
+                    ret = iic_inb(adap, iic->xfrcnt);
+                    ret = ret & 0x07;
+                    return (wrcount-4+ret);
+                 }
+                 else return error_code;
+              }
+           }
+       }
+       else if((loops >= 1) && (remainder > 0)){
+          //printk(KERN_DEBUG "iic_sendbytes: (loops >= 1)\n");
+          for(i=0; i<loops; i++) {
+              //
+              // Write four bytes to master data buffer
+              //
+              for(j=0; j<4; j++) {
+                 iic_outb(adap, iic->mdbuf,
+                 buf[wrcount++]);
+              }
+              //
+              // Issue command to IICO device to begin transmission
+              //
+              iic_outb(adap, iic->cntl, 0x35);
+              //
+              // Wait for transmission to complete.  When it does,
+              //loop to the top of the for statement and write the
+              // next four bytes.
+              //
+              timeout = wait_for_pin(adap, &status);
+              if(timeout < 0) {
+                 //
+                 // Error handling
+                 //
+                 //printk(KERN_ERR "Error: write timeout\n");
+                 return wrcount;
+              }
+              ret = analyze_status(adap, &error_code);
+              if(ret < 0) {
+                 if(error_code == IIC_ERR_INCOMPLETE_XFR) {
+                    // Return the number of bytes transferred
+                    ret = iic_inb(adap, iic->xfrcnt);
+                    ret = ret & 0x07;
+                    return (wrcount-4+ret);
+                 }
+                 else return error_code;
+              }
+           }
+        }
+
+       //printk(KERN_DEBUG "iic_sendbytes: expedite write\n");
+       if(remainder == 0) remainder = 4;
+       // remainder = remainder - 1;
+       //
+       // Write the remaining bytes (less than or equal to 4)
+       //
+       for(i=0; i<remainder; i++) {
+          iic_outb(adap, iic->mdbuf, buf[wrcount++]);
+          //printk(KERN_DEBUG "iic_sendbytes:  data transferred = %x, wrcount = %d\n", buf[wrcount-1], (wrcount-1));
+       }
+        //printk(KERN_DEBUG "iic_sendbytes: Issuing write\n");
+
+        if(xfer_flag == IIC_COMBINED_XFER) {
+           iic_outb(adap, iic->cntl, (0x09 | ((remainder-1) << 4)));
+        }
+       else {
+           iic_outb(adap, iic->cntl, (0x01 | ((remainder-1) << 4)));
+        }
+       DEB2(printk(KERN_DEBUG "iic_sendbytes: Waiting for interrupt\n"));
+       timeout = wait_for_pin(adap, &status);
+        if(timeout < 0) {
+                  //
+           // Error handling
+           //
+           //printk(KERN_ERR "Error: write timeout\n");
+           return wrcount;
+        }
+        ret = analyze_status(adap, &error_code);
+        if(ret < 0) {
+           if(error_code == IIC_ERR_INCOMPLETE_XFR) {
+              // Return the number of bytes transferred
+              ret = iic_inb(adap, iic->xfrcnt);
+              ret = ret & 0x07;
+              return (wrcount-4+ret);
+           }
+           else return error_code;
+        }
+       DEB2(printk(KERN_DEBUG "iic_sendbytes: Got interrupt\n"));
+       return wrcount;
+}
+
+
+//
+// Description: Called by the upper layers to do the grunt work for
+// a master read transaction.
+//
+static int iic_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count, int xfer_type)
+{
+       struct iic_regs *iic;
+       int rdcount=0, i, status, timeout;
+       struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
+       struct iic_ibm *adap_priv_data = adap->data;
+       int loops, remainder, j;
+        int ret, error_code;
+       iic = (struct iic_regs *) adap_priv_data->iic_base;
+
+       if(count == 0) return 0;
+       loops = count / 4;
+       remainder = count % 4;
+
+       //printk(KERN_DEBUG "iic_readbytes: loops = %d, remainder = %d\n", loops, remainder);
+
+       if((loops > 1) && (remainder == 0)) {
+       //printk(KERN_DEBUG "iic_readbytes: (loops > 1) && (remainder == 0)\n");
+          for(i=0; i<(loops-1); i++) {
+             //
+              // Issue command to begin master read (4 bytes maximum)
+              //
+             //printk(KERN_DEBUG "--->Issued read command\n");
+             iic_outb(adap, iic->cntl, 0x37);
+             //
+              // Wait for transmission to complete.  When it does,
+              // loop to the top of the for statement and write the
+              // next four bytes.
+              //
+             //printk(KERN_DEBUG "--->Waiting for interrupt\n");
+              timeout = wait_for_pin(adap, &status);
+              if(timeout < 0) {
+                // Error Handler
+                //printk(KERN_ERR "Error: read timed out\n");
+                 return rdcount;
+             }
+              //printk(KERN_DEBUG "--->Got interrupt\n");
+
+              ret = analyze_status(adap, &error_code);
+             if(ret < 0) {
+                 if(error_code == IIC_ERR_INCOMPLETE_XFR)
+                    return rdcount;
+                 else
+                    return error_code;
+              }
+
+             for(j=0; j<4; j++) {
+                 // Wait for data to shuffle to top of data buffer
+                 // This value needs to optimized.
+                udelay(1);
+                buf[rdcount] = iic_inb(adap, iic->mdbuf);
+                rdcount++;
+                //printk(KERN_DEBUG "--->Read one byte\n");
+              }
+           }
+       }
+
+       else if((loops >= 1) && (remainder > 0)){
+       //printk(KERN_DEBUG "iic_readbytes: (loops >=1) && (remainder > 0)\n");
+          for(i=0; i<loops; i++) {
+              //
+              // Issue command to begin master read (4 bytes maximum)
+              //
+              //printk(KERN_DEBUG "--->Issued read command\n");
+              iic_outb(adap, iic->cntl, 0x37);
+              //
+              // Wait for transmission to complete.  When it does,
+              // loop to the top of the for statement and write the
+              // next four bytes.
+              //
+              //printk(KERN_DEBUG "--->Waiting for interrupt\n");
+              timeout = wait_for_pin(adap, &status);
+              if(timeout < 0) {
+                 // Error Handler
+                 //printk(KERN_ERR "Error: read timed out\n");
+                 return rdcount;
+              }
+              //printk(KERN_DEBUG "--->Got interrupt\n");
+
+              ret = analyze_status(adap, &error_code);
+              if(ret < 0) {
+                 if(error_code == IIC_ERR_INCOMPLETE_XFR)
+                    return rdcount;
+                 else
+                    return error_code;
+              }
+
+              for(j=0; j<4; j++) {
+                 // Wait for data to shuffle to top of data buffer
+                 // This value needs to optimized.
+                 udelay(1);
+                 buf[rdcount] = iic_inb(adap, iic->mdbuf);
+                 rdcount++;
+                 //printk(KERN_DEBUG "--->Read one byte\n");
+              }
+           }
+        }
+
+       //printk(KERN_DEBUG "iic_readbytes: expedite read\n");
+       if(remainder == 0) remainder = 4;
+       DEB2(printk(KERN_DEBUG "iic_readbytes: writing %x to IICO_CNTL\n", (0x03 | ((remainder-1) << 4))));
+
+       if(xfer_type == IIC_COMBINED_XFER) {
+          iic_outb(adap, iic->cntl, (0x0b | ((remainder-1) << 4)));
+        }
+        else {
+          iic_outb(adap, iic->cntl, (0x03 | ((remainder-1) << 4)));
+        }
+       DEB2(printk(KERN_DEBUG "iic_readbytes: Wait for pin\n"));
+        timeout = wait_for_pin(adap, &status);
+       DEB2(printk(KERN_DEBUG "iic_readbytes: Got the interrupt\n"));
+        if(timeout < 0) {
+           // Error Handler
+          //printk(KERN_ERR "Error: read timed out\n");
+           return rdcount;
+        }
+
+        ret = analyze_status(adap, &error_code);
+        if(ret < 0) {
+           if(error_code == IIC_ERR_INCOMPLETE_XFR)
+              return rdcount;
+           else
+              return error_code;
+        }
+
+       //printk(KERN_DEBUG "iic_readbyte: Begin reading data buffer\n");
+       for(i=0; i<remainder; i++) {
+          buf[rdcount] = iic_inb(adap, iic->mdbuf);
+          // printk(KERN_DEBUG "iic_readbytes:  Character read = %x\n", buf[rdcount]);
+           rdcount++;
+       }
+
+       return rdcount;
+}
+
+
+//
+// Description:  This function implements combined transactions.  Combined
+// transactions consist of combinations of reading and writing blocks of data.
+// Each transfer (i.e. a read or a write) is separated by a repeated start
+// condition.
+//
+static int iic_combined_transaction(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num) 
+{
+   int i;
+   struct i2c_msg *pmsg;
+   int ret;
+
+   DEB2(printk(KERN_DEBUG "Beginning combined transaction\n"));
+       for(i=0; i < num; i++) {
+               pmsg = &msgs[i];
+               if(pmsg->flags & I2C_M_RD) {
+
+                       // Last read or write segment needs to be terminated with a stop
+                       if(i < num-1) {
+                               DEB2(printk(KERN_DEBUG "This one is a read\n"));
+                       }
+                       else {
+                               DEB2(printk(KERN_DEBUG "Doing the last read\n"));
+                       }
+                       ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, (i < num-1) ? IIC_COMBINED_XFER : IIC_SINGLE_XFER);
+
+                       if (ret != pmsg->len) {
+                               DEB2(printk("i2c-algo-ppc405.o: fail: "
+                                                       "only read %d bytes.\n",ret));
+                               return i;
+                       }
+                       else {
+                               DEB2(printk("i2c-algo-ppc405.o: read %d bytes.\n",ret));
+                       }
+               }
+               else if(!(pmsg->flags & I2C_M_RD)) {
+
+                       // Last read or write segment needs to be terminated with a stop
+                       if(i < num-1) {
+                               DEB2(printk(KERN_DEBUG "This one is a write\n"));
+                       }
+                       else {
+                               DEB2(printk(KERN_DEBUG "Doing the last write\n"));
+                       }
+                       ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, (i < num-1) ? IIC_COMBINED_XFER : IIC_SINGLE_XFER);
+
+                       if (ret != pmsg->len) {
+                               DEB2(printk("i2c-algo-ppc405.o: fail: "
+                                                       "only wrote %d bytes.\n",ret));
+                               return i;
+                       }
+                       else {
+                               DEB2(printk("i2c-algo-ppc405.o: wrote %d bytes.\n",ret));
+                       }
+               }
+       }
+ 
+       return num;
+}
+
+
+//
+// Description: Whenever we initiate a transaction, the first byte clocked
+// onto the bus after the start condition is the address (7 bit) of the
+// device we want to talk to.  This function manipulates the address specified
+// so that it makes sense to the hardware when written to the IIC peripheral.
+//
+// Note: 10 bit addresses are not supported in this driver, although they are
+// supported by the hardware.  This functionality needs to be implemented.
+//
+static inline int iic_doAddress(struct i2c_algo_iic_data *adap,
+                                struct i2c_msg *msg, int retries) 
+{
+       struct iic_regs *iic;
+       unsigned short flags = msg->flags;
+       unsigned char addr;
+       struct iic_ibm *adap_priv_data = adap->data;
+       iic = (struct iic_regs *) adap_priv_data->iic_base;
+
+//
+// The following segment for 10 bit addresses needs to be ported
+//
+/* Ten bit addresses not supported right now
+       if ( (flags & I2C_M_TEN)  ) { 
+               // a ten bit address
+               addr = 0xf0 | (( msg->addr >> 7) & 0x03);
+               DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
+               // try extended address code...
+               ret = try_address(adap, addr, retries);
+               if (ret!=1) {
+                       printk(KERN_ERR "iic_doAddress: died at extended address code.\n");
+                       return -EREMOTEIO;
+               }
+               // the remaining 8 bit address
+               iic_outb(adap,msg->addr & 0x7f);
+               // Status check comes here
+               if (ret != 1) {
+                       printk(KERN_ERR "iic_doAddress: died at 2nd address code.\n");
+                       return -EREMOTEIO;
+               }
+               if ( flags & I2C_M_RD ) {
+                       i2c_repstart(adap);
+                       // okay, now switch into reading mode
+                       addr |= 0x01;
+                       ret = try_address(adap, addr, retries);
+                       if (ret!=1) {
+                               printk(KERN_ERR "iic_doAddress: died at extended address code.\n");
+                               return -EREMOTEIO;
+                       }
+               }
+       } else ----------> // normal 7 bit address
+
+Ten bit addresses not supported yet */
+
+       addr = ( msg->addr << 1 );
+       if (flags & I2C_M_RD )
+               addr |= 1;
+       if (flags & I2C_M_REV_DIR_ADDR )
+               addr ^= 1;
+       //
+       // Write to the low slave address
+       //
+       iic_outb(adap, iic->lmadr, addr);
+       //
+       // Write zero to the high slave register since we are
+       // only using 7 bit addresses
+       //
+       iic_outb(adap, iic->hmadr, 0);
+
+       return 0;
+}
+
+
+//
+// Description: Prepares the controller for a transaction (clearing status
+// registers, data buffers, etc), and then calls either iic_readbytes or
+// iic_sendbytes to do the actual transaction.
+//
+static int iic_xfer(struct i2c_adapter *i2c_adap,
+                   struct i2c_msg msgs[], 
+                   int num)
+{
+       struct iic_regs *iic;
+       struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
+       struct iic_ibm *adap_priv_data = adap->data;
+       struct i2c_msg *pmsg;
+       int i = 0;
+       int ret;
+       iic = (struct iic_regs *) adap_priv_data->iic_base;
+
+       pmsg = &msgs[i];
+
+       //
+       // Clear status register
+       //
+       DEB2(printk(KERN_DEBUG "iic_xfer: iic_xfer: Clearing status register\n"));
+       iic_outb(adap, iic->sts, 0x0a);
+
+       //
+       // Wait for any pending transfers to complete
+       //
+       DEB2(printk(KERN_DEBUG "iic_xfer: Waiting for any pending transfers to complete\n"));
+       while((ret = iic_inb(adap, iic->sts)) == 0x01) {
+               ;
+       }
+
+       //
+       // Flush master data buf
+       //
+       DEB2(printk(KERN_DEBUG "iic_xfer: Clearing master data buffer\n"));             
+       ret = iic_inb(adap, iic->mdcntl);
+       iic_outb(adap, iic->mdcntl, ret | 0x40);
+
+       //
+       // Load slave address
+       //
+       DEB2(printk(KERN_DEBUG "iic_xfer: Loading slave address\n"));
+       ret = iic_doAddress(adap, pmsg, i2c_adap->retries);
+
+        //
+        // Check to see if the bus is busy
+        //
+        ret = iic_inb(adap, iic->extsts);
+        // Mask off the irrelevent bits
+        ret = ret & 0x70;
+        // When the bus is free, the BCS bits in the EXTSTS register are 0b100
+        if(ret != 0x40) return IIC_ERR_LOST_ARB;
+
+       //
+       // Combined transaction (read and write)
+       //
+       if(num > 1) {
+           DEB2(printk(KERN_DEBUG "iic_xfer: Call combined transaction\n"));
+           ret = iic_combined_transaction(i2c_adap, msgs, num);
+        }
+       //
+       // Read only
+       //
+       else if((num == 1) && (pmsg->flags & I2C_M_RD)) {
+          //
+          // Tell device to begin reading data from the  master data 
+          //
+          DEB2(printk(KERN_DEBUG "iic_xfer: Call adapter's read\n"));
+          ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER);
+       } 
+        //
+       // Write only
+       //
+       else if((num == 1 ) && (!(pmsg->flags & I2C_M_RD))) {
+          //
+          // Write data to master data buffers and tell our device
+          // to begin transmitting
+          //
+          DEB2(printk(KERN_DEBUG "iic_xfer: Call adapter's write\n"));
+          ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER);
+       }       
+
+       return ret;   
+}
+
+
+//
+// Description: Implements device specific ioctls.  Higher level ioctls can
+// be found in i2c-core.c and are typical of any i2c controller (specifying
+// slave address, timeouts, etc).  These ioctls take advantage of any hardware
+// features built into the controller for which this algorithm-adapter set
+// was written.  These ioctls allow you to take control of the data and clock
+// lines on the IBM PPC 405 IIC controller and set the either high or low,
+// similar to a GPIO pin.
+//
+static int algo_control(struct i2c_adapter *adapter, 
+       unsigned int cmd, unsigned long arg)
+{
+       struct iic_regs *iic;
+       struct i2c_algo_iic_data *adap = adapter->algo_data;
+       struct iic_ibm *adap_priv_data = adap->data;
+       int ret=0;
+       int lines;
+       iic = (struct iic_regs *) adap_priv_data->iic_base;
+
+       lines = iic_inb(adap, iic->directcntl);
+
+       if (cmd == IICO_I2C_SDAHIGH) {
+             lines = lines & 0x01;
+             if( lines ) lines = 0x04;
+             else lines = 0;
+             iic_outb(adap, iic->directcntl,(0x08|lines));
+       }
+       else if (cmd == IICO_I2C_SDALOW) {
+             lines = lines & 0x01;
+             if( lines ) lines = 0x04;
+              else lines = 0;
+              iic_outb(adap, iic->directcntl,(0x00|lines));
+       }
+       else if (cmd == IICO_I2C_SCLHIGH) {
+              lines = lines & 0x02;
+              if( lines ) lines = 0x08;
+              else lines = 0;
+              iic_outb(adap, iic->directcntl,(0x04|lines));
+       }
+       else if (cmd == IICO_I2C_SCLLOW) {
+              lines = lines & 0x02;
+             if( lines ) lines = 0x08;
+              else lines = 0;
+              iic_outb(adap, iic->directcntl,(0x00|lines));
+       }
+       else if (cmd == IICO_I2C_LINEREAD) {
+             ret = lines;
+       }
+       return ret;
+}
+
+
+static u32 iic_func(struct i2c_adapter *adap)
+{
+       return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
+              I2C_FUNC_PROTOCOL_MANGLING; 
+}
+
+
+/* -----exported algorithm data: ------------------------------------- */
+
+static struct i2c_algorithm iic_algo = {
+       "IBM on-chip IIC algorithm",
+       I2C_ALGO_OCP,
+       iic_xfer,
+       NULL,
+       NULL,                           /* slave_xmit           */
+       NULL,                           /* slave_recv           */
+       algo_control,                   /* ioctl                */
+       iic_func,                       /* functionality        */
+};
+
+
+/* 
+ * registering functions to load algorithms at runtime 
+ */
+
+
+//
+// Description: Register bus structure
+//
+int i2c_iic_add_bus(struct i2c_adapter *adap)
+{
+       struct i2c_algo_iic_data *iic_adap = adap->algo_data;
+
+       DEB2(printk(KERN_DEBUG "i2c-algo-iic.o: hw routines for %s registered.\n",
+                   adap->name));
+
+       /* register new adapter to i2c module... */
+
+       adap->id |= iic_algo.id;
+       adap->algo = &iic_algo;
+
+       adap->timeout = 100;    /* default values, should       */
+       adap->retries = 3;              /* be replaced by defines       */
+
+#ifdef MODULE
+       MOD_INC_USE_COUNT;
+#endif
+
+       iic_init(iic_adap);
+       i2c_add_adapter(adap);
+
+       /* scan bus */
+       /* By default scanning the bus is turned off. */
+       if (iic_scan) {
+               printk(KERN_INFO " i2c-algo-iic.o: scanning bus %s.\n",
+                      adap->name);
+       }
+       return 0;
+}
+
+
+//
+// Done
+//
+int i2c_iic_del_bus(struct i2c_adapter *adap)
+{
+       int res;
+       if ((res = i2c_del_adapter(adap)) < 0)
+               return res;
+       DEB2(printk(KERN_DEBUG "i2c-algo-iic.o: adapter unregistered: %s\n",adap->name));
+
+#ifdef MODULE
+       MOD_DEC_USE_COUNT;
+#endif
+       return 0;
+}
+
+
+//
+// Done
+//
+int __init i2c_algo_iic_init (void)
+{
+       printk(KERN_INFO "IBM On-chip iic (i2c) algorithm module 2002.27.03\n");
+       return 0;
+}
+
+
+void i2c_algo_iic_exit(void)
+{
+       return;
+}
+
+
+EXPORT_SYMBOL(i2c_iic_add_bus);
+EXPORT_SYMBOL(i2c_iic_del_bus);
+
+//
+// The MODULE_* macros resolve to nothing if MODULES is not defined
+// when this file is compiled.
+//
+MODULE_AUTHOR("MontaVista Software <www.mvista.com>");
+MODULE_DESCRIPTION("PPC 405 iic algorithm");
+
+MODULE_PARM(iic_test, "i");
+MODULE_PARM(iic_scan, "i");
+MODULE_PARM(i2c_debug,"i");
+
+MODULE_PARM_DESC(iic_test, "Test if the I2C bus is available");
+MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
+MODULE_PARM_DESC(i2c_debug,
+        "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
+
+
+module_init(i2c_algo_iic_init);
+module_exit(i2c_algo_iic_exit);
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-ibm_ocp.h        2002-07-03 21:00:38.000000000 -0400
@@ -0,0 +1,55 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-algo-ibm_ocp.h i2c driver algorithms for IBM PPC 405 IIC adapters         */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 1995-97 Simon G. Vogl
+                   1998-99 Hans Berglund
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
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
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                */
+/* ------------------------------------------------------------------------- */
+
+/* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
+   Frodo Looijaard <frodol@dds.nl> */
+
+/* Modifications by MontaVista Software, August 2000
+   Changes made to support the IIC peripheral on the IBM PPC 405 */
+
+#ifndef I2C_ALGO_IIC_H
+#define I2C_ALGO_IIC_H 1
+
+/* --- Defines for pcf-adapters ---------------------------------------        */
+#include <linux/i2c.h>
+
+struct i2c_algo_iic_data {
+       struct iic_regs *data;          /* private data for lolevel routines    */
+       void (*setiic) (void *data, int ctl, int val);
+       int  (*getiic) (void *data, int ctl);
+       int  (*getown) (void *data);
+       int  (*getclock) (void *data);
+       void (*waitforpin) (void *data);     
+
+       /* local settings */
+       int udelay;
+       int mdelay;
+       int timeout;
+};
+
+
+#define I2C_IIC_ADAP_MAX       16
+
+
+int i2c_iic_add_bus(struct i2c_adapter *);
+int i2c_iic_del_bus(struct i2c_adapter *);
+
+#endif /* I2C_ALGO_IIC_H */
--- linux-2.5.26/drivers/i2c/i2c-elektor.c.orig 2002-07-05 19:42:02.000000000 -0400
+++ linux/drivers/i2c/i2c-elektor.c     2002-08-07 22:39:08.000000000 -0400
@@ -55,12 +55,9 @@
   in some functions, called from the algo-pcf module. Sometimes it's
   need to be rewriten - but for now just remove this for simpler reading */
 
-#if (LINUX_VERSION_CODE < 0x020301)
-static struct wait_queue *pcf_wait = NULL;
-#else
 static wait_queue_head_t pcf_wait;
-#endif
 static int pcf_pending;
+spinlock_t irq_driver_lock = SPIN_LOCK_UNLOCKED;
 
 /* ----- global defines -----------------------------------------------        */
 #define DEB(x) if (i2c_debug>=1) x
@@ -121,12 +118,12 @@
        int timeout = 2;
 
        if (irq > 0) {
-               cli();
+               spin_lock_irq(&irq_driver_lock);
                if (pcf_pending == 0) {
                        interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
                } else
                        pcf_pending = 0;
-               sti();
+               spin_unlock_irq(&irq_driver_lock);
        } else {
                udelay(100);
        }
@@ -280,9 +277,7 @@
                base = DEFAULT_BASE;
        }
 
-#if (LINUX_VERSION_CODE >= 0x020301)
        init_waitqueue_head(&pcf_wait);
-#endif
        if (pcf_isa_init() == 0) {
                if (i2c_pcf_add_bus(&pcf_isa_ops) < 0) {
                        pcf_isa_exit();
@@ -297,6 +292,7 @@
        return 0;
 }
 
+EXPORT_NO_SYMBOLS;
 
 #ifdef MODULE
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-frodo.c       2002-07-09 08:39:21.000000000 -0400
@@ -0,0 +1,118 @@
+
+/*
+ * linux/drivers/i2c/i2c-frodo.c
+ *
+ * Author: Abraham van der Merwe <abraham@2d3d.co.za>
+ *
+ * An I2C adapter driver for the 2d3D, Inc. StrongARM SA-1110
+ * Development board (Frodo).
+ *
+ * This source code is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+
+#include <asm/hardware.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+static void frodo_setsda (void *data,int state)
+{
+       if (state)
+               FRODO_CPLD_I2C |= FRODO_I2C_SDA_OUT;
+       else
+               FRODO_CPLD_I2C &= ~FRODO_I2C_SDA_OUT;
+}
+
+static void frodo_setscl (void *data,int state)
+{
+       if (state)
+               FRODO_CPLD_I2C |= FRODO_I2C_SCL_OUT;
+       else
+               FRODO_CPLD_I2C &= ~FRODO_I2C_SCL_OUT;
+}
+
+static int frodo_getsda (void *data)
+{
+       return ((FRODO_CPLD_I2C & FRODO_I2C_SDA_IN) != 0);
+}
+
+static int frodo_getscl (void *data)
+{
+       return ((FRODO_CPLD_I2C & FRODO_I2C_SCL_IN) != 0);
+}
+
+static struct i2c_algo_bit_data bit_frodo_data = {
+       setsda:         frodo_setsda,
+       setscl:         frodo_setscl,
+       getsda:         frodo_getsda,
+       getscl:         frodo_getscl,
+       udelay:         80,
+       mdelay:         80,
+       timeout:        100
+};
+
+static int frodo_client_register (struct i2c_client *client)
+{
+       return (0);
+}
+
+static int frodo_client_unregister (struct i2c_client *client)
+{
+       return (0);
+}
+
+static void frodo_inc_use (struct i2c_adapter *adapter)
+{
+       MOD_INC_USE_COUNT;
+}
+
+static void frodo_dec_use (struct i2c_adapter *adapter)
+{
+       MOD_DEC_USE_COUNT;
+}
+
+static struct i2c_adapter frodo_ops = {
+       name:                           "Frodo adapter driver",
+       id:                                     I2C_HW_B_FRODO,
+       algo:                           NULL,
+       algo_data:                      &bit_frodo_data,
+       inc_use:                        frodo_inc_use,
+       dec_use:                        frodo_dec_use,
+       client_register:        frodo_client_register,
+       client_unregister:      frodo_client_unregister
+};
+
+static int __init i2c_frodo_init (void)
+{
+       return (i2c_bit_add_bus (&frodo_ops));
+}
+
+EXPORT_NO_SYMBOLS;
+
+static void __exit i2c_frodo_exit (void)
+{
+       i2c_bit_del_bus (&frodo_ops);
+}
+
+MODULE_AUTHOR ("Abraham van der Merwe <abraham@2d3d.co.za>");
+MODULE_DESCRIPTION ("I2C-Bus adapter routines for Frodo");
+
+#ifdef MODULE_LICENSE
+MODULE_LICENSE ("GPL");
+#endif /* #ifdef MODULE_LICENSE */
+
+EXPORT_NO_SYMBOLS;
+
+module_init (i2c_frodo_init);
+module_exit (i2c_frodo_exit);
+
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-rpx.c 2002-06-11 22:29:54.000000000 -0400
@@ -0,0 +1,136 @@
+/*
+ * Embedded Planet RPX Lite MPC8xx CPM I2C interface.
+ * Copyright (c) 1999 Dan Malek (dmalek@jlc.net).
+ *
+ * moved into proper i2c interface;
+ * Brad Parker (brad@heeltoe.com)
+ *
+ * RPX lite specific parts of the i2c interface
+ * Update:  There actually isn't anything RPXLite-specific about this module.
+ * This should work for most any 8xx board.  The console messages have been 
+ * changed to eliminate RPXLite references.
+ */
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/stddef.h>
+#include <linux/parport.h>
+
+#include <asm/mpc8xx.h>
+#include <asm/commproc.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-8xx.h>
+
+static void
+rpx_iic_init(struct i2c_algo_8xx_data *data)
+{
+       volatile cpm8xx_t *cp;
+       volatile immap_t *immap;
+
+       cp = cpmp;      /* Get pointer to Communication Processor */
+       immap = (immap_t *)IMAP_ADDR;   /* and to internal registers */
+
+       data->iip = (iic_t *)&cp->cp_dparam[PROFF_IIC];
+
+       /* Check for and use a microcode relocation patch.
+       */
+       if ((data->reloc = data->iip->iic_rpbase))
+               data->iip = (iic_t *)&cp->cp_dpmem[data->iip->iic_rpbase];
+               
+       data->i2c = (i2c8xx_t *)&(immap->im_i2c);
+       data->cp = cp;
+
+       /* Initialize Port B IIC pins.
+       */
+       cp->cp_pbpar |= 0x00000030;
+       cp->cp_pbdir |= 0x00000030;
+       cp->cp_pbodr |= 0x00000030;
+
+       /* Allocate space for two transmit and two receive buffer
+        * descriptors in the DP ram.
+        */
+       data->dp_addr = m8xx_cpm_dpalloc(sizeof(cbd_t) * 4);
+
+       /* ptr to i2c area */
+       data->i2c = (i2c8xx_t *)&(((immap_t *)IMAP_ADDR)->im_i2c);
+}
+
+static int rpx_install_isr(int irq, void (*func)(void *, void *), void *data)
+{
+       /* install interrupt handler */
+       cpm_install_handler(irq, (void (*)(void *, struct pt_regs *)) func, data);
+
+       return 0;
+}
+
+static int rpx_reg(struct i2c_client *client)
+{
+       return 0;
+}
+
+static int rpx_unreg(struct i2c_client *client)
+{
+       return 0;
+}
+
+static void rpx_inc_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+       MOD_INC_USE_COUNT;
+#endif
+}
+
+static void rpx_dec_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+       MOD_DEC_USE_COUNT;
+#endif
+}
+
+static struct i2c_algo_8xx_data rpx_data = {
+       setisr: rpx_install_isr
+};
+
+
+static struct i2c_adapter rpx_ops = {
+       "m8xx",
+       I2C_HW_MPC8XX_EPON,
+       NULL,
+       &rpx_data,
+       rpx_inc_use,
+       rpx_dec_use,
+       rpx_reg,
+       rpx_unreg,
+};
+
+int __init i2c_rpx_init(void)
+{
+       printk("i2c-rpx.o: i2c MPC8xx module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+
+       /* reset hardware to sane state */
+       rpx_iic_init(&rpx_data);
+
+       if (i2c_8xx_add_bus(&rpx_ops) < 0) {
+               printk("i2c-rpx: Unable to register with I2C\n");
+               return -ENODEV;
+       }
+
+       return 0;
+}
+
+void __exit i2c_rpx_exit(void)
+{
+       i2c_8xx_del_bus(&rpx_ops);
+}
+
+#ifdef MODULE
+MODULE_AUTHOR("Dan Malek <dmalek@jlc.net>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for MPC8xx boards");
+
+module_init(i2c_rpx_init);
+module_exit(i2c_rpx_exit);
+#endif
+

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
