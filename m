Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWFRPrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWFRPrv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWFRPrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:47:51 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751183AbWFRPru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:47:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=oPzKfOZVJbsOrgo8rF67yXp4Xs3obKDJFJenww67FIqOpYUho7VuEp8hMrsqty4M70xcrrq9sXIBBbGCBcJcWiMrh37pUPxGCwTr7H78QebPg4biscrNcxhG2TN7YTKfSZCTwocoC31gc+B1cmKcdM2r1rjPi970emUEFh49Zdc=
Message-ID: <44956F97.1040101@gmail.com>
Date: Sun, 18 Jun 2006 23:21:59 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: [PATCH 2/9] VT binding: Add sysfs control to the VT layer
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs control to the VT layer.  A new sysfs class, 'vtconsole', and class
devices 'vtcon[n]' are added. Each class device file has the following
attributes:

/sys/class/vtconsole/vtcon[n]/name - read-only attribute showing the
                                     name of the current backend

/sys/class/vtconsole/vtcon[n]/bind - read/write attribute
             where: 0 - backend is unbound/unbind backend from the VT layer
                    1 - backend is bound/bind backend to the VT layer

In addition, if any of the consoles are in KD_GRAPHICS mode, binding and
unbinding will not succeed. KD_GRAPHICS mode usually indicates that the
underlying console hardware is used for other purposes other than displaying
text (ie X). This feature should prevent binding/unbinding from interfering
with a graphics application using the VT.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/vt.c |  371 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 224 insertions(+), 147 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index d788a0e..d0cc421 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -100,12 +100,14 @@ #include <asm/uaccess.h>
 
 #define MAX_NR_CON_DRIVER 16
 
-#define CON_DRIVER_FLAG_BIND 1
+#define CON_DRIVER_FLAG_MODULE 1
 #define CON_DRIVER_FLAG_INIT 2
 
 struct con_driver {
 	const struct consw *con;
 	const char *desc;
+	struct class_device *class_dev;
+	int node;
 	int first;
 	int last;
 	int flag;
@@ -2685,6 +2687,25 @@ #endif
 }
 
 #ifndef VT_SINGLE_DRIVER
+#include <linux/device.h>
+
+static struct class *vtconsole_class;
+
+static int con_is_graphics(const struct consw *csw, int first, int last)
+{
+	int i, retval = 0;
+
+	for (i = first; i <= last; i++) {
+		struct vc_data *vc = vc_cons[i].d;
+
+		if (vc && vc->vc_mode == KD_GRAPHICS) {
+			retval = 1;
+			break;
+		}
+	}
+
+	return retval;
+}
 
 static int bind_con_driver(const struct consw *csw, int first, int last,
 			   int deflt)
@@ -2805,7 +2826,7 @@ static int unbind_con_driver(const struc
 		con_driver = &registered_con_driver[i];
 
 		if (con_driver->con == csw &&
-		    con_driver->flag & CON_DRIVER_FLAG_BIND) {
+		    con_driver->flag & CON_DRIVER_FLAG_MODULE) {
 			retval = 0;
 			break;
 		}
@@ -2816,12 +2837,14 @@ static int unbind_con_driver(const struc
 		goto err;
 	}
 
+	retval = -ENODEV;
+
 	/* check if backup driver exists */
 	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
 		con_back = &registered_con_driver[i];
 
 		if (con_back->con &&
-		    !(con_back->flag & CON_DRIVER_FLAG_BIND)) {
+		    !(con_back->flag & CON_DRIVER_FLAG_MODULE)) {
 			defcsw = con_back->con;
 			retval = 0;
 			break;
@@ -2857,13 +2880,162 @@ static int unbind_con_driver(const struc
 		con_driver->flag &= ~CON_DRIVER_FLAG_INIT;
 
 	release_console_sem();
-	retval = bind_con_driver(defcsw, first, last, deflt);
+	/* ignore return value, binding should not fail */
+	bind_con_driver(defcsw, first, last, deflt);
 err:
 	module_put(owner);
 	return retval;
 
 }
 
+static int vt_bind(struct con_driver *con)
+{
+	const struct consw *defcsw = NULL, *csw = NULL;
+	int i, more = 1, first = -1, last = -1, deflt = 0;
+
+ 	if (!con->con || !(con->flag & CON_DRIVER_FLAG_MODULE) ||
+	    con_is_graphics(con->con, con->first, con->last))
+		goto err;
+
+	csw = con->con;
+
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		struct con_driver *con = &registered_con_driver[i];
+
+		if (con->con && !(con->flag & CON_DRIVER_FLAG_MODULE)) {
+			defcsw = con->con;
+			break;
+		}
+	}
+
+	if (!defcsw)
+		goto err;
+
+	while (more) {
+		more = 0;
+
+		for (i = con->first; i <= con->last; i++) {
+			if (con_driver_map[i] == defcsw) {
+				if (first == -1)
+					first = i;
+				last = i;
+				more = 1;
+			} else if (first != -1)
+				break;
+		}
+
+		if (first == 0 && last == MAX_NR_CONSOLES -1)
+			deflt = 1;
+
+		if (first != -1)
+			bind_con_driver(csw, first, last, deflt);
+
+		first = -1;
+		last = -1;
+		deflt = 0;
+	}
+
+err:
+	return 0;
+}
+
+static int vt_unbind(struct con_driver *con)
+{
+	const struct consw *csw = NULL;
+	int i, more = 1, first = -1, last = -1, deflt = 0;
+
+ 	if (!con->con || !(con->flag & CON_DRIVER_FLAG_MODULE) ||
+	    con_is_graphics(con->con, con->first, con->last))
+		goto err;
+
+	csw = con->con;
+
+	while (more) {
+		more = 0;
+
+		for (i = con->first; i <= con->last; i++) {
+			if (con_driver_map[i] == csw) {
+				if (first == -1)
+					first = i;
+				last = i;
+				more = 1;
+			} else if (first != -1)
+				break;
+		}
+
+		if (first == 0 && last == MAX_NR_CONSOLES -1)
+			deflt = 1;
+
+		if (first != -1)
+			unbind_con_driver(csw, first, last, deflt);
+
+		first = -1;
+		last = -1;
+		deflt = 0;
+	}
+
+err:
+	return 0;
+}
+
+static ssize_t store_bind(struct class_device *class_device,
+			  const char *buf, size_t count)
+{
+	struct con_driver *con = class_get_devdata(class_device);
+	int bind = simple_strtoul(buf, NULL, 0);
+
+	if (bind)
+		vt_bind(con);
+	else
+		vt_unbind(con);
+
+	return count;
+}
+
+static ssize_t show_bind(struct class_device *class_device, char *buf)
+{
+	struct con_driver *con = class_get_devdata(class_device);
+	int bind = con_is_bound(con->con);
+
+	return snprintf(buf, PAGE_SIZE, "%i\n", bind);
+}
+
+static ssize_t show_name(struct class_device *class_device, char *buf)
+{
+	struct con_driver *con = class_get_devdata(class_device);
+
+	return snprintf(buf, PAGE_SIZE, "%s %s\n",
+			(con->flag & CON_DRIVER_FLAG_MODULE) ? "(M)" : "(S)",
+			 con->desc);
+
+}
+
+static struct class_device_attribute class_device_attrs[] = {
+	__ATTR(bind, S_IRUGO|S_IWUSR, show_bind, store_bind),
+	__ATTR(name, S_IRUGO, show_name, NULL),
+};
+
+static int vtconsole_init_class_device(struct con_driver *con)
+{
+	class_set_devdata(con->class_dev, con);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
+		class_device_create_file(con->class_dev,
+					 &class_device_attrs[i]);
+
+	return 0;
+}
+
+static void vtconsole_deinit_class_device(struct con_driver *con)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
+		class_device_remove_file(con->class_dev,
+					 &class_device_attrs[i]);
+};
+
 /**
  * con_is_bound - checks if driver is bound to the console
  * @csw: console driver
@@ -2934,7 +3106,8 @@ int register_con_driver(const struct con
 		if (con_driver->con == NULL) {
 			con_driver->con = csw;
 			con_driver->desc = desc;
-			con_driver->flag = CON_DRIVER_FLAG_BIND |
+			con_driver->node = i;
+			con_driver->flag = CON_DRIVER_FLAG_MODULE |
 			                   CON_DRIVER_FLAG_INIT;
 			con_driver->first = first;
 			con_driver->last = last;
@@ -2943,6 +3116,22 @@ int register_con_driver(const struct con
 		}
 	}
 
+	if (retval)
+		goto err;
+
+	con_driver->class_dev = class_device_create(vtconsole_class, NULL,
+						    MKDEV(0, 0), NULL,
+						    "vtcon%i",
+						    con_driver->node);
+
+	if (IS_ERR(con_driver->class_dev)) {
+		printk(KERN_WARNING "Unable to create class_device for %s; "
+		       "errno = %ld\n", con_driver->desc,
+		       PTR_ERR(con_driver->class_dev));
+		con_driver->class_dev = NULL;
+	} else {
+		vtconsole_init_class_device(con_driver);
+	}
 err:
 	release_console_sem();
 	module_put(owner);
@@ -2975,9 +3164,13 @@ int unregister_con_driver(const struct c
 		struct con_driver *con_driver = &registered_con_driver[i];
 
 		if (con_driver->con == csw &&
-		    con_driver->flag & CON_DRIVER_FLAG_BIND) {
+		    con_driver->flag & CON_DRIVER_FLAG_MODULE) {
+			vtconsole_deinit_class_device(con_driver);
+			class_device_destroy(vtconsole_class, MKDEV(0, 0));
 			con_driver->con = NULL;
 			con_driver->desc = NULL;
+			con_driver->class_dev = NULL;
+			con_driver->node = 0;
 			con_driver->flag = 0;
 			con_driver->first = 0;
 			con_driver->last = 0;
@@ -2985,7 +3178,6 @@ int unregister_con_driver(const struct c
 			break;
 		}
 	}
-
 err:
 	release_console_sem();
 	return retval;
@@ -3006,7 +3198,7 @@ int take_over_console(const struct consw
 	err = register_con_driver(csw, first, last);
 
 	if (!err)
-		err = bind_con_driver(csw, first, last, deflt);
+		bind_con_driver(csw, first, last, deflt);
 
 	return err;
 }
@@ -3020,160 +3212,45 @@ void give_up_console(const struct consw 
 	unregister_con_driver(csw);
 }
 
-/*
- * this function is intended to be called by the tty layer only
- */
-int vt_bind(int index)
+static int __init vtconsole_class_init(void)
 {
-	const struct consw *defcsw = NULL, *csw = NULL;
-	struct con_driver *con;
-	int i, more = 1, first = -1, last = -1, deflt = 0;
-
-	if (index >= MAX_NR_CON_DRIVER)
-		goto err;
-
-	con = &registered_con_driver[index];
-
- 	if (!con->con || !(con->flag & CON_DRIVER_FLAG_BIND))
-		goto err;
+	vtconsole_class = class_create(THIS_MODULE, "vtconsole");
+	int i;
 
-	csw = con->con;
+	if (IS_ERR(vtconsole_class)) {
+		printk(KERN_WARNING "Unable to create vt console class; "
+		       "errno = %ld\n", PTR_ERR(vtconsole_class));
+		vtconsole_class = NULL;
+	}
 
+	/* Add system drivers to sysfs */
 	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
 		struct con_driver *con = &registered_con_driver[i];
 
-		if (con->con && !(con->flag & CON_DRIVER_FLAG_BIND)) {
-			defcsw = con->con;
-			break;
-		}
-	}
-
-	if (!defcsw)
-		goto err;
-
-	while (more) {
-		more = 0;
-
-		for (i = con->first; i <= con->last; i++) {
-			if (con_driver_map[i] == defcsw) {
-				if (first == -1)
-					first = i;
-				last = i;
-				more = 1;
-			} else if (first != -1)
-				break;
-		}
-
-		if (first == 0 && last == MAX_NR_CONSOLES -1)
-			deflt = 1;
-
-		if (first != -1)
-			bind_con_driver(csw, first, last, deflt);
-
-		first = -1;
-		last = -1;
-		deflt = 0;
-	}
-
-err:
-	return 0;
-}
-
-/*
- * this function is intended to be called by the tty layer only
- */
-int vt_unbind(int index)
-{
-	const struct consw *csw = NULL;
-	struct con_driver *con;
-	int i, more = 1, first = -1, last = -1, deflt = 0;
-
-	if (index >= MAX_NR_CON_DRIVER)
-		goto err;
-
-	con = &registered_con_driver[index];
-
- 	if (!con->con || !(con->flag & CON_DRIVER_FLAG_BIND))
-		goto err;
-
-	csw = con->con;
-
-	while (more) {
-		more = 0;
-
-		for (i = con->first; i <= con->last; i++) {
-			if (con_driver_map[i] == csw) {
-				if (first == -1)
-					first = i;
-				last = i;
-				more = 1;
-			} else if (first != -1)
-				break;
+		if (con->con && !con->class_dev) {
+			con->class_dev =
+				class_device_create(vtconsole_class, NULL,
+						    MKDEV(0, 0), NULL,
+						    "vtcon%i", con->node);
+
+			if (IS_ERR(con->class_dev)) {
+				printk(KERN_WARNING "Unable to create "
+				       "class_device for %s; errno = %ld\n",
+				       con->desc, PTR_ERR(con->class_dev));
+				con->class_dev = NULL;
+			} else {
+				vtconsole_init_class_device(con);
+			}
 		}
-
-		if (first == 0 && last == MAX_NR_CONSOLES -1)
-			deflt = 1;
-
-		if (first != -1)
-			unbind_con_driver(csw, first, last, deflt);
-
-		first = -1;
-		last = -1;
-		deflt = 0;
 	}
 
-err:
-	return 0;
-}
-#else
-int vt_bind(int index)
-{
 	return 0;
 }
+postcore_initcall(vtconsole_class_init);
 
-int vt_unbind(int index)
-{
-	return 0;
-}
 #endif
 
 /*
- * this function is intended to be called by the tty layer only
- */
-int vt_show_drivers(char *buf)
-{
-	int i, j, read, offset = 0, cnt = PAGE_SIZE;
-
-	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
-		struct con_driver *con_driver = &registered_con_driver[i];
-
-		if (con_driver->con != NULL) {
-			int sys = 0;
-
-			if (con_driver->flag & CON_DRIVER_FLAG_BIND) {
-				sys = 2;
-
-				for (j = 0; j < MAX_NR_CONSOLES; j++) {
-					if (con_driver_map[j] ==
-					    con_driver->con) {
-						sys = 1;
-						break;
-					}
-				}
-			}
-
-			read = snprintf(buf + offset, cnt, "%i %s: %s\n",
-					i, (sys) ? ((sys == 1) ? "B" : "U") :
-					"S", con_driver->desc);
-			offset += read;
-			cnt -= read;
-		}
-	}
-
-	return offset;
-}
-
-/*
  *	Screen blanking
  */
 

