Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVAYUyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVAYUyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVAYUwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:52:43 -0500
Received: from spock.bluecherry.net ([66.138.159.248]:30663 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S262113AbVAYUvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:51:07 -0500
Date: Tue, 25 Jan 2005 15:50:47 -0500
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: davidm@hpl.hp.com, Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: patch to enable Nvidia v5336 on v2.6.11 kernel (was Re: inter_module_get and __symbol_get)
Message-ID: <20050125205046.GA19738@babylon.d2dc.net>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	davidm@hpl.hp.com, Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <16885.32149.788747.550216@napali.hpl.hp.com> <31612.1106607781@ocs3.ocs.com.au> <16885.38947.35646.558780@napali.hpl.hp.com> <1106657785l.6979l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <1106657785l.6979l.0l@werewolf.able.es>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 25, 2005 at 12:56:25PM +0000, J.A. Magallon wrote:
<snip>
> You can use the latest drivers (6629) with this patches:
> 
> http://www.minion.de/files/1.0-6629/
> 
> They work fine up to -rc2.
> 
> If you want to use the driver with -mm, you have to kill the support
> for AGPGART in nvidia driver, add -DNOAGPGART to EXTRA_CFLAGS in the
> makefile. It will require a big change to use the multi-agp patches
> in -mm. But you are restricted to those AGPs supported by nvidia
> (ah, and don't load any agp related module...).

For values of big changes that equal the attached patch.

I'm using it on 2.6.10-mm3.  I sent it to Zander however since there is
no way to detect the new multi-agp support barring some sick hacks it
has not gone in.

It may conflict with the support for the 2.6.11-rc kernels, in which
case when I next upgrade I'll find out and write a new one.
> 
> Ah, just a ton of workarounds....



-- 
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

<Mercury> Be warned, I have a keyboard I can use to beat luser's heads
          in, and then continue to use... (=:]
<Deek> Mercury: Oh, an IBM. :)

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nvidia_multiagp.diff"

diff -ur modules/nvidia-kernel/nv/nv-linux.h modules_new/nvidia-kernel/nv/nv-linux.h
--- modules/nvidia-kernel/nv/nv-linux.h	2004-11-12 14:14:20.000000000 -0500
+++ modules_new/nvidia-kernel/nv/nv-linux.h	2005-01-18 23:25:03.000000000 -0500
@@ -854,6 +854,9 @@
 
     /* lock for linux-specific alloc queue */
     struct semaphore at_lock;
+
+    /* AGP handle. */
+    struct agp_bridge_data *agp_bridge;
 } nv_linux_state_t;
 
 
diff -ur modules/nvidia-kernel/nv/os-agp.c modules_new/nvidia-kernel/nv/os-agp.c
--- modules/nvidia-kernel/nv/os-agp.c	2004-11-12 14:14:20.000000000 -0500
+++ modules_new/nvidia-kernel/nv/os-agp.c	2005-01-18 23:22:51.000000000 -0500
@@ -70,6 +70,7 @@
     U032  agp_fw;
     void *bitmap;
     U032 bitmap_size;
+    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);
 
     memset( (void *) &gart, 0, sizeof(agp_gart));
 
@@ -82,7 +83,7 @@
      * the memory controller.
      */
 
-    if (drm_agp_p->acquire())
+    if (!(nvl->agp_bridge = drm_agp_p->acquire(nvl->dev)))
     {
         nv_printf(NV_DBG_ERRORS, "NVRM: AGPGART: backend in use\n");
         inter_module_put("drm_agp");
@@ -110,7 +111,7 @@
      */
     drm_agp_p->copy_info(&agpinfo);
 #else
-    if (drm_agp_p->copy_info(&agpinfo)) {
+    if (drm_agp_p->copy_info(nvl->agp_bridge, &agpinfo)) {
         nv_printf(NV_DBG_ERRORS,
             "NVRM: AGPGART: kernel reports chipset as unsupported\n");
         goto failed;
@@ -170,7 +171,7 @@
     if (!(agp_rate & 0x00000004)) agpinfo.mode &= ~0x00000004;
     if (!(agp_rate & 0x00000002)) agpinfo.mode &= ~0x00000002;
     
-    drm_agp_p->enable(agpinfo.mode);
+    drm_agp_p->enable(nvl->agp_bridge, agpinfo.mode);
 
     *ap_phys_base   = (void*) agpinfo.aper_base;
     *ap_mapped_base = (void*) gart.aperture;
@@ -182,7 +183,7 @@
 
 failed:
     MTRR_DEL(gart); /* checks gart.mtrr */
-    drm_agp_p->release();
+    drm_agp_p->release(nvl->agp_bridge);
     inter_module_put("drm_agp");
 
     return -1;
@@ -198,6 +199,7 @@
     return 1;
 #else
     void *bitmap;
+    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);
 
     /* sanity check to make sure we should actually be here. */
     if (!gart.ready)
@@ -213,7 +215,7 @@
         NV_IOUNMAP(gart.aperture, RM_PAGE_SIZE);
     }
 
-    drm_agp_p->release();
+    drm_agp_p->release(nvl->agp_bridge);
 
     inter_module_put("drm_agp");
 
@@ -247,6 +249,7 @@
     int err;
     agp_priv_data *data;
     RM_STATUS status;
+    nv_linux_state_t *nvl = NV_GET_NVL_FROM_NV_STATE(nv);
 
     if (!gart.ready)
     {
@@ -262,7 +265,7 @@
         return RM_ERROR;
     }
 
-    ptr = drm_agp_p->allocate_memory(PageCount, AGP_NORMAL_MEMORY);
+    ptr = drm_agp_p->allocate_memory(nvl->agp_bridge, PageCount, AGP_NORMAL_MEMORY);
     if (ptr == NULL)
     {
         *pAddress = (void*) 0;

--/04w6evG8XlLl3ft--

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB9rEmRFMAi+ZaeAERAgOzAKDJCKfIcqlVSGjZnfaAvByOy8zonwCghyfd
3qpIgyK2A+EOFphoxBldclU=
=ZUUP
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
