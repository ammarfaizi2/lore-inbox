Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSHGF0n>; Wed, 7 Aug 2002 01:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSHGF0m>; Wed, 7 Aug 2002 01:26:42 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:11504 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317091AbSHGFZd>; Wed, 7 Aug 2002 01:25:33 -0400
Message-ID: <3D50B01F.53D7FFF5@attbi.com>
Date: Wed, 07 Aug 2002 01:29:03 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH]2.5.30 i2c updates 3/4 
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Please apply the following four patches that update
2.5.30 with these I2C changes:
o Support for SMBus 2.0 PEC Packet Error Checking
o New algorithm-i2c-algo-8xxx for MPC8XXX
o New algorithm-i2c-algo-ibm_ocp for IBM PPC 405
o New adapter-i2c-adap-ibm_ocp for IBM PPC 405
o New adapter-i2c-frodo for SA 1110 board
o New adapter-i2c-pcf-epp for PCF8584
o New adapter-i2c-pport for parallel port
o New adapter-i2c-rpx for embeded MPC8XX
o Replace depreciated cli()&sti() with spin_{un}lock_irq()
o Updated documentation
Thanks,
Albert
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-adap-ibm_ocp.c        2002-07-03 21:00:38.000000000 -0400
@@ -0,0 +1,401 @@
+/*
+   -------------------------------------------------------------------------
+   i2c-adap-ibm_ocp.c i2c-hw access for the IIC peripheral on the IBM PPC 405
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
+   ----------------------------------------------------------------------------
+   This file was highly leveraged from i2c-elektor.c, which was created
+   by Simon G. Vogl and Hans Berglund:
+
+ 
+     Copyright (C) 1995-97 Simon G. Vogl
+                   1998-99 Hans Berglund
+
+   With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
+   Frodo Looijaard <frodol@dds.nl>
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
+   ----------------------------------------------------------------------------
+
+   History: 01/20/12 - Armin
+       akuster@mvista.com
+       ported up to 2.4.16+    
+
+   Version 02/03/25 - Armin
+       converted to ocp format
+       removed commented out or #if 0 code
+
+   TODO: convert to ocp_register
+         add PM hooks
+
+*/
+
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <linux/i2c.h>
+#include "i2c-algo-ibm_ocp.h"
+#include <linux/i2c-id.h>
+#include <asm/ocp.h>
+
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
+
+/*
+ * This next section is configurable, and it is used to set the number
+ * of i2c controllers in the system.  The default number of instances is 1,
+ * however, this should be changed to reflect your system's configuration.
+ */ 
+
+/*
+ * The STB03xxx, with a PPC405 core, has two i2c controllers.
+ */
+//(sizeof(IIC_ADDR)/sizeof(struct iic_regs))
+extern iic_t *IIC_ADDR[];
+static struct iic_ibm iic_ibmocp_adaps[IIC_NUMS][5];
+
+static struct i2c_algo_iic_data *iic_ibmocp_data[IIC_NUMS];
+static struct i2c_adapter *iic_ibmocp_ops[IIC_NUMS];
+
+static int i2c_debug=0;
+static wait_queue_head_t iic_wait[IIC_NUMS];
+static int iic_pending;
+
+
+/* ----- global defines -----------------------------------------------        */
+#define DEB(x) if (i2c_debug>=1) x
+#define DEB2(x) if (i2c_debug>=2) x
+#define DEB3(x) if (i2c_debug>=3) x
+#define DEBE(x)        x       /* error messages                               */
+
+/* ----- local functions ----------------------------------------------        */
+
+//
+// Description: Write a byte to IIC hardware
+//
+static void iic_ibmocp_setbyte(void *data, int ctl, int val)
+{
+   // writeb resolves to a write to the specified memory location
+   // plus a call to eieio.  eieio ensures that all instructions
+   // preceding it are completed before any further stores are
+   // completed.
+   // Delays at this level (to protect writes) are not needed here.
+   writeb(val, ctl);
+}
+
+
+//
+// Description: Read a byte from IIC hardware
+//
+static int iic_ibmocp_getbyte(void *data, int ctl)
+{
+   int val;
+
+   val = readb(ctl);
+   return (val);
+}
+
+
+//
+// Description: Return our slave address.  This is the address
+// put on the I2C bus when another master on the bus wants to address us
+// as a slave
+//
+static int iic_ibmocp_getown(void *data)
+{
+   return(((struct iic_ibm *)(data))->iic_own);
+}
+
+
+//
+// Description: Return the clock rate
+//
+static int iic_ibmocp_getclock(void *data)
+{
+   return(((struct iic_ibm *)(data))->iic_clock);
+}
+
+
+#if 0
+static void iic_ibmocp_sleep(unsigned long timeout)
+{
+   schedule_timeout( timeout * HZ);
+}
+#endif
+
+
+//
+// Description:  Put this process to sleep.  We will wake up when the
+// IIC controller interrupts.
+//
+static void iic_ibmocp_waitforpin(void *data) {
+
+   int timeout = 2;
+   struct iic_ibm *priv_data = data;
+   spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
+
+   //
+   // If interrupts are enabled (which they are), then put the process to
+   // sleep.  This process will be awakened by two events -- either the
+   // the IIC peripheral interrupts or the timeout expires. 
+   //
+   if (priv_data->iic_irq > 0) {
+      spin_lock_irq(&driver_lock);
+      if (iic_pending == 0) {
+        interruptible_sleep_on_timeout(&(iic_wait[priv_data->index]), timeout*HZ );
+      } else
+        iic_pending = 0;
+      spin_unlock_irq(&driver_lock);
+   } else {
+      //
+      // If interrupts are not enabled then delay for a reasonable amount
+      // of time and return.  We expect that by time we return to the calling
+      // function that the IIC has finished our requested transaction and
+      // the status bit reflects this.
+      //
+      // udelay is probably not the best choice for this since it is
+      // the equivalent of a busy wait
+      //
+      udelay(100);
+   }
+   //printk("iic_ibmocp_waitforpin: exitting\n");
+}
+
+
+//
+// Description: The registered interrupt handler
+//
+static void iic_ibmocp_handler(int this_irq, void *dev_id, struct pt_regs *regs) 
+{
+   int ret;
+   struct iic_regs *iic;
+   struct iic_ibm *priv_data = dev_id;
+   iic = (struct iic_regs *) priv_data->iic_base;
+   iic_pending = 1;
+   DEB2(printk("iic_ibmocp_handler: in interrupt handler\n"));
+   // Read status register
+   ret = readb((int) &(iic->sts));
+   DEB2(printk("iic_ibmocp_handler: status = %x\n", ret));
+   // Clear status register.  See IBM PPC 405 reference manual for details
+   writeb(0x0a, (int) &(iic->sts));
+   wake_up_interruptible(&(iic_wait[priv_data->index]));
+}
+
+
+//
+// Description: This function is very hardware dependent.  First, we lock
+// the region of memory where out registers exist.  Next, we request our
+// interrupt line and register its associated handler.  Our IIC peripheral
+// uses interrupt number 2, as specified by the 405 reference manual.
+//
+static int iic_hw_resrc_init(int instance)
+{
+
+   DEB(printk("iic_hw_resrc_init: Physical Base address: 0x%x\n", (u32) IIC_ADDR[instance] ));
+   iic_ibmocp_adaps[instance]->iic_base = (u32)ioremap((unsigned long)IIC_ADDR[instance],PAGE_SIZE);
+
+   DEB(printk("iic_hw_resrc_init: ioremapped base address: 0x%x\n", iic_ibmocp_adaps[instance]->iic_base));
+
+   if (iic_ibmocp_adaps[instance]->iic_irq > 0) {
+       
+      if (request_irq(iic_ibmocp_adaps[instance]->iic_irq, iic_ibmocp_handler,
+       0, "IBM OCP IIC", iic_ibmocp_adaps[instance]) < 0) {
+         printk(KERN_ERR "iic_hw_resrc_init: Request irq%d failed\n",
+          iic_ibmocp_adaps[instance]->iic_irq);
+        iic_ibmocp_adaps[instance]->iic_irq = 0;
+      } else {
+         DEB3(printk("iic_hw_resrc_init: Enabled interrupt\n"));
+      }
+   }
+   return 0;
+}
+
+
+//
+// Description: Release irq and memory
+//
+static void iic_ibmocp_release(void)
+{
+   int i;
+
+   for(i=0; i<IIC_NUMS; i++) {
+      struct iic_ibm *priv_data = (struct iic_ibm *)iic_ibmocp_data[i]->data;
+      if (priv_data->iic_irq > 0) {
+         disable_irq(priv_data->iic_irq);
+         free_irq(priv_data->iic_irq, 0);
+      }
+      kfree(iic_ibmocp_data[i]);
+      kfree(iic_ibmocp_ops[i]);
+   }
+}
+
+
+//
+// Description: Does nothing
+//
+static int iic_ibmocp_reg(struct i2c_client *client)
+{
+       return 0;
+}
+
+
+//
+// Description: Does nothing
+//
+static int iic_ibmocp_unreg(struct i2c_client *client)
+{
+       return 0;
+}
+
+
+//
+// Description: If this compiled as a module, then increment the count
+//
+static void iic_ibmocp_inc_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+       MOD_INC_USE_COUNT;
+#endif
+}
+
+
+//
+// Description: If this is a module, then decrement the count
+//
+static void iic_ibmocp_dec_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+       MOD_DEC_USE_COUNT;
+#endif
+}
+
+//
+// Description: Called when the module is loaded.  This function starts the
+// cascade of calls up through the heirarchy of i2c modules (i.e. up to the
+//  algorithm layer and into to the core layer)
+//
+static int __init iic_ibmocp_init(void) 
+{
+   int i;
+
+   printk(KERN_INFO "iic_ibmocp_init: IBM on-chip iic adapter module\n");
+ 
+   for(i=0; i<IIC_NUMS; i++) {
+      iic_ibmocp_data[i] = kmalloc(sizeof(struct i2c_algo_iic_data),GFP_KERNEL);
+      if(iic_ibmocp_data[i] == NULL) {
+         return -ENOMEM;
+      }
+      memset(iic_ibmocp_data[i], 0, sizeof(struct i2c_algo_iic_data));
+      
+      switch (i) {
+             case 0:
+              iic_ibmocp_adaps[i]->iic_irq = IIC_IRQ(0);
+             break;
+             case 1:
+              iic_ibmocp_adaps[i]->iic_irq = IIC_IRQ(1);
+             break;
+      }
+      iic_ibmocp_adaps[i]->iic_clock = IIC_CLOCK;
+      iic_ibmocp_adaps[i]->iic_own = IIC_OWN; 
+      iic_ibmocp_adaps[i]->index = i;
+ 
+      DEB(printk("irq %x\n", iic_ibmocp_adaps[i]->iic_irq));
+      DEB(printk("clock %x\n", iic_ibmocp_adaps[i]->iic_clock));
+      DEB(printk("own %x\n", iic_ibmocp_adaps[i]->iic_own));
+      DEB(printk("index %x\n", iic_ibmocp_adaps[i]->index));
+
+
+      iic_ibmocp_data[i]->data = (struct iic_regs *)iic_ibmocp_adaps[i]; 
+      iic_ibmocp_data[i]->setiic = iic_ibmocp_setbyte;
+      iic_ibmocp_data[i]->getiic = iic_ibmocp_getbyte;
+      iic_ibmocp_data[i]->getown = iic_ibmocp_getown;
+      iic_ibmocp_data[i]->getclock = iic_ibmocp_getclock;
+      iic_ibmocp_data[i]->waitforpin = iic_ibmocp_waitforpin;
+      iic_ibmocp_data[i]->udelay = 80;
+      iic_ibmocp_data[i]->mdelay = 80;
+      iic_ibmocp_data[i]->timeout = 100;
+      
+            iic_ibmocp_ops[i] = kmalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+      if(iic_ibmocp_ops[i] == NULL) {
+         return -ENOMEM;
+      }
+      memset(iic_ibmocp_ops[i], 0, sizeof(struct i2c_adapter));
+      strcpy(iic_ibmocp_ops[i]->name, "IBM OCP IIC adapter");
+      iic_ibmocp_ops[i]->id = I2C_HW_OCP;
+      iic_ibmocp_ops[i]->algo = NULL;
+      iic_ibmocp_ops[i]->algo_data = iic_ibmocp_data[i];
+      iic_ibmocp_ops[i]->inc_use = iic_ibmocp_inc_use;
+      iic_ibmocp_ops[i]->dec_use = iic_ibmocp_dec_use;
+      iic_ibmocp_ops[i]->client_register = iic_ibmocp_reg;
+      iic_ibmocp_ops[i]->client_unregister = iic_ibmocp_unreg;
+       
+      
+      init_waitqueue_head(&(iic_wait[i]));
+      if (iic_hw_resrc_init(i) == 0) {
+         if (i2c_iic_add_bus(iic_ibmocp_ops[i]) < 0)
+         return -ENODEV;
+      } else {
+         return -ENODEV;
+      }
+      DEB(printk(KERN_INFO "iic_ibmocp_init: found device at %#x.\n\n", iic_ibmocp_adaps[i]->iic_base));
+   }
+   return 0;
+}
+
+
+static void iic_ibmocp_exit(void)
+{
+   int i;
+
+   for(i=0; i<IIC_NUMS; i++) {
+      i2c_iic_del_bus(iic_ibmocp_ops[i]);
+   }
+   iic_ibmocp_release();
+}
+
+EXPORT_NO_SYMBOLS;
+
+//
+// If modules is NOT defined when this file is compiled, then the MODULE_*
+// macros will resolve to nothing
+//
+MODULE_AUTHOR("MontaVista Software <www.mvista.com>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for PPC 405 IIC bus adapter");
+MODULE_PARM(base, "i");
+MODULE_PARM(irq, "i");
+MODULE_PARM(clock, "i");
+MODULE_PARM(own, "i");
+MODULE_PARM(i2c_debug,"i");
+
+
+module_init(iic_ibmocp_init);
+module_exit(iic_ibmocp_exit); 
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-8xx.c    2002-06-11 22:29:54.000000000 -0400
@@ -0,0 +1,592 @@
+/*
+ * i2c-algo-8xx.c i2x driver algorithms for MPC8XX CPM
+ * Copyright (c) 1999 Dan Malek (dmalek@jlc.net).
+ *
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
+ *
+ * moved into proper i2c interface; separated out platform specific 
+ * parts into i2c-rpx.c
+ * Brad Parker (brad@heeltoe.com)
+ */
+
+// XXX todo
+// timeout sleep?
+
+/* $Id: i2c-algo-8xx.c,v 1.6 2002/06/12 02:29:54 mds Exp $ */
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
+#include <asm/mpc8xx.h>
+#include <asm/commproc.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-8xx.h>
+
+#define CPM_MAX_READ   513
+
+static wait_queue_head_t iic_wait;
+static ushort r_tbase, r_rbase;
+
+int cpm_scan = 1;
+int cpm_debug = 0;
+
+static void
+cpm_iic_interrupt(void *dev_id, void *regs)
+{
+       volatile i2c8xx_t *i2c = (i2c8xx_t *)dev_id;
+
+       if (cpm_debug > 1)
+               printk("cpm_iic_interrupt(dev_id=%p)\n", dev_id);
+
+       /* Chip errata, clear enable.
+       */
+       i2c->i2c_i2mod = 0;
+
+       /* Clear interrupt.
+       */
+       i2c->i2c_i2cer = 0xff;
+
+       /* Get 'me going again.
+       */
+       wake_up_interruptible(&iic_wait);
+}
+
+static void
+cpm_iic_init(struct i2c_algo_8xx_data *cpm_adap)
+{
+       volatile iic_t          *iip = cpm_adap->iip;
+       volatile i2c8xx_t       *i2c = cpm_adap->i2c;
+
+       if (cpm_debug) printk("cpm_iic_init() - iip=%p\n",iip);
+
+       /* Initialize the parameter ram.
+        * We need to make sure many things are initialized to zero,
+        * especially in the case of a microcode patch.
+        */
+       iip->iic_rstate = 0;
+       iip->iic_rdp = 0;
+       iip->iic_rbptr = 0;
+       iip->iic_rbc = 0;
+       iip->iic_rxtmp = 0;
+       iip->iic_tstate = 0;
+       iip->iic_tdp = 0;
+       iip->iic_tbptr = 0;
+       iip->iic_tbc = 0;
+       iip->iic_txtmp = 0;
+
+       /* Set up the IIC parameters in the parameter ram.
+       */
+       iip->iic_tbase = r_tbase = cpm_adap->dp_addr;
+       iip->iic_rbase = r_rbase = cpm_adap->dp_addr + sizeof(cbd_t)*2;
+
+       iip->iic_tfcr = SMC_EB;
+       iip->iic_rfcr = SMC_EB;
+
+       /* Set maximum receive size.
+       */
+       iip->iic_mrblr = CPM_MAX_READ;
+
+       /* Initialize Tx/Rx parameters.
+       */
+       if (cpm_adap->reloc == 0) {
+               volatile cpm8xx_t *cp = cpm_adap->cp;
+
+               cp->cp_cpcr =
+                       mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+               while (cp->cp_cpcr & CPM_CR_FLG);
+       }
+
+       /* Select an arbitrary address.  Just make sure it is unique.
+       */
+       i2c->i2c_i2add = 0x34;
+
+       /* Make clock run maximum slow.
+       */
+       i2c->i2c_i2brg = 7;
+
+       /* Disable interrupts.
+       */
+       i2c->i2c_i2cmr = 0;
+       i2c->i2c_i2cer = 0xff;
+
+       init_waitqueue_head(&iic_wait);
+
+       /* Install interrupt handler.
+       */
+       if (cpm_debug) {
+               printk ("%s[%d] Install ISR for IRQ %d\n",
+                       __func__,__LINE__, CPMVEC_I2C);
+       }
+       (*cpm_adap->setisr)(CPMVEC_I2C, cpm_iic_interrupt, (void *)i2c);
+}
+
+
+static int
+cpm_iic_shutdown(struct i2c_algo_8xx_data *cpm_adap)
+{
+       volatile i2c8xx_t *i2c = cpm_adap->i2c;
+
+       /* Shut down IIC.
+       */
+       i2c->i2c_i2mod = 0;
+       i2c->i2c_i2cmr = 0;
+       i2c->i2c_i2cer = 0xff;
+
+       return(0);
+}
+
+static void 
+cpm_reset_iic_params(volatile iic_t *iip)
+{
+       iip->iic_tbase = r_tbase;
+       iip->iic_rbase = r_rbase;
+
+       iip->iic_tfcr = SMC_EB;
+       iip->iic_rfcr = SMC_EB;
+
+       iip->iic_mrblr = CPM_MAX_READ;
+
+       iip->iic_rstate = 0;
+       iip->iic_rdp = 0;
+       iip->iic_rbptr = r_rbase;
+       iip->iic_rbc = 0;
+       iip->iic_rxtmp = 0;
+       iip->iic_tstate = 0;
+       iip->iic_tdp = 0;
+       iip->iic_tbptr = r_tbase;
+       iip->iic_tbc = 0;
+       iip->iic_txtmp = 0;
+}
+
+#define BD_SC_NAK              ((ushort)0x0004) /* NAK - did not respond */
+#define CPM_CR_CLOSE_RXBD      ((ushort)0x0007)
+
+static void force_close(struct i2c_algo_8xx_data *cpm)
+{
+       if (cpm->reloc == 0) {
+               volatile cpm8xx_t *cp = cpm->cp;
+
+               if (cpm_debug) printk("force_close()\n");
+               cp->cp_cpcr =
+                       mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |
+                       CPM_CR_FLG;
+
+               while (cp->cp_cpcr & CPM_CR_FLG);
+       }
+}
+
+
+/* Read from IIC...
+ * abyte = address byte, with r/w flag already set
+ */
+static int
+cpm_iic_read(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf, int count)
+{
+       volatile iic_t *iip = cpm->iip;
+       volatile i2c8xx_t *i2c = cpm->i2c;
+       volatile cpm8xx_t *cp = cpm->cp;
+       volatile cbd_t  *tbdf, *rbdf;
+       u_char *tb;
+       unsigned long flags;
+
+       if (count >= CPM_MAX_READ)
+               return -EINVAL;
+
+       /* check for and use a microcode relocation patch */
+       if (cpm->reloc) {
+               cpm_reset_iic_params(iip);
+       }
+
+       tbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];
+       rbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];
+
+       /* To read, we need an empty buffer of the proper length.
+        * All that is used is the first byte for address, the remainder
+        * is just used for timing (and doesn't really have to exist).
+        */
+       if (cpm->reloc) {
+               cpm_reset_iic_params(iip);
+       }
+       tb = cpm->temp;
+       tb = (u_char *)(((uint)tb + 15) & ~15);
+       tb[0] = abyte;          /* Device address byte w/rw flag */
+
+       flush_dcache_range((unsigned long) tb, (unsigned long) (tb+1));
+
+       if (cpm_debug) printk("cpm_iic_read(abyte=0x%x)\n", abyte);
+
+       tbdf->cbd_bufaddr = __pa(tb);
+       tbdf->cbd_datlen = count + 1;
+       tbdf->cbd_sc =
+               BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
+               BD_SC_WRAP | BD_IIC_START;
+
+       rbdf->cbd_datlen = 0;
+       rbdf->cbd_bufaddr = __pa(buf);
+       rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
+
+       invalidate_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
+
+       /* Chip bug, set enable here */
+       local_irq_save(flags);
+       i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
+       i2c->i2c_i2cer = 0xff;
+       i2c->i2c_i2mod = 1;     /* Enable */
+       i2c->i2c_i2com = 0x81;  /* Start master */
+
+       /* Wait for IIC transfer */
+       interruptible_sleep_on(&iic_wait);
+       local_irq_restore(flags);
+       if (signal_pending(current))
+               return -EIO;
+
+       if (cpm_debug) {
+               printk("tx sc %04x, rx sc %04x\n",
+                      tbdf->cbd_sc, rbdf->cbd_sc);
+       }
+
+       if (tbdf->cbd_sc & BD_SC_NAK) {
+               printk("IIC read; no ack\n");
+               return 0;
+       }
+
+       if (rbdf->cbd_sc & BD_SC_EMPTY) {
+               printk("IIC read; complete but rbuf empty\n");
+               force_close(cpm);
+               printk("tx sc %04x, rx sc %04x\n",
+                      tbdf->cbd_sc, rbdf->cbd_sc);
+       }
+
+       if (cpm_debug) printk("read %d bytes\n", rbdf->cbd_datlen);
+
+       if (rbdf->cbd_datlen < count) {
+               printk("IIC read; short, wanted %d got %d\n",
+                      count, rbdf->cbd_datlen);
+               return 0;
+       }
+
+
+       invalidate_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
+
+       return count;
+}
+
+/* Write to IIC...
+ * addr = address byte, with r/w flag already set
+ */
+static int
+cpm_iic_write(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf,int count)
+{
+       volatile iic_t *iip = cpm->iip;
+       volatile i2c8xx_t *i2c = cpm->i2c;
+       volatile cpm8xx_t *cp = cpm->cp;
+       volatile cbd_t  *tbdf;
+       u_char *tb;
+       unsigned long flags;
+
+       /* check for and use a microcode relocation patch */
+       if (cpm->reloc) {
+               cpm_reset_iic_params(iip);
+       }
+       tb = cpm->temp;
+       tb = (u_char *)(((uint)tb + 15) & ~15);
+       *tb = abyte;            /* Device address byte w/rw flag */
+
+       flush_dcache_range((unsigned long) tb, (unsigned long) (tb+1));
+       flush_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
+
+       if (cpm_debug) printk("cpm_iic_write(abyte=0x%x)\n", abyte);
+
+       /* set up 2 descriptors */
+       tbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];
+
+       tbdf[0].cbd_bufaddr = __pa(tb);
+       tbdf[0].cbd_datlen = 1;
+       tbdf[0].cbd_sc = BD_SC_READY | BD_IIC_START;
+
+       tbdf[1].cbd_bufaddr = __pa(buf);
+       tbdf[1].cbd_datlen = count;
+       tbdf[1].cbd_sc = BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | BD_SC_WRAP;
+
+       /* Chip bug, set enable here */
+       local_irq_save(flags);
+       i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
+       i2c->i2c_i2cer = 0xff;
+       i2c->i2c_i2mod = 1;     /* Enable */
+       i2c->i2c_i2com = 0x81;  /* Start master */
+
+       /* Wait for IIC transfer */
+       interruptible_sleep_on(&iic_wait);
+       local_irq_restore(flags);
+       if (signal_pending(current))
+               return -EIO;
+
+       if (cpm_debug) {
+               printk("tx0 sc %04x, tx1 sc %04x\n",
+                      tbdf[0].cbd_sc, tbdf[1].cbd_sc);
+       }
+
+       if (tbdf->cbd_sc & BD_SC_NAK) {
+               printk("IIC write; no ack\n");
+               return 0;
+       }
+         
+       if (tbdf->cbd_sc & BD_SC_READY) {
+               printk("IIC write; complete but tbuf ready\n");
+               return 0;
+       }
+
+       return count;
+}
+
+/* See if an IIC address exists..
+ * addr = 7 bit address, unshifted
+ */
+static int
+cpm_iic_tryaddress(struct i2c_algo_8xx_data *cpm, int addr)
+{
+       volatile iic_t *iip = cpm->iip;
+       volatile i2c8xx_t *i2c = cpm->i2c;
+       volatile cpm8xx_t *cp = cpm->cp;
+       volatile cbd_t *tbdf, *rbdf;
+       u_char *tb;
+       unsigned long flags, len;
+
+       if (cpm_debug > 1)
+               printk("cpm_iic_tryaddress(cpm=%p,addr=%d)\n", cpm, addr);
+
+       /* check for and use a microcode relocation patch */
+       if (cpm->reloc) {
+               cpm_reset_iic_params(iip);
+       }
+
+       if (cpm_debug && addr == 0) {
+               printk("iip %p, dp_addr 0x%x\n", cpm->iip, cpm->dp_addr);
+               printk("iic_tbase %d, r_tbase %d\n", iip->iic_tbase, r_tbase);
+       }
+
+       tbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];
+       rbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];
+
+       tb = cpm->temp;
+       tb = (u_char *)(((uint)tb + 15) & ~15);
+
+       /* do a simple read */
+       tb[0] = (addr << 1) | 1;        /* device address (+ read) */
+       len = 2;
+
+       flush_dcache_range((unsigned long) tb, (unsigned long) (tb+1));
+
+       tbdf->cbd_bufaddr = __pa(tb);
+       tbdf->cbd_datlen = len;
+       tbdf->cbd_sc =
+               BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
+               BD_SC_WRAP | BD_IIC_START;
+
+       rbdf->cbd_datlen = 0;
+       rbdf->cbd_bufaddr = __pa(tb+2);
+       rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
+
+       local_irq_save(flags);
+       i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
+       i2c->i2c_i2cer = 0xff;
+       i2c->i2c_i2mod = 1;     /* Enable */
+       i2c->i2c_i2com = 0x81;  /* Start master */
+
+       if (cpm_debug > 1) printk("about to sleep\n");
+
+       /* wait for IIC transfer */
+       interruptible_sleep_on(&iic_wait);
+       local_irq_restore(flags);
+       if (signal_pending(current))
+               return -EIO;
+
+       if (cpm_debug > 1) printk("back from sleep\n");
+
+       if (tbdf->cbd_sc & BD_SC_NAK) {
+               if (cpm_debug > 1) printk("IIC try; no ack\n");
+               return 0;
+       }
+         
+       if (tbdf->cbd_sc & BD_SC_READY) {
+               printk("IIC try; complete but tbuf ready\n");
+       }
+       
+       return 1;
+}
+
+static int cpm_xfer(struct i2c_adapter *i2c_adap,
+                   struct i2c_msg msgs[], 
+                   int num)
+{
+       struct i2c_algo_8xx_data *adap = i2c_adap->algo_data;
+       struct i2c_msg *pmsg;
+       int i, ret;
+       u_char addr;
+    
+       for (i = 0; i < num; i++) {
+               pmsg = &msgs[i];
+
+               if (cpm_debug)
+                       printk("i2c-algo-8xx.o: "
+                              "#%d addr=0x%x flags=0x%x len=%d\n",
+                              i, pmsg->addr, pmsg->flags, pmsg->len);
+
+               addr = pmsg->addr << 1;
+               if (pmsg->flags & I2C_M_RD )
+                       addr |= 1;
+               if (pmsg->flags & I2C_M_REV_DIR_ADDR )
+                       addr ^= 1;
+    
+               if (!(pmsg->flags & I2C_M_NOSTART)) {
+               }
+               if (pmsg->flags & I2C_M_RD ) {
+                       /* read bytes into buffer*/
+                       ret = cpm_iic_read(adap, addr, pmsg->buf, pmsg->len);
+                       if (cpm_debug)
+                               printk("i2c-algo-8xx.o: read %d bytes\n", ret);
+                       if (ret < pmsg->len ) {
+                               return (ret<0)? ret : -EREMOTEIO;
+                       }
+               } else {
+                       /* write bytes from buffer */
+                       ret = cpm_iic_write(adap, addr, pmsg->buf, pmsg->len);
+                       if (cpm_debug)
+                               printk("i2c-algo-8xx.o: wrote %d\n", ret);
+                       if (ret < pmsg->len ) {
+                               return (ret<0) ? ret : -EREMOTEIO;
+                       }
+               }
+       }
+       return (num);
+}
+
+static int algo_control(struct i2c_adapter *adapter, 
+       unsigned int cmd, unsigned long arg)
+{
+       return 0;
+}
+
+static u32 cpm_func(struct i2c_adapter *adap)
+{
+       return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
+              I2C_FUNC_PROTOCOL_MANGLING; 
+}
+
+/* -----exported algorithm data: ------------------------------------- */
+
+static struct i2c_algorithm cpm_algo = {
+       "MPC8xx CPM algorithm",
+       I2C_ALGO_MPC8XX,
+       cpm_xfer,
+       NULL,
+       NULL,                           /* slave_xmit           */
+       NULL,                           /* slave_recv           */
+       algo_control,                   /* ioctl                */
+       cpm_func,                       /* functionality        */
+};
+
+/* 
+ * registering functions to load algorithms at runtime 
+ */
+int i2c_8xx_add_bus(struct i2c_adapter *adap)
+{
+       int i;
+       struct i2c_algo_8xx_data *cpm_adap = adap->algo_data;
+
+       if (cpm_debug)
+               printk("i2c-algo-8xx.o: hw routines for %s registered.\n",
+                      adap->name);
+
+       /* register new adapter to i2c module... */
+
+       adap->id |= cpm_algo.id;
+       adap->algo = &cpm_algo;
+
+#ifdef MODULE
+       MOD_INC_USE_COUNT;
+#endif
+
+       i2c_add_adapter(adap);
+       cpm_iic_init(cpm_adap);
+
+       /* scan bus */
+       if (cpm_scan) {
+               printk(KERN_INFO " i2c-algo-8xx.o: scanning bus %s...\n",
+                      adap->name);
+               for (i = 0; i < 128; i++) {
+                       if (cpm_iic_tryaddress(cpm_adap, i)) {
+                               printk("(%02x)",i<<1); 
+                       }
+               }
+               printk("\n");
+       }
+       return 0;
+}
+
+
+int i2c_8xx_del_bus(struct i2c_adapter *adap)
+{
+       int res;
+       struct i2c_algo_8xx_data *cpm_adap = adap->algo_data;
+
+       cpm_iic_shutdown(cpm_adap);
+
+       if ((res = i2c_del_adapter(adap)) < 0)
+               return res;
+
+       printk("i2c-algo-8xx.o: adapter unregistered: %s\n",adap->name);
+
+#ifdef MODULE
+       MOD_DEC_USE_COUNT;
+#endif
+       return 0;
+}
+
+EXPORT_SYMBOL(i2c_8xx_add_bus);
+EXPORT_SYMBOL(i2c_8xx_del_bus);
+
+int __init i2c_algo_8xx_init (void)
+{
+       printk("i2c-algo-8xx.o: i2c mpc8xx algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+       return 0;
+}
+
+
+#ifdef MODULE
+MODULE_AUTHOR("Brad Parker <brad@heeltoe.com>");
+MODULE_DESCRIPTION("I2C-Bus MPC8XX algorithm");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
+
+int init_module(void) 
+{
+       return i2c_algo_8xx_init();
+}
+
+void cleanup_module(void) 
+{
+}
+#endif
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
+++ linux/drivers/i2c/i2c-elektor.c     2001-11-19 13:45:02.000000000 -0500
@@ -119,14 +119,15 @@
 static void pcf_isa_waitforpin(void) {
 
        int timeout = 2;
+       spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
 
        if (irq > 0) {
-               cli();
+               spin_lock_irq(&driver_lock);
                if (pcf_pending == 0) {
                        interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
                } else
                        pcf_pending = 0;
-               sti();
+               spin_unlock_irq(&driver_lock);
        } else {
                udelay(100);
        }
@@ -297,6 +298,7 @@
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
+++ linux/drivers/i2c/i2c-pcf-epp.c     2002-07-09 21:29:56.000000000 -0400
@@ -0,0 +1,316 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-pcf-epp.c i2c-hw access for PCF8584 style EPP parallel port adapters  */
+/* ------------------------------------------------------------------------- */
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/parport.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-pcf.h>
+#include "i2c-pcf8584.h"
+
+struct  i2c_pcf_epp {
+  int pe_base;
+  int pe_irq;
+  int pe_clock;
+  int pe_own;
+} ;
+
+#define DEFAULT_BASE 0x378
+#define DEFAULT_IRQ      7
+#define DEFAULT_CLOCK 0x1c
+#define DEFAULT_OWN   0x55
+
+static int base  = 0;
+static int irq   = 0;
+static int clock = 0;
+static int own   = 0;
+static int i2c_debug=0;
+static struct i2c_pcf_epp gpe;
+#if (LINUX_VERSION_CODE < 0x020301)
+static struct wait_queue *pcf_wait = NULL;
+#else
+static wait_queue_head_t pcf_wait;
+#endif
+static int pcf_pending;
+
+/* ----- global defines -----------------------------------------------        */
+#define DEB(x) if (i2c_debug>=1) x
+#define DEB2(x) if (i2c_debug>=2) x
+#define DEB3(x) if (i2c_debug>=3) x
+#define DEBE(x)        x       /* error messages                               */
+
+/* --- Convenience defines for the EPP/SPP port:                       */
+#define BASE   ((struct i2c_pcf_epp *)(data))->pe_base
+// #define DATA        BASE                    /* SPP data port */
+#define STAT   (BASE+1)                /* SPP status port */
+#define CTRL   (BASE+2)                /* SPP control port */
+#define EADD   (BASE+3)                /* EPP address port */
+#define EDAT   (BASE+4)                /* EPP data port */
+
+/* ----- local functions ----------------------------------------------        */
+
+static void pcf_epp_setbyte(void *data, int ctl, int val)
+{
+  if (ctl) {
+    if (gpe.pe_irq > 0) {
+      DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: Write control 0x%x\n",
+                 val|I2C_PCF_ENI));
+      // set A0 pin HIGH
+      outb(inb(CTRL) | PARPORT_CONTROL_INIT, CTRL);
+      // DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: CTRL port = 0x%x\n", inb(CTRL)));
+      // DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: STAT port = 0x%x\n", inb(STAT)));
+      
+      // EPP write data cycle
+      outb(val | I2C_PCF_ENI, EDAT);
+    } else {
+      DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: Write control 0x%x\n", val));
+      // set A0 pin HIGH
+      outb(inb(CTRL) | PARPORT_CONTROL_INIT, CTRL);
+      outb(val, CTRL);
+    }
+  } else {
+    DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: Write data 0x%x\n", val));
+    // set A0 pin LO
+    outb(inb(CTRL) & ~PARPORT_CONTROL_INIT, CTRL);
+    // DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: CTRL port = 0x%x\n", inb(CTRL)));
+    // DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: STAT port = 0x%x\n", inb(STAT)));
+    outb(val, EDAT);
+  }
+}
+
+static int pcf_epp_getbyte(void *data, int ctl)
+{
+  int val;
+
+  if (ctl) {
+    // set A0 pin HIGH
+    outb(inb(CTRL) | PARPORT_CONTROL_INIT, CTRL);
+    val = inb(EDAT);
+    DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: Read control 0x%x\n", val));
+  } else {
+    // set A0 pin LOW
+    outb(inb(CTRL) & ~PARPORT_CONTROL_INIT, CTRL);
+    val = inb(EDAT);
+    DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: Read data 0x%x\n", val));
+  }
+  return (val);
+}
+
+static int pcf_epp_getown(void *data)
+{
+  return (gpe.pe_own);
+}
+
+
+static int pcf_epp_getclock(void *data)
+{
+  return (gpe.pe_clock);
+}
+
+#if 0
+static void pcf_epp_sleep(unsigned long timeout)
+{
+  schedule_timeout( timeout * HZ);
+}
+#endif
+
+static void pcf_epp_waitforpin(void) {
+  int timeout = 10;
+  spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
+
+  if (gpe.pe_irq > 0) {
+    spin_lock_irq(&driver_lock);
+    if (pcf_pending == 0) {
+      interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ);
+      //udelay(100);
+    } else {
+      pcf_pending = 0;
+    }
+    spin_unlock_irq(&driver_lock);
+  } else {
+    udelay(100);
+  }
+}
+
+static void pcf_epp_handler(int this_irq, void *dev_id, struct pt_regs *regs) {
+  pcf_pending = 1;
+  wake_up_interruptible(&pcf_wait);
+  DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: in interrupt handler.\n"));
+}
+
+
+static int pcf_epp_init(void *data)
+{
+  if (check_region(gpe.pe_base, 5) < 0 ) {
+    
+    printk(KERN_WARNING "Could not request port region with base 0x%x\n", gpe.pe_base);
+    return -ENODEV;
+  } else {
+    request_region(gpe.pe_base, 5, "i2c (EPP parallel port adapter)");
+  }
+
+  DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: init status port = 0x%x\n", inb(0x379)));
+  
+  if (gpe.pe_irq > 0) {
+    if (request_irq(gpe.pe_irq, pcf_epp_handler, 0, "PCF8584", 0) < 0) {
+      printk(KERN_NOTICE "i2c-pcf-epp.o: Request irq%d failed\n", gpe.pe_irq);
+      gpe.pe_irq = 0;
+    } else
+      disable_irq(gpe.pe_irq);
+      enable_irq(gpe.pe_irq);
+  }
+  // EPP mode initialize
+  // enable interrupt from nINTR pin
+  outb(inb(CTRL)|0x14, CTRL);
+  // clear ERROR bit of STAT
+  outb(inb(STAT)|0x01, STAT);
+  outb(inb(STAT)&~0x01,STAT);
+  
+  return 0;
+}
+
+
+static void pcf_epp_exit(void)
+{
+  if (gpe.pe_irq > 0) {
+    disable_irq(gpe.pe_irq);
+    free_irq(gpe.pe_irq, 0);
+  }
+  release_region(gpe.pe_base , 5);
+}
+
+
+static int pcf_epp_reg(struct i2c_client *client)
+{
+  return 0;
+}
+
+
+static int pcf_epp_unreg(struct i2c_client *client)
+{
+  return 0;
+}
+
+static void pcf_epp_inc_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+  MOD_INC_USE_COUNT;
+#endif
+}
+
+static void pcf_epp_dec_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+  MOD_DEC_USE_COUNT;
+#endif
+}
+
+
+/* ------------------------------------------------------------------------
+ * Encapsulate the above functions in the correct operations structure.
+ * This is only done when more than one hardware adapter is supported.
+ */
+static struct i2c_algo_pcf_data pcf_epp_data = {
+  NULL,
+  pcf_epp_setbyte,
+  pcf_epp_getbyte,
+  pcf_epp_getown,
+  pcf_epp_getclock,
+  pcf_epp_waitforpin,
+  80, 80, 100,         /*      waits, timeout */
+};
+
+static struct i2c_adapter pcf_epp_ops = {
+  "PCF8584 EPP adapter",
+  I2C_HW_P_LP,
+  NULL,
+  &pcf_epp_data,
+  pcf_epp_inc_use,
+  pcf_epp_dec_use,
+  pcf_epp_reg,
+  pcf_epp_unreg,
+};
+
+int __init i2c_pcfepp_init(void) 
+{
+  struct i2c_pcf_epp *pepp = &gpe;
+
+  printk(KERN_DEBUG "i2c-pcf-epp.o: i2c pcf8584-epp adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+  if (base == 0)
+    pepp->pe_base = DEFAULT_BASE;
+  else
+    pepp->pe_base = base;
+
+  if (irq == 0)
+    pepp->pe_irq = DEFAULT_IRQ;
+  else if (irq<0) {
+    // switch off irq
+    pepp->pe_irq=0;
+  } else {
+    pepp->pe_irq = irq;
+  }
+  if (clock == 0)
+    pepp->pe_clock = DEFAULT_CLOCK;
+  else
+    pepp->pe_clock = clock;
+
+  if (own == 0)
+    pepp->pe_own = DEFAULT_OWN;
+  else
+    pepp->pe_own = own;
+
+  pcf_epp_data.data = (void *)pepp;
+#if (LINUX_VERSION_CODE >= 0x020301)
+  init_waitqueue_head(&pcf_wait);
+#endif
+  if (pcf_epp_init(pepp) == 0) {
+    int ret;
+    if ( (ret = i2c_pcf_add_bus(&pcf_epp_ops)) < 0) {
+      printk(KERN_WARNING "i2c_pcf_add_bus caused an error: %d\n",ret);
+      release_region(pepp->pe_base , 5);
+      return ret;
+    }
+  } else {
+    
+    return -ENODEV;
+  }
+  printk(KERN_DEBUG "i2c-pcf-epp.o: found device at %#x.\n", pepp->pe_base);
+  return 0;
+}
+
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+MODULE_AUTHOR("Hans Berglund <hb@spacetec.no> \n modified by Ryosuke Tajima <rosk@jsk.t.u-tokyo.ac.jp>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 EPP parallel port adapter");
+
+MODULE_PARM(base, "i");
+MODULE_PARM(irq, "i");
+MODULE_PARM(clock, "i");
+MODULE_PARM(own, "i");
+MODULE_PARM(i2c_debug, "i");
+
+int init_module(void) 
+{
+  return i2c_pcfepp_init();
+}
+
+void cleanup_module(void) 
+{
+  i2c_pcf_del_bus(&pcf_epp_ops);
+  pcf_epp_exit();
+}
+
+#endif
+
+
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-pport.c       2001-10-13 14:09:01.000000000 -0400
@@ -0,0 +1,254 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-pport.c i2c-hw access  for primitive i2c par. port adapter           */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 2001    Daniel Smolik
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
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.               */
+/* ------------------------------------------------------------------------- */
+
+/*
+       See doc/i2c-pport for instructions on wiring to the
+       parallel port connector.
+
+       Cut & paste :-)  based on Velleman K9000 driver by Simon G. Vogl
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
+#include <asm/io.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
+
+#define DEFAULT_BASE 0x378
+static int base=0;
+static unsigned char PortData = 0;
+
+/* ----- global defines -----------------------------------------------        */
+#define DEB(x)         /* should be reasonable open, close &c.         */
+#define DEB2(x)        /* low level debugging - very slow              */
+#define DEBE(x)        x       /* error messages                               */
+#define DEBINIT(x) x   /* detection status messages                    */
+
+/* --- Convenience defines for the parallel port:                      */
+#define BASE   (unsigned int)(data)
+#define DATA   BASE                    /* Centronics data port         */
+#define STAT   (BASE+1)                /* Centronics status port       */
+#define CTRL   (BASE+2)                /* Centronics control port      */
+
+/* we will use SDA  - Auto Linefeed(14)   bit 1  POUT   */
+/* we will use SCL - Initialize printer(16)    BUSY bit 2*/
+
+#define  SET_SCL    | 0x04
+#define  CLR_SCL    & 0xFB
+
+
+
+
+#define  SET_SDA    & 0x04
+#define  CLR_SDA    | 0x02
+
+
+/* ----- local functions ----------------------------------------------        */
+
+
+static void bit_pport_setscl(void *data, int state)
+{
+       if (state) {
+               //high
+               PortData = PortData SET_SCL;
+       } else {
+               //low
+               PortData = PortData CLR_SCL; 
+       }
+       outb(PortData, CTRL);
+}
+
+static void bit_pport_setsda(void *data, int state)
+{
+       if (state) {
+               
+               PortData = PortData SET_SDA;
+       } else {
+
+               PortData = PortData CLR_SDA;
+       }
+       outb(PortData, CTRL);
+} 
+
+static int bit_pport_getscl(void *data)
+{
+
+       return ( 4 == ( (inb_p(CTRL)) & 0x04 ) );
+}
+
+static int bit_pport_getsda(void *data)
+{
+       return ( 0 == ( (inb_p(CTRL)) & 0x02 ) );
+}
+
+static int bit_pport_init(void)
+{
+       //release_region( (base+2) ,1);
+
+       if (check_region((base+2),1) < 0 ) {
+               return -ENODEV; 
+       } else {
+
+               /* test for PPORT adap.         */
+       
+
+               PortData=inb(base+2);
+               PortData= (PortData SET_SDA) SET_SCL;
+               outb(PortData,base+2);                          
+
+               if (!(inb(base+2) | 0x06)) {    /* SDA and SCL will be high     */
+                       DEBINIT(printk("i2c-pport.o: SDA and SCL was low.\n"));
+                       return -ENODEV;
+               } else {
+               
+                       /*SCL high and SDA low*/
+                       PortData = PortData SET_SCL CLR_SDA;
+                       outb(PortData,base+2);  
+                       udelay(400);
+                       if ( !(inb(base+2) | 0x4) ) {
+                               //outb(0x04,base+2);
+                               DEBINIT(printk("i2c-port.o: SDA was high.\n"));
+                               return -ENODEV;
+                       }
+               }
+               request_region((base+2),1,
+                       "i2c (PPORT adapter)");
+               bit_pport_setsda((void*)base,1);
+               bit_pport_setscl((void*)base,1);
+       }
+       return 0;
+}
+
+static void bit_pport_exit(void)
+{
+       release_region((base+2),1);
+}
+
+static int bit_pport_reg(struct i2c_client *client)
+{
+       return 0;
+}
+
+static int bit_pport_unreg(struct i2c_client *client)
+{
+       release_region((base+2),1);
+       return 0;
+}
+
+static void bit_pport_inc_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+       MOD_INC_USE_COUNT;
+#endif
+}
+
+static void bit_pport_dec_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+       MOD_DEC_USE_COUNT;
+#endif
+}
+
+/* ------------------------------------------------------------------------
+ * Encapsulate the above functions in the correct operations structure.
+ * This is only done when more than one hardware adapter is supported.
+ */
+static struct i2c_algo_bit_data bit_pport_data = {
+       NULL,
+       bit_pport_setsda,
+       bit_pport_setscl,
+       bit_pport_getsda,
+       bit_pport_getscl,
+       //NULL,
+       40, 80, 100,            /*      waits, timeout */
+};
+
+static struct i2c_adapter bit_pport_ops = {
+       "Primitive Parallel port adaptor",
+       I2C_HW_B_PPORT,
+       NULL,
+       &bit_pport_data,
+       bit_pport_inc_use,
+       bit_pport_dec_use,
+       bit_pport_reg,
+       bit_pport_unreg,        
+};
+
+static int __init i2c_bitpport_init(void)
+{
+       printk("i2c-pport.o: i2c Primitive parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+
+       if (base==0) {
+               /* probe some values */
+               base=DEFAULT_BASE;
+               bit_pport_data.data=(void*)DEFAULT_BASE;
+               if (bit_pport_init()==0) {
+                       if(i2c_bit_add_bus(&bit_pport_ops) < 0)
+                               return -ENODEV;
+               } else {
+                       return -ENODEV;
+               }
+       } else {
+               bit_pport_data.data=(void*)base;
+               if (bit_pport_init()==0) {
+                       if(i2c_bit_add_bus(&bit_pport_ops) < 0)
+                               return -ENODEV;
+               } else {
+                       return -ENODEV;
+               }
+       }
+       printk("i2c-pport.o: found device at %#x.\n",base);
+       return 0;
+}
+
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+MODULE_AUTHOR("Daniel Smolik <marvin@sitour.cz>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for Primitive parallel port adapter")
+;
+
+MODULE_PARM(base, "i");
+
+int init_module(void)
+{
+       return i2c_bitpport_init();
+}
+
+void cleanup_module(void)
+{
+       i2c_bit_del_bus(&bit_pport_ops);
+       bit_pport_exit();
+}
+
+#endif
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
