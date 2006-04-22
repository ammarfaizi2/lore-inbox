Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWDVR07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDVR07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWDVR06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:26:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:61335 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750765AbWDVR06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:26:58 -0400
X-Sasl-enc: U88qSiwIZhCTTQQX/yBbSihfJkYGz5Rj87AcB6ltFEye 1145723698
Message-ID: <444A5BA5.6040007@imap.cc>
Date: Sat, 22 Apr 2006 18:36:53 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, gregkh@suse.de, hjlipp@web.de
Subject: Re: [PATCH 2.6.17-rc2 1/2] return class device pointer from tty_register_device()
References: <44497FFE.6050508@imap.cc> <20060421181429.5ea9d777.akpm@osdl.org>
In-Reply-To: <20060421181429.5ea9d777.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC08F37F2D94B32BC931EFADD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC08F37F2D94B32BC931EFADD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 22.04.2006 03:14, Andrew Morton wrote:

> Tilman Schmidt <tilman@imap.cc> wrote:
> 
>> + * Returns a pointer to the class device (or NULL on error).
>> + *
> 
> It would be better to make this return ERR_PTR(-Efoo) on error, rather than
> NULL.

Good point. Here's an accordingly updated version.
I'll follow up with a matching version of part 2.

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
+++ linux-2.6.17-rc1-mm2/drivers/char/tty_io.c	2006-04-22 04:57:59.000000000 +0200
@@ -2957,12 +2957,14 @@ static struct class *tty_class;
  *	This field is optional, if there is no known struct device for this
  *	tty device it can be set to NULL safely.
  *
+ * Returns a pointer to the class device (or ERR_PTR(-Efoo) on error).
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
+		return ERR_PTR(-EINVAL);
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
+++ linux-2.6.17-rc1-mm2/include/linux/tty.h	2006-04-22 05:12:34.000000000 +0200
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

--------------enigC08F37F2D94B32BC931EFADD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESlulMdB4Whm86/kRAigVAJ4u/ENwvczSuxYz/M7F1aeyRIznIACfc1w8
uPyB7mEq9j+heFKX4Zly7g0=
=FaMw
-----END PGP SIGNATURE-----

--------------enigC08F37F2D94B32BC931EFADD--
