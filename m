Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVCURFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVCURFc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 12:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVCURFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 12:05:32 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:19413 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261309AbVCURFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 12:05:15 -0500
Message-ID: <423EFEC8.9020208@ens-lyon.org>
Date: Mon, 21 Mar 2005 18:05:12 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mike Werner <werner@sgi.com>
Subject: Re: 2.6.12-rc1-mm1
References: <20050321025159.1cabd62e.akpm@osdl.org>
In-Reply-To: <20050321025159.1cabd62e.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050402000809050507030202"
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050402000809050507030202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/
> 
> 
> - We might have a fix here for the recent AGP/DRM problems.  If you were
>   having problems with that, please test and report.
> 
> +fix-agp_backend-usage-in-drm_agp_init.patch
> 
>  Might fix the DRM problems

Hi Andrew,

After tracking down this bug in the X code, Mike Werner asked me to
change my patch so that we directly use agp_find_bridge instead of
defining a new wrapper (agp_backend_find).
A new patch is attached.

Note that agp-make-some-code-static.patch makes agp_find_bridge
static in drivers/char/agp/backend.c while my new patch exports it.
That's why I also attach a patch to revert this part of 
agp-make-some-code-static.patch.

Regards,
Brice


Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>


--------------050402000809050507030202
Content-Type: text/x-patch;
 name="fix-agp_backend-usage-in-drm_agp_init2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-agp_backend-usage-in-drm_agp_init2.patch"

--- linux-mm/include/linux/agp_backend.h.old	2005-03-21 11:08:33.000000000 +0100
+++ linux-mm/include/linux/agp_backend.h	2005-03-21 11:08:47.000000000 +0100
@@ -100,6 +100,7 @@ extern int agp_copy_info(struct agp_brid
 extern int agp_bind_memory(struct agp_memory *, off_t);
 extern int agp_unbind_memory(struct agp_memory *);
 extern void agp_enable(struct agp_bridge_data *, u32);
+extern struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *);
 extern struct agp_bridge_data *agp_backend_acquire(struct pci_dev *);
 extern void agp_backend_release(struct agp_bridge_data *);
 
--- linux-mm/drivers/char/agp/backend.c.old	2005-03-21 11:07:29.000000000 +0100
+++ linux-mm/drivers/char/agp/backend.c	2005-03-21 11:08:11.000000000 +0100
@@ -50,6 +50,7 @@ static struct agp_version agp_current_ve
 
 struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *) =
 	&agp_generic_find_bridge;
+EXPORT_SYMBOL(agp_find_bridge);
 
 struct agp_bridge_data *agp_bridge;
 LIST_HEAD(agp_bridges);
--- linux-mm/drivers/char/drm/drm_agpsupport.c.old	2005-03-21 11:08:59.000000000 +0100
+++ linux-mm/drivers/char/drm/drm_agpsupport.c	2005-03-21 11:09:25.000000000 +0100
@@ -387,12 +387,11 @@ drm_agp_head_t *drm_agp_init(drm_device_
 	if (!(head = drm_alloc(sizeof(*head), DRM_MEM_AGPLISTS)))
 		return NULL;
 	memset((void *)head, 0, sizeof(*head));
-	if (!(head->bridge = agp_backend_acquire(dev->pdev))) {
+	if (!(head->bridge = agp_find_bridge(dev->pdev))) {
 		drm_free(head, sizeof(*head), DRM_MEM_AGPLISTS);
 		return NULL;
 	}
 	agp_copy_info(head->bridge, &head->agp_info);
-	agp_backend_release(head->bridge);
 	if (head->agp_info.chipset == NOT_SUPPORTED) {
 		drm_free(head, sizeof(*head), DRM_MEM_AGPLISTS);
 		return NULL;

--------------050402000809050507030202
Content-Type: text/x-patch;
 name="revert-make-agp_find_bridge-static.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="revert-make-agp_find_bridge-static.patch"

--- linux-mm/drivers/char/agp/backend.c.old	2005-03-21 11:07:29.000000000 +0100
+++ linux-mm/drivers/char/agp/backend.c	2005-03-21 11:08:11.000000000 +0100
@@ -50,7 +50,7 @@ static struct agp_version agp_current_ve
 	.minor = AGPGART_VERSION_MINOR,
 };
 
-static struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *) =
+struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *) =
 	&agp_generic_find_bridge;
 
 struct agp_bridge_data *agp_bridge;

--------------050402000809050507030202--
