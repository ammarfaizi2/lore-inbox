Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUDVHk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUDVHk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbUDVHgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:36:21 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:58195 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262579AbUDVH3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:29:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/15] New set of input patches: serio open/close optional
Date: Thu, 22 Apr 2004 02:29:38 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net> <200404220156.42083.dtor_core@ameritech.net>
In-Reply-To: <200404220156.42083.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404220229.41680.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extra stuff slipped into the previous patch, this one better...


===================================================================


ChangeSet@1.1928, 2004-04-22 02:26:37-05:00, dtor_core@ameritech.net
  Input: make serio open and close methods optional


 mouse/synaptics.c |   11 -----------
 serio/parkbd.c    |   11 -----------
 serio/q40kbd.c    |   11 -----------
 serio/serio.c     |    5 +++--
 serio/serport.c   |   10 ++--------
 5 files changed, 5 insertions(+), 43 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Apr 22 02:27:22 2004
+++ b/drivers/input/mouse/synaptics.c	Thu Apr 22 02:27:22 2004
@@ -212,15 +212,6 @@
 /*****************************************************************************
  *	Synaptics pass-through PS/2 port support
  ****************************************************************************/
-static int synaptics_pt_open(struct serio *port)
-{
-	return 0;
-}
-
-static void synaptics_pt_close(struct serio *port)
-{
-}
-
 static int synaptics_pt_write(struct serio *port, unsigned char c)
 {
 	struct psmouse *parent = port->driver;
@@ -282,8 +273,6 @@
 	port->serio.name = "Synaptics pass-through";
 	port->serio.phys = "synaptics-pt/serio0";
 	port->serio.write = synaptics_pt_write;
-	port->serio.open = synaptics_pt_open;
-	port->serio.close = synaptics_pt_close;
 	port->serio.driver = psmouse;
 
 	port->activate = synaptics_pt_activate;
diff -Nru a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c	Thu Apr 22 02:27:22 2004
+++ b/drivers/input/serio/parkbd.c	Thu Apr 22 02:27:22 2004
@@ -86,20 +86,9 @@
 	return 0;
 }
 
-static int parkbd_open(struct serio *port)
-{
-	return 0;
-}
-
-static void parkbd_close(struct serio *port)
-{
-}
-
 static struct serio parkbd_port =
 {
 	.write	= parkbd_write,
-	.open	= parkbd_open,
-	.close	= parkbd_close,
 	.name	= parkbd_name,
 	.phys	= parkbd_phys,
 };
diff -Nru a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
--- a/drivers/input/serio/q40kbd.c	Thu Apr 22 02:27:22 2004
+++ b/drivers/input/serio/q40kbd.c	Thu Apr 22 02:27:22 2004
@@ -47,23 +47,12 @@
 MODULE_DESCRIPTION("Q40 PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
 
-
-static int q40kbd_open(struct serio *port)
-{
-	return 0;
-}
-static void q40kbd_close(struct serio *port)
-{
-}
-
 static struct serio q40kbd_port =
 {
 	.type	= SERIO_8042,
 	.name	= "Q40 kbd port",
 	.phys	= "Q40",
 	.write	= NULL,
-	.open	= q40kbd_open,
-	.close	= q40kbd_close,
 };
 
 static irqreturn_t q40kbd_interrupt(int irq, void *dev_id,
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Apr 22 02:27:22 2004
+++ b/drivers/input/serio/serio.c	Thu Apr 22 02:27:22 2004
@@ -293,7 +293,7 @@
 int serio_open(struct serio *serio, struct serio_dev *dev)
 {
 	serio->dev = dev;
-	if (serio->open(serio)) {
+	if (serio->open && serio->open(serio)) {
 		serio->dev = NULL;
 		return -1;
 	}
@@ -303,7 +303,8 @@
 /* called from serio_dev->connect/disconnect methods under serio_sem */
 void serio_close(struct serio *serio)
 {
-	serio->close(serio);
+	if (serio->close)
+		serio->close(serio);
 	serio->dev = NULL;
 }
 
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	Thu Apr 22 02:27:22 2004
+++ b/drivers/input/serio/serport.c	Thu Apr 22 02:27:22 2004
@@ -48,11 +48,6 @@
 	return -(serport->tty->driver->write(serport->tty, 0, &data, 1) != 1);
 }
 
-static int serport_serio_open(struct serio *serio)
-{
-        return 0;
-}
-
 static void serport_serio_close(struct serio *serio)
 {
 	struct serport *serport = serio->driver;
@@ -87,7 +82,6 @@
 
 	serport->serio.type = SERIO_RS232;
 	serport->serio.write = serport_serio_write;
-	serport->serio.open = serport_serio_open;
 	serport->serio.close = serport_serio_close;
 	serport->serio.driver = serport;
 
@@ -135,7 +129,7 @@
 }
 
 /*
- * serport_ldisc_read() just waits indefinitely if everything goes well. 
+ * serport_ldisc_read() just waits indefinitely if everything goes well.
  * However, when the serio driver closes the serio port, it finishes,
  * returning 0 characters.
  */
@@ -165,7 +159,7 @@
 static int serport_ldisc_ioctl(struct tty_struct * tty, struct file * file, unsigned int cmd, unsigned long arg)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
-	
+
 	if (cmd == SPIOCSTYPE)
 		return get_user(serport->serio.type, (unsigned long *) arg);
 
