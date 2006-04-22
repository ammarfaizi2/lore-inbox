Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWDVA6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWDVA6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDVA6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:58:41 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:25779 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750822AbWDVA6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:58:40 -0400
X-Sasl-enc: uNvXhT7xWWqP7TUpm4E1ULahEPf2ybiWqaBTeYCBLhVI 1145667480
Message-ID: <44497FFE.6050508@imap.cc>
Date: Sat, 22 Apr 2006 02:59:42 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>
CC: Hansjoerg Lipp <hjlipp@web.de>
Subject: [PATCH 2.6.17-rc2 1/2] return class device pointer from tty_register_device()
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFEC2E13264C85F45C6155ED4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFEC2E13264C85F45C6155ED4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Please consider the following patch for inclusion.

From: Hansjoerg Lipp <hjlipp@web.de>

Let tty_register_device() return a pointer to the class device it creates.
This allows registrants to add their own sysfs files under the class
device node.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>

---

 drivers/char/tty_io.c |   11 +++++++----
 include/linux/tty.h   |    4 +++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff -urpN -X exclude linux-2.6.17-rc1-mm2.orig/drivers/char/tty_io.c linux-2.6.17-rc1-mm2/drivers/char/tty_io.c
--- linux-2.6.17-rc1-mm2.orig/drivers/char/tty_io.c	2006-04-09 18:30:56.000000000 +0200
+++ linux-2.6.17-rc1-mm2/drivers/char/tty_io.c	2006-04-18 23:17:32.000000000 +0200
@@ -2957,12 +2957,14 @@ static struct class *tty_class;
  *	This field is optional, if there is no known struct device for this
  *	tty device it can be set to NULL safely.
  *
+ * Returns a pointer to the class device (or NULL on error).
+ *
  * This call is required to be made to register an individual tty device if
  * the tty driver's flags have the TTY_DRIVER_NO_DEVFS bit set.  If that
  * bit is not set, this function should not be called.
  */
-void tty_register_device(struct tty_driver *driver, unsigned index,
-			 struct device *device)
+struct class_device *tty_register_device(struct tty_driver *driver,
+					 unsigned index, struct device *device)
 {
 	char name[64];
 	dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
@@ -2970,7 +2972,7 @@ void tty_register_device(struct tty_driv
 	if (index >= driver->num) {
 		printk(KERN_ERR "Attempt to register invalid tty line number "
 		       " (%d).\n", index);
-		return;
+		return NULL;
 	}

 	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
@@ -2980,7 +2982,8 @@ void tty_register_device(struct tty_driv
 		pty_line_name(driver, index, name);
 	else
 		tty_line_name(driver, index, name);
-	class_device_create(tty_class, NULL, dev, device, "%s", name);
+
+	return class_device_create(tty_class, NULL, dev, device, "%s", name);
 }

 /**
diff -urpN -X exclude linux-2.6.17-rc1-mm2.orig/include/linux/tty.h linux-2.6.17-rc1-mm2/include/linux/tty.h
--- linux-2.6.17-rc1-mm2.orig/include/linux/tty.h	2006-04-04 23:29:14.000000000 +0200
+++ linux-2.6.17-rc1-mm2/include/linux/tty.h	2006-04-18 23:22:47.000000000 +0200
@@ -291,7 +291,9 @@ extern int tty_register_ldisc(int disc,
 extern int tty_unregister_ldisc(int disc);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
-extern void tty_register_device(struct tty_driver *driver, unsigned index, struct device *dev);
+extern struct class_device *tty_register_device(struct tty_driver *driver,
+						unsigned index,
+						struct device *dev);
 extern void tty_unregister_device(struct tty_driver *driver, unsigned index);
 extern int tty_read_raw_data(struct tty_struct *tty, unsigned char *bufp,
 			     int buflen);

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Imagine a world without hypothetical situations.

--------------enigFEC2E13264C85F45C6155ED4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESYAHMdB4Whm86/kRAtUTAJ9KWic8vRz4G+j1CE2Q7zxeGWP7hwCdHU1o
t2KmzwlZN9eY8IIVgFKJogQ=
=Qq1R
-----END PGP SIGNATURE-----

--------------enigFEC2E13264C85F45C6155ED4--
