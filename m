Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266469AbUFQMhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbUFQMhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUFQMhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:37:31 -0400
Received: from p10068181.pureserver.de ([217.160.75.209]:12812 "EHLO
	www.kuix.de") by vger.kernel.org with ESMTP id S266469AbUFQMhY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:37:24 -0400
Message-ID: <40D1909F.4090408@kuix.de>
Date: Thu, 17 Jun 2004 14:37:51 +0200
From: Kai Engert <kaie@kuix.de>
Reply-To: kai.engert@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, "Nemosoft Unv." <webcam@smcc.demon.nl>
Subject: Re: small patch: enable pwc usb camera driver
References: <40C466FB.1040309@kuix.de> <20040607202036.GA6185@kroah.com> <200406080027.04577@smcc.demon.nl> <20040607223919.GA9172@kroah.com>
In-Reply-To: <20040607223919.GA9172@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------020502010302080400000305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020502010302080400000305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Tue, Jun 08, 2004 at 12:27:04AM +0200, Nemosoft Unv. wrote:
>> ... 
>>Don't use this. It will BUG() your kernel hard, because of a double free(). 

I confirm, if you disconnect the device / unload the driver, it doesn't 
take long and the kernel reports an exception. My fault, sorry.

> ... I'll wait for someone to send another patch fixing this one ...

I'm attaching a new patch:

- revert video device release code to original no-op,
   using correct function signature.

With this patch applied to 2.6.7, I am able to connect/disconnect the 
camera, load/unload the driver 20 times and everything still works fine.

No warnings during compilation (which was the original reason to mark 
the driver broken, IIUC).

Thanks and Regards,
Kai

--------------020502010302080400000305
Content-Type: text/plain;
 name="pwcdiff3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pwcdiff3"

diff -ruw org-267/drivers/usb/media/pwc-if.c linux-2.6.7/drivers/usb/media/pwc-if.c
--- org-267/drivers/usb/media/pwc-if.c	2004-06-16 07:19:44.000000000 +0200
+++ linux-2.6.7/drivers/usb/media/pwc-if.c	2004-06-17 13:49:58.268336544 +0200
@@ -129,6 +129,7 @@
 
 static int pwc_video_open(struct inode *inode, struct file *file);
 static int pwc_video_close(struct inode *inode, struct file *file);
+static void pwc_video_release(struct video_device *);
 static ssize_t pwc_video_read(struct file *file, char *buf,
 			  size_t count, loff_t *ppos);
 static unsigned int pwc_video_poll(struct file *file, poll_table *wait);
@@ -1120,6 +1121,12 @@
 	return 0;
 }
 
+static void pwc_video_release(struct video_device *vfd)
+{
+	/* Do nothing to prevent a double free */
+	Trace(TRACE_OPEN, "pwc_video_release() called.\n");
+}
+
 /*
  *	FIXME: what about two parallel reads ????
  *      ANSWER: Not supported. You can't open the device more than once,
@@ -1848,7 +1855,7 @@
 		}
 	}
 
-	pdev->vdev.release = video_device_release;
+	pdev->vdev.release = pwc_video_release;
 	i = video_register_device(&pdev->vdev, VFL_TYPE_GRABBER, video_nr);
 	if (i < 0) {
 		Err("Failed to register as video device (%d).\n", i);

--------------020502010302080400000305--
