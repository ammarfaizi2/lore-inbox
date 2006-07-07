Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWGGBUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWGGBUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGGBUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:20:37 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:44083 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751118AbWGGBUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:20:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GtuXiXSbLcR1s2CvKYxN8NcOzsgPk/oazRCpSJn8dgKes3jP/iwH57LAVKA02gwCvMCUqoHUBMI2cuKXLCXFDmR5Ug+JAsa6LmKDIiQeFRp91tYpUd6eDT373nrXIYSODIXLCUPPc2/O+kbe7pB1eRm4w/QmOjUi92W9fMZ2sUU=
Date: Thu, 6 Jul 2006 21:20:25 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] Integrate asus_acpi LED's with new LED subsystem
Message-ID: <20060707012025.GB8900@phoenix>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Richard Purdie <rpurdie@rpsys.net>
References: <20060706193157.GC14043@phoenix> <20060706154930.1a8fbad5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20060706154930.1a8fbad5.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: multipart/mixed; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here is a patch to the asus_acpi driver that links the Asus laptop LED's
into the new LED subsystem.  It creates LED class devices named
asus:mail, asus:wireless, and asus:touchpad, depending on if the laptop
supports the mled, wled, and tled LED's.

Since it's so new, I added a config option to turn it on and off.  It's
worked for me, though I have an Asus M2N, which only has the mail and
wireless LED's.

Signed-off-by: Thomas Tuttle <thinkinginbinary@gmail.com>


I believe I've fixed everything you asked about, plus a few things
Richard Purdie (the LED subsystem guy) suggested.

On July 06 at 18:49 EDT, Andrew Morton hastily scribbled:
> Thomas Tuttle <thinkinginbinary@gmail.com> wrote:
> > +#ifdef CONFIG_ACPI_ASUS_NEW_LED
> > +#include <linux/leds.h>
> > +#endif
> The ifdef shouldn't be required.  If it is, ldes.h needs fixing.
Fixed.

> This mingles declarations with definitions.  It's more conventional to ke=
ep
> them together.
Fixed.  I moved all the declarations together, and initialized the
led_cdev structs if and when they are going to be registered.  (Just as
with the zero initializers, this should stop them from wasting space in
=2Evmlinux.)

> Please don' t initialise static storage to zero (the "=3D 0").  The C run=
time
> environment does that already, and the above construct will place the
> values into .data and hence into .vmlinux.
Fixed.

> > +/* LED update work structs. */
> These all should be declared static.
Fixed.

> > +/* LED work functions. */
> > +static void led_update_mled(void *private) {
> The opening brace goes in column 1.
Fixed.

> It's usual to put a blank line at the end of the declaration of the
> automatic valriables.
Fixed.

> Add:
>=20
> #else
> static inline int led_initialize(struct device *parent)
> {
> }
>=20
> static inline void led_terminate(void)
> {
> }
> #endif
Fixed.

> > +#ifdef CONFIG_ACPI_ASUS_NEW_LED
> > +        result =3D led_initialize(acpi_get_physical_device(device->han=
dle));
> > +#endif
> > +
> > =20
> > +#ifdef CONFIG_ACPI_ASUS_NEW_LED
> > +        led_terminate();
> > +#endif         =20
> > +
> And remove these ifdefs.
Fixed.

I believe it's a little less ugly now.  The declarations are better
organized, error recovery from the initialization is better (sorry to
use goto, but if I didn't, I'd have to duplicate the abort code for each
possible point of failure).

This revision is essentially the same, functionally, and it appears to
work in quick testing.  I think it would be nice if someone else with an
Asus laptop could give this a test before it goes into mainline.  The
code that updates the LED's is basically copied from the /proc
interface, but testing is good.

-- Thomas Tuttle

--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="asus-acpi-led-subsystem.patch"
Content-Transfer-Encoding: quoted-printable

diff -udrN linux-2.6.17-git25/drivers/acpi/asus_acpi.c linux-2.6.17-git25-m=
ine/drivers/acpi/asus_acpi.c
--- linux-2.6.17-git25/drivers/acpi/asus_acpi.c	2006-07-05 22:11:37.0000000=
00 -0400
+++ linux-2.6.17-git25-mine/drivers/acpi/asus_acpi.c	2006-07-06 21:06:58.00=
0000000 -0400
@@ -27,6 +27,7 @@
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting poin=
t.
  *  =C9ric Burghard  - LED display support for W1N
+ *  Thomas Tuttle  - LED subsystem integration
  *
  */
=20
@@ -35,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/leds.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -916,6 +918,158 @@
 	return 0;
 }
=20
+#ifdef CONFIG_ACPI_ASUS_NEW_LED
+	=09
+static struct led_classdev led_cdev_mled, led_cdev_wled, led_cdev_tled;
+
+/* Desired values of LED's. */
+static int led_mled_value;=20
+static int led_wled_value;
+static int led_tled_value;=20
+
+/* These functions are called by the LED subsystem to update the desired
+ * state of the LED's. */
+static void led_set_mled(struct led_classdev *led_cdev,
+				enum led_brightness value);
+static void led_set_wled(struct led_classdev *led_cdev,
+				enum led_brightness value);
+static void led_set_tled(struct led_classdev *led_cdev,
+				enum led_brightness value);
+
+/* The LED update functions can be called in interrupt context, so we
+ * use a work queue to pass the updates to ACPI at a safer time. */
+static void led_update_mled(void *private);
+static void led_update_wled(void *private);
+static void led_update_tled(void *private);
+	=09
+/* LED workqueue. */
+static struct workqueue_struct *led_workqueue;
+
+/* LED update work structs. */
+static DECLARE_WORK(led_mled_work, led_update_mled, NULL);
+static DECLARE_WORK(led_wled_work, led_update_wled, NULL);
+static DECLARE_WORK(led_tled_work, led_update_tled, NULL);
+
+/* LED subsystem callbacks. */
+static void led_set_mled(struct led_classdev *led_cdev,
+	enum led_brightness value)
+{      =20
+	led_mled_value =3D value;
+	queue_work(led_workqueue, &led_mled_work);
+}
+
+static void led_set_wled(struct led_classdev *led_cdev,
+	enum led_brightness value)
+{
+	led_wled_value =3D value;
+	queue_work(led_workqueue, &led_wled_work);
+}      =20
+=09
+static void led_set_tled(struct led_classdev *led_cdev,
+	enum led_brightness value)
+{      =20
+	led_tled_value =3D value;=20
+	queue_work(led_workqueue, &led_tled_work);
+}      =20
+	   =20
+/* LED work functions. */
+static void led_update_mled(void *private)
+{
+	char *ledname =3D hotk->methods->mt_mled;
+	int led_out =3D led_mled_value ? 1 : 0;
+
+	hotk->status =3D (led_out) ? (hotk->status | MLED_ON) : (hotk->status & ~=
MLED_ON);
+	led_out =3D 1 - led_out;
+	if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
+		printk(KERN_WARNING "Asus ACPI: Writing MLED failed.\n");
+}
+
+static void led_update_wled(void *private)
+{
+	char *ledname =3D hotk->methods->mt_wled;
+	int led_out =3D led_wled_value ? 1 : 0;
+
+	hotk->status =3D (led_out) ? (hotk->status | WLED_ON) : (hotk->status & ~=
WLED_ON);
+	if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
+		printk(KERN_WARNING "Asus ACPI: Writing WLED failed.\n");
+}
+
+static void led_update_tled(void *private)
+{
+	char *ledname =3D hotk->methods->mt_tled;
+	int led_out =3D led_tled_value ? 1 : 0;
+
+	hotk->status =3D (led_out) ? (hotk->status | TLED_ON) : (hotk->status & ~=
TLED_ON);
+	if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
+		printk(KERN_WARNING "Asus ACPI: Writing TLED failed.\n");
+}
+
+/* Registers LED class devices and sets up workqueue. */
+static int led_initialize(struct device *parent)
+{
+	int result;
+
+	if (hotk->methods->mt_mled) {
+		led_cdev_mled.name =3D "asus:mail";
+		led_cdev_mled.brightness_set =3D led_set_mled;
+		result =3D led_classdev_register(parent, &led_cdev_mled);
+		if (result) goto mled_abort;
+	}
+
+	if (hotk->methods->mt_wled) {
+		led_cdev_wled.name =3D "asus:wireless";
+		led_cdev_wled.brightness_set =3D led_set_wled;
+		result =3D led_classdev_register(parent, &led_cdev_wled);
+		if (result) goto wled_abort;
+	}
+
+	if (hotk->methods->mt_tled) {
+		led_cdev_tled.name =3D "asus:touchpad";
+		led_cdev_tled.brightness_set =3D led_set_tled;
+		result =3D led_classdev_register(parent, &led_cdev_tled);
+		if (result) goto tled_abort;
+	}
+
+	led_workqueue =3D create_singlethread_workqueue("led_workqueue");
+
+	return 0;
+
+tled_abort:
+	if (hotk->methods->mt_wled) led_classdev_unregister(&led_cdev_wled);
+wled_abort:
+	if (hotk->methods->mt_mled) led_classdev_unregister(&led_cdev_mled);
+mled_abort:
+	return result;
+=09
+}
+
+/* Destroys the workqueue and unregisters the LED class devices. */
+static void led_terminate(void)
+{
+	destroy_workqueue(led_workqueue);
+
+	if (hotk->methods->mt_tled)
+		led_classdev_unregister(&led_cdev_tled);
+
+	if (hotk->methods->mt_wled)
+		led_classdev_unregister(&led_cdev_wled);
+=09
+	if (hotk->methods->mt_mled)
+		led_classdev_unregister(&led_cdev_mled);
+}
+
+#else
+
+static inline int led_initialize(struct device *parent)
+{
+}
+
+static inline void led_terminate(void)
+{
+}
+
+#endif
+
 static int asus_hotk_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *proc;
@@ -1299,6 +1453,8 @@
 	/* LED display is off by default */
 	hotk->ledd_status =3D 0xFFF;
=20
+	result =3D led_initialize(acpi_get_physical_device(device->handle));
+
       end:
 	if (result) {
 		kfree(hotk);
@@ -1314,6 +1470,8 @@
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
=20
+	led_terminate();
+
 	status =3D acpi_remove_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
 					    asus_hotk_notify);
 	if (ACPI_FAILURE(status))
diff -udrN linux-2.6.17-git25/drivers/acpi/Kconfig linux-2.6.17-git25-mine/=
drivers/acpi/Kconfig
--- linux-2.6.17-git25/drivers/acpi/Kconfig	2006-07-05 22:44:33.000000000 -=
0400
+++ linux-2.6.17-git25-mine/drivers/acpi/Kconfig	2006-07-05 22:44:43.000000=
000 -0400
@@ -199,6 +199,15 @@
           something works not quite as expected, please use the mailing li=
st
           available on the above page (acpi4asus-user@lists.sourceforge.ne=
t)
          =20
+config ACPI_ASUS_NEW_LED
+        bool "ASUS/Medion LED subsystem integration"
+        depends on ACPI_ASUS
+        depends on LEDS_CLASS
+        help
+          This adds support for the new LED subsystem to the asus_acpi
+          driver.  The LED's will show up as asus:mail, asus:wireless,
+          and asus:touchpad, as applicable to your laptop.
+
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86

--bCsyhTFzCvuiizWE--

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFErbbZ/UG6u69REsYRAptBAJ4zSgCCRf5OBFjFgr2k9VHzTIJOXACgidiq
7wHhcGuDC8TFrI6unPbrb+Y=
=R3Pj
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
