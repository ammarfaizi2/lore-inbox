Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVCGX1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVCGX1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVCGXZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:25:47 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:62156 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261185AbVCGWrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:47:00 -0500
Message-ID: <422CD9DB.10103@us.ltcfwd.linux.ibm.com>
Date: Mon, 07 Mar 2005 17:46:51 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com> <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com> <20050304220116.GA1201@kroah.com>
In-Reply-To: <20050304220116.GA1201@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------080706040303020709010903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080706040303020709010903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Fri, Mar 04, 2005 at 04:08:17PM -0500, Wen Xiong wrote:
>  
>
>>+int get_jsm_board_number(void)
>>+{
>>+        struct list_head *tmp;
>>+        struct jsm_board *cur_board_entry;
>>+        int adapter_count = 0;
>>+        u64 lock_flags;
>>+
>>+        spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
>>+        list_for_each(tmp, &jsm_board_head) {
>>+        cur_board_entry =
>>+                list_entry(tmp, struct jsm_board,
>>+                        jsm_board_entry);
>>+                adapter_count++;
>>+        }
>>+        spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
>>+
>>+        return adapter_count;
>>+}
>>    
>>
>
>Should this be static?
>
>And it's returning the number of boards, not the current board number,
>right?
>
>And you have a indenting error in the list_for_each() section...
>
>  
>
>>+static ssize_t jsm_driver_version_show(struct device_driver *ddp, char *buf)
>>+{
>>+	return snprintf(buf, PAGE_SIZE, "jsm_version: %s\n", "jsm: 1.1-1-INKERNEL");
>>    
>>
>
>Shouldn't that value also be in MODULE_VERSION()?  And if so, it should
>be a #define somewhere.
>
>Also, don't put "jsm:" in your sysfs files, the file name describes what
>the value should be.  That goes for a lot of your sysfs files.
>
>  
>
>>+static ssize_t jsm_driver_debug_show(struct device_driver *ddp, char *buf)
>>+{
>>+	return snprintf(buf, PAGE_SIZE, "0x%x\n", debug);
>>+}
>>    
>>
>
>"debug" is not a nice variable to have in the global namespace :(
>
>Also, why not just make this a module paramater, that way it can be
>modified through that interface, and you don't have to create your own?
>
>  
>
>>+#define JSM_VERIFY_BOARD(p, bd)				\
>>+	if (!p)						\
>>+		return 0;				\
>>+	bd = (struct jsm_board *)dev_get_drvdata(p);	\
>>    
>>
>
>Cast is not needed.
>
>  
>
>>+	if (!bd)					\
>>+		return 0;				\
>>+	if (bd->state != BOARD_READY)			\
>>+		return 0;				\
>>    
>>
>
>Don't break out of functions from within a macro.  Will cause headaches
>for people reviewing your code in the future.
>
>And shouldn't you be returning an error if one of these checks fail?
>
>  
>
>>+static ssize_t jsm_ports_state_show(struct device *p, char *buf)
>>+{
>>+	struct jsm_board *bd;
>>+	int count = 0;
>>+	int i = 0;
>>+
>>+	JSM_VERIFY_BOARD(p, bd);
>>+
>>+	for (i = 0; i < bd->nasync; i++) {
>>+		count += snprintf(buf + count, PAGE_SIZE - count,
>>+			"%d %s\n", bd->channels[i]->ch_portnum,
>>+			bd->channels[i]->ch_open_count ? "Open" : "Closed");
>>+	}
>>+	return count;
>>    
>>
>
>No, make this a per-port value.  You are showing more than one value in
>a single file.  You do this for a few other sysfs files :(
>
>And who cares about this value?
>
>  
>
>>+static ssize_t jsm_ports_baud_show(struct device *p, char *buf)
>>+{
>>+	struct jsm_board *bd;
>>+	int count = 0;
>>+	int i = 0;
>>+
>>+	JSM_VERIFY_BOARD(p, bd);
>>+
>>+	for (i = 0; i < bd->nasync; i++) {
>>+		count +=  snprintf(buf + count, PAGE_SIZE - count,
>>+			"%d %d\n", bd->channels[i]->ch_portnum, bd->channels[i]->ch_old_baud);
>>+	}
>>+	return count;
>>+}
>>+static DEVICE_ATTR(ports_baud, S_IRUSR, jsm_ports_baud_show, NULL);
>>    
>>
>
>What's wrong with the standard tty ioctls that return this value, and
>the other values you are exporting through sysfs?  What is all of this
>data needed for?
>
>  
>
>>+#define JSM_VERIFY_CHANNEL(p, ch)			\
>>+	if (!p)						\
>>+		return 0;				\
>>+	ch = (struct jsm_channel *)class_get_devdata(p);\
>>+	if (!ch)					\
>>+		return 0;				\
>>+	if (ch->ch_bd->state != BOARD_READY)		\
>>+		return 0;				\
>>    
>>
>
>Again, don't put return in a macro, and return an error if there really
>is one.
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
Hi Greg,
Since some tools in Digi  need some new ioctls, so I still keep some new 
ioctls.

Thanks for your reviewing!
wendy

--------------080706040303020709010903
Content-Type: text/plain;
 name="patch4.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch4.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c
--- linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c	2005-03-07 16:27:47.293998096 -0600
@@ -0,0 +1,289 @@
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
+#include <linux/device.h>
+#include <linux/serial_reg.h>
+
+#include "jsm_driver.h"
+
+static struct class_simple *jsm_tty_class;
+
+int jsm_total_boardnum(void)
+{
+	struct list_head *tmp;
+	struct jsm_board *cur_board_entry;
+	int adapter_count = 0;
+	u64 lock_flags;
+
+	spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
+	list_for_each(tmp, &jsm_board_head) {
+		cur_board_entry =
+			list_entry(tmp, struct jsm_board,
+			jsm_board_entry);
+		adapter_count++;
+	}
+	spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
+
+	return adapter_count;
+}
+
+static ssize_t jsm_driver_version_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "jsm_version: %s\n", JSM_VERSION);
+}
+static DRIVER_ATTR(version, S_IRUSR, jsm_driver_version_show, NULL);
+
+static ssize_t jsm_driver_boards_show(struct device_driver *ddp, char *buf)
+{
+	int adapter_count = 0;
+	adapter_count = jsm_total_boardnum();
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
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", jsm_debug);
+}
+static DRIVER_ATTR(debug, S_IRUSR, jsm_driver_debug_show, NULL);
+
+
+static ssize_t jsm_driver_rawreadok_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", jsm_rawreadok);
+}
+static DRIVER_ATTR(rawreadok, S_IRUSR, jsm_driver_rawreadok_show, NULL);
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
+static ssize_t jsm_tty_state_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	if (class_dev) {
+		ch = class_get_devdata(class_dev);
+		if ( ch && (ch->ch_bd->state == BOARD_READY))
+			return snprintf(buf, PAGE_SIZE, "%s\n", ch->ch_open_count ? "Open" : "Closed");
+	}
+
+	return -EINVAL;
+}
+static CLASS_DEVICE_ATTR(state, S_IRUGO, jsm_tty_state_show, NULL);
+
+
+static ssize_t jsm_tty_baud_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	if (class_dev) {
+		ch = class_get_devdata(class_dev);
+		if ( ch && (ch->ch_bd->state == BOARD_READY))
+		return snprintf(buf, PAGE_SIZE, "%d\n", ch->ch_old_baud);
+	}
+
+	return -EINVAL;
+}
+static CLASS_DEVICE_ATTR(baud, S_IRUGO, jsm_tty_baud_show, NULL);
+
+static ssize_t jsm_tty_msignals_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	if (class_dev) {
+		ch = class_get_devdata(class_dev);
+		if ( ch && (ch->ch_bd->state == BOARD_READY))
+			if (ch->ch_open_count) {
+				return snprintf(buf, PAGE_SIZE, "%s %s %s %s %s %s\n",
+					(ch->ch_mostat & UART_MCR_RTS) ? "RTS" : "",
+					(ch->ch_mistat & UART_MSR_CTS) ? "CTS" : "",
+					(ch->ch_mostat & UART_MCR_DTR) ? "DTR" : "",
+					(ch->ch_mistat & UART_MSR_DSR) ? "DSR" : "",
+					(ch->ch_mistat & UART_MSR_DCD) ? "DCD" : "",
+					(ch->ch_mistat & UART_MSR_RI)  ? "RI"  : "");
+			}
+	}
+
+	return -EINVAL;
+}
+static CLASS_DEVICE_ATTR(msignals, S_IRUGO, jsm_tty_msignals_show, NULL);
+
+static ssize_t jsm_tty_iflag_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	if (class_dev) {
+		ch = class_get_devdata(class_dev);
+		if ( ch && (ch->ch_bd->state == BOARD_READY))
+		return snprintf(buf, PAGE_SIZE, "%x\n", ch->ch_c_iflag);
+	}
+
+	return -EINVAL;
+}
+static CLASS_DEVICE_ATTR(iflag, S_IRUGO, jsm_tty_iflag_show, NULL);
+
+
+static ssize_t jsm_tty_cflag_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	if (class_dev) {
+		ch = class_get_devdata(class_dev);
+		if ( ch && (ch->ch_bd->state == BOARD_READY))
+		return snprintf(buf, PAGE_SIZE, "%x\n", ch->ch_c_cflag);
+	}
+
+	return -EINVAL;
+}
+static CLASS_DEVICE_ATTR(cflag, S_IRUGO, jsm_tty_cflag_show, NULL);
+
+static ssize_t jsm_tty_oflag_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	if (class_dev) {
+		ch = class_get_devdata(class_dev);
+		if ( ch && (ch->ch_bd->state == BOARD_READY))
+		return snprintf(buf, PAGE_SIZE, "%x\n", ch->ch_c_oflag);
+	}
+
+	return -EINVAL;
+}
+static CLASS_DEVICE_ATTR(oflag, S_IRUGO, jsm_tty_oflag_show, NULL);
+
+static ssize_t jsm_tty_lflag_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	if (class_dev) {
+		ch = class_get_devdata(class_dev);
+		if ( ch && (ch->ch_bd->state == BOARD_READY))
+		return snprintf(buf, PAGE_SIZE, "%x\n", ch->ch_c_lflag);
+	}
+
+	return -EINVAL;
+}
+static CLASS_DEVICE_ATTR(lflag, S_IRUGO, jsm_tty_lflag_show, NULL);
+
+static ssize_t jsm_tty_rxcount_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	if (class_dev) {
+		ch = class_get_devdata(class_dev);
+		if ( ch && (ch->ch_bd->state == BOARD_READY))
+		return snprintf(buf, PAGE_SIZE, "%ld\n", ch->ch_rxcount);
+	}
+
+	return -EINVAL;
+}
+static CLASS_DEVICE_ATTR(rxcount, S_IRUGO, jsm_tty_rxcount_show, NULL);
+
+static ssize_t jsm_tty_txcount_show(struct class_device *class_dev, char *buf)
+{
+	struct jsm_channel *ch;
+
+	if (class_dev) {
+		ch = class_get_devdata(class_dev);
+		if ( ch && (ch->ch_bd->state == BOARD_READY))
+		return snprintf(buf, PAGE_SIZE, "%ld\n", ch->ch_txcount);
+	}
+
+	return -EINVAL;
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

--------------080706040303020709010903--

