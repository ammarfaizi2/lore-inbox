Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVCXLyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVCXLyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVCXLyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:54:55 -0500
Received: from dea.vocord.ru ([217.67.177.50]:37596 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262445AbVCXLy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:54:28 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: David McCullough <davidm@snapgear.com>
Cc: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050324042708.GA2806@beast>
References: <20050315133644.GA25903@beast>  <20050324042708.GA2806@beast>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/GdB+YE6KFDESd8fwdOn"
Organization: MIPT
Date: Thu, 24 Mar 2005 14:59:11 +0300
Message-Id: <1111665551.23532.90.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 24 Mar 2005 14:52:04 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/GdB+YE6KFDESd8fwdOn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-24 at 14:27 +1000, David McCullough wrote:
> Hi all,
>=20
> Here is a small patch for 2.6.11 that adds a routine:
>=20
> 	add_true_randomness(__u32 *buf, int nwords);
>=20
> so that true random number generator device drivers can add a entropy
> to the system.  Drivers that use this can be found in the latest release
> of ocf-linux,  an asynchronous crypto implementation for linux based on
> the *BSD Cryptographic Framework.
>=20
> 	http://ocf-linux.sourceforge.net/
>=20
> Adding this can dramatically improve the performance of /dev/random on
> small embedded systems which do not generate much entropy.

People will not apply any kind of such changes.
Both OCF and acrypto already handle all RNG cases - no need for any kind
of userspace daemon or entropy (re)injection mechanism.
Anyone who want to use HW randomness may use OCF/acrypto mechanism.
For example here is patch to enable acrypto support for hw_random.c
It is very simple and support only upto 4 bytes request, of course it
is=20
not interested for anyone, but it is only 2-minutes example:

--- ./drivers/char/hw_random.c.orig     2005-03-24 13:36:05.000000000 +0300
+++ ./drivers/char/hw_random.c  2005-03-24 14:48:30.470407432 +0300
@@ -34,6 +34,10 @@
 #include <linux/smp_lock.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
+#include <linux/acrypto.h>
+#include <linux/crypto_def.h>
+#include <linux/crypto_stat.h>
+#include <linux/highmem.h>

 #ifdef __i386__
 #include <asm/msr.h>
@@ -73,6 +77,8 @@
 #endif

 #define RNG_MISCDEV_MINOR              183 /* official */
+
+static DEFINE_SPINLOCK(rng_lock);

 static int rng_dev_open (struct inode *inode, struct file *filp);
 static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t s=
ize,
@@ -482,7 +488,6 @@
 static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t s=
ize,
                                loff_t * offp)
 {
-       static DEFINE_SPINLOCK(rng_lock);
        unsigned int have_data;
        u32 data =3D 0;
        ssize_t ret =3D 0;
@@ -526,7 +531,109 @@
        return ret;
 }

+#define CONFIG_ACRYPTO
+#ifdef CONFIG_ACRYPTO
+static struct crypto_device *hwr_cdev;
+static struct crypto_capability hwr_caps[] =3D   {
+       {CRYPTO_OP_RNG, 0, 0, 100},
+};
+

+static void hwr_data_ready(struct crypto_device *dev)
+{
+       struct crypto_session *s, *n;
+       unsigned long flags;
+       u32 data =3D 0;
+       unsigned int have_data;
+       u8 *ptr, *optr;
+
+       local_irq_save(flags);
+       if (spin_trylock(&dev->session_lock)) {
+               local_irq_restore(flags);
+               return;
+       }
+
+       list_for_each_entry_safe(s, n, &dev->session_list, dev_queue_entry)=
 {
+               if (!session_completed(s) && !session_is_processed(s)) {
+                       start_process_session(s);
+                       spin_lock(&rng_lock);
+                       have_data =3D 0;
+                       if (rng_ops->data_present()) {
+                               data =3D rng_ops->data_read();
+                               have_data =3D rng_ops->n_bytes;
+                       }
+                       spin_unlock (&rng_lock);
+
+                       optr =3D ptr =3D kmap_atomic(s->data.sg_dst[0].page=
, KM_USER0) + s->data.sg_dst[0].offset;
+                       while (s->data.sg_dst[0].length && have_data) {
+                               *ptr++ =3D data & 0xff;
+                               s->data.sg_dst[0].length--;
+                               have_data--;
+                               data >>=3D 8;
+                       }
+                       kunmap_atomic(optr, KM_USER0);
+
+                       if (s->data.sg_dst[0].length)
+                               broke_session(s); /* Need proper work defer=
ring, see async_provider.c as example. */
+
+                       crypto_stat_complete_inc(s);
+                       crypto_session_dequeue_route(s);
+                       complete_session(s);
+                       stop_process_session(s);
+               }
+       }
+
+       spin_unlock(&dev->session_lock);
+       local_irq_restore(flags);
+}
+
+static int hwr_acrypto_init(struct rng_operations *ops)
+{
+       int err;
+
+       hwr_cdev =3D kmalloc(sizeof(*hwr_cdev), GFP_KERNEL);
+       if (!hwr_cdev) {
+               printk(KERN_ERR "Failed to allocate new crypto_device struc=
ture.\n");
+               return -ENOMEM;
+       }
+
+       memset(hwr_cdev, 0, sizeof(*hwr_cdev));
+
+       hwr_cdev->cap           =3D hwr_caps;
+       hwr_cdev->cap_number    =3D sizeof(hwr_caps)/sizeof(hwr_caps[0]);
+       hwr_cdev->priv          =3D ops;
+       hwr_cdev->data_ready    =3D &hwr_data_ready;
+       snprintf(hwr_cdev->name, sizeof(hwr_cdev->name), "%s", "hwr");
+
+       err =3D crypto_device_add(hwr_cdev);
+       if (err) {
+               kfree(hwr_cdev);
+               hwr_cdev =3D NULL;
+               return err;
+       }
+
+       printk(KERN_INFO "%s acrypto support is turned on.\n", hwr_cdev->na=
me);
+
+       return err;
+}
+
+static void hwr_acrypto_fini(void)
+{
+       crypto_device_remove(hwr_cdev);
+       printk(KERN_INFO "%s acrypto support is turned off.\n", hwr_cdev->n=
ame);
+       kfree(hwr_cdev);
+       hwr_cdev =3D NULL;
+}
+#else
+static int hwr_acrypto_init(struct rng_operations *ops)
+{
+       return 0;
+}
+
+static void hwr_acrypto_fini(void)
+{
+}
+#endif

 /*
  * rng_init_one - look for and attempt to init a single RNG
@@ -549,9 +656,15 @@
                goto err_out_cleanup_hw;
        }

+       rc =3D hwr_acrypto_init(rng_ops);
+       if (rc)
+               goto err_out_misc_unregister;
+
        DPRINTK ("EXIT, returning 0\n");
        return 0;

+err_out_misc_unregister:
+       misc_deregister(&rng_miscdev);
 err_out_cleanup_hw:
        rng_ops->cleanup();
 err_out:
@@ -617,6 +730,8 @@
 {
        DPRINTK ("ENTER\n");

+       hwr_acrypto_fini();
+
        misc_deregister (&rng_miscdev);

        if (rng_ops->cleanup)


So, one may use crypto_session_alloc(gimme_real_randomness) and that is
all
(either from userspace or kernelspace).
As far as I can see, OCF support is also very simple.

What I want to say, is that since OCF and acrypto already support
all RNG cases, it is better to port existing drivers to them, but
not the reverse.
That will allow to use both old hw_random.c driver and
any new one(HIFN, VIA, safenet, any other) without breaking any
interfaces from both userspace and kernelspace.

If one of the asynchronous crypto layers will be included,=20
/dev/random implementation can be changed to support it.

> Cheers,
> Davidm

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-/GdB+YE6KFDESd8fwdOn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQquPIKTPhE+8wY0RArn/AKCCWejd1hrBxkEA24ARvGE+lyk3egCeNxJY
O4EuyqFc3XHS7ynCd1W/VQs=
=9RO2
-----END PGP SIGNATURE-----

--=-/GdB+YE6KFDESd8fwdOn--

