Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263332AbRFACqi>; Thu, 31 May 2001 22:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbRFACqb>; Thu, 31 May 2001 22:46:31 -0400
Received: from patan.Sun.COM ([192.18.98.43]:1752 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S263332AbRFACqQ>;
	Thu, 31 May 2001 22:46:16 -0400
Message-ID: <3B17025B.E5E23095@sun.com>
Date: Thu, 31 May 2001 19:47:55 -0700
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
 boundary="------------E6133A5CDB35508348DA526E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E6133A5CDB35508348DA526E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

apparently, LKML silently (!) bounces messages > a certain size.  So I'll
try smaller patches.  This is part 1/2 of the general Cobalt support.

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
--------------E6133A5CDB35508348DA526E
Content-Type: text/plain; charset=us-ascii;
 name="cobalt-drivers-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cobalt-drivers-1.diff"

diff -ruN dist-2.4.5/drivers/cobalt/acpi.c cobalt-2.4.5/drivers/cobalt/acpi.c
--- dist-2.4.5/drivers/cobalt/acpi.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/acpi.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,218 @@
+/* 
+ * cobalt acpi driver 
+ * Copyright (c) 2000, Cobalt Networks, Inc.
+ * Copyright (c) 2001, Sun Microsystems, Inc.
+ * $Id: acpi.c,v 1.10 2001/05/30 07:19:47 thockin Exp $
+ *
+ * author: asun@cobalt.com, thockin@sun.com
+ *
+ * this driver just sets stuff up for ACPI interrupts
+ *
+ * if acpi support really existed in the kernel, we would read
+ * data from the ACPI tables. however, it doesn't. as a result,
+ * we use some hardcoded values. 
+ *
+ * This should be SMP safe.  The only data that needs protection is the acpi
+ * handler list.  It gets scanned at timer-interrupts, must use
+ * irqsave/restore locks. Read/write locks would be useful if there were any
+ * other times that the list was read but never written. --TPH
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <linux/cobalt.h>
+#include <linux/cobalt-systype.h>
+#include <linux/cobalt-acpi.h>
+#include <linux/cobalt-superio.h>
+
+#define POWER_BUTTON_SHUTDOWN     0
+
+#define ACPI_IRQ	10       /* XXX: hardcoded interrupt */
+#define ACPI_NAME	"sci"
+#define ACPI_MAGIC	0xc0b7ac21
+
+#define SUPERIO_EVENT	0xff
+#define OSB4_EVENT	0x40
+#define OSB4_INDEX_PORT	0x0cd6
+#define OSB4_DATA_PORT	0x0cd7
+
+/* for registering ACPI handlers */
+struct acpi_handler {
+	void (*function)(int irq, void *dev_id, struct pt_regs *regs);
+	struct acpi_handler *next;
+	struct acpi_handler *prev;
+};
+struct acpi_handler *acpi_handler_list;
+
+static spinlock_t acpi_lock = SPIN_LOCK_UNLOCKED;
+/* these two are for gen V */
+static u16 osb4_port;
+static u16 superio_port;
+
+static u16 
+get_reg(u16 index, u16 data, u8 port)
+{
+	if (cobt_is_5k()) {
+		u16 reg;
+
+		outb(port, index);
+		reg = inb(data);
+		outb(port + 1, index);
+		reg |= inb(data) << 8;
+		return reg;
+	}
+
+	return 0;
+}
+
+static void 
+acpi_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags, events;
+	struct acpi_handler *p;
+
+	spin_lock_irqsave(&acpi_lock, flags);
+
+	if (cobt_is_5k()) {
+		/* save the superio events */
+		events = inb(superio_port) | (inb(superio_port + 1) << 8);
+	
+		/* clear SCI interrupt generation */
+		outb(OSB4_EVENT, osb4_port); 
+		outb(SUPERIO_EVENT, superio_port);
+		outb(SUPERIO_EVENT, superio_port + 1);
+	}
+
+	/* call the ACPI handlers */
+	p = acpi_handler_list;
+	while (p) {
+		p->function(irq, dev_id, regs);
+		p = p->next;
+	}
+
+	spin_unlock_irqrestore(&acpi_lock, flags);
+}
+
+int
+cobalt_acpi_register_handler(void (*function)(int, void *, struct pt_regs *))
+{
+	struct acpi_handler *newh;
+	unsigned long flags;
+
+	newh = kmalloc(sizeof(*newh), GFP_ATOMIC);
+	if (!newh) {
+		EPRINTK("can't allocate memory for handler %p\n", function);
+		return -1;
+	}
+
+	spin_lock_irqsave(&acpi_lock, flags);
+
+	/* head insert */
+	newh->function = function;
+	newh->next = acpi_handler_list;
+	newh->prev = NULL;
+	if (acpi_handler_list) {
+		acpi_handler_list->prev = newh;
+	}
+	acpi_handler_list = newh;	
+
+	spin_unlock_irqrestore(&acpi_lock, flags);
+
+	return 0;
+}
+
+int
+cobalt_acpi_unregister_handler(void (*function)(int, void *, struct pt_regs *))
+{
+	struct acpi_handler *p;
+	unsigned long flags;
+	int r = -1;
+
+	spin_lock_irqsave(&acpi_lock, flags);
+
+	p = acpi_handler_list;
+	while (p) {
+		if (p->function == function) {
+			if (p->prev) {
+				p->prev->next = p->next;
+			}
+			if (p->next) {
+				p->next->prev = p->prev;
+			}
+			r = 0;
+			break;
+		}
+		p = p->next;
+	}
+
+	spin_unlock_irqrestore(&acpi_lock, flags);
+
+	return r;
+}
+
+int __init 
+cobalt_acpi_init(void)
+{
+	int err, reg;
+	u16 addr;
+	unsigned long flags;
+
+	if (cobt_is_5k()) {
+		/* setup osb4 i/o regions */
+		if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x20)))
+			request_region(reg, 4, "OSB4 (pm1a_evt_blk)");
+		if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x22)))
+			request_region(reg, 2, "OSB4 (pm1a_cnt_blk)");
+		if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x24)))
+			request_region(reg, 4, "OSB4 (pm_tmr_blk)");
+		if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x26)))
+			request_region(reg, 6, "OSB4 (p_cnt_blk)");
+		if ((reg = get_reg(OSB4_INDEX_PORT, OSB4_DATA_PORT, 0x28)))
+			request_region(reg, 8, "OSB4 (gpe0_blk)");
+		osb4_port = reg;
+
+		spin_lock_irqsave(&cobalt_superio_lock, flags);
+	
+		/* superi/o -- select pm logical device and get base address */
+		outb(SUPERIO_LOGICAL_DEV, SUPERIO_INDEX_PORT);
+		outb(SUPERIO_DEV_PM, SUPERIO_DATA_PORT);
+		outb(SUPERIO_ADDR_HIGH, SUPERIO_INDEX_PORT);
+		addr = inb(SUPERIO_DATA_PORT) << 8;
+		outb(SUPERIO_ADDR_LOW, SUPERIO_INDEX_PORT);
+		addr |= inb(SUPERIO_DATA_PORT); 
+		if (addr) {
+			/* get registers */
+			if ((reg = get_reg(addr, addr + 1, 0x08))) {
+				request_region(reg, 4, "SUPERIO (pm1_evt_blk)");
+				superio_port = reg;
+			}
+			if ((reg = get_reg(addr, addr + 1, 0x0c))) 
+				request_region(reg, 2, "SUPERIO (pm1_cnt_blk)");
+			if ((reg = get_reg(addr, addr + 1, 0x0e)))
+				request_region(reg, 16, "SUPERIO (gpe_blk)");
+		}
+	
+		spin_unlock_irqrestore(&cobalt_superio_lock, flags);
+	
+		/* setup an interrupt handler for an ACPI SCI */
+		err = request_irq(ACPI_IRQ, acpi_interrupt, 
+			  SA_SHIRQ, ACPI_NAME, (void *)ACPI_MAGIC);
+		if (err) {
+			EPRINTK("couldn't assign ACPI IRQ (%d)\n", ACPI_IRQ);
+			return -1;
+		}
+	}
+
+	return 0;
+}
diff -ruN dist-2.4.5/drivers/cobalt/Config.in cobalt-2.4.5/drivers/cobalt/Config.in
--- dist-2.4.5/drivers/cobalt/Config.in	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/Config.in	Thu May 31 14:32:15 2001
@@ -0,0 +1,23 @@
+#
+# Cobalt Networks hardware support
+#
+mainmenu_option next_comment
+comment 'Cobalt Networks support'
+bool 'Support for Cobalt Networks x86 servers' CONFIG_COBALT
+
+if [ "$CONFIG_COBALT" != "n" ]; then
+   bool 'Gen III (3000 series) system support' CONFIG_COBALT_GEN_III
+   bool 'Gen V (5000 series) system support' CONFIG_COBALT_GEN_V
+   bool 'Create legacy /proc files' CONFIG_COBALT_OLDPROC
+
+   comment 'Cobalt hardware options'
+
+   bool 'Front panel (LCD) support' CONFIG_COBALT_LCD
+   bool 'Software controlled LED support' CONFIG_COBALT_LED
+   bool 'Serial number support' CONFIG_COBALT_SERNUM
+   bool 'Watchdog timer support' CONFIG_COBALT_WDT
+   bool 'Thermal sensor support' CONFIG_COBALT_THERMAL
+   bool 'Fan tachometer support' CONFIG_COBALT_FANS
+   bool 'Disk drive ruler support' CONFIG_COBALT_RULER
+fi
+endmenu
diff -ruN dist-2.4.5/drivers/cobalt/fans.c cobalt-2.4.5/drivers/cobalt/fans.c
--- dist-2.4.5/drivers/cobalt/fans.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/fans.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,159 @@
+/* $Id: fans.c,v 1.3 2001/05/30 07:19:47 thockin Exp $
+ * Copyright (c) 2000-2001 Sun Microsystems, Inc 
+ *
+ * This should be SMP safe.  There are no critical regions or data.  All 
+ * this ever does in inb(). --TPH
+ */
+#include <linux/config.h>
+#ifdef CONFIG_COBALT_FANS
+
+#include <stdarg.h>
+#include <stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/time.h>
+#include <asm/io.h>
+#include <linux/cobalt.h>
+#include <linux/cobalt-systype.h>
+
+#define GEN_V_FANS_MAX		6
+
+#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_COBALT_OLDPROC
+static struct proc_dir_entry *proc_faninfo;
+#endif
+static struct proc_dir_entry *proc_cfaninfo;
+#endif
+static int fan_read_proc(char *buf, char **start, off_t pos, int len,
+	int *eof, void *x);
+
+
+int __init 
+cobalt_fan_init(void)
+{
+#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_COBALT_OLDPROC
+	proc_faninfo = create_proc_read_entry("faninfo", S_IFREG | S_IRUGO, 
+		NULL, fan_read_proc, NULL);
+        if (!proc_faninfo) {
+		EPRINTK("can't create /proc/faninfo\n");
+	}
+#endif
+	proc_cfaninfo = create_proc_read_entry("faninfo", S_IFREG | S_IRUGO, 
+		proc_cobalt, fan_read_proc, NULL);
+        if (!proc_cfaninfo) {
+		EPRINTK("can't create /proc/cobalt/faninfo\n");
+	}
+#endif
+
+	printk("Cobalt Networks fan tachometers v1.2\n");
+
+	return 0;
+}
+
+/*
+ * Samples fan tachometer square wave to calculate and report RPM
+ */
+static int 
+get_faninfo(char *buffer)
+{
+	if (cobt_is_5k()) {
+		int a, ap, b, bp;
+		int halfcycles[] = {0,0,0,0,0,0};
+		/* these are masks for the fans, cpufanbits are on 
+		 * GPIO port 1, fanbits are on port 2 */
+		int cpufanbits[] = {0x2, 0x4};
+		int fanbits[] = {0x10, 0x40, 0x20, 0x80};
+		int i;
+		int len=0;
+		struct timeval utime;
+		unsigned long elapsed, start;
+	
+		get_fast_time(&utime);
+		start = utime.tv_usec;
+
+		/* initialize 'previous' values. we do edge detection by
+		 * looking for transitions from previous values */
+		ap = inb(0x600);
+		bp = inb(0x604);
+
+		/* We are counting the number of halfcycles in a square wave
+		 * that pass in a given amount of time to determine frequency */
+		do {
+			a = inb(0x600);
+			for (i=0; i<2; i++) {
+				if ((a ^ ap) & cpufanbits[i]) {
+					halfcycles[i]++;
+				}
+			}
+
+			b = inb(0x604);
+			for (i=0; i<4; i++) {
+				if ((b ^ bp) & fanbits[i]) {
+					halfcycles[i+2]++;
+				}
+			}	
+			ap = a;
+			bp = b;
+
+			get_fast_time(&utime);
+			if (utime.tv_usec > start) {
+				elapsed = utime.tv_usec - start;
+			} else {
+				elapsed = utime.tv_usec + 1000001 - start;
+			}
+		} while (elapsed < 50000); /* count for 50ms */
+
+		/* Fan rpm = 60 / ( t x poles )
+		 *  where t is 1/2 the period and poles are the number of 
+		 *  magnetic poles for the fan.
+		 *  
+		 * For the Sunon KDE1204PKBX fans on Raq XTR, poles = 4
+		 * So, in terms of cycles,
+		 *
+		 *  rpm = 60 s/m    halfcycles       
+		 *        ------ *  -------------- * 1,000,000 us/s * 2
+		 *        4         2 * elapsed us
+		 *      = 15,000,000 * halfcycles / elapsed
+		 *
+		 * Note, by this method and sampling for 50ms, our accuracy
+		 *  is +/- 300 rpm.  The fans are spec'ed for 8000 +/- 1000 rpm 
+		 */
+		for (i = 0; i < GEN_V_FANS_MAX; i++)
+			len += sprintf(buffer+len, "fan %x     : %lu\n", i, 
+				halfcycles[i] * 15000000 / elapsed);
+		return len;
+	} else {
+		/* software is keyed off this string - do not change it ! */
+		return sprintf(buffer, "Fan monitoring not supported.\n");
+	}
+}
+
+static int 
+fan_read_proc(char *buf, char **start, off_t pos, int len,
+	int *eof, void *x)
+{
+	int plen;
+
+	plen = get_faninfo(buf);
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
+#endif /* CONFIG_COBALT_FANS */
diff -ruN dist-2.4.5/drivers/cobalt/i2c.c cobalt-2.4.5/drivers/cobalt/i2c.c
--- dist-2.4.5/drivers/cobalt/i2c.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/i2c.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,402 @@
+/*
+ * $Id: i2c.c,v 1.6 2001/05/30 07:19:47 thockin Exp $
+ * i2c.c : Cobalt I2C driver support
+ *
+ * Copyright (C) 2000 Cobalt Networks, Inc. 
+ * Copyright (C) 2001 Sun Microsystems, Inc. 
+ *
+ * This should be SMP safe.  All the exported functions lock on enter and
+ * unlock on exit.  These exported functions may be called at interupt time,
+ * so we have to use the IRQ safe locks.  NOTE: no function herein may call 
+ * any exported function herein. --TPH
+ */
+#include <stddef.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/cobalt.h>
+#include <linux/cobalt-i2c.h>
+#include <linux/cobalt-systype.h>
+
+#define I2C_3K_STATUS                   0x00
+#define I2C_3K_CMD                      0x01
+#define I2C_3K_START                    0x02
+#define I2C_3K_ADDR                     0x03
+#define I2C_3K_LOW_DATA                 0x04
+#define I2C_3K_HIGH_DATA                0x05
+#define I2C_3K_BLOCK_DATA               0x06
+#define I2C_3K_INDEX                    0x07
+#define I2C_3K_STATUS_IDLE              0x04
+#define I2C_3K_CMD_RW_BYTE              0x20
+#define I2C_3K_CMD_RW_WORD              0x30
+#define I2C_3K_CMD_RW_BLOCK             0xC0
+#define I2C_3K_CMD_RESET_PTR            0x80
+
+#define I2C_5K_HOST_STATUS              0x00
+#define I2C_5K_SLAVE_STATUS             0x01
+#define I2C_5K_HOST_CONTROL             0x02
+#define I2C_5K_HOST_COMMAND             0x03
+#define I2C_5K_HOST_ADDR                0x04
+#define I2C_5K_DATA_0                   0x05
+#define I2C_5K_DATA_1                   0x06
+#define I2C_5K_BLOCK_DATA               0x07
+#define I2C_5K_SLAVE_CONTROL            0x08
+#define I2C_5K_SHADOW_COMMAND           0x09
+#define I2C_5K_SLAVE_EVENT              0x0a
+#define I2C_5K_SLAVE_DATA               0x0c
+#define I2C_5K_HOST_STATUS_BUSY         0x01
+#define I2C_5K_HOST_CMD_START           0x40
+#define I2C_5K_HOST_CMD_QUICK_RW        (0 << 2)
+#define I2C_5K_HOST_CMD_BYTE_RW         (1 << 2)
+#define I2C_5K_HOST_CMD_BYTE_DATA_RW    (2 << 2)
+#define I2C_5K_HOST_CMD_WORD_DATA_RW    (3 << 2)
+#define I2C_5K_HOST_CMD_BLOCK_DATA_RW   (5 << 2)
+
+#define I2C_WRITE			0
+#define I2C_READ			1
+
+#define COBALT_I2C_INFO			"Cobalt Networks I2C bus"
+
+struct cobalt_i2c_data {
+	const unsigned char status;
+	const unsigned char addr;
+	const unsigned char index;
+	const unsigned char data_low;
+	const unsigned char data_high;
+	const unsigned char data_block;
+	const unsigned char rw_byte;
+	const unsigned char rw_word;
+	const unsigned char rw_block;
+	unsigned int io_port;
+};
+
+struct cobalt_i2c_data cobalt_i2c_3k = {
+	I2C_3K_STATUS,
+	I2C_3K_ADDR,
+	I2C_3K_INDEX,
+	I2C_3K_LOW_DATA,
+	I2C_3K_HIGH_DATA,
+	I2C_3K_BLOCK_DATA,
+	I2C_3K_CMD_RW_BYTE,
+	I2C_3K_CMD_RW_WORD,
+	I2C_3K_CMD_RW_BLOCK,
+	0L
+};
+
+struct cobalt_i2c_data cobalt_i2c_5k = {
+	I2C_5K_HOST_STATUS,
+	I2C_5K_HOST_ADDR,
+	I2C_5K_HOST_COMMAND,
+	I2C_5K_DATA_0,
+	I2C_5K_DATA_1,
+	I2C_5K_BLOCK_DATA,
+	I2C_5K_HOST_CMD_BYTE_DATA_RW,
+	I2C_5K_HOST_CMD_WORD_DATA_RW,
+	I2C_5K_HOST_CMD_BLOCK_DATA_RW,
+	0L
+};
+
+/* a global pointer for our i2c data */
+struct cobalt_i2c_data *i2c_data;
+
+#define I2C_REG(r)			(i2c_data->io_port + i2c_data->r)
+#define I2C_CMD(c)			(i2c_data->c)
+
+static spinlock_t i2c_lock = SPIN_LOCK_UNLOCKED;
+
+static int 
+i2c_wait_for_smi(void)
+{
+	unsigned int timeout=0xffff;
+	int status;
+
+	while (timeout) {
+		outb(0xff, 0x80); /* wait */
+		status = inb(I2C_REG(status));
+
+		if (cobt_is_3k()) {
+			if (status & I2C_3K_STATUS_IDLE) {
+				return 0;
+			}
+		} else if (cobt_is_5k()) {
+			if (!(status & I2C_5K_HOST_STATUS_BUSY)) {
+				return 0;
+			}
+		}
+
+		timeout--;
+	}
+
+	/* still busy - punch the abort bit */
+	WPRINTK("i2c timeout: status=0x%x, resetting...\n", status);
+
+	if (cobt_is_3k()) {
+		outb(4, i2c_data->io_port + I2C_3K_CMD);
+	} else if (cobt_is_5k()) {
+		outb(2, i2c_data->io_port + I2C_5K_HOST_CONTROL);
+		outb(1, i2c_data->io_port + I2C_5K_HOST_CONTROL);
+	}
+
+	return -1;
+}
+
+static inline int 
+i2c_setup(const int dev, const int index, const int r)
+{
+	if (i2c_wait_for_smi() < 0)
+		return -1;
+
+	/* clear status */
+	outb(0xff, I2C_REG(status));
+
+	/* device address */
+	outb((dev|r) & 0xff, I2C_REG(addr));
+
+	/* I2C index */
+	outb(index & 0xff, I2C_REG(index));
+
+	return 0;
+}
+	
+static inline int 
+i2c_cmd(const unsigned char command)
+{
+	if (cobt_is_3k()) {
+		outb(command, i2c_data->io_port + I2C_3K_CMD); 
+		outb(0xff, i2c_data->io_port + I2C_3K_START);
+	} else if (cobt_is_5k()) {
+		outb(I2C_5K_HOST_CMD_START | command,
+			i2c_data->io_port + I2C_5K_HOST_CONTROL);
+	}
+
+	if (i2c_wait_for_smi() < 0)
+		return -1;
+
+	return 0;
+}
+
+int __init 
+cobalt_i2c_init(void)
+{
+	struct pci_dev *i2cdev = NULL;
+
+	if (cobt_is_3k()) {
+		i2c_data = &cobalt_i2c_3k;
+	        i2cdev = pci_find_device(PCI_VENDOR_ID_AL, 
+			PCI_DEVICE_ID_AL_M7101, NULL);
+		if (!i2cdev) {
+			EPRINTK("can't find PMU for i2c access\n");
+			return -1;
+		}
+		pci_read_config_dword(i2cdev, 0x14, &i2c_data->io_port);
+	} else if (cobt_is_5k()) {
+		i2c_data = &cobalt_i2c_5k;
+		i2cdev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS,
+			PCI_DEVICE_ID_SERVERWORKS_OSB4, i2cdev);
+		if (!i2cdev) {
+			EPRINTK("can't find OSB4 for i2c access\n");
+			return -1;
+		}
+		pci_read_config_dword(i2cdev, 0x90, &i2c_data->io_port);
+	}
+
+        i2c_data->io_port &= 0xfff0;
+        if (i2c_data->io_port) {
+		printk(KERN_INFO "%s\n", COBALT_I2C_INFO);
+	} else {
+		EPRINTK("i2c IO port not found\n");
+	}
+
+	return 0;
+}
+
+int 
+cobalt_i2c_reset(void)
+{
+	int r;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c_lock, flags);
+
+	if (cobt_is_3k()) {
+		/* clear status */
+		outb(0xff, i2c_data->io_port + I2C_3K_STATUS);
+		/* reset SMB devs */
+		outb(0x08, i2c_data->io_port + I2C_3K_CMD);
+		/* start command */
+		outb(0xff, i2c_data->io_port + I2C_3K_START);
+	} else if (cobt_is_5k()) {
+		/* clear status */
+		outb(0xff, i2c_data->io_port + I2C_5K_HOST_STATUS);
+		outb(0x2, i2c_data->io_port + I2C_5K_HOST_CONTROL);
+	}
+
+	r = i2c_wait_for_smi();
+
+	spin_unlock_irqrestore(&i2c_lock, flags);
+
+	return r;
+}
+
+int 
+cobalt_i2c_read_byte(const int dev, const int index)
+{
+	int val = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c_lock, flags);
+
+	if (i2c_setup(dev, index, I2C_READ) < 0 
+	 || i2c_cmd(I2C_CMD(rw_byte)) < 0) {
+		val = -1;
+	}
+
+	if (val == 0) {
+		val = inb(I2C_REG(data_low));
+	}
+
+	spin_unlock_irqrestore(&i2c_lock, flags);
+
+	return val;
+}
+
+int 
+cobalt_i2c_read_word(const int dev, const int index)
+{
+	int val = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c_lock, flags);
+	
+	if (i2c_setup(dev, index, I2C_READ) < 0 
+	 || i2c_cmd(I2C_CMD(rw_word)) < 0) {
+		val = -1;
+	}
+
+	if (val == 0) {
+		val  = inb(I2C_REG(data_low));
+		val += inb(I2C_REG(data_high)) << 8;
+	}
+
+	spin_unlock_irqrestore(&i2c_lock, flags);
+
+	return val;
+}
+
+int 
+cobalt_i2c_read_block(const int dev, const int index, 
+	unsigned char *data, int count)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c_lock, flags);
+	
+	if (i2c_setup(dev, index, I2C_READ) < 0) { 
+		spin_unlock_irqrestore(&i2c_lock, flags);
+		return -1;
+	}
+
+	outb(count & 0xff, I2C_REG(data_low));
+	outb(count & 0xff, I2C_REG(data_high));
+
+	if (i2c_cmd(I2C_CMD(rw_block)) < 0) {
+		spin_unlock_irqrestore(&i2c_lock, flags);
+		return -1;
+	}
+
+	while (count) {
+		/* read a byte of block data */
+		*data = inb(I2C_REG(data_block));
+		data++;
+		count--;
+	}
+
+	spin_unlock_irqrestore(&i2c_lock, flags);
+
+	return 0;	
+}
+
+int 
+cobalt_i2c_write_byte(const int dev, const int index, const u8 val)
+{
+	int r = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c_lock, flags);
+
+	if (i2c_setup(dev, index, I2C_WRITE) < 0) {
+		r = -1;
+	}
+
+	if (r == 0) {
+		outb(val & 0xff, I2C_REG(data_low));
+
+		if (i2c_cmd(I2C_CMD(rw_byte)) < 0) {
+		    r = -1;
+		}
+	}
+
+	spin_unlock_irqrestore(&i2c_lock, flags);
+
+	return r;	
+}
+
+int 
+cobalt_i2c_write_word(const int dev, const int index, const u16 val)
+{
+	int r = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c_lock, flags);
+
+	if (i2c_setup(dev, index, I2C_WRITE) < 0) {
+		r = -1;
+	}
+
+	if (r == 0) {
+		outb(val & 0xff, I2C_REG(data_low));
+		outb((val >> 8) & 0xff, I2C_REG(data_high));
+
+		if (i2c_cmd(I2C_CMD(rw_word)) < 0) {
+			r = -1;
+		}
+	}
+
+	spin_unlock_irqrestore(&i2c_lock, flags);
+
+	return r;	
+}
+
+int 
+cobalt_i2c_write_block(int dev, int index, unsigned char *data, int count)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c_lock, flags);
+
+	if (i2c_setup(dev, index, I2C_WRITE) < 0) {
+		spin_unlock_irqrestore(&i2c_lock, flags);
+		return -1;
+	}
+
+	outb(count & 0xff, I2C_REG(data_low));
+	outb(count & 0xff, I2C_REG(data_high));
+
+	if (i2c_cmd(I2C_CMD(rw_block)) < 0) {
+		spin_unlock_irqrestore(&i2c_lock, flags);
+		return -1;
+	}
+
+	while (count) {
+		/* write a byte of block data */
+		outb(*data, I2C_REG(data_block));
+		data++;
+		count--;
+	}
+
+	spin_unlock_irqrestore(&i2c_lock, flags);
+
+	return 0;	
+}
diff -ruN dist-2.4.5/drivers/cobalt/init.c cobalt-2.4.5/drivers/cobalt/init.c
--- dist-2.4.5/drivers/cobalt/init.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/init.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,79 @@
+/* $Id: init.c,v 1.6 2001/05/30 07:19:48 thockin Exp $ */
+/*
+ *   Copyright (c) 2001  Sun Microsystems
+ *   Generic initialization, to reduce pollution of other files
+ */
+#include <linux/config.h>
+#ifdef CONFIG_COBALT
+
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/cobalt.h>
+
+static int cobalt_proc_init(void);
+extern int cobalt_i2c_init(void);
+extern int cobalt_net_init(void);
+extern int cobalt_systype_init(void);
+extern int cobalt_led_init(void);
+extern int cobalt_lcd_init(void);
+extern int cobalt_serialnum_init(void);
+extern int cobalt_wdt_init(void);
+extern int cobalt_thermal_init(void);
+extern int cobalt_fan_init(void);
+extern int cobalt_acpi_init(void);
+extern int cobalt_ruler_init(void);
+
+struct proc_dir_entry *proc_cobalt;
+spinlock_t cobalt_superio_lock = SPIN_LOCK_UNLOCKED;
+
+/* initialize all the cobalt specific stuff */
+int __init 
+cobalt_init(void)
+{
+	cobalt_proc_init();
+	cobalt_systype_init();
+	cobalt_i2c_init();
+	cobalt_acpi_init();
+	cobalt_net_init();
+#ifdef CONFIG_COBALT_LED
+	cobalt_led_init();
+#endif
+#ifdef CONFIG_COBALT_LCD
+	cobalt_lcd_init();
+#endif
+#ifdef CONFIG_COBALT_RULER
+	cobalt_ruler_init();
+#endif
+#ifdef CONFIG_COBALT_SERNUM
+	cobalt_serialnum_init();
+#endif
+#ifdef CONFIG_COBALT_WDT
+	cobalt_wdt_init();
+#endif
+#ifdef CONFIG_COBALT_THERMAL
+	cobalt_thermal_init();
+#endif
+#ifdef CONFIG_COBALT_FANS
+	cobalt_fan_init();
+#endif
+
+	return 0;
+}
+
+static int __init
+cobalt_proc_init(void)
+{
+	proc_cobalt = proc_mkdir("cobalt", 0);
+	if (!proc_cobalt) {
+		EPRINTK("can't create /proc/cobalt\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+#endif /* CONFIG_COBALT */
diff -ruN dist-2.4.5/drivers/cobalt/lcd.c cobalt-2.4.5/drivers/cobalt/lcd.c
--- dist-2.4.5/drivers/cobalt/lcd.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/lcd.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,645 @@
+/*
+ * $Id: lcd.c,v 1.9 2001/05/30 07:19:48 thockin Exp $
+ * lcd.c : driver for Cobalt LCD/Buttons
+ *
+ * Copyright 1996-2000 Cobalt Networks, Inc.
+ * Copyright 2001 Sun Microsystems, Inc.
+ *
+ * By:	Andrew Bose
+ *	Timothy Stonis
+ *	Tim Hockin
+ *	Adrian Sun
+ *	Duncan Laurie
+ *
+ * This should be SMP safe.  We don't deal with interrupts or timers at all,
+ * so plain old spin_lock() is sufficient.  We're hardly performance critical,
+ * so we lock around lcd_ioctl() and just where needed by other external
+ * functions.  There is a static global waiters variable that is atomic_t, and
+ * so should be safe. --TPH
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_COBALT_LCD
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/malloc.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/stat.h>
+#include <linux/netdevice.h>
+#include <linux/proc_fs.h>
+#include <linux/in6.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/segment.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <asm/checksum.h>
+#include <linux/delay.h>
+
+#include <linux/cobalt.h>
+#include <linux/cobalt-systype.h>
+#include <linux/cobalt-lcd.h>
+#include <linux/cobalt-superio.h>
+#include <linux/cobalt-i2c.h>
+
+#define LCD_DRIVER		"Cobalt Networks LCD driver"
+#define LCD_DRIVER_VMAJ		4
+#define LCD_DRIVER_VMIN		0
+
+/* io registers */
+#define LPT			0x0378
+#define LCD_DATA_ADDRESS	LPT+0
+#define LCD_CONTROL_ADDRESS	LPT+2
+
+/* LCD device info */
+#define LCD_Addr		0x80
+#define DD_R00			0x00
+#define DD_R01			0x27
+#define DD_R10			0x40
+#define DD_R11			0x67
+
+/* driver functions */
+static int cobalt_lcd_open(struct inode *, struct file *);
+static ssize_t cobalt_lcd_read(struct file *, char *, size_t, loff_t *);
+static int cobalt_lcd_read_proc(char *, char **, off_t, int, int *, void *);
+static char *cobalt_lcddev_read_line(int, char *);
+static int cobalt_lcd_ioctl(struct inode *, struct file *,
+			    unsigned int, unsigned long);
+
+/* globals used throughout */
+#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_COBALT_OLDPROC
+static struct proc_dir_entry *proc_lcd;
+#endif
+static struct proc_dir_entry *proc_clcd;
+#endif
+static int lcd_present;
+static spinlock_t lcd_lock = SPIN_LOCK_UNLOCKED;
+/* this is for polling the power button on gen V */
+static u16 pm_event_port;
+
+/* various file operations we support for this driver */
+static struct file_operations lcd_fops = {
+	read:	cobalt_lcd_read,
+	ioctl:	cobalt_lcd_ioctl,
+	open:	cobalt_lcd_open,
+};
+
+/* device structure */
+static struct miscdevice lcd_dev = {
+	COBALT_LCD_MINOR,
+	"lcd",
+	&lcd_fops
+};
+
+static int disable_lcd;
+static int __init 
+lcd_disable_setup(char *str)
+{
+	disable_lcd = 1;
+	return 0;
+}
+__setup("nolcd", lcd_disable_setup);
+
+/* Read a control instruction from the LCD */
+static inline unsigned char 
+lcddev_read_inst(void)
+{
+        unsigned char a = 0;
+
+	if (cobt_is_3k()) {
+		outb(0x21, LCD_CONTROL_ADDRESS); /* RS=0, R/W=1, E=0 */
+		outb(0x20, LCD_CONTROL_ADDRESS); /* RS=0, R/W=1, E=1 */
+		a = inb(LCD_DATA_ADDRESS);
+		outb(0x21, LCD_CONTROL_ADDRESS); /* RS=0, R/W=1, E=0 */
+		outb(0x01, LCD_CONTROL_ADDRESS); /* RS=0, R/W=1, E=0 */
+	} else if (cobt_is_5k()) {
+		a = cobalt_i2c_read_byte(COBALT_I2C_DEV_LCD_INST | 
+			COBALT_I2C_READ, 0);
+	}
+
+	/* small delay */
+        udelay(100);
+
+        return a;
+}
+
+#define LCD_MAX_POLL 10000
+static inline void 
+lcddev_poll_wait(void) 
+{
+        int i=0;
+
+	while (i++ < LCD_MAX_POLL) {
+		if ((lcddev_read_inst() & 0x80) != 0x80)
+			break;
+	}
+}
+
+/* Write a control instruction to the LCD */
+static inline void 
+lcddev_write_inst(unsigned char data)
+{
+	lcddev_poll_wait();
+
+	if (cobt_is_3k()) {
+		outb(0x03, LCD_CONTROL_ADDRESS); /* RS=0, R/W=0, E=0 */
+		outb(data, LCD_DATA_ADDRESS);
+		outb(0x02, LCD_CONTROL_ADDRESS); /* RS=0, R/W=0, E=1 */
+		outb(0x03, LCD_CONTROL_ADDRESS); /* RS=0, R/W=0, E=0 */
+		outb(0x01, LCD_CONTROL_ADDRESS); /* RS=0, R/W=1, E=0 */
+	} else if (cobt_is_5k()) {
+		cobalt_i2c_write_byte(COBALT_I2C_DEV_LCD_INST | 
+			COBALT_I2C_WRITE, 0, data);
+	}
+
+	/* small delay */
+        udelay(100);
+}
+
+/* Write one byte of data to the LCD */
+static inline void 
+lcddev_write_data(unsigned char data)
+{
+	lcddev_poll_wait();
+
+	if (cobt_is_3k()) {
+		outb(0x07, LCD_CONTROL_ADDRESS); /* RS=1, R/W=0, E=0 */
+		outb(data, LCD_DATA_ADDRESS);
+		outb(0x06, LCD_CONTROL_ADDRESS); /* RS=1, R/W=0, E=1 */
+		outb(0x07, LCD_CONTROL_ADDRESS); /* RS=1, R/W=0, E=0 */
+		outb(0x05, LCD_CONTROL_ADDRESS); /* RS=1, R/W=1, E=0 */
+	} else if (cobt_is_5k()) {
+		cobalt_i2c_write_byte(COBALT_I2C_DEV_LCD_DATA | 
+			COBALT_I2C_WRITE, 0, data);
+	}
+
+	/* small delay */
+        udelay(100);
+}
+
+/* Read one byte of data from the LCD */
+static inline unsigned char 
+lcddev_read_data(void)
+{
+        unsigned char a = 0;
+
+	lcddev_poll_wait();
+
+	if (cobt_is_3k()) {
+		outb(0x25, LCD_CONTROL_ADDRESS); /* RS=1, R/W=1, E=0 */
+		outb(0x24, LCD_CONTROL_ADDRESS); /* RS=1, R/W=1, E=1 */
+		a = inb(LCD_DATA_ADDRESS);
+		outb(0x25, LCD_CONTROL_ADDRESS); /* RS=1, R/W=1, E=0 */
+		outb(0x01, LCD_CONTROL_ADDRESS); /* RS=1, R/W=1, E=0 */
+	} else if (cobt_is_5k()) {
+		a = cobalt_i2c_read_byte(COBALT_I2C_DEV_LCD_DATA | 
+			COBALT_I2C_READ, 0);
+	}
+
+	/* small delay */
+        udelay(100);
+
+        return a;
+}
+
+static inline void
+lcddev_init(void)
+{
+	lcddev_write_inst(0x38);
+	lcddev_write_inst(0x38);
+	lcddev_write_inst(0x38);
+	lcddev_write_inst(0x06);
+	lcddev_write_inst(0x0c);
+}
+
+static inline char 
+read_buttons(void)
+{
+	char r = 0;
+
+	if (cobt_is_3k()) {
+		outb(0x29, LCD_CONTROL_ADDRESS); /* Sel=0, Bi=1 */
+		r = inb(LCD_DATA_ADDRESS);
+	} else if (cobt_is_5k()) {
+		/* first, check to see if the power button has been pushed */
+		if (pm_event_port 
+		 && (inb(pm_event_port + SUPERIO_PM1_STATUS) 
+		     & SUPERIO_PWRBUTTON)) {
+			outb(SUPERIO_PWRBUTTON, 
+				pm_event_port + SUPERIO_PM1_STATUS);
+			return BUTTON_Power;
+		}
+
+		{
+			unsigned char inst = cobalt_i2c_read_byte(0x41, 0);
+			switch (inst) {
+			case 0x3e: r = BUTTON_Next_B; break;
+			case 0x3d: r = BUTTON_Enter_B; break;
+			case 0x1f: r = BUTTON_Left_B; break;
+			case 0x3b: r = BUTTON_Right_B; break;
+			case 0x2f: r = BUTTON_Up_B; break;
+			case 0x37: r = BUTTON_Down_B; break;
+			case 0x3f: r = BUTTON_NONE_B; break;
+			default: r = inst;
+			}
+		}
+	}
+	
+	return r;
+}
+
+static inline int 
+button_pressed(void)
+{
+        unsigned char b;
+	
+	spin_lock(&lcd_lock);
+	b = read_buttons();
+	spin_unlock(&lcd_lock);
+
+	switch (b) {
+	case BUTTON_Next:
+	case BUTTON_Next_B:
+	case BUTTON_Reset_B:
+	case BUTTON_Power:
+		return b;
+	default:
+	}
+
+        return 0;
+}
+
+static int 
+cobalt_lcd_ioctl(struct inode *inode, struct file *file,
+			    unsigned int cmd, unsigned long arg)
+{
+	struct lcd_display button_display, display;
+	unsigned long address, a;
+	int index;
+	int dlen = sizeof(struct lcd_display);
+
+	spin_lock(&lcd_lock);
+
+	switch (cmd) {
+	/* Turn the LCD on */
+	case LCD_On:
+		lcddev_write_inst(0x0F);
+		break;		
+
+	/* Turn the LCD off */
+	case LCD_Off:
+		lcddev_write_inst(0x08);
+		break;
+
+	/* Reset the LCD */
+	case LCD_Reset:
+		lcddev_write_inst(0x3F);
+		lcddev_write_inst(0x3F);
+		lcddev_write_inst(0x3F);
+		lcddev_write_inst(0x3F);
+		lcddev_write_inst(0x01);
+		lcddev_write_inst(0x06);
+		break;
+
+	/* Clear the LCD */
+	case LCD_Clear:
+       		lcddev_write_inst(0x01);     
+		break;
+
+	/* Move the cursor one position to the left */
+	case LCD_Cursor_Left:
+		lcddev_write_inst(0x10);
+		break;
+
+	/* Move the cursor one position to the right */
+	case LCD_Cursor_Right:
+		lcddev_write_inst(0x14);
+		break;	
+
+	/* Turn the cursor off */
+	case LCD_Cursor_Off:
+                lcddev_write_inst(0x0C);
+	        break;
+
+	/* Turn the cursor on */
+        case LCD_Cursor_On:
+                lcddev_write_inst(0x0F);
+                break;
+
+	/* Turn blinking off? I don't know what this does - TJS */
+        case LCD_Blink_Off:
+                lcddev_write_inst(0x0E);
+                break;
+
+	/* Get the current cursor position */
+        case LCD_Get_Cursor_Pos:
+                display.cursor_address = lcddev_read_inst();
+                display.cursor_address = display.cursor_address & 0x07F;
+                copy_to_user((struct lcd_display *)arg, &display, dlen);
+                break;
+
+	/* Set the cursor position */
+        case LCD_Set_Cursor_Pos:
+                copy_from_user(&display, (struct lcd_display *)arg, dlen);
+                a = display.cursor_address | LCD_Addr;
+                lcddev_write_inst(a);
+                break;
+
+	/* Get the value at the current cursor position? - TJS */
+        case LCD_Get_Cursor:
+                display.character = lcddev_read_data();
+                copy_to_user((struct lcd_display *)arg, &display, dlen);
+                lcddev_write_inst(0x10);
+                break;
+
+	/* Set the character at the cursor position? - TJS */
+	case LCD_Set_Cursor:
+                copy_from_user(&display, (struct lcd_display *)arg, dlen);
+                lcddev_write_data(display.character);
+                lcddev_write_inst(0x10);
+                break;
+
+	/* Dunno what this does - TJS */ 
+	case LCD_Disp_Left:
+		lcddev_write_inst(0x18);
+		break;
+
+	/* Dunno what this does - TJS */ 
+	case LCD_Disp_Right:
+		lcddev_write_inst(0x1C);
+		break;
+
+	/* Dunno what this does - TJS */ 
+	case LCD_Home:
+		lcddev_write_inst(0x02);
+		break;
+
+	/* Write a string to the LCD */
+	case LCD_Write:
+                copy_from_user(&display, (struct lcd_display *)arg, dlen);
+
+		/* First line */
+                lcddev_write_inst(0x80);
+		for (index = 0; index < display.size1; index++)
+			lcddev_write_data(display.line1[index]);
+
+		/* Second line */
+		lcddev_write_inst(0xC0);	
+		for (index = 0; index < display.size2; index++)
+			lcddev_write_data(display.line2[index]);
+		break;	
+
+	/* Read what's on the LCD */
+        case LCD_Read:
+                for (address = DD_R00; address <= DD_R01; address++) {
+                        lcddev_write_inst(address | LCD_Addr);
+                        display.line1[address] = lcddev_read_data();
+                }
+                display.line1[DD_R01] = '\0';
+
+                for (address = DD_R10; address <= DD_R11; address++) {
+                        lcddev_write_inst(address | LCD_Addr);
+                        display.line2[address - DD_R10] = lcddev_read_data();
+		}
+                display.line2[DD_R01] = '\0';
+
+                copy_to_user((struct lcd_display *)arg, &display, dlen);
+                break;
+
+	case LCD_Raw_Inst:
+                copy_from_user(&display, (struct lcd_display *)arg, dlen);
+                lcddev_write_inst(display.character);
+                break;
+
+        case LCD_Raw_Data:
+                copy_from_user(&display, (struct lcd_display *)arg, dlen);
+                lcddev_write_data(display.character);
+                break;
+
+	case LCD_Type:
+		if (cobt_is_3k()) {
+	        	put_user(LCD_TYPE_PARALLEL_B, (int *)arg);
+		} else if (cobt_is_5k()) {
+	        	put_user(LCD_TYPE_I2C, (int *)arg);
+		}
+		break;
+
+	/* Read the buttons */
+        case BUTTON_Read:
+                button_display.buttons = read_buttons();
+                copy_to_user((struct lcd_display *)arg, &button_display, dlen);
+                break;
+	
+	/* a slightly different api that allows you to set 32 leds */
+	case LED32_Set:
+                cobalt_led_set_lazy(arg);
+		break;
+
+	case LED32_Bit_Set:
+                cobalt_led_set_lazy(cobalt_led_get() | arg);
+		break;
+
+	case LED32_Bit_Clear:
+                cobalt_led_set_lazy(cobalt_led_get() & ~arg);
+		break;
+
+	/* set all the leds */
+	case LED_Set:
+                copy_from_user(&display, (struct lcd_display *)arg, dlen);
+                cobalt_led_set_lazy(display.leds);
+		break;
+
+	/* set a single led */
+	case LED_Bit_Set:
+                copy_from_user(&display, (struct lcd_display *)arg, dlen);
+                cobalt_led_set_lazy(cobalt_led_get() | display.leds);
+		break;
+
+	/* clear an led */
+	case LED_Bit_Clear:
+                copy_from_user(&display, (struct lcd_display *)arg, dlen);
+                cobalt_led_set_lazy(cobalt_led_get() & ~display.leds);
+		break;
+
+	default:
+	}
+
+	spin_unlock(&lcd_lock);
+
+	return 0;
+}
+
+static int 
+cobalt_lcd_open(struct inode *inode, struct file *file)
+{
+	if (!lcd_present)
+		return -ENXIO;
+	else
+		return 0;
+}
+
+/* LED daemon sits on this, we wake it up once a key is pressed */
+static ssize_t 
+cobalt_lcd_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	int buttons_now;
+	static atomic_t lcd_waiters = ATOMIC_INIT(0);
+
+	if (atomic_read(&lcd_waiters) > 0)
+		return -EINVAL;
+	atomic_inc(&lcd_waiters);
+
+	while (((buttons_now = button_pressed()) == 0) &&
+	       !(signal_pending(current)))
+	{
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout((2 * HZ));
+	}
+	atomic_dec(&lcd_waiters);
+
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	return buttons_now;
+}
+
+/* read a single line from the LCD into a string */
+static char *
+cobalt_lcddev_read_line(int lineno, char *line)
+{
+	unsigned long addr, min, max;
+
+	switch (lineno) {
+	case 0:
+		min = DD_R00;
+		max = DD_R01;
+		break;
+	case 1:
+		min = DD_R10;
+		max = DD_R11;
+		break;
+	default:
+		min = 1;
+		max = 0;
+	}
+
+	spin_lock(&lcd_lock);
+	for (addr = min; addr <= max; addr++) {
+                lcddev_write_inst(addr | LCD_Addr);
+                udelay(150);
+                line[addr-min] = lcddev_read_data();
+                udelay(150);
+	}
+	spin_unlock(&lcd_lock);
+	line[addr-min] = '\0';
+
+	return line;
+}
+
+static int 
+cobalt_lcd_read_proc(char *buf, char **start, off_t offset,
+				int len, int *eof, void *private)
+{
+	int plen = 0;
+	char line[COBALT_LCD_LINELEN+1];
+
+	/* first line */
+	cobalt_lcddev_read_line(0, line);
+	plen += sprintf(buf+plen, "%s\n", line);
+
+	/* second line */
+	cobalt_lcddev_read_line(1, line);
+	plen += sprintf(buf+plen, "%s\n", line);
+	
+	if (offset >= plen) {
+		*eof = 1;
+		return 0;
+	}
+
+	*start = buf + offset;
+	plen -= offset;
+
+	if (len > plen) {
+		return plen;
+	} else {
+        	return len;
+	}
+}
+
+int __init 
+cobalt_lcd_init(void)
+{	
+	if (disable_lcd) {
+		printk(KERN_INFO "%s version %d.%d [DISABLED]\n",
+		       LCD_DRIVER, LCD_DRIVER_VMAJ, LCD_DRIVER_VMIN);
+		return 0;
+	}
+
+	misc_register(&lcd_dev);
+    
+	/* flag ourselves as present */
+	lcd_present = 1;
+
+	/* initialize the device */
+	lcddev_init();
+
+	if (cobt_is_5k()) {
+		u16 pm_port;
+		unsigned long flags;
+
+		spin_lock_irqsave(&cobalt_superio_lock, flags);
+		
+		/* superio power button -- get ioport */
+		outb(SUPERIO_LOGICAL_DEV, SUPERIO_INDEX_PORT);
+		outb(SUPERIO_DEV_PM, SUPERIO_DATA_PORT);
+		outb(SUPERIO_ADDR_HIGH, SUPERIO_INDEX_PORT);
+		pm_port = inb(SUPERIO_DATA_PORT) << 8;
+		outb(SUPERIO_ADDR_LOW, SUPERIO_INDEX_PORT);
+		pm_port |= inb(SUPERIO_DATA_PORT);
+		if (pm_port) {
+			/* get the PM1 event base address */
+			outb(0x08, pm_port);
+			pm_event_port = inb(pm_port + 1);
+			outb(0x09, pm_port);
+			pm_event_port |= inb(pm_port + 1) << 8;
+			if (!pm_event_port) {
+				EPRINTK("pm_event_port is 0\n");
+			}
+		} else {
+			EPRINTK("pm_port is 0\n");
+		}
+
+		spin_unlock_irqrestore(&cobalt_superio_lock, flags);
+	}
+
+#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_COBALT_OLDPROC
+	/* create /proc/lcd */
+	proc_lcd = create_proc_read_entry("lcd", S_IRUSR, NULL, 
+		cobalt_lcd_read_proc, NULL);
+	if (!proc_lcd) {
+		EPRINTK("can't create /proc/lcd\n");
+	}
+#endif
+	proc_clcd = create_proc_read_entry("lcd", S_IRUSR, proc_cobalt, 
+		cobalt_lcd_read_proc, NULL);
+	if (!proc_clcd) {
+		EPRINTK("can't create /proc/cobalt/lcd\n");
+	}
+#endif
+
+	printk(KERN_INFO "%s version %d.%d\n", LCD_DRIVER,
+	       LCD_DRIVER_VMAJ, LCD_DRIVER_VMIN);
+
+	return 0;
+}
+
+#endif /* CONFIG_COBALT_LCD */
diff -ruN dist-2.4.5/drivers/cobalt/led.c cobalt-2.4.5/drivers/cobalt/led.c
--- dist-2.4.5/drivers/cobalt/led.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/led.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,447 @@
+/*
+ * $Id: led.c,v 1.12 2001/05/30 07:19:48 thockin Exp $
+ * led.c : driver for Cobalt LEDs
+ *
+ * Copyright 1996-2000 Cobalt Networks, Inc.
+ * Copyright 2001 Sun Microsystems, Inc.
+ *
+ * By:	Andrew Bose
+ *	Timothy Stonis
+ *	Tim Hockin
+ *	Adrian Sun
+ *	Duncan Laurie
+ *
+ * This should be SMP safe.  There is one definite critical region: the
+ * handler list (led_handler_lock).  The led_state is atomic, so should be 
+ * safe against simultaneous writes.  Bit banging of lights is currently 
+ * also a protected region (led_hw_lock).
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_COBALT_LED
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/malloc.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <asm/io.h>
+#include <asm/atomic.h>
+#include <linux/delay.h>
+
+#include <linux/cobalt.h>
+#include <linux/cobalt-systype.h>
+#include <linux/cobalt-led.h>
+#include <linux/cobalt-i2c.h>
+#include <linux/cobalt-superio.h>
+
+#define LED_DRIVER              "Cobalt Networks LED driver"
+#define LED_DRIVER_VMAJ         1
+#define LED_DRIVER_VMIN         0
+
+/* the rate at which software controlled frontpanel LEDs blink */
+#define FPLED_HZ		(HZ/20)
+
+/* 
+ * this is the abstracted state of active LEDs - see the defines for LED_* 
+ *
+ * NOTE: this is an atomic integer, and does not have full 32 bit size : the
+ * best we can count on is 24 bits, says the headers for atomic ops
+ */
+static atomic_t led_state = ATOMIC_INIT(0);
+
+/* leds are PCI on genIII */
+static struct pci_dev *led_dev;
+/* on XTR the front panel LEDs are software controlled */
+struct led_handler {
+	unsigned int (*function)(void *);
+	void *data;
+	struct led_handler *next;
+	struct led_handler *prev;
+};
+struct led_handler *led_handler_list;
+static spinlock_t led_handler_lock = SPIN_LOCK_UNLOCKED;
+static u16 superio_rtc_port; /* this is the IO port for the power button */
+static struct timer_list timer;
+
+static spinlock_t led_hw_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ *    RaQ 3
+ *    RaQ 4
+ *    Qube 3
+ */
+#define RAQ3_SHUTLOGO_ADDR	0x7e
+#define RAQ3_SHUTDOWN_OFF	0x40 /* reverse polarity */
+#define RAQ3_COBALTLOGO_ON	0x80
+#define QUBE3_LIGHTBAR_ON	0xc0 /* direct polarity */
+#define RAQ3_WEBLIGHT_ADDR	0xb8
+#define RAQ3_WEBLIGHT_ON	0x80
+
+/*
+ *    RaQ XTR
+ */
+#define RAQXTR_FPLED_ETH0_TXRX		0x8000
+#define RAQXTR_FPLED_ETH0_LINK		0x1000
+#define RAQXTR_FPLED_ETH1_TXRX		0x4000
+#define RAQXTR_FPLED_ETH1_LINK		0x0800
+#define RAQXTR_FPLED_DISK0		0x2000
+#define RAQXTR_FPLED_DISK1		0x0200
+#define RAQXTR_FPLED_DISK2		0x0080
+#define RAQXTR_FPLED_DISK3		0x0040
+#define RAQXTR_FPLED_DISK_FAULT		0x0010
+#define RAQXTR_FPLED_WEB 		0x0400
+#define RAQXTR_FPLED_HEART		0x0100
+#define RAQXTR_FPLED_SPARE		0x0020
+
+#define FPLED_MASK 			(LED_ETH0_TXRX | LED_ETH0_LINK | \
+					 LED_ETH1_TXRX | LED_ETH1_LINK | \
+		   			 LED_DISK0 | LED_DISK1 | \
+					 LED_DISK2 | LED_DISK3 | \
+					 LED_WEBLIGHT) 
+
+static void 
+xtr_set_logo_led(const int newstate)
+{
+	if (cobt_is_5k()) {
+		u8 val; 
+		unsigned long flags;
+
+		/* get the RTC lock */
+		spin_lock_irqsave(&rtc_lock, flags);
+
+		/* set bank 2 */
+		outb(SUPERIO_RTC_CRA, superio_rtc_port);
+		val = inb(superio_rtc_port + 1) & 0x8f;
+		outb(val | SUPERIO_RTC_BANK_2, superio_rtc_port + 1);
+
+		/* get the current state of APCR4 */
+		outb(SUPERIO_APCR4, superio_rtc_port);
+		val = inb(superio_rtc_port + 1) & 0x3f;
+
+		if (newstate) {
+			val |= (newstate & LED_SYSFAULT) ? 0x80 : 0x0;
+		} else { 
+			val |= 0x40; /* logo is off */
+		}
+		outb(val, superio_rtc_port + 1);
+
+		/* go back to bank 0 */
+		outb(SUPERIO_RTC_CRA, superio_rtc_port);
+		val = inb(superio_rtc_port + 1) & 0x8f;
+		outb(val | SUPERIO_RTC_BANK_0, superio_rtc_port + 1);
+
+		spin_unlock_irqrestore(&rtc_lock, flags);
+	}
+}
+
+/* 
+ * actually set the leds (icky details hidden within) 
+ * this protects against itself with led_hw_lock
+ * */
+static void 
+set_led_hw(const unsigned int newstate)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&led_hw_lock, flags);
+
+	if (cobt_is_raq3() && led_dev) {
+		unsigned char tmp;
+		/* RaQ 3, RaQ 4
+		 * - shutdown light
+		 * - logo light
+		 * - web light
+		 */
+
+		/* read the current state of shutdown/logo lights */
+		pci_read_config_byte(led_dev, RAQ3_SHUTLOGO_ADDR, &tmp);
+
+		/* reverse polarity for shutdown light */
+		if (newstate & LED_SHUTDOWN)
+			tmp &= ~RAQ3_SHUTDOWN_OFF;
+		else
+			tmp |= RAQ3_SHUTDOWN_OFF;
+
+		/* logo light is straight forward */
+		if (newstate & LED_COBALTLOGO)
+			tmp |= RAQ3_COBALTLOGO_ON;
+		else
+			tmp &= ~RAQ3_COBALTLOGO_ON;
+
+		/* write new shutdown/logo light state */
+		pci_write_config_byte(led_dev, RAQ3_SHUTLOGO_ADDR, tmp);
+
+		/* read web light state */
+		pci_read_config_byte(led_dev, RAQ3_WEBLIGHT_ADDR, &tmp);
+		if (newstate & LED_WEBLIGHT) {
+			tmp |= RAQ3_WEBLIGHT_ON;
+		} else {
+			tmp &= ~RAQ3_WEBLIGHT_ON;
+		}
+
+		/* write new web light state */
+		pci_write_config_byte(led_dev, RAQ3_WEBLIGHT_ADDR, tmp);
+	} else if (cobt_is_qube3() && led_dev) {
+		unsigned char tmp;
+		/* Qube 3
+		 * - no shutdown light
+		 * - lightbar instead of logo
+		 * - no web led (wired to 2nd IDE reset for staggered startup)
+		 */
+
+		/* read the current state of lightbar */
+		pci_read_config_byte(led_dev, RAQ3_SHUTLOGO_ADDR, &tmp);
+		if (newstate & LED_COBALTLOGO) {
+			tmp |= QUBE3_LIGHTBAR_ON;
+		} else {
+			tmp &= ~QUBE3_LIGHTBAR_ON;
+		}
+
+		/* write new lightbar state */
+		pci_write_config_byte(led_dev, RAQ3_SHUTLOGO_ADDR, tmp);
+	} else if (cobt_is_raqxtr()) {
+		unsigned int tmp = 0;
+		if (newstate & LED_WEBLIGHT) {
+			tmp |= RAQXTR_FPLED_WEB;
+		}
+		if (newstate & LED_ETH0_TXRX) {
+			tmp |= RAQXTR_FPLED_ETH0_TXRX;
+		}
+		if (newstate & LED_ETH0_LINK) {
+			tmp |= RAQXTR_FPLED_ETH0_LINK;
+		}
+		if (newstate & LED_ETH1_TXRX) {
+			tmp |= RAQXTR_FPLED_ETH1_TXRX;
+		}
+		if (newstate & LED_ETH1_LINK) {
+			tmp |= RAQXTR_FPLED_ETH1_LINK;
+		}
+		if (newstate & LED_DISK0) {
+			tmp |= RAQXTR_FPLED_DISK0;
+		}
+		if (newstate & LED_DISK1) {
+			tmp |= RAQXTR_FPLED_DISK1;
+		}
+		if (newstate & LED_DISK2) {
+			tmp |= RAQXTR_FPLED_DISK2;
+		}
+		if (newstate & LED_DISK3) {
+			tmp |= RAQXTR_FPLED_DISK3;
+		}
+		if (newstate & LED_HEART) {
+			tmp |= RAQXTR_FPLED_HEART;
+		}
+		if (newstate & LED_SPARE) {
+			tmp |= RAQXTR_FPLED_SPARE;
+		}
+	  	cobalt_i2c_write_byte(COBALT_I2C_DEV_LED_I, 0, tmp & 0xff);
+	  	cobalt_i2c_write_byte(COBALT_I2C_DEV_LED_II, 0, tmp >> 8);
+		xtr_set_logo_led(newstate & LED_COBALTLOGO);
+	}
+
+	spin_unlock_irqrestore(&led_hw_lock, flags);
+}
+
+static inline void
+do_led_set(const unsigned int leds)
+{
+	atomic_set(&led_state, leds);
+	set_led_hw(leds);
+}
+
+static inline unsigned int
+do_led_get(void)
+{
+	return atomic_read(&led_state);
+}
+
+/* blip the front panel leds */
+static void led_timer_func(unsigned long data)
+{
+	if (cobt_is_5k()) {
+		unsigned int leds = 0;
+		struct led_handler *p;
+		unsigned long flags;
+
+		/* snapshot the stored state */
+		leds = do_led_get();
+
+		/* call all registered callbacks */
+		spin_lock_irqsave(&led_handler_lock, flags);
+		p = led_handler_list;
+		while (p) {
+			leds |= p->function(p->data);
+			p = p->next;
+		}
+		spin_unlock_irqrestore(&led_handler_lock, flags);
+		
+		/* set the led state, which sets led_state */
+		do_led_set(leds);
+
+		/* reset the stored state */
+		atomic_set(&led_state, leds & ~FPLED_MASK);
+
+		/* re-arm ourself */
+		mod_timer(&timer, jiffies + FPLED_HZ);
+	}
+}
+
+void 
+cobalt_led_set(const unsigned int leds)
+{
+	do_led_set(leds);
+}
+
+void 
+cobalt_led_set_lazy(const unsigned int leds)
+{
+	if (cobt_is_3k()) {
+		/* no timer on GEN_III, thus no _lazy() form */
+		do_led_set(leds);
+	} else if (cobt_is_5k()) {
+		/* the next led timer run will catch these changes */
+		atomic_set(&led_state, leds);
+	}
+}
+
+unsigned int 
+cobalt_led_get(void)
+{
+	unsigned int r;
+
+	r = do_led_get();
+
+	return r;
+}
+
+int 
+cobalt_fpled_register(unsigned int (*function)(void *), void *data)
+{
+	int r = -1;
+
+	if (cobt_is_5k()) {
+		struct led_handler *newh;
+		unsigned long flags;
+
+		newh = kmalloc(sizeof(*newh), GFP_ATOMIC);
+		if (!newh) {
+			EPRINTK("can't allocate memory for handler %p(%p)\n",
+				function, data);
+			return -1;
+		}
+
+		spin_lock_irqsave(&led_handler_lock, flags);
+	
+		/* head insert */
+		newh->function = function;
+		newh->data = data;
+		newh->next = led_handler_list;
+		newh->prev = NULL;
+		if (led_handler_list) {
+			led_handler_list->prev = newh;
+		}
+		led_handler_list = newh;
+	
+		spin_unlock_irqrestore(&led_handler_lock, flags);
+		r = 0;
+	}
+
+	return r;
+}
+
+int 
+cobalt_fpled_unregister(unsigned int (*function)(void *), void *data)
+{
+	int r = -1;
+
+	if (cobt_is_5k()) {
+		struct led_handler *p;
+		unsigned long flags;
+	
+		spin_lock_irqsave(&led_handler_lock, flags);
+
+		p = led_handler_list;
+		while (p) {
+			if (p->function == function && p->data == data) {
+				if (p->prev) {
+					p->prev->next = p->next;
+				}
+				if (p->next) {
+					p->next->prev = p->prev;
+				}
+				r = 0;
+				break;
+			}
+			p = p->next;
+		}
+
+		spin_unlock_irqrestore(&led_handler_lock, flags);
+	}
+
+	return r;
+}
+
+int __init 
+cobalt_led_init(void)
+{	
+	unsigned int leds = LED_SHUTDOWN | LED_COBALTLOGO;
+
+	if (cobt_is_3k()) {
+		/* LEDs for RaQ3/4 and Qube3 are on the PMU */
+		led_dev = pci_find_device(PCI_VENDOR_ID_AL,
+					  PCI_DEVICE_ID_AL_M7101,
+					  NULL);
+		if (!led_dev) {
+			EPRINTK("can't find PMU for LED control\n");
+			return -1;
+		}
+	} else if (cobt_is_5k()) {
+		unsigned long flags;
+
+		/*
+		 * get the superio port for the power button
+		 */
+
+		spin_lock_irqsave(&cobalt_superio_lock, flags);
+	
+		/* select apc */
+		outb(SUPERIO_LOGICAL_DEV, SUPERIO_INDEX_PORT);
+		outb(SUPERIO_DEV_RTC, SUPERIO_DATA_PORT);
+
+		/* determine base address */
+		outb(SUPERIO_ADDR_HIGH, SUPERIO_INDEX_PORT);
+		superio_rtc_port = inb(SUPERIO_DATA_PORT) << 8;
+		outb(SUPERIO_ADDR_LOW, SUPERIO_INDEX_PORT);
+		superio_rtc_port |= inb(SUPERIO_DATA_PORT);
+		if (!superio_rtc_port) {
+			EPRINTK("superio_rtc_port is 0\n");
+		}
+		spin_unlock_irqrestore(&cobalt_superio_lock, flags);
+
+		/* setup up timer for fp leds */
+		init_timer(&timer);
+		timer.expires = jiffies + FPLED_HZ;
+		timer.data = 0;
+		timer.function = &led_timer_func;
+		add_timer(&timer);
+	}
+
+	/* set the initial state */
+	leds |= cobalt_cmos_read_flag(CMOS_SYSFAULT_FLAG) ? LED_SYSFAULT : 0;
+	do_led_set(leds);
+
+	printk(KERN_INFO "%s version %d.%d\n", LED_DRIVER,
+		LED_DRIVER_VMAJ, LED_DRIVER_VMIN);
+
+	return 0;
+}
+
+#endif /* CONFIG_COBALT_LED */
diff -ruN dist-2.4.5/drivers/cobalt/Makefile cobalt-2.4.5/drivers/cobalt/Makefile
--- dist-2.4.5/drivers/cobalt/Makefile	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/Makefile	Thu May 31 14:32:15 2001
@@ -0,0 +1,19 @@
+#
+# Makefile for the Sun/Cobalt device drivers
+#
+
+O_TARGET := cobalt.o
+
+export-objs	:= init.o i2c.o lcd.o led.o systype.o serialnum.o wdt.o \
+		   thermal.o fans.o
+
+obj-$(CONFIG_COBALT)		+= init.o systype.o i2c.o acpi.o net.o
+obj-$(CONFIG_COBALT_SERNUM)	+= serialnum.o
+obj-$(CONFIG_COBALT_LCD)	+= lcd.o
+obj-$(CONFIG_COBALT_LED)	+= led.o
+obj-$(CONFIG_COBALT_WDT)	+= wdt.o
+obj-$(CONFIG_COBALT_THERMAL)	+= thermal.o
+obj-$(CONFIG_COBALT_FANS)	+= fans.o
+obj-$(CONFIG_COBALT_RULER)	+= ruler.o
+
+include $(TOPDIR)/Rules.make
diff -ruN dist-2.4.5/drivers/cobalt/net.c cobalt-2.4.5/drivers/cobalt/net.c
--- dist-2.4.5/drivers/cobalt/net.c	Wed Dec 31 16:00:00 1969
+++ cobalt-2.4.5/drivers/cobalt/net.c	Thu May 31 14:32:15 2001
@@ -0,0 +1,128 @@
+/* 
+ * cobalt net wrappers
+ * Copyright (c) 2000, Cobalt Networks, Inc.
+ * $Id: net.c,v 1.5 2001/04/27 03:13:53 thockin Exp $
+ * author: thockin@sun.com
+ *
+ * This should be SMP safe.  The only critical data is the list of devices.
+ * The LED handler runs at timer-interrupt, so we must use the IRQ safe forms
+ * of the locks. --TPH
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <asm/io.h>
+#include <linux/cobalt.h>
+#include <linux/cobalt-net.h>
+#include <linux/cobalt-led.h>
+
+#define MAX_COBT_NETDEVS	2
+static struct net_device *netdevs[MAX_COBT_NETDEVS];
+static int n_netdevs;
+static spinlock_t cobaltnet_lock = SPIN_LOCK_UNLOCKED;
+
+#if defined(CONFIG_COBALT_LED)
+static unsigned int
+net_led_handler(void *data)
+{
+	int i;
+	unsigned int leds = 0;
+	static int txrxmap[MAX_COBT_NETDEVS] = {LED_ETH0_TXRX, LED_ETH1_TXRX};
+	static int linkmap[MAX_COBT_NETDEVS] = {LED_ETH0_LINK, LED_ETH1_LINK};
+	unsigned long flags;
+	static unsigned long net_old[MAX_COBT_NETDEVS];
+
+	spin_lock_irqsave(&cobaltnet_lock, flags);
+
+	for (i = 0; i < n_netdevs; i++) {
+		unsigned long txrxstate;
+		struct net_device *dev = netdevs[i];
+		if (!dev) {
+			continue;
+		}
+		/* check for link */
+		if (dev->link_check && dev->link_check(dev)) {
+			leds |= linkmap[i];
+		}
+		/* check for tx/rx */
+		txrxstate = dev->trans_start ^ dev->last_rx;
+		if (txrxstate != net_old[i]) {
+			leds |= txrxmap[i];
+			net_old[i] = txrxstate;
+		}
+	}
+
+	spin_unlock_irqrestore(&cobaltnet_lock, flags);
+
+	return leds;
+}
+#endif
+
+/* 
+ * We try to be VERY explicit here.  Fine for now, may eventually break down.
+ */
+void 
+cobalt_net_register(struct net_device *ndev)
+{
+	unsigned long flags;
+	int i;
+	
+        if (!ndev) {
+	       return;
+	}
+
+	/* we'll track the first MAX_COBT_NETDEVS NICs */
+	if (n_netdevs >= MAX_COBT_NETDEVS) {
+	       return;
+	}
+
+	spin_lock_irqsave(&cobaltnet_lock, flags);
+
+	/* find a free slot */
+	for (i = 0; i < n_netdevs; i++) {
+		if (!netdevs[i]) {
+			netdevs[i] = ndev;
+			n_netdevs++;
+		}
+	}
+
+	spin_unlock_irqrestore(&cobaltnet_lock, flags);
+}
+
+void 
+cobalt_net_unregister(struct net_device *ndev)
+{
+	int i;
+	unsigned long flags;
+	
+        if (!ndev) {
+	       return;
+	}
+
+	spin_lock_irqsave(&cobaltnet_lock, flags);
+
+	/* try to remove it from the list */
+	for (i = 0; i < n_netdevs; i++) {
+		if (netdevs[i] == ndev) {
+			netdevs[i] = NULL;
+		}
+	}
+
+	spin_unlock_irqrestore(&cobaltnet_lock, flags);
+}
+
+int __init
+cobalt_net_init(void)
+{
+#if defined(CONFIG_COBALT_LED)
+	/* register an LED handler */
+	cobalt_fpled_register(net_led_handler, NULL);
+#endif
+
+	return 0;
+}

--------------E6133A5CDB35508348DA526E--

