Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTJHPzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTJHPzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:55:17 -0400
Received: from mail.convergence.de ([212.84.236.4]:8169 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261685AbTJHPyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:54:22 -0400
Message-ID: <3F84332A.6080707@convergence.de>
Date: Wed, 08 Oct 2003 17:54:18 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: ranty@debian.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/14] firmware update for av7110 dvb driver
References: <10656197272107@convergence.de> <1065624307.5470.242.camel@pegasus> <3F842EEE.5070001@convergence.de>
In-Reply-To: <3F842EEE.5070001@convergence.de>
Content-Type: multipart/mixed;
 boundary="------------080208030807010209040204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080208030807010209040204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel,
>>> ... send to Linus only. (You don't want a 150kB bzip2 compressed 
>>> firmware blob, don't you? In case you do, drop me a line.)
> 
> 
>> the request_firmware() framework is part of Linux 2.4 and 2.6 and so for
>> most drivers the firmware file can be loaded from userspace through proc
>> or sysfs. Please take a look at it.

> Yes, we know. When I looked at it the last time, there were some 
> problems that kept us from actually finishing the work.
> 
> (If you did not use a hotplug agent, then the system was frozen, because 
> the firmware foo did not use it's own workqueue)

As a follow-up to my post: I just checked what already got in and what's 
still missing. I attached the stuff from request_firmwar() that didn't 
make it into the kernel yet.

Please note that I did not check if the problem has been solved 
otherwise. Perhaps Manuel Estrada Sainz <ranty@debian.org> can tell us 
what the current state is?

CU
Michael.

--------------080208030807010209040204
Content-Type: text/plain;
 name="xx-01-FC-request_firmware_own-workqueue.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xx-01-FC-request_firmware_own-workqueue.diff"

diff -u -r1.3 firmware_class.c
--- linux/drivers/base/firmware_class.c	4 Jul 2003 02:21:18 -0000	1.3
+++ linux/drivers/base/firmware_class.c	26 Jul 2003 08:38:07 -0000
@@ -22,6 +22,8 @@
 MODULE_LICENSE("GPL");
 
 static int loading_timeout = 10;	/* In seconds */
+static struct workqueue_struct *firmware_wq;
+
 
 struct firmware_priv {
 	char fw_id[FIRMWARE_NAME_MAX];
@@ -467,7 +469,7 @@
 	};
 	INIT_WORK(&fw_work->work, request_firmware_work_func, fw_work);
 
-	schedule_work(&fw_work->work);
+	queue_work(firmware_wq, &fw_work->work);
 	return 0;
 }
 
@@ -485,12 +487,20 @@
 		       __FUNCTION__);
 		class_unregister(&firmware_class);
 	}
+	firmware_wq = create_workqueue("firmware");
+	if (!firmware_wq) {
+		printk(KERN_ERR "%s: create_workqueue failed\n", __FUNCTION__);
+		class_remove_file(&firmware_class, &class_attr_timeout);
+		class_unregister(&firmware_class);
+		error = -EIO;
+	}
 	return error;
 
 }
 static void __exit
 firmware_class_exit(void)
 {
+	destroy_workqueue(firmware_wq);
 	class_remove_file(&firmware_class, &class_attr_timeout);
 	class_unregister(&firmware_class);
 }

--------------080208030807010209040204--

