Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUFGM1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUFGM1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264673AbUFGM0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:26:35 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:5761 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264543AbUFGL4B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:01 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093531825@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093532571@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 18/39] input: Make serio open and close methods optional
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.25, 2004-04-23 02:50:09-05:00, dtor_core@ameritech.net
  Input: make serio open and close methods optional


 mouse/synaptics.c |   11 -----------
 serio/parkbd.c    |   11 -----------
 serio/q40kbd.c    |   11 -----------
 serio/serio.c     |    5 +++--
 serio/serport.c   |   10 ++--------
 5 files changed, 5 insertions(+), 43 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-06-07 13:12:14 +02:00
+++ b/drivers/input/mouse/synaptics.c	2004-06-07 13:12:14 +02:00
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
--- a/drivers/input/serio/parkbd.c	2004-06-07 13:12:14 +02:00
+++ b/drivers/input/serio/parkbd.c	2004-06-07 13:12:14 +02:00
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
--- a/drivers/input/serio/q40kbd.c	2004-06-07 13:12:14 +02:00
+++ b/drivers/input/serio/q40kbd.c	2004-06-07 13:12:14 +02:00
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
--- a/drivers/input/serio/serio.c	2004-06-07 13:12:14 +02:00
+++ b/drivers/input/serio/serio.c	2004-06-07 13:12:14 +02:00
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
--- a/drivers/input/serio/serport.c	2004-06-07 13:12:14 +02:00
+++ b/drivers/input/serio/serport.c	2004-06-07 13:12:14 +02:00
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
 

