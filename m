Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269380AbUI3SME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269380AbUI3SME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269389AbUI3SMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:12:03 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:47292 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269380AbUI3SKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:10:50 -0400
Message-ID: <9e473391040930111029879e62@mail.gmail.com>
Date: Thu, 30 Sep 2004 14:10:48 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Keith Whitwell <keith@tungstengraphics.com>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Cc: Christoph Hellwig <hch@infradead.org>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <415ABA34.9080608@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_44_32695719.1096567848607"
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <20040929133759.A11891@infradead.org>
	 <415AB8B4.4090408@tungstengraphics.com>
	 <20040929143129.A12651@infradead.org>
	 <415ABA34.9080608@tungstengraphics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_44_32695719.1096567848607
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch removes DRM flush, poll, read functions. It leave the fops entry
null so that the OS default function will be used.

The fops table is converted to be one per driver instead of a global. 
This fixes the module open ref count problem.  It also simplifies
i810/830 by allow them to directly patch their mmap function into the
fops table.

I spent two days looking for a bug in DRM with multiple drivers under
X. I don't think DRM has problems. I see now that X also fails if two
older DRM drivers are loaded. The first problem seems to be the X's
DRM lock refcount varibale is a static. That won't work for two DRM
drivers.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_44_32695719.1096567848607
Content-Type: text/x-patch; name="open.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="open.patch"

=3D=3D=3D=3D=3D linux-core/drmP.h 1.2 vs edited =3D=3D=3D=3D=3D
--- 1.2/linux-core/drmP.h=092004-09-28 18:26:13 -04:00
+++ edited/linux-core/drmP.h=092004-09-30 13:34:40 -04:00
@@ -523,11 +523,6 @@
 struct drm_device;
=20
 struct drm_driver_fn {
-=09u32 driver_features;
-=09int dev_priv_size;
-=09int permanent_maps;
-=09drm_ioctl_desc_t *ioctls;
-=09int num_ioctls;
 =09int (*preinit)(struct drm_device *, unsigned long flags);
 =09void (*prerelease)(struct drm_device *, struct file *filp);
 =09void (*pretakedown)(struct drm_device *);
@@ -558,6 +553,13 @@
 =09unsigned long (*get_reg_ofs)(struct drm_device *dev);
 =09void (*set_version)(struct drm_device *dev, drm_set_version_t *sv);
 =09int (*version)(drm_version_t *version);
+/* variables */
+=09u32 driver_features;
+=09int dev_priv_size;
+=09int permanent_maps;
+=09drm_ioctl_desc_t *ioctls;
+=09int num_ioctls;
+=09struct file_operations fops;
 };
=20
=20
@@ -691,8 +693,6 @@
 =09drm_sigdata_t     sigdata;=09/**< For block_all_signals */
 =09sigset_t          sigmask;
 =09
-=09struct file_operations *fops;=09/**< file operations */
-
 =09struct drm_driver_fn *fn_tbl;
 =09drm_local_map_t   *agp_buffer_map;
 } drm_device_t;
@@ -757,13 +757,11 @@
 extern int =09     drm_fill_in_dev(drm_device_t *dev, struct pci_dev *pdev=
,
 =09=09=09=09 const struct pci_device_id *ent, struct drm_driver_fn *driver=
_fn);
 extern int           drm_fb_loaded;
-extern struct file_operations drm_fops;
=20
 =09=09=09=09/* Device support (drm_fops.h) */
 extern int=09     drm_open_helper(struct inode *inode, struct file *filp,
 =09=09=09=09      drm_device_t *dev);
-extern int=09     drm_flush(struct file *filp);
-extern int=09     drm_fasync(int fd, struct file *filp, int on);
+extern int =09     drm_fasync(int fd, struct file *filp, int on);
=20
 =09=09=09=09/* Mapping support (drm_vm.h) */
 extern void=09     drm_vm_open(struct vm_area_struct *vma);
@@ -772,8 +770,6 @@
 extern int=09     drm_mmap_dma(struct file *filp,
 =09=09=09=09   struct vm_area_struct *vma);
 extern int=09     drm_mmap(struct file *filp, struct vm_area_struct *vma);
-extern unsigned int  drm_poll(struct file *filp, struct poll_table_struct =
*wait);
-extern ssize_t       drm_read(struct file *filp, char __user *buf, size_t =
count, loff_t *off);
=20
 =09=09=09=09/* Memory management support (drm_memory.h) */
 #include "drm_memory.h"
=3D=3D=3D=3D=3D linux-core/drm_drv.c 1.2 vs edited =3D=3D=3D=3D=3D
--- 1.2/linux-core/drm_drv.c=092004-09-28 18:26:13 -04:00
+++ edited/linux-core/drm_drv.c=092004-09-30 13:34:40 -04:00
@@ -76,18 +76,6 @@
=20
 int drm_fb_loaded =3D 0;
=20
-struct file_operations=09drm_fops =3D {
-=09.owner   =3D THIS_MODULE,
-=09.open=09 =3D drm_open,
-=09.flush=09 =3D drm_flush,
-=09.release =3D drm_release,
-=09.ioctl=09 =3D drm_ioctl,
-=09.mmap=09 =3D drm_mmap,
-=09.fasync  =3D drm_fasync,
-=09.poll=09 =3D drm_poll,
-=09.read=09 =3D drm_read,
-};
-
 /** Ioctl table */
 drm_ioctl_desc_t=09=09  drm_ioctls[] =3D {
 =09[DRM_IOCTL_NR(DRM_IOCTL_VERSION)]       =3D { drm_version,     0, 0 },
@@ -384,7 +372,6 @@
 =09sema_init( &dev->ctxlist_sem, 1 );
=20
 =09dev->name   =3D DRIVER_NAME;
-=09dev->fops   =3D &drm_fops;
 =09dev->pdev   =3D pdev;
=20
 #ifdef __alpha__
@@ -630,7 +617,7 @@
 =09=09=09minor =3D &drm_minors[i];
 =09=09=09dev =3D minor->dev;
 =09=09=09DRM_DEBUG("fb loaded release minor %d\n", dev->minor);
-=09=09=09if ((minor->class =3D=3D DRM_MINOR_PRIMARY) && (dev->fops =3D=3D =
&drm_fops)) {
+=09=09=09if (minor->class =3D=3D DRM_MINOR_PRIMARY) {
 =09=09=09=09/* release the pci driver */
 =09=09=09=09if (dev->pdev)
 =09=09=09=09=09pci_dev_put(dev->pdev);
=3D=3D=3D=3D=3D linux-core/drm_fops.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/drm_fops.c=092004-09-28 13:03:33 -04:00
+++ edited/linux-core/drm_fops.c=092004-09-30 13:56:18 -04:00
@@ -116,18 +116,6 @@
 }
=20
 /** No-op. */
-int drm_flush(struct file *filp)
-{
-=09drm_file_t    *priv   =3D filp->private_data;
-=09drm_device_t  *dev    =3D priv->dev;
-
-=09DRM_DEBUG("pid =3D %d, device =3D 0x%lx, open_count =3D %d\n",
-=09=09  current->pid, (long)old_encode_dev(dev->device), dev->open_count);
-=09return 0;
-}
-EXPORT_SYMBOL(drm_flush);
-
-/** No-op. */
 int drm_fasync(int fd, struct file *filp, int on)
 {
 =09drm_file_t    *priv   =3D filp->private_data;
@@ -140,16 +128,3 @@
 =09return 0;
 }
 EXPORT_SYMBOL(drm_fasync);
-
-/** No-op. */
-unsigned int drm_poll(struct file *filp, struct poll_table_struct *wait)
-{
-=09return 0;
-}
-
-
-/** No-op. */
-ssize_t drm_read(struct file *filp, char __user *buf, size_t count, loff_t=
 *off)
-{
-=09return 0;
-}
=3D=3D=3D=3D=3D linux-core/drm_stub.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/drm_stub.c=092004-09-28 13:03:33 -04:00
+++ edited/linux-core/drm_stub.c=092004-09-30 13:13:25 -04:00
@@ -77,7 +77,7 @@
 =09=09return -ENODEV;
=20
 =09old_fops =3D filp->f_op;
-=09filp->f_op =3D fops_get(dev->fops);
+=09filp->f_op =3D fops_get(&dev->fn_tbl->fops);
 =09if (filp->f_op->open && (err =3D filp->f_op->open(inode, filp))) {
 =09=09fops_put(filp->f_op);
 =09=09filp->f_op =3D fops_get(old_fops);
=3D=3D=3D=3D=3D linux-core/drm_vm.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/drm_vm.c=092004-09-28 13:03:33 -04:00
+++ edited/linux-core/drm_vm.c=092004-09-30 13:17:13 -04:00
@@ -670,3 +670,4 @@
 =09drm_vm_open(vma);
 =09return 0;
 }
+EXPORT_SYMBOL(drm_mmap);
=3D=3D=3D=3D=3D linux-core/ffb_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/ffb_drv.c=092004-09-28 13:03:33 -04:00
+++ edited/linux-core/ffb_drv.c=092004-09-30 13:34:41 -04:00
@@ -321,6 +321,14 @@
 =09.reclaim_buffers =3D drm_core_reclaim_buffers,
 =09.postinit =3D postinit,
 =09.version =3D version,
+=09fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/i810_dma.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/i810_dma.c=092004-09-28 13:03:33 -04:00
+++ edited/linux-core/i810_dma.c=092004-09-30 13:19:46 -04:00
@@ -109,15 +109,6 @@
    =09return 0;
 }
=20
-static struct file_operations i810_buffer_fops =3D {
-=09.open=09 =3D drm_open,
-=09.flush=09 =3D drm_flush,
-=09.release =3D drm_release,
-=09.ioctl=09 =3D drm_ioctl,
-=09.mmap=09 =3D i810_mmap_buffers,
-=09.fasync  =3D drm_fasync,
-};
-
 int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
 {
 =09drm_file_t=09    *priv=09  =3D filp->private_data;
@@ -151,22 +142,19 @@
 =09drm_device_t=09  *dev=09  =3D priv->dev;
 =09drm_i810_buf_priv_t *buf_priv =3D buf->dev_private;
       =09drm_i810_private_t *dev_priv =3D dev->dev_private;
-   =09struct file_operations *old_fops;
 =09int retcode =3D 0;
=20
 =09if (buf_priv->currently_mapped =3D=3D I810_BUF_MAPPED)=20
 =09=09return -EINVAL;
=20
 =09down_write( &current->mm->mmap_sem );
-=09old_fops =3D filp->f_op;
-=09filp->f_op =3D &i810_buffer_fops;
 =09dev_priv->mmap_buffer =3D buf;
 =09buf_priv->virtual =3D (void *)do_mmap(filp, 0, buf->total,
 =09=09=09=09=09    PROT_READ|PROT_WRITE,
 =09=09=09=09=09    MAP_SHARED,
 =09=09=09=09=09    buf->bus_address);
 =09dev_priv->mmap_buffer =3D NULL;
-=09filp->f_op =3D old_fops;
+
 =09if ((unsigned long)buf_priv->virtual > -1024UL) {
 =09=09/* Real error */
 =09=09DRM_ERROR("mmap error\n");
=3D=3D=3D=3D=3D linux-core/i810_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/i810_drv.c=092004-09-28 13:03:33 -04:00
+++ edited/linux-core/i810_drv.c=092004-09-30 13:34:40 -04:00
@@ -107,6 +107,14 @@
 =09.version =3D version,
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D i810_mmap_buffers,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/i830_dma.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/i830_dma.c=092004-09-28 13:03:33 -04:00
+++ edited/linux-core/i830_dma.c=092004-09-30 13:20:41 -04:00
@@ -110,15 +110,6 @@
    =09return 0;
 }
=20
-static struct file_operations i830_buffer_fops =3D {
-=09.open=09 =3D drm_open,
-=09.flush=09 =3D drm_flush,
-=09.release =3D drm_release,
-=09.ioctl=09 =3D drm_ioctl,
-=09.mmap=09 =3D i830_mmap_buffers,
-=09.fasync  =3D drm_fasync,
-};
-
 int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
 {
 =09drm_file_t=09    *priv=09  =3D filp->private_data;
@@ -152,20 +143,17 @@
 =09drm_device_t=09  *dev=09  =3D priv->dev;
 =09drm_i830_buf_priv_t *buf_priv =3D buf->dev_private;
       =09drm_i830_private_t *dev_priv =3D dev->dev_private;
-   =09struct file_operations *old_fops;
 =09unsigned long virtual;
 =09int retcode =3D 0;
=20
 =09if(buf_priv->currently_mapped =3D=3D I830_BUF_MAPPED) return -EINVAL;
=20
 =09down_write( &current->mm->mmap_sem );
-=09old_fops =3D filp->f_op;
-=09filp->f_op =3D &i830_buffer_fops;
 =09dev_priv->mmap_buffer =3D buf;
 =09virtual =3D do_mmap(filp, 0, buf->total, PROT_READ|PROT_WRITE,
 =09=09=09    MAP_SHARED, buf->bus_address);
 =09dev_priv->mmap_buffer =3D NULL;
-=09filp->f_op =3D old_fops;
+
 =09if (IS_ERR((void *)virtual)) {=09=09/* ugh */
 =09=09/* Real error */
 =09=09DRM_ERROR("mmap error\n");
=3D=3D=3D=3D=3D linux-core/i830_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/i830_drv.c=092004-09-28 13:03:33 -04:00
+++ edited/linux-core/i830_drv.c=092004-09-30 13:34:40 -04:00
@@ -116,6 +116,14 @@
 =09.version =3D version,
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D i830_mmap_buffers,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/i915_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/i915_drv.c=092004-09-28 13:03:34 -04:00
+++ edited/linux-core/i915_drv.c=092004-09-30 13:34:40 -04:00
@@ -83,6 +83,14 @@
 =09.version =3D version,
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/mach64_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/mach64_drv.c=092004-09-28 13:03:34 -04:00
+++ edited/linux-core/mach64_drv.c=092004-09-30 13:34:40 -04:00
@@ -99,6 +99,14 @@
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
 =09.dma_ioctl =3D mach64_dma_buffers,
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/mga_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/mga_drv.c=092004-09-28 13:03:34 -04:00
+++ edited/linux-core/mga_drv.c=092004-09-30 13:34:40 -04:00
@@ -103,6 +103,14 @@
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
 =09.dma_ioctl =3D mga_dma_buffers,
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/r128_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/r128_drv.c=092004-09-28 13:03:34 -04:00
+++ edited/linux-core/r128_drv.c=092004-09-30 13:34:40 -04:00
@@ -113,6 +113,14 @@
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
 =09.dma_ioctl =3D r128_cce_buffers,
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/radeon_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/radeon_drv.c=092004-09-28 13:03:34 -04:00
+++ edited/linux-core/radeon_drv.c=092004-09-30 13:34:40 -04:00
@@ -154,6 +154,14 @@
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
 =09.dma_ioctl =3D radeon_cp_buffers,
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/savage_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/savage_drv.c=092004-09-28 13:03:34 -04:00
+++ edited/linux-core/savage_drv.c=092004-09-30 13:34:41 -04:00
@@ -292,6 +292,14 @@
 =09.version =3D version,
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/sis_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/sis_drv.c=092004-09-28 13:03:34 -04:00
+++ edited/linux-core/sis_drv.c=092004-09-30 13:34:41 -04:00
@@ -83,6 +83,14 @@
 =09.version =3D version,
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D linux-core/tdfx_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/linux-core/tdfx_drv.c=092004-09-28 13:03:34 -04:00
+++ edited/linux-core/tdfx_drv.c=092004-09-30 13:34:41 -04:00
@@ -74,6 +74,14 @@
 =09.get_reg_ofs =3D drm_core_get_reg_ofs,
 =09.postinit =3D postinit,
 =09.version =3D version,
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
=3D=3D=3D=3D=3D shared-core/via_drv.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/shared-core/via_drv.c=092004-09-28 13:03:34 -04:00
+++ edited/shared-core/via_drv.c=092004-09-30 13:34:41 -04:00
@@ -99,6 +99,14 @@
 =09.version =3D version,
 =09.ioctls =3D ioctls,
 =09.num_ioctls =3D DRM_ARRAY_SIZE(ioctls),
+=09.fops =3D {
+=09=09.owner   =3D THIS_MODULE,
+=09=09.open=09 =3D drm_open,
+=09=09.release =3D drm_release,
+=09=09.ioctl=09 =3D drm_ioctl,
+=09=09.mmap=09 =3D drm_mmap,
+=09=09.fasync  =3D drm_fasync,
+=09},
 };
=20
 static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)

------=_Part_44_32695719.1096567848607--
