Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVCYFr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVCYFr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVCYFr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:47:59 -0500
Received: from dea.vocord.ru ([217.67.177.50]:30695 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261335AbVCYFrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:47:23 -0500
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
In-Reply-To: <1111665551.23532.90.camel@uganda>
References: <20050315133644.GA25903@beast>  <20050324042708.GA2806@beast>
	 <1111665551.23532.90.camel@uganda>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7mNxw/gZlShPvoOou4C3"
Organization: MIPT
Date: Fri, 25 Mar 2005 08:52:51 +0300
Message-Id: <1111729971.20797.1.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 08:46:35 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7mNxw/gZlShPvoOou4C3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-24 at 14:59 +0300, Evgeniy Polyakov wrote:

> For example here is patch to enable acrypto support for hw_random.c
> It is very simple and support only upto 4 bytes request, of course it
> is not interested for anyone, but it is only 2-minutes example:

Full port.

--- ./drivers/char/hw_random.c.orig     2005-03-24 13:36:05.000000000 +0300
+++ ./drivers/char/hw_random.c  2005-03-25 08:46:03.841601032 +0300
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
@@ -526,7 +531,163 @@
        return ret;
 }

+#ifdef CONFIG_ACRYPTO
+static struct crypto_device *hwr_cdev;
+static struct crypto_capability hwr_caps[] =3D   {
+       {CRYPTO_OP_RNG, 0, 0, 100},
+};
+static int hwr_pid, hwr_need_exit;
+static struct completion hwr_thread_exited;
+static DECLARE_WAIT_QUEUE_HEAD(hwr_wait);
+
+
+static void hwr_data_ready(struct crypto_device *dev)
+{
+       wake_up(&hwr_wait);
+}
+
+static int hwr_process(void *data)
+{
+       struct crypto_device *dev =3D data;
+       struct crypto_session *s, *n;
+       u32 rng_data =3D 0;
+       unsigned int have_data, size;
+       int i;
+       u8 *ptr;
+
+       daemonize("%s", dev->name);
+       allow_signal(SIGTERM);
+
+       while (!hwr_need_exit) {
+               interruptible_sleep_on_timeout(&hwr_wait, 10);
+
+               list_for_each_entry_safe(s, n, &dev->session_list, dev_queu=
e_entry) {
+                       if (!session_completed(s) && !session_is_processed(=
s)) {
+                               start_process_session(s);
+
+                               if (s->data.sg_src_num !=3D s->data.sg_dst_=
num) {
+                                       dprintk("%s: session %llu [%llu]: d=
ifferent src/dst sg numbers: %d %d.\n",
+                                                       dev->name, s->ci.id=
, s->ci.dev_id,
+                                                       s->data.sg_src_num,=
 s->data.sg_dst_num);
+                                       broke_session(s);
+                                       goto out_complete_session;
+                               }
+
+                               for (i=3D0; i<s->data.sg_src_num; ++i) {
+                                       if (s->data.sg_dst[i].length !=3D s=
->data.sg_src[i].length) {
+                                               dprintk("%s: session %llu [=
%llu]: sg %d different src/dst lengths: %u %u.\n",
+                                                               dev->name, =
s->ci.id, s->ci.dev_id, i,
+                                                               s->data.sg_=
src[i].length, s->data.sg_dst[i].length);
+                                               if (s->data.sg_dst[i].lengt=
h)
+                                                       s->data.sg_src[i].l=
ength =3D s->data.sg_dst[i].length;
+                                               else
+                                                       s->data.sg_dst[i].l=
ength =3D s->data.sg_src[i].length;
+
+                                       }
+
+                                       size =3D s->data.sg_dst[i].length;
+
+                                       while (size) {
+                                               spin_lock(&rng_lock);
+                                               have_data =3D 0;
+                                               if (rng_ops->data_present()=
) {
+                                                       rng_data =3D rng_op=
s->data_read();
+                                                       have_data =3D rng_o=
ps->n_bytes;
+                                               }
+                                               spin_unlock (&rng_lock);
+
+                                               ptr =3D kmap_atomic(s->data=
.sg_dst[i].page, KM_USER0) + s->data.sg_dst[i].offset +
+                                                       s->data.sg_dst[i].l=
ength - size;
+
+                                               while (size && have_data) {
+                                                       *ptr =3D rng_data &=
 0xff;
+                                                       size--;
+                                                       have_data--;
+                                                       rng_data >>=3D 8;
+                                               }
+                                               kunmap_atomic(ptr, KM_USER0=
);
+
+                                               if (size)
+                                                       msleep_interruptibl=
e(1);
+                                       }
+                               }
+
+                               crypto_stat_complete_inc(s);
+
+out_complete_session:
+                               crypto_session_dequeue_route(s);
+                               complete_session(s);
+                               stop_process_session(s);
+                       }
+               }
+       }
+
+       complete_and_exit(&hwr_thread_exited, 0);
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
+       init_completion(&hwr_thread_exited);
+       hwr_pid =3D kernel_thread(hwr_process, hwr_cdev, CLONE_FS | CLONE_F=
ILES);
+       if (hwr_pid < 0) {
+               err =3D hwr_pid;
+               goto err_out_free_cdev;
+       }

+       err =3D crypto_device_add(hwr_cdev);
+       if (err)
+               goto err_out_remove_thread;
+
+       printk(KERN_INFO "%s acrypto support is turned on.\n", hwr_cdev->na=
me);
+
+err_out_remove_thread:
+       hwr_need_exit =3D 1;
+       kill_proc(hwr_pid, SIGTERM, 0);
+       wait_for_completion(&hwr_thread_exited);
+err_out_free_cdev:
+       kfree(hwr_cdev);
+       hwr_cdev =3D NULL;
+       return err;
+}
+
+static void hwr_acrypto_fini(void)
+{
+       crypto_device_remove(hwr_cdev);
+       printk(KERN_INFO "%s acrypto support is turned off.\n", hwr_cdev->n=
ame);
+
+       hwr_need_exit =3D 1;
+       kill_proc(hwr_pid, SIGTERM, 0);
+       wait_for_completion(&hwr_thread_exited);
+
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
@@ -549,9 +710,15 @@
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
@@ -617,6 +784,8 @@
 {
        DPRINTK ("ENTER\n");

+       hwr_acrypto_fini();
+
        misc_deregister (&rng_miscdev);

        if (rng_ops->cleanup)


--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-7mNxw/gZlShPvoOou4C3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ6czIKTPhE+8wY0RAiDGAKCUXrEAZSXotvN1hBtEplu2s6+u8gCcDMOG
2rVsgtPfIsd8GCW1uYSJeqE=
=lNVC
-----END PGP SIGNATURE-----

--=-7mNxw/gZlShPvoOou4C3--

