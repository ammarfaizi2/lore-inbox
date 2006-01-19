Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWASPCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWASPCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWASPCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:02:50 -0500
Received: from node3.inaccessnetworks.com ([212.205.200.118]:9128 "EHLO
	inaccessnetworks.com") by vger.kernel.org with ESMTP
	id S1161226AbWASPCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:02:49 -0500
Date: Thu, 19 Jan 2006 17:01:56 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I2C bus implementation (for MPC82xx)
Message-ID: <20060119150155.GA18188@inaccessnetworks.com>
References: <43C2914A.8080409@inaccessnetworks.com> <1136848334.19965.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136848334.19965.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: Angelos Manousarides <amanous@inaccessnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 10:12:14AM +1100, Benjamin Herrenschmidt wrote:
> You can parse the msg list for validity and if it contains anything you
> don't grok, reject it. That's a bit of a pain though. That's why for
> PowerMac (see the patches that just went in rewriting the PowerMac i2c
> code), I have my own low level layer that uses different semantics
> closer to what Apple HW provides and one stub driver that hooks to linux
> i2c layer. In that stub, I chose to mostly implement the "smbus"
> transactions. In fact, smbus transactions map to pretty much 90% of the
> needs of most i2c devices around here. Of course, that mean you can't
> use existing i2c drivers that use the master_xfer() entry and not the
> smbus API, but then, do you really want to use an existing i2c driver ?
> I find them generally of no use as they don't know anything about the
> specifics of the platform anyway.


Sorry, that was my misunderstanding. There is no problem with the CPM2
and the I2C framework. Attached is a patch for I2C CPM2 support. It is a
(heavily) modified version of another patch I found in the linux PPC
mailing list by Heiko Schocher.

For the resources I have used platform definition. In my platform I have
defined:

static struct resource mpc_i2c_resources[] = {
    [0] = {
        .name = "i2c_int",
        .start = SIU_INT_I2C,
        .end = SIU_INT_I2C,
        .flags = IORESOURCE_IRQ,
    },
    [1] = {
        .name = "i2c_regs",
        .start = 0x11860,
        .end = 0x11860 + sizeof(i2c_cpm2_t) - 1,
        .flags = IORESOURCE_MEM,
    },
    [2] = {
        .name = "i2c_pram_base",
        .start = PROFF_I2C_BASE,
        .end = PROFF_I2C_BASE + 1,
        .flags = IORESOURCE_MEM,
    },
};

The memory addresses are offsets from DPRAM base. Later on initialization, the
platform specific code adds the DPRAM base address to them.

Here is the patch. I don't know what I have to do in order for this
patch to be included in the kernel. Code for powerPC is contributed
directly to the kernel maintainers according to the linux PPC site
(http://www.penguinppc.org/kernel/).

diff -urN linux-2.6.14/drivers/i2c/busses/Kconfig linux-2.6.14-mine/drivers/i2c/busses/Kconfig
--- linux-2.6.14/drivers/i2c/busses/Kconfig	2006-01-19 16:26:17.000000000 +0200
+++ linux-2.6.14-mine/drivers/i2c/busses/Kconfig	2006-01-19 16:20:16.000000000 +0200
@@ -270,6 +270,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mpc.
 
+config I2C_CPM2
+	tristate "MPC CPM2"
+	depends on I2C && PPC32 && CPM2
+	help
+	  If you say yes to this option, support will be included for the
+	  I2C interface on PPC with CPM2
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-cpm2.
+
 config I2C_NFORCE2
 	tristate "Nvidia nForce2, nForce3 and nForce4"
 	depends on I2C && PCI
diff -urN linux-2.6.14/drivers/i2c/busses/Makefile linux-2.6.14-mine/drivers/i2c/busses/Makefile
--- linux-2.6.14/drivers/i2c/busses/Makefile	2005-10-28 03:02:08.000000000 +0300
+++ linux-2.6.14-mine/drivers/i2c/busses/Makefile	2006-01-19 16:20:16.000000000 +0200
@@ -43,6 +43,7 @@
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_I2C_CPM2)		+= i2c-cpm2.o
 
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG
diff -urN linux-2.6.14/drivers/i2c/busses/i2c-cpm2.c linux-2.6.14-mine/drivers/i2c/busses/i2c-cpm2.c
--- linux-2.6.14/drivers/i2c/busses/i2c-cpm2.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.6.14-mine/drivers/i2c/busses/i2c-cpm2.c	2006-01-19 16:20:16.000000000 +0200
@@ -0,0 +1,450 @@
+/*
+ * (C) Copyright 2005
+ * Heiko Schocher <hs@denx.de>
+ *
+ * This is a combined i2c adapter and algorithm driver for
+ * PPC with CPM2
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/immap_cpm2.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/io.h>
+
+#define CPM_MAX_READ    513
+
+struct cpm2_i2c {
+    struct i2c_adapter adap;
+    wait_queue_head_t queue;
+    u32 irq;
+    spinlock_t flags;
+    i2c_cpm2_t *regs;
+    u16 *base;
+    iic_t *pram;
+    uint pram_addr;
+    uint rbdf_addr;
+    uint tbdf_addr;
+    enum { I2C_IDLE, I2C_TX_WAIT, I2C_TX_DONE, I2C_TX_ERROR,
+           I2C_RX_WAIT, I2C_RX_DONE } state;
+};
+
+
+static irqreturn_t cpm2_i2c_isr(int irq, void *dev_id, struct pt_regs *regs)
+{
+    struct cpm2_i2c *cpm2_i2c = dev_id;
+    unsigned short isr;
+    int oldstate = cpm2_i2c->state;
+
+    isr = cpm2_i2c->regs->i2c_i2cer;
+    /* acknowledge all interrupts */
+    cpm2_i2c->regs->i2c_i2cer = 0xff;
+    /* disable I2C */
+    cpm2_i2c->regs->i2c_i2mod &= ~0x01;
+    dev_dbg(&cpm2_i2c->adap.dev, "INT isr %x state %d\n", isr, cpm2_i2c->state);
+
+    switch ( cpm2_i2c->state ) {
+        case I2C_TX_WAIT:
+            if ( isr & 0x02 ) { /* TX DONE */
+                cpm2_i2c->state = I2C_TX_DONE;
+                wake_up_interruptible(&cpm2_i2c->queue);
+            }
+            if ( isr & 0x10 ) { /* TX ERROR */
+                cpm2_i2c->state = I2C_TX_ERROR;
+                wake_up_interruptible(&cpm2_i2c->queue);
+            }
+            break;
+        case I2C_RX_WAIT:
+            if ( isr & 0x02 ) { /* TX DONE (triggered when RX is done) */
+                cpm2_i2c->state = I2C_RX_DONE;
+                wake_up_interruptible(&cpm2_i2c->queue);
+            }
+            break;
+        default:
+            /* Keep gcc happy */
+            break;
+    }
+
+    if ( cpm2_i2c->state == oldstate ) {
+        dev_info(&cpm2_i2c->adap.dev, "no state change. spurious interrupt?\n");
+    }
+
+    return IRQ_HANDLED;
+}
+
+
+static void
+cpm2_pram_init(struct cpm2_i2c *i2c)
+{
+    iic_t *iip = i2c->pram;
+
+    /* Initialize the parameter ram. */
+    iip->iic_rstate = 0;
+    iip->iic_rdp = 0;
+    iip->iic_rbptr = 0;
+    iip->iic_rbc = 0;
+    iip->iic_rxtmp = 0;
+    iip->iic_tstate = 0;
+    iip->iic_tdp = 0;
+    iip->iic_tbptr = 0;
+    iip->iic_tbc = 0;
+    iip->iic_txtmp = 0;
+
+    /* Set up the IIC parameters in the parameter ram. */
+    iip->iic_tbase = i2c->tbdf_addr;
+    iip->iic_rbase = i2c->rbdf_addr;
+
+    iip->iic_tfcr = CPMFCR_GBL | CPMFCR_EB;
+    iip->iic_rfcr = CPMFCR_GBL | CPMFCR_EB;
+
+    /* Set maximum receive size. */
+    iip->iic_mrblr = CPM_MAX_READ;
+}
+
+
+static int
+cpm_iic_read(struct cpm2_i2c *mpc, u_char i2c_addr, char *buf, int count)
+{
+    i2c_cpm2_t *regs = mpc->regs;
+    cbd_t *tbdf, *rbdf;
+    u_char temp[CPM_MAX_READ];
+
+    if (count >= CPM_MAX_READ)
+        return -EINVAL;
+
+    dev_dbg(&mpc->adap.dev, "read %d bytes\n", count);
+
+    tbdf = (cbd_t *)&cpm2_immr->im_dprambase[mpc->pram->iic_tbase];
+    rbdf = (cbd_t *)&cpm2_immr->im_dprambase[mpc->pram->iic_rbase];
+
+    /* setup a transmit buffer. First byte is slave address. Length is
+     * count + 1. the rest of the bits are used for timing and are left
+     * uninitialized */
+    temp[0] = i2c_addr;
+    tbdf->cbd_bufaddr = virt_to_phys(temp);
+    tbdf->cbd_datlen = count + 1;
+    tbdf->cbd_sc = BD_SC_READY | BD_SC_LAST | BD_SC_WRAP | BD_SC_INTRPT;
+
+    /* setup receive buffer and read length */
+    rbdf->cbd_datlen = 0;
+    rbdf->cbd_bufaddr = virt_to_phys(buf);
+    rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
+    mpc->pram->iic_mrblr = count;
+
+    mpc->state = I2C_RX_WAIT;
+
+    spin_lock_irq(&mpc->flags);
+    /* enable I2C */
+    regs->i2c_i2mod |= 0x01;
+    /* start I2C */
+    regs->i2c_i2com = 0x81;
+    spin_unlock_irq(&mpc->flags);
+
+    /* Wait for IIC transfer */
+    if ( wait_event_interruptible(mpc->queue, (mpc->state==I2C_RX_DONE)) )
+        return -ERESTARTSYS;
+
+    if ( rbdf->cbd_sc & BD_SC_EMPTY ) {
+        dev_info(&mpc->adap.dev, "read complete but rbuf empty\n");
+        return 0;
+    }
+    if ( rbdf->cbd_sc & BD_SC_OV ) {
+        dev_info(&mpc->adap.dev, "read overrun\n");
+        return 0;
+    }
+
+    if ( rbdf->cbd_datlen < count ) {
+        dev_info(&mpc->adap.dev, "read short. wanted %d got %d\n",
+                 count, rbdf->cbd_datlen);
+    }
+
+    return rbdf->cbd_datlen;
+}
+
+
+static int
+cpm_iic_write(struct cpm2_i2c *mpc, u_char i2c_addr, char *buf, int count)
+{
+    i2c_cpm2_t *regs = mpc->regs;
+    cbd_t *tbdf;
+    u_char temp[CPM_MAX_READ];
+
+    dev_dbg(&mpc->adap.dev, "write %d bytes\n", count);
+
+    tbdf = (cbd_t *)&cpm2_immr->im_dprambase[mpc->pram->iic_tbase];
+
+    /* setup transmit buffers. First buffer contains one byte, the slave
+     * address. The second buffer contains the actual data */
+    temp[0] = i2c_addr;
+    tbdf[0].cbd_bufaddr = virt_to_phys(temp);
+    tbdf[0].cbd_datlen = 1;
+    tbdf[0].cbd_sc = BD_SC_READY | BD_IIC_START;
+    tbdf[1].cbd_bufaddr = virt_to_phys(buf);
+    tbdf[1].cbd_datlen = count;
+    tbdf[1].cbd_sc = BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | BD_SC_WRAP;
+
+    mpc->state = I2C_TX_WAIT;
+
+    spin_lock_irq(&mpc->flags);
+    /* enable I2C */
+    regs->i2c_i2mod |= 0x01;
+    /* start I2C */
+    regs->i2c_i2com = 0x81;
+    spin_unlock_irq(&mpc->flags);
+
+    if ( wait_event_interruptible(mpc->queue, ((mpc->state==I2C_TX_DONE) ||
+                                               (mpc->state==I2C_TX_ERROR))) )
+        return -ERESTARTSYS;
+
+    if ( mpc->state == I2C_TX_ERROR )
+        dev_info(&mpc->adap.dev, "TX error\n");
+
+    if ( tbdf->cbd_sc & BD_SC_READY ) {
+        dev_info(&mpc->adap.dev, "ready is still up in transmit buffer\n");
+        return 0;
+    }
+    if ( tbdf->cbd_sc & BD_SC_NAK ) {
+        dev_info(&mpc->adap.dev, "no ack in transmit\n");
+        return 0;
+    }
+    if ( tbdf->cbd_sc & BD_SC_OV ) {
+        dev_info(&mpc->adap.dev, "write overrun\n");
+        return 0;
+    }
+    if ( tbdf->cbd_sc & BD_SC_CD ) {
+        dev_info(&mpc->adap.dev, "write collision\n");
+        return 0;
+    }
+
+    if ( tbdf->cbd_sc & BD_SC_READY ) {
+        dev_info(&mpc->adap.dev, "write complete but tbuf ready\n");
+        return 0;
+    }
+
+    return count;
+}
+
+static int cpm2_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+    struct i2c_msg *pmsg;
+    struct cpm2_i2c *mpc_i2c = i2c_get_adapdata(adap);
+    int i;
+    int ret = 0;
+    u_char addr;
+
+    for (i = 0; i < num; i++) {
+        pmsg = &msgs[i];
+        addr = pmsg->addr << 1;
+        if ( pmsg->flags & I2C_M_RD )
+            addr |= 1;
+        if ( pmsg->flags & I2C_M_REV_DIR_ADDR )
+            addr ^= 1;
+        if ( pmsg->flags & I2C_M_RD ) {
+            /* read bytes into buffer*/
+            ret = cpm_iic_read(mpc_i2c, addr, pmsg->buf, pmsg->len);
+            dev_dbg(&mpc_i2c->adap.dev, "read %d bytes\n", ret);
+            if ( ret < pmsg->len ) {
+                return (ret<0) ? ret : -EREMOTEIO;
+            }
+        } else {
+            /* write bytes from buffer */
+            ret = cpm_iic_write(mpc_i2c, addr, pmsg->buf, pmsg->len);
+            dev_dbg(&mpc_i2c->adap.dev, "wrote %d\n", ret);
+            if ( ret < pmsg->len ) {
+                return (ret<0) ? ret : -EREMOTEIO;
+            }
+        }
+    }
+    return (ret < 0) ? ret : num;
+}
+
+static u32 cpm2_functionality(struct i2c_adapter *adap)
+{
+    return I2C_FUNC_I2C;
+}
+
+static struct i2c_algorithm cpm2_algo = {
+    .master_xfer = cpm2_xfer,
+    .functionality = cpm2_functionality,
+};
+
+static struct i2c_adapter cpm2_ops = {
+    .owner = THIS_MODULE,
+    .name = "MPC CPM2 adapter",
+    .id = I2C_HW_MPC82xx,
+    .algo = &cpm2_algo,
+    .class = I2C_CLASS_HWMON,
+    .timeout = 1,
+    .retries = 1
+};
+
+static int fsl_i2c_probe(struct device *device)
+{
+    struct platform_device *pdev = to_platform_device(device);
+    struct cpm2_i2c *i2c;
+    struct resource *r;
+    void *start;
+    int result = 0;
+
+    i2c = kmalloc(sizeof(*i2c), GFP_KERNEL);
+    if ( i2c == NULL )
+        return -ENOMEM;
+    memset(i2c, 0, sizeof(*i2c));
+
+    r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+    if ( r == NULL ) {
+        dev_err(device, "register resource not found\n");
+        result = -EINVAL;
+        goto fail_map1;
+    }
+
+    start = ioremap((phys_addr_t)r->start, sizeof(i2c_cpm2_t));
+    if ( start==NULL ) {
+        dev_err(device, "ioremap for registers failed\n");
+        result = -ENOMEM;
+        goto fail_map1;
+    }
+    i2c->regs = start;
+
+    r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+    if ( r==NULL ) {
+        dev_err(device, "i2c base pointer resource not found\n");
+        result = -EINVAL;
+        goto fail_map2;
+    }
+
+    start = ioremap((phys_addr_t)r->start, 2);
+    if ( start==NULL ) {
+        dev_err(device, "ioremap for i2c base pointer failed\n");
+        result = -ENOMEM;
+        goto fail_map2;
+    }
+    i2c->base = start;
+
+    i2c->irq = platform_get_irq(pdev, 0);
+    if ( ! i2c->irq ) {
+        dev_err(device, "i2c irq resource not found\n");
+        result = -EINVAL;
+        goto fail_irq;
+    }
+
+    if ( (result = request_irq(i2c->irq, cpm2_i2c_isr,
+                               SA_SHIRQ, "i2c-mpc", i2c)) < 0 ) {
+        dev_err(device, "failed to attach interrupt\n");
+        goto fail_irq;
+    }
+
+    i2c->pram_addr = cpm_dpalloc(sizeof(iic_t), 64);
+    *(i2c->base) = (ushort)i2c->pram_addr;
+    i2c->pram = (iic_t *)&cpm2_immr->im_dprambase[i2c->pram_addr];
+    
+    i2c->rbdf_addr = cpm_dpalloc(sizeof(cbd_t) * 2, 8);
+    i2c->tbdf_addr = cpm_dpalloc(sizeof(cbd_t) * 2, 8);
+
+    cpm2_pram_init(i2c);
+
+    /* Initialize Tx/Rx parameters. */
+    {
+        volatile cpm_cpm2_t *cp = cpmp;
+        cp->cp_cpcr =
+            mk_cr_cmd(CPM_CR_I2C_PAGE,
+                      CPM_CR_I2C_SBLOCK,
+                      0x00, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+        while (cp->cp_cpcr & CPM_CR_FLG);
+    }
+
+    /* Select an arbitrary address.  Just make sure it is unique. */
+    i2c->regs->i2c_i2add = 0x34;
+    /* Divider is 2 * ( 28 + 3 ) */
+    i2c->regs->i2c_i2brg = 0x1c;
+    /* Pre-divider is BRGCLK/4 */
+    i2c->regs->i2c_i2mod = 0x06;
+    /* acknowledge old interrupts */
+    i2c->regs->i2c_i2cer = 0xff;
+    /* Enable interrupts. */
+    i2c->regs->i2c_i2cmr = 0x12;
+
+    init_waitqueue_head(&i2c->queue);
+
+    i2c->state = I2C_IDLE;
+
+    dev_set_drvdata(device, i2c);
+    i2c->adap = cpm2_ops;
+    i2c_set_adapdata(&i2c->adap, i2c);
+    i2c->adap.dev.parent = &pdev->dev;
+
+    result = i2c_add_adapter(&i2c->adap);
+    if ( result < 0 ) {
+        dev_err(device, "failed to add adapter\n");
+        goto fail_add;
+    }
+
+    return result;
+
+fail_add:
+    free_irq(i2c->irq, NULL);
+    cpm_dpfree(i2c->rbdf_addr);
+    cpm_dpfree(i2c->tbdf_addr);
+    cpm_dpfree(i2c->pram_addr);
+fail_irq:
+    iounmap(i2c->base);
+fail_map2:
+    iounmap(i2c->regs);
+fail_map1:
+    kfree(i2c);
+    return result;
+};
+
+static int fsl_i2c_remove(struct device *device)
+{
+    struct cpm2_i2c *i2c = dev_get_drvdata(device);
+
+    i2c_del_adapter(&i2c->adap);
+    dev_set_drvdata(device, NULL);
+
+    free_irq(i2c->irq, i2c);
+    cpm_dpfree(i2c->rbdf_addr);
+    cpm_dpfree(i2c->tbdf_addr);
+    cpm_dpfree(i2c->pram_addr);
+
+    iounmap(i2c->base);
+    iounmap(i2c->regs);
+    kfree(i2c);
+
+    return 0;
+};
+
+/* Structure for a device driver */
+static struct device_driver fsl_i2c_driver = {
+    .name = "fsl-cpm-i2c",
+    .bus = &platform_bus_type,
+    .probe = fsl_i2c_probe,
+    .remove = fsl_i2c_remove,
+};
+
+static int __init fsl_i2c_init(void)
+{
+    return driver_register(&fsl_i2c_driver);
+}
+
+static void __exit fsl_i2c_exit(void)
+{
+    driver_unregister(&fsl_i2c_driver);
+}
+
+module_init(fsl_i2c_init);
+module_exit(fsl_i2c_exit);
+
+MODULE_AUTHOR("Heiko Schocher <hs@denx.de>");
+MODULE_DESCRIPTION("I2C-Bus adapter for MPC with CPM2 processors");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.14/include/asm-ppc/cpm2.h linux-2.6.14-mine/include/asm-ppc/cpm2.h
--- linux-2.6.14/include/asm-ppc/cpm2.h	2006-01-19 16:26:33.000000000 +0200
+++ linux-2.6.14-mine/include/asm-ppc/cpm2.h	2006-01-19 16:20:16.000000000 +0200
@@ -139,6 +139,7 @@
 #define BD_SC_BR	((ushort)0x0020)	/* Break received */
 #define BD_SC_FR	((ushort)0x0010)	/* Framing error */
 #define BD_SC_PR	((ushort)0x0008)	/* Parity error */
+#define BD_SC_NAK	((ushort)0x0004)	/* No acknowledge */
 #define BD_SC_OV	((ushort)0x0002)	/* Overrun */
 #define BD_SC_CD	((ushort)0x0001)	/* ?? */
 
diff -urN linux-2.6.14/include/linux/i2c-id.h linux-2.6.14-mine/include/linux/i2c-id.h
--- linux-2.6.14/include/linux/i2c-id.h	2006-01-19 16:26:34.000000000 +0200
+++ linux-2.6.14-mine/include/linux/i2c-id.h	2006-01-19 16:20:16.000000000 +0200
@@ -224,6 +224,9 @@
 /* --- PowerPC on-chip adapters						*/
 #define I2C_HW_OCP		0x120000 /* IBM on-chip I2C adapter */
 
+/* --- MPC82xx PowerPC adapters				*/
+#define I2C_HW_MPC82xx		0x100002 /* MPC82xx I2C adapter */
+
 /* --- Broadcom SiByte adapters						*/
 #define I2C_HW_SIBYTE		0x150000



--
Manousaridis Angelos
