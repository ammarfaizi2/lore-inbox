Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269709AbTGZPvi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272557AbTGZPsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:48:43 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:50654 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S270158AbTGZPoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:44:54 -0400
Date: Sat, 26 Jul 2003 17:59:52 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Michael Hunold <hunold@convergence.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       John Alvord <jalvo@mbay.net>
Subject: Re: [PATCH] request_firmware() private workqueue (was: Re: Using firmware_class with recent 2.6 kernels)
Message-ID: <20030726155952.GA23335@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <3F1BD157.4090509@convergence.de> <20030726101818.GA25104@ranty.pantax.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20030726101818.GA25104@ranty.pantax.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 26, 2003 at 12:18:18PM +0200, Manuel Estrada Sainz wrote:
> On Mon, Jul 21, 2003 at 01:41:11PM +0200, Michael Hunold wrote:
[snip]
>  About the attached patch:
>  
>  	- use a private workqueue so we can sleep without interfering
> 	  with other subsystems.

 Oops, as usuall I forgot to attach the patch, It is attached now.

 Sorry

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="request_firmware_own-workqueue.diff"

Index: firmware_class.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/base/firmware_class.c,v
retrieving revision 1.3
diff -u -r1.3 firmware_class.c
--- firmware_class.c	4 Jul 2003 02:21:18 -0000	1.3
+++ firmware_class.c	26 Jul 2003 08:38:07 -0000
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

--nFreZHaLTZJo0R7j--
