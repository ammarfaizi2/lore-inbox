Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVCIPsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVCIPsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVCIPrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:47:49 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51948 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261490AbVCIPrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:47:31 -0500
Message-ID: <422F1A8A.4000106@us.ltcfwd.linux.ibm.com>
Date: Wed, 09 Mar 2005 10:47:22 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com> <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com> <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com> <20050308064424.GF17022@kroah.com> <422DF525.8030606@us.ltcfwd.linux.ibm.com> <20050308235807.GA11807@kroah.com>
In-Reply-To: <20050308235807.GA11807@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------060100070708060606060609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060100070708060606060609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Tue, Mar 08, 2005 at 01:55:33PM -0500, Wen Xiong wrote:
>  
>
>>+static ssize_t jsm_driver_boards_show(struct device_driver *ddp, char *buf)
>>+{
>>+	int adapter_count = 0;
>>+	adapter_count = jsm_total_boardnum();
>>+	return snprintf(buf, PAGE_SIZE, "%d\n", adapter_count);
>>+}
>>+static DRIVER_ATTR(boards, S_IRUSR, jsm_driver_boards_show, NULL);
>>    
>>
>
>Why is this file even needed?  You can just look at the number of sysfs
>directories attached to this device, right?
>
>thanks,
>
>greg k-h
>
>  
>
We can find out the number of adapters in several ways in linux. But we 
are not sure the end customer really know how to find out.
Anyway, attatched the new patch4.jasmine for you.

Thanks,
wendy

--------------060100070708060606060609
Content-Type: text/plain;
 name="patch4.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch4.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c
--- linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c	2005-03-09 09:37:00.520967448 -0600
@@ -0,0 +1,69 @@
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
+static ssize_t jsm_driver_version_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", JSM_VERSION);
+}
+static DRIVER_ATTR(version, S_IRUSR, jsm_driver_version_show, NULL);
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
+	driver_create_file(driverfs, &driver_attr_debug);
+	driver_create_file(driverfs, &driver_attr_rawreadok); 
+	driver_create_file(driverfs, &driver_attr_state);
+}
+
+void jsm_remove_driver_sysfiles(struct device_driver  *driverfs)
+{
+	driver_remove_file(driverfs, &driver_attr_version);
+	driver_remove_file(driverfs, &driver_attr_debug);
+	driver_remove_file(driverfs, &driver_attr_rawreadok);
+	driver_remove_file(driverfs, &driver_attr_state);
+}

--------------060100070708060606060609--

