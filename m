Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290820AbSAYVzo>; Fri, 25 Jan 2002 16:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290822AbSAYVzh>; Fri, 25 Jan 2002 16:55:37 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:34690 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S290821AbSAYVzZ>;
	Fri, 25 Jan 2002 16:55:25 -0500
Message-ID: <3C51D44B.2050402@acm.org>
Date: Fri, 25 Jan 2002 15:55:23 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: LED device driver
Content-Type: multipart/mixed;
 boundary="------------000901060004040303020205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000901060004040303020205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A lot of boards have LEDs on the front, it is useful to be able to 
control these LEDs from userland.  I have implemented a start at a 
device driver front-end for this that gives a generic interface.  I'd 
appreciate comments on it.  I have not tied things like the num lock 
LEDs to this, but that might be doable later.

Although it doesn't include it right now, this could be extended to add 
things like 7-segment LEDs, scrolling displays, etc.

The basic thought is to allow low-level LED drivers to register with 
this with a name and capabilities.  This driver would give a consistent 
way to advertise and use those capabilities to the user application, so 
it could discover LEDs by name, know their capabilities, etc.

-Corey

--------------000901060004040303020205
Content-Type: text/plain;
 name="linux-led.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-led.diff"

--- ./drivers/char/led.c.led	Fri Jan 25 09:36:27 2002
+++ ./drivers/char/led.c	Fri Jan 25 11:03:22 2002
@@ -0,0 +1,316 @@
+/*
+ * Device driver for controlling LEDs.  See linux/led.h for info on
+ * how to use this.
+ *
+ * This currently only supports mono and bicolor LEDs, but support for
+ * fancier LEDs (scrolling text or numeric LEDs, for instance) could
+ * easily be added.
+ *
+ * Corey Minyard <minyard@mvista.com>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <linux/init.h>
+#include <linux/led.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+
+#define VERSION "1.0"
+
+/* A lock that is held when manipulating LED info. */
+static spinlock_t led_lock;
+
+/* A linked list of all the LEDs registered. */
+static struct led_reg_info *leds;
+
+/* Register a new LED with the driver. */
+int register_led_info(struct led_reg_info *info)
+{
+	struct led_reg_info *led;
+	int		    rv = 0;
+
+	spin_lock(&led_lock);
+	info->next = NULL;
+	led = leds;
+	if (led == NULL)
+	{
+		leds = info;
+	}
+	else
+	{
+		while (led->next != NULL)
+		{
+			if (strcmp(led->info->name, info->info->name) == 0)
+			{
+				/* Registering a duplicate. */
+				rv = -1;
+				goto out;
+			}
+			led = led->next;
+		}
+		led->next = info;
+	}
+	MOD_INC_USE_COUNT;
+
+out:
+	spin_unlock(&led_lock);
+
+	return rv;
+}
+
+/* Unregister an LED from the driver. */
+int unregister_led_info(struct led_reg_info *info)
+{
+	int                 rv = -1;
+	struct led_reg_info *led;
+
+	if (info == NULL)
+	{
+		return -1;
+	}
+
+	spin_lock(&led_lock);
+	led = leds;
+	if (led == info)
+	{
+	        MOD_DEC_USE_COUNT;
+		leds = leds->next;
+	}
+	else
+	{
+		while (led->next != NULL)
+		{
+			if (led->next == info)
+			{
+				MOD_DEC_USE_COUNT;
+				led->next = info->next;
+				rv = 0;
+				goto out;
+			}
+			led = led->next;
+		}
+	}
+out:
+	spin_unlock(&led_lock);
+	return rv;
+}
+
+/* Return the number of LEDs registered. */
+static int count_leds(void)
+{
+	struct led_reg_info *led;
+	int                 count = 0;
+
+	spin_lock(&led_lock);
+	led = leds;
+	while (led != NULL)
+	{
+		count = count + 1;
+		led = led->next;
+	}
+	spin_unlock(&led_lock);
+
+	return count;
+}
+
+/* Find an LED by its number.  Must be called with the led spin lock
+   held. */
+static struct led_reg_info *get_led_by_num(int num)
+{
+	struct led_reg_info *led;
+	int                 count = num;
+
+	led = leds;
+	while (led != NULL)
+	{
+		if (count == 0)
+		{
+			led->info->led_num = num;
+			return led;
+		}
+		count = count - 1;
+		led = led->next;
+	}
+
+	return NULL;
+}
+
+/* Find an LED by its name.  Must be called with the led spin lock
+   held. */
+static struct led_reg_info *get_led_by_name(char *name)
+{
+	struct led_reg_info *led;
+	int                 count = 0;
+
+	led = leds;
+	while (led != NULL)
+	{
+		if (strcmp(name, led->info->name) == 0)
+		{
+			led->info->led_num = count;
+			return led;
+		}
+		count++;
+		led = led->next;
+	}
+
+	return NULL;
+}
+
+/* The IOCTL handler for the LED driver. */
+static int led_ioctl(struct inode  *inode,
+		     struct file   *file,
+		     unsigned int  cmd,
+		     unsigned long arg)
+{
+	int i;
+	struct led_reg_info *led;
+	struct led_info     info;
+	struct led_op       op;
+
+	switch(cmd)
+	{
+	case LEDIOC_GETCOUNT:
+		return count_leds();
+
+	case LEDIOC_GETINFO_BY_NUM:
+	case LEDIOC_GETINFO_BY_NAME:
+		i = copy_from_user(&info, (void*)arg, sizeof(info));
+		if (i)
+		{
+			return -EFAULT;
+		}
+
+		spin_lock(&led_lock);
+		if (cmd == LEDIOC_GETINFO_BY_NUM)
+			led = get_led_by_num(info.led_num);
+		else
+			led = get_led_by_name(info.name);
+		if (led == NULL)
+		{
+			spin_unlock(&led_lock);
+			return -EINVAL;
+		}
+
+		info.type = led->info->type;
+		info.led_num = led->info->led_num;
+		strcpy(info.name, led->info->name);
+		info.info = led->info->info;
+		i = copy_to_user((void *)arg, &info, sizeof(info));
+
+		spin_unlock(&led_lock);
+
+		if (i)
+		{
+			return -EFAULT;
+		}
+		return 0;
+
+	case LEDIOC_OP:
+		i = copy_from_user(&op, (void*)arg, sizeof(op));
+		if (i)
+		{
+			return -EFAULT;
+		}
+
+		spin_lock(&led_lock);
+		led = get_led_by_name(op.name);
+		if (led == NULL)
+		{
+			spin_unlock(&led_lock);
+			return -EINVAL;
+		}
+
+		i = led->handle_led_op(led, &op);
+		if (!i)
+		{
+		    i = copy_to_user((void *)arg, &op, sizeof(op));
+		    if (i)
+		    {
+			i = -EFAULT;
+		    }
+		}
+		spin_unlock(&led_lock);
+
+		return i;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+/* Not much to do for opening. */ 
+static int led_open(struct inode *inode, struct file *file)
+{
+	switch(MINOR(inode->i_rdev))
+	{
+		case LED_MINOR:
+			return 0;
+
+		default:
+			return -ENODEV;
+	}
+}
+
+/* Closing is really easy. */ 
+static int led_close(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+ 
+static struct file_operations led_fops = {
+	owner:		THIS_MODULE,
+	llseek:		NULL,
+	read:		NULL,
+	write:		NULL,
+	ioctl:		led_ioctl,
+	open:		led_open,
+	release:	led_close,
+};
+
+static struct miscdevice led_miscdev=
+{
+	LED_MINOR,
+	"led",
+	&led_fops
+};
+
+
+/* Remove the LED driver. */
+static void __exit led_exit(void)
+{
+	misc_deregister(&led_miscdev);
+}
+
+/* Set up the LED device driver. */
+static int __init led_init(void)
+{
+	int ret;
+
+	printk("generic LED driver: v%s Corey Minyard (minyard@mvista.com)\n",
+	       VERSION);
+
+	leds = NULL;
+	ret = misc_register(&led_miscdev);
+	if (ret) {
+		printk(KERN_ERR "led: can't misc_register on minor=%d\n",
+		       LED_MINOR);
+		return -1;
+	}
+	return 0;
+}
+
+module_init(led_init);
+module_exit(led_exit);
+
+EXPORT_SYMBOL(register_led_info);
+EXPORT_SYMBOL(unregister_led_info);
--- ./drivers/char/Config.in.led	Fri Jan 25 10:33:28 2002
+++ ./drivers/char/Config.in	Fri Jan 25 11:03:22 2002
@@ -222,6 +222,8 @@
 fi
 endmenu
 
+tristate 'LED device driver support' CONFIG_LINUX_LED
+
 if [ "$CONFIG_ARCH_NETWINDER" = "y" ]; then
    tristate 'NetWinder thermometer support' CONFIG_DS1620
    tristate 'NetWinder Button' CONFIG_NWBUTTON
--- ./drivers/char/Makefile.led	Fri Jan 25 09:36:27 2002
+++ ./drivers/char/Makefile	Fri Jan 25 11:03:22 2002
@@ -24,7 +24,7 @@
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
 			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
-			ppc405_gpio.o au1000_gpio.o lcd.o \
+			ppc405_gpio.o au1000_gpio.o lcd.o led.o \
 			h3600_backpaq_fpga.o
 
 mod-subdirs	:=	joystick ftape drm pcmcia
@@ -250,6 +250,7 @@
 obj-$(CONFIG_ITE_GPIO) += ite_gpio.o
 obj-$(CONFIG_AU1000_GPIO) += au1000_gpio.o
 obj-$(CONFIG_PPC405_GPIO) += ppc405_gpio.o
+obj-$(CONFIG_LINUX_LED) += led.o
 
 obj-$(CONFIG_QIC02_TAPE) += tpqic02.o
 
--- ./Documentation/Configure.help.led	Fri Jan 25 11:02:12 2002
+++ ./Documentation/Configure.help	Fri Jan 25 11:03:22 2002
@@ -11578,6 +11578,12 @@
   then also Y to the driver for your FDDI card, below). Most people
   will say N.
 
+Linux LED Support
+CONFIG_LINUX_LED
+  This is a driver that supports controlling LEDs.  It is a generic
+  driver that provides a control framework, the actual drivers must
+  register with it to work.
+
 Digital DEFEA and DEFPA adapter support
 CONFIG_DEFXX
   This is support for the DIGITAL series of EISA (DEFEA) and PCI
--- ./include/linux/led.h.led	Fri Jan 25 09:36:27 2002
+++ ./include/linux/led.h	Fri Jan 25 11:03:22 2002
@@ -0,0 +1,130 @@
+/*
+ * Defines for the LED device driver.
+ *
+ * This driver uses ioctl() calls to get information about the LEDS
+ * and to set their values.
+ *
+ * This currently only supports mono and bicolor LEDs, but support for
+ * fancier LEDs (scrolling text or numeric LEDs, for instance) could
+ * easily be added.
+ *
+ * Corey Minyard <minyard@mvista.com>
+ *
+ */
+
+#ifndef _LINUX_LED_H
+#define _LINUX_LED_H
+
+#include <linux/ioctl.h>
+
+#define	LED_IOCTL_BASE	'L'
+
+/* Types of LEDs. */
+#define LED_TYPE_MONOCOLOR	1
+#define LED_TYPE_BICOLOR	2
+
+/* Defines for LED colors. */
+#define LED_COLOR_OFF		0
+#define LED_COLOR_RED		1
+#define LED_COLOR_GREEN		2
+#define LED_COLOR_BLUE		3
+#define LED_COLOR_YELLOW	4
+#define LED_COLOR_AUXMODE	-1 /* Set it to the auxiliary mode. */
+
+union led_info_u
+{
+	struct
+	{
+		int color;		/* Color of the LED. */
+		int has_aux_mode;	/* If true, the LED has an auxiliary
+					   mode (like a disk drive or
+					   network LED) that it can be set
+					   to work in. */
+	} monocolor;
+
+	struct
+	{
+		int color1;		/* First color of the LED. */
+		int color2;		/* Second color of the LED. */
+		int has_aux_mode;	/* If true, the LED has an auxiliary
+					   mode (like a disk drive or
+					   network LED) that it can be set
+					   to work in. */
+	} bicolor;
+};
+
+/* Information about an LED.  This is not the dynamic information, but
+   the information about the capabilities of the LED. */
+struct led_info
+{
+	int led_num;
+	int type;
+	char name[32]; /* The name of the LED, used to address it. */
+	union led_info_u info;
+};
+
+/* Operation types that are valid. */
+#define SET_LED		1	/* Set the value of the LED. */
+#define GET_LED		2	/* Return the LED's current value. */
+
+/* Operations defined for each different type of LED. */
+union led_op_u
+{
+	struct
+	{
+		int color;
+	} monocolor;
+
+	struct
+	{
+		int color;
+	} bicolor;
+};
+
+/* An operation to perform on the LED.  Set the name and the operation
+   and any needed info and do an LEDIOC_OP ioctl. */
+struct led_op
+{
+	int op;
+	char name[32]; /* The name of the LED, used to address it. */
+	union led_op_u op_info;
+};
+
+
+
+/* Return the number of LEDs that have registered with the driver. */
+#define	LEDIOC_GETCOUNT		_IOR(LED_IOCTL_BASE, 0, void)
+
+/* Get the info for a single LED, indexed by number or name. */
+#define	LEDIOC_GETINFO_BY_NUM	_IOR(LED_IOCTL_BASE, 1, struct led_info)
+#define	LEDIOC_GETINFO_BY_NAME	_IOR(LED_IOCTL_BASE, 2, struct led_info)
+
+/* Perform an operation on single LED, indexed by name. */
+#define	LEDIOC_OP		_IOR(LED_IOCTL_BASE, 3, struct led_op)
+
+
+
+/* This is the structure that is registered with the LED driver by the
+   subtending LED drivers.  One of these must be registered for each
+   LED. */
+struct led_reg_info
+{
+	struct led_info     *info; /* Pointer to the info structure for
+				      this LED. */
+	void                *data; /* Used by the specific LED driver for
+				      whatever it likes. */
+
+	/* The handler the driver supplies to handle operations. */
+	int (*handle_led_op)(struct led_reg_info *info,
+			     struct led_op       *op);
+
+	struct led_reg_info *next;
+};
+
+/* Add an LED to the set of LEDs the driver controls. */
+int register_led_info(struct led_reg_info *info);
+
+/* Remove an LED from the set of LEDs the driver controls. */
+int unregister_led_info(struct led_reg_info *info);
+
+#endif  /* ifndef _LINUX_LED_H */
--- ./include/linux/miscdevice.h.led	Fri Jan 25 11:00:55 2002
+++ ./include/linux/miscdevice.h	Fri Jan 25 11:03:22 2002
@@ -15,6 +15,7 @@
 #define ADB_MOUSE_MINOR 10
 #define WATCHDOG_MINOR		130	/* Watchdog timer     */
 #define TEMP_MINOR		131	/* Temperature Sensor */
+#define LED_MINOR		132	/* LED device driver */
 #define RTC_MINOR 135
 #define EFI_RTC_MINOR		136	/* EFI Time services */
 #define SUN_OPENPROM_MINOR 139

--------------000901060004040303020205--

