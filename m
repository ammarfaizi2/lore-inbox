Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVATCij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVATCij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVATCih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:38:37 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:60648 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261742AbVATCic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:38:32 -0500
Date: Wed, 19 Jan 2005 18:38:32 -0800
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] agp_backend: remove drm_agp_t & inter_module_<foo> V1 [1/1]
Message-ID: <20050120023832.GA3758@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What extremely obvious thing am I missing which prevents up from
kill drm_agp_t and the inter_module_register, etc. code that goes with
it?

I couldn't see any in-tree users of this stuff...


---

 drivers/char/agp/backend.c  |   15 ---------------
 include/linux/agp_backend.h |   18 ------------------
 2 files changed, 33 deletions(-)

Index: cw-current/drivers/char/agp/backend.c
===================================================================
--- cw-current.orig/drivers/char/agp/backend.c	2005-01-19 17:57:33.838452042 -0800
+++ cw-current/drivers/char/agp/backend.c	2005-01-19 17:57:42.830795786 -0800
@@ -214,17 +214,6 @@
 				phys_to_virt(bridge->scratch_page_real));
 }
 
-static const drm_agp_t drm_agp = {
-	&agp_free_memory,
-	&agp_allocate_memory,
-	&agp_bind_memory,
-	&agp_unbind_memory,
-	&agp_enable,
-	&agp_backend_acquire,
-	&agp_backend_release,
-	&agp_copy_info
-};
-
 /* XXX Kludge alert: agpgart isn't ready for multiple bridges yet */
 struct agp_bridge_data *agp_alloc_bridge(void)
 {
@@ -277,9 +266,6 @@
 		goto frontend_err;
 	}
 
-	/* FIXME: What to do with this? */
-	inter_module_register("drm_agp", THIS_MODULE, &drm_agp);
-
 	agp_count++;
 	return 0;
 
@@ -298,7 +284,6 @@
 	bridge->type = NOT_SUPPORTED;
 	agp_frontend_cleanup();
 	agp_backend_cleanup(bridge);
-	inter_module_unregister("drm_agp");
 	agp_count--;
 	module_put(bridge->driver->owner);
 }
Index: cw-current/include/linux/agp_backend.h
===================================================================
--- cw-current.orig/include/linux/agp_backend.h	2005-01-19 17:57:33.839452080 -0800
+++ cw-current/include/linux/agp_backend.h	2005-01-19 17:57:42.830795786 -0800
@@ -96,23 +96,5 @@
 extern int agp_backend_acquire(void);
 extern void agp_backend_release(void);
 
-/*
- * Interface between drm and agp code.  When agp initializes, it makes
- * the below structure available via inter_module_register(), drm might
- * use it.  Keith Owens <kaos@ocs.com.au> 28 Oct 2000.
- */
-typedef struct {
-	void			(*free_memory)(struct agp_memory *);
-	struct agp_memory *	(*allocate_memory)(size_t, u32);
-	int			(*bind_memory)(struct agp_memory *, off_t);
-	int			(*unbind_memory)(struct agp_memory *);
-	void			(*enable)(u32);
-	int			(*acquire)(void);
-	void			(*release)(void);
-	int			(*copy_info)(struct agp_kern_info *);
-} drm_agp_t;
-
-extern const drm_agp_t *drm_agp_p;
-
 #endif				/* __KERNEL__ */
 #endif				/* _AGP_BACKEND_H */
