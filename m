Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbUJWO27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUJWO27 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUJWO27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:28:59 -0400
Received: from mproxy.gmail.com ([216.239.56.246]:47528 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261195AbUJWO2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:28:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=sIqA7vPobRXXjtTr9INDJclsehjwqLNnC7bZSUhaAuuc2kt/qCIhe1aNVEkfwaEZUzo6GuSK0IUNUTNHJoSOKc0y9y20nJPUqJC1lojtKebeN8JpsBYNCGFOKi8lP1fJ82+PQgJ+jDsHXSIAx8uutGNKcUSeKZpk8vmHR5fcmIE=
Message-ID: <21d7e99704102307287a08247@mail.gmail.com>
Date: Sun, 24 Oct 2004 00:28:18 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
In-Reply-To: <20041023095644.GC30137@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2550_6765188.1098541698905"
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2550_6765188.1098541698905
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> 
> Sorry, wrong API.  At least export the individual functions and use them
> directly (and without the symbol_get abnomination that's not any better
> than inter_module_*).

I wonder what the reasoning behind the old drm_agp structure was in
the first place?

What about this patch?

The 2.6 kernel module stuff should sort out the dependencies itself, I
haven't had a chance to test this yet....

Dave.

------=_Part_2550_6765188.1098541698905
Content-Type: text/x-patch; name="new_drm_agp.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="new_drm_agp.patch"

=3D=3D=3D=3D=3D drivers/char/drm/drm_agpsupport.h 1.29 vs edited =3D=3D=3D=
=3D=3D
--- 1.29/drivers/char/drm/drm_agpsupport.h=092004-09-05 09:22:42 +10:00
+++ edited/drivers/char/drm/drm_agpsupport.h=092004-10-24 00:21:46 +10:00
@@ -36,14 +36,6 @@
=20
 #if __OS_HAS_AGP
=20
-#define DRM_AGP_GET (drm_agp_t *)inter_module_get("drm_agp")
-#define DRM_AGP_PUT inter_module_put("drm_agp")
-
-/**
- * Pointer to the drm_agp_t structure made available by the agpgart module=
.
- */
-static const drm_agp_t *drm_agp =3D NULL;
-
 /**
  * AGP information ioctl.
  *
@@ -64,7 +56,7 @@
 =09DRM_AGP_KERN     *kern;
 =09drm_agp_info_t   info;
=20
-=09if (!dev->agp || !dev->agp->acquired || !drm_agp->copy_info)
+=09if (!dev->agp || !dev->agp->acquired)
 =09=09return -EINVAL;
=20
 =09kern                   =3D &dev->agp->agp_info;
@@ -93,7 +85,7 @@
  * \return zero on success or a negative number on failure.=20
  *
  * Verifies the AGP device hasn't been acquired before and calls
- * drm_agp->acquire().
+ * agp_backend_acquire().
  */
 int DRM(agp_acquire)(struct inode *inode, struct file *filp,
 =09=09     unsigned int cmd, unsigned long arg)
@@ -106,9 +98,7 @@
 =09=09return -ENODEV;
 =09if (dev->agp->acquired)
 =09=09return -EBUSY;
-=09if (!drm_agp->acquire)
-=09=09return -EINVAL;
-=09if ((retcode =3D drm_agp->acquire()))
+=09if ((retcode =3D agp_backend_acquire()))
 =09=09return retcode;
 =09dev->agp->acquired =3D 1;
 =09return 0;
@@ -123,7 +113,7 @@
  * \param arg user argument.
  * \return zero on success or a negative number on failure.
  *
- * Verifies the AGP device has been acquired and calls drm_agp->release().
+ * Verifies the AGP device has been acquired and calls agp_backend_release=
().
  */
 int DRM(agp_release)(struct inode *inode, struct file *filp,
 =09=09     unsigned int cmd, unsigned long arg)
@@ -131,9 +121,9 @@
 =09drm_file_t=09 *priv=09 =3D filp->private_data;
 =09drm_device_t=09 *dev=09 =3D priv->dev;
=20
-=09if (!dev->agp || !dev->agp->acquired || !drm_agp->release)
+=09if (!dev->agp || !dev->agp->acquired)
 =09=09return -EINVAL;
-=09drm_agp->release();
+=09agp_backend_release();
 =09dev->agp->acquired =3D 0;
 =09return 0;
=20
@@ -142,12 +132,11 @@
 /**
  * Release the AGP device.
  *
- * Calls drm_agp->release().
+ * Calls agp_backend_release().
  */
 void DRM(agp_do_release)(void)
 {
-=09if (drm_agp->release)
-=09=09drm_agp->release();
+=09agp_backend_release();
 }
=20
 /**
@@ -169,14 +158,14 @@
 =09drm_device_t=09 *dev=09 =3D priv->dev;
 =09drm_agp_mode_t   mode;
=20
-=09if (!dev->agp || !dev->agp->acquired || !drm_agp->enable)
+=09if (!dev->agp || !dev->agp->acquired)
 =09=09return -EINVAL;
=20
 =09if (copy_from_user(&mode, (drm_agp_mode_t __user *)arg, sizeof(mode)))
 =09=09return -EFAULT;
=20
 =09dev->agp->mode    =3D mode.mode;
-=09drm_agp->enable(mode.mode);
+=09agp_enable(mode.mode);
 =09dev->agp->base    =3D dev->agp->agp_info.aper_base;
 =09dev->agp->enabled =3D 1;
 =09return 0;
@@ -325,7 +314,7 @@
 =09int               retcode;
 =09int               page;
=20
-=09if (!dev->agp || !dev->agp->acquired || !drm_agp->bind_memory)
+=09if (!dev->agp || !dev->agp->acquired)
 =09=09return -EINVAL;
 =09if (copy_from_user(&request, (drm_agp_binding_t __user *)arg, sizeof(re=
quest)))
 =09=09return -EFAULT;
@@ -399,25 +388,17 @@
 {
 =09drm_agp_head_t *head         =3D NULL;
=20
-=09drm_agp =3D DRM_AGP_GET;
-=09if (drm_agp) {
-=09=09if (!(head =3D DRM(alloc)(sizeof(*head), DRM_MEM_AGPLISTS)))
-=09=09=09return NULL;
-=09=09memset((void *)head, 0, sizeof(*head));
-=09=09drm_agp->copy_info(&head->agp_info);
-=09=09if (head->agp_info.chipset =3D=3D NOT_SUPPORTED) {
-=09=09=09DRM(free)(head, sizeof(*head), DRM_MEM_AGPLISTS);
-=09=09=09return NULL;
-=09=09}
-=09=09head->memory =3D NULL;
-#if LINUX_VERSION_CODE <=3D 0x020408
-=09=09head->cant_use_aperture =3D 0;
-=09=09head->page_mask =3D ~(0xfff);
-#else
-=09=09head->cant_use_aperture =3D head->agp_info.cant_use_aperture;
-=09=09head->page_mask =3D head->agp_info.page_mask;
-#endif
+=09if (!(head =3D DRM(alloc)(sizeof(*head), DRM_MEM_AGPLISTS)))
+=09=09return NULL;
+=09memset((void *)head, 0, sizeof(*head));
+=09agp_copy_info(&head->agp_info);
+=09if (head->agp_info.chipset =3D=3D NOT_SUPPORTED) {
+=09=09DRM(free)(head, sizeof(*head), DRM_MEM_AGPLISTS);
+=09=09return NULL;
 =09}
+=09head->memory =3D NULL;
+=09head->cant_use_aperture =3D head->agp_info.cant_use_aperture;
+=09head->page_mask =3D head->agp_info.page_mask;
 =09return head;
 }
=20
@@ -428,41 +409,37 @@
  */
 void DRM(agp_uninit)(void)
 {
-=09DRM_AGP_PUT;
-=09drm_agp =3D NULL;
 }
=20
 /** Calls drm_agp->allocate_memory() */
 DRM_AGP_MEM *DRM(agp_allocate_memory)(size_t pages, u32 type)
 {
-=09if (!drm_agp->allocate_memory)
-=09=09return NULL;
-=09return drm_agp->allocate_memory(pages, type);
+=09return agp_allocate_memory(pages, type);
 }
=20
 /** Calls drm_agp->free_memory() */
 int DRM(agp_free_memory)(DRM_AGP_MEM *handle)
 {
-=09if (!handle || !drm_agp->free_memory)
+=09if (!handle)
 =09=09return 0;
-=09drm_agp->free_memory(handle);
+=09agp_free_memory(handle);
 =09return 1;
 }
=20
 /** Calls drm_agp->bind_memory() */
 int DRM(agp_bind_memory)(DRM_AGP_MEM *handle, off_t start)
 {
-=09if (!handle || !drm_agp->bind_memory)
+=09if (!handle)
 =09=09return -EINVAL;
-=09return drm_agp->bind_memory(handle, start);
+=09return agp_bind_memory(handle, start);
 }
=20
 /** Calls drm_agp->unbind_memory() */
 int DRM(agp_unbind_memory)(DRM_AGP_MEM *handle)
 {
-=09if (!handle || !drm_agp->unbind_memory)
+=09if (!handle)
 =09=09return -EINVAL;
-=09return drm_agp->unbind_memory(handle);
+=09return agp_unbind_memory(handle);
 }
=20
 #endif /* __OS_HAS_AGP */

------=_Part_2550_6765188.1098541698905--
