Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271217AbTHATPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270875AbTHATPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:15:17 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:53167 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S272985AbTHATPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:15:09 -0400
Date: Fri, 1 Aug 2003 21:15:04 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Michael Hunold <hunold@convergence.de>
Subject: [PATCH] Re: request_firmware() private workqueue
Message-ID: <20030801191504.GA32044@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <3F1BD157.4090509@convergence.de> <20030726101818.GA25104@ranty.pantax.net> <20030726155952.GA23335@ranty.pantax.net> <3F268C84.6060004@convergence.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <3F268C84.6060004@convergence.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2003 at 05:02:28PM +0200, Michael Hunold wrote:
> Hello Manuel,
> 
> I've applied your patches
> - request_firmware_own-workqueue.diff
> - sysfs-bin-unbreak.diff
> 
> and it's working very well for the av7110 DVB driver.
> 
> I hope that these patches are applied to the mainline kernel soon, so 
> the other DVB drivers which need binary firmware blobs (namely 
> dvb-ttusb-dec, dvb-ttusb-budget and one frontend driver) can be ported.
> 
> This will get rid of the av7110 firmware in the kernel and the ugly 
> config hacks to get the other drivers working.

 In it's current form request_firmware_async() sleeps way too long on
 the system's shared workqueue, which make it unresponsive until the
 firmware load finishes or gets canceled.

 The attached patch makes it use it's own workqueue, please apply.

 Have a nice day

 	Manuel

 PS: the sysfs issue is handled in a separate email.

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="request_firmware_own-workqueue.diff"

Index: drivers/base/firmware_class.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/base/firmware_class.c,v
retrieving revision 1.3
diff -u -r1.3 drivers/base/firmware_class.c
--- drivers/base/firmware_class.c	4 Jul 2003 02:21:18 -0000	1.3
+++ drivers/base/firmware_class.c	26 Jul 2003 08:38:07 -0000
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

--i9LlY+UWpKt15+FH--
