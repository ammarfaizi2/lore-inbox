Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263121AbSJBQEp>; Wed, 2 Oct 2002 12:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263127AbSJBQEp>; Wed, 2 Oct 2002 12:04:45 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:7592 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S263121AbSJBQEl>; Wed, 2 Oct 2002 12:04:41 -0400
Date: Wed, 2 Oct 2002 11:10:06 -0500
From: Bob McElrath <bob+linux-kernel@mcelrath.org>
To: linux-kernel@vger.kernel.org
Subject: NVIDIA binary-only driver patch for 2.5.40
Message-ID: <20021002161006.GM25319@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DH4/xewco2zMcht6"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DH4/xewco2zMcht6
Content-Type: multipart/mixed; boundary="LJm8egi4vkexsie5"
Content-Disposition: inline


--LJm8egi4vkexsie5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here is an updated patch to the binary-only drivers provided by NVIDIA
(version 1.0-3123) for kernel 2.5.40.  I have tested it for both 2D and
3D and it seems to work fine.  (Warcraft III under linux 2.5.40 should
be a good enough test, no?)

I have not tested their NVAGP under 2.5.40.  If in doubt use the
kernel's agpgart driver and:
    Option "NvAGP" "2"
to tell the NVIDIA driver not to use its internal NVAGP driver.

This patch is based on a patch previously posted by Roberto Nibali.  I
place my contributions to this patch under the GPL.  NVIDIA may not use
this code without prior written consent from me.

Cheers,
-- Bob

Bob McElrath (bob+linux-kernel@mcelrath.org)=20
Univ. of Wisconsin at Madison, Department of Physics

    "The purpose of separation of church and state is to keep forever from
    these shores the ceaseless strife that has soaked the soil of Europe in
    blood for centuries." -- James Madison


--LJm8egi4vkexsie5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nvidia.2.5.40.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur NVIDIA_kernel-1.0-3123/nv-linux.h NVIDIA_kernel-1.0-3123.bob/nv-li=
nux.h
--- NVIDIA_kernel-1.0-3123/nv-linux.h	Tue Aug 27 18:36:53 2002
+++ NVIDIA_kernel-1.0-3123.bob/nv-linux.h	Wed Oct  2 10:25:19 2002
@@ -36,11 +36,6 @@
 #  error This driver does not support 2.3.x development kernels!
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
 #  define KERNEL_2_4
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
-#  error This driver does not support 2.5.x development kernels!
-#  define KERNEL_2_5
-#else
-#  error This driver does not support 2.6.x or newer kernels!
 #endif
=20
 #if defined (CONFIG_SMP) && !defined (__SMP__)
diff -ur NVIDIA_kernel-1.0-3123/nv.c NVIDIA_kernel-1.0-3123.bob/nv.c
--- NVIDIA_kernel-1.0-3123/nv.c	Tue Aug 27 18:36:52 2002
+++ NVIDIA_kernel-1.0-3123.bob/nv.c	Wed Oct  2 10:47:03 2002
@@ -1068,11 +1068,22 @@
=20
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
+
+    /* I don't really know the correct kernel version since when it change=
d */=20
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)=20
     if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
         return nv_kern_ctl_open(inode, file);
-
+#else
+    if (NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
+        return nv_kern_ctl_open(inode, file);
+#endif
     /* what device are we talking about? */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     devnum =3D NV_DEVICE_NUMBER(inode->i_rdev);
+#else
+    devnum =3D NV_DEVICE_NUMBER(kdev_val(inode->i_rdev));
+#endif
     if (devnum >=3D NV_MAX_DEVICES)
     {
         rc =3D -ENODEV;
@@ -1178,9 +1189,14 @@
=20
     /* for control device, just jump to its open routine */
     /* after setting up the private data */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     if (NV_DEVICE_IS_CONTROL_DEVICE(inode->i_rdev))
+       return nv_kern_ctl_close(inode, file);
+#else
+    if(NV_DEVICE_IS_CONTROL_DEVICE(kdev_val(inode->i_rdev)))
         return nv_kern_ctl_close(inode, file);
-
+#endif
     NV_DMSG(nv, "close");
=20
     rm_free_unused_clients(nv, current->pid, (void *) file);
@@ -1299,11 +1315,21 @@
 #if defined(NVCPU_IA64)
         vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
 #endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
         if (remap_page_range(vma->vm_start,
                              (u32)(nv->regs.address) + LINUX_VMA_OFFS(vma)=
 - NV_MMAP_REG_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
+#else
+        if (remap_page_range(vma,
+                            vma->vm_start,
+                             (u32) (nv->regs.address) + LINUX_VMA_OFFS(vma=
) - NV_MMAP_REG_OFFSET,
+                             vma->vm_end - vma->vm_start,
+                             vma->vm_page_prot))
+            return -EAGAIN;
+#endif
=20
         /* mark it as IO so that we don't dump it on core dump */
         vma->vm_flags |=3D VM_IO;
@@ -1316,11 +1342,20 @@
 #if defined(NVCPU_IA64)
         vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
 #endif
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
         if (remap_page_range(vma->vm_start,
                              (u32)(nv->fb.address) + LINUX_VMA_OFFS(vma) -=
 NV_MMAP_FB_OFFSET,
                              vma->vm_end - vma->vm_start,
                              vma->vm_page_prot))
             return -EAGAIN;
+#else
+        if (remap_page_range(vma,
+                            vma->vm_start,
+                             (u32) (nv->fb.address) + LINUX_VMA_OFFS(vma) =
- NV_MMAP_FB_OFFSET,
+                             vma->vm_end - vma->vm_start,
+                             vma->vm_page_prot))
+            return -EAGAIN;
+#endif
=20
         // mark it as IO so that we don't dump it on core dump
         vma->vm_flags |=3D VM_IO;
@@ -1350,8 +1385,13 @@
         while (pages--)
         {
             page =3D (unsigned long) at->page_table[i++];
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
             if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
               	return -EAGAIN;
+#else
+            if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+                 return -EAGAIN;
+#endif
             start +=3D PAGE_SIZE;
             pos +=3D PAGE_SIZE;
        	}
@@ -1627,8 +1667,12 @@
         nv_lock_bh(nv);
         nv->bh_count++;
         nvl->bh->data =3D nv->pdev;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
         queue_task(nvl->bh, &tq_immediate);
         mark_bh(IMMEDIATE_BH);
+#else
+        schedule_task(nvl->bh);
+#endif
         nv_unlock_bh(nv);
     }
 }
@@ -2179,7 +2223,11 @@
     pte_kunmap(pte__);
 #else
     pte__ =3D NULL;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
     pte =3D *pte_offset(pg_mid_dir, address);
+#else
+    pte =3D *pte_offset_map(pg_mid_dir, address);
+#endif
 #endif
=20
     if (!pte_present(pte))=20
diff -ur NVIDIA_kernel-1.0-3123/os-interface.c NVIDIA_kernel-1.0-3123.bob/o=
s-interface.c
--- NVIDIA_kernel-1.0-3123/os-interface.c	Tue Aug 27 18:36:52 2002
+++ NVIDIA_kernel-1.0-3123.bob/os-interface.c	Wed Oct  2 10:25:19 2002
@@ -27,7 +27,10 @@
=20
 BOOL os_is_administrator(PHWINFO pDev)
 {
-    return suser();
+    /* Actually suser() wasn't really a bool, but since the
+       nvidia guys want it as a bool, let's give them a bool.
+    */
+    return (!capable(CAP_SYS_ADMIN)?1:0);
 }
=20
 U032 os_get_page_size(VOID)
@@ -1141,9 +1144,14 @@
     uaddr =3D *priv;
=20
     /* finally, let's do it! */
-    err =3D remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes,=
=20
+   =20
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
+    err =3D remap_page_range( (size_t) uaddr, (size_t) paddr, size_bytes,
+                           PAGE_SHARED);
+#else
+    err =3D remap_page_range( kaddr, (size_t) uaddr, (size_t) paddr, size_=
bytes,
                             PAGE_SHARED);
-
+#endif
     if (err !=3D 0)
     {
         return (void *) NULL;
@@ -1176,10 +1184,14 @@
=20
     uaddr =3D *priv;
=20
-    /* finally, let's do it! */
-    err =3D remap_page_range( (size_t) uaddr, (size_t) start, size_bytes,=
=20
+    /* finally, let's do it! */=20
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
+    err =3D remap_page_rage( (size_t) uaddr, (size_t) start, size_bytes,
+                          PAGE_SHARED);   =20
+#else
+    err =3D remap_page_range( *priv, (size_t) uaddr, (size_t) start, size_=
bytes,=20
                             PAGE_SHARED);
-
+#endif
     if (err !=3D 0)
     {
         return (void *) NULL;
@@ -1593,7 +1605,8 @@
=20
     agp_addr =3D agpinfo.aper_base + (agp_data->offset << PAGE_SHIFT);
=20
-    err =3D remap_page_range(vma->vm_start, (size_t) agp_addr,=20
+    err =3D remap_page_range(vma,
+			   vma->vm_start, (size_t) agp_addr,=20
                            agp_data->num_pages << PAGE_SHIFT,
 #if defined(NVCPU_IA64)
                            vma->vm_page_prot);

--LJm8egi4vkexsie5--

--DH4/xewco2zMcht6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2bGl4ACgkQjwioWRGe9K0x4QCgrp35HI/1/gmlx9cEWS3/lePm
Xw8AoN7Lrj/SxAkRw76l8wwB5Gs0slqB
=/Njk
-----END PGP SIGNATURE-----

--DH4/xewco2zMcht6--
