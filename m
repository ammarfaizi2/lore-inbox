Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbULVNol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbULVNol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 08:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbULVNok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 08:44:40 -0500
Received: from [213.146.154.40] ([213.146.154.40]:39091 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261782AbULVNoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 08:44:25 -0500
Date: Wed, 22 Dec 2004 13:44:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx, hch@infradead.org
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
Message-ID: <20041222134423.GA11750@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	matthew@wil.cx
References: <200412220028.iBM0SB3d299993@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412220028.iBM0SB3d299993@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I cleaned this up a bit.  There still are a couple of issues. One is
> that the sgiioc4 driver also "uses" the ioc4 card for ide. So the probe
> needs to "fail" so that both driver's probes will be called (is there a
> better way?). Because of that the ->remove function isn't called
> directly.

So both claim the same PCI ID?  In this case you need to creat a small
shim driver that exports a pseudo-bus to the serial and ide driver using
the driver model.  You must never return an error from ->probe if you
actually use that particular device.

> I still save off the pci_dev ptrs for all cards found, so I can
> register with the serial core after probe (is there a better way?).
> Should I register the driver separately for each card ? That seems a
> bit overkill.

You should register them with the serial core in ->probe.

+#include <asm/sn/ioc4.h>

Please put that header into drivers/serial/ioc4.h or if you need it from
other drivers in the future to include/linux/ioc4.h

+/* Various states/options */
+#define ENABLE_FLOW_CONTROL
+#define ENABLE_OUTPUT_INTERRUPTS

So why do you need these ifdefs?  Unless there's a very good reason
kill all these conditionals.

+/* To use dynamic numbers only and not use the assigned major and minor,
+ * define the following.. */
+#define USE_DYNAMIC_MINOR 0	/* Don't rely on misc_register dynamic minor */
+static struct miscdevice misc;	/* used with misc_register for dynamic */

Dito.  Please kill the miscdevice code as you seem to have an assigned
number.

+/* defining this will force the driver to run in polled mode */
+//#define POLLING_FOR_CHARACTERS

Again, what's the need for these conditionals?

+/* Infinite loop detection.
+ */
+#define MAXITER 10000000
+#define SPIN(cond, success) \
+{ \
+	 int spiniter = 0; \
+	 success = 1; \
+	 while(cond) { \
+		 spiniter++; \
+		 if (spiniter > MAXITER) { \
+			 success = 0; \
+			 break; \
+		 } \
+	 } \
+}

Opencoding this in the callers would make the code a lot more readable.

+static struct pci_dev *Pdevs[IOC4_NUM_CARDS];

As mentioned above this shouldn't be needed when the driver uses
proper attachment.

+/* a table to keep the card names as passed to request_region */
+static struct {
+	char c_name[20];
+} Table_o_cards[IOC4_NUM_CARDS];

Completely superflous.  Just pass "ioc4_serial" as argument to request_region.

+/* Prototypes */
+static void ioc4_cb_output_lowat(struct ioc4_port *);
+static void ioc4_cb_post_ncs(struct uart_port *, int);
+static void receive_chars(struct uart_port *);
+static void handle_intr(void *arg, uint32_t sio_ir);

Please try to avoid forward-declarations where possible.

+
+/*
+ * support routines for local atomic operations.
+ */
+
+static spinlock_t local_lock;
+
+static inline unsigned int atomicClearInt(atomic_t * a, unsigned int b)
+{
+	unsigned long s;
+	unsigned int ret, new;
+
+	spin_lock_irqsave(&local_lock, s);
+	new = ret = atomic_read(a);
+	new &= ~b;
+	atomic_set(a, new);
+	spin_unlock_irqrestore(&local_lock, s);
+
+	return ret;
+}

There's only a singler caller, so better open-code it with a per-device
lock and avoid the bogus atomic_t use.  It looks like using bitops.h
functions would help that code aswell.

+static inline void
+write_ireg(struct ioc4_soft *ioc4_soft, uint32_t val, int which, int type)
+{
+	struct ioc4_mem *mem = ioc4_soft->is_ioc4_mem_addr;
+	spinlock_t *lp = &ioc4_soft->is_ir_lock;

small style nitpick: In general we try to avoid using spinlock_t pointers
just as local variables as that makes it more clear what's actually locked.

+	unsigned long s;

normally we call that variable flags.  Doing so aswell  here makes the
code easier to read.

+	spin_lock_irqsave(lp, s);
+
+	switch (type) {
+	case IOC4_SIO_INTR_TYPE:
+		switch (which) {
+		case IOC4_W_IES:
+			writel(val, (void *)&mem->sio_ies_ro);

The second argumnet to writeX (and readX) is actually void __iomem *,
but to see the difference you need to run sparse (from sparse.bkbits.net)
over the driver.  Please store all I/O addresses in void __iomem * pointers
in your structures and avoid the cast here and in all the other places.

Remember that in 90% of the cases a cast hides a possible bug.

+		return (1);

Please avoid braces around the return values.

+	if (ioc4_revid < ioc4_revid_min) {
+		printk(KERN_WARNING
+		    "IOC4 serial not supported on firmware rev %d on card %d, "
+				"please upgrade to rev %d or higher\n",
+				ioc4_revid, card_number, ioc4_revid_min);
+		return -1;

Please return meaninfull values from errno.h

+		port = (struct ioc4_port *)kmalloc(sizeof(struct ioc4_port),
+								GFP_KERNEL);

no need to cast the return value from kmalloc (dito for the other places)

+	if (pci_enable_device(pdev)) {

pci_enable_device returns an detailed error, please pass it on to the
caller.

+	/* Map in the ioc4 memory */
+	mem = (struct ioc4_mem *)pci_resource_start(pdev, 0);

You're missing an ioremap somewhere.

+	pdev->dev.driver_data = (void *)control;

please use pci_set_drvdata, the cast isn't needed here aswell.

+	control = (struct ioc4_control *)pdev->dev.driver_data;

please use pca_get_drvdata, again no need for a cast.

+	/* do the pci probing */
+	pci_register_driver(&ioc4_s_driver);

You need to check the return value from pci_register_driver.

+		if (uart_register_driver(&ioc4_uart) < 0) {

Please call uart_register_driver before calling pci_register_driver
so you can register the ports from ->probe.

+	spin_lock_irqsave(&IOC4_lock, flags);
+#ifdef POLLING_FOR_CHARACTERS
+	del_timer_sync(&IOC4_timer_list);
+#endif

del_timer_sync can sleep and must not be called inside a spinlock.

+	pci_unregister_driver(&ioc4_s_driver);

dito for pci_unregister_driver.

