Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129178AbQKOHeH>; Wed, 15 Nov 2000 02:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKOHd5>; Wed, 15 Nov 2000 02:33:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20868 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129091AbQKOHdi>;
	Wed, 15 Nov 2000 02:33:38 -0500
Date: Tue, 14 Nov 2000 22:48:45 -0800
Message-Id: <200011150648.WAA03713@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: comandante@zaralinux.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A11C0C9.665B1EB0@zaralinux.com> (message from Jorge Nerin on
	Tue, 14 Nov 2000 23:46:33 +0100)
Subject: Re: kernel BUG at sock.c:722! (2.4.0-test11-pre4)
In-Reply-To: <3A11C0C9.665B1EB0@zaralinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Tue, 14 Nov 2000 23:46:33 +0100
   From: Jorge Nerin <comandante@zaralinux.com>

   Well, first saw this in test11-pre1, and now in test11-pre4 I report it
   again.

Do you use any one of USB, PCMCIA+Yenta, or ATM?  If so, please give
the following patch a try.

If not, do you use KHTTPD?  If so, please don't... it's unmaintained,
buggy, and to eventually be replaced by TUX.

--- ./drivers/sbus/char/su.c.~1~	Sat Oct 14 03:09:04 2000
+++ ./drivers/sbus/char/su.c	Tue Nov 14 23:28:09 2000
@@ -1,4 +1,4 @@
-/* $Id: su.c,v 1.42 2000/10/14 10:09:04 davem Exp $
+/* $Id: su.c,v 1.43 2000/11/15 07:28:09 davem Exp $
  * su.c: Small serial driver for keyboard/mouse interface on sparc32/PCI
  *
  * Copyright (C) 1997  Eddie C. Dost  (ecd@skynet.be)
@@ -2001,6 +2001,7 @@
 #endif
 		schedule();
 	}
+	current->state = TASK_RUNNING;
 	remove_wait_queue(&info->open_wait, &wait);
 	if (extra_count)
 		info->count++;
@@ -2219,7 +2220,7 @@
  */
 static __inline__ void __init show_su_version(void)
 {
-	char *revision = "$Revision: 1.42 $";
+	char *revision = "$Revision: 1.43 $";
 	char *version, *p;
 
 	version = strchr(revision, ' ');
--- ./drivers/sbus/char/sab82532.c.~1~	Sat Oct 14 03:09:04 2000
+++ ./drivers/sbus/char/sab82532.c	Tue Nov 14 23:28:09 2000
@@ -1,4 +1,4 @@
-/* $Id: sab82532.c,v 1.52 2000/10/14 10:09:04 davem Exp $
+/* $Id: sab82532.c,v 1.53 2000/11/15 07:28:09 davem Exp $
  * sab82532.c: ASYNC Driver for the SIEMENS SAB82532 DUSCC.
  *
  * Copyright (C) 1997  Eddie C. Dost  (ecd@skynet.be)
@@ -1833,6 +1833,7 @@
 #endif
 		schedule();
 	}
+	current->state = TASK_RUNNING;
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;
@@ -2133,7 +2134,7 @@
 
 static inline void __init show_serial_version(void)
 {
-	char *revision = "$Revision: 1.52 $";
+	char *revision = "$Revision: 1.53 $";
 	char *version, *p;
 
 	version = strchr(revision, ' ');
--- ./drivers/usb/storage/transport.c.~1~	Sun Nov 12 00:22:27 2000
+++ ./drivers/usb/storage/transport.c	Tue Nov 14 22:28:51 2000
@@ -423,6 +423,7 @@
 	if (status) {
 		/* something went wrong */
 		up(&(us->current_urb_sem));
+		current->state = TASK_RUNNING;
 		remove_wait_queue(&wqh, &wait);
 		kfree(dr);
 		return status;
@@ -480,6 +481,7 @@
 	if (status) {
 		/* something went wrong */
 		up(&(us->current_urb_sem));
+		current->state = TASK_RUNNING;
 		remove_wait_queue(&wqh, &wait);
 		return status;
 	}
--- ./drivers/usb/usb.c.~1~	Tue Nov 14 14:21:38 2000
+++ ./drivers/usb/usb.c	Tue Nov 14 22:27:22 2000
@@ -951,6 +951,7 @@
 	if (status) {
 		// something went wrong
 		usb_free_urb(urb);
+		current->state = TASK_RUNNING;
 		remove_wait_queue(&wqh, &wait);
 		return status;
 	}
@@ -961,6 +962,7 @@
 	} else
 		status = 1;
 
+	current->state = TASK_RUNNING;
 	remove_wait_queue(&wqh, &wait);
 
 	if (!status) {
--- ./drivers/usb/net1080.c.~1~	Sun Nov 12 00:22:26 2000
+++ ./drivers/usb/net1080.c	Tue Nov 14 22:27:49 2000
@@ -653,6 +653,7 @@
 		dbg ("waited for %d urb completions", temp);
 	}
 	dev->wait = 0;
+	current->state = TASK_RUNNING;
 	remove_wait_queue (&unlink_wakeup, &wait); 
 
 	mutex_unlock (&dev->mutex);
--- ./drivers/usb/usb-ohci.c.~1~	Tue Oct 31 12:58:00 2000
+++ ./drivers/usb/usb-ohci.c	Tue Nov 14 22:28:15 2000
@@ -654,6 +654,7 @@
 				set_current_state(TASK_UNINTERRUPTIBLE);
 				while (timeout && (urb->status == USB_ST_URB_PENDING))
 					timeout = schedule_timeout (timeout);
+				current->state = TASK_RUNNING;
 				remove_wait_queue (&unlink_wakeup, &wait); 
 				if (urb->status == USB_ST_URB_PENDING) {
 					err ("unlink URB timeout");
@@ -765,6 +766,7 @@
 				set_current_state(TASK_UNINTERRUPTIBLE);
 				while (timeout && dev->ed_cnt)
 					timeout = schedule_timeout (timeout);
+				current->state = TASK_RUNNING;
 				remove_wait_queue (&freedev_wakeup, &wait);
 				if (dev->ed_cnt) {
 					err ("free device %d timeout", usb_dev->devnum);
--- ./drivers/atm/atmtcp.c.~1~	Sat Jun 24 05:40:27 2000
+++ ./drivers/atm/atmtcp.c	Tue Nov 14 22:29:32 2000
@@ -77,6 +77,7 @@
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 	}
+	current->state = TASK_RUNNING;
 	remove_wait_queue(&vcc->sleep,&wait);
 	return error;
 }
--- ./drivers/pcmcia/yenta.c.~1~	Tue Nov  7 21:04:48 2000
+++ ./drivers/pcmcia/yenta.c	Tue Nov 14 22:29:54 2000
@@ -585,6 +585,7 @@
 		add_wait_queue(&socket->wait, &wait);
 		if (!socket->events)
 			schedule_timeout(HZ);
+		current->state = TASK_RUNNING;
 		remove_wait_queue(&socket->wait, &wait);
 	} while (!signal_pending(current));
 	MOD_DEC_USE_COUNT;
--- ./net/atm/signaling.c.~1~	Tue Jul 11 22:52:09 2000
+++ ./net/atm/signaling.c	Tue Nov 14 22:40:26 2000
@@ -50,6 +50,7 @@
 		}
 		schedule();
 	}
+	current->state = TASK_RUNNING;
 	remove_wait_queue(&sigd_sleep,&wait);
 #else
 	if (!sigd) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
