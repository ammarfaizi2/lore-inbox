Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVAZAG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVAZAG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVAZAFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:05:14 -0500
Received: from smtp09.auna.com ([62.81.186.19]:7878 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262249AbVAZACx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:02:53 -0500
Date: Wed, 26 Jan 2005 00:02:51 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: patch to enable Nvidia v5336 on v2.6.11 kernel (was Re:
 inter_module_get and __symbol_get)
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Cc: davidm@hpl.hp.com, Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <16885.32149.788747.550216@napali.hpl.hp.com>
	<31612.1106607781@ocs3.ocs.com.au>
	<16885.38947.35646.558780@napali.hpl.hp.com>
	<1106657785l.6979l.0l@werewolf.able.es>
	<20050125205046.GA19738@babylon.d2dc.net>
In-Reply-To: <20050125205046.GA19738@babylon.d2dc.net> (from
	warp@babylon.d2dc.net on Tue Jan 25 21:50:47 2005)
X-Mailer: Balsa 2.2.6
Message-Id: <1106697771l.5485l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-wuhTm6sdPF9Pn4Y8Inxd"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-wuhTm6sdPF9Pn4Y8Inxd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.01.25, Zephaniah E. Hull wrote:
> On Tue, Jan 25, 2005 at 12:56:25PM +0000, J.A. Magallon wrote:
> <snip>
> > You can use the latest drivers (6629) with this patches:
> >=20
> > http://www.minion.de/files/1.0-6629/
> >=20
> > They work fine up to -rc2.
> >=20
> > If you want to use the driver with -mm, you have to kill the support
> > for AGPGART in nvidia driver, add -DNOAGPGART to EXTRA_CFLAGS in the
> > makefile. It will require a big change to use the multi-agp patches
> > in -mm. But you are restricted to those AGPs supported by nvidia
> > (ah, and don't load any agp related module...).
>=20
> For values of big changes that equal the attached patch.
>=20
> I'm using it on 2.6.10-mm3.  I sent it to Zander however since there is
> no way to detect the new multi-agp support barring some sick hacks it
> has not gone in.
>=20
> It may conflict with the support for the 2.6.11-rc kernels, in which
> case when I next upgrade I'll find out and write a new one.
> >=20
> > Ah, just a ton of workarounds....
>=20

Hay, that gave me the clues I was missing !!!
With patch below, I get 6629 working on 2.6.10-rc2-mm1. Apply it on top of
all the patches in the link above.

I know, it is ugly as hell (all those superfluos parameters in NV_AGPGART
macros, unused drm_agp_p...), but perhaps someone  will rework all that
macro mesh. For the moment, it works....

diff -ruN nv-6629-jam/src/nv/nv-linux.h nv-6629-jam-2/src/nv/nv-linux.h
--- nv-6629-jam/src/nv/nv-linux.h	2005-01-24 23:16:46.000000000 +0100
+++ nv-6629-jam-2/src/nv/nv-linux.h	2005-01-26 00:25:10.000000000 +0100
@@ -930,6 +930,9 @@
=20
     /* lock for linux-specific alloc queue */
     struct semaphore at_lock;
+
+	/* AGP bridge handle */
+	struct agp_bridge_data *agp_bridge;
 } nv_linux_state_t;
=20
=20
diff -ruN nv-6629-jam/src/nv/nv.c nv-6629-jam-2/src/nv/nv.c
--- nv-6629-jam/src/nv/nv.c	2005-01-24 23:16:46.000000000 +0100
+++ nv-6629-jam-2/src/nv/nv.c	2005-01-26 00:47:14.000000000 +0100
@@ -3011,10 +3011,11 @@
             return -1;
         }
 #elif defined(AGPGART)
-        int error;
-        if ((error =3D agp_backend_acquire()) !=3D -EINVAL)
+		nv_linux_state_t *nvl =3D NV_GET_NVL_FROM_NV_STATE(nv);
+		nvl->agp_bridge =3D agp_backend_acquire(nvl->dev);
+        if (nvl->agp_bridge)
         {
-            if (!error) agp_backend_release();
+            agp_backend_release(nvl->agp_bridge);
             nv_printf(NV_DBG_WARNINGS,
                       "NVRM: not using NVAGP, an AGPGART backend is loaded=
!\n");
             return -1;
diff -ruN nv-6629-jam/src/nv/os-agp.c nv-6629-jam-2/src/nv/os-agp.c
--- nv-6629-jam/src/nv/os-agp.c	2005-01-24 23:16:46.000000000 +0100
+++ nv-6629-jam-2/src/nv/os-agp.c	2005-01-26 00:49:01.000000000 +0100
@@ -60,23 +60,23 @@
 #endif
=20
 #if defined(KERNEL_2_6)
-#define NV_AGPGART_BACKEND_ACQUIRE(o) agp_backend_acquire()
-#define NV_AGPGART_BACKEND_ENABLE(o,mode) agp_enable(mode)
-#define NV_AGPGART_BACKEND_RELEASE(o) agp_backend_release()
-#define NV_AGPGART_COPY_INFO(o,p) agp_copy_info(p)
-#define NV_AGPGART_ALLOCATE_MEMORY(o,count,type) agp_allocate_memory(count=
,type)
-#define NV_AGPGART_FREE_MEMORY(o,p) agp_free_memory(p)
-#define NV_AGPGART_BIND_MEMORY(o,p,offset) agp_bind_memory(p,offset)
-#define NV_AGPGART_UNBIND_MEMORY(o,p) agp_unbind_memory(p)
+#define NV_AGPGART_BACKEND_ACQUIRE(nvl,o) ({ nvl->agp_bridge =3D agp_backe=
nd_acquire(nvl->dev); !nvl->agp_bridge; })
+#define NV_AGPGART_BACKEND_ENABLE(nvl,o,mode) agp_enable(nvl->agp_bridge,m=
ode)
+#define NV_AGPGART_BACKEND_RELEASE(nvl,o) agp_backend_release(nvl->agp_bri=
dge)
+#define NV_AGPGART_COPY_INFO(nvl,o,p) agp_copy_info(nvl->agp_bridge,p)
+#define NV_AGPGART_ALLOCATE_MEMORY(nvl,o,count,type) agp_allocate_memory(n=
vl->agp_bridge,count,type)
+#define NV_AGPGART_FREE_MEMORY(nvl,o,p) agp_free_memory(p)
+#define NV_AGPGART_BIND_MEMORY(nvl,o,p,offset) agp_bind_memory(p,offset)
+#define NV_AGPGART_UNBIND_MEMORY(nvl,o,p) agp_unbind_memory(p)
 #elif defined(KERNEL_2_4)
-#define NV_AGPGART_BACKEND_ACQUIRE(o) ({ (o)->acquire(); 0; })
-#define NV_AGPGART_BACKEND_ENABLE(o,mode) (o)->enable(mode)
-#define NV_AGPGART_BACKEND_RELEASE(o) ((o)->release())
-#define NV_AGPGART_COPY_INFO(o,p) ({ (o)->copy_info(p); 0; })
-#define NV_AGPGART_ALLOCATE_MEMORY(o,count,type) (o)->allocate_memory(coun=
t,type)
-#define NV_AGPGART_FREE_MEMORY(o,p) (o)->free_memory(p)
-#define NV_AGPGART_BIND_MEMORY(o,p,offset) (o)->bind_memory(p,offset)
-#define NV_AGPGART_UNBIND_MEMORY(o,p) (o)->unbind_memory(p)
+#define NV_AGPGART_BACKEND_ACQUIRE(nvl,o) ({ (o)->acquire(); 0; })
+#define NV_AGPGART_BACKEND_ENABLE(nvl,o,mode) (o)->enable(mode)
+#define NV_AGPGART_BACKEND_RELEASE(nvl,o) ((o)->release())
+#define NV_AGPGART_COPY_INFO(nvl,o,p) ({ (o)->copy_info(p); 0; })
+#define NV_AGPGART_ALLOCATE_MEMORY(nvl,o,count,type) (o)->allocate_memory(=
count,type)
+#define NV_AGPGART_FREE_MEMORY(nvl,o,p) (o)->free_memory(p)
+#define NV_AGPGART_BIND_MEMORY(nvl,o,p,offset) (o)->bind_memory(p,offset)
+#define NV_AGPGART_UNBIND_MEMORY(nvl,o,p) (o)->unbind_memory(p)
 #endif
=20
 #endif /* AGPGART */
@@ -96,6 +96,7 @@
     U032  agp_fw;
     void *bitmap;
     U032 bitmap_size;
+	nv_linux_state_t *nvl =3D NV_GET_NVL_FROM_NV_STATE(nv);
=20
     memset( (void *) &gart, 0, sizeof(agp_gart));
=20
@@ -110,7 +111,7 @@
      * the memory controller.
      */
=20
-    if (NV_AGPGART_BACKEND_ACQUIRE(drm_agp_p))
+    if (NV_AGPGART_BACKEND_ACQUIRE(nvl,drm_agp_p))
     {
         nv_printf(NV_DBG_INFO, "NVRM: AGPGART: no backend available\n");
         goto bailout;
@@ -128,7 +129,7 @@
         agp_fw =3D 1;
     agp_fw &=3D 0x00000001;
=20
-    if (NV_AGPGART_COPY_INFO(drm_agp_p, &agpinfo))
+    if (NV_AGPGART_COPY_INFO(nvl,drm_agp_p, &agpinfo))
     {
         nv_printf(NV_DBG_ERRORS,
             "NVRM: AGPGART: kernel reports chipset as unsupported\n");
@@ -188,7 +189,7 @@
     if (!(agp_rate & 0x00000004)) agpinfo.mode &=3D ~0x00000004;
     if (!(agp_rate & 0x00000002)) agpinfo.mode &=3D ~0x00000002;
    =20
-    NV_AGPGART_BACKEND_ENABLE(drm_agp_p, agpinfo.mode);
+    NV_AGPGART_BACKEND_ENABLE(nvl,drm_agp_p, agpinfo.mode);
=20
     *ap_phys_base   =3D (void*) agpinfo.aper_base;
     *ap_mapped_base =3D (void*) gart.aperture;
@@ -200,7 +201,7 @@
=20
 failed:
     MTRR_DEL(gart); /* checks gart.mtrr */
-    NV_AGPGART_BACKEND_RELEASE(drm_agp_p);
+    NV_AGPGART_BACKEND_RELEASE(nvl,drm_agp_p);
 bailout:
 #if defined(KERNEL_2_4)
     inter_module_put("drm_agp");
@@ -219,6 +220,7 @@
     return 1;
 #else
     void *bitmap;
+	nv_linux_state_t *nvl;
=20
     /* sanity check to make sure we should actually be here. */
     if (!gart.ready)
@@ -234,7 +236,8 @@
         NV_IOUNMAP(gart.aperture, RM_PAGE_SIZE);
     }
=20
-    NV_AGPGART_BACKEND_RELEASE(drm_agp_p);
+	nvl =3D NV_GET_NVL_FROM_NV_STATE(nv);
+	NV_AGPGART_BACKEND_RELEASE(nvl,drm_agp_p);
 #if defined(KERNEL_2_4)
     inter_module_put("drm_agp");
 #endif
@@ -268,6 +271,7 @@
     agp_memory *ptr;
     agp_priv_data *data;
     RM_STATUS status;
+	nv_linux_state_t *nvl;
=20
     if (!gart.ready)
     {
@@ -283,7 +287,8 @@
         return RM_ERROR;
     }
=20
-    ptr =3D NV_AGPGART_ALLOCATE_MEMORY(drm_agp_p, PageCount, AGP_NORMAL_ME=
MORY);
+	nvl =3D NV_GET_NVL_FROM_NV_STATE(nv);
+    ptr =3D NV_AGPGART_ALLOCATE_MEMORY(nvl,drm_agp_p, PageCount, AGP_NORMA=
L_MEMORY);
     if (ptr =3D=3D NULL)
     {
         *pAddress =3D (void*) 0;
@@ -291,7 +296,7 @@
         return RM_ERR_NO_FREE_MEM;
     }
    =20
-    if (NV_AGPGART_BIND_MEMORY(drm_agp_p, ptr, *Offset))
+    if (NV_AGPGART_BIND_MEMORY(nvl,drm_agp_p, ptr, *Offset))
     {
         // this happens a lot when the aperture itself fills up..
         // not a big deal, so don't alarm people with an error message
@@ -304,7 +309,7 @@
     if (status !=3D RM_OK)
     {
         nv_printf(NV_DBG_ERRORS, "NVRM: AGPGART: memory allocation failed\=
n");
-        NV_AGPGART_UNBIND_MEMORY(drm_agp_p, ptr);
+        NV_AGPGART_UNBIND_MEMORY(nvl,drm_agp_p, ptr);
         goto fail;
     }
=20
@@ -319,7 +324,7 @@
     return RM_OK;
=20
 fail:
-    NV_AGPGART_FREE_MEMORY(drm_agp_p, ptr);
+    NV_AGPGART_FREE_MEMORY(nvl,drm_agp_p, ptr);
     *pAddress =3D (void*) 0;
=20
     return RM_ERROR;
@@ -359,7 +364,7 @@
     {
         nv_printf(NV_DBG_ERRORS, "NVRM: AGPGART: unable to remap %lu pages=
\n",
             (unsigned long)agp_data->num_pages);
-        NV_AGPGART_UNBIND_MEMORY(drm_agp_p, agp_data->ptr);
+        NV_AGPGART_UNBIND_MEMORY(nvl,drm_agp_p, agp_data->ptr);
         goto fail;
     }
    =20
@@ -458,8 +463,8 @@
     {
         size_t pages =3D ptr->page_count;
=20
-        NV_AGPGART_UNBIND_MEMORY(drm_agp_p, ptr);
-        NV_AGPGART_FREE_MEMORY(drm_agp_p, ptr);
+        NV_AGPGART_UNBIND_MEMORY(nvl,drm_agp_p, ptr);
+        NV_AGPGART_FREE_MEMORY(nvl,drm_agp_p, ptr);
=20
         nv_printf(NV_DBG_INFO, "NVRM: AGPGART: freed %ld pages\n",
             (unsigned long)pages);

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam6 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


--=-wuhTm6sdPF9Pn4Y8Inxd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB9t4rRlIHNEGnKMMRAmAAAJ9bIi2ts1Kc+3NzZHN2s/CFmZoOcACfQyI9
sUWE6xY71ZASJ/X83AD2ztE=
=Hzu3
-----END PGP SIGNATURE-----

--=-wuhTm6sdPF9Pn4Y8Inxd--

