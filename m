Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbRFACsJ>; Thu, 31 May 2001 22:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbRFACrw>; Thu, 31 May 2001 22:47:52 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:26551 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S263334AbRFACrh>;
	Thu, 31 May 2001 22:47:37 -0400
Message-ID: <3B1702AB.89C0790F@sun.com>
Date: Thu, 31 May 2001 19:49:15 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@redhat.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] support for Cobalt Networks (x86 only) systems (for real this 
 time)
Content-Type: multipart/mixed;
 boundary="------------3996306720A092317236588D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3996306720A092317236588D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

apparently, LKML silently (!) bounces messages > a certain size.  So I'll
try smaller patches.  This is part 2/2 of the general Cobalt support.

Alan,

Aattached is a (large, but self contained) patch for Cobalt Networks suport
for x86 systems (RaQ3, RaQ4, Qube3, RaQXTR).  Please let me know if there
is anything that would prevent this from general inclusion in the next
release.

(patch against 2.4.5)

Thanks

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------3996306720A092317236588D
Content-Type: text/plain; charset=us-ascii;
 name="cobalt-drivers-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cobalt-drivers-2.diff"

diff -ruN dist-2.4.5/drivers/cobalt/README cobalt-2.4.5/drivers/cobalt/README
--- dist-2.4.5/drivers/cobalt/README	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/README	Thu May 31 14:32:15 2001
@@ -0,0 +1,19 @@
+Notes on Cobalt's drivers:
+
+You will notice in several places constructs such as this:
+
+	if (cobt_is_3k()) {
+		foo();
+	} else if (cobt_is_5k()) {
+		bar();
+	}
+
+The goal here is to only compile in code that is needed, but to allow one to
+define support for both 3k and 5k (and more?) style systems.  The systype
+check macros are very simple and clean.  They check whether config-time
+support for the generation has been enabled, and (if so) whether systype
+detected the specified generation.  This leaves the code free from #ifdef
+cruft, but lets the compiler throw out unsupported generation-specific code
+with if (0) detection.
+
+--
diff -ruN dist-2.4.5/drivers/cobalt/ruler.c cobalt-2.4.5/drivers/cobalt/ruler.c
--- dist-2.4.5/drivers/cobalt/ruler.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/ruler.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,393 @@
+/* 
+ * cobalt ruler driver 
+ * Copyright (c) 2000, Cobalt Networks, Inc.
+ * $Id: ruler.c,v 1.10 2001/05/30 07:19:48 thockin Exp $
+ *
+ * author: asun@cobalt.com, thockin@sun.com
+ *
+ * This should be SMP safe.  There are two critical pieces of data, and thsu
+ * two locks.  The ruler_lock protects the arrays of channels(hwifs) and
+ * busproc function pointers.  These are only ever written in the
+ * register/unregister functions but read in several other places.  A
+ * read/write lock is appropriate.  The second lock is the lock on the sled
+ * led state and the I2C_DEV_RULER.  It gets called from timer context, so
+ * irqsave it. The global switches and sled_leds are atomic_t. --TPH
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/ide.h>
+#include <linux/hdreg.h>
+#include <linux/notifier.h>
+#include <linux/sysctl.h>
+#include <linux/reboot.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <asm/io.h>
+#include <linux/cobalt.h>
+#include <linux/cobalt-systype.h>
+#include <linux/cobalt-i2c.h>
+#include <linux/cobalt-acpi.h>
+#include <linux/cobalt-led.h>
+
+#define RULER_TIMEOUT		(HZ >> 1)  /* .5s */
+#define MAX_COBT_DRIVES		4
+#define LED_SLED0		(1 << 3)
+#define LED_SLED1		(1 << 2)
+#define LED_SLED2		(1 << 1)
+#define LED_SLED3		(1 << 0)
+
+/* all of this is for gen V */
+static struct timer_list cobalt_ruler_timer;
+static rwlock_t ruler_lock = RW_LOCK_UNLOCKED;
+static spinlock_t rled_lock = SPIN_LOCK_UNLOCKED;
+static ide_hwif_t *channels[MAX_COBT_DRIVES];
+static ide_busproc_t *busprocs[MAX_COBT_DRIVES];
+/* NOTE: switches is a bitmask of DETACHED sleds */
+static atomic_t switches = ATOMIC_INIT(0);	
+static atomic_t sled_leds = ATOMIC_INIT(0);
+static int sled_led_map[] = {LED_SLED0, LED_SLED1, LED_SLED2, LED_SLED3};
+static int ruler_detect;
+
+static inline u8
+read_switches(void)
+{
+	u8 state = 0;
+	if (cobt_is_5k()) {
+		int tries = 3;
+
+		/* i2c can be busy, and this can read wrong - try a few times */
+		while (tries--) {
+			state = cobalt_i2c_read_byte(COBALT_I2C_DEV_DRV_SWITCH, 
+				0);
+			if ((state & 0xf0) != 0xf0) {
+				break;
+			}
+		}
+	}
+
+	return state;
+}
+
+/*
+ * deal with sled leds: LED on means OK to remove
+ * NOTE: all the reset lines are kept high. 
+ * NOTE: the reset lines are in the reverse order of the switches. 
+ */
+static void
+set_sled_leds(u8 leds)
+{
+	if (cobt_is_5k()) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&rled_lock, flags);
+
+		atomic_set(&sled_leds, leds);
+		leds |= 0xf0;
+		cobalt_i2c_write_byte(COBALT_I2C_DEV_RULER, 0, leds);
+
+		spin_unlock_irqrestore(&rled_lock, flags);
+	}
+}
+
+static inline u8
+get_sled_leds(void)
+{
+	return atomic_read(&sled_leds);
+}
+
+/* this must be called with the ruler_lock held for read */
+static int
+do_busproc(int idx, ide_hwif_t *hwif, int arg)
+{
+	if (cobt_is_5k()) {
+		/* sed sled LEDs */
+		switch (arg) {
+			case BUSSTATE_ON:
+				set_sled_leds(get_sled_leds() & 
+					~sled_led_map[idx]);
+				break;
+			case BUSSTATE_OFF:
+			case BUSSTATE_TRISTATE:
+				set_sled_leds(get_sled_leds() | 
+					sled_led_map[idx]);
+				break;
+			default:
+				WPRINTK("unknown busproc argument (%d)\n", arg);
+		}
+	}
+
+	/* do the real work */
+	return busprocs[idx](hwif, arg);
+}
+
+static void 
+ruler_timer_fn(unsigned long data)
+{
+	if (cobt_is_5k()) {
+		u8 state;
+		int i;
+		unsigned int now, expected, bit, swcur;
+
+		state = read_switches();
+		if ((state & 0xf0) == 0xf0) {
+			return;
+		}
+		swcur = atomic_read(&switches);
+	
+		state &= 0xf;
+		read_lock(&ruler_lock);
+		for (i = 0; i < MAX_COBT_DRIVES; i++) {
+		  	bit = 1 << i;
+			now = state & bit;
+			expected = swcur & bit;
+			if (now == expected) {
+				/* no changes to worry about */
+				continue;
+			}
+
+		  	if (now) {
+				/* a freshly detached drive */
+				atomic_set(&switches, swcur | bit);
+		    		if (channels[i]) {
+					printk("disabling ide ruler "
+						"channel %d\n", i);
+					do_busproc(i, channels[i], 
+						BUSSTATE_TRISTATE);
+		    		} else {
+					WPRINTK("drive detach on bad "
+						"channel (%d)\n", i);
+				}
+				set_sled_leds(get_sled_leds() | 
+					sled_led_map[i]);
+		  	} else {
+				/* 
+				 * do we want to do anything when a re-attach 
+				 * is detected?
+				 */
+			}
+		}
+		read_unlock(&ruler_lock);
+	}
+}
+
+static void 
+ruler_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	if (cobt_is_5k() && ruler_detect) {
+		u8 state;
+
+		state = read_switches();
+		if ((state & 0xf0) != 0xf0) {
+			/* this is protected inside mod_timer */
+			mod_timer(&cobalt_ruler_timer, jiffies + RULER_TIMEOUT);
+		}
+		 
+		/* empirical: delay enough to debounce */
+		udelay(10);
+	}
+}
+
+#if defined(CONFIG_COBALT_LED)
+/* figure which LEDs to blink */
+static unsigned int
+ide_led_handler(void *data)
+{
+	unsigned int leds = 0;
+
+	if (cobt_is_5k()) {
+		int i;
+		static int ledmap[MAX_COBT_DRIVES] = { 
+			LED_DISK0, LED_DISK1, LED_DISK2, LED_DISK3
+		};
+		static unsigned long old[MAX_COBT_DRIVES];
+
+		read_lock(&ruler_lock);
+
+		for (i = 0; i < MAX_COBT_DRIVES; i++) {
+			if (channels[i] && channels[i]->drives[0].present 
+			 && channels[i]->drives[0].service_start != old[i]) {
+				leds |= ledmap[i];
+				old[i] = channels[i]->drives[0].service_start;
+			}
+		}
+
+		read_unlock(&ruler_lock);
+	}
+
+	return leds;
+}
+#endif
+
+/* this is essentially an exported function - it is in the hwif structs */
+static int
+ruler_busproc_fn(ide_hwif_t *hwif, int arg)
+{
+	int r = 0;
+
+	if (cobt_is_5k()) {
+		int idx;
+
+		read_lock(&ruler_lock);
+
+		for (idx = 0; idx < MAX_COBT_DRIVES; idx++) {
+			if (channels[idx] == hwif) {
+				break;
+			}
+		}
+
+		if (idx >= MAX_COBT_DRIVES) {
+			/* not a hwif we manage? */
+			return 0;
+		}
+
+		r = do_busproc(idx, hwif, arg);
+	
+		read_unlock(&ruler_lock);
+	
+	}
+
+	return r;
+}
+	
+/* 
+ * We try to be VERY explicit here.  Fine for now, may eventually break down.
+ */
+void 
+cobalt_ruler_register(ide_hwif_t *hwif)
+{
+	if (cobt_is_5k()) {
+		struct pci_dev *dev;
+		int idx;
+		unsigned long flags;
+
+		if (!hwif) {
+			return;
+		}
+
+		/* Cobalt rulers only have HPT370 controllers on bus 1 */
+		dev = hwif->pci_dev;
+		if (dev->vendor != PCI_VENDOR_ID_TTI
+		 || dev->device != PCI_DEVICE_ID_TTI_HPT366
+		 || dev->bus->number != 1) {
+			/* ignore it */
+			return;
+		}
+
+		/* IDE ruler has controllers at dev 3 and 4, ONLY */
+		if (dev->devfn == PCI_DEVFN(3,0)) {
+			idx = hwif->channel;
+		} else if (dev->devfn == PCI_DEVFN(4,0)) {
+			idx = 2 + hwif->channel;
+		} else {
+			return;
+		}
+
+		if (idx >= MAX_COBT_DRIVES) {
+		       return;
+		}
+
+		write_lock_irqsave(&ruler_lock, flags);
+
+		/* save a pointer to the hwif, and trap it's busproc() */
+		channels[idx] = hwif;
+		if (hwif->busproc) {
+			busprocs[idx] = hwif->busproc;
+			hwif->busproc = ruler_busproc_fn;
+		}
+
+		write_unlock_irqrestore(&ruler_lock, flags);
+
+		/* the associated switch should be closed */
+		if (hwif->drives[0].present) {
+			/* set the sled LED off - not safe to remove */
+			set_sled_leds(get_sled_leds() & ~sled_led_map[idx]);
+		}
+	}
+}
+
+void 
+cobalt_ruler_unregister(ide_hwif_t *hwif)
+{
+	if (cobt_is_5k()) {
+		int i;
+		unsigned long flags;
+
+		write_lock_irqsave(&ruler_lock, flags);
+
+		for (i = 0; i < MAX_COBT_DRIVES; i++) {
+			if (channels[i] == hwif) {
+				channels[i] = NULL;
+				hwif->busproc = busprocs[i];
+				busprocs[i] = NULL;
+			}
+		}
+
+		write_unlock_irqrestore(&ruler_lock, flags);
+	}
+}
+
+void 
+cobalt_ruler_powerdown(void)
+{
+	if (cobt_is_5k()) {
+		unsigned long flags;
+		spin_lock_irqsave(&rled_lock, flags);
+		cobalt_i2c_write_byte(COBALT_I2C_DEV_RULER, 0, 0x0);
+		atomic_set(&sled_leds, 0);
+		spin_unlock_irqrestore(&rled_lock, flags);
+	}
+}
+
+int __init 
+cobalt_ruler_init(void)
+{
+	if (cobt_is_5k()) {
+		int err;
+		u8 tmp;
+
+		/* initialize switches */
+		tmp = read_switches();
+		ruler_detect = ((tmp & 0xf0) == 0xf0) ? 0 : 1;
+		tmp &= 0xf;
+		atomic_set(&switches, tmp);
+
+		/* initialize space for hwif variables */
+		memset(channels, 0, sizeof(channels));
+
+		/* initialize our timer */
+		init_timer(&cobalt_ruler_timer);
+		cobalt_ruler_timer.function = ruler_timer_fn;
+	
+		/* register an interrupt handler */
+		err = cobalt_acpi_register_handler(ruler_interrupt);
+		if (err) {
+			EPRINTK("can't register interrupt handler %p\n", 
+				ruler_interrupt);
+		}
+
+		/* set initial sled LED state */
+		set_sled_leds(LED_SLED0 | LED_SLED1 | LED_SLED2 | LED_SLED3);
+
+		/* register for a blinky LEDs callback */
+#if defined(CONFIG_COBALT_LED)
+		err = cobalt_fpled_register(ide_led_handler, NULL);
+		if (err) {
+			EPRINTK("can't register LED handler %p\n", 
+				ide_led_handler);
+		}
+#endif
+	
+		printk(KERN_INFO "Cobalt Networks ruler driver v1.2\n");
+	}
+
+	return 0;
+}
diff -ruN dist-2.4.5/drivers/cobalt/serialnum.c cobalt-2.4.5/drivers/cobalt/serialnum.c
--- dist-2.4.5/drivers/cobalt/serialnum.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/serialnum.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,476 @@
+/* $Id: serialnum.c,v 1.4 2001/05/30 07:19:48 thockin Exp $ */
+/*
+ *
+ *   Author: Philip Gladstone, Axent Technologies
+ *           modified for Nat Semi PC[89]7317 by asun@cobalt.com
+ *           ported to 2.4.x by thockin@sun.com
+ *   Copyright (c) 2000  Axent Technologies, Cobalt Networks
+ *   Copyright (c) 2001  Axent Technologies, Sun Microsystems
+ *
+ *   This module interrogates the DS2401 Silicon Serial Number chip
+ *   that is attached to all x86 Cobalt systems.
+ *
+ *   It exports /proc/cobalt/hostid which is four bytes generated from of 
+ *   the id. It can be linked to /var/adm/hostid or /etc/hostid for the 
+ *   hostid command to use.
+ *
+ *   It exports /proc/cobalt/serialnumber which is the entire 64 bit value 
+ *   read back (in ascii).
+ *
+ *   For the guts of the 1 wire protocol used herein, please see the DS2401
+ *   specification.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * This driver is SMP safe by nature. --TPH
+ */
+#include <linux/config.h>
+#ifdef CONFIG_COBALT_SERNUM
+
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <linux/delay.h>
+#include <asm/uaccess.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <linux/cobalt.h>
+#include <linux/cobalt-systype.h>
+#include <linux/cobalt-superio.h>
+#include <linux/cobalt-serialnum.h>
+
+/* dependent on systype */
+static unsigned int sn_direction;
+static unsigned int sn_output;
+static unsigned int sn_input;
+static unsigned int sn_mask;
+
+/* 3k style systems */
+#define III_SN_DIRECTION	0x7d
+#define III_SN_OUTPUT		0x7e
+#define III_SN_INPUT		0x7f
+#define III_SN_MASK		0x08
+static struct pci_dev *id_dev;
+
+/* 5k style systems */
+#define V_SN_DIRECTION		(sn_io_base + 0x01)
+#define V_SN_OUTPUT		(sn_io_base + 0x00)
+#define V_SN_INPUT		(sn_io_base + 0x00)
+#define V_SN_MASK		(sn_io_base + 0x01)
+static unsigned int sn_io_base;
+
+#define SSN_SIZE     8	/* bytes */
+static char ssn_string[SSN_SIZE * 2 + 1];
+static unsigned long hostid;
+static int debug;
+#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_COBALT_OLDPROC
+static struct proc_dir_entry *proc_hostid;
+static struct proc_dir_entry *proc_serialnum;
+#endif
+static struct proc_dir_entry *proc_chostid;
+static struct proc_dir_entry *proc_cserialnum;
+#endif
+
+static int
+hostid_read(char *buf, char **start, off_t pos, int len, int *eof, void *x)
+{
+	int plen = sizeof(hostid);
+
+	if (pos >= plen) {
+		*eof = 1;
+		return 0;
+	}
+
+	memcpy(buf, &hostid, sizeof(hostid));
+	*start = buf + pos;
+	plen -= pos;
+
+	if (len > plen) {
+		return plen;
+	} else {
+		return len;
+	}
+}
+
+static int
+serialnum_read(char *buf, char **start, off_t pos, int len, int *eof, void *x)
+{
+	int plen = sizeof(ssn_string);
+
+	if (pos >= plen+1) {
+		*eof = 1;
+		return 0;
+	}
+
+	sprintf(buf, "%s\n", ssn_string);
+	*start = buf + pos;
+	plen -= pos;
+
+	if (len > plen) {
+		return plen;
+	} else {
+		return len;
+	}
+}
+
+/* set up the requisite IO bits */
+static int __init 
+io_init(void)
+{
+	unsigned char data;
+
+	if (cobt_is_3k()) {
+		/* The GPIO tied to the ID chip is on the PMU */
+		id_dev = pci_find_device(PCI_VENDOR_ID_AL, 
+			PCI_DEVICE_ID_AL_M7101, NULL);
+		if (!id_dev) {
+			EPRINTK("can't find PMU for serialnumber access\n");
+			return -ENXIO;
+		}
+
+		/* Set input mode on GPIO3 */
+		pci_read_config_byte(id_dev, sn_direction, &data);
+		if (debug > 1) {
+			WPRINTK("read of register 0x%x = 0x%x\n",
+				sn_direction, data);
+		}
+		if (data & sn_mask) {
+			pci_write_config_byte(id_dev, sn_direction, 
+				data & ~sn_mask);
+		}
+
+		/* Set the output value to be 0 */
+		pci_read_config_byte(id_dev, sn_output, &data);
+		if (debug > 1) {
+			WPRINTK("read of register 0x%x = 0x%x\n",
+				sn_output, data);
+		}
+		if (data & sn_mask) {
+			pci_write_config_byte(id_dev, sn_output, 
+				data & ~sn_mask);
+		}
+	} else if (cobt_is_5k()) {
+		u16 addr;
+		unsigned long flags;
+
+		spin_lock_irqsave(&cobalt_superio_lock, flags);
+		outb(SUPERIO_LOGICAL_DEV, SUPERIO_INDEX_PORT);
+		outb(SUPERIO_DEV_GPIO, SUPERIO_DATA_PORT);
+		outb(SUPERIO_ADDR_HIGH, SUPERIO_INDEX_PORT);
+		addr = inb(SUPERIO_DATA_PORT) << 8;
+		outb(SUPERIO_ADDR_LOW, SUPERIO_INDEX_PORT);
+		addr |= inb(SUPERIO_DATA_PORT);
+		spin_unlock_irqrestore(&cobalt_superio_lock, flags);
+		if (addr) {
+			u8 val;
+
+			sn_io_base = addr;
+
+			/* set output value to 0 */
+			val = inb(sn_direction);
+			outb(val | sn_mask, sn_direction);
+			data = inb(sn_output);
+			if (data & sn_mask) {
+				outb(data & ~sn_mask, sn_output);
+			}
+			/* set to input */
+			outb(val & ~sn_mask, sn_direction);
+		}
+	} else {
+		return -ENXIO;
+	}
+
+	/* Let things calm down */
+	udelay(500);
+	return 0;
+}
+
+/* write out a bit */
+static void __init
+io_write(int delay)
+{
+	if (cobt_is_3k()) {
+		unsigned char data;
+		/* Set output mode on GPIO3 */
+		pci_read_config_byte(id_dev, sn_direction, &data);
+		pci_write_config_byte(id_dev, sn_direction, data | sn_mask);
+		udelay(delay);
+
+		/* Set input mode */
+		pci_write_config_byte(id_dev, sn_direction, data & ~sn_mask);
+	} else if (cobt_is_5k()) {
+		unsigned char direction;
+
+		/* change to output and back */
+		direction = inb(sn_direction); 
+		outb(direction | sn_mask, sn_direction);
+		udelay(delay);
+		outb(direction & ~sn_mask, sn_direction);
+	}
+}
+
+/* read in a bit */
+static int __init
+io_read(void)
+{
+	unsigned char data = 0;
+
+	/* Get the input value */
+	if (cobt_is_3k()) {
+		pci_read_config_byte(id_dev, sn_input, &data);
+	} else if (cobt_is_5k()) {
+		data = inb(sn_input);
+	}
+
+	return (data & sn_mask) ? 1 : 0;
+}
+
+static void __init
+io_write_byte(unsigned char c)
+{
+	int i;
+	unsigned long flags;
+
+	save_flags(flags);
+
+	for (i = 0; i < 8; i++, c >>= 1) {
+		cli();
+		if (c & 1) {
+			/* Transmit a 1 */
+			io_write(5);
+			udelay(80);
+		} else {
+			/* Transmit a 0 */
+			io_write(80);
+			udelay(10);
+		}
+		restore_flags(flags);
+	}
+}
+
+static int __init
+io_read_byte(void)
+{
+	int i;
+	int c = 0;
+	unsigned long flags;
+
+	save_flags(flags);
+
+	for (i = 0; i < 8; i++) {
+		cli();
+		io_write(1);	/* Start the read */
+		udelay(2);
+		if (io_read()) {
+			c |= 1 << i;
+		}
+		udelay(60);
+		restore_flags(flags);
+	}
+
+	return c;
+}
+
+static int __init
+get_ssn(unsigned char *buf)
+{
+	int i;
+	unsigned long flags;
+
+	save_flags(flags);
+	cli();
+
+	/* Master Reset Pulse */
+	for (i = 0; i < 600; i += 30) {
+		if (io_read()) {
+			break;
+		}
+	}
+
+	if (i >= 600) {
+		if (debug) {
+			EPRINTK("the data line seems to be held low\n");
+		}
+		return -ENXIO;
+	}
+
+	io_write(600);
+
+	for (i = 0; i < 300; i += 15) {
+		udelay(15);
+		if (io_read() == 0) {
+			/* We got a presence pulse */
+			udelay(600);	/* Wait for things to quiet down */
+			break;
+		}
+	}
+	restore_flags(flags);
+
+	if (i >= 300) {
+		if (debug)
+			EPRINTK("no presence pulse detected\n");
+		return -ENXIO;
+	}
+
+	io_write_byte(0x33);
+
+	for (i = 0; i < 8; i++) {
+		int rc;
+
+		rc = io_read_byte();
+		if (rc < 0) {
+			return rc;
+		}
+
+		*buf++ = rc;
+	}
+
+	return 0;
+}
+
+int __init
+cobalt_serialnum_init(void)
+{
+	char *version;
+	char vstring[32];
+	unsigned char ssn[SSN_SIZE];
+	int rc;
+	int i;
+
+	/* pick proper variables */
+	if (cobt_is_3k()) {
+		sn_direction = III_SN_DIRECTION;
+		sn_output = III_SN_OUTPUT;
+		sn_input = III_SN_INPUT;
+		sn_mask = III_SN_MASK;
+	} else if (cobt_is_5k()) {
+		sn_direction = V_SN_DIRECTION;
+		sn_output = V_SN_OUTPUT;
+		sn_input = V_SN_INPUT;
+		sn_mask = V_SN_MASK;
+	} else {
+		return -1;
+	}
+
+	/* get version from CVS */
+	version = strchr("$Revision: 1.4 $", ':') + 2;
+	if (version) {
+		char *p;
+
+		strncpy(vstring, version, sizeof(vstring));
+		if ((p = strchr(vstring, ' '))) {
+			*p = '\0';
+		}
+	} else {
+		strncpy(vstring, "unknown", sizeof(vstring));
+	}
+
+	/* set up for proper IO */
+	rc = io_init();
+	if (rc) {
+		return rc;
+	}
+
+	/*
+	 * NOTE: the below algorithm CAN NOT be changed.  We have many systems
+	 * out there registered with the serial number AS DERIVED by this
+	 * algorithm.
+	 */
+
+	rc = get_ssn(ssn);
+	if (rc) {
+		return rc;
+	}
+
+	/* Convert to ssn_string */
+	for (i = 7; i >= 0; i--) {
+		sprintf(ssn_string + (7 - i) * 2, "%02x", ssn[i]);
+	}
+
+	/* get four bytes for a pretty unique (not guaranteed) hostid */
+	hostid = *(unsigned long *)ssn ^ *(unsigned long *)(ssn+4);
+
+#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_COBALT_OLDPROC
+	proc_hostid = create_proc_read_entry("hostid", 0, NULL, 
+		hostid_read, NULL);
+	if (!proc_hostid) {
+		EPRINTK("can't create /proc/hostid\n");
+	}
+	proc_serialnum = create_proc_read_entry("serialnumber", 0, NULL,
+		serialnum_read, NULL);
+	if (!proc_serialnum) {
+		EPRINTK("can't create /proc/serialnumber\n");
+	}
+#endif
+	proc_chostid = create_proc_read_entry("hostid", 0, proc_cobalt, 
+		hostid_read, NULL);
+	if (!proc_chostid) {
+		EPRINTK("can't create /proc/cobalt/hostid\n");
+	}
+	proc_cserialnum = create_proc_read_entry("serialnumber", 0, 
+		proc_cobalt, serialnum_read, NULL);
+	if (!proc_cserialnum) {
+		EPRINTK("can't create /proc/cobalt/serialnumber\n");
+	}
+#endif
+
+	/* done */
+	printk(KERN_INFO "Cobalt Networks serial number version %s: %s\n", 
+		vstring, ssn_string);
+
+	return 0;
+}
+
+char *
+cobalt_serialnum_get(void)
+{
+	return ssn_string;
+}
+
+unsigned long
+cobalt_hostid_get(void)
+{
+	return hostid;
+}
+
+#ifdef MODULE
+MODULE_PARM(debug, "i");
+
+int
+init_module(void)
+{
+	return cobalt_serialnum_init();
+}
+
+void
+cleanup_module(void)
+{
+#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_COBALT_OLDPROC
+	remove_proc_entry("hostid", NULL);
+	remove_proc_entry("serialnumber", NULL);
+#endif
+	remove_proc_entry("hostid", proc_cobalt);
+	remove_proc_entry("serialnumber", proc_cobalt);
+#endif
+}
+#endif /* MODULE */
+
+#endif /* CONFIG_COBALT_SERNUM */
diff -ruN dist-2.4.5/drivers/cobalt/systype.c cobalt-2.4.5/drivers/cobalt/systype.c
--- dist-2.4.5/drivers/cobalt/systype.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/systype.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,141 @@
+/*
+ * $Id: systype.c,v 1.4 2001/05/30 07:19:48 thockin Exp $
+ * systype.c : routines for figuring out which Cobalt system this is
+ *
+ * Copyright 2001 Sun Microsystems, Inc.
+ *
+ * By:  Tim Hockin
+ *	Adrian Sun
+ *	Duncan Laurie
+ *
+ * This driver is SMP safe by nature. --TPH
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_COBALT
+
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+
+#include <linux/cobalt.h>
+#include <linux/cobalt-systype.h>
+
+cobt_sys_t cobt_type = COBT_UNKNOWN;
+
+#ifdef CONFIG_PROC_FS
+static struct proc_dir_entry *proc_systype;
+#endif
+static int systype_read_proc(char *buf, char **start, off_t pos, int len,
+	int *eof, void *x);
+static char *systype_str(cobt_sys_t type);
+
+int __init 
+cobalt_systype_init(void)
+{
+	static int init_done = 0;
+	struct pci_dev *pdev;
+
+	if (init_done) {
+		return 0;
+	}
+	init_done = 1;
+
+#if defined(CONFIG_COBALT_GEN_III)
+	/* board identifier for RaQ3/4 vs Qube3 is on the PMU @ 0x7f */
+	pdev = pci_find_device(PCI_VENDOR_ID_AL,
+		PCI_DEVICE_ID_AL_M7101, NULL);
+	if (pdev) {
+		/* 
+		 * check to see what board we are on
+		 * ( RaQ 3, RaQ 4, Qube 3 )
+		 */
+		unsigned char val;
+
+		/* momentarily set DOGB# to input */
+		pci_read_config_byte(pdev, 0x7d, &val);
+		pci_write_config_byte(pdev, 0x7d, val & ~0x20);
+
+		/* read the GPIO register */
+		pci_read_config_byte(pdev, 0x7f, &val);
+		/* RaQ3/4 boards have DOGB (0x20) high, 
+		 * Qube3 has DOGB low */ 
+		cobt_type = (val & 0x20) ? COBT_RAQ3 : COBT_QUBE3;
+
+		/* change DOGB back to output */
+		pci_read_config_byte(pdev, 0x7d, &val);
+		pci_write_config_byte(pdev, 0x7d, val | 0x20);
+	}
+#endif
+#if defined(CONFIG_COBALT_GEN_V)
+	/* is it a gen V ? */
+	pdev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS,
+		PCI_DEVICE_ID_SERVERWORKS_LE, NULL);
+	if (pdev) {
+		cobt_type = COBT_RAQXTR;
+	}
+#endif /* CONFIG_COBALT_GEN */
+
+#ifdef CONFIG_PROC_FS
+	proc_systype = create_proc_read_entry("systype", S_IFREG | S_IRUGO, 
+		proc_cobalt, systype_read_proc, NULL);
+	if (!proc_systype) {
+		EPRINTK("can't create /proc/cobalt/systype\n");
+	}
+#endif
+
+	printk("Cobalt system type: ");
+	if (cobt_type == COBT_UNKNOWN) {
+		printk("unknown (trouble will ensue)\n");
+		return -1;
+	} else {
+		printk("%s\n", systype_str(cobt_type));
+	}
+
+	return 0;
+}
+
+static int 
+systype_read_proc(char *buf, char **start, off_t pos, int len,
+	int *eof, void *x)
+{
+	int plen = 0;
+
+	plen += sprintf(buf+plen, "%s\n", systype_str(cobt_type));
+
+        if (pos >= plen) {
+		*eof = 1;
+		return 0;
+	}
+
+	*start = buf + pos;
+	plen -= pos;
+
+	if (len > plen) {
+		return plen;
+	} else {
+		return len;
+	}
+}
+
+static char *
+systype_str(cobt_sys_t type)
+{
+	switch (type) {
+		case COBT_RAQ3:
+			return "RaQ 3/4";
+			break;
+		case COBT_QUBE3:
+			return "Qube 3";
+			break;
+		case COBT_RAQXTR:
+			return "RaQ XTR";
+			break;
+		case COBT_UNKNOWN:
+		default:
+			return "unknown";
+			break;
+	}
+}
+#endif /* CONFIG_COBALT */
diff -ruN dist-2.4.5/drivers/cobalt/thermal.c cobalt-2.4.5/drivers/cobalt/thermal.c
--- dist-2.4.5/drivers/cobalt/thermal.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/thermal.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,144 @@
+/* $Id: thermal.c,v 1.3 2001/05/30 07:19:48 thockin Exp $
+ * Copyright (c) 2000-2001 Sun Microsystems, Inc 
+ *
+ * This is SMP safe.  The only protectable operationis a single I2C access,
+ * which gets protected by I2C.  This may change in the future with different
+ * thermal sensors. --TPH
+ */
+#include <linux/config.h>
+#ifdef CONFIG_COBALT_THERMAL
+
+#include <stdarg.h>
+#include <stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/cobalt.h>
+#include <linux/cobalt-systype.h>
+#include <linux/cobalt-i2c.h>
+#include <linux/cobalt-thermal.h>
+#include <asm/io.h>
+
+unsigned int cobalt_thermal_id_max;
+#ifdef CONFIG_PROC_FS
+static struct proc_dir_entry *proc_therm;
+#endif
+
+static char *degrees(int);
+static int thermal_read_proc(char *buf, char **start, off_t pos, int len, 
+	int *eof, void *x);
+
+int __init 
+cobalt_thermal_init(void)
+{
+	if (cobt_is_3k()) {
+		cobalt_thermal_id_max = 0; /* 3k's have 1 thermal */
+	} else if (cobt_is_5k()) {
+		cobalt_thermal_id_max = 3; /* monterey has 4 temp sensors */
+	}
+
+#ifdef CONFIG_PROC_FS
+	/* make a file in /proc */
+	proc_therm = create_proc_read_entry("thermal_sensors", S_IFREG, 
+		proc_cobalt, thermal_read_proc, NULL);
+        if (!proc_therm) {
+		EPRINTK("can't create /proc/cobalt/thermal_sensors\n");
+	}
+#endif
+
+	printk("Cobalt Networks thermal sensors v1.4\n");
+
+	return 0;
+}
+
+#define LM77_TEMP		0x0
+#define LM77_STATUS		0x1
+#define LM77_HYST		0x2
+#define LM77_CRIT		0x3
+#define LM77_LOW		0x4
+#define LM77_HIGH		0x5
+
+#ifndef min
+#define min(a,b)  ((a) < (b) ? (a) : (b))
+#endif
+
+char *
+cobalt_temp_read(unsigned int sensor)
+{
+	int tmp;
+	int val = 0;
+	int tries = 2;
+	static int last_val = 0;
+
+	if (sensor > cobalt_thermal_id_max) {
+		return NULL;
+	}
+
+	/* sometimes it reads as zero... try again */
+	while (tries--) {
+		/* LM77 returns the bytes backwards - <shrug> */
+		/* address = base + deviceid + 1 for read */
+		tmp = cobalt_i2c_read_word(COBALT_I2C_DEV_TEMP +
+			(sensor<<1) + 1, LM77_TEMP);
+		if (tmp < 0) {
+			/* read failed, return the last known value */
+			return degrees(last_val);
+		}
+
+        	val = (tmp<<8 & 0xff00) + (tmp>>8 & 0x00ff);
+		if (val) {
+			last_val = val;
+			break;
+		}
+	}
+	return degrees(val);
+}
+
+/* build a string - measured in degrees C */
+static char *
+degrees(int val)
+{
+	static char temp[16] = "unknown";
+
+	sprintf(temp, "%d", val>>4);
+	if (val & 0x0008) {
+		sprintf(temp+strlen(temp), ".5");
+	}
+	return temp;
+}
+
+static int 
+thermal_read_proc(char *buf, char **start, off_t pos, int len, 
+	int *eof, void *x)
+{
+	int i;
+	int plen = 0;
+
+	for (i = 0; i <= cobalt_thermal_id_max; i++) {
+		char *c;
+		c = cobalt_temp_read(i);
+		if (!c) {
+			continue;
+		}
+		plen += sprintf(buf+plen, "%d: %s\n", i, c);
+	}
+
+	if (pos >= plen) {
+		*eof = 1;
+		return 0;
+	}
+
+	*start = buf + pos;
+	plen -= pos;
+
+	if (len > plen) {
+		return plen;
+	} else {
+		return len;
+	}
+}
+
+#endif /* CONFIG_COBALT_THERMAL */
diff -ruN dist-2.4.5/drivers/cobalt/wdt.c cobalt-2.4.5/drivers/cobalt/wdt.c
--- dist-2.4.5/drivers/cobalt/wdt.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/wdt.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,371 @@
+/* $Id: wdt.c,v 1.8 2001/05/30 22:34:57 thockin Exp $ */
+/* 
+ * Cobalt kernel WDT timer driver
+ * Tim Hockin <thockin@cobaltnet.com>
+ * Adrian Sun <asun@cobalt.com>
+ * Chris Johnson <cjohnson@cobalt.com>
+ * Copyright (c)1999-2000, Cobalt Networks
+ * Copyright (c)2001, Sun Microsystems
+ *
+ * This should be SMP safe.  Every external function (except trigger_reboot)
+ * grabs the wdt lock.  No function in this file may call any exported
+ * function (excepting trigger_reboot).  The disable counter is an atomic, so
+ * there should be no issues there. --TPH
+ */
+#include <linux/config.h>
+#ifdef CONFIG_COBALT_WDT
+
+#include <linux/module.h>
+#include <stdarg.h>
+#include <stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/cobalt.h>
+#include <linux/cobalt-systype.h>
+#include <linux/cobalt-wdt.h>
+#include <linux/cobalt-superio.h>
+#include <asm/io.h>
+#include <asm/msr.h>
+
+#define DOGB		0x20
+#define ALI_7101_WDT	0x92
+#define ALI_WDT_ARM	0x01
+#define WDT_3K_TIMEOUT (HZ >> 4)	/* 1/16 second */
+
+#define SUPERIO_TIMEOUT  (0x01)		/* 1 minute */
+#define WDT_5K_TIMEOUT (HZ << 3)	/* 8 seconds */
+
+struct timer_list cobalt_wdt_timer;
+static unsigned long wdt_timeout;
+static unsigned long long tsc_per_wdt;
+static atomic_t cobalt_wdt_disable_count = ATOMIC_INIT(0);
+static int initialized;
+static spinlock_t wdt_lock = SPIN_LOCK_UNLOCKED;
+
+/* gen III */
+static struct pci_dev *cobalt_pmu;
+static int use_pic;
+/* gen V */
+static u16 superio_pm_port;
+
+static void do_refresh(void);
+static void do_cleardog(void);
+static void do_disable(void);
+static void do_reenable(void);
+	
+static unsigned long  __init 
+chipset_setup(void)
+{
+	if (cobt_is_3k()) {
+		/* 
+		 * Set up the PMU for 3k boards. It has a max
+		 * of a 1 second timeout. 
+		 */
+		struct pci_dev *south;
+		char tmp;
+
+		/* PMU (1543 ver A1-E) has a built-in WDT.  Set it to 1 sec */
+		cobalt_pmu = pci_find_device(PCI_VENDOR_ID_AL, 
+			PCI_DEVICE_ID_AL_M7101, NULL);
+		if (!cobalt_pmu) {
+			EPRINTK("can't find south bridge for WDT\n");
+			return 0;
+		}
+		pci_write_config_byte(cobalt_pmu, ALI_7101_WDT, 0x02);
+	
+		/* why it is called 1543, but DevId is 1533 I'll never know */
+		south = pci_find_device(PCI_VENDOR_ID_AL, 
+			PCI_DEVICE_ID_AL_M1533, NULL);
+		if (!south) {
+			EPRINTK("can't find south bridge for WDT\n");
+			use_pic = 1;
+		} else {
+		        /* reversion # is here - must match ???1001?(b)
+			 * else use PIC for WDT */
+			pci_read_config_byte(south, 0x5e, &tmp);
+			use_pic = ((tmp & 0x1e) != 0x12);
+		}
+
+		if (!use_pic) {
+			/* set DOGB GPIO pin to OUTPUT - JIC */
+			pci_read_config_byte(cobalt_pmu, 0x7d, &tmp);
+			pci_write_config_byte(cobalt_pmu, 0x7d, tmp | DOGB);
+		}
+		return WDT_3K_TIMEOUT;
+	} else if (cobt_is_5k()) {
+		unsigned long flags;
+
+		/* 
+		 * Set up the Nat. Semi SuperI/O for Monterey. It has a 
+		 * minimum of a 1 minute timeout. 
+		 */
+	
+		spin_lock_irqsave(&cobalt_superio_lock, flags);
+		
+		/* superi/o -- select pm logical device and get base address */
+		outb(SUPERIO_LOGICAL_DEV, SUPERIO_INDEX_PORT);
+		outb(SUPERIO_DEV_PM, SUPERIO_DATA_PORT);
+		outb(SUPERIO_ADDR_HIGH, SUPERIO_INDEX_PORT);
+		superio_pm_port = inb(SUPERIO_DATA_PORT) << 8;
+		outb(SUPERIO_ADDR_LOW, SUPERIO_INDEX_PORT);
+		superio_pm_port |= inb(SUPERIO_DATA_PORT); 
+		if (superio_pm_port) {
+			outb(SUPERIO_WDT_DEV, superio_pm_port);
+			outb(SUPERIO_TIMEOUT, superio_pm_port + 1); 
+		}
+	
+		spin_unlock_irqrestore(&cobalt_superio_lock, flags);
+
+		return WDT_5K_TIMEOUT;
+	}
+
+	return 0;
+}
+
+void __init 
+cobalt_wdt_init(void)
+{
+	unsigned long long start, stop;
+
+	wdt_timeout = chipset_setup();
+
+	/* figure out time */
+	rdtscll(start);
+	udelay(100);
+	rdtscll(stop);
+
+	/*
+	 * (int) (stop - start) * 10 == tsc per msec
+	 * 1000 / HZ == msec per tick
+	 * wdt_timeout == ticks per watchdog rearm
+	 */
+	tsc_per_wdt = (int) (stop - start) * 10 * (1000 * wdt_timeout / HZ);
+
+#if !defined(CONFIG_COBALT_BOOTLOADER)
+	/* set the timer going */
+	init_timer(&cobalt_wdt_timer);
+	cobalt_wdt_timer.function = cobalt_wdt_refresh;
+	cobalt_wdt_timer.data = 1;
+	cobalt_wdt_timer.expires = jiffies + wdt_timeout;
+	add_timer(&cobalt_wdt_timer);
+
+	/* the first timer tick will set it going */
+	printk("Cobalt Networks watchdog v1.4");
+	if (cobt_is_3k() && use_pic) {
+		printk(" (old revision board: using PIC controller)");
+	}
+	printk("\n");
+#endif /* BOOTLOADER */
+
+	initialized = 1;
+}
+
+static inline void
+hw_disable(void)
+{
+	if (cobt_is_3k()) {
+		char tmp;
+
+		/* read the value, disable (reset) WDT */
+		pci_read_config_byte(cobalt_pmu, ALI_7101_WDT, &tmp);
+		pci_write_config_byte(cobalt_pmu, ALI_7101_WDT, 
+			(tmp & ~ALI_WDT_ARM));
+	} else if (cobt_is_5k()) {
+		unsigned long flags;
+		spin_lock_irqsave(&cobalt_superio_lock, flags);
+		outb(SUPERIO_WDT_DEV, superio_pm_port);
+		outb(0x0, superio_pm_port + 1);
+		spin_unlock_irqrestore(&cobalt_superio_lock, flags);
+	}
+}
+
+static inline void
+hw_enable(void)
+{
+	if (cobt_is_3k()) {
+		unsigned char tmp;
+		/* read the value, disable (reset) WDT, enable WDT */
+		pci_read_config_byte(cobalt_pmu, ALI_7101_WDT, &tmp);
+		pci_write_config_byte(cobalt_pmu, ALI_7101_WDT, 
+			(tmp | ALI_WDT_ARM));
+		if (use_pic) {
+			/* transition GPIO 5 (DOGB) to arm/clear timer */
+			pci_read_config_byte(cobalt_pmu, 0x7e, &tmp);
+			pci_write_config_byte(cobalt_pmu, 0x7e, tmp ^ DOGB);
+		}
+	} else if (cobt_is_5k()) {
+		unsigned long flags;
+		spin_lock_irqsave(&cobalt_superio_lock, flags);
+		outb(SUPERIO_WDT_DEV, superio_pm_port);
+		outb(SUPERIO_TIMEOUT, superio_pm_port + 1);
+		spin_unlock_irqrestore(&cobalt_superio_lock, flags);
+	}
+}
+
+static void
+do_refresh(void)
+{
+	if (!initialized) {
+		return;
+	}
+
+	do_cleardog();
+	
+	/* re-arm the timer - this is locked in mod_timer() */
+	mod_timer(&cobalt_wdt_timer, jiffies + wdt_timeout);
+}
+
+EXPORT_SYMBOL(cobalt_wdt_refresh);
+void 
+cobalt_wdt_refresh(unsigned long refresh_timer)
+{
+	unsigned long flags;
+
+#ifdef CONFIG_COBALT_BOOTLOADER
+	return;
+#endif
+
+	spin_lock_irqsave(&wdt_lock, flags);
+	do_refresh();
+	spin_unlock_irqrestore(&wdt_lock, flags);
+}
+
+static void
+do_cleardog(void)
+{
+	static unsigned long long last_tsc = 0;
+	unsigned long long tmp;
+
+	if (!initialized || (atomic_read(&cobalt_wdt_disable_count) > 0)) {
+		return;
+	}
+
+	/* only bother if we're due */
+	rdtscll(tmp);
+	if ((int)(tmp - last_tsc) < tsc_per_wdt) {
+		return;
+	}
+
+	hw_disable();
+	hw_enable();
+
+	rdtscll(last_tsc);
+}
+
+EXPORT_SYMBOL(cobalt_wdt_cleardog);
+void 
+cobalt_wdt_cleardog(void)
+{
+	unsigned long flags;
+
+#ifdef CONFIG_COBALT_BOOTLOADER
+	return;
+#endif
+
+	spin_lock_irqsave(&wdt_lock, flags);
+	do_cleardog();
+	spin_unlock_irqrestore(&wdt_lock, flags);
+}
+
+/* 
+ * this is called from machine_restart. it should not be used on
+ * 5k machines. 
+ */
+EXPORT_SYMBOL(cobalt_wdt_trigger_reboot);
+void 
+cobalt_wdt_trigger_reboot(void)
+{
+	if (cobt_is_3k()) {
+		if (!cobalt_pmu) {
+			WPRINTK("no PMU found!\n");
+			WPRINTK("reboot not possible!\n");
+			return;
+		}
+
+#if !defined(CONFIG_COBALT_BOOTLOADER)
+		/* stop feeding it */
+		del_timer(&cobalt_wdt_timer);
+#endif
+
+		/* kiss your rear goodbye... */
+		initialized = 0;
+		hw_disable();
+		hw_enable();
+	}
+}
+
+static void
+do_disable(void)
+{
+	if (!initialized) {
+		return;
+	}
+
+	if (atomic_read(&cobalt_wdt_disable_count) == 0) {
+		atomic_inc(&cobalt_wdt_disable_count);
+		del_timer(&cobalt_wdt_timer);
+		hw_disable();
+	}
+}
+
+EXPORT_SYMBOL(cobalt_wdt_disable);
+void 
+cobalt_wdt_disable(void)
+{
+	unsigned long flags;
+
+#ifdef CONFIG_COBALT_BOOTLOADER
+	return;
+#endif
+
+	if (cobt_is_3k() && use_pic) {
+		WPRINTK("in PIC mode - cannot disable\n");
+		return;
+	}
+
+	spin_lock_irqsave(&wdt_lock, flags);
+	do_disable();
+	spin_unlock_irqrestore(&wdt_lock, flags);
+}
+
+static void
+do_reenable(void)
+{
+	int dcnt;
+
+	if (!initialized) { 
+		return;
+	}
+
+	atomic_dec(&cobalt_wdt_disable_count);
+	dcnt = atomic_read(&cobalt_wdt_disable_count);
+
+	if (dcnt == 0) {
+		do_refresh();
+	} else if (dcnt < 0) {
+		WPRINTK("too many enables\n");
+		atomic_set(&cobalt_wdt_disable_count, 0);
+	}
+}
+
+
+EXPORT_SYMBOL(cobalt_wdt_reenable);
+void 
+cobalt_wdt_reenable(void)
+{
+	unsigned long flags;
+
+#ifdef CONFIG_COBALT_BOOTLOADER
+	return;
+#endif
+
+	spin_lock_irqsave(&wdt_lock, flags);
+	do_reenable();
+	spin_unlock_irqrestore(&wdt_lock, flags);
+}
+
+#endif /* CONFIG_COBALT_WDT */
diff -ruN dist-2.4.5/include/linux/cobalt-acpi.h cobalt-2.4.5/include/linux/cobalt-acpi.h
--- dist-2.4.5/include/linux/cobalt-acpi.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-acpi.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,16 @@
+/*
+ * $Id: $
+ * cobalt-acpi.h : support for ACPI interrupts
+ *
+ * Copyright 2000 Cobalt Networks, Inc.
+ * Copyright 2001 Sun Microsystems, Inc.
+ */
+#ifndef COBALT_ACPI_H
+#define COBALT_ACPI_H
+
+extern int cobalt_acpi_register_handler(void (*function)
+	(int, void *, struct pt_regs *));
+extern int cobalt_acpi_unregister_handler(void (*function)
+	(int, void *, struct pt_regs *));
+
+#endif /* COBALT_ACPI_H */
diff -ruN dist-2.4.5/include/linux/cobalt.h cobalt-2.4.5/include/linux/cobalt.h
--- dist-2.4.5/include/linux/cobalt.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,76 @@
+/* $Id: cobalt.h,v 1.5 2001/05/30 07:19:48 thockin Exp $ */
+/* Copyright 2001 Sun Microsystems, Inc. */
+#ifndef COBALT_H
+#define COBALT_H
+
+/* generational support - for easy checking */
+#ifdef CONFIG_COBALT_GEN_III
+# define COBT_SUPPORT_GEN_III 1
+#else
+# define COBT_SUPPORT_GEN_III 0
+#endif
+
+#ifdef CONFIG_COBALT_GEN_V
+# define COBT_SUPPORT_GEN_V 1
+#else
+# define COBT_SUPPORT_GEN_V 0
+#endif
+
+/* keep this test up to date with new generation defines */
+#if !defined(CONFIG_COBALT_GEN_III) && !defined(CONFIG_COBALT_GEN_V)
+/* barf if no generation has been selected */
+#error You asked for CONFIG_COBALT, but no CONFIG_COBALT_GEN !
+#endif
+
+/* macros for consistent errors/warnings */
+#define EPRINTK(fmt, args...)  \
+	printk(KERN_ERR "%s:%s" fmt , __FILE__ , __FUNCTION__ , ##args)
+
+#define WPRINTK(fmt, args...)  \
+	printk(KERN_WARNING "%s:%s" fmt , __FILE__ , __FUNCTION__ , ##args)
+
+/* accesses for CMOS */
+#include <linux/mc146818rtc.h>
+#define CMOS_FLAG_MIN           0x0001
+#define CMOS_SYSFAULT_FLAG      0x0020
+#define CMOS_OOPSPANIC_FLAG     0x0040
+#define CMOS_FLAG_MAX           0x0040
+
+#define CMOS_ADDR_PORT          0x70
+#define CMOS_DATA_PORT          0x71
+#define CMOS_INFO_MAX           0xff
+#define CMOS_FLAG_BYTE_0        0x10
+#define CMOS_FLAG_BYTE_1        0x11
+
+static inline u8
+cobalt_cmos_read_byte(int index)
+{
+	u8 data;
+	unsigned long flags;
+
+	if (index > CMOS_INFO_MAX)
+		return 0;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	outb(index, CMOS_ADDR_PORT);
+	data = inb(CMOS_DATA_PORT);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	return data;
+}
+
+static inline int
+cobalt_cmos_read_flag(const unsigned int flag)
+{
+	u16 cmosfl;
+
+	cmosfl = cobalt_cmos_read_byte(CMOS_FLAG_BYTE_0) << 8;
+	cmosfl |= cobalt_cmos_read_byte(CMOS_FLAG_BYTE_1);
+
+	return (cmosfl & flag) ? 1 : 0;
+}
+
+/* the root of /proc/cobalt */
+extern struct proc_dir_entry *proc_cobalt;
+
+#endif
diff -ruN dist-2.4.5/include/linux/cobalt-i2c.h cobalt-2.4.5/include/linux/cobalt-i2c.h
--- dist-2.4.5/include/linux/cobalt-i2c.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-i2c.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,37 @@
+/*
+ * $Id: cobalt-i2c.h,v 1.1 2001/03/07 01:58:24 thockin Exp $
+ * cobalt-i2c.h : I2C support for LCD/Front Panel
+ *
+ * Copyright 2000 Cobalt Networks, Inc.
+ * Copyright 2001 Sun Microsystems, Inc.
+ */
+#ifndef COBALT_I2C_H
+#define COBALT_I2C_H
+
+#include <linux/types.h>
+#include <linux/cobalt.h>
+
+#define COBALT_I2C_DEV_LED_I		0x40
+#define COBALT_I2C_DEV_LED_II		0x42
+#define COBALT_I2C_DEV_LCD_DATA		0x4a
+#define COBALT_I2C_DEV_LCD_INST		0x48
+#define COBALT_I2C_DEV_FP_BUTTONS	0x41
+#define COBALT_I2C_DEV_DRV_SWITCH	0x45
+#define COBALT_I2C_DEV_RULER		0x46
+#define COBALT_I2C_DEV_TEMP		0x90
+#define COBALT_I2C_READ			0x01
+#define COBALT_I2C_WRITE		0x00
+
+extern int cobalt_i2c_reset(void);
+extern int cobalt_i2c_read_byte(const int dev, const int index);
+extern int cobalt_i2c_read_word(const int dev, const int index);
+extern int cobalt_i2c_read_block(const int dev, const int index,
+				 unsigned char *data, int count);
+extern int cobalt_i2c_write_byte(const int dev, const int index,
+				 const u8 val);
+extern int cobalt_i2c_write_word(const int dev, const int index,
+				 const u16 val);
+extern int cobalt_i2c_write_block(const int dev, const int index,
+				  unsigned char *data, int count);
+
+#endif /* COBALT_I2C_H */
diff -ruN dist-2.4.5/include/linux/cobalt-lcd.h cobalt-2.4.5/include/linux/cobalt-lcd.h
--- dist-2.4.5/include/linux/cobalt-lcd.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-lcd.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,90 @@
+/*
+ * $Id: cobalt-lcd.h,v 1.2 2001/04/11 03:53:41 thockin Exp $
+ * cobalt-lcd.h : some useful defines for the Cobalt LCD driver
+ *                (must be useable from both kernel and user space)
+ *
+ * Copyright 1996-2000 Cobalt Networks, Inc.
+ * Copyright 2001 Sun Microsystems, Inc.
+ *
+ * By:	Andrew Bose	
+ *	Timothy Stonis (x86 version)
+ *	Tim Hockin
+ *	Adrian Sun
+ *	Erik Gilling
+ *	Duncan Laurie
+ */
+#ifndef COBALT_LCD_H
+#define COBALT_LCD_H
+
+#include <linux/cobalt.h>
+#include <linux/cobalt-led.h>
+
+/* this is the generic device minor assigned to /dev/lcd */
+#define COBALT_LCD_MINOR	156
+#define COBALT_LCD_LINELEN	40
+
+struct lcd_display {
+        unsigned long buttons;
+        int size1;
+        int size2;
+        unsigned char line1[COBALT_LCD_LINELEN];
+        unsigned char line2[COBALT_LCD_LINELEN];
+        unsigned char cursor_address;
+        unsigned char character;
+        unsigned char leds;
+        unsigned char *RomImage;
+};
+
+/* different lcd types */
+#define LCD_TYPE_UNKNOWN	0
+#define LCD_TYPE_PARALLEL	1
+#define LCD_TYPE_PARALLEL_B	2
+#define LCD_TYPE_I2C		3
+
+/* Function command codes for ioctl */
+#define LCD_On			1
+#define LCD_Off			2
+#define LCD_Clear		3
+#define LCD_Reset		4
+#define LCD_Cursor_Left		5
+#define LCD_Cursor_Right	6
+#define LCD_Disp_Left		7
+#define LCD_Disp_Right		8
+#define LCD_Get_Cursor		9
+#define LCD_Set_Cursor		10
+#define LCD_Home		11
+#define LCD_Read		12		
+#define LCD_Write		13	
+#define LCD_Cursor_Off		14
+#define LCD_Cursor_On		15
+#define LCD_Get_Cursor_Pos	16
+#define LCD_Set_Cursor_Pos	17
+#define LCD_Blink_Off		18
+#define LCD_Raw_Inst		19
+#define LCD_Raw_Data		20
+#define LCD_Type                21
+
+/* LED controls */
+#define LED_Set			40	
+#define LED_Bit_Set		41
+#define LED_Bit_Clear		42
+#define LED32_Set		43	
+#define LED32_Bit_Set		44
+#define LED32_Bit_Clear		45
+
+/* button ioctls */
+#define BUTTON_Read		50  
+
+/* Button defs */
+#define BUTTON_Next		0x3D
+#define BUTTON_Next_B		0x7E
+#define BUTTON_Reset_B		0xFC
+#define BUTTON_NONE_B           0xFE
+#define BUTTON_Left_B           0xFA
+#define BUTTON_Right_B          0xDE
+#define BUTTON_Up_B             0xF6
+#define BUTTON_Down_B           0xEE
+#define BUTTON_Enter_B          0xBE
+#define BUTTON_Power            0x01
+
+#endif /* COBALT_LCD_H */
diff -ruN dist-2.4.5/include/linux/cobalt-led.h cobalt-2.4.5/include/linux/cobalt-led.h
--- dist-2.4.5/include/linux/cobalt-led.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-led.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,45 @@
+/*
+ * $Id: cobalt-led.h,v 1.1 2001/04/11 03:53:41 thockin Exp $
+ * cobalt-led.c
+ *
+ * Copyright 1996-2000 Cobalt Networks, Inc.
+ * Copyright 2001 Sun Microsystems, Inc.
+ *
+ * By:	Andrew Bose	
+ *	Timothy Stonis (x86 version)
+ *	Tim Hockin
+ *	Adrian Sun
+ *	Erik Gilling
+ *	Duncan Laurie
+ */
+#ifndef COBALT_LED_H
+#define COBALT_LED_H
+
+#include <linux/ide.h>
+
+/* the set of all leds available on Cobalt systems */
+#define LED_SHUTDOWN		(1 << 0)
+#define LED_WEBLIGHT		(1 << 1)
+#define LED_COBALTLOGO		(1 << 2)
+#define LED_ETH0_TXRX		(1 << 3)
+#define LED_ETH0_LINK		(1 << 4)
+#define LED_ETH1_TXRX		(1 << 5)
+#define LED_ETH1_LINK		(1 << 6)
+#define LED_DISK0		(1 << 7)
+#define LED_DISK1		(1 << 8)
+#define LED_DISK2		(1 << 9)
+#define LED_DISK3		(1 << 10)
+#define LED_SYSFAULT		(1 << 11)
+#define LED_HEART		(1 << 12)
+#define LED_SPARE		(1 << 13)
+
+#ifdef __KERNEL__
+extern void cobalt_led_set(const unsigned int leds);
+extern void cobalt_led_set_lazy(const unsigned int leds);
+extern unsigned int cobalt_led_get(void);
+extern int cobalt_fpled_register(unsigned int (*fn)(void *), void *data);
+extern int cobalt_fpled_unregister(unsigned int (*fn)(void *), void *data);
+#endif
+
+#endif /* COBALT_LED_H */
+
diff -ruN dist-2.4.5/include/linux/cobalt-misc.h cobalt-2.4.5/include/linux/cobalt-misc.h
--- dist-2.4.5/include/linux/cobalt-misc.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-misc.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,11 @@
+/* $Id: $ */
+/* Copyright 2001 Sun Microsystems, Inc. */
+#ifndef COBALT_MISC_H
+#define COBALT_MISC_H
+
+void cobalt_nmi(unsigned char reason, struct pt_regs *regs);
+void cobalt_restart(void);
+void cobalt_halt(void);
+void cobalt_power_off(void);
+
+#endif
diff -ruN dist-2.4.5/include/linux/cobalt-net.h cobalt-2.4.5/include/linux/cobalt-net.h
--- dist-2.4.5/include/linux/cobalt-net.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-net.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,11 @@
+/* $Id: cobalt-net.h,v 1.1 2001/04/13 02:15:35 thockin Exp $ */
+/* Copyright 2001 Sun Microsystems, Inc. */
+#ifndef COBALT_NET_H
+#define COBALT_NET_H
+
+#include <linux/netdevice.h>
+
+void cobalt_net_register(struct net_device *ndev);
+void cobalt_net_unregister(struct net_device *ndev);
+
+#endif
diff -ruN dist-2.4.5/include/linux/cobalt-ruler.h cobalt-2.4.5/include/linux/cobalt-ruler.h
--- dist-2.4.5/include/linux/cobalt-ruler.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-ruler.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,12 @@
+/* $Id: cobalt-ruler.h,v 1.2 2001/04/27 03:13:53 thockin Exp $ */
+/* Copyright 2001 Sun Microsystems, Inc. */
+#ifndef COBALT_RULER_H
+#define COBALT_RULER_H
+
+#include <linux/ide.h>
+
+void cobalt_ruler_register(ide_hwif_t *hwif);
+void cobalt_ruler_unregister(ide_hwif_t *hwif);
+void cobalt_ruler_powerdown(void);
+
+#endif
diff -ruN dist-2.4.5/include/linux/cobalt-serialnum.h cobalt-2.4.5/include/linux/cobalt-serialnum.h
--- dist-2.4.5/include/linux/cobalt-serialnum.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-serialnum.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,16 @@
+/*
+ * $Id: $
+ * cobalt-serialnum.h : access to the DS2401 serial number
+ *
+ * Copyright 2000 Cobalt Networks, Inc.
+ * Copyright 2001 Sun Microsystems, Inc.
+ */
+#ifndef COBALT_SERIALNUM_H
+#define COBALT_SERIALNUM_H
+
+#include <linux/cobalt.h>
+
+char *cobalt_serialnum_get(void);
+unsigned long cobalt_hostid_get(void);
+
+#endif /* COBALT_SERIALNUM_H */
diff -ruN dist-2.4.5/include/linux/cobalt-superio.h cobalt-2.4.5/include/linux/cobalt-superio.h
--- dist-2.4.5/include/linux/cobalt-superio.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-superio.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,41 @@
+/*
+ * $Id: cobalt-superio.h,v 1.1 2001/03/07 01:58:24 thockin Exp $
+ * cobalt-superio.h : SuperIO support for Sun/Cobalt servers
+ *
+ * Copyright 2000 Cobalt Networks, Inc.
+ * Copyright 2001 Sun Microsystems, Inc.
+ */
+#ifndef COBALT_SUPERIO_H
+#define COBALT_SUPERIO_H
+
+#include <linux/cobalt.h>
+
+#define SUPERIO_INDEX_PORT      0x2e
+#define SUPERIO_DATA_PORT       0x2f
+
+#define SUPERIO_LOGICAL_DEV     0x07
+#define SUPERIO_DEV_RTC         0x02
+#define SUPERIO_DEV_GPIO        0x07
+#define SUPERIO_DEV_PM          0x08
+
+#define SUPERIO_ACTIVATE        0x30
+#define SUPERIO_ADDR_HIGH       0x60
+#define SUPERIO_ADDR_LOW        0x61
+#define SUPERIO_INTR_PIN        0x70
+#define SUPERIO_INTR_TYPE       0x71
+
+#define SUPERIO_APCR1           0x40
+#define SUPERIO_APCR4           0x4a
+
+#define SUPERIO_RTC_CRA         0x0a
+#define SUPERIO_RTC_BANK_0      0x20
+#define SUPERIO_RTC_BANK_2      0x40
+
+#define SUPERIO_PWRBUTTON       0x01
+#define SUPERIO_PM1_STATUS      0x01
+
+#define SUPERIO_WDT_DEV         0x05
+
+extern spinlock_t cobalt_superio_lock;
+
+#endif /* COBALT_SUPERIO_H */
diff -ruN dist-2.4.5/include/linux/cobalt-systype.h cobalt-2.4.5/include/linux/cobalt-systype.h
--- dist-2.4.5/include/linux/cobalt-systype.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-systype.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,29 @@
+/*
+ * $Id: cobalt-systype.h,v 1.1 2001/03/07 01:58:24 thockin Exp $
+ * cobalt-systype.h : figure out what Cobalt system we are on
+ *
+ * Copyright 2000 Cobalt Networks, Inc.
+ * Copyright 2001 Sun Microsystems, Inc.
+ */
+#ifndef COBALT_SYSTYPE_H
+#define COBALT_SYSTYPE_H
+
+#include <linux/cobalt.h>
+
+typedef enum {
+	COBT_UNKNOWN,
+	COBT_RAQ3,
+	COBT_QUBE3,
+	COBT_RAQXTR,
+} cobt_sys_t;
+
+extern cobt_sys_t cobt_type;
+/* one for each major board-type - COBT_SUPPORT_* from <linux/cobalt.h> */
+#define cobt_is_raq3()	 (COBT_SUPPORT_GEN_III && cobt_type == COBT_RAQ3)
+#define cobt_is_qube3()	 (COBT_SUPPORT_GEN_III && cobt_type == COBT_QUBE3)
+#define cobt_is_raqxtr() (COBT_SUPPORT_GEN_V && cobt_type == COBT_RAQXTR)
+/* one for each major generation */
+#define cobt_is_3k()	 (cobt_is_raq3() || cobt_is_qube3())
+#define cobt_is_5k()	 (cobt_is_raqxtr())
+
+#endif
diff -ruN dist-2.4.5/include/linux/cobalt-thermal.h cobalt-2.4.5/include/linux/cobalt-thermal.h
--- dist-2.4.5/include/linux/cobalt-thermal.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-thermal.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,12 @@
+/* $Id: $ */
+/* Copyright 2001 Sun Microsystems, Inc. */
+#ifndef COBALT_THERMAL_H
+#define COBALT_THERMAL_H
+
+#include <linux/cobalt.h>
+
+extern unsigned int cobalt_thermal_id_max;
+
+char *cobalt_temp_read(unsigned int sensor);
+
+#endif
diff -ruN dist-2.4.5/include/linux/cobalt-wdt.h cobalt-2.4.5/include/linux/cobalt-wdt.h
--- dist-2.4.5/include/linux/cobalt-wdt.h	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/include/linux/cobalt-wdt.h	Thu May 31 14:33:16 2001
@@ -0,0 +1,16 @@
+/* $Id: $ */
+/* Copyright 2001 Sun Microsystems, Inc. */
+#ifndef COBALT_WDT_H
+#define COBALT_WDT_H
+
+#include <linux/cobalt.h>
+
+void cobalt_wdt_refresh(unsigned long refresh_timer);
+void cobalt_wdt_trigger_reboot(void);
+
+void cobalt_wdt_disable(void);
+void cobalt_wdt_reenable(void);
+
+void cobalt_wdt_cleardog(void);
+
+#endif
diff -ruN dist-2.4.5/arch/i386/config.in cobalt-2.4.5/arch/i386/config.in
--- dist-2.4.5/arch/i386/config.in	Thu May 24 15:14:08 2001
+++ cobalt-2.4.5/arch/i386/config.in	Thu May 31 14:31:37 2001
@@ -192,6 +192,7 @@
    define_bool CONFIG_X86_LOCAL_APIC y
    define_bool CONFIG_PCI y
 else
+   source drivers/cobalt/Config.in
    if [ "$CONFIG_SMP" = "y" ]; then
       define_bool CONFIG_X86_IO_APIC y
       define_bool CONFIG_X86_LOCAL_APIC y
diff -ruN dist-2.4.5/Documentation/Configure.help cobalt-2.4.5/Documentation/Configure.help
--- dist-2.4.5/Documentation/Configure.help	Thu May 24 15:03:06 2001
+++ cobalt-2.4.5/Documentation/Configure.help	Thu May 31 14:31:29 2001
@@ -13035,6 +13035,121 @@
 
   If unsure, say N.
 
+Cobalt Networks support
+CONFIG_COBALT
+  Support for Cobalt Networks x86-based servers.
+
+Gen III (3000 series) system support
+CONFIG_COBALT_GEN_III
+  This option enables support for the 3000 series of Cobalt Networks 
+  systems. This includes the RaQ 3, RaQ 4, and Qube 3 product lines.
+
+  This platform uses an AMD K6-2 processor, an ALI M1541/1533 chipset, 
+  an optional NCR 53c875 SCSI controller, and two Intel 82559ER or 
+  National Semiconductor DP83815 NICs.
+
+  Getting this option wrong will likely result in a kernel that does 
+  not boot. Selecting support for more than 1 system series will add
+  bloat to your kernel, but will not cause anything bad to happen.
+
+  If you have a Cobalt Networks System, but aren't sure what kind, 
+  say Y here.
+  
+Gen V (5000 series) system support
+CONFIG_COBALT_GEN_V
+  This option enables support for the 5000 series of Cobalt Networks 
+  systems. This includes the RaQ XTR product line.
+
+  This platform uses Intel Pentium III Coppermine FCPGA CPUs, the 
+  ServerWorks LE chipset (with registered ECC DIMMs only!), two 
+  HighPoint HPT370 IDE controllers, and two National Semiconductor 
+  DP83815 NICs.
+
+  Getting this option wrong will likely result in a kernel that does 
+  not boot. Selecting support for more than 1 system series will add
+  bloat to your kernel, but will not cause anything bad to happen.
+
+  If you have a Cobalt Networks System, but aren't sure what kind, 
+  say Y here.
+
+Create legacy /proc files
+CONFIG_COBALT_OLDPROC
+  This option forces some Cobalt Networks drivers to support legacy 
+  files in /proc.  Older versions of these drivers exported files 
+  directly in /proc, as opposed to the newer /proc/cobalt.  If you say 
+  N to this option, the old filenames will no longer be exported.  
+  Regardless of your selection here, files in /proc/cobalt will be 
+  exported.  Of course, you have to include support for /proc fs, too.
+
+  It is safe to say Y here.
+
+Front panel LCD support
+CONFIG_COBALT_LCD
+  This enables support for the Cobalt Networks front panel.  This is 
+  for the LCD panel and buttons.  The primary method for connection is 
+  via the parallel port (IO base 0x370), but newer systems use an
+  I2C bus.  
+  
+  If you have a Cobalt Networks system, you should say Y here.
+
+Software controlled LED support
+CONFIG_COBALT_LED
+  This enables support for the software-controlled LEDs on Cobalt 
+  Networks systems.  This includes the fault light and front panel LEDs
+  on the RaQ XTR, the lightbar on the Qube 3, and others.
+
+  If you have a Cobalt Networks system, you should say Y here.
+
+Silicon serial number support
+CONFIG_COBALT_SERNUM
+  This enables support for the on-board serial number on Cobalt Networks 
+  systems.  This is a universally-unique 64-bit serial number.  Some 
+  systems use a Dallas DS2401 chip, others have an I2C based EEPROM.
+ 
+  If you select Y here, the files /proc/cobalt/hostid and 
+  /proc/cobalt/serialnumber will be created.  The hostid file contains a 
+  32 bit integer generated from the serial number, in binary form.  The 
+  serialnumber file contains the hexadecimal representation of the serial 
+  number, in ASCII.
+  
+  If you have a Cobalt Networks system, you should say Y here.
+
+Chipset watchdog timer support
+CONFIG_COBALT_WDT
+  This enables support for the watchdog timer built into Cobalt chipsets.
+  The timer wakes up periodically, to make find out if system has hung, 
+  or disabled interrupts too long. The result of detecting a hang is a 
+  hard reboot.
+
+  If you have a Cobalt Networks system, you should say Y here.
+
+Thermal sensor support
+CONFIG_COBALT_THERMAL
+  This enables support for the thermal sensor(s) built into Cobalt
+  Networks systems.  This driver exports /proc/cobalt/thermal_sensors.
+
+  If you have a Cobalt Networks system, you should say Y here.
+
+Fan tachometer support
+CONFIG_COBALT_FANS
+  This enables support for the fan tachometers built into some Cobalt 
+  Networks systems.  This driver exports /proc/cobalt/faninfo.  Some 
+  Cobalt software depends on this feature, and enabling it does not cause 
+  any risks.
+
+  If you have a Cobalt Networks system, you should say Y here, unless you
+  are absolutely sure.
+
+Disk drive ruler support
+CONFIG_COBALT_RULER
+  This enables support for the cobalt hard drive ruler, found on some
+  Cobalt systems, including the RaQ XTR.  This is the device that enables
+  swapping of drives.  It is not needed for basic disk operation.  
+  Enabling this on a system with no ruler will have no adverse effects.
+
+  If you have a Cobalt Networks system, you should say Y here,
+  unless you are absolutely sure.
+
 I2C support
 CONFIG_I2C
   I2C (pronounce: I-square-C) is a slow serial bus protocol used in
diff -ruN dist-2.4.5/arch/i386/kernel/Makefile cobalt-2.4.5/arch/i386/kernel/Makefile
--- dist-2.4.5/arch/i386/kernel/Makefile	Fri Dec 29 14:35:47 2000
+++ cobalt-2.4.5/arch/i386/kernel/Makefile	Thu May 31 14:31:37 2001
@@ -40,5 +40,6 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
+obj-$(CONFIG_COBALT)	+= cobalt.o
 
 include $(TOPDIR)/Rules.make
diff -ruN dist-2.4.5/arch/i386/kernel/cobalt.c cobalt-2.4.5/arch/i386/kernel/cobalt.c
--- dist-2.4.5/arch/i386/kernel/cobalt.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/arch/i386/kernel/cobalt.c	Thu May 31 14:31:37 2001
@@ -0,0 +1,168 @@
+/* $Id: cobalt.c,v 1.4 2001/04/17 05:38:51 asun Exp $ */
+#include <linux/config.h>
+
+#ifdef CONFIG_COBALT
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/cobalt-misc.h>
+#include <linux/cobalt-led.h>
+#include <linux/cobalt-superio.h>
+#include <linux/cobalt-ruler.h>
+
+static inline void ledonoff(unsigned long on, unsigned long off);
+
+void 
+cobalt_nmi(unsigned char reason, struct pt_regs *regs)
+{
+#if defined(CONFIG_COBALT_GEN_V)
+	struct pci_dev *cnb_dev;
+	u8 err;
+
+	printk("NMI:");
+	cnb_dev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS,
+		PCI_DEVICE_ID_SERVERWORKS_LE, NULL);
+	if (!cnb_dev) {
+		printk("%s: can't find north bridge for NMI status\n", 
+			__FILE__);
+		return;
+	}
+
+	pci_read_config_byte(cnb_dev, 0x47, &err);
+	if (err & 0x40)
+		printk(" (PCI tx data error)");
+	if (err & 0x20)
+		printk(" (PCI rx data error)");
+	if (err & 0x10)
+		printk(" (PCI address error)");
+	if (err & 0x04)
+		printk(" (DRAM uncorrectable error)");
+	if (err & 0x02)
+		printk(" (DRAM correctable error)");
+	if (err & 0x01)
+		printk(" (Shutdown cycle detected)");
+
+	if (err & 0x06) {
+		u32 address;
+		u8 row, dimm, ecc;
+
+		pci_read_config_dword(cnb_dev, 0x94, &address);
+		row = (address >> 29) & 0x7;
+		pci_read_config_byte(cnb_dev, 0x7c + (row >> 1), &dimm);
+		dimm = ((row & 1) ? (dimm >> 4) : dimm) & 0xf;
+		pci_read_config_byte(cnb_dev, 0xe8, &ecc);
+
+		printk(" [memory row 0x%x, DIMM type %d "
+		       "(col addr=0x%x, row addr=0x%x) ECC=0x%x]", row, 
+		       dimm, (address >> 15) & 0x3fff, address & 0x7fff,
+		       ecc);
+       	} 
+	printk("\n");
+
+	/* clear errors */
+	pci_write_config_byte(cnb_dev, 0x47, err); 
+#endif
+}
+
+void 
+cobalt_restart(void)
+{
+#if defined(CONFIG_COBALT_GEN_III)
+	/* kick watchdog */
+	cobalt_wdt_trigger_reboot();
+#elif defined (CONFIG_COBALT_GEN_V)
+	cobalt_ruler_powerdown();
+
+	/* set "Enable Hard Reset" bit to 1 */
+	outb(0x02, 0x0cf9);
+
+	/* the 0-to-1 transition of bit 2 will cause reset of processor */
+	outb(0x06, 0x0cf9);
+#endif
+
+	/* we should not get here unless there is a BAD error */
+	printk("%s: can not restart - halting\n", __FILE__);
+	machine_halt();
+}
+
+void
+cobalt_halt(void)
+{
+	int haltok = current_cpu_data.hlt_works_ok;
+
+#if defined(CONFIG_COBALT_GEN_V) 
+	/* we have soft power-off */
+	machine_power_off();
+#endif
+
+	/* 
+	 * we want to do cpu_idle, but we don't actually want to 
+	 * call cpu_idle. bleah. 
+	 */
+	while (1) {
+		ledonoff(HZ >> 1, HZ >> 1);
+		if (haltok) {
+			__asm__("hlt");
+		}
+	}
+}
+
+static inline void 
+ledonoff(unsigned long on, unsigned long off)
+{
+#if defined(CONFIG_COBALT_LCD)
+	unsigned long start;
+	int haltok = current_cpu_data.hlt_works_ok;
+       
+	if (on) {
+		start = jiffies;
+		cobalt_led_set(cobalt_led_get() | LED_SHUTDOWN);
+		while (jiffies < start + on) {
+			if (haltok) __asm__("hlt");
+		}
+	}
+
+	if (off) {
+		start = jiffies;
+		cobalt_led_set(cobalt_led_get() & ~LED_SHUTDOWN);
+		while (jiffies < start + off) {
+			if (haltok) __asm__("hlt");
+		}
+	}
+#endif
+}
+
+void
+cobalt_power_off(void)
+{
+#if defined(CONFIG_COBALT_GEN_V)
+	u16 addr;
+	u8 val;
+
+	/* use card control register 7 to select logical device 2 (APC) */
+	outb(SUPERIO_LOGICAL_DEV, SUPERIO_INDEX_PORT);
+	outb(SUPERIO_DEV_RTC, SUPERIO_DATA_PORT);
+
+	/* get the base register */
+	outb(SUPERIO_ADDR_HIGH, SUPERIO_INDEX_PORT);
+	addr = inb(SUPERIO_DATA_PORT) << 8;
+	outb(SUPERIO_ADDR_LOW, SUPERIO_INDEX_PORT);
+	addr |= inb(SUPERIO_DATA_PORT);
+	if (addr) {
+		/* set up bank 2 */
+		outb(SUPERIO_RTC_CRA, addr);
+		val = inb(addr + 1) & 0x8f;
+		outb(val | SUPERIO_RTC_BANK_2, addr + 1);
+
+		/* power off the machine with APCR1 */
+		outb(SUPERIO_APCR1, addr);
+		val = inb(addr + 1);
+		outb(0x20 | val, addr + 1);
+	}
+#endif
+}
+
+#endif /* CONFIG_COBALT */
diff -ruN dist-2.4.5/arch/i386/kernel/process.c cobalt-2.4.5/arch/i386/kernel/process.c
--- dist-2.4.5/arch/i386/kernel/process.c	Fri Feb  9 11:29:44 2001
+++ cobalt-2.4.5/arch/i386/kernel/process.c	Thu May 31 14:31:38 2001
@@ -46,6 +46,9 @@
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#ifdef CONFIG_COBALT
+#include <linux/cobalt-misc.h>
+#endif
 
 #include <linux/irq.h>
 
@@ -354,6 +357,10 @@
 	disable_IO_APIC();
 #endif
 
+#ifdef CONFIG_COBALT
+	cobalt_restart();
+#endif
+
 	if(!reboot_thru_bios) {
 		/* rebooting needs to touch the page at absolute addr 0 */
 		*((unsigned short *)__va(0x472)) = reboot_mode;
@@ -376,10 +383,17 @@
 
 void machine_halt(void)
 {
+#ifdef CONFIG_COBALT
+	cobalt_halt();
+#endif
 }
 
 void machine_power_off(void)
 {
+#ifdef CONFIG_COBALT
+	cobalt_power_off();
+#endif
+
 	if (pm_power_off)
 		pm_power_off();
 }
diff -ruN dist-2.4.5/arch/i386/kernel/setup.c cobalt-2.4.5/arch/i386/kernel/setup.c
--- dist-2.4.5/arch/i386/kernel/setup.c	Fri May 25 17:07:09 2001
+++ cobalt-2.4.5/arch/i386/kernel/setup.c	Thu May 31 14:31:38 2001
@@ -104,6 +104,10 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#ifdef CONFIG_COBALT
+#include <linux/cobalt-thermal.h>
+#endif
+
 /*
  * Machine setup..
  */
@@ -2441,9 +2445,13 @@
 			     x86_cap_flags[i] != NULL )
 				p += sprintf(p, " %s", x86_cap_flags[i]);
 
-		p += sprintf(p, "\nbogomips\t: %lu.%02lu\n\n",
+		p += sprintf(p, "\nbogomips\t: %lu.%02lu\n",
 			     c->loops_per_jiffy/(500000/HZ),
 			     (c->loops_per_jiffy/(5000/HZ)) % 100);
+#ifdef CONFIG_COBALT
+		p += sprintf(p, "temperature\t: %s\n", cobalt_temp_read(n));
+#endif
+		p += sprintf(p, "\n");
 	}
 	return p - buffer;
 }
diff -ruN dist-2.4.5/arch/i386/kernel/traps.c cobalt-2.4.5/arch/i386/kernel/traps.c
--- dist-2.4.5/arch/i386/kernel/traps.c	Mon May  7 14:15:21 2001
+++ cobalt-2.4.5/arch/i386/kernel/traps.c	Thu May 31 14:31:38 2001
@@ -46,6 +46,9 @@
 #include <asm/cobalt.h>
 #include <asm/lithium.h>
 #endif
+#ifdef CONFIG_COBALT
+#include <linux/cobalt-misc.h>
+#endif
 
 #include <linux/irq.h>
 
@@ -347,12 +350,18 @@
 
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
+#if defined(CONFIG_COBALT_GEN_V)
+	cobalt_nmi(reason, regs);
+#else
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
 	printk("You probably have a hardware problem with your RAM chips\n");
+#endif
 
-	/* Clear and disable the memory parity error line. */
-	reason = (reason & 0xf) | 4;
-	outb(reason, 0x61);
+	/* Clear and re-enable the memory parity error line. */
+	reason &= 0xf;
+	outb(reason | 4, 0x61);
+	outb(reason & ~4, 0x61);
+	
 }
 
 static void io_check_error(unsigned char reason, struct pt_regs * regs)
diff -ruN dist-2.4.5/drivers/Makefile cobalt-2.4.5/drivers/Makefile
--- dist-2.4.5/drivers/Makefile	Wed May 16 10:27:02 2001
+++ cobalt-2.4.5/drivers/Makefile	Thu May 31 14:32:02 2001
@@ -7,7 +7,7 @@
 
 
 mod-subdirs :=	dio mtd sbus video macintosh usb input telephony sgi i2o ide \
-		scsi md ieee1394 pnp isdn atm fc4 net/hamradio i2c acpi
+		scsi md ieee1394 pnp isdn atm fc4 net/hamradio i2c acpi cobalt
 
 subdir-y :=	parport char block net sound misc media cdrom
 subdir-m :=	$(subdir-y)
@@ -42,6 +42,7 @@
 subdir-$(CONFIG_HAMRADIO)	+= net/hamradio
 subdir-$(CONFIG_I2C)		+= i2c
 subdir-$(CONFIG_ACPI)		+= acpi
+subdir-$(CONFIG_COBALT)		+= cobalt
 
 include $(TOPDIR)/Rules.make
 
diff -ruN dist-2.4.5/drivers/char/mem.c cobalt-2.4.5/drivers/char/mem.c
--- dist-2.4.5/drivers/char/mem.c	Sat May 19 18:11:36 2001
+++ cobalt-2.4.5/drivers/char/mem.c	Thu May 31 14:32:09 2001
@@ -26,6 +26,9 @@
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_COBALT
+extern int cobalt_init(void);
+#endif
 #ifdef CONFIG_I2C
 extern int i2c_init_all(void);
 #endif
@@ -644,6 +647,9 @@
 #endif
 #if defined(CONFIG_ADB)
 	adbdev_init();
+#endif
+#ifdef CONFIG_COBALT
+	cobalt_init();
 #endif
 	return 0;
 }
diff -ruN dist-2.4.5/Makefile cobalt-2.4.5/Makefile
--- dist-2.4.5/Makefile	Fri May 25 09:51:33 2001
+++ cobalt-2.4.5/Makefile	Thu May 31 14:31:28 2001
@@ -177,6 +177,7 @@
 DRIVERS-$(CONFIG_PHONE) += drivers/telephony/telephony.o
 DRIVERS-$(CONFIG_ACPI) += drivers/acpi/acpi.o
 DRIVERS-$(CONFIG_MD) += drivers/md/mddev.o
+DRIVERS-$(CONFIG_COBALT) += drivers/cobalt/cobalt.o
 
 DRIVERS := $(DRIVERS-y)
 
@@ -193,6 +194,10 @@
 	drivers/zorro/devlist.h drivers/zorro/gen-devlist \
 	drivers/sound/bin2hex drivers/sound/hex2hex \
 	drivers/atm/fore200e_mkfirm drivers/atm/{pca,sba}*{.bin,.bin1,.bin2} \
+	drivers/scsi/aic7xxx/aicasm/aicasm_gram.c \
+	drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
+	drivers/scsi/aic7xxx/aicasm/y.tab.h \
+	drivers/scsi/aic7xxx/aicasm/aicasm \
 	net/khttpd/make_times_h \
 	net/khttpd/times.h \
 	submenu*

--------------3996306720A092317236588D--

