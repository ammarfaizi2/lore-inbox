Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVCHS4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVCHS4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVCHS4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:56:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17360 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261513AbVCHSzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:55:36 -0500
Message-ID: <422DF525.8030606@us.ltcfwd.linux.ibm.com>
Date: Tue, 08 Mar 2005 13:55:33 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com> <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com> <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com> <20050308064424.GF17022@kroah.com>
In-Reply-To: <20050308064424.GF17022@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------080501040905050907060000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080501040905050907060000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Mon, Mar 07, 2005 at 05:46:51PM -0500, Wen Xiong wrote:
>  
>
>>+static ssize_t jsm_driver_version_show(struct device_driver *ddp, char *buf)
>>+{
>>+	return snprintf(buf, PAGE_SIZE, "jsm_version: %s\n", JSM_VERSION);
>>    
>>
>
>Again, drop the "prefix:" from every sysfs file, it should not be there
>(the data type is inferred by the name of the file, you do not have to
>repeat it again.)
>
>  
>
>>+static ssize_t jsm_tty_state_show(struct class_device *class_dev, char *buf)
>>+{
>>+	struct jsm_channel *ch;
>>+
>>+	if (class_dev) {
>>+		ch = class_get_devdata(class_dev);
>>+		if ( ch && (ch->ch_bd->state == BOARD_READY))
>>+			return snprintf(buf, PAGE_SIZE, "%s\n", ch->ch_open_count ? "Open" : "Closed");
>>+	}
>>+
>>+	return -EINVAL;
>>+}
>>+static CLASS_DEVICE_ATTR(state, S_IRUGO, jsm_tty_state_show, NULL);
>>    
>>
>
>Who needs to know if a port is open or not?
>
>  
>
>>+static ssize_t jsm_tty_baud_show(struct class_device *class_dev, char *buf)
>>+{
>>+	struct jsm_channel *ch;
>>+
>>+	if (class_dev) {
>>+		ch = class_get_devdata(class_dev);
>>+		if ( ch && (ch->ch_bd->state == BOARD_READY))
>>+		return snprintf(buf, PAGE_SIZE, "%d\n", ch->ch_old_baud);
>>+	}
>>+
>>+	return -EINVAL;
>>+}
>>+static CLASS_DEVICE_ATTR(baud, S_IRUGO, jsm_tty_baud_show, NULL);
>>    
>>
>
>No, please delete these, and the other sysfs files that duplicate the
>same info that you can get by using the standard Linux termios calls.
>There is no need for them here.
>
>thanks,
>
>greg k-h
>
>  
>
Hi Greg,
        Removed some codes in jsm_sysfs.c.

Thanks for your reviewing the code.
wendy

--------------080501040905050907060000
Content-Type: text/plain;
 name="patch4.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch4.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c
--- linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c	2005-03-08 12:19:57.498967368 -0600
@@ -0,0 +1,98 @@
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
+#include <linux/device.h>
+#include <linux/serial_reg.h>
+
+#include "jsm_driver.h"
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
+	return snprintf(buf, PAGE_SIZE, "%s\n", JSM_VERSION);
+}
+static DRIVER_ATTR(version, S_IRUSR, jsm_driver_version_show, NULL);
+
+static ssize_t jsm_driver_boards_show(struct device_driver *ddp, char *buf)
+{
+	int adapter_count = 0;
+	adapter_count = jsm_total_boardnum();
+	return snprintf(buf, PAGE_SIZE, "%d\n", adapter_count);
+}
+static DRIVER_ATTR(boards, S_IRUSR, jsm_driver_boards_show, NULL);
+
+static ssize_t jsm_driver_state_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", jsm_driver_state_text[jsm_driver_state]);
+}
+static DRIVER_ATTR(state, S_IRUSR, jsm_driver_state_show, NULL);
+
+static ssize_t jsm_driver_debug_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", jsm_debug);
+}
+static DRIVER_ATTR(debug, S_IRUSR, jsm_driver_debug_show, NULL);
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

--------------080501040905050907060000--

