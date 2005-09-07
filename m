Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVIGCTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVIGCTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 22:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVIGCTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 22:19:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64726 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750714AbVIGCTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 22:19:35 -0400
Message-ID: <431E4E28.5020604@volny.cz>
Date: Wed, 07 Sep 2005 04:19:20 +0200
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vojtech@suse.cz
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Wistron laptop button driver
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------070504030706070800000400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070504030706070800000400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,
attached (as a patch against 2.6.13-git6) is a driver for laptop buttons
on my Fujitsu-Siemens Amilo Pro V2000; it seems quite a few other
laptops use the same interface (with differing sets of buttons).

Thanks,
	Mirek

--------------070504030706070800000400
Content-Type: text/x-patch;
 name="wistron_btns.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wistron_btns.patch"

A driver for laptop buttons using an x86 BIOS interface that is
apparently used on quite a few laptops and seems to be originating
from Wistron.

This driver currently "knows" only about Fujitsu-Siemens Amilo Pro V2000
(i.e. it can detect the laptop using DMI and it contains the
keycode->key meaning mapping for this laptop), adding other laptops
should be easy.

In addition to reporting button presses to the input layer the driver
also allows enabling/disabling the embedded wireless NIC (using the
"Wifi" button); this is done using the same BIOS interface, so it seems
only logical to keep the implementation together.  Any flexibility
possibly gained by allowing users to remap the function of the "Wifi"
button is IMHO not worth it when weighted against the necessity to run
an user-space daemon to convert button presses to wifi state changes.

Signed-off-by: Miloslav Trmac <mitr@volny.cz>


diff -urN --exclude '*~' orig/linux-2.6.13/drivers/input/misc/Kconfig linux-2.6.13/drivers/input/misc/Kconfig
--- orig/linux-2.6.13/drivers/input/misc/Kconfig	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/input/misc/Kconfig	2005-09-06 15:37:30.000000000 +0200
@@ -40,6 +40,16 @@
 	tristate "M68k Beeper support"
 	depends on M68K
 
+config INPUT_WISTRON_BTNS
+	tristate "x86 Wistron laptop button interface"
+	depends on X86
+	help
+	  Say Y here for support of Winstron laptop button interface, used on
+	  laptops of various brands, including Acer and Fujitsu-Siemens.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called wistron_btns.
+
 config INPUT_UINPUT
 	tristate "User level driver support"
 	help
diff -urN --exclude '*~' orig/linux-2.6.13/drivers/input/misc/Makefile linux-2.6.13/drivers/input/misc/Makefile
--- orig/linux-2.6.13/drivers/input/misc/Makefile	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/input/misc/Makefile	2005-09-06 15:34:36.000000000 +0200
@@ -9,4 +9,5 @@
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
+obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
diff -urN --exclude '*~' orig/linux-2.6.13/drivers/input/misc/wistron_btns.c linux-2.6.13/drivers/input/misc/wistron_btns.c
--- orig/linux-2.6.13/drivers/input/misc/wistron_btns.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13/drivers/input/misc/wistron_btns.c	2005-09-06 15:34:06.000000000 +0200
@@ -0,0 +1,385 @@
+/* Wistron laptop button driver
+   Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
+
+   You can redistribute and/or modify this program under the terms of the
+   GNU General Public License version 2 as published by the Free Software
+   Foundation.
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
+   Public License for more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program; if not, write to the Free Software Foundation, Inc.,
+   59 Temple Place Suite 330, Boston, MA 02111-1307, USA. */
+#include <asm/io.h>
+#include <linux/dmi.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mc146818rtc.h>
+#include <linux/module.h>
+#include <linux/preempt.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+
+/* Number of attempts to read data from queue per poll; the queue can hold up
+   to 31 entries */
+#define MAX_POLL_ITERATIONS 64
+#define POLL_FREQUENCY 10 /* Number of polls per second */
+
+#if POLL_FREQUENCY > HZ
+#error "POLL_FREQUENCY too high"
+#endif
+
+MODULE_AUTHOR("Miloslav Trmac <mitr@volny.cz>");
+MODULE_DESCRIPTION("Wistron laptop button driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.1");
+
+static int force; /* = 0; */
+module_param(force, bool, 0);
+MODULE_PARM_DESC(force, "Load even if computer is not in database");
+
+ /* BIOS interface implementation */
+
+static void __iomem *bios_entry_point; /* BIOS routine entry point */
+static void __iomem *bios_code_map_base;
+static void __iomem *bios_data_map_base;
+
+static uint8_t cmos_address;
+
+struct regs {
+	uint32_t eax, ebx, ecx;
+};
+
+static void call_bios(struct regs *regs)
+{
+	unsigned long flags;
+
+	preempt_disable();
+	local_irq_save(flags);
+	asm volatile ("pushl %%ebp;"
+		      "movl %[data], %%ebp;"
+		      "call *%[routine];"
+		      "popl %%ebp"
+		      : "=a" (regs->eax), "=b" (regs->ebx), "=c" (regs->ecx)
+		      : "0" (regs->eax), "1" (regs->ebx), "2" (regs->ecx),
+			[routine] "m" (bios_entry_point),
+			[data] "m" (bios_data_map_base)
+		      : "edx", "edi", "esi", "memory");
+	local_irq_restore(flags);
+	preempt_enable();
+}
+
+static int __init map_bios(void)
+{
+	static const unsigned char __initdata signature[]
+		= { 0x42, 0x21, 0x55, 0x30 };
+
+	void __iomem *base;
+	size_t offset;
+	uint32_t entry_point;
+
+	base = ioremap(0xF0000, 0x10000); /* Can't fail */
+	for (offset = 0; offset < 0x10000; offset += 0x10) {
+		if (check_signature(base + offset, signature,
+				    sizeof(signature)) != 0)
+			goto found;
+	}
+	printk(KERN_INFO "wistron_btns: BIOS entry point not found\n");
+	iounmap(base);
+	return -ENODEV;
+
+found:
+	entry_point = readl(base + offset + 5);
+	printk(KERN_DEBUG "wistron_btns: BIOS signature found at %p, entry "
+	       "point %08X\n", base + offset, entry_point);
+	if (entry_point >= 0xF0000) {
+		bios_code_map_base = base;
+		bios_entry_point = bios_code_map_base + (entry_point & 0xFFFF);
+	} else {
+		iounmap(base);
+		bios_code_map_base = ioremap(entry_point & ~0x3FFF, 0x4000);
+		if (bios_code_map_base == NULL) {
+			printk(KERN_INFO "wistron_btns: Can't map BIOS code "
+			       "at %08X\n", entry_point & ~0x3FFF);
+			goto err;
+		}
+		bios_entry_point = bios_code_map_base + (entry_point & 0x3FFF);
+	}
+	/* The Windows driver maps 0x10000 bytes, we keep only one page... */
+	bios_data_map_base = ioremap(0x400, 0xc00);
+	if (bios_data_map_base == NULL) {
+		printk(KERN_INFO "wistron_btns: Can't map BIOS data\n");
+		goto err_code;
+	}
+	return 0;
+
+err_code:
+	iounmap(bios_code_map_base);
+err:
+	return -ENOMEM;
+}
+
+static void __exit unmap_bios(void)
+{
+	iounmap(bios_code_map_base);
+	iounmap(bios_data_map_base);
+}
+
+ /* BIOS calls */
+
+static uint16_t bios_pop_queue(void)
+{
+	struct regs regs;
+
+	memset(&regs, 0, sizeof (regs));
+	regs.eax = 0x9610;
+	regs.ebx = 0x061C;
+	regs.ecx = 0x0000;
+	call_bios(&regs);
+	return (uint16_t)regs.eax;
+}
+
+static void __init bios_attach(void)
+{
+	struct regs regs;
+
+	memset(&regs, 0, sizeof (regs));
+	regs.eax = 0x9610;
+	regs.ebx = 0x012E;
+	call_bios(&regs);
+}
+
+static void __exit bios_detach(void)
+{
+	struct regs regs;
+
+	memset(&regs, 0, sizeof (regs));
+	regs.eax = 0x9610;
+	regs.ebx = 0x002E;
+	call_bios(&regs);
+}
+
+static uint8_t __init bios_get_cmos_address(void)
+{
+	struct regs regs;
+
+	memset(&regs, 0, sizeof (regs));
+	regs.eax = 0x9610;
+	regs.ebx = 0x051C;
+	call_bios(&regs);
+	return (uint8_t)regs.ecx;
+}
+
+static uint16_t __init bios_wifi_get_default_setting(void)
+{
+	struct regs regs;
+
+	memset(&regs, 0, sizeof (regs));
+	regs.eax = 0x9610;
+	regs.ebx = 0x0235;
+	call_bios(&regs);
+	return (uint16_t)regs.eax;
+}
+
+static void bios_wifi_set_state(int enable)
+{
+	struct regs regs;
+
+	memset(&regs, 0, sizeof (regs));
+	regs.eax = 0x9610;
+	regs.ebx = enable ? 0x0135 : 0x0035;
+	call_bios(&regs);
+}
+
+ /* Hardware database */
+
+struct key_entry {
+	char type;		/* See KE_* below */
+	uint8_t code;
+	unsigned keycode;	/* For KE_KEY */
+};
+
+enum { KE_END, KE_KEY, KE_WIFI };
+
+static const struct key_entry *keymap; /* = NULL; Current key map */
+static int have_wifi;
+
+static int __init dmi_matched(struct dmi_system_id *dmi)
+{
+	const struct key_entry *key;
+
+	keymap = dmi->driver_data;
+	for (key = keymap; key->type != KE_END; key++) {
+		if (key->type == KE_WIFI) {
+			have_wifi = 1;
+			break;
+		}
+	}
+	return 1;
+}
+
+static struct key_entry keymap_empty[] = {
+	{ KE_END, 0 }
+};
+
+static struct key_entry keymap_fs_amilo_pro_v2000[] = {
+	{ KE_KEY,  0x01, KEY_HELP },
+	{ KE_KEY,  0x11, KEY_PROG1 },
+	{ KE_KEY,  0x12, KEY_PROG2 },
+	{ KE_WIFI, 0x30, 0 },
+	{ KE_KEY,  0x31, KEY_MAIL },
+	{ KE_KEY,  0x36, KEY_WWW },
+	{ KE_END, 0 }
+};
+
+/* If your machine is not here (which is currently rather likely), please send
+   a list of buttons and their key codes (reported when loading this module
+   with force=1) and the output of dmidecode to $MODULE_AUTHOR. */
+static struct dmi_system_id dmi_ids[] = {
+	{
+		.callback = dmi_matched,
+		.ident = "Fujitsu-Siemens Amilo Pro V2000",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2000"),
+		},
+		.driver_data = keymap_fs_amilo_pro_v2000
+	},
+	{ 0, }
+};
+
+ /* Input layer interface */
+
+static struct input_dev input_dev = {
+	.name = "Wistron laptop buttons",
+};
+
+static void __init setup_input_dev(void)
+{
+	const struct key_entry *key;
+
+	for (key = keymap; key->type != KE_END; key++) {
+		if (key->type == KE_KEY) {
+			input_dev.evbit[LONG(EV_KEY)] = BIT(EV_KEY);
+			input_dev.keybit[LONG(key->keycode)]
+				|= BIT(key->keycode);
+		}
+	}
+}
+
+static void report_key(unsigned keycode)
+{
+	input_report_key(&input_dev, keycode, 1);
+	input_sync(&input_dev);
+	input_report_key(&input_dev, keycode, 0);
+	input_sync(&input_dev);
+}
+
+ /* Driver core */
+
+static int wifi_enabled;
+
+static void poll_bios(unsigned long);
+
+static struct timer_list poll_timer = TIMER_INITIALIZER (poll_bios, 0, 0);
+
+static void handle_key(uint8_t code)
+{
+	const struct key_entry *key;
+
+	for (key = keymap; key->type != KE_END; key++) {
+		if (code == key->code) {
+			switch (key->type) {
+			case KE_KEY:
+				report_key(key->keycode);
+				break;
+
+			case KE_WIFI:
+				if (have_wifi == 0)
+					break;
+				wifi_enabled = !wifi_enabled;
+				bios_wifi_set_state(wifi_enabled);
+				break;
+
+			case KE_END: default:
+				BUG();
+			}
+			return;
+		}
+	}
+	printk(KERN_NOTICE "wistron_btns: Unknown key code %02X\n", code);
+}
+
+static void poll_bios(unsigned long discard)
+{
+	for (;;) {
+		uint8_t qlen;
+		uint16_t val;
+
+		qlen = CMOS_READ(cmos_address);
+		if (qlen == 0)
+			break;
+		val = bios_pop_queue ();
+		if (val != 0 && discard == 0)
+			handle_key((uint8_t)val);
+	}
+	poll_timer.expires = jiffies + HZ / POLL_FREQUENCY;
+	add_timer(&poll_timer);
+}
+
+static int __init wb_module_init(void)
+{
+	int err;
+
+	dmi_check_system(dmi_ids);
+	if (keymap == NULL) {
+		if (force == 0) {
+			printk(KERN_WARNING "wistron_btns: System unknown\n");
+			return -ENODEV;
+		}
+		keymap = keymap_empty;
+	}
+	err = map_bios();
+	if (err != 0)
+		return err;
+	bios_attach();
+	cmos_address = bios_get_cmos_address();
+	if (have_wifi != 0) {
+		switch (bios_wifi_get_default_setting()) {
+		case 0x01:
+			wifi_enabled = 0;
+			break;
+
+		case 0x03:
+			wifi_enabled = 1;
+			break;
+
+		default:
+			have_wifi = 0;
+			break;
+		}
+		if (have_wifi != 0)
+			bios_wifi_set_state(wifi_enabled);
+	}
+	setup_input_dev();
+	input_register_device(&input_dev);
+	poll_bios(1); /* Flush stale event queue and arm timer */
+	return 0;
+}
+
+static void __exit wb_module_exit(void)
+{
+	del_timer_sync(&poll_timer);
+	input_unregister_device(&input_dev);
+	bios_detach();
+	unmap_bios();
+}
+
+module_init(wb_module_init);
+module_exit(wb_module_exit);
diff -urN --exclude '*~' orig/linux-2.6.13/MAINTAINERS linux-2.6.13/MAINTAINERS
--- orig/linux-2.6.13/MAINTAINERS	2005-09-06 15:05:17.000000000 +0200
+++ linux-2.6.13/MAINTAINERS	2005-09-06 15:39:13.000000000 +0200
@@ -2726,6 +2726,11 @@
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
+WISTRON LAPTOP BUTTON DRIVER
+P:	Miloslav Trmac
+M:	mitr@volny.cz
+S:	Maintained
+
 WL3501 WIRELESS PCMCIA CARD DRIVER
 P:	Arnaldo Carvalho de Melo
 M:	acme@conectiva.com.br


--------------070504030706070800000400--
