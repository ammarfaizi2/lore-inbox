Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVCHOvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVCHOvU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 09:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVCHOvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 09:51:20 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:2469 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261368AbVCHOuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 09:50:50 -0500
Date: Tue, 8 Mar 2005 18:16:12 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [1/5] bd: Asynchronous block device
Message-ID: <20050308181612.1cb38b5d@zanzibar.2ka.mipt.ru>
In-Reply-To: <11102278582250@2ka.mipt.ru>
References: <1110227858283@2ka.mipt.ru>
	<11102278582250@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 08 Mar 2005 17:50:12 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small morning patch for bd_fd filter which closes "major security vulnerability"
 described at http://off.net/~jme/loopdev_vul.html

Author's quite: "about 3 years ago i published a paper describing how an attacker would be able
to modify the content of the encrypted device without being detected."

Small archive of the descussion at: http://mail.nl.linux.org/linux-crypto/2005-01/msg00040.html

It is provideed to show how easy is bd filters creation.

Thank you for your attention :)

P.S. userspace ubd.c patch is not attached, it is 32 lines copy/allocation.

--- orig/bd_fd.c
+++ mod/bd_fd.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/crypto.h>
 
 #include "bd.h"
 #include "bd_filter.h"
@@ -37,6 +38,7 @@
 static int bd_fd_transfer(struct bd_transfer *);
 static int bd_fd_init(struct bd_device *, struct bd_filter *);
 static void bd_fd_fini(struct bd_device *, struct bd_filter *);
+static int bd_fd_check_media(struct bd_device *dev, struct bd_filter *f, int size);
 
 static struct bd_main_filter fd_filter = 
 {
@@ -126,9 +128,11 @@
 {
        struct bd_fd_private *p;
                struct bd_fd_user *u = f->priv;
-       int err;
+       int err, size;
+
+       size = f->priv_size - sizeof(*u);
 
-       p = kmalloc(sizeof(*p), GFP_KERNEL);
+       p = kmalloc(sizeof(*p) + size, GFP_KERNEL);
        if (!p) {
                dprintk("Failed to allocate new bd_fd priavte structure in dev=%s, filter=%s.\n", 
                                dev->name, f->mf->name);
@@ -136,8 +140,11 @@
        }
 
        memset(p, 0, sizeof(*p));
-
        memcpy(&p->u, u, sizeof(p->u));
+       if (size) {
+               p->hmac = (u8 *)(p+1);
+               memcpy(p->hmac, u+1, size);
+       }
 
        dprintk("%s: filter=%s, flags=%08x.\n", __func__, f->mf->name, f->mf->flags);
        
@@ -152,8 +159,11 @@
        err = bd_set_fd(dev, p);
        if (err)
                return err;
+
+       if (size)
+               err = bd_fd_check_media(dev, f, size);
        
-       return 0;
+       return err;
 }
 
 static void bd_fd_fini(struct bd_device *dev, struct bd_filter *f)
@@ -305,6 +315,93 @@
        return err;
 }
 
+static void bd_fd_complete(struct bd_transfer *t)
+{
+}
+#define SHA512_DIGEST_SIZE 64
+static int bd_fd_check_media(struct bd_device *dev, struct bd_filter *f, int size)
+{
+       struct crypto_tfm *tfm;
+       int err, i; 
+       loff_t storage_size, pos;
+       struct bd_fd_private *p = f->priv;
+       struct page *pg;
+       struct bd_transfer t;
+       u8 hmac[SHA512_DIGEST_SIZE];
+       u8 scratch[SHA512_DIGEST_SIZE];
+       struct scatterlist sg;
+
+       if (size != SHA512_DIGEST_SIZE)
+               return -EINVAL;
+       
+       tfm = crypto_alloc_tfm("sha512", 0);
+       if (!tfm) {
+               dprintk("Failed to create sha512 tfm for device %s.\n", dev->name);
+               return -ENODEV;
+       }
+
+       storage_size = bd_get_size(dev, p);
+       if (!storage_size) {
+               dprintk("Storage size of %s is %llu.\n", dev->name, storage_size);
+               err = -EINVAL;
+               goto err_out_free_tfm;
+       }
+
+       pg = alloc_pages(GFP_KERNEL, 0);
+       if (!pg) {
+               dprintk("Failed to get free scratch page for device %s.\n", dev->name);
+               err = -ENOMEM;
+               goto err_out_free_tfm;
+       }
+
+       memset(&t, 0, sizeof(t));
+
+       for (pos=0; pos<storage_size;) {
+               t.src.page = pg;
+               t.src.off = 0;
+               t.src.size = (storage_size - pos > PAGE_SIZE)?PAGE_SIZE:(storage_size - pos);
+               t.cmd = READ;
+               t.pos = pos;
+               t.f = f;
+               t.f->complete = bd_fd_complete;
+               
+               file_bd_read(&t);
+
+               pos += PAGE_SIZE;
+
+               sg.page = pg;
+               sg.offset = 0;
+               sg.length = PAGE_SIZE;
+
+               crypto_digest_digest(tfm, &sg, 1, scratch);
+
+               for (i=0; i<sizeof(hmac); ++i) {
+                       hmac[i] ^= scratch[i];
+               }
+       }
+
+       __free_pages(pg, 0);
+
+err_out_free_tfm:
+       crypto_free_tfm(tfm);
+
+       err = memcmp(hmac, p->hmac, sizeof(hmac));
+
+       printk("Calculated: ");
+       for (i=0; i<sizeof(hmac); ++i) {
+               printk("%02x ", hmac[i]);
+       }
+       printk("\n");
+       printk("Provided  : ");
+       for (i=0; i<sizeof(hmac); ++i) {
+               printk("%02x ", p->hmac[i]);
+       }
+       printk("\n");
+               
+       return err;
+}
+
+
 int __devinit bd_fd_init_dev(void)
 {
        int err;


--- orig/bd_fd.h
+++ mod/bd_fd.h
@@ -34,6 +34,8 @@
        struct bd_fd_user       u;
 
        struct file             *file;
+
+       u8                      *hmac;
 };
 
 #endif /* __KERNEL__ */



	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
