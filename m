Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbUAEFVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 00:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbUAEFVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 00:21:24 -0500
Received: from colo.lackof.org ([198.49.126.79]:29633 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S264394AbUAEFVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 00:21:01 -0500
Date: Sun, 4 Jan 2004 22:20:59 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Alessandro Rubini <rubini@ipvvis.unipv.it>
Cc: rubini@linux.it, linux-kernel@vger.kernel.org, grundler@parisc-linux.org
Subject: [PATCH] 2.4.24-pre3 obmouse driver for HP OB600 C/CT laptop
Message-ID: <20040105052059.GA612@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessandro, et al,

Over Christmas break I got obmouse driver working with XF86 4.2.x and
properly integrated into the linux-2.4 kernel tree.
HP Omnibook 600C/CT laptops are small, slow, fairly old (predate Cardbus
but have custom PCMCIA controller), very cute laptops. The "pop-up" mouse
is driven by HP proprietary silicon.

Original obmouse driver was written by Olivier Florent in 1999.
(None of his original code remains.)

Kudos to Alan Cox for writing Documentation/DocBook/mousedrivers.tmpl.
Made the conversion pretty simple (< 1 days work).  Previous obmouse
versions only worked with XF86 3.x and emulated a "microsoft" mouse.
Converting to BusMouse protocol cut a few more hundred lines
out of the driver.

A minor number needs to be officially assigned/blessed and entered
into Documentation/devices.txt.  I tested with minor number 16 and
bumped up NR_MICE in busmouse.c to 17.  Obmouse driver could share a
minor number with another "non-serial" mouse driver since the Pop-Up
mouse is a built-in device and will never conflict with say an
amigamouse or atarimouse.  Obmouse could conflict a parallel port,
serial, or ISA-bus mouse.  I was guessing the busmouse subsystem
maintainer (Alessandro Rubini) would determine what is right.

Also, one "unfixable" bug is the lack of a probe routine.
Without documentation, I have no clue if it's possible to probe for
a pop-up mouse or not. Maybe it will be obvious to someone else based
on the 4 defined registers.

XF86Config-4 file and prebuilt 2.4.24-preX kernel bits suitable for
OB600CT (486, 75Mhz, 24MB RAM) are available from:
	ftp://gsyprf10.external.hp.com/kernels/ob600/

(prerelease versions of ob600_ss.c PCMCIA driver are also available there.
 Michael Teske got it working on his OB600C with a 2.2 kernel; I'm not
 able to reproduce his success on the OB600CT I've got.)

diffstat says:
 Documentation/Configure.help |    9 +
 drivers/char/Config.in       |    1 
 drivers/char/Makefile        |    1 
 drivers/char/busmouse.c      |    2 
 drivers/char/obmouse.c       |  354 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 366 insertions(+), 1 deletion(-)

thanks,
grant


diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/Documentation/Configure.help ob600-linux-2.4/Documentation/Configure.help
--- linux-2.4/Documentation/Configure.help	Sun Jan  4 18:22:45 2004
+++ ob600-linux-2.4/Documentation/Configure.help	Sun Jan  4 17:18:28 2004
@@ -19234,6 +19234,15 @@
   say M here and read <file:Documentation/modules.txt>.  The module
   will be called pc110pad.o.
 
+HP OB600 C/CT Pop-Up Mouse
+CONFIG_OBMOUSE
+  Only add this driver if you have an Omnibook 600C or 600CT laptop.
+  This driver has no probe routine and must assume ports 0x238-23b
+  belong to the Pop-Up mouse. Depends on BUSMOUSE.
+
+  Best is to use a module and load the obmouse driver at runtime.
+  Say M here and read <file:Documentation/modules.txt>.
+
 Microsoft busmouse support
 CONFIG_MS_BUSMOUSE
   These animals (also called Inport mice) are connected to an
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/drivers/char/Config.in ob600-linux-2.4/drivers/char/Config.in
--- linux-2.4/drivers/char/Config.in	Sun Jan  4 18:23:06 2004
+++ ob600-linux-2.4/drivers/char/Config.in	Sun Jan  4 17:18:57 2004
@@ -197,6 +197,7 @@
    dep_tristate '  ATIXL busmouse support' CONFIG_ATIXL_BUSMOUSE $CONFIG_BUSMOUSE
    dep_tristate '  Logitech busmouse support' CONFIG_LOGIBUSMOUSE $CONFIG_BUSMOUSE
    dep_tristate '  Microsoft busmouse support' CONFIG_MS_BUSMOUSE $CONFIG_BUSMOUSE
+   dep_tristate '  HP OB600 popup mouse support' CONFIG_OBMOUSE $CONFIG_BUSMOUSE
    if [ "$CONFIG_ADB" = "y" -a "$CONFIG_ADB_KEYBOARD" = "y" ]; then
       dep_tristate '  Apple Desktop Bus mouse support (old driver)' CONFIG_ADBMOUSE $CONFIG_BUSMOUSE
    fi
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/drivers/char/Makefile ob600-linux-2.4/drivers/char/Makefile
--- linux-2.4/drivers/char/Makefile	Sun Jan  4 18:23:06 2004
+++ ob600-linux-2.4/drivers/char/Makefile	Sun Jan  4 17:18:57 2004
@@ -226,6 +226,7 @@
 
 obj-$(CONFIG_ATIXL_BUSMOUSE) += atixlmouse.o
 obj-$(CONFIG_LOGIBUSMOUSE) += logibusmouse.o
+obj-$(CONFIG_OBMOUSE) += obmouse.o
 obj-$(CONFIG_PRINTER) += lp.o
 obj-$(CONFIG_TIPAR) += tipar.o
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/drivers/char/busmouse.c ob600-linux-2.4/drivers/char/busmouse.c
--- linux-2.4/drivers/char/busmouse.c	Sun Jan  4 18:23:06 2004
+++ ob600-linux-2.4/drivers/char/busmouse.c	Sun Jan  4 17:18:57 2004
@@ -49,7 +49,7 @@
 	int			dypos;
 };
 
-#define NR_MICE			15
+#define NR_MICE			17
 #define FIRST_MOUSE		0
 #define DEV_TO_MOUSE(dev)	MINOR_TO_MOUSE(MINOR(dev))
 #define MINOR_TO_MOUSE(minor)	((minor) - FIRST_MOUSE)
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.4/drivers/char/obmouse.c ob600-linux-2.4/drivers/char/obmouse.c
--- linux-2.4/drivers/char/obmouse.c	Wed Dec 31 16:00:00 1969
+++ ob600-linux-2.4/drivers/char/obmouse.c	Sun Jan  4 17:18:58 2004
@@ -0,0 +1,354 @@
+/* obmouse.c -- HP omnibook 600C/CT pop-up mouse driver
+ *
+ *  Copyright (C) 1999 Olivier Florent
+ *  Copyright (C) 1999 Chuck Slivkoff <chuck_slivkoff_AT_hp.com>
+ *  Copyright (C) 1999-2004 Grant Grundler <grundler_at_parisc-linux.org>
+ *
+ * OB600C/CT mouse can be compared to a tablet, as absolute coordinates
+ * are given by the hardware.  This driver emulates a basic serial mouse
+ * protocol by translating absolute coordinates to relative moves.
+ * This works with gpm -t pnp and Xfree86 as a standard Micro$oft mouse.
+ *
+ * FIXME:  This driver lacks a detection routine.
+ *         i.e you must know that you have a 600C/CT before using it.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *  
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *  
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *  
+ *
+ * 0.6	2 January 2004      grant
+ *	converted to busmouse
+ *
+ * 0.5	27 december 2003    grant
+ *	fix "built-in" code - added module_* calls
+ *
+ * 0.4	27 december 2002 grant grundler
+ *	Add MODULES_ stuff (author, license, etc)
+ *	fix read to return 0 if no change.
+ *
+ * 0.3	26 november 1999 grant grundler
+ *	removed ifdefs for EMULATE_SERIAL_MOUSE  and EMULATE_NCR_PEN.
+ *	Only support "basic serial mouse protocol (gpm -t pnp)" which
+ *	is also supported directly by Xfree.
+ *
+ *	Moved delta(x,y) calculations into ob_interrupt.
+ *	If we only get interrupts when the mouse moves,
+ *	then only need to update delta(x,y) then too.
+ *
+ * 0.2	22 november 1999, grant grundler
+ *	"man 4 mouse" explains really well how PNP mouse works. Read it.
+ *
+ *	Fixed algorithm which generated delta(x,y) from current-last
+ *	position reported. Now handles "roll-over" properly and
+ *	speed scales _inversely_ (ie bigger number is slower).
+ *	"speed" parameter can be set with "insmod obmouse speed=5" (default).
+ *
+ * 0.1a	16 november 1999, charles_slivkoff_at_hp.com
+ *	File did not compile as received.
+ *	Modified ob_write,ob_read parameters to match 2.2.x kernel.
+ *	Added uaccess.h. Tried to fix ob_interrupt.
+ *
+ * 0.1	17 february 1999, olivier_florent_AT_hp.com
+ *	original author.
+ */
+
+#include <linux/module.h>
+
+#include <linux/errno.h>
+#include <linux/kmod.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/ioport.h>
+
+#include <asm/io.h>
+#include <asm/segment.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#include "busmouse.h"
+
+#undef OBMOUSE_DEBUG		/* define to enable lots of printf */
+#undef EMULATE_BUSMOUSE
+
+/* name of the device */
+#define OBMOUSE_DEV_NAME "obmouse"
+#define OBMOUSE_REV "v0.6"
+
+
+/*
+** "speed" of the mouse. Determines how "fast" the mouse "moves".
+** Similar (but not the same) as acceleration. Using slower acceleration
+** together with lower speed value might result in better mouse control.
+** I've only used the default acceleration.
+*/
+int speed = 4;	/* my personal preference */
+
+/*
+** OB 600 mouse doesn't completely act like a tablet.
+** The xy-coordinates do in fact roll over which would
+** not happen on a tablet.
+*/
+#define OB_ROLL_LIMIT 0xd00
+
+/*
+** obmouse HW specific data
+*/
+#define OBMOUSE_BASE           (0x238)  /* base address of the hardware */
+#define OBMOUSE_EXTENT         (3)      /* from 0x238 to 0x23b          */
+#define OBMOUSE_IRQ            (12)     /* irq 12                       */
+
+/* The 4 high bits of OBMOUSE_INTR_CTL */
+#define OBMOUSE_BTN_IRQ_MASK   (0x10)    /* WR: enable/disable button irq   */
+#define OBMOUSE_MOV_IRQ_MASK   (0x20)    /* WR: enable/disable movement irq */
+#define OBMOUSE_BUTTON1_MASK   (0x40)    /* RD: status of button 1 */
+#define OBMOUSE_BUTTON2_MASK   (0x80)    /* RD: status of button 2 */
+
+#define OBMOUSE_COORD_ONLY(v)  ((v) & 0xfff)  /* ignore high 4 bits */
+
+#define OBMOUSE_INTR_CTL   (OBMOUSE_BASE+3)
+#define OBMOUSE_INTR_BITS  (OBMOUSE_BTN_IRQ_MASK | OBMOUSE_MOV_IRQ_MASK)
+
+/* Enable/disable both button and movement interrupt */
+#define OBMOUSE_ENABLE_INTR()  outb(OBMOUSE_INTR_BITS,  OBMOUSE_INTR_CTL)
+#define OBMOUSE_DISABLE_INTR() outb(~OBMOUSE_INTR_BITS, OBMOUSE_INTR_CTL)
+
+/* Amount mouse has to move before the hardware launchs a new
+** interrupt (I think). 0x08 is the standard value.
+** Write value to OBMOUSE_BASE each time an interrupt is handled to
+** enable the next one.
+*/
+#define OBMOUSE_SENSITIVITY    (0x08)
+
+/* reset the sensitivity to enable next interrupt */
+#define OBMOUSE_ENABLE_SENSE() outb(OBMOUSE_SENSITIVITY,OBMOUSE_BASE) 
+#define OBMOUSE_DISABLE_SENSE() outb(0,OBMOUSE_BASE) 
+
+static int ob_dev;	/* busmouse # */
+
+static short lastx;	/* last reported normalized coords */
+static short lasty;
+
+static unsigned char	ob_opened ; /* 0=closed, 1=opened  */
+
+
+/*
+** Omnibook 600 mouse ISR.
+** Read the HW state and resets "SENSITIVITY" in order to re-arm
+** the interrupt.
+*/
+static void
+ob_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	short dx, dy;
+	unsigned short rawx, rawy;
+	unsigned int buttons = 2;	/* M-button never pressed */
+
+	rawx = inb(OBMOUSE_BASE+0) + (inb(OBMOUSE_BASE+1) << 8);
+	rawy = inb(OBMOUSE_BASE+2) + (inb(OBMOUSE_BASE+3) << 8);
+
+#ifdef OBMOUSE_DEBUG
+/* This printk is really useful for learning how the mouse actually behaves. */
+printk("ob_intr: %4x,%4x\n", rawx, rawy);
+#endif
+
+	/* reset the sensitivity */
+	OBMOUSE_ENABLE_SENSE();
+
+	/* ------------------------------------
+	**  update delta(x,y) values.
+	** ------------------------------------
+	*/
+
+	dx = (short) rawx - lastx ;
+	dy = (short) OBMOUSE_COORD_ONLY(rawy) - lasty ;
+
+	lastx = (short) rawx;
+	lasty = (short) OBMOUSE_COORD_ONLY(rawy);
+
+	/*
+	** determine if the reading "rolled" over.
+	** Not fool-proof but should be good enough.
+	*/
+	if (dx > OB_ROLL_LIMIT) {
+		/* 0xf80 - 0x80 = 0xf00 (and we want 0x100) */
+		dx = 0x1000 - dx;
+	} else if (-dx > OB_ROLL_LIMIT) {
+		/*
+		** 0x80 - 0xf80 = -0xf00 (and we want -0x100)
+		** -0x1000 - (-0xf00) = -0x1000 + 0xf00 = -0x100
+		*/
+		dx = -0x1000 - dx;
+	}
+
+	/* Same story with the Y-coordinate */	
+	if (dy > OB_ROLL_LIMIT) {
+		dy = 0x1000 - dy;
+	} else if (-dy > OB_ROLL_LIMIT) {
+		dy = -0x1000 - dy;
+	}
+
+	dx /= speed;	/* scale */
+	dy /= speed;
+
+	/* BusMouse wants xxxxxLMR.  we only have L and M */
+	buttons |=  (rawy >> 13) & 4;	/* set L */
+	buttons |= (rawy >> 14) & 1;	/* set R */
+
+	/*
+	** ob600 mouse thinks {0,0} is the "top right corner".
+	** bus mouse wants it in bottom left corner.
+	*/
+        busmouse_add_movementbuttons(ob_dev, -dx, -dy, buttons);
+}
+
+
+static int
+ob_open(struct inode *inode, struct file *file)
+{
+	/* device is already opened */
+	if (ob_opened)
+		return -EBUSY;
+
+#ifdef OBMOUSE_DEBUG
+printk(OBMOUSE_DEV_NAME ": attempt request irq %d\n",OBMOUSE_IRQ);
+#endif
+
+	/* Try to get the interrupt */
+	if (request_irq(OBMOUSE_IRQ,ob_interrupt,0,OBMOUSE_DEV_NAME,NULL)) {
+		printk (OBMOUSE_DEV_NAME ": request_irq failed for %d\n",OBMOUSE_IRQ);
+		return -EBUSY;
+	}
+
+#ifdef OBMOUSE_DEBUG
+printk(OBMOUSE_DEV_NAME ": irq %d registered\n",OBMOUSE_IRQ);
+#endif
+
+	OBMOUSE_ENABLE_INTR() ;
+	OBMOUSE_ENABLE_SENSE() ;
+
+	MOD_INC_USE_COUNT;
+	ob_opened = 1 ;
+	return 0;
+}
+
+
+/*
+ * obmouse close/release function
+ */
+static int
+ob_release(struct inode *inode, struct file *file)
+{
+	/* device has never been opened */
+	if (!ob_opened)
+		return -ENODEV;
+
+	OBMOUSE_DISABLE_INTR() ;
+
+	free_irq(OBMOUSE_IRQ,NULL);
+
+	MOD_DEC_USE_COUNT;
+	ob_opened = 0 ;
+
+	return 0;
+}
+
+
+#ifndef MODULE
+static int __init obmouse_setup(char *str)
+{
+	int ints[4];
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+	if (ints[0] > 0)
+		speed=ints[1];
+
+	return 1;
+}
+
+__setup("speed=", obmouse_setup);
+#endif /* !MODULE */
+
+#define OBMOUSE_MINOR	16
+
+static struct busmouse ob600_busmouse = {
+        .minor = OBMOUSE_MINOR,
+	.name  = OBMOUSE_DEV_NAME,
+	.owner = THIS_MODULE,
+	.open  = ob_open,
+	.release = ob_release,
+	.init_button_state = 7	/* LMR-buttons are not pressed */
+};
+
+
+static int obmouse_init(void)
+{
+	unsigned int buttons;
+
+	/* Get the IO Port region first */
+	if (request_region(OBMOUSE_BASE,OBMOUSE_EXTENT,OBMOUSE_DEV_NAME) < 0) {
+		printk(KERN_ERR OBMOUSE_DEV_NAME ": IO Port 0x%d not available!\n", OBMOUSE_BASE);
+		return -ENODEV;
+
+	}
+
+	OBMOUSE_DISABLE_INTR() ;
+	OBMOUSE_DISABLE_SENSE() ;
+
+	/* setup initial X,Y and button state */
+	lastx = inb(OBMOUSE_BASE+0) + (inb(OBMOUSE_BASE+1) << 8);
+	lasty = inb(OBMOUSE_BASE+2) + (inb(OBMOUSE_BASE+3) << 8);
+
+	/* BusMouse wants xxxxxLMR.  we only have inverted L and R */
+	buttons = 2;	/* M is not pressed */
+	buttons |= (lasty >> 13) & 4;	/* set L */
+	buttons |= (lasty >> 14) & 1;	/* set R */
+	ob600_busmouse.init_button_state = buttons;
+
+	lasty = OBMOUSE_COORD_ONLY(lasty);
+
+	ob_dev = register_busmouse(&ob600_busmouse);
+	if (ob_dev < 0) {
+		printk(KERN_ERR OBMOUSE_DEV_NAME ": cannot register ob600 busmouse.\n");
+		release_region(OBMOUSE_BASE,OBMOUSE_EXTENT);
+	} else {
+		printk(OBMOUSE_DEV_NAME ": " OBMOUSE_REV \
+			" HP omnibook 600C/CT pop-up mouse (0x%x, IRQ %d), Grant Grundler\n",
+			OBMOUSE_BASE, OBMOUSE_IRQ);
+	}
+
+	return (ob_dev < 0) ? ob_dev : 0;
+}
+
+static void obmouse_exit(void)
+{
+	OBMOUSE_DISABLE_INTR() ;
+	OBMOUSE_DISABLE_SENSE() ;
+
+	unregister_busmouse(ob_dev);
+	release_region(OBMOUSE_BASE,OBMOUSE_EXTENT);
+	printk(OBMOUSE_DEV_NAME ": HP omnibook 600C/CT pop-up mouse driver closed\n");
+}
+
+module_init(obmouse_init);
+module_exit(obmouse_exit);
+
+EXPORT_NO_SYMBOLS;
+ 
+MODULE_AUTHOR("Grant Grundler <grundler_at_parisc-linux.org>");
+MODULE_DESCRIPTION("HP omnibook 600C/CT pop-up mouse");
+MODULE_PARM(speed, "i");
+MODULE_PARM_DESC(speed, "obmouse speed (not accel) control");
+MODULE_LICENSE("GPL");
