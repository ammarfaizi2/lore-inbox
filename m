Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbUASU1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUASU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:27:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:16631 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263330AbUASU1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:27:35 -0500
Message-ID: <400C3D87.3010502@us.ibm.com>
Date: Mon, 19 Jan 2004 14:26:47 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kobj_to_dev ?
References: <3FC7B008-487C-11D8-AED9-000A95A0560C@us.ibm.com> <20040117001739.GB3840@kroah.com>
In-Reply-To: <20040117001739.GB3840@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> How about just adding a find_device() function to the driver core, where
> you pass in a name and a type, so that others can use it?

Something like this?

===== include/linux/device.h 1.111 vs edited =====
--- 1.111/include/linux/device.h        Mon Dec 29 15:38:10 2003
+++ edited/include/linux/device.h       Mon Jan 19 14:25:26 2004
@@ -354,6 +354,7 @@
   */
  extern struct device * get_device(struct device * dev);
  extern void put_device(struct device * dev);
+extern struct device *find_device(const char *name, struct bus_type *bus);


  /* drivers/base/platform.c */
===== drivers/base/core.c 1.78 vs edited =====
--- 1.78/drivers/base/core.c    Mon Sep 29 16:20:44 2003
+++ edited/drivers/base/core.c  Mon Jan 19 14:33:42 2004
@@ -400,6 +400,14 @@
         return error;
  }

+struct device *find_device(const char *name, struct bus_type *bus)
+{
+       struct kobject *k = kset_find_obj(&bus->devices, name);
+       if (k)
+               return to_dev(k);
+       return NULL;
+}
+
  int __init devices_init(void)
  {
         return subsystem_register(&devices_subsys);
@@ -416,6 +424,7 @@
  EXPORT_SYMBOL(device_unregister_wait);
  EXPORT_SYMBOL(get_device);
  EXPORT_SYMBOL(put_device);
+EXPORT_SYMBOL(find_device);

  EXPORT_SYMBOL(device_create_file);
  EXPORT_SYMBOL(device_remove_file);


-- 
Hollis Blanchard
IBM Linux Technology Center
