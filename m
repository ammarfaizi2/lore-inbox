Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270203AbTGMKTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270204AbTGMKTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:19:02 -0400
Received: from sun13.bham.ac.uk ([147.188.128.145]:12197 "EHLO
	sun13.bham.ac.uk") by vger.kernel.org with ESMTP id S270203AbTGMKSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:18:52 -0400
Subject: Re: 2.4.22pre3 / pwc / emi disconnect == oops, workaround
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1058085276.31918.31.camel@dhcp22.swansea.linux.org.uk>
References: <1058024543.8030.3.camel@sage.kitchen>
	 <1058085276.31918.31.camel@dhcp22.swansea.linux.org.uk>
Content-Type: multipart/mixed; boundary="=-N41sRy8w42tmVeUiElWI"
Organization: 
Message-Id: <1058092416.24654.11.camel@sage.kitchen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 11:33:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-N41sRy8w42tmVeUiElWI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

How about something like the attached patch ? (based on the se401
driver)

Caution: I'm not in front of the test machine currently, so it's only
had a compile test so far (and the EMI error only happens about once a
day)

Also, while I was grepping around, it seems ov511 suffers from the same
unregister in the disconnect callback.  Someone with an ov511 camera
might want to check into that.

Cheers,

Mark

On Sun, 2003-07-13 at 09:34, Alan Cox wrote:
> On Sad, 2003-07-12 at 16:42, Mark Cooke wrote:
> > 3. usb.c appears to force a disconnect immediately after #2.
> > 4. pwc module warns about a disconnect while open.
> > 5. Next call to video_ioctl with handle from #1 causes oops.
> 
> pwc driver bug. It must defer its unregister until it closes
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Mark Cooke <mpc@star.sr.bham.ac.uk>

--=-N41sRy8w42tmVeUiElWI
Content-Disposition: attachment; filename=patch-2.4.22-pre3-ac1-videodev
Content-Type: text/plain; name=patch-2.4.22-pre3-ac1-videodev; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.4.21/drivers/usb/pwc-if.c.orig	2003-03-04 22:43:01.000000000 +0000
+++ linux-2.4.21/drivers/usb/pwc-if.c	2003-07-13 10:55:10.000000000 +0100
@@ -1077,6 +1077,7 @@
 /* Note that all cleanup is done in the reverse order as in _open */
 static void pwc_video_close(struct video_device *vdev)
 {
+        /* Called with BKL held */
 	struct pwc_device *pdev;
 	int i;
 
@@ -1107,17 +1108,16 @@
 				Err("Failed to power down camera (%d)\n", i);
 		}
 	}
-
+	
 	pdev->vopen = 0;
-	if (pdev->decompressor != NULL) {
-		pdev->decompressor->exit();
-		pdev->decompressor->unlock();
-	}
-	pwc_free_buffers(pdev);
-
-	/* wake up _disconnect() routine */
-	if (pdev->unplugged)
-		wake_up(&pdev->remove_ok);
+	
+	if (pdev->unplugged) {
+	  /* Camera was unplugged during use.  Now the user is dead, we can
+	     unregister */
+	  video_unregister_device(pdev->vdev); 
+	  usb_pwc_remove_disconnected(pdev);
+	}
+	
 	Trace(TRACE_OPEN, "<< video_close()\n");
 }
 
@@ -1885,11 +1885,8 @@
 static void usb_pwc_disconnect(struct usb_device *udev, void *ptr)
 {
 	struct pwc_device *pdev;
-	int hint;
-	DECLARE_WAITQUEUE(wait, current);
 
 	lock_kernel();
-	free_mem_leak();
 
 	pdev = (struct pwc_device *)ptr;
 	if (pdev == NULL) {
@@ -1910,53 +1907,41 @@
 		return;
 	}
 #endif	
-	
-	pdev->unplugged = 1;
-	if (pdev->vdev != NULL) {
-		Trace(TRACE_PROBE, "Unregistering video device.\n");
-		video_unregister_device(pdev->vdev); 
-		if (pdev->vopen) {
-			Info("Disconnected while device/video is open!\n");
-			
-			/* Wake up any processes that might be waiting for
-			   a frame, let them return an error condition
-			 */
-			wake_up(&pdev->frameq);
-			
-			/* Wait until we get a 'go' from _close(). This used
-			   to have a gigantic race condition, since we kfree()
-			   stuff here, but we have to wait until close() 
-			   is finished. 
-			 */
-			   
-			Trace(TRACE_PROBE, "Sleeping on remove_ok.\n");
-			add_wait_queue(&pdev->remove_ok, &wait);
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			/* ... wait ... */
-			schedule();
-			remove_wait_queue(&pdev->remove_ok, &wait);
-			set_current_state(TASK_RUNNING);
-			Trace(TRACE_PROBE, "Done sleeping.\n");
-			set_mem_leak(pdev->vdev);
-			pdev->vdev = NULL;
-		}
-		else {
-			/* Normal disconnect; remove from available devices */
-			kfree(pdev->vdev);
-			pdev->vdev = NULL;
-		}
-	}
 
-	/* search device_hint[] table if we occupy a slot, by any chance */
-	for (hint = 0; hint < MAX_DEV_HINTS; hint++)
-		if (device_hint[hint].pdev == pdev)
-			device_hint[hint].pdev = NULL;
-
-	pdev->udev = NULL;
+	if (!pdev->user) {
+	  Trace(TRACE_PROBE, "Unregistering video device.\n");
+	  video_unregister_device(pdev->vdev); 
+	  usb_pwc_remove_disconnected(pdev);
+	} else {
+	  Trace(TRACE_PROBE, "Disconnect while open - defer until close.\n");
+	  pdev->unplugged = 1;
+	}
+	
 	unlock_kernel();
-	kfree(pdev);
 }
 
+static inline void usb_pwc_remove_disconnected(struct pwc_device *pdev)
+{
+  int hint;
+  
+  /* search device_hint[] table if we occupy a slot, by any chance */
+  for (hint = 0; hint < MAX_DEV_HINTS; hint++)
+    if (device_hint[hint].pdev == pdev)
+      device_hint[hint].pdev = NULL;
+  
+  if (pdev->decompressor != NULL) {
+    pdev->decompressor->exit();
+    pdev->decompressor->unlock();
+  }
+  pwc_free_buffers(pdev);
+  
+  /* Normal disconnect; remove from available devices */
+  free_mem_leak();
+  kfree(pdev->vdev);
+  pdev->vdev = NULL;
+  pdev->udev = NULL;
+  kfree(pdev);
+}
 
 /* *grunt* We have to do atoi ourselves :-( */
 static int pwc_atoi(const char *s)
--- linux-2.4.21/drivers/usb/pwc-if.c.orig	2003-07-13 10:58:24.000000000 +0100
+++ linux-2.4.21/drivers/usb/pwc-if.c	2003-07-13 11:01:49.000000000 +0100
@@ -94,6 +94,7 @@
 
 static void *usb_pwc_probe(struct usb_device *udev, unsigned int ifnum, const struct usb_device_id *id);
 static void usb_pwc_disconnect(struct usb_device *udev, void *ptr);
+static inline void usb_pwc_remove_disconnected(struct pwc_device *pdev);
 
 static struct usb_driver pwc_driver =
 {

--=-N41sRy8w42tmVeUiElWI--

