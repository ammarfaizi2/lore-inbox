Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263351AbVCDWsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbVCDWsI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbVCDWmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:42:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15568 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263214AbVCDVIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:08:21 -0500
Message-ID: <4228CE41.2000102@us.ltcfwd.linux.ibm.com>
Date: Fri, 04 Mar 2005 16:08:17 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com> <20050228063954.GB23595@kroah.com>
In-Reply-To: <20050228063954.GB23595@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------000200040204070708060604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000200040204070708060604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Sun, Feb 27, 2005 at 06:39:51PM -0500, Wen Xiong wrote:
>  
>
>>This patch is for jsm_proc.c and includes the functions relating to 
>>/proc/jsm entry.
>>    
>>
>
>No, don't add new /proc stuff.  Use sysfs, and if you want to spit out
>more data, use debugfs.
>
>What is the need for these files?
>
>thanks,
>
>greg k-h 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Changed to use sysfs.

Signed-off-by: Wen Xiong <wendyx@us.ltcfwd.linux.ibm.com>



--------------000200040204070708060604
Content-Type: text/plain;
 name="patch4.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch4.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c
--- linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c	2005-03-04 11:24:37.962944848 -0600
@@ -0,0 +1,463 @@
+/************************************************************************
+ * Copyright 2003 Digi International (www.digi.com)
+ *
+ * Copyright (C) 2004 IBM Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the 
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
+ * PURPOSE.  See the GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License 
+ * along with this program; if not, write to the Free Software 
+ * Foundation, Inc., 59 * Temple Place - Suite 330, Boston,
+ * MA  02111-1307, USA.
+ *
+ * Contact Information:
+ * Scott H Kilau <Scott_Kilau@digi.com>
+ * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ *
+ ***********************************************************************/
+
+#include "jsm_driver.h"
+
+static struct class_simple *jsm_tty_class;
+
+int get_jsm_board_number(void)
+{
+        struct list_head *tmp;
+        struct jsm_board *cur_board_entry;
+        int adapter_count = 0;
+        u64 lock_flags;
+
+        spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
+        list_for_each(tmp, &jsm_board_head) {
+        cur_board_entry =
+                list_entry(tmp, struct jsm_board,
+                        jsm_board_entry);
+                adapter_count++;
+        }
+        spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
+
+        return adapter_count;
+}
+
+static ssize_t jsm_driver_version_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "jsm_version: %s\n", "jsm: 1.1-1-INKERNEL");
+}
+static DRIVER_ATTR(version, S_IRUSR, jsm_driver_version_show, NULL);
+
+static ssize_t jsm_driver_boards_show(struct device_driver *ddp, char *buf)
+{
+	int adapter_count = 0;
+	adapter_count = get_jsm_board_number();
+	return snprintf(buf, PAGE_SIZE, "jsm_board_number: %d\n", adapter_count);
+}
+static DRIVER_ATTR(boards, S_IRUSR, jsm_driver_boards_show, NULL);
+
+static ssize_t jsm_driver_state_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "jsm_state: %s\n", jsm_driver_state_text[jsm_driver_state]);
+}
+static DRIVER_ATTR(state, S_IRUSR, jsm_driver_state_show, NULL);
+
+static ssize_t jsm_driver_debug_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", debug);
+}
+
+static ssize_t jsm_driver_debug_store(struct device_driver *ddp, const char *buf, size_t count)
+{
+	sscanf(buf, "0x%x\n", &debug);
+	return count;
+}
+static DRIVER_ATTR(debug, (S_IRUSR | S_IWUSR), jsm_driver_debug_show, jsm_driver_debug_store);
+
+
+static ssize_t jsm_driver_rawreadok_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", rawreadok);
+}
+
+static ssize_t jsm_driver_rawreadok_store(struct device_driver *ddp, const char *buf, size_t count)
+{
+	sscanf(buf, "0x%x\n", &rawreadok);
+	return count;
+}
+static DRIVER_ATTR(rawreadok, (S_IRUSR | S_IWUSR), jsm_driver_rawreadok_show, jsm_driver_rawreadok_store);
+
+void jsm_create_driver_sysfiles(struct device_driver *driverfs)
+{
+	driver_create_file(driverfs, &driver_attr_version);
+	driver_create_file(driverfs, &driver_attr_boards);
+	driver_create_file(driverfs, &driver_attr_debug);
+	driver_create_file(driverfs, &driver_attr_rawreadok); 
+	driver_create_file(driverfs, &driver_attr_state);
+}
+
+void jsm_remove_driver_sysfiles(struct device_driver  *driverfs)
+{
+	driver_remove_file(driverfs, &driver_attr_version);
+	driver_remove_file(driverfs, &driver_attr_boards);
+	driver_remove_file(driverfs, &driver_attr_debug);
+	driver_remove_file(driverfs, &driver_attr_rawreadok);
+	driver_remove_file(driverfs, &driver_attr_state);
+}
+
+#define JSM_VERIFY_BOARD(p, bd)				\
+	if (!p)						\
+		return 0;				\
+	bd = (struct jsm_board *)dev_get_drvdata(p);	\
+	if (!bd)					\
+		return 0;				\
+	if (bd->state != BOARD_READY)			\
+		return 0;				\
+
+static ssize_t jsm_ports_state_show(struct device *p, char *buf)
+{
+	struct jsm_board *bd;
+	int count = 0;
+	int i = 0;
+
+	JSM_VERIFY_BOARD(p, bd);
+
+	for (i = 0; i < bd->nasync; i++) {
+		count += snprintf(buf + count, PAGE_SIZE - count,
+			"%d %s\n", bd->channels[i]->ch_portnum,
+			bd->channels[i]->ch_open_count ? "Open" : "Closed");
+	}
+	return count;
+}
+static DEVICE_ATTR(ports_state, S_IRUSR, jsm_ports_state_show, NULL);
+
+static ssize_t jsm_ports_baud_show(struct device *p, char *buf)
+{
+	struct jsm_board *bd;
+	int count = 0;
+	int i = 0;
+
+	JSM_VERIFY_BOARD(p, bd);
+
+	for (i = 0; i < bd->nasync; i++) {
+		count +=  snprintf(buf + count, PAGE_SIZE - count,
+			"%d %d\n", bd->channels[i]->ch_portnum, bd->channels[i]->ch_old_baud);
+	}
+	return count;
+}
+static DEVICE_ATTR(ports_baud, S_IRUSR, jsm_ports_baud_show, NULL);
+
+static ssize_t jsm_ports_msignals_show(struct device *p, char *buf)
+{
+	struct jsm_board *bd;
+	int count = 0;
+	int i = 0;
+
+	JSM_VERIFY_BOARD(p, bd);
+
+	for (i = 0; i < bd->nasync; i++) {
+		if (bd->channels[i]->ch_open_count) {
+			count += snprintf(buf + count, PAGE_SIZE - count,
+				"%d %s %s %s %s %s %s\n", bd->channels[i]->ch_portnum,
+				(bd->channels[i]->ch_mostat & UART_MCR_RTS) ? "RTS" : "",
+				(bd->channels[i]->ch_mistat & UART_MSR_CTS) ? "CTS" : "",
+				(bd->channels[i]->ch_mostat & UART_MCR_DTR) ? "DTR" : "",
+				(bd->channels[i]->ch_mistat & UART_MSR_DSR) ? "DSR" : "",
+				(bd->channels[i]->ch_mistat & UART_MSR_DCD) ? "DCD" : "",
+				(bd->channels[i]->ch_mistat & UART_MSR_RI)  ? "RI"  : "");
+		} else {
+			count += snprintf(buf + count, PAGE_SIZE - count,
+				"%d\n", bd->channels[i]->ch_portnum);
+		}
+	}
+	return count;
+}
+static DEVICE_ATTR(ports_msignals, S_IRUSR, jsm_ports_msignals_show, NULL);
+
+static ssize_t jsm_ports_iflag_show(struct device *p, char *buf)
+{
+	struct jsm_board *bd;
+	int count = 0;
+	int i = 0;
+
+	JSM_VERIFY_BOARD(p, bd);
+
+	for (i = 0; i < bd->nasync; i++) {
+		count += snprintf(buf + count, PAGE_SIZE - count, "%d %x\n",
+			bd->channels[i]->ch_portnum, bd->channels[i]->ch_c_iflag);
+	}
+	return count;
+}
+static DEVICE_ATTR(ports_iflag, S_IRUSR, jsm_ports_iflag_show, NULL);
+
+static ssize_t jsm_ports_cflag_show(struct device *p, char *buf)
+{
+	struct jsm_board *bd;
+	int count = 0;
+	int i = 0;
+
+	JSM_VERIFY_BOARD(p, bd);
+
+	for (i = 0; i < bd->nasync; i++) {
+		count += snprintf(buf + count, PAGE_SIZE - count, "%d %x\n",
+			bd->channels[i]->ch_portnum, bd->channels[i]->ch_c_cflag);
+	}
+	return count;
+}
+static DEVICE_ATTR(ports_cflag, S_IRUSR, jsm_ports_cflag_show, NULL);
+
+static ssize_t jsm_ports_oflag_show(struct device *p, char *buf)
+{
+	struct jsm_board *bd;
+	int count = 0;
+	int i = 0;
+
+	JSM_VERIFY_BOARD(p, bd);
+
+	for (i = 0; i < bd->nasync; i++) {
+		count += snprintf(buf + count, PAGE_SIZE - count, "%d %x\n",
+			bd->channels[i]->ch_portnum, bd->channels[i]->ch_c_oflag);
+	}
+	return count;
+}
+static DEVICE_ATTR(ports_oflag, S_IRUSR, jsm_ports_oflag_show, NULL);
+
+static ssize_t jsm_ports_lflag_show(struct device *p, char *buf)
+{
+	struct jsm_board *bd;
+	int count = 0;
+	int i = 0;
+
+	JSM_VERIFY_BOARD(p, bd);
+
+	for (i = 0; i < bd->nasync; i++) {
+		count += snprintf(buf + count, PAGE_SIZE - count, "%d %x\n",
+			bd->channels[i]->ch_portnum, bd->channels[i]->ch_c_lflag);
+	}
+	return count;
+}
+static DEVICE_ATTR(ports_lflag, S_IRUSR, jsm_ports_lflag_show, NULL);
+
+static ssize_t jsm_ports_rxcount_show(struct device *p, char *buf)
+{
+	struct jsm_board *bd;
+	int count = 0;
+	int i = 0;
+
+	JSM_VERIFY_BOARD(p, bd);
+
+	for (i = 0; i < bd->nasync; i++) {
+		count += snprintf(buf + count, PAGE_SIZE - count, "%d %ld\n",
+			bd->channels[i]->ch_portnum, bd->channels[i]->ch_rxcount);
+	}
+	return count;
+}
+static DEVICE_ATTR(ports_rxcount, S_IRUSR, jsm_ports_rxcount_show, NULL);
+
+static ssize_t jsm_ports_txcount_show(struct device *p, char *buf)
+{
+	struct jsm_board *bd;
+	int count = 0;
+	int i = 0;
+
+	JSM_VERIFY_BOARD(p, bd);
+
+	for (i = 0; i < bd->nasync; i++) {
+		count += snprintf(buf + count, PAGE_SIZE - count, "%d %ld\n",
+			bd->channels[i]->ch_portnum, bd->channels[i]->ch_txcount);
+	}
+	return count;
+}
+static DEVICE_ATTR(ports_txcount, S_IRUSR, jsm_ports_txcount_show, NULL);
+
+/* this function creates the sys files that will export each signal status
+ * to sysfs each value will be put in a separate filename
+ */
+void jsm_create_ports_sysfiles(struct jsm_board *bd, struct device *devicefs)
+{
+	dev_set_drvdata(devicefs, bd);
+	device_create_file(devicefs, &dev_attr_ports_state);
+	device_create_file(devicefs, &dev_attr_ports_baud);
+	device_create_file(devicefs, &dev_attr_ports_msignals);
+	device_create_file(devicefs, &dev_attr_ports_iflag);
+	device_create_file(devicefs, &dev_attr_ports_cflag);
+	device_create_file(devicefs, &dev_attr_ports_oflag);
+	device_create_file(devicefs, &dev_attr_ports_lflag);
+	device_create_file(devicefs, &dev_attr_ports_rxcount);
+	device_create_file(devicefs, &dev_attr_ports_txcount);
+}
+
+/* removes all the sys files created for that port */
+void jsm_remove_ports_sysfiles(struct jsm_board *bd, struct device *devicefs)
+{
+	device_remove_file(devicefs, &dev_attr_ports_state);
+	device_remove_file(devicefs, &dev_attr_ports_baud);
+	device_remove_file(devicefs, &dev_attr_ports_msignals);
+	device_remove_file(devicefs, &dev_attr_ports_iflag);
+	device_remove_file(devicefs, &dev_attr_ports_cflag);
+	device_remove_file(devicefs, &dev_attr_ports_oflag);
+	device_remove_file(devicefs, &dev_attr_ports_lflag);
+	device_remove_file(devicefs, &dev_attr_ports_rxcount);
+	device_remove_file(devicefs, &dev_attr_ports_txcount);
+}
+
+
+int jsm_tty_class_init(void)
+{
+	jsm_tty_class = class_simple_create(THIS_MODULE, "jsm_tty");
+	if (IS_ERR(jsm_tty_class))
+		return PTR_ERR(jsm_tty_class);
+
+	return 0;
+}
+
+int jsm_tty_class_destroy(void)
+{
+	if (IS_ERR(jsm_tty_class))
+		return PTR_ERR(jsm_tty_class);
+
+	class_simple_destroy(jsm_tty_class);
+	return 0;
+}
+
+#define JSM_VERIFY_CHANNEL(p, ch)			\
+	if (!p)						\
+		return 0;				\
+	ch = (struct jsm_channel *)class_get_devdata(p);\
+	if (!ch)					\
+		return 0;				\
+	if (ch->ch_bd->state != BOARD_READY)		\
+		return 0;				\
+
+static ssize_t jsm_tty_state_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	JSM_VERIFY_CHANNEL(class_dev, ch);
+	return snprintf(buf, PAGE_SIZE, "%s\n", ch->ch_open_count ? "Open" : "Closed");
+}
+static CLASS_DEVICE_ATTR(state, S_IRUGO, jsm_tty_state_show, NULL);
+
+
+static ssize_t jsm_tty_baud_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	JSM_VERIFY_CHANNEL(class_dev, ch);
+	return snprintf(buf, PAGE_SIZE, "%d\n", ch->ch_old_baud);
+}
+static CLASS_DEVICE_ATTR(baud, S_IRUGO, jsm_tty_baud_show, NULL);
+
+
+static ssize_t jsm_tty_msignals_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	JSM_VERIFY_CHANNEL(class_dev, ch);
+	if (ch->ch_open_count) {
+		return snprintf(buf, PAGE_SIZE, "%s %s %s %s %s %s\n",
+			(ch->ch_mostat & UART_MCR_RTS) ? "RTS" : "",
+			(ch->ch_mistat & UART_MSR_CTS) ? "CTS" : "",
+			(ch->ch_mostat & UART_MCR_DTR) ? "DTR" : "",
+			(ch->ch_mistat & UART_MSR_DSR) ? "DSR" : "",
+			(ch->ch_mistat & UART_MSR_DCD) ? "DCD" : "",
+			(ch->ch_mistat & UART_MSR_RI)  ? "RI"  : "");
+	}
+	return 0;
+}
+static CLASS_DEVICE_ATTR(msignals, S_IRUGO, jsm_tty_msignals_show, NULL);
+
+static ssize_t jsm_tty_iflag_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	JSM_VERIFY_CHANNEL(class_dev, ch);
+	return snprintf(buf, PAGE_SIZE, "%x\n", ch->ch_c_iflag);
+}
+static CLASS_DEVICE_ATTR(iflag, S_IRUGO, jsm_tty_iflag_show, NULL);
+
+
+static ssize_t jsm_tty_cflag_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	JSM_VERIFY_CHANNEL(class_dev, ch);
+	return snprintf(buf, PAGE_SIZE, "%x\n", ch->ch_c_cflag);
+}
+static CLASS_DEVICE_ATTR(cflag, S_IRUGO, jsm_tty_cflag_show, NULL);
+
+static ssize_t jsm_tty_oflag_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	JSM_VERIFY_CHANNEL(class_dev, ch);
+	return snprintf(buf, PAGE_SIZE, "%x\n", ch->ch_c_oflag);
+}
+static CLASS_DEVICE_ATTR(oflag, S_IRUGO, jsm_tty_oflag_show, NULL);
+
+static ssize_t jsm_tty_lflag_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	JSM_VERIFY_CHANNEL(class_dev, ch);
+	return snprintf(buf, PAGE_SIZE, "%x\n", ch->ch_c_lflag);
+}
+static CLASS_DEVICE_ATTR(lflag, S_IRUGO, jsm_tty_lflag_show, NULL);
+
+static ssize_t jsm_tty_rxcount_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	JSM_VERIFY_CHANNEL(class_dev, ch);
+	return snprintf(buf, PAGE_SIZE, "%ld\n", ch->ch_rxcount);
+}
+static CLASS_DEVICE_ATTR(rxcount, S_IRUGO, jsm_tty_rxcount_show, NULL);
+
+static ssize_t jsm_tty_txcount_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	JSM_VERIFY_CHANNEL(class_dev, ch);
+	return snprintf(buf, PAGE_SIZE, "%ld\n", ch->ch_txcount);
+}
+static CLASS_DEVICE_ATTR(txcount, S_IRUGO, jsm_tty_txcount_show, NULL);
+
+void jsm_tty_register_device(struct jsm_channel *ch, struct device *device)
+{
+	struct class_device *jsm_class_member;
+	dev_t dev;
+
+	dev = MKDEV(ch->ch_bd->jsm_serial_major,
+			ch->ch_portnum + ch->ch_bd->boardnum * 2);
+
+	jsm_class_member = class_simple_device_add(jsm_tty_class, dev, device,
+			"ttyn%d", ch->ch_portnum + ch->ch_bd->boardnum*2);
+
+	if (IS_ERR(jsm_class_member))
+		return;
+
+	class_set_devdata(jsm_class_member, ch);
+	class_device_create_file(jsm_class_member, &class_device_attr_state);
+	class_device_create_file(jsm_class_member, &class_device_attr_baud);
+	class_device_create_file(jsm_class_member, &class_device_attr_msignals);
+	class_device_create_file(jsm_class_member, &class_device_attr_iflag);
+	class_device_create_file(jsm_class_member, &class_device_attr_cflag);
+	class_device_create_file(jsm_class_member, &class_device_attr_oflag);
+	class_device_create_file(jsm_class_member, &class_device_attr_lflag);
+	class_device_create_file(jsm_class_member, &class_device_attr_rxcount);
+	class_device_create_file(jsm_class_member, &class_device_attr_txcount);
+}
+
+void jsm_tty_unregister_device(struct jsm_channel *ch)
+{
+
+	class_simple_device_remove(MKDEV(ch->ch_bd->jsm_serial_major, 
+					ch->ch_portnum + ch->ch_bd->boardnum * 2));
+}

--------------000200040204070708060604--

