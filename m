Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267139AbRGJUnS>; Tue, 10 Jul 2001 16:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267140AbRGJUnI>; Tue, 10 Jul 2001 16:43:08 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:61278 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267139AbRGJUms>; Tue, 10 Jul 2001 16:42:48 -0400
Date: Tue, 10 Jul 2001 16:42:49 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: johannes@erdfelt.com
Cc: linux-kernel@vger.kernel.org
Subject: Fwd: Claim serialization problem
Message-ID: <20010710164249.B30050@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes,

the attached patch fixed a real problem for me and
the linux-usb-devel folks agreed it was a good fix.
Do you mind to push it to Linus? The 2.4.6 still
has no trace of it.

Thanks,
-- Pete

cc: to linux-kernel in case the maintainer is hit by a bus.

----- Forwarded message from Pete Zaitcev <zaitcev@redhat.com> -----

Date: Tue, 29 May 2001 23:07:58 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: zaitcev@redhat.com
Subject: Claim serialization problem
User-Agent: Mutt/1.2.5i

Hi,

I attached a USB tape (Freecom based) to my machine and
the usb-storage driver registered itself 3 times with SCSI.
Upon a closer inspection the following was found, approximately:

usb_find_interface_driver () {
        if (usb_interface_claimed(interface))
                goto out_err;
        down(&driver->serialize);
        private = driver->probe(dev,ifnum,id);
        up(&driver->serialize);
	usb_driver_claim_interface(driver, interface, private);
}

This is wrong even on UP.

Here is a patch that fixes the problem for me:

diff -ur linux-2.4.5/drivers/usb/usb.c linux-2.4.5-tr5/drivers/usb/usb.c
--- linux-2.4.5/drivers/usb/usb.c	Sat Apr 28 11:28:09 2001
+++ linux-2.4.5-tr5/drivers/usb/usb.c	Tue May 29 18:22:19 2001
@@ -688,10 +688,12 @@
 		return -1;
 	}
 
+	down(&dev->serialize);
+
 	interface = dev->actconfig->interface + ifnum;
 
 	if (usb_interface_claimed(interface))
-		return -1;
+		goto out_err;
 
 	private = NULL;
 	for (tmp = usb_driver_list.next; tmp != &usb_driver_list;) {
@@ -699,7 +701,6 @@
 		driver = list_entry(tmp, struct usb_driver, driver_list);
 		tmp = tmp->next;
 
-		down(&driver->serialize);
 		id = driver->id_table;
 		/* new style driver? */
 		if (id) {
@@ -707,7 +708,9 @@
 			  	interface->act_altsetting = i;
 				id = usb_match_id(dev, interface, id);
 				if (id) {
+					down(&driver->serialize);
 					private = driver->probe(dev,ifnum,id);
+					up(&driver->serialize);
 					if (private != NULL)
 						break;
 				}
@@ -717,15 +720,21 @@
 				interface->act_altsetting = 0;
 		}
 		else /* "old style" driver */
+		{
+			down(&driver->serialize);
 			private = driver->probe(dev, ifnum, NULL);
+			up(&driver->serialize);
+		}
 
-		up(&driver->serialize);
 		if (private) {
 			usb_driver_claim_interface(driver, interface, private);
+			up(&dev->serialize);
 			return 0;
 		}
 	}
 
+out_err:
+	up(&dev->serialize);
 	return -1;
 }
 
@@ -924,6 +933,8 @@
 	atomic_set(&dev->refcnt, 1);
 	INIT_LIST_HEAD(&dev->inodes);
 	INIT_LIST_HEAD(&dev->filelist);
+
+	init_MUTEX(&dev->serialize);
 
 	dev->bus->op->allocate(dev);
 
diff -ur linux-2.4.5/include/linux/usb.h linux-2.4.5-tr5/include/linux/usb.h
--- linux-2.4.5/include/linux/usb.h	Fri May 25 18:02:43 2001
+++ linux-2.4.5-tr5/include/linux/usb.h	Tue May 29 18:12:33 2001
@@ -595,6 +595,7 @@
 	int slow;			/* Slow device? */
 
 	atomic_t refcnt;		/* Reference count */
+	struct semaphore serialize;
 
 	unsigned int toggle[2];		/* one bit for each endpoint ([0] = IN, [1] = OUT) */
 	unsigned int halted[2];		/* endpoint halts; one bit per endpoint # & direction; */

Two notes about parts missing from the patch:
 1. Disconnect is not handled. I think the author intended to handle it
differently, with a usage count. See the source...
 2. Drivers call claim_interface, and it seems they do it safely.
devio.c brackets it with lock_kernel/unlock_kernel. mdc800.c,
audio.c and acm.c do not attempt to claim something that they
do no own, so the old semaphore protects them.

-- Pete

----- End forwarded message -----
