Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVAUPP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVAUPP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 10:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVAUPP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 10:15:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11957 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262384AbVAUPPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 10:15:17 -0500
Message-ID: <41F11C66.5000707@sgi.com>
Date: Fri, 21 Jan 2005 10:14:46 -0500
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: [PATCH][RFC]: Clean up resource allocation in i8042 driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch cleans up resource allocations in the i8042 driver 
when initialization fails.

Please consider for tree application.  Patch is generated against 
current bk pull.

Thanks,

P.

Signed-off-by: Prarit Bhargava <prarit@sgi.com>

===== i8042.c 1.71 vs edited =====
--- 1.71/drivers/input/serio/i8042.c    2005-01-03 08:11:49 -05:00
+++ edited/i8042.c      2005-01-21 10:02:20 -05:00
@@ -696,7 +696,10 @@
                unsigned char param;
 
                if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
-                       printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
+                       if (i8042_read_status() != 0xFF)
+                               printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
+                       else
+                               printk(KERN_ERR "i8042.c: no i8042 controller found.\n");
                        return -1;
                }
 
                }

@@ -1011,21 +1014,34 @@
        i8042_timer.function = i8042_timer_func;
 
        if (i8042_platform_init())
+       {
+               del_timer_sync(&i8042_timer);
                return -EBUSY;
+       }
 
        i8042_aux_values.irq = I8042_AUX_IRQ;
        i8042_kbd_values.irq = I8042_KBD_IRQ;
 
        if (i8042_controller_init())
+       {
+               i8042_platform_exit();
+               del_timer_sync(&i8042_timer);
                return -ENODEV;
+       }
 
        err = driver_register(&i8042_driver);
        if (err)
+       {
+               i8042_platform_exit();
+               del_timer_sync(&i8042_timer);
                return err;
+       }

        i8042_platform_device = platform_device_register_simple("i8042", -1, NULL, 0);
        if (IS_ERR(i8042_platform_device)) {
                driver_unregister(&i8042_driver);
+               i8042_platform_exit();
+               del_timer_sync(&i8042_timer);
                return PTR_ERR(i8042_platform_device);
        }



