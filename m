Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWFVNGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWFVNGm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWFVNGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:06:42 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:17288 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1030210AbWFVNGl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:06:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 1/13] SST driver: tty_register_device() change
Date: Thu, 22 Jun 2006 09:06:40 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B710F1@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 1/13] SST driver: tty_register_device() change
Thread-Index: AcaV/LL5lRWNNqJdQhm4HIkdZRABYw==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 1: Modifies the tty subsystem routine tty_register_device so that
it
returns the class_device allocated for the tty device, thus making it 
available to the tty driver.  The class_device is used by this driver to
add additional sysfs-based attribute files used for status and
diagnostics.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 drivers/char/tty_io.c |    8 ++++----
 include/linux/tty.h   |    4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff -Naurp -X dontdiff linux-2.6.17/include/linux/tty.h
linux-2.6.17.eqnx/include/linux/tty.h
--- linux-2.6.17/include/linux/tty.h	2006-06-17 21:49:35.000000000
-0400
+++ linux-2.6.17.eqnx/include/linux/tty.h	2006-06-20
09:49:54.000000000 -0400
@@ -291,7 +291,9 @@ extern int tty_register_ldisc(int disc, 
 extern int tty_unregister_ldisc(int disc);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
-extern void tty_register_device(struct tty_driver *driver, unsigned
index, struct device *dev);
+extern struct class_device *tty_register_device(struct tty_driver
*driver,
+						unsigned index,
+						struct device *dev);
 extern void tty_unregister_device(struct tty_driver *driver, unsigned
index);
 extern int tty_read_raw_data(struct tty_struct *tty, unsigned char
*bufp,
 			     int buflen);
diff -Naurp -X dontdiff linux-2.6.17/drivers/char/tty_io.c
linux-2.6.17.eqnx/drivers/char/tty_io.c
--- linux-2.6.17/drivers/char/tty_io.c	2006-06-17 21:49:35.000000000
-0400
+++ linux-2.6.17.eqnx/drivers/char/tty_io.c	2006-06-20
09:49:54.000000000 -0400
@@ -2965,8 +2965,8 @@ static struct class *tty_class;
  * the tty driver's flags have the TTY_DRIVER_NO_DEVFS bit set.  If
that
  * bit is not set, this function should not be called.
  */
-void tty_register_device(struct tty_driver *driver, unsigned index,
-			 struct device *device)
+struct class_device *tty_register_device(struct tty_driver *driver,
+					 unsigned index, struct device
*device)
 {
 	char name[64];
 	dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
@@ -2974,7 +2974,7 @@ void tty_register_device(struct tty_driv
 	if (index >= driver->num) {
 		printk(KERN_ERR "Attempt to register invalid tty line
number "
 		       " (%d).\n", index);
-		return;
+		return NULL;
 	}
 
 	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
@@ -2984,7 +2984,7 @@ void tty_register_device(struct tty_driv
 		pty_line_name(driver, index, name);
 	else
 		tty_line_name(driver, index, name);
-	class_device_create(tty_class, NULL, dev, device, "%s", name);
+	return (class_device_create(tty_class, NULL, dev, device, "%s",
name));
 }
 
 /**
