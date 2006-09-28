Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWI1Tf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWI1Tf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWI1Tf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:35:59 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:64222 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1161025AbWI1Tf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:35:58 -0400
Message-id: <123879783241321@wsc.cz>
Subject: [PATCH 1/1] Char: specialix, kill unneeded page alloc
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <R.E.Wolff@BitWizard.nl>
Date: Thu, 28 Sep 2006 21:36:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

specialix, kill unneeded page alloc

There is no need to have allocated zeroed page in the driver at all. Save a
little bit memory and some ticks by deleting that allocation and freeing.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit dba1b47119514420edc927a6abe337934c5c1a46
tree 477db4a0abfd10ea8a411e2b61821b83afbfe75c
parent 7a6d209f0b3ad71818138d9c2b4694fdf3181859
author Jiri Slaby <jirislaby@gmail.com> Thu, 28 Sep 2006 11:42:07 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Thu, 28 Sep 2006 11:42:07 +0200

 drivers/char/specialix.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
index df07b4a..902c48d 100644
--- a/drivers/char/specialix.c
+++ b/drivers/char/specialix.c
@@ -182,7 +182,6 @@ #undef RS_EVENT_WRITE_WAKEUP
 #define RS_EVENT_WRITE_WAKEUP	0
 
 static struct tty_driver *specialix_driver;
-static unsigned char * tmp_buf;
 
 static unsigned long baud_table[] =  {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
@@ -1674,7 +1673,7 @@ static int sx_write(struct tty_struct * 
 
 	bp = port_Board(port);
 
-	if (!port->xmit_buf || !tmp_buf) {
+	if (!port->xmit_buf) {
 		func_exit();
 		return 0;
 	}
@@ -2398,12 +2397,6 @@ static int sx_init_drivers(void)
 		return 1;
 	}
 
-	if (!(tmp_buf = (unsigned char *) get_zeroed_page(GFP_KERNEL))) {
-		printk(KERN_ERR "sx: Couldn't get free page.\n");
-		put_tty_driver(specialix_driver);
-		func_exit();
-		return 1;
-	}
 	specialix_driver->owner = THIS_MODULE;
 	specialix_driver->name = "ttyW";
 	specialix_driver->major = SPECIALIX_NORMAL_MAJOR;
@@ -2417,7 +2410,6 @@ static int sx_init_drivers(void)
 
 	if ((error = tty_register_driver(specialix_driver))) {
 		put_tty_driver(specialix_driver);
-		free_page((unsigned long)tmp_buf);
 		printk(KERN_ERR "sx: Couldn't register specialix IO8+ driver, error = %d\n",
 		       error);
 		func_exit();
@@ -2443,7 +2435,6 @@ static void sx_release_drivers(void)
 {
 	func_enter();
 
-	free_page((unsigned long)tmp_buf);
 	tty_unregister_driver(specialix_driver);
 	put_tty_driver(specialix_driver);
 	func_exit();
