Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318939AbSHMFqz>; Tue, 13 Aug 2002 01:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318944AbSHMFqz>; Tue, 13 Aug 2002 01:46:55 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:51099 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318939AbSHMFp5>; Tue, 13 Aug 2002 01:45:57 -0400
Message-ID: <3D589DF2.EC3C5917@attbi.com>
Date: Tue, 13 Aug 2002 01:49:38 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 3/4] 2.4.20-pre2 i2c updates
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,
Please apply the following four tested patches that update
2.4.20-pre2 with these I2C changes:
o Support for SMBus 2.0 PEC Packet Error Checking
o New adapter-i2c-frodo for SA 1110 board
o New adapter-i2c-rpx for embeded MPC8XX
o Remove compat code for < 2.4
o Replace cli()&sti() with spin_{un}lock_irq()
o Updated documentation
Thanks,
Albert
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-8xx.c    2002-07-23 08:52:47.000000000 -0400
@@ -0,0 +1,589 @@
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
+MODULE_LICENSE("GPL");
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
--- linux/drivers/i2c/i2c-algo-bit.c.orig       2002-07-23 01:43:58.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-bit.c    2002-07-23 08:37:26.000000000 -0400
@@ -21,7 +21,7 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.c,v 1.30 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-algo-bit.c,v 1.37 2002/07/08 00:41:49 mds Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -32,8 +32,6 @@
 #include <asm/uaccess.h>
 #include <linux/ioport.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
@@ -123,7 +121,7 @@
                if (current->need_resched)
                        schedule();
        }
-       DEBSTAT(printk("needed %ld jiffies\n", jiffies-start));
+       DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
 #ifdef SLO_IO
        SLO_IO
 #endif
@@ -145,7 +143,7 @@
        /* scl, sda may not be high */
        DEBPROTO(printk(" Sr "));
        setsda(adap,1);
-       setscl(adap,1);
+       sclhi(adap);
        udelay(adap->udelay);
        
        sdalo(adap);
@@ -179,12 +177,12 @@
        struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
        /* assert: scl is low */
-       DEB2(printk(" i2c_outb:%2.2X\n",c&0xff));
+       DEB2(printk(KERN_DEBUG " i2c_outb:%2.2X\n",c&0xff));
        for ( i=7 ; i>=0 ; i-- ) {
                sb = c & ( 1 << i );
                setsda(adap,sb);
                udelay(adap->udelay);
-               DEBPROTO(printk("%d",sb!=0));
+               DEBPROTO(printk(KERN_DEBUG "%d",sb!=0));
                if (sclhi(adap)<0) { /* timed out */
                        sdahi(adap); /* we don't want to block the net */
                        return -ETIMEDOUT;
@@ -201,10 +199,10 @@
        };
        /* read ack: SDA should be pulled down by slave */
        ack=getsda(adap);       /* ack: sda is pulled low ->success.     */
-       DEB2(printk(" i2c_outb: getsda() =  0x%2.2x\n", ~ack ));
+       DEB2(printk(KERN_DEBUG " i2c_outb: getsda() =  0x%2.2x\n", ~ack ));
 
-       DEBPROTO( printk("[%2.2x]",c&0xff) );
-       DEBPROTO(if (0==ack){ printk(" A ");} else printk(" NA ") );
+       DEBPROTO( printk(KERN_DEBUG "[%2.2x]",c&0xff) );
+       DEBPROTO(if (0==ack){ printk(KERN_DEBUG " A ");} else printk(KERN_DEBUG " NA ") );
        scllo(adap);
        return 0==ack;          /* return 1 if device acked      */
        /* assert: scl is low (sda undef) */
@@ -220,7 +218,7 @@
        struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
        /* assert: scl is low */
-       DEB2(printk("i2c_inb.\n"));
+       DEB2(printk(KERN_DEBUG "i2c_inb.\n"));
 
        sdahi(adap);
        for (i=0;i<8;i++) {
@@ -233,7 +231,7 @@
                scllo(adap);
        }
        /* assert: scl is low */
-       DEBPROTO(printk(" %2.2x", indata & 0xff));
+       DEBPROTO(printk(KERN_DEBUG " %2.2x", indata & 0xff));
        return (int) (indata & 0xff);
 }
 
@@ -245,69 +243,69 @@
        int scl,sda;
        sda=getsda(adap);
        if (adap->getscl==NULL) {
-               printk("i2c-algo-bit.o: Warning: Adapter can't read from clock line - skipping test.\n");
+               printk(KERN_WARNING "i2c-algo-bit.o: Warning: Adapter can't read from clock line - skipping test.\n");
                return 0;               
        }
        scl=getscl(adap);
-       printk("i2c-algo-bit.o: Adapter: %s scl: %d  sda: %d -- testing...\n",
+       printk(KERN_INFO "i2c-algo-bit.o: Adapter: %s scl: %d  sda: %d -- testing...\n",
               name,getscl(adap),getsda(adap));
        if (!scl || !sda ) {
-               printk("i2c-algo-bit.o: %s seems to be busy.\n",name);
+               printk(KERN_INFO " i2c-algo-bit.o: %s seems to be busy.\n",name);
                goto bailout;
        }
        sdalo(adap);
-       printk("i2c-algo-bit.o:1 scl: %d  sda: %d \n",getscl(adap),
+       printk(KERN_DEBUG "i2c-algo-bit.o:1 scl: %d  sda: %d \n",getscl(adap),
               getsda(adap));
        if ( 0 != getsda(adap) ) {
-               printk("i2c-algo-bit.o: %s SDA stuck high!\n",name);
+               printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck high!\n",name);
                sdahi(adap);
                goto bailout;
        }
        if ( 0 == getscl(adap) ) {
-               printk("i2c-algo-bit.o: %s SCL unexpected low while pulling SDA low!\n",
+               printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while pulling SDA low!\n",
                        name);
                goto bailout;
        }               
        sdahi(adap);
-       printk("i2c-algo-bit.o:2 scl: %d  sda: %d \n",getscl(adap),
+       printk(KERN_DEBUG "i2c-algo-bit.o:2 scl: %d  sda: %d \n",getscl(adap),
               getsda(adap));
        if ( 0 == getsda(adap) ) {
-               printk("i2c-algo-bit.o: %s SDA stuck low!\n",name);
+               printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck low!\n",name);
                sdahi(adap);
                goto bailout;
        }
        if ( 0 == getscl(adap) ) {
-               printk("i2c-algo-bit.o: %s SCL unexpected low while SDA high!\n",
+               printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while SDA high!\n",
                       name);
        goto bailout;
        }
        scllo(adap);
-       printk("i2c-algo-bit.o:3 scl: %d  sda: %d \n",getscl(adap),
+       printk(KERN_DEBUG "i2c-algo-bit.o:3 scl: %d  sda: %d \n",getscl(adap),
               getsda(adap));
        if ( 0 != getscl(adap) ) {
-               printk("i2c-algo-bit.o: %s SCL stuck high!\n",name);
+               printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck high!\n",name);
                sclhi(adap);
                goto bailout;
        }
        if ( 0 == getsda(adap) ) {
-               printk("i2c-algo-bit.o: %s SDA unexpected low while pulling SCL low!\n",
+               printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while pulling SCL low!\n",
                        name);
                goto bailout;
        }
        sclhi(adap);
-       printk("i2c-algo-bit.o:4 scl: %d  sda: %d \n",getscl(adap),
+       printk(KERN_DEBUG "i2c-algo-bit.o:4 scl: %d  sda: %d \n",getscl(adap),
               getsda(adap));
        if ( 0 == getscl(adap) ) {
-               printk("i2c-algo-bit.o: %s SCL stuck low!\n",name);
+               printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck low!\n",name);
                sclhi(adap);
                goto bailout;
        }
        if ( 0 == getsda(adap) ) {
-               printk("i2c-algo-bit.o: %s SDA unexpected low while SCL high!\n",
+               printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while SCL high!\n",
                        name);
                goto bailout;
        }
-       printk("i2c-algo-bit.o: %s passed test.\n",name);
+       printk(KERN_INFO "i2c-algo-bit.o: %s passed test.\n",name);
        return 0;
 bailout:
        sdahi(adap);
@@ -341,7 +339,7 @@
                i2c_start(adap);
                udelay(adap->udelay);
        }
-       DEB2(if (i) printk("i2c-algo-bit.o: needed %d retries for %d\n",
+       DEB2(if (i) printk(KERN_DEBUG "i2c-algo-bit.o: needed %d retries for %d\n",
                           i,addr));
        return ret;
 }
@@ -356,7 +354,7 @@
 
        while (count > 0) {
                c = *temp;
-               DEB2(printk("i2c-algo-bit.o: %s i2c_write: writing %2.2X\n",
+               DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: %s i2c_write: writing %2.2X\n",
                            i2c_adap->name, c&0xff));
                retval = i2c_outb(i2c_adap,c);
                if (retval>0) {
@@ -364,7 +362,7 @@
                        temp++;
                        wrcount++;
                } else { /* arbitration or no acknowledge */
-                       printk("i2c-algo-bit.o: %s i2c_write: error - bailout.\n",
+                       printk(KERN_ERR "i2c-algo-bit.o: %s i2c_write: error - bailout.\n",
                               i2c_adap->name);
                        i2c_stop(adap);
                        return (retval<0)? retval : -EFAULT;
@@ -392,7 +390,7 @@
                        *temp = inval;
                        rdcount++;
                } else {   /* read timed out */
-                       printk("i2c-algo-bit.o: i2c_read: i2c_inb timed out.\n");
+                       printk(KERN_ERR "i2c-algo-bit.o: i2c_read: i2c_inb timed out.\n");
                        break;
                }
 
@@ -405,7 +403,7 @@
                }
                if (sclhi(adap)<0) {    /* timeout */
                        sdahi(adap);
-                       printk("i2c-algo-bit.o: i2c_read: Timeout at ack\n");
+                       printk(KERN_ERR "i2c-algo-bit.o: i2c_read: Timeout at ack\n");
                        return -ETIMEDOUT;
                };
                scllo(adap);
@@ -435,18 +433,18 @@
        if ( (flags & I2C_M_TEN)  ) { 
                /* a ten bit address */
                addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-               DEB2(printk("addr0: %d\n",addr));
+               DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
                /* try extended address code...*/
                ret = try_address(i2c_adap, addr, retries);
                if (ret!=1) {
-                       printk("died at extended address code.\n");
+                       printk(KERN_ERR "died at extended address code.\n");
                        return -EREMOTEIO;
                }
                /* the remaining 8 bit address */
                ret = i2c_outb(i2c_adap,msg->addr & 0x7f);
                if (ret != 1) {
                        /* the chip did not ack / xmission error occurred */
-                       printk("died at 2nd address code.\n");
+                       printk(KERN_ERR "died at 2nd address code.\n");
                        return -EREMOTEIO;
                }
                if ( flags & I2C_M_RD ) {
@@ -455,7 +453,7 @@
                        addr |= 0x01;
                        ret = try_address(i2c_adap, addr, retries);
                        if (ret!=1) {
-                               printk("died at extended address code.\n");
+                               printk(KERN_ERR "died at extended address code.\n");
                                return -EREMOTEIO;
                        }
                }
@@ -490,7 +488,7 @@
                        }
                        ret = bit_doAddress(i2c_adap,pmsg,i2c_adap->retries);
                        if (ret != 0) {
-                               DEB2(printk("i2c-algo-bit.o: NAK from device adr %#2x msg #%d\n"
+                               DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: NAK from device adr %#2x msg #%d\n"
                                       ,msgs[i].addr,i));
                                return (ret<0) ? ret : -EREMOTEIO;
                        }
@@ -498,14 +496,14 @@
                if (pmsg->flags & I2C_M_RD ) {
                        /* read bytes into buffer*/
                        ret = readbytes(i2c_adap,pmsg->buf,pmsg->len);
-                       DEB2(printk("i2c-algo-bit.o: read %d bytes.\n",ret));
+                       DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: read %d bytes.\n",ret));
                        if (ret < pmsg->len ) {
                                return (ret<0)? ret : -EREMOTEIO;
                        }
                } else {
                        /* write bytes from buffer */
                        ret = sendbytes(i2c_adap,pmsg->buf,pmsg->len);
-                       DEB2(printk("i2c-algo-bit.o: wrote %d bytes.\n",ret));
+                       DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: wrote %d bytes.\n",ret));
                        if (ret < pmsg->len ) {
                                return (ret<0) ? ret : -EREMOTEIO;
                        }
@@ -555,7 +553,7 @@
                        return -ENODEV;
        }
 
-       DEB2(printk("i2c-algo-bit.o: hw routines for %s registered.\n",
+       DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: hw routines for %s registered.\n",
                    adap->name));
 
        /* register new adapter to i2c module... */
@@ -599,7 +597,7 @@
        if ((res = i2c_del_adapter(adap)) < 0)
                return res;
 
-       DEB2(printk("i2c-algo-bit.o: adapter unregistered: %s\n",adap->name));
+       DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: adapter unregistered: %s\n",adap->name));
 
 #ifdef MODULE
        MOD_DEC_USE_COUNT;
@@ -609,7 +607,7 @@
 
 int __init i2c_algo_bit_init (void)
 {
-       printk("i2c-algo-bit.o: i2c bit algorithm module\n");
+       printk(KERN_INFO "i2c-algo-bit.o: i2c bit algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
        return 0;
 }
 
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-ibm_ocp.c        2002-07-23 08:53:14.000000000 -0400
@@ -0,0 +1,963 @@
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
+
+#include <linux/i2c.h>
+#include "i2c-algo-ibm_ocp.h"
+#include <asm/ocp.h>
+
+MODULE_LICENSE("GPL");
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
+++ linux/drivers/i2c/i2c-algo-ibm_ocp.h        2002-07-23 01:45:46.000000000 -0400
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
--- linux/drivers/i2c/i2c-algo-pcf.c.orig       2001-10-11 11:05:47.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-pcf.c    2002-07-23 08:54:31.000000000 -0400
@@ -36,8 +36,6 @@
 #include <asm/uaccess.h>
 #include <linux/ioport.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
 #include "i2c-pcf8584.h"
@@ -99,7 +97,7 @@
        }
 #endif
        if (timeout <= 0) {
-               printk("Timeout waiting for Bus Busy\n");
+               printk(KERN_ERR "Timeout waiting for Bus Busy\n");
        }
        
        return (timeout<=0);
@@ -144,15 +142,14 @@
 {
        unsigned char temp;
 
-       DEB3(printk("i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(adap, 1)));
+       DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(adap, 1)));
 
        /* S1=0x80: S0 selected, serial interface off */
        set_pcf(adap, 1, I2C_PCF_PIN);
        /* check to see S1 now used as R/W ctrl -
           PCF8584 does that when ESO is zero */
-       /* PCF also resets PIN bit */
-       if ((temp = get_pcf(adap, 1)) != (0)) {
-               DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
+       if (((temp = get_pcf(adap, 1)) & 0x7f) != (0)) {
+               DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
                return -ENXIO; /* definetly not PCF8584 */
        }
 
@@ -160,15 +157,15 @@
        i2c_outb(adap, get_own(adap));
        /* check it's realy writen */
        if ((temp = i2c_inb(adap)) != get_own(adap)) {
-               DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
+               DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
                return -ENXIO;
        }
 
        /* S1=0xA0, next byte in S2                                     */
        set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
        /* check to see S2 now selected */
-       if ((temp = get_pcf(adap, 1)) != I2C_PCF_ES1) {
-               DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
+       if (((temp = get_pcf(adap, 1)) & 0x7f) != I2C_PCF_ES1) {
+               DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
                return -ENXIO;
        }
 
@@ -176,7 +173,7 @@
        i2c_outb(adap, get_clock(adap));
        /* check it's realy writen, the only 5 lowest bits does matter */
        if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
-               DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
+               DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
                return -ENXIO;
        }
 
@@ -185,11 +182,11 @@
 
        /* check to see PCF is realy idled and we can access status register */
        if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
-               DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
+               DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
                return -ENXIO;
        }
        
-       printk("i2c-algo-pcf.o: deteted and initialized PCF8584.\n");
+       printk(KERN_DEBUG "i2c-algo-pcf.o: deteted and initialized PCF8584.\n");
 
        return 0;
 }
@@ -215,7 +212,7 @@
                i2c_stop(adap);
                udelay(adap->udelay);
        }
-       DEB2(if (i) printk("i2c-algo-pcf.o: needed %d retries for %d\n",i,
+       DEB2(if (i) printk(KERN_DEBUG "i2c-algo-pcf.o: needed %d retries for %d\n",i,
                           addr));
        return ret;
 }
@@ -228,20 +225,20 @@
        int wrcount, status, timeout;
     
        for (wrcount=0; wrcount<count; ++wrcount) {
-               DEB2(printk("i2c-algo-pcf.o: %s i2c_write: writing %2.2X\n",
+               DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: %s i2c_write: writing %2.2X\n",
                      i2c_adap->name, buf[wrcount]&0xff));
                i2c_outb(adap, buf[wrcount]);
                timeout = wait_for_pin(adap, &status);
                if (timeout) {
                        i2c_stop(adap);
-                       printk("i2c-algo-pcf.o: %s i2c_write: "
+                       printk(KERN_ERR "i2c-algo-pcf.o: %s i2c_write: "
                               "error - timeout.\n", i2c_adap->name);
                        return -EREMOTEIO; /* got a better one ?? */
                }
 #ifndef STUB_I2C
                if (status & I2C_PCF_LRB) {
                        i2c_stop(adap);
-                       printk("i2c-algo-pcf.o: %s i2c_write: "
+                       printk(KERN_ERR "i2c-algo-pcf.o: %s i2c_write: "
                               "error - no ack.\n", i2c_adap->name);
                        return -EREMOTEIO; /* got a better one ?? */
                }
@@ -269,14 +266,14 @@
 
                if (wait_for_pin(adap, &status)) {
                        i2c_stop(adap);
-                       printk("i2c-algo-pcf.o: pcf_readbytes timed out.\n");
+                       printk(KERN_ERR "i2c-algo-pcf.o: pcf_readbytes timed out.\n");
                        return (-1);
                }
 
 #ifndef STUB_I2C
                if ((status & I2C_PCF_LRB) && (i != count)) {
                        i2c_stop(adap);
-                       printk("i2c-algo-pcf.o: i2c_read: i2c_inb, No ack.\n");
+                       printk(KERN_ERR "i2c-algo-pcf.o: i2c_read: i2c_inb, No ack.\n");
                        return (-1);
                }
 #endif
@@ -312,18 +309,18 @@
        if ( (flags & I2C_M_TEN)  ) { 
                /* a ten bit address */
                addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-               DEB2(printk("addr0: %d\n",addr));
+               DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
                /* try extended address code...*/
                ret = try_address(adap, addr, retries);
                if (ret!=1) {
-                       printk("died at extended address code.\n");
+                       printk(KERN_ERR "died at extended address code.\n");
                        return -EREMOTEIO;
                }
                /* the remaining 8 bit address */
                i2c_outb(adap,msg->addr & 0x7f);
 /* Status check comes here */
                if (ret != 1) {
-                       printk("died at 2nd address code.\n");
+                       printk(KERN_ERR "died at 2nd address code.\n");
                        return -EREMOTEIO;
                }
                if ( flags & I2C_M_RD ) {
@@ -332,7 +329,7 @@
                        addr |= 0x01;
                        ret = try_address(adap, addr, retries);
                        if (ret!=1) {
-                               printk("died at extended address code.\n");
+                               printk(KERN_ERR "died at extended address code.\n");
                                return -EREMOTEIO;
                        }
                }
@@ -360,7 +357,7 @@
        /* Check for bus busy */
        timeout = wait_for_bb(adap);
        if (timeout) {
-               DEB2(printk("i2c-algo-pcf.o: "
+               DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
                            "Timeout waiting for BB in pcf_xfer\n");)
                return -EIO;
        }
@@ -368,7 +365,7 @@
        for (i = 0;ret >= 0 && i < num; i++) {
                pmsg = &msgs[i];
 
-               DEB2(printk("i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
+               DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
                     pmsg->flags & I2C_M_RD ? "read" : "write",
                      pmsg->len, pmsg->addr, i + 1, num);)
     
@@ -383,7 +380,7 @@
                timeout = wait_for_pin(adap, &status);
                if (timeout) {
                        i2c_stop(adap);
-                       DEB2(printk("i2c-algo-pcf.o: Timeout waiting "
+                       DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
                                    "for PIN(1) in pcf_xfer\n");)
                        return (-EREMOTEIO);
                }
@@ -392,12 +389,12 @@
                /* Check LRB (last rcvd bit - slave ack) */
                if (status & I2C_PCF_LRB) {
                        i2c_stop(adap);
-                       DEB2(printk("i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
+                       DEB2(printk(KERN_ERR "i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
                        return (-EREMOTEIO);
                }
 #endif
     
-               DEB3(printk("i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
+               DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
                            i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
     
                /* Read */
@@ -407,20 +404,20 @@
                                             (i + 1 == num));
         
                        if (ret != pmsg->len) {
-                               DEB2(printk("i2c-algo-pcf.o: fail: "
+                               DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
                                            "only read %d bytes.\n",ret));
                        } else {
-                               DEB2(printk("i2c-algo-pcf.o: read %d bytes.\n",ret));
+                               DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret));
                        }
                } else { /* Write */
                        ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
                                             (i + 1 == num));
         
                        if (ret != pmsg->len) {
-                               DEB2(printk("i2c-algo-pcf.o: fail: "
+                               DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
                                            "only wrote %d bytes.\n",ret));
                        } else {
-                               DEB2(printk("i2c-algo-pcf.o: wrote %d bytes.\n",ret));
+                               DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n",ret));
                        }
                }
        }
@@ -461,7 +458,7 @@
        int i, status;
        struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 
-       DEB2(printk("i2c-algo-pcf.o: hw routines for %s registered.\n",
+       DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: hw routines for %s registered.\n",
                    adap->name));
 
        /* register new adapter to i2c module... */
@@ -514,7 +511,7 @@
        int res;
        if ((res = i2c_del_adapter(adap)) < 0)
                return res;
-       DEB2(printk("i2c-algo-pcf.o: adapter unregistered: %s\n",adap->name));
+       DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: adapter unregistered: %s\n",adap->name));
 
 #ifdef MODULE
        MOD_DEC_USE_COUNT;
@@ -524,7 +521,7 @@
 
 int __init i2c_algo_pcf_init (void)
 {
-       printk("i2c-algo-pcf.o: i2c pcf8584 algorithm module\n");
+       printk(KERN_INFO "i2c-algo-pcf.o: i2c pcf8584 algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
        return 0;
 }
 
--- linux/drivers/i2c/i2c-elektor.c.orig        2001-10-11 11:05:47.000000000 -0400
+++ linux/drivers/i2c/i2c-elektor.c     2002-08-13 00:39:32.000000000 -0400
@@ -35,7 +35,6 @@
 #include <linux/pci.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
 #include <linux/i2c-elektor.h>
@@ -55,12 +54,9 @@
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
@@ -74,11 +70,12 @@
 {
        int address = ctl ? (base + 1) : base;
 
-       if (ctl && irq) {
+       /* enable irq if any specified for serial operation */
+       if (ctl && irq && (val & I2C_PCF_ESO)) {
                val |= I2C_PCF_ENI;
        }
 
-       DEB3(printk("i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
+       DEB3(printk(KERN_DEBUG "i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
 
        switch (mmapped) {
        case 0: /* regular I/O */
@@ -99,7 +96,7 @@
        int address = ctl ? (base + 1) : base;
        int val = mmapped ? readb(address) : inb(address);
 
-       DEB3(printk("i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
+       DEB3(printk(KERN_DEBUG "i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
 
        return (val);
 }
@@ -120,12 +117,12 @@
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
@@ -142,7 +139,7 @@
 {
        if (!mmapped) {
                if (check_region(base, 2) < 0 ) {
-                       printk("i2c-elektor.o: requested I/O region (0x%X:2) is in use.\n", base);
+                       printk(KERN_ERR "i2c-elektor.o: requested I/O region (0x%X:2) is in use.\n", base);
                        return -ENODEV;
                } else {
                        request_region(base, 2, "i2c (isa bus adapter)");
@@ -150,7 +147,7 @@
        }
        if (irq > 0) {
                if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", 0) < 0) {
-                       printk("i2c-elektor.o: Request irq%d failed\n", irq);
+                       printk(KERN_ERR "i2c-elektor.o: Request irq%d failed\n", irq);
                        irq = 0;
                } else
                        enable_irq(irq);
@@ -159,7 +156,7 @@
 }
 
 
-static void __exit pcf_isa_exit(void)
+static void pcf_isa_exit(void)
 {
        if (irq > 0) {
                disable_irq(irq);
@@ -238,7 +235,7 @@
                        /* yeap, we've found cypress, let's check config */
                        if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
                                
-                               DEB3(printk("i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
+                               DEB3(printk(KERN_DEBUG "i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
 
                                /* UP2000 board has this register set to 0xe1,
                                    but the most significant bit as seems can be 
@@ -260,7 +257,7 @@
                                           8.25 MHz (PCI/4) clock
                                           (this can be read from cypress) */
                                        clock = I2C_PCF_CLK | I2C_PCF_TRNS90;
-                                       printk("i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
+                                       printk(KERN_INFO "i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
                                }
                        }
                }
@@ -269,27 +266,27 @@
 
        /* sanity checks for mmapped I/O */
        if (mmapped && base < 0xc8000) {
-               printk("i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
+               printk(KERN_ERR "i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
                return -ENODEV;
        }
 
-       printk("i2c-elektor.o: i2c pcf8584-isa adapter module\n");
+       printk(KERN_INFO "i2c-elektor.o: i2c pcf8584-isa adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
        if (base == 0) {
                base = DEFAULT_BASE;
        }
 
-#if (LINUX_VERSION_CODE >= 0x020301)
        init_waitqueue_head(&pcf_wait);
-#endif
        if (pcf_isa_init() == 0) {
-               if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
+               if (i2c_pcf_add_bus(&pcf_isa_ops) < 0) {
+                       pcf_isa_exit();
                        return -ENODEV;
+               }
        } else {
                return -ENODEV;
        }
        
-       printk("i2c-elektor.o: found device at %#x.\n", base);
+       printk(KERN_ERR "i2c-elektor.o: found device at %#x.\n", base);
 
        return 0;
 }
--- linux/drivers/i2c/i2c-elv.c.orig    2001-10-11 11:05:47.000000000 -0400
+++ linux/drivers/i2c/i2c-elv.c 2002-07-23 09:07:00.000000000 -0400
@@ -21,7 +21,7 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-elv.c,v 1.17 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-elv.c,v 1.21 2001/11/19 18:45:02 mds Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -29,9 +29,7 @@
 #include <linux/slab.h>
 #include <linux/version.h>
 #include <linux/init.h>
-
 #include <asm/uaccess.h>
-
 #include <linux/ioport.h>
 #include <asm/io.h>
 #include <linux/errno.h>
@@ -95,14 +93,14 @@
        } else {
                                                /* test for ELV adap.   */
                if (inb(base+1) & 0x80) {       /* BUSY should be high  */
-                       DEBINIT(printk("i2c-elv.o: Busy was low.\n"));
+                       DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Busy was low.\n"));
                        return -ENODEV;
                } else {
                        outb(0x0c,base+2);      /* SLCT auf low         */
                        udelay(400);
                        if ( !(inb(base+1) && 0x10) ) {
                                outb(0x04,base+2);
-                               DEBINIT(printk("i2c-elv.o: Select was high.\n"));
+                               DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Select was high.\n"));
                                return -ENODEV;
                        }
                }
@@ -170,7 +168,7 @@
 
 int __init i2c_bitelv_init(void)
 {
-       printk("i2c-elv.o: i2c ELV parallel port adapter module\n");
+       printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
        if (base==0) {
                /* probe some values */
                base=DEFAULT_BASE;
@@ -190,7 +188,7 @@
                        return -ENODEV;
                }
        }
-       printk("i2c-elv.o: found device at %#x.\n",base);
+       printk(KERN_DEBUG "i2c-elv.o: found device at %#x.\n",base);
        return 0;
 }
 
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-frodo.c       2002-07-23 01:51:04.000000000 -0400
@@ -0,0 +1,116 @@
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
+MODULE_LICENSE ("GPL");
+
+EXPORT_NO_SYMBOLS;
+
+module_init (i2c_frodo_init);
+module_exit (i2c_frodo_exit);
+
--- linux/drivers/i2c/i2c-pcf8584.h.orig        2001-02-09 14:40:02.000000000 -0500
+++ linux/drivers/i2c/i2c-pcf8584.h     2002-07-23 01:45:46.000000000 -0400
@@ -21,7 +21,7 @@
 
 /* With some changes from Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-pcf8584.h,v 1.3 2000/01/18 23:54:07 frodo Exp $ */
+/* $Id: i2c-pcf8584.h,v 1.4 2001/10/02 00:07:37 mds Exp $ */
 
 #ifndef I2C_PCF8584_H
 #define I2C_PCF8584_H 1
--- linux/drivers/i2c/i2c-philips-par.c.orig    2001-09-30 15:26:05.000000000 -0400
+++ linux/drivers/i2c/i2c-philips-par.c 2002-07-23 09:11:19.000000000 -0400
@@ -21,7 +21,7 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-philips-par.c,v 1.18 2000/07/06 19:21:49 frodo Exp $ */
+/* $Id: i2c-philips-par.c,v 1.23 2002/02/06 08:50:58 simon Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/ioport.h>
@@ -29,7 +29,6 @@
 #include <linux/init.h>
 #include <linux/stddef.h>
 #include <linux/parport.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
@@ -190,18 +189,18 @@
        struct i2c_par *adapter = kmalloc(sizeof(struct i2c_par),
                                          GFP_KERNEL);
        if (!adapter) {
-               printk("i2c-philips-par: Unable to malloc.\n");
+               printk(KERN_ERR "i2c-philips-par: Unable to malloc.\n");
                return;
        }
 
-       printk("i2c-philips-par.o: attaching to %s\n", port->name);
+       printk(KERN_DEBUG "i2c-philips-par.o: attaching to %s\n", port->name);
 
        adapter->pdev = parport_register_device(port, "i2c-philips-par",
                                                NULL, NULL, NULL, 
                                                PARPORT_FLAG_EXCL,
                                                NULL);
        if (!adapter->pdev) {
-               printk("i2c-philips-par: Unable to register with parport.\n");
+               printk(KERN_ERR "i2c-philips-par: Unable to register with parport.\n");
                return;
        }
 
@@ -210,15 +209,18 @@
        adapter->bit_lp_data = type ? bit_lp_data2 : bit_lp_data;
        adapter->bit_lp_data.data = port;
 
+       if (parport_claim_or_block(adapter->pdev) < 0 ) {
+               printk(KERN_ERR "i2c-philips-par: Could not claim parallel port.\n");
+               return;
+       }
        /* reset hardware to sane state */
-       parport_claim_or_block(adapter->pdev);
        bit_lp_setsda(port, 1);
        bit_lp_setscl(port, 1);
        parport_release(adapter->pdev);
 
        if (i2c_bit_add_bus(&adapter->adapter) < 0)
        {
-               printk("i2c-philips-par: Unable to register with I2C.\n");
+               printk(KERN_ERR "i2c-philips-par: Unable to register with I2C.\n");
                parport_unregister_device(adapter->pdev);
                kfree(adapter);
                return;         /* No good */
@@ -250,41 +252,23 @@
 }
 
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 static struct parport_driver i2c_driver = {
        "i2c-philips-par",
        i2c_parport_attach,
        i2c_parport_detach,
        NULL
 };
-#endif
 
 int __init i2c_bitlp_init(void)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,4)
-       struct parport *port;
-#endif
-       printk("i2c-philips-par.o: i2c Philips parallel port adapter module\n");
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
+       printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
        parport_register_driver(&i2c_driver);
-#else
-       for (port = parport_enumerate(); port; port=port->next)
-               i2c_parport_attach(port);
-#endif
-       
        return 0;
 }
 
 void __exit i2c_bitlp_exit(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
        parport_unregister_driver(&i2c_driver);
-#else
-       struct parport *port;
-       for (port = parport_enumerate(); port; port=port->next)
-               i2c_parport_detach(port);
-#endif
 }
 
 EXPORT_NO_SYMBOLS;
--- /dev/null   1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/i2c-rpx.c 2002-07-23 01:45:46.000000000 -0400
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
--- linux/drivers/i2c/i2c-velleman.c.orig       2001-10-11 11:05:47.000000000 -0400
+++ linux/drivers/i2c/i2c-velleman.c    2002-07-23 09:18:05.000000000 -0400
@@ -27,7 +27,6 @@
 #include <linux/string.h>  /* for 2.0 kernels to get NULL   */
 #include <asm/errno.h>     /* for 2.0 kernels to get ENODEV */
 #include <asm/io.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
@@ -91,7 +90,7 @@
 static int bit_velle_init(void)
 {
        if (check_region(base,(base == 0x3bc)? 3 : 8) < 0 ) {
-               DEBE(printk("i2c-velleman.o: Port %#x already in use.\n",
+               DEBE(printk(KERN_DEBUG "i2c-velleman.o: Port %#x already in use.\n",
                     base));
                return -ENODEV;
        } else {
@@ -160,7 +159,7 @@
 
 int __init  i2c_bitvelle_init(void)
 {
-       printk("i2c-velleman.o: i2c Velleman K8000 adapter module\n");
+       printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
        if (base==0) {
                /* probe some values */
                base=DEFAULT_BASE;
@@ -180,7 +179,7 @@
                        return -ENODEV;
                }
        }
-       printk("i2c-velleman.o: found device at %#x.\n",base);
+       printk(KERN_DEBUG "i2c-velleman.o: found device at %#x.\n",base);
        return 0;
 }
 

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
