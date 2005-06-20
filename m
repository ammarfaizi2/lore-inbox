Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVFTTDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVFTTDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVFTTC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:02:57 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:29450 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261487AbVFTS52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:57:28 -0400
Message-Id: <200506201851.j5KIpN43008509@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/8] UML - hot-unplug code cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Jun 2005 14:51:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the hot-unplugging code.  There is now an id procedure which is
called to figure out what device we're talking to.  The error messages
from that are now done from mconsole_remove instead of the driver.  remove
is now called with the device number, after it has been checked, so doesn't
need to do sanity checking on it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/drivers/line.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/line.c	2005-06-20 11:54:45.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/line.c	2005-06-20 12:15:16.000000000 -0400
@@ -602,11 +602,26 @@ int line_get_config(char *name, struct l
 	return n;
 }
 
-int line_remove(struct line *lines, unsigned int num, char *str)
+int line_id(char **str, int *start_out, int *end_out)
+{
+	char *end;
+        int n;
+
+	n = simple_strtoul(*str, &end, 0);
+	if((*end != '\0') || (end == *str))
+                return -1;
+
+        *str = end;
+        *start_out = n;
+        *end_out = n;
+        return n;
+}
+
+int line_remove(struct line *lines, unsigned int num, int n)
 {
 	char config[sizeof("conxxxx=none\0")];
 
-	sprintf(config, "%s=none", str);
+	sprintf(config, "%d=none", n);
 	return !line_setup(lines, num, config, 0);
 }
 
Index: linux-2.6.12/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/mconsole_kern.c	2005-06-20 11:54:47.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/mconsole_kern.c	2005-06-20 12:39:54.000000000 -0400
@@ -419,8 +419,9 @@ void mconsole_config(struct mc_request *
 void mconsole_remove(struct mc_request *req)
 {
 	struct mc_device *dev;	
-	char *ptr = req->request.data;
-	int err;
+	char *ptr = req->request.data, *err_msg = "";
+        char error[256];
+	int err, start, end, n;
 
 	ptr += strlen("remove");
 	while(isspace(*ptr)) ptr++;
@@ -429,8 +430,35 @@ void mconsole_remove(struct mc_request *
 		mconsole_reply(req, "Bad remove option", 1, 0);
 		return;
 	}
-	err = (*dev->remove)(&ptr[strlen(dev->name)]);
-	mconsole_reply(req, "", err, 0);
+
+        ptr = &ptr[strlen(dev->name)];
+
+        err = 1;
+        n = (*dev->id)(&ptr, &start, &end);
+        if(n < 0){
+                err_msg = "Couldn't parse device number";
+                goto out;
+        }
+        else if((n < start) || (n > end)){
+                sprintf(error, "Invalid device number - must be between "
+                        "%d and %d", start, end);
+                err_msg = error;
+                goto out;
+        }
+
+	err = (*dev->remove)(n);
+        switch(err){
+        case -ENODEV:
+                err_msg = "Device doesn't exist";
+                break;
+        case -EBUSY:
+                err_msg = "Device is currently open";
+                break;
+        default:
+                break;
+        }
+ out:
+	mconsole_reply(req, err_msg, err, 0);
 }
 
 #ifdef CONFIG_MAGIC_SYSRQ
Index: linux-2.6.12/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/net_kern.c	2005-06-20 11:54:46.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/net_kern.c	2005-06-20 12:15:16.000000000 -0400
@@ -612,25 +612,35 @@ static int net_config(char *str)
 	return(err);
 }
 
-static int net_remove(char *str)
+static int net_id(char **str, int *start_out, int *end_out)
+{
+        char *end;
+        int n;
+
+	n = simple_strtoul(*str, &end, 0);
+	if((*end != '\0') || (end == *str))
+		return -1;
+
+        *start_out = n;
+        *end_out = n;
+        *str = end;
+        return n;
+}
+
+static int net_remove(int n)
 {
 	struct uml_net *device;
 	struct net_device *dev;
 	struct uml_net_private *lp;
-	char *end;
-	int n;
-
-	n = simple_strtoul(str, &end, 0);
-	if((*end != '\0') || (end == str))
-		return(-1);
 
 	device = find_device(n);
 	if(device == NULL)
-		return(0);
+		return -ENODEV;
 
 	dev = device->dev;
 	lp = dev->priv;
-	if(lp->fd > 0) return(-1);
+	if(lp->fd > 0) 
+                return -EBUSY;
 	if(lp->remove != NULL) (*lp->remove)(&lp->user);
 	unregister_netdev(dev);
 	platform_device_unregister(&device->pdev);
@@ -638,13 +648,14 @@ static int net_remove(char *str)
 	list_del(&device->list);
 	kfree(device);
 	free_netdev(dev);
-	return(0);
+	return 0;
 }
 
 static struct mc_device net_mc = {
 	.name		= "eth",
 	.config		= net_config,
 	.get_config	= NULL,
+        .id		= net_id,
 	.remove		= net_remove,
 };
 
Index: linux-2.6.12/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/ssl.c	2005-06-20 11:54:46.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/ssl.c	2005-06-20 12:15:16.000000000 -0400
@@ -49,7 +49,7 @@ static struct chan_opts opts = {
 
 static int ssl_config(char *str);
 static int ssl_get_config(char *dev, char *str, int size, char **error_out);
-static int ssl_remove(char *str);
+static int ssl_remove(int n);
 
 static struct line_driver driver = {
 	.name 			= "UML serial line",
@@ -69,6 +69,7 @@ static struct line_driver driver = {
 		.name  		= "ssl",
 		.config 	= ssl_config,
 		.get_config 	= ssl_get_config,
+                .id		= line_id,
 		.remove 	= ssl_remove,
 	},
 };
@@ -94,10 +95,10 @@ static int ssl_get_config(char *dev, cha
 			       str, size, error_out));
 }
 
-static int ssl_remove(char *str)
+static int ssl_remove(int n)
 {
-	return(line_remove(serial_lines, 
-			   sizeof(serial_lines)/sizeof(serial_lines[0]), str));
+        return line_remove(serial_lines, 
+                           sizeof(serial_lines)/sizeof(serial_lines[0]), n);
 }
 
 int ssl_open(struct tty_struct *tty, struct file *filp)
Index: linux-2.6.12/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/stdio_console.c	2005-06-20 11:54:46.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/stdio_console.c	2005-06-20 12:15:16.000000000 -0400
@@ -55,7 +55,7 @@ static struct chan_opts opts = {
 
 static int con_config(char *str);
 static int con_get_config(char *dev, char *str, int size, char **error_out);
-static int con_remove(char *str);
+static int con_remove(int n);
 
 static struct line_driver driver = {
 	.name 			= "UML console",
@@ -75,6 +75,7 @@ static struct line_driver driver = {
 		.name  		= "con",
 		.config 	= con_config,
 		.get_config 	= con_get_config,
+                .id		= line_id,
 		.remove 	= con_remove,
 	},
 };
@@ -99,9 +100,9 @@ static int con_get_config(char *dev, cha
 			       size, error_out));
 }
 
-static int con_remove(char *str)
+static int con_remove(int n)
 {
-	return(line_remove(vts, sizeof(vts)/sizeof(vts[0]), str));
+        return line_remove(vts, sizeof(vts)/sizeof(vts[0]), n);
 }
 
 static int con_open(struct tty_struct *tty, struct file *filp)
Index: linux-2.6.12/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/ubd_kern.c	2005-06-20 11:54:56.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/ubd_kern.c	2005-06-20 12:40:34.000000000 -0400
@@ -754,24 +754,34 @@ static int ubd_get_config(char *name, ch
 	return(len);
 }
 
-static int ubd_remove(char *str)
+static int ubd_id(char **str, int *start_out, int *end_out)
+{
+        int n;
+
+	n = parse_unit(str);
+        *start_out = 0;
+        *end_out = MAX_DEV - 1;
+        return n;
+}
+
+static int ubd_remove(int n)
 {
 	struct ubd *dev;
-	int n, err = -ENODEV;
+	int err = -ENODEV;
 
-	n = parse_unit(&str);
+	spin_lock(&ubd_lock);
 
-	if((n < 0) || (n >= MAX_DEV))
-		return(err);
+	if(ubd_gendisk[n] == NULL)
+		goto out;
 
 	dev = &ubd_dev[n];
-	if(dev->count > 0)
-		return(-EBUSY);	/* you cannot remove a open disk */
 
-	err = 0;
- 	spin_lock(&ubd_lock);
+	if(dev->file == NULL)
+		goto out;
 
-	if(ubd_gendisk[n] == NULL)
+	/* you cannot remove a open disk */
+	err = -EBUSY;
+	if(dev->count > 0)
 		goto out;
 
 	del_gendisk(ubd_gendisk[n]);
@@ -787,15 +797,16 @@ static int ubd_remove(char *str)
 	platform_device_unregister(&dev->pdev);
 	*dev = ((struct ubd) DEFAULT_UBD);
 	err = 0;
- out:
- 	spin_unlock(&ubd_lock);
-	return(err);
+out:
+	spin_unlock(&ubd_lock);
+	return err;
 }
 
 static struct mc_device ubd_mc = {
 	.name		= "ubd",
 	.config		= ubd_config,
  	.get_config	= ubd_get_config,
+	.id		= ubd_id,
 	.remove		= ubd_remove,
 };
 
Index: linux-2.6.12/arch/um/include/line.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/line.h	2005-06-20 11:54:46.000000000 -0400
+++ linux-2.6.12/arch/um/include/line.h	2005-06-20 12:15:16.000000000 -0400
@@ -101,7 +101,8 @@ extern void lines_init(struct line *line
 extern void close_lines(struct line *lines, int nlines);
 
 extern int line_config(struct line *lines, unsigned int sizeof_lines, char *str);
-extern int line_remove(struct line *lines, unsigned int sizeof_lines, char *str);
+extern int line_id(char **str, int *start_out, int *end_out);
+extern int line_remove(struct line *lines, unsigned int sizeof_lines, int n);
 extern int line_get_config(char *dev, struct line *lines, unsigned int sizeof_lines, char *str,
 			   int size, char **error_out);
 
Index: linux-2.6.12/arch/um/include/mconsole_kern.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/mconsole_kern.h	2005-06-20 11:54:46.000000000 -0400
+++ linux-2.6.12/arch/um/include/mconsole_kern.h	2005-06-20 12:15:16.000000000 -0400
@@ -20,7 +20,8 @@ struct mc_device {
 	char *name;
 	int (*config)(char *);
 	int (*get_config)(char *, char *, int, char **);
-	int (*remove)(char *);
+        int (*id)(char **, int *, int *);
+	int (*remove)(int);
 };
 
 #define CONFIG_CHUNK(str, size, current, chunk, end) \
Index: linux-2.6.12/arch/um/kernel/tt/gdb.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/gdb.c	2005-06-20 11:54:47.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/gdb.c	2005-06-20 12:39:54.000000000 -0400
@@ -153,10 +153,10 @@ void remove_gdb_cb(void *unused)
 	exit_debugger_cb(NULL);
 }
 
-int gdb_remove(char *unused)
+int gdb_remove(int unused)
 {
 	initial_thread_cb(remove_gdb_cb, NULL);
-	return(0);
+        return 0;
 }
 
 void signal_usr1(int sig)
Index: linux-2.6.12/arch/um/kernel/tt/gdb_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/gdb_kern.c	2005-06-20 11:54:46.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/gdb_kern.c	2005-06-20 12:15:16.000000000 -0400
@@ -10,7 +10,7 @@
 #ifdef CONFIG_MCONSOLE
 
 extern int gdb_config(char *str);
-extern int gdb_remove(char *unused);
+extern int gdb_remove(int n);
 
 static struct mc_device gdb_mc = {
 	.name		= "gdb",
Index: linux-2.6.12/arch/um/kernel/tt/include/debug.h
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/include/debug.h	2005-06-20 11:54:48.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/include/debug.h	2005-06-20 12:39:55.000000000 -0400
@@ -4,8 +4,8 @@
  * Licensed under the GPL
  */
 
-#ifndef __DEBUG_H
-#define __DEBUG_H
+#ifndef __UML_TT_DEBUG_H
+#define __UML_TT_DEBUG_H
 
 extern int debugger_proxy(int status, pid_t pid);
 extern void child_proxy(pid_t pid, int status);
@@ -13,17 +13,6 @@ extern void init_proxy (pid_t pid, int w
 extern int start_debugger(char *prog, int startup, int stop, int *debugger_fd);
 extern void fake_child_exit(void);
 extern int gdb_config(char *str);
-extern int gdb_remove(char *unused);
+extern int gdb_remove(int unused);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

