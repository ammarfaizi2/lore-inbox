Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbQJaR6k>; Tue, 31 Oct 2000 12:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbQJaR6b>; Tue, 31 Oct 2000 12:58:31 -0500
Received: from dyna252.cygnus.co.uk ([194.130.39.252]:63992 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129185AbQJaR6S>;
	Tue, 31 Oct 2000 12:58:18 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: randy.dunlap@intel.com, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: USB init order dependencies.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 17:58:05 +0000
Message-ID: <1827.973015085@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Personally, I think this fix is less ugly than any of the alternatives I've 
seen so far.

It removes the dependency on init order completely, by statically putting 
the hub driver into the usb_driver_list at compile time.

Leave the link ordering stuff for 2.5.

Index: drivers/usb//hub.c
===================================================================
RCS file: /inst/cvs/linux/drivers/usb/hub.c,v
retrieving revision 1.2.2.38
diff -u -r1.2.2.38 hub.c
--- drivers/usb//hub.c	2000/10/12 16:50:36	1.2.2.38
+++ drivers/usb//hub.c	2000/10/31 17:50:58
@@ -759,11 +759,13 @@
 	return 0;
 }
 
-static struct usb_driver hub_driver = {
+struct usb_driver hub_driver = {
 	name:		"hub",
 	probe:		hub_probe,
 	ioctl:		hub_ioctl,
-	disconnect:	hub_disconnect
+	disconnect:	hub_disconnect,
+	serialize:      __MUTEX_INITIALIZER(hub_driver.serialize),
+	driver_list:	LIST_HEAD_INIT(usb_driver_list)
 };
 
 /*
@@ -772,11 +774,6 @@
 int usb_hub_init(void)
 {
 	int pid;
-
-	if (usb_register(&hub_driver) < 0) {
-		err("Unable to register USB hub driver");
-		return -1;
-	}
 
 	pid = kernel_thread(usb_hub_thread, NULL,
 		CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
Index: drivers/usb//usb.c
===================================================================
RCS file: /inst/cvs/linux/drivers/usb/usb.c,v
retrieving revision 1.2.2.52
diff -u -r1.2.2.52 usb.c
--- drivers/usb//usb.c	2000/10/04 12:29:27	1.2.2.52
+++ drivers/usb//usb.c	2000/10/31 17:50:58
@@ -56,8 +56,14 @@
 
 /*
  * We have a per-interface "registered driver" list.
+ * We link the USB hub driver into the list statically at compile
+ * time, to prevent ugly dependencies on the order in which the
+ * init routines are called.
  */
-LIST_HEAD(usb_driver_list);
+
+extern struct usb_driver hub_driver;
+
+struct list_head usb_driver_list = LIST_HEAD_INIT(hub_driver.driver_list);
 LIST_HEAD(usb_bus_list);
 
 static struct usb_busmap busmap;


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
