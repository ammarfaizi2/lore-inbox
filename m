Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUATC2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbUATAHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:07:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:9388 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264510AbUASX7t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:59:49 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <1074556767824@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:28 -0800
Message-Id: <10745567681965@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.28, 2004/01/19 15:07:53-08:00, greg@kroah.com

[PATCH] I2C: add I2C_DEBUG_BUS config option and convert the i2c bus drivers to use it.

This cleans up the mismatch of ways we could enable debugging messages.


 drivers/i2c/Kconfig                    |    9 ++++++++
 drivers/i2c/busses/i2c-ali1535.c       |    5 +++-
 drivers/i2c/busses/i2c-ali15x3.c       |    5 +++-
 drivers/i2c/busses/i2c-amd756.c        |    5 +++-
 drivers/i2c/busses/i2c-amd8111.c       |    5 ++++
 drivers/i2c/busses/i2c-elektor.c       |   19 +++++++----------
 drivers/i2c/busses/i2c-elv.c           |   17 +++++++--------
 drivers/i2c/busses/i2c-frodo.c         |    5 ++++
 drivers/i2c/busses/i2c-i801.c          |    5 +++-
 drivers/i2c/busses/i2c-i810.c          |    5 ++++
 drivers/i2c/busses/i2c-ibm_iic.c       |    6 +++++
 drivers/i2c/busses/i2c-iop3xx.c        |    9 +++-----
 drivers/i2c/busses/i2c-isa.c           |    5 ++++
 drivers/i2c/busses/i2c-ite.c           |   24 ++++++++++------------
 drivers/i2c/busses/i2c-keywest.c       |   36 +++++++++++++++------------------
 drivers/i2c/busses/i2c-nforce2.c       |    5 ++++
 drivers/i2c/busses/i2c-parport-light.c |    5 ++++
 drivers/i2c/busses/i2c-parport.c       |    7 +++++-
 drivers/i2c/busses/i2c-philips-par.c   |    7 +++++-
 drivers/i2c/busses/i2c-piix4.c         |    5 +++-
 drivers/i2c/busses/i2c-prosavage.c     |    5 ++++
 drivers/i2c/busses/i2c-rpx.c           |    7 +++++-
 drivers/i2c/busses/i2c-savage4.c       |    5 ++++
 drivers/i2c/busses/i2c-sis5595.c       |   10 +++++----
 drivers/i2c/busses/i2c-sis630.c        |    5 +++-
 drivers/i2c/busses/i2c-sis96x.c        |    5 +++-
 drivers/i2c/busses/i2c-velleman.c      |   12 +++++------
 drivers/i2c/busses/i2c-via.c           |    5 +++-
 drivers/i2c/busses/i2c-viapro.c        |    5 ++++
 drivers/i2c/busses/i2c-voodoo3.c       |    5 ++++
 drivers/i2c/busses/scx200_acb.c        |    9 ++++++--
 drivers/i2c/busses/scx200_i2c.c        |   10 ++++++---
 32 files changed, 189 insertions(+), 83 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/Kconfig	Mon Jan 19 15:27:44 2004
@@ -49,6 +49,15 @@
 	  messages to the system log.  Select this if you are having a
 	  problem with I2C support and want to see more of what is going on.
 
+config I2C_DEBUG_BUS
+	bool "I2C Bus debugging messages"
+	depends on I2C
+	help
+	  Say Y here if you want the I2C bus drivers to produce a bunch of
+	  debug messages to the system log.  Select this if you are having
+	  a problem with I2C support and want to see more of what is going
+	  on.
+
 config I2C_DEBUG_CHIP
 	bool "I2C Chip debugging messages"
 	depends on I2C
diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-ali1535.c	Mon Jan 19 15:27:44 2004
@@ -53,7 +53,10 @@
 
 /* Note: we assume there can only be one ALI1535, with one SMBus interface */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Mon Jan 19 15:27:44 2004
@@ -60,7 +60,10 @@
 
 /* Note: we assume there can only be one ALI15X3, with one SMBus interface */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-amd756.c	Mon Jan 19 15:27:44 2004
@@ -37,7 +37,10 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-amd8111.c	Mon Jan 19 15:27:44 2004
@@ -8,6 +8,11 @@
  * the Free Software Foundation version 2.
  */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-elektor.c	Mon Jan 19 15:27:44 2004
@@ -25,6 +25,11 @@
 /* Partialy rewriten by Oleg I. Vdovikin for mmapped support of 
    for Alpha Processor Inc. UP-2000(+) boards */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -50,7 +55,6 @@
 static int clock  = 0x1c;
 static int own    = 0x55;
 static int mmapped;
-static int i2c_debug;
 
 /* vdovikin: removed static struct i2c_pcf_isa gpi; code - 
   this module in real supports only one device, due to missing arguments
@@ -60,12 +64,6 @@
 static wait_queue_head_t pcf_wait;
 static int pcf_pending;
 
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)	if (i2c_debug>=1) x
-#define DEB2(x) if (i2c_debug>=2) x
-#define DEB3(x) if (i2c_debug>=3) x
-#define DEBE(x)	x	/* error messages 				*/
-
 /* ----- local functions ----------------------------------------------	*/
 
 static void pcf_isa_setbyte(void *data, int ctl, int val)
@@ -77,7 +75,7 @@
 		val |= I2C_PCF_ENI;
 	}
 
-	DEB3(printk(KERN_DEBUG "i2c-elektor: Write 0x%X 0x%02X\n", address, val & 255));
+	pr_debug("i2c-elektor: Write 0x%X 0x%02X\n", address, val & 255);
 
 	switch (mmapped) {
 	case 0: /* regular I/O */
@@ -98,7 +96,7 @@
 	int address = ctl ? (base + 1) : base;
 	int val = mmapped ? readb(address) : inb(address);
 
-	DEB3(printk(KERN_DEBUG "i2c-elektor: Read 0x%X 0x%02X\n", address, val));
+	pr_debug("i2c-elektor: Read 0x%X 0x%02X\n", address, val);
 
 	return (val);
 }
@@ -196,7 +194,7 @@
 			/* yeap, we've found cypress, let's check config */
 			if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
 				
-				DEB3(printk(KERN_DEBUG "i2c-elektor: found cy82c693, config register 0x47 = 0x%02x.\n", config));
+				pr_debug("i2c-elektor: found cy82c693, config register 0x47 = 0x%02x.\n", config);
 
 				/* UP2000 board has this register set to 0xe1,
                                    but the most significant bit as seems can be 
@@ -280,7 +278,6 @@
 MODULE_PARM(clock, "i");
 MODULE_PARM(own, "i");
 MODULE_PARM(mmapped, "i");
-MODULE_PARM(i2c_debug, "i");
 
 module_init(i2c_pcfisa_init);
 module_exit(i2c_pcfisa_exit);
diff -Nru a/drivers/i2c/busses/i2c-elv.c b/drivers/i2c/busses/i2c-elv.c
--- a/drivers/i2c/busses/i2c-elv.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-elv.c	Mon Jan 19 15:27:44 2004
@@ -21,6 +21,11 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -36,12 +41,6 @@
 static int base=0;
 static unsigned char port_data = 0;
 
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)		/* should be reasonable open, close &c. 	*/
-#define DEB2(x) 	/* low level debugging - very slow 		*/
-#define DEBE(x)	x	/* error messages 				*/
-#define DEBINIT(x) x	/* detection status messages			*/
-
 /* --- Convenience defines for the parallel port:			*/
 #define BASE	(unsigned int)(data)
 #define DATA	BASE			/* Centronics data port		*/
@@ -89,7 +88,7 @@
 		return -ENODEV;
 
 	if (inb(base+1) & 0x80) {	/* BUSY should be high	*/
-		DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Busy was low.\n"));
+		pr_debug("i2c-elv: Busy was low.\n");
 		goto fail;
 	} 
 
@@ -97,7 +96,7 @@
 	udelay(400);
 	if (!(inb(base+1) && 0x10)) {
 		outb(0x04,base+2);
-		DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Select was high.\n"));
+		pr_debug("i2c-elv: Select was high.\n");
 		goto fail;
 	}
 
@@ -153,7 +152,7 @@
 			return -ENODEV;
 		}
 	}
-	printk(KERN_DEBUG "i2c-elv.o: found device at %#x.\n",base);
+	pr_debug("i2c-elv: found device at %#x.\n",base);
 	return 0;
 }
 
diff -Nru a/drivers/i2c/busses/i2c-frodo.c b/drivers/i2c/busses/i2c-frodo.c
--- a/drivers/i2c/busses/i2c-frodo.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-frodo.c	Mon Jan 19 15:27:44 2004
@@ -12,6 +12,11 @@
  * version 2 as published by the Free Software Foundation.
  */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-i801.c	Mon Jan 19 15:27:44 2004
@@ -38,7 +38,10 @@
 
 /* Note: we assume there can only be one I801, with one SMBus interface */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
--- a/drivers/i2c/busses/i2c-i810.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-i810.c	Mon Jan 19 15:27:44 2004
@@ -34,6 +34,11 @@
    i815			1132           
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Mon Jan 19 15:27:44 2004
@@ -27,6 +27,12 @@
  * option) any later version.
  *
  */
+
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
diff -Nru a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
--- a/drivers/i2c/busses/i2c-iop3xx.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-iop3xx.c	Mon Jan 19 15:27:44 2004
@@ -31,6 +31,10 @@
 
   ---------------------------------------------------------------------------*/
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -529,8 +533,3 @@
 MODULE_AUTHOR("D-TACQ Solutions Ltd <www.d-tacq.com>");
 MODULE_DESCRIPTION("IOP3xx iic algorithm and driver");
 MODULE_LICENSE("GPL");
-
-MODULE_PARM(i2c_debug,"i");
-
-MODULE_PARM_DESC(i2c_debug, "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
-
diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-isa.c	Mon Jan 19 15:27:44 2004
@@ -24,6 +24,11 @@
    the SMBus and the ISA bus very much easier. See lm78.c for an example
    of this. */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-ite.c b/drivers/i2c/busses/i2c-ite.c
--- a/drivers/i2c/busses/i2c-ite.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-ite.c	Mon Jan 19 15:27:44 2004
@@ -33,6 +33,11 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -58,26 +63,21 @@
 static int clock = 0;
 static int own   = 0;
 
-static int i2c_debug=0;
 static struct iic_ite gpi;
 static wait_queue_head_t iic_wait;
 static int iic_pending;
 
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)	if (i2c_debug>=1) x
-#define DEB2(x) if (i2c_debug>=2) x
-#define DEB3(x) if (i2c_debug>=3) x
-#define DEBE(x)	x	/* error messages 				*/
-
-
 /* ----- local functions ----------------------------------------------	*/
 
 static void iic_ite_setiic(void *data, int ctl, short val)
 {
         unsigned long j = jiffies + 10;
 
-	DEB3(printk(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff));
-	DEB3({while (time_before(jiffies, j)) schedule();})
+	pr_debug(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff);
+#ifdef DEBUG
+	while (time_before(jiffies, j))
+		schedule();
+#endif
 	outw(val,ctl);
 }
 
@@ -86,7 +86,7 @@
 	short val;
 
 	val = inw(ctl);
-	DEB3(printk("Read 0x%02x from 0x%x\n",(unsigned short)val, ctl&0xff));  
+	pr_debug("Read 0x%02x from 0x%x\n",(unsigned short)val, ctl&0xff);
 	return (val);
 }
 
@@ -145,7 +145,6 @@
 	
    iic_pending = 1;
 
-   DEB2(printk("iic_ite_handler: in interrupt handler\n"));
    wake_up_interruptible(&iic_wait);
 }
 
@@ -263,7 +262,6 @@
 MODULE_PARM(irq, "i");
 MODULE_PARM(clock, "i");
 MODULE_PARM(own, "i");
-MODULE_PARM(i2c_debug,"i");
 
 
 /* Called when module is loaded or when kernel is initialized.
diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-keywest.c	Mon Jan 19 15:27:44 2004
@@ -43,6 +43,11 @@
     sound driver to be happy
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -65,20 +70,13 @@
 
 #include "i2c-keywest.h"
 
-#define DBG(x...) do {\
-	if (debug > 0) \
-		printk(KERN_DEBUG "KW:" x); \
-	} while(0)
-
 
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("I2C driver for Apple's Keywest");
 MODULE_LICENSE("GPL");
 MODULE_PARM(probe, "i");
-MODULE_PARM(debug, "i");
 
-int probe = 0;
-int debug = 0;
+static int probe = 0;
 
 static void
 do_stop(struct keywest_iface* iface, int result)
@@ -95,7 +93,7 @@
 	int ack;
 	int rearm_timer = 1;
 	
-	DBG("handle_interrupt(), got: %x, status: %x, state: %d\n",
+	pr_debug("handle_interrupt(), got: %x, status: %x, state: %d\n",
 		isr, read_reg(reg_status), iface->state);
 	if (isr == 0 && iface->state != state_stop) {
 		do_stop(iface, -1);
@@ -112,7 +110,7 @@
 			break;
 		}
 		ack = read_reg(reg_status);
-		DBG("ack on set address: %x\n", ack);
+		pr_debug("ack on set address: %x\n", ack);
 		if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
 			do_stop(iface, -1);
 			break;
@@ -127,7 +125,7 @@
 					| KW_I2C_CTL_AAK);
 		} else {
 			iface->state = state_write;
-			DBG("write byte: %x\n", *(iface->data));
+			pr_debug("write byte: %x\n", *(iface->data));
 			write_reg(reg_data, *(iface->data++));
 			iface->datalen--;
 		}
@@ -139,7 +137,7 @@
 			break;
 		}
 		*(iface->data++) = read_reg(reg_data);
-		DBG("read byte: %x\n", *(iface->data-1));
+		pr_debug("read byte: %x\n", *(iface->data-1));
 		iface->datalen--;
 		if (iface->datalen == 0)
 			iface->state = state_stop;
@@ -153,13 +151,13 @@
 		}
 		/* Check ack status */
 		ack = read_reg(reg_status);
-		DBG("ack on data write: %x\n", ack);
+		pr_debug("ack on data write: %x\n", ack);
 		if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
 			do_stop(iface, -1);
 			break;
 		}
 		if (iface->datalen) {
-			DBG("write byte: %x\n", *(iface->data));
+			pr_debug("write byte: %x\n", *(iface->data));
 			write_reg(reg_data, *(iface->data++));
 			iface->datalen--;
 		} else
@@ -203,7 +201,7 @@
 {
 	struct keywest_iface *iface = (struct keywest_iface *)data;
 
-	DBG("timeout !\n");
+	pr_debug("timeout !\n");
 	spin_lock_irq(&iface->lock);
 	if (handle_interrupt(iface, read_reg(reg_isr)))
 		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
@@ -271,7 +269,7 @@
 
 	down(&iface->sem);
 
-	DBG("chan: %d, addr: 0x%x, transfer len: %d, read: %d\n",
+	pr_debug("chan: %d, addr: 0x%x, transfer len: %d, read: %d\n",
 		chan->chan_no, addr, len, read_write == I2C_SMBUS_READ);
 
 	iface->data = buffer;
@@ -306,7 +304,7 @@
 	wait_for_completion(&iface->complete);	
 
 	rc = iface->result;	
-	DBG("transfer done, result: %d\n", rc);
+	pr_debug("transfer done, result: %d\n", rc);
 
 	if (rc == 0 && size == I2C_SMBUS_WORD_DATA && read_write == I2C_SMBUS_READ)
 	    	data->word = le16_to_cpu(cur_word);
@@ -348,7 +346,7 @@
 			rc = -EINVAL;
 			break;
 		}
-		DBG("xfer: chan: %d, doing %s %d bytes to 0x%02x - %d of %d messages\n",
+		pr_debug("xfer: chan: %d, doing %s %d bytes to 0x%02x - %d of %d messages\n",
 		     chan->chan_no,
 		     pmsg->flags & I2C_M_RD ? "read" : "write",
                      pmsg->len, addr, i, num);
@@ -388,7 +386,7 @@
 		rc = iface->result;
 		if (rc == 0)
 			completed++;
-		DBG("transfer done, result: %d\n", rc);
+		pr_debug("transfer done, result: %d\n", rc);
 	}
 
 	/* Release sem */
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-nforce2.c	Mon Jan 19 15:27:44 2004
@@ -32,6 +32,11 @@
 
 /* Note: we assume there can only be one nForce2, with two SMBus interfaces */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
--- a/drivers/i2c/busses/i2c-parport-light.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-parport-light.c	Mon Jan 19 15:27:44 2004
@@ -24,6 +24,11 @@
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * ------------------------------------------------------------------------ */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
--- a/drivers/i2c/busses/i2c-parport.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-parport.c	Mon Jan 19 15:27:44 2004
@@ -24,6 +24,11 @@
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * ------------------------------------------------------------------------ */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -162,7 +167,7 @@
 	}
 	memset(adapter, 0x00, sizeof(struct i2c_par));
 
-	printk(KERN_DEBUG "i2c-parport: attaching to %s\n", port->name);
+	pr_debug("i2c-parport: attaching to %s\n", port->name);
 	adapter->pdev = parport_register_device(port, "i2c-parport",
 		NULL, NULL, NULL, PARPORT_FLAG_EXCL, NULL);
 	if (!adapter->pdev) {
diff -Nru a/drivers/i2c/busses/i2c-philips-par.c b/drivers/i2c/busses/i2c-philips-par.c
--- a/drivers/i2c/busses/i2c-philips-par.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-philips-par.c	Mon Jan 19 15:27:44 2004
@@ -23,6 +23,11 @@
 
 /* $Id: i2c-philips-par.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -158,7 +163,7 @@
 	}
 	memset (adapter, 0x00, sizeof(struct i2c_par));
 
-	/* printk(KERN_DEBUG "i2c-philips-par.o: attaching to %s\n", port->name); */
+	/* pr_debug("i2c-philips-par: attaching to %s\n", port->name); */
 
 	adapter->pdev = parport_register_device(port, "i2c-philips-par",
 						NULL, NULL, NULL, 
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon Jan 19 15:27:44 2004
@@ -28,7 +28,10 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-prosavage.c	Mon Jan 19 15:27:44 2004
@@ -54,6 +54,11 @@
  *    (Additional documentation needed :(
  */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-rpx.c b/drivers/i2c/busses/i2c-rpx.c
--- a/drivers/i2c/busses/i2c-rpx.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-rpx.c	Mon Jan 19 15:27:44 2004
@@ -11,6 +11,11 @@
  * changed to eliminate RPXLite references.
  */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -82,7 +87,7 @@
 	rpx_iic_init(&rpx_data);
 
 	if (i2c_8xx_add_bus(&rpx_ops) < 0) {
-		printk("i2c-rpx: Unable to register with I2C\n");
+		printk(KERN_ERR "i2c-rpx: Unable to register with I2C\n");
 		return -ENODEV;
 	}
 
diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-savage4.c	Mon Jan 19 15:27:44 2004
@@ -29,6 +29,11 @@
    it easier to add later.
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-sis5595.c	Mon Jan 19 15:27:44 2004
@@ -55,7 +55,10 @@
  * Add adapter resets
  */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -311,13 +314,12 @@
 		break;
 /*
 	case I2C_SMBUS_BLOCK_DATA:
-		printk("sis5595.o: Block data not yet implemented!\n");
+		printk(KERN_WARNING "sis5595.o: Block data not yet implemented!\n");
 		return -1;
 		break;
 */
 	default:
-		printk
-		    (KERN_WARNING "sis5595.o: Unsupported transaction %d\n", size);
+		printk(KERN_WARNING "sis5595.o: Unsupported transaction %d\n", size);
 		return -1;
 	}
 
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-sis630.c	Mon Jan 19 15:27:44 2004
@@ -48,7 +48,10 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-/* #define DEBUG 1 */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-sis96x.c	Mon Jan 19 15:27:44 2004
@@ -32,7 +32,10 @@
     We assume there can only be one SiS96x with one SMBus interface.
 */
 
-/* #define DEBUG */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/module.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-velleman.c b/drivers/i2c/busses/i2c-velleman.c
--- a/drivers/i2c/busses/i2c-velleman.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-velleman.c	Mon Jan 19 15:27:44 2004
@@ -20,6 +20,11 @@
 
 /* $Id: i2c-velleman.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -29,11 +34,6 @@
 #include <linux/i2c-algo-bit.h>
 #include <asm/io.h>
 
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)		/* should be reasonable open, close &c. 	*/
-#define DEB2(x) 	/* low level debugging - very slow 		*/
-#define DEBE(x)	x	/* error messages 				*/
-
 					/* Pin Port  Inverted	name	*/
 #define I2C_SDA		0x02		/*  ctrl bit 1 	(inv)	*/
 #define I2C_SCL		0x08		/*  ctrl bit 3 	(inv)	*/
@@ -140,7 +140,7 @@
 			return -ENODEV;
 		}
 	}
-	printk(KERN_DEBUG "i2c-velleman: found device at %#x.\n",base);
+	pr_debug("i2c-velleman: found device at %#x.\n",base);
 	return 0;
 }
 
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-via.c	Mon Jan 19 15:27:44 2004
@@ -21,7 +21,10 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* #define DEBUG */
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-viapro.c	Mon Jan 19 15:27:44 2004
@@ -33,6 +33,11 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/i2c-voodoo3.c	Mon Jan 19 15:27:44 2004
@@ -27,6 +27,11 @@
 /* This interfaces to the I2C bus of the Voodoo3 to gain access to
     the BT869 and possibly other I2C devices. */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/scx200_acb.c	Mon Jan 19 15:27:44 2004
@@ -25,6 +25,11 @@
 */
 
 #include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -373,7 +378,7 @@
 	    	data->word = le16_to_cpu(cur_word);
 
 #ifdef DEBUG
-	printk(KERN_DEBUG NAME ": transfer done, result: %d", rc);
+	DBG(": transfer done, result: %d", rc);
 	if (buffer) {
 		int i;
 		printk(" data:");
@@ -505,7 +510,7 @@
 	int i;
 	int rc;
 
-	printk(KERN_DEBUG NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
+	pr_debug(NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
 
 	/* Verify that this really is a SCx200 processor */
 	if (pci_find_device(PCI_VENDOR_ID_NS,
diff -Nru a/drivers/i2c/busses/scx200_i2c.c b/drivers/i2c/busses/scx200_i2c.c
--- a/drivers/i2c/busses/scx200_i2c.c	Mon Jan 19 15:27:44 2004
+++ b/drivers/i2c/busses/scx200_i2c.c	Mon Jan 19 15:27:44 2004
@@ -22,6 +22,11 @@
 */
 
 #include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -88,15 +93,14 @@
 
 int scx200_i2c_init(void)
 {
-	printk(KERN_DEBUG NAME ": NatSemi SCx200 I2C Driver\n");
+	pr_debug(NAME ": NatSemi SCx200 I2C Driver\n");
 
 	if (!scx200_gpio_present()) {
 		printk(KERN_ERR NAME ": no SCx200 gpio pins available\n");
 		return -ENODEV;
 	}
 
-	printk(KERN_DEBUG NAME ": SCL=GPIO%02u, SDA=GPIO%02u\n", 
-	       scl, sda);
+	pr_debug(NAME ": SCL=GPIO%02u, SDA=GPIO%02u\n", scl, sda);
 
 	if (scl == -1 || sda == -1 || scl == sda) {
 		printk(KERN_ERR NAME ": scl and sda must be specified\n");

