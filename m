Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWF1XtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWF1XtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWF1XtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:49:13 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:32657 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751793AbWF1XtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:49:11 -0400
Date: Wed, 28 Jun 2006 19:49:09 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       David Quigley <dpquigl@tycho.nsa.gov>, gregkh@suse.de
Subject: [PATCH 3/3] SELinux: Update USB code with new kill_proc_info_as_uid
In-Reply-To: <Pine.LNX.4.64.0606281943240.17149@d.namei>
Message-ID: <Pine.LNX.4.64.0606281946561.17159@d.namei>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch updates the USB core to save and pass the sending task secid 
when sending signals upon AIO completion so that proper security checking 
can be applied by security modules.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>


Please apply.

---

 drivers/usb/core/devio.c |    6 +++++-
 drivers/usb/core/inode.c |    2 +-
 drivers/usb/core/usb.h   |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/drivers/usb/core/devio.c linux-2.6.17-mm3-kill/drivers/usb/core/devio.c
--- linux-2.6.17-mm3/drivers/usb/core/devio.c	2006-06-28 13:58:55.000000000 -0400
+++ linux-2.6.17-mm3-kill/drivers/usb/core/devio.c	2006-06-28 14:32:30.000000000 -0400
@@ -47,6 +47,7 @@
 #include <linux/usbdevice_fs.h>
 #include <linux/cdev.h>
 #include <linux/notifier.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 #include <linux/moduleparam.h>
@@ -68,6 +69,7 @@ struct async {
 	void __user *userbuffer;
 	void __user *userurb;
 	struct urb *urb;
+	u32 secid;
 };
 
 static int usbfs_snoop = 0;
@@ -312,7 +314,7 @@ static void async_completed(struct urb *
 		sinfo.si_code = SI_ASYNCIO;
 		sinfo.si_addr = as->userurb;
 		kill_proc_info_as_uid(as->signr, &sinfo, as->pid, as->uid, 
-				      as->euid);
+				      as->euid, as->secid);
 	}
 	snoop(&urb->dev->dev, "urb complete\n");
 	snoop_urb(urb, as->userurb);
@@ -572,6 +574,7 @@ static int usbdev_open(struct inode *ino
 	ps->disc_euid = current->euid;
 	ps->disccontext = NULL;
 	ps->ifclaimed = 0;
+	security_task_getsecid(current, &ps->secid);
 	wmb();
 	list_add_tail(&ps->list, &dev->filelist);
 	file->private_data = ps;
@@ -1053,6 +1056,7 @@ static int proc_do_submiturb(struct dev_
 	as->pid = current->pid;
 	as->uid = current->uid;
 	as->euid = current->euid;
+	security_task_getsecid(current, &as->secid);
 	if (!(uurb->endpoint & USB_DIR_IN)) {
 		if (copy_from_user(as->urb->transfer_buffer, uurb->buffer, as->urb->transfer_buffer_length)) {
 			free_async(as);
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/drivers/usb/core/inode.c linux-2.6.17-mm3-kill/drivers/usb/core/inode.c
--- linux-2.6.17-mm3/drivers/usb/core/inode.c	2006-06-28 13:58:55.000000000 -0400
+++ linux-2.6.17-mm3-kill/drivers/usb/core/inode.c	2006-06-28 14:33:00.000000000 -0400
@@ -700,7 +700,7 @@ static void usbfs_remove_device(struct u
 			sinfo.si_errno = EPIPE;
 			sinfo.si_code = SI_ASYNCIO;
 			sinfo.si_addr = ds->disccontext;
-			kill_proc_info_as_uid(ds->discsignr, &sinfo, ds->disc_pid, ds->disc_uid, ds->disc_euid);
+			kill_proc_info_as_uid(ds->discsignr, &sinfo, ds->disc_pid, ds->disc_uid, ds->disc_euid, ds->secid);
 		}
 	}
 }
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/drivers/usb/core/usb.h linux-2.6.17-mm3-kill/drivers/usb/core/usb.h
--- linux-2.6.17-mm3/drivers/usb/core/usb.h	2006-06-28 13:58:55.000000000 -0400
+++ linux-2.6.17-mm3-kill/drivers/usb/core/usb.h	2006-06-28 14:33:46.000000000 -0400
@@ -80,6 +80,7 @@ struct dev_state {
 	uid_t disc_uid, disc_euid;
 	void __user *disccontext;
 	unsigned long ifclaimed;
+	u32 secid;
 };
 
 /* internal notify stuff */
