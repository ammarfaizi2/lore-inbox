Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132078AbRCMVsR>; Tue, 13 Mar 2001 16:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132079AbRCMVsA>; Tue, 13 Mar 2001 16:48:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7373 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131187AbRCMVcL>;
	Tue, 13 Mar 2001 16:32:11 -0500
Date: Tue, 13 Mar 2001 15:44:58 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: randy.dunlap@intel.com, david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, teg@redhat.com
Subject: Fix to khubd oops, hellooo?
Message-ID: <20010313154458.A2362@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is my fix to khubd going anywhere? Randy, David?
I have an actual, reproducible bug that I need to close.
Here's my message to linux-usb-devel with explanations:
  http://marc.theaimsgroup.com/?l=linux-usb-devel&m=98411157628404&w=2

-- Pete

diff -ur -X ../dontdiff linux-2.4.2-ac12/drivers/usb/hub.c linux-2.4.2-ac12-p3/drivers/usb/hub.c
--- linux-2.4.2-ac12/drivers/usb/hub.c	Wed Mar  7 12:17:02 2001
+++ linux-2.4.2-ac12-p3/drivers/usb/hub.c	Thu Mar  8 19:43:14 2001
@@ -357,6 +357,7 @@
 
 	INIT_LIST_HEAD(&hub->event_list);
 	hub->dev = dev;
+	init_MUTEX(&hub->khubd_sem);
 
 	/* Record the new hub's existence */
 	spin_lock_irqsave(&hub_event_lock, flags);
@@ -400,6 +399,9 @@
 
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 
+	down(&hub->khubd_sem);	/* Wait for khubd to leave this hub alone. */
+	up(&hub->khubd_sem);
+
 	if (hub->urb) {
 		usb_unlink_urb(hub->urb);
 		usb_free_urb(hub->urb);
@@ -709,7 +717,7 @@
 		spin_lock_irqsave(&hub_event_lock, flags);
 
 		if (list_empty(&hub_event_list))
-			goto he_unlock;
+			break;
 
 		/* Grab the next entry from the beginning of the list */
 		tmp = hub_event_list.next;
@@ -720,6 +728,7 @@
 		list_del(tmp);
 		INIT_LIST_HEAD(tmp);
 
+		down(&hub->khubd_sem);	/* never blocks, we were on list */
 		spin_unlock_irqrestore(&hub_event_lock, flags);
 
 		if (hub->error) {
@@ -728,6 +737,7 @@
 			if (usb_hub_reset(hub)) {
 				err("error resetting hub %d - disconnecting", dev->devnum);
 				usb_hub_disconnect(dev);
+				up(&hub->khubd_sem);
 				continue;
 			}
 
@@ -742,6 +752,7 @@
 			ret = usb_get_port_status(dev, i + 1, &portsts);
 			if (ret < 0) {
 				err("get_port_status failed (err = %d)", ret);
+				up(&hub->khubd_sem);
 				continue;
 			}
 
@@ -803,9 +814,9 @@
                         	usb_hub_power_on(hub);
 			}
 		}
+		up(&hub->khubd_sem);
         } /* end while (1) */
 
-he_unlock:
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 }
 
diff -ur -X ../dontdiff linux-2.4.2-ac12/drivers/usb/hub.h linux-2.4.2-ac12-p3/drivers/usb/hub.h
--- linux-2.4.2-ac12/drivers/usb/hub.h	Wed Mar  7 12:17:02 2001
+++ linux-2.4.2-ac12-p3/drivers/usb/hub.h	Thu Mar  8 19:17:38 2001
@@ -134,6 +134,8 @@
 	struct list_head event_list;
 
 	struct usb_hub_descriptor *descriptor;
+
+	struct semaphore khubd_sem;
 };
 
 #endif /* __LINUX_HUB_H */
