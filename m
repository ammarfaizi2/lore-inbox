Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262774AbRE0GvG>; Sun, 27 May 2001 02:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbRE0Gu5>; Sun, 27 May 2001 02:50:57 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:42321 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262774AbRE0Gun>; Sun, 27 May 2001 02:50:43 -0400
Date: Sun, 27 May 2001 02:49:35 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: jerdfelt@valinux.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [linux-usb-devel] USB oops on SMP, 2.4.5 kernel, and other problems
Message-ID: <20010527024935.E26250@devserv.devel.redhat.com>
In-Reply-To: <20010526143724.A302@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010526143724.A302@linuxhacker.ru>; from green@linuxhacker.ru on Sat, May 26, 2001 at 02:37:24PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Oleg Drokin <green@linuxhacker.ru>
> To: jerdfelt@valinux.com, linux-usb-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Date: Sat, 26 May 2001 14:37:24 +0400

> >>EIP; c01a3162 <call_policy+162/1f0>   <=====
> Trace; c01a42fc <usb_disconnect+fc/130>
> Trace; c01a5f9c <hub_disconnect+1c/80>
> Trace; c01a42e0 <usb_disconnect+e0/130>
> Trace; c019f19f <pci_unregister_driver+2f/50>
> Trace; c0118a9e <free_module+1e/d0>
> Trace; c0117e62 <sys_delete_module+132/270>
> Trace; c0106e0b <system_call+33/38>

This is a relatively known problem, on SMP. My old patch for that
sort of thing fixed it, and the replacement that Johannes rolled
did not fix it completely. Linus did not like my fix, because
the kindest apprisal that he used was "idiocy".

For the moment I in Red Hat ship a patch that backs out the
Johannes' fix and reinstalls my fix, because I would rather
have things working than get Linus pleased (even if such
a thing was possible...). Johannes is generally on the right
track here and will fix it compeltely in time, one way or
another (e.g. perhaps adding one more refcounting somewhere :)

If someone needs a resolution until Johannes completes it,
use my attached patch, or use Red Hat kernels.

-- Pete

--- linux-2.4.5/drivers/usb/hub.h	Tue Apr 17 17:23:06 2001
+++ linux-2.4.5-tr5/drivers/usb/hub.h	Sat May 26 07:39:34 2001
@@ -109,7 +109,7 @@
 
 	struct usb_hub_descriptor *descriptor;
 
-	atomic_t refcnt;
+ 	struct semaphore khubd_sem;
 };
 
 #endif
--- linux-2.4.5/drivers/usb/hub.c	Wed Apr 25 14:10:47 2001
+++ linux-2.4.5-tr5/drivers/usb/hub.c	Sat May 26 07:44:10 2001
@@ -289,7 +289,7 @@
 
 	INIT_LIST_HEAD(&hub->event_list);
 	hub->dev = dev;
-	atomic_set(&hub->refcnt, 1);
+	init_MUTEX(&hub->khubd_sem);
 
 	/* Record the new hub's existence */
 	spin_lock_irqsave(&hub_event_lock, flags);
@@ -318,34 +318,11 @@
 	return NULL;
 }
 
-static void hub_get(struct usb_hub *hub)
-{
-	atomic_inc(&hub->refcnt);
-}
-
-static void hub_put(struct usb_hub *hub)
-{
-	if (atomic_dec_and_test(&hub->refcnt)) {
-		if (hub->descriptor) {
-			kfree(hub->descriptor);
-			hub->descriptor = NULL;
-		}
-
-		kfree(hub);
-	}
-}
-
 static void hub_disconnect(struct usb_device *dev, void *ptr)
 {
 	struct usb_hub *hub = (struct usb_hub *)ptr;
 	unsigned long flags;
 
-	if (hub->urb) {
-		usb_unlink_urb(hub->urb);
-		usb_free_urb(hub->urb);
-		hub->urb = NULL;
-	}
-
 	spin_lock_irqsave(&hub_event_lock, flags);
 
 	/* Delete it and then reset it */
@@ -356,7 +333,22 @@
 
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 
-	hub_put(hub);
+	down(&hub->khubd_sem); /* Wait for khubd to leave this hub alone. */
+	up(&hub->khubd_sem);
+
+	if (hub->urb) {
+		usb_unlink_urb(hub->urb);
+		usb_free_urb(hub->urb);
+		hub->urb = NULL;
+	}
+
+	if (hub->descriptor) {
+		kfree(hub->descriptor);
+		hub->descriptor = NULL;
+	}
+
+	/* Free the memory */
+	kfree(hub);
 }
 
 static int hub_ioctl(struct usb_device *hub, unsigned int code, void *user_data)
@@ -668,7 +660,7 @@
 		list_del(tmp);
 		INIT_LIST_HEAD(tmp);
 
-		hub_get(hub);
+		down(&hub->khubd_sem); /* never blocks, we were on list */
 		spin_unlock_irqrestore(&hub_event_lock, flags);
 
 		if (hub->error) {
@@ -676,8 +668,8 @@
 
 			if (usb_hub_reset(hub)) {
 				err("error resetting hub %d - disconnecting", dev->devnum);
+				up(&hub->khubd_sem);
 				usb_hub_disconnect(dev);
-				hub_put(hub);
 				continue;
 			}
 
@@ -753,7 +745,7 @@
                         	usb_hub_power_on(hub);
 			}
 		}
-		hub_put(hub);
+		up(&hub->khubd_sem);
         } /* end while (1) */
 
 	spin_unlock_irqrestore(&hub_event_lock, flags);
