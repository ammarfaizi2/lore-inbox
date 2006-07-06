Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbWGFC6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWGFC6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWGFC6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:58:18 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:43838 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965140AbWGFC6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:58:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=aQ9aE5Hta19EhV93xQ8ezOXcrUiGM+GFrq6HoScqqYGpuiZLC+QyZ0hFspW06/TYbOj23rowJUhKH5GrqIks27PfkljIztPk6E77lvowwUf1GV+6k8/nFTSTTRhkjswbJC5b63JR33XhJZsHK8ji+1hgK66z3Rsw6lDlkZKvfKg=
Date: Wed, 5 Jul 2006 22:58:15 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: Integrate asus_acpi LED's with new LED subsystem
Message-ID: <20060706025815.GB25835@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: multipart/mixed; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Again... I'm sorry, Gmail sucks, here's a plain text version against
2.6.17-git25.

Comments are happily accepted.

Thanks,

Thomas Tuttle

--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="asus-acpi-led-subsystem.patch"
Content-Transfer-Encoding: quoted-printable

diff -udrN linux-2.6.17-git25/drivers/acpi/asus_acpi.c linux-2.6.17-git25-m=
ine/drivers/acpi/asus_acpi.c
--- linux-2.6.17-git25/drivers/acpi/asus_acpi.c	2006-07-05 22:11:37.0000000=
00 -0400
+++ linux-2.6.17-git25-mine/drivers/acpi/asus_acpi.c	2006-07-05 22:26:51.00=
0000000 -0400
@@ -27,14 +27,19 @@
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting poin=
t.
  *  =EF=BF=BDric Burghard  - LED display support for W1N
+ *  Thomas Tuttle  - LED subsystem integration
  *
  */
=20
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#ifdef CONFIG_ACPI_ASUS_NEW_LED
+#include <linux/leds.h>
+#endif
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -916,6 +921,145 @@
 	return 0;
 }
=20
+#ifdef CONFIG_ACPI_ASUS_NEW_LED
+               =20
+/* These functions are called by the LED subsystem to update the desired
+ * state of the LED's. */
+static void led_set_mled(struct led_classdev *led_cdev,
+                                enum led_brightness value);
+static void led_set_wled(struct led_classdev *led_cdev,
+                                enum led_brightness value);
+static void led_set_tled(struct led_classdev *led_cdev,
+                                enum led_brightness value);
+
+/* LED class devices. */
+static struct led_classdev led_cdev_mled =3D
+        { .name =3D "asus:mail",     .brightness_set =3D led_set_mled };
+static struct led_classdev led_cdev_wled =3D
+        { .name =3D "asus:wireless", .brightness_set =3D led_set_wled };
+static struct led_classdev led_cdev_tled =3D
+        { .name =3D "asus:touchpad", .brightness_set =3D led_set_tled };
+
+/* These functions actually update the LED's, and are called from a
+ * workqueue.  By doing this as separate work rather than when the LED
+ * subsystem asks, I avoid messing with the Asus ACPI stuff during a
+ * potentially bad time, such as a timer interrupt. */
+static void led_update_mled(void *private);
+static void led_update_wled(void *private);
+static void led_update_tled(void *private);
+               =20
+/* Desired values of LED's. */
+static int led_mled_value =3D 0;=20
+static int led_wled_value =3D 0;
+static int led_tled_value =3D 0;=20
+
+/* LED workqueue. */
+static struct workqueue_struct *led_workqueue;
+
+/* LED update work structs. */
+DECLARE_WORK(led_mled_work, led_update_mled, NULL);
+DECLARE_WORK(led_wled_work, led_update_wled, NULL);
+DECLARE_WORK(led_tled_work, led_update_tled, NULL);
+               =20
+/* LED subsystem callbacks. */
+static void led_set_mled(struct led_classdev *led_cdev,
+        enum led_brightness value)
+{      =20
+        led_mled_value =3D value;
+        queue_work(led_workqueue, &led_mled_work);
+}
+
+static void led_set_wled(struct led_classdev *led_cdev,
+        enum led_brightness value)
+{
+        led_wled_value =3D value;
+        queue_work(led_workqueue, &led_wled_work);
+}      =20
+       =20
+static void led_set_tled(struct led_classdev *led_cdev,
+        enum led_brightness value)
+{      =20
+        led_tled_value =3D value;=20
+        queue_work(led_workqueue, &led_tled_work);
+}      =20
+           =20
+/* LED work functions. */
+static void led_update_mled(void *private) {
+        char *ledname =3D hotk->methods->mt_mled;
+        int led_out =3D led_mled_value ? 1 : 0;
+        hotk->status =3D (led_out) ? (hotk->status | MLED_ON) : (hotk->sta=
tus & ~MLED_ON);
+        led_out =3D 1 - led_out;
+        if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
+                printk(KERN_WARNING "Asus ACPI: LED (%s) write failed\n",
+                       ledname);
+}
+
+static void led_update_wled(void *private) {
+        char *ledname =3D hotk->methods->mt_wled;
+        int led_out =3D led_wled_value ? 1 : 0;
+        hotk->status =3D (led_out) ? (hotk->status | WLED_ON) : (hotk->sta=
tus & ~WLED_ON);
+        if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
+                printk(KERN_WARNING "Asus ACPI: LED (%s) write failed\n",
+                       ledname);
+}
+
+static void led_update_tled(void *private) {
+        char *ledname =3D hotk->methods->mt_tled;
+        int led_out =3D led_tled_value ? 1 : 0;
+        hotk->status =3D (led_out) ? (hotk->status | TLED_ON) : (hotk->sta=
tus & ~TLED_ON);
+        if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
+                printk(KERN_WARNING "Asus ACPI: LED (%s) write failed\n",
+                       ledname);
+}
+
+/* Registers LED class devices and sets up workqueue. */
+static int led_initialize(struct device *parent)
+{
+        int result;
+
+        if (hotk->methods->mt_mled) {
+                result =3D led_classdev_register(parent, &led_cdev_mled);
+                if (result)
+                        return result;
+        }
+
+        if (hotk->methods->mt_wled) {
+                result =3D led_classdev_register(parent, &led_cdev_wled);
+                if (result)
+                        return result;
+        }
+
+        if (hotk->methods->mt_tled) {
+                result =3D led_classdev_register(parent, &led_cdev_tled);
+                if (result)
+                        return result;
+        }
+
+        led_workqueue =3D create_singlethread_workqueue("led_workqueue");
+
+        return 0;
+}
+
+/* Destroys the workqueue and unregisters the LED class devices. */
+static void led_terminate(void)
+{
+        destroy_workqueue(led_workqueue);
+
+        if (hotk->methods->mt_tled) {
+                led_classdev_unregister(&led_cdev_tled);
+        }
+
+        if (hotk->methods->mt_wled) {
+                led_classdev_unregister(&led_cdev_wled);
+        }
+       =20
+        if (hotk->methods->mt_mled) {
+                led_classdev_unregister(&led_cdev_mled);
+        }
+}
+
+#endif
+
 static int asus_hotk_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *proc;
@@ -1299,6 +1443,10 @@
 	/* LED display is off by default */
 	hotk->ledd_status =3D 0xFFF;
=20
+#ifdef CONFIG_ACPI_ASUS_NEW_LED
+        result =3D led_initialize(acpi_get_physical_device(device->handle)=
);
+#endif
+
       end:
 	if (result) {
 		kfree(hotk);
@@ -1314,6 +1462,10 @@
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
=20
+#ifdef CONFIG_ACPI_ASUS_NEW_LED
+        led_terminate();
+#endif         =20
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

--Clx92ZfkiYIKRjnr--

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFErHxH/UG6u69REsYRApSjAJ0egXCpQFCscnjbr0jLBYiAhRasmQCdEQub
kM0jEAmN2fuTJLkSNw6KCvs=
=mmDq
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
