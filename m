Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272137AbRIJXH2>; Mon, 10 Sep 2001 19:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272135AbRIJXHJ>; Mon, 10 Sep 2001 19:07:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19139 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272122AbRIJXGT>; Mon, 10 Sep 2001 19:06:19 -0400
Message-ID: <3B9D477F.CABAFD79@us.ibm.com>
Date: Mon, 10 Sep 2001 16:06:39 -0700
From: "David C. Hansen" <haveblue@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter.Pregler@risc.uni-linz.ac.at
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] broken locking in CPiA driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a locking issue with the CPiA driver, and cleans up the
locking.  There is a potential race condition in cpia_pp_detach().  The
REMOVE_FROM_LIST macro uses the BKL to provide protection for the
cam_list.  However, the BKL is not held during the whole for loop, only
during the macro.  
 
This patch does several things:
1.  rename REMOVE_FROM_LIST and ADD_TO_LIST to cpia_remove_from_list and
cpia_add_to_list, respectively
2. make them "static inline" functions instead of #define macros. (take
a look at this, they probably should be functions)
3.  add one static spinlock cam_list_lock_{pp|usb} for each of the pp
and usb drivers to replace BKL
4.  do locking around all cam_list references to replace BKL locking
from the macros
5.  fix race condition
6.  initialize cam_list to NULL in pp driver, just like the usb driver.



--
David C. Hansen
haveblue@us.ibm.com
IBM LTC Base/OS Group
(503)578-4080


--- ../clean/linux/drivers/media/video/cpia_pp.c	Fri Mar  2 11:12:10
2001
+++ linux/drivers/media/video/cpia_pp.c	Mon Sep 10 16:02:42 2001
@@ -158,6 +158,7 @@
 };
 
 static struct cam_data *cam_list;
+static spinlock_t cam_list_lock_pp;
 
 #ifdef _CPIA_DEBUG_
 #define DEB_PORT(port) { \
@@ -582,7 +583,9 @@
 		kfree(cam);
 		return -ENXIO;
 	}
-	ADD_TO_LIST(cam_list, cpia);
+	spin_lock( &cam_list_lock_pp );
+	cpia_add_to_list(cam_list, cpia);
+	spin_unlock( &cam_list_lock_pp );
 
 	return 0;
 }
@@ -591,11 +594,12 @@
 {
 	struct cam_data *cpia;
 
+	spin_lock( &cam_list_lock_pp );
 	for(cpia = cam_list; cpia != NULL; cpia = cpia->next) {
 		struct pp_cam_entry *cam = cpia->lowlevel_data;
 		if (cam && cam->port->number == port->number) {
-			REMOVE_FROM_LIST(cpia);
-			
+			cpia_remove_from_list(cpia);
+			spin_unlock( &cam_list_lock_pp );			
 			cpia_unregister_camera(cpia);
 			
 			if(cam->open_count > 0) {
@@ -606,9 +610,10 @@
 		
 			kfree(cam);
 			cpia->lowlevel_data = NULL;
-			break;
+			return;
 		}
 	}
+	spin_unlock( &cam_list_lock_pp );
 }
 
 static void cpia_pp_attach (struct parport *port)
@@ -660,6 +665,9 @@
 		LOG ("unable to register with parport\n");
 		return -EIO;
 	}
+	
+	cam_list = NULL;
+	spinlock_init( cam_list_lock_pp );
 
 	return 0;
 }
--- ../clean/linux/drivers/media/video/cpia_usb.c	Mon Feb 19 10:18:18
2001
+++ linux/drivers/media/video/cpia_usb.c	Mon Sep 10 15:19:19 2001
@@ -104,6 +104,7 @@
 };
 
 static struct cam_data *cam_list;
+static spinlock_t cam_list_lock_usb;
 
 static void cpia_usb_complete(struct urb *urb)
 {
@@ -536,7 +537,9 @@
 		goto fail_all;
 	}
 
-	ADD_TO_LIST(cam_list, cam);
+	spin_lock( &cam_list_lock_usb );
+	cpia_add_to_list(cam_list, cam);
+	spin_unlock( &cam_list_lock_usb );
 
 	return cam;
 
@@ -579,8 +582,10 @@
 	struct cam_data *cam = (struct cam_data *) ptr;
 	struct usb_cpia *ucpia = (struct usb_cpia *) cam->lowlevel_data;
   
-	REMOVE_FROM_LIST(cam);
-
+	spin_lock( &cam_list_lock_usb );
+	cpia_remove_from_list(cam);
+	spin_unlock( &cam_list_lock_usb );
+	
 	/* Don't even try to reset the altsetting if we're disconnected */
 	cpia_usb_free_resources(ucpia, 0);
 
@@ -620,7 +625,7 @@
 static int __init usb_cpia_init(void)
 {
 	cam_list = NULL;
-
+	spin_lock_init(&cam_list_lock_usb);
 	return usb_register(&cpia_driver);
 }
 
--- ../clean/linux/drivers/media/video/cpia.h	Fri Mar  2 11:12:10 2001
+++ linux/drivers/media/video/cpia.h	Mon Sep 10 15:24:03 2001
@@ -393,27 +393,24 @@
       (p)&0x80?1:0, (p)&0x40?1:0, (p)&0x20?1:0, (p)&0x10?1:0,\
         (p)&0x08?1:0, (p)&0x04?1:0, (p)&0x02?1:0, (p)&0x01?1:0);
 
-#define ADD_TO_LIST(l, drv) \
-  {\
-    lock_kernel();\
-    (drv)->next = l;\
-    (drv)->previous = &(l);\
-    (l) = drv;\
-    unlock_kernel();\
-  } while(0)
+static inline void cpia_add_to_list(struct cam_data* l, struct
cam_data* drv)
+{
+	drv->next = l;
+	drv->previous = &l;
+	l = drv;
+}
 
-#define REMOVE_FROM_LIST(drv) \
-  {\
-    if ((drv)->previous != NULL) {\
-      lock_kernel();\
-      if ((drv)->next != NULL)\
-        (drv)->next->previous = (drv)->previous;\
-      *((drv)->previous) = (drv)->next;\
-      (drv)->previous = NULL;\
-      (drv)->next = NULL;\
-      unlock_kernel();\
-    }\
-  } while (0)
+
+static inline void cpia_remove_from_list(struct cam_data* drv)
+{
+	if (drv->previous != NULL) {
+		if (drv->next != NULL)
+			drv->next->previous = drv->previous;
+		*(drv->previous) = drv->next;
+		drv->previous = NULL;
+		drv->next = NULL;
+	}
+}
 
 
 #endif /* __KERNEL__ */
