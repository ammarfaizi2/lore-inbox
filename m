Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTKRSkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 13:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTKRSkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 13:40:19 -0500
Received: from jupiter.loonybin.net ([208.248.0.98]:51460 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S263742AbTKRSkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 13:40:10 -0500
Date: Tue, 18 Nov 2003 12:40:00 -0600
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] serio_for_each_port() -- for serio hijacking
Message-ID: <20031118184000.GA9338@bliss>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Well, this is the best method I could think of for rescanning
the serio devices.  I don't know if the overhead for function
calls is acceptable, or even if this functionality is desired.

Anyway, this is for questions and comments.

WARNING: Untested code, but I'm resonably sure it works ;)

-- 
Zinx Verituse

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.0-test9-serio_for_each_port.diff"

diff -ru linux-2.6.0-test9.orig/drivers/input/serio/serio.c linux-2.6.0-test9/drivers/input/serio/serio.c
--- linux-2.6.0-test9.orig/drivers/input/serio/serio.c	2003-10-25 13:42:48.000000000 -0500
+++ linux-2.6.0-test9/drivers/input/serio/serio.c	2003-11-18 12:23:46.000000000 -0600
@@ -28,6 +28,9 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  *
  * Changes:
+ * 18 Nov. 2003    Zinx Verituse <zinx@epicsol.org>
+ *                 serio_for_each_port()
+ *
  * 20 Jul. 2003    Daniele Bellucci <bellucda@tiscali.it>
  *                 Minor cleanups.
  */
@@ -57,6 +60,7 @@
 EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
 EXPORT_SYMBOL(serio_rescan);
+EXPORT_SYMBOL(serio_for_each_port);
 
 struct serio_event {
 	int type;
@@ -244,6 +248,27 @@
 	serio->dev = NULL;
 }
 
+/*
+ * called without serio_sem locked
+ * func() should return non-zero to exit the for_each
+ * the last return value of func() is returned by serio_for_each_func
+ */
+int serio_for_each_port(int (*func)(struct serio*))
+{
+	struct serio *serio;
+	int retval;
+
+	down(&serio_sem);
+	list_for_each_entry(serio, &serio_list, node) {
+		retval = func(serio);
+		if (retval)
+			break;
+	}
+	up(&serio_sem);
+	
+	return retval;
+}
+
 static int __init serio_init(void)
 {
 	int pid;
diff -ru linux-2.6.0-test9.orig/include/linux/serio.h linux-2.6.0-test9/include/linux/serio.h
--- linux-2.6.0-test9.orig/include/linux/serio.h	2003-10-25 13:43:52.000000000 -0500
+++ linux-2.6.0-test9/include/linux/serio.h	2003-11-18 12:15:04.000000000 -0600
@@ -67,6 +67,8 @@
 void serio_register_device(struct serio_dev *dev);
 void serio_unregister_device(struct serio_dev *dev);
 
+int serio_for_each_port(int (*func)(struct serio *));
+
 static __inline__ int serio_write(struct serio *serio, unsigned char data)
 {
 	if (serio->write)

--LZvS9be/3tNcYl/X--
