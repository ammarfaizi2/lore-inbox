Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVCSCqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVCSCqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 21:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVCSCqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 21:46:42 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:54226 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261638AbVCSCqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 21:46:37 -0500
Message-ID: <423B9261.9040108@ens-lyon.org>
Date: Sat, 19 Mar 2005 03:45:53 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
Cc: Mike Werner <werner@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Fix agp_backend usage in drm_agp_init (was: 2.6.11-mm3 - DRM/i915
 broken)
References: <20050312034222.12a264c4.akpm@osdl.org> <42360820.702@ens-lyon.org>	 <200503142330.42556.bero@arklinux.org> <423616CF.6060204@ens-lyon.org> <21d7e99705031601363f27296@mail.gmail.com>
In-Reply-To: <21d7e99705031601363f27296@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
>>DRM/i915 does not work on my Dell Dimension 3000 (i865 chipset).
> 
> This is more than likely caused by the multi-bridge AGP stuff in -bk3

Yes, that's it! The bug appeared in -mm when the multi-bridge AGP stuff
was merged (2.6.10-mm3). It is still here in 2.6.12-rc1.

Here's the scenario I think I'm seeing:

agpioc_acquire_wrap is called, it increments the agp_in_use. Then (before
agpioc_release_wrap happens), drm_agp_init is called (I don't know how).
drm_agp_init uses agp_backend_acquire which fails because agp_in_use is
non-null (hold by agpioc_acquire_wrap).

The multi-bridge AGP patch actually changed drm_agp_init by adding
agp_backend_acquire/release around agp_copy_info.
It is why drm_agp_init fails now while it worked before.

I don't think we need to "acquire" it during agp_copy_info.
Why don't we just get a pointer to the bridge instead ?
(is there any chance this bridge gets deleted during drm_agp_init ?)
That's what the attached patch implements on top of 2.6.12-rc1.

I chose to add a new agp_backend_find() function, but we might also
directly call agp_find_bridge() from drm_agp_init(). I don't know what's
the best.

I'm not familiar enough with DRM/AGP code to understand everything here.
I might be missing something...

Regards,
Brice


Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>


--- linux-rc/include/linux/agp_backend.h.old	2005-03-19 03:26:36.000000000 +0100
+++ linux-rc/include/linux/agp_backend.h	2005-03-19 03:35:43.000000000 +0100
@@ -102,6 +102,7 @@ extern int agp_copy_info(struct agp_brid
  extern int agp_bind_memory(struct agp_memory *, off_t);
  extern int agp_unbind_memory(struct agp_memory *);
  extern void agp_enable(struct agp_bridge_data *, u32);
+extern struct agp_bridge_data *agp_backend_find(struct pci_dev *);
  extern struct agp_bridge_data *agp_backend_acquire(struct pci_dev *);
  extern void agp_backend_release(struct agp_bridge_data *);

--- linux-rc/drivers/char/agp/backend.c.old	2005-03-19 03:30:32.000000000 +0100
+++ linux-rc/drivers/char/agp/backend.c	2005-03-19 03:35:24.000000000 +0100
@@ -58,6 +58,12 @@ LIST_HEAD(agp_bridges);
  EXPORT_SYMBOL(agp_bridge);
  EXPORT_SYMBOL(agp_bridges);

+struct agp_bridge_data *agp_backend_find(struct pci_dev *pdev)
+{
+	return agp_find_bridge(pdev);
+}
+EXPORT_SYMBOL(agp_backend_find);
+
  /**
   *	agp_backend_acquire  -  attempt to acquire an agp backend.
   *
@@ -66,7 +72,7 @@ struct agp_bridge_data *agp_backend_acqu
  {
  	struct agp_bridge_data *bridge;

-	bridge = agp_find_bridge(pdev);
+	bridge = agp_backend_find(pdev);

  	if (!bridge)
  		return NULL;
--- linux-rc/drivers/char/drm/drm_agpsupport.c.old	2005-03-19 03:29:50.000000000 +0100
+++ linux-rc/drivers/char/drm/drm_agpsupport.c	2005-03-19 03:34:28.000000000 +0100
@@ -387,12 +387,11 @@ drm_agp_head_t *drm_agp_init(drm_device_
  	if (!(head = drm_alloc(sizeof(*head), DRM_MEM_AGPLISTS)))
  		return NULL;
  	memset((void *)head, 0, sizeof(*head));
-	if (!(head->bridge = agp_backend_acquire(dev->pdev))) {
+	if (!(head->bridge = agp_backend_find(dev->pdev))) {
  		drm_free(head, sizeof(*head), DRM_MEM_AGPLISTS);
  		return NULL;
  	}
  	agp_copy_info(head->bridge, &head->agp_info);
-	agp_backend_release(head->bridge);
  	if (head->agp_info.chipset == NOT_SUPPORTED) {
  		drm_free(head, sizeof(*head), DRM_MEM_AGPLISTS);
  		return NULL;
