Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWFIIn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWFIIn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWFIIn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:43:28 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:59923 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751447AbWFIIn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:43:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ktra8uZgTknCKxnuyMUTdxc1RlgVYKa36seoHxpV1/3321E4oWWa2aq+Q3Rri+ktFJwi43hohqDj45QzBycF2aWtnJBUj/SAnu2O4OUdXCwD9kf44qOxrSpXQEdKfEebm+VdNptgvCAx6fkS9fwq000g6SklKhxy8wRXAmfbmuU=
Message-ID: <448933CA.2020408@gmail.com>
Date: Fri, 09 Jun 2006 16:39:38 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] VT binding: Add binding/unbinding support for the VT
 console
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The framebuffer console is now able to dynamically bind and unbind from the VT
console layer. Due to the way the VT console layer works, the drivers
themselves decide when to bind or unbind. However, it was decided that
binding must be controlled, not by the drivers themselves, but by the VT
console layer. With this, dynamic binding is possible for all VT console
drivers, not just fbcon.

Thus, the VT console layer will impose the following to all VT console drivers:

- all registered VT console drivers will be entered in a private list
- drivers can register themselves to the VT console layer, but they cannot
  decide when to bind or unbind. (Exception: To maintain backwards
  compatibility, take_over_console() will automatically bind the driver after
  registration.)
- drivers can remove themselves from the list by unregistering from the VT
  console layer. A prerequisite for unregistration is that the driver must not
  be bound.

The following functions are new in the vt.c:

register_con_driver() - public function, this function adds the VT console
driver to an internal list maintained by the VT console

bind_con_driver() - private function, it binds the driver to the console

take_over_console() is changed to call register_con_driver() followed by
a bind_con_driver(). This is the only time drivers can decide when to bind to
the VT layer. This is to maintain backwards compatibility.

unbind_con_driver() - private function, it unbinds the driver from its console.
The vacated consoles will be taken over by the default boot console driver.

unregister_con_driver() - public function, removes the driver from the internal
list maintained by the VT console. It will only succeed if the driver is
currently unbound.

con_is_bound() checks if the driver is currently bound or not

give_up_console() is just a wrapper to unregister_con_driver().

There are also 3 additional functions meant to be called only by the tty
layer for sysfs control:

	vt_bind() - calls bind_con_driver()
	vt_unbind() - calls unbind_con_driver()
	vt_show_drivers() - shows the list of registered drivers

Most VT console drivers will continue to work as is, but might have problems
when unbinding or binding which should be fixable with minimal changes.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/vt.c       |  467 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/console.h |    4 
 2 files changed, 437 insertions(+), 34 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index d7ff7fd..d788a0e 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -98,9 +98,21 @@ #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
+#define MAX_NR_CON_DRIVER 16
 
+#define CON_DRIVER_FLAG_BIND 1
+#define CON_DRIVER_FLAG_INIT 2
+
+struct con_driver {
+	const struct consw *con;
+	const char *desc;
+	int first;
+	int last;
+	int flag;
+};
+
+static struct con_driver registered_con_driver[MAX_NR_CON_DRIVER];
 const struct consw *conswitchp;
-static struct consw *defcsw; /* default console */
 
 /* A bitmap for codes <32. A bit of 1 indicates that the code
  * corresponding to that bit number invokes some special action
@@ -2558,7 +2570,7 @@ static int __init con_init(void)
 {
 	const char *display_desc = NULL;
 	struct vc_data *vc;
-	unsigned int currcons = 0;
+	unsigned int currcons = 0, i;
 
 	acquire_console_sem();
 
@@ -2570,6 +2582,22 @@ static int __init con_init(void)
 		return 0;
 	}
 
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		struct con_driver *con_driver = &registered_con_driver[i];
+
+		if (con_driver->con == NULL) {
+			con_driver->con = conswitchp;
+			con_driver->desc = display_desc;
+			con_driver->flag = CON_DRIVER_FLAG_INIT;
+			con_driver->first = 0;
+			con_driver->last = MAX_NR_CONSOLES - 1;
+			break;
+		}
+	}
+
+	for (i = 0; i < MAX_NR_CONSOLES; i++)
+		con_driver_map[i] = conswitchp;
+
 	init_timer(&console_timer);
 	console_timer.function = blank_screen_t;
 	if (blankinterval) {
@@ -2658,33 +2686,36 @@ #endif
 
 #ifndef VT_SINGLE_DRIVER
 
-/*
- *	If we support more console drivers, this function is used
- *	when a driver wants to take over some existing consoles
- *	and become default driver for newly opened ones.
- */
-
-int take_over_console(const struct consw *csw, int first, int last, int deflt)
+static int bind_con_driver(const struct consw *csw, int first, int last,
+			   int deflt)
 {
-	int i, j = -1, k = -1;
-	const char *desc;
-	struct module *owner;
+	struct module *owner = csw->owner;
+	const char *desc = NULL;
+	struct con_driver *con_driver;
+	int i, j = -1, k = -1, retval = -ENODEV;
 
-	owner = csw->owner;
 	if (!try_module_get(owner))
 		return -ENODEV;
 
-	/* save default console, for possible recovery later on */
-	if (!defcsw)
-		defcsw = (struct consw *) conswitchp;
-
 	acquire_console_sem();
-	desc = csw->con_startup();
 
-	if (!desc) {
-		release_console_sem();
-		module_put(owner);
-		return -ENODEV;
+	/* check if driver is registered */
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		con_driver = &registered_con_driver[i];
+
+		if (con_driver->con == csw) {
+			desc = con_driver->desc;
+			retval = 0;
+			break;
+		}
+	}
+
+	if (retval)
+		goto err;
+
+	if (!(con_driver->flag & CON_DRIVER_FLAG_INIT)) {
+		csw->con_startup();
+		con_driver->flag |= CON_DRIVER_FLAG_INIT;
 	}
 
 	if (deflt) {
@@ -2695,6 +2726,9 @@ int take_over_console(const struct consw
 		conswitchp = csw;
 	}
 
+	first = max(first, con_driver->first);
+	last = min(last, con_driver->last);
+
 	for (i = first; i <= last; i++) {
 		int old_was_color;
 		struct vc_data *vc = vc_cons[i].d;
@@ -2746,33 +2780,400 @@ int take_over_console(const struct consw
 	} else
 		printk("to %s\n", desc);
 
+	retval = 0;
+err:
 	release_console_sem();
 	module_put(owner);
-	return 0;
-}
+	return retval;
+};
 
-void give_up_console(const struct consw *csw)
+static int unbind_con_driver(const struct consw *csw, int first, int last,
+			     int deflt)
 {
-	int i, first = -1, last = -1, deflt = 0;
+	struct module *owner = csw->owner;
+	const struct consw *defcsw = NULL;
+	struct con_driver *con_driver = NULL, *con_back = NULL;
+	int i, retval = -ENODEV;
 
-	for (i = 0; i < MAX_NR_CONSOLES; i++)
+	if (!try_module_get(owner))
+		return -ENODEV;
+
+	acquire_console_sem();
+
+	/* check if driver is registered and if it is unbindable */
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		con_driver = &registered_con_driver[i];
+
+		if (con_driver->con == csw &&
+		    con_driver->flag & CON_DRIVER_FLAG_BIND) {
+			retval = 0;
+			break;
+		}
+	}
+
+	if (retval) {
+		release_console_sem();
+		goto err;
+	}
+
+	/* check if backup driver exists */
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		con_back = &registered_con_driver[i];
+
+		if (con_back->con &&
+		    !(con_back->flag & CON_DRIVER_FLAG_BIND)) {
+			defcsw = con_back->con;
+			retval = 0;
+			break;
+		}
+	}
+
+	if (retval) {
+		release_console_sem();
+		goto err;
+	}
+
+	if (!con_is_bound(csw)) {
+		release_console_sem();
+		goto err;
+	}
+
+	first = max(first, con_driver->first);
+	last = min(last, con_driver->last);
+
+	for (i = first; i <= last; i++) {
 		if (con_driver_map[i] == csw) {
-			if (first == -1)
-				first = i;
-			last = i;
 			module_put(csw->owner);
 			con_driver_map[i] = NULL;
 		}
+	}
+
+	if (!con_is_bound(defcsw)) {
+		defcsw->con_startup();
+		con_back->flag |= CON_DRIVER_FLAG_INIT;
+	}
+
+	if (!con_is_bound(csw))
+		con_driver->flag &= ~CON_DRIVER_FLAG_INIT;
+
+	release_console_sem();
+	retval = bind_con_driver(defcsw, first, last, deflt);
+err:
+	module_put(owner);
+	return retval;
+
+}
+
+/**
+ * con_is_bound - checks if driver is bound to the console
+ * @csw: console driver
+ *
+ * RETURNS: zero if unbound, nonzero if bound
+ *
+ * Drivers can call this and if zero, they should release
+ * all resources allocated on con_startup()
+ */
+int con_is_bound(const struct consw *csw)
+{
+	int i, bound = 0;
+
+	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		if (con_driver_map[i] == csw) {
+			bound = 1;
+			break;
+		}
+	}
+
+	return bound;
+}
+EXPORT_SYMBOL(con_is_bound);
+
+/**
+ * register_con_driver - register console driver to console layer
+ * @csw: console driver
+ * @first: the first console to take over, minimum value is 0
+ * @last: the last console to take over, maximum value is MAX_NR_CONSOLES -1
+ *
+ * DESCRIPTION: This function registers a console driver which can later
+ * bind to a range of consoles specified by @first and @last. It will
+ * also initialize the console driver by calling con_startup().
+ */
+int register_con_driver(const struct consw *csw, int first, int last)
+{
+	struct module *owner = csw->owner;
+	struct con_driver *con_driver;
+	const char *desc;
+	int i, retval = 0;
+
+	if (!try_module_get(owner))
+		return -ENODEV;
+
+	acquire_console_sem();
+
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		con_driver = &registered_con_driver[i];
+
+		/* already registered */
+		if (con_driver->con == csw)
+			retval = -EINVAL;
+	}
+
+	if (retval)
+		goto err;
+
+	desc = csw->con_startup();
+
+	if (!desc)
+		goto err;
+
+	retval = -EINVAL;
+
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		con_driver = &registered_con_driver[i];
+
+		if (con_driver->con == NULL) {
+			con_driver->con = csw;
+			con_driver->desc = desc;
+			con_driver->flag = CON_DRIVER_FLAG_BIND |
+			                   CON_DRIVER_FLAG_INIT;
+			con_driver->first = first;
+			con_driver->last = last;
+			retval = 0;
+			break;
+		}
+	}
+
+err:
+	release_console_sem();
+	module_put(owner);
+	return retval;
+}
+EXPORT_SYMBOL(register_con_driver);
+
+/**
+ * unregister_con_driver - unregister console driver from console layer
+ * @csw: console driver
+ *
+ * DESCRIPTION: All drivers that registers to the console layer must
+ * call this function upon exit, or if the console driver is in a state
+ * where it won't be able to handle console services, such as the
+ * framebuffer console without loaded framebuffer drivers.
+ *
+ * The driver must unbind first prior to unregistration.
+ */
+int unregister_con_driver(const struct consw *csw)
+{
+	int i, retval = -ENODEV;
+
+	acquire_console_sem();
+
+	/* cannot unregister a bound driver */
+	if (con_is_bound(csw))
+		goto err;
+
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		struct con_driver *con_driver = &registered_con_driver[i];
+
+		if (con_driver->con == csw &&
+		    con_driver->flag & CON_DRIVER_FLAG_BIND) {
+			con_driver->con = NULL;
+			con_driver->desc = NULL;
+			con_driver->flag = 0;
+			con_driver->first = 0;
+			con_driver->last = 0;
+			retval = 0;
+			break;
+		}
+	}
+
+err:
+	release_console_sem();
+	return retval;
+}
+EXPORT_SYMBOL(unregister_con_driver);
+
+/*
+ *	If we support more console drivers, this function is used
+ *	when a driver wants to take over some existing consoles
+ *	and become default driver for newly opened ones.
+ *
+ *      take_over_console is basically a register followed by unbind
+ */
+int take_over_console(const struct consw *csw, int first, int last, int deflt)
+{
+	int err;
+
+	err = register_con_driver(csw, first, last);
+
+	if (!err)
+		err = bind_con_driver(csw, first, last, deflt);
+
+	return err;
+}
+
+/*
+ * give_up_console is a wrapper to unregister_con_driver. It will only
+ * work if driver is fully unbound.
+ */
+void give_up_console(const struct consw *csw)
+{
+	unregister_con_driver(csw);
+}
+
+/*
+ * this function is intended to be called by the tty layer only
+ */
+int vt_bind(int index)
+{
+	const struct consw *defcsw = NULL, *csw = NULL;
+	struct con_driver *con;
+	int i, more = 1, first = -1, last = -1, deflt = 0;
+
+	if (index >= MAX_NR_CON_DRIVER)
+		goto err;
+
+	con = &registered_con_driver[index];
+
+ 	if (!con->con || !(con->flag & CON_DRIVER_FLAG_BIND))
+		goto err;
+
+	csw = con->con;
+
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		struct con_driver *con = &registered_con_driver[i];
+
+		if (con->con && !(con->flag & CON_DRIVER_FLAG_BIND)) {
+			defcsw = con->con;
+			break;
+		}
+	}
 
-	if (first != -1 && defcsw) {
-		if (first == 0 && last == MAX_NR_CONSOLES - 1)
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
 			deflt = 1;
-		take_over_console(defcsw, first, last, deflt);
+
+		if (first != -1)
+			bind_con_driver(csw, first, last, deflt);
+
+		first = -1;
+		last = -1;
+		deflt = 0;
 	}
+
+err:
+	return 0;
+}
+
+/*
+ * this function is intended to be called by the tty layer only
+ */
+int vt_unbind(int index)
+{
+	const struct consw *csw = NULL;
+	struct con_driver *con;
+	int i, more = 1, first = -1, last = -1, deflt = 0;
+
+	if (index >= MAX_NR_CON_DRIVER)
+		goto err;
+
+	con = &registered_con_driver[index];
+
+ 	if (!con->con || !(con->flag & CON_DRIVER_FLAG_BIND))
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
+#else
+int vt_bind(int index)
+{
+	return 0;
+}
+
+int vt_unbind(int index)
+{
+	return 0;
 }
 #endif
 
 /*
+ * this function is intended to be called by the tty layer only
+ */
+int vt_show_drivers(char *buf)
+{
+	int i, j, read, offset = 0, cnt = PAGE_SIZE;
+
+	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
+		struct con_driver *con_driver = &registered_con_driver[i];
+
+		if (con_driver->con != NULL) {
+			int sys = 0;
+
+			if (con_driver->flag & CON_DRIVER_FLAG_BIND) {
+				sys = 2;
+
+				for (j = 0; j < MAX_NR_CONSOLES; j++) {
+					if (con_driver_map[j] ==
+					    con_driver->con) {
+						sys = 1;
+						break;
+					}
+				}
+			}
+
+			read = snprintf(buf + offset, cnt, "%i %s: %s\n",
+					i, (sys) ? ((sys == 1) ? "B" : "U") :
+					"S", con_driver->desc);
+			offset += read;
+			cnt -= read;
+		}
+	}
+
+	return offset;
+}
+
+/*
  *	Screen blanking
  */
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 31b646d..f1392fd 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -63,9 +63,11 @@ extern const struct consw vga_con;	/* VG
 extern const struct consw newport_con;	/* SGI Newport console  */
 extern const struct consw prom_con;	/* SPARC PROM console */
 
+int con_is_bound(const struct consw *csw);
+int register_con_driver(const struct consw *csw, int first, int last);
+int unregister_con_driver(const struct consw *csw);
 int take_over_console(const struct consw *sw, int first, int last, int deflt);
 void give_up_console(const struct consw *sw);
-
 /* scroll */
 #define SM_UP       (1)
 #define SM_DOWN     (2)


