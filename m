Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVALXEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVALXEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVALXDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:03:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:7621 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261537AbVALXAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:00:14 -0500
Date: Wed, 12 Jan 2005 14:59:45 -0800 (PST)
From: Michael Werner <werner@mrcoffee.engr.sgi.com>
Message-Id: <200501122259.j0CMxjgc2003601@mrcoffee.engr.sgi.com>
To: linux-kernel@vger.kernel.org, davej@redhat.com, akpm@osdl.org
Subject: [patch 2.6.10-mm3] agpgart: allow drivers to allocate memory local to
    the bridge
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows drivers to allocate memory local to the bridge
using platform specific alloc_page routines.

Signed-off-by: Mike Werner <werner@sgi.com>
---

 agp.h           |    4 ++--
 ali-agp.c       |    4 ++--
 backend.c       |    2 +-
 generic.c       |    4 ++--
 i460-agp.c      |    4 ++--
 intel-agp.c     |    2 +-
 intel-mch-agp.c |    2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

# This is a BitKeeper generated diff -Nru style patch.
#
#   Add bridge parameter to alloc_page
#diff -Nru a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
--- a/drivers/char/agp/agp.h	2005-01-12 12:56:47 -08:00
+++ b/drivers/char/agp/agp.h	2005-01-12 12:56:47 -08:00
@@ -111,7 +111,7 @@
 	int (*remove_memory)(struct agp_memory *, off_t, int);
 	struct agp_memory *(*alloc_by_type) (size_t, int);
 	void (*free_by_type)(struct agp_memory *);
-	void *(*agp_alloc_page)(void);
+	void *(*agp_alloc_page)(struct agp_bridge_data *);
 	void (*agp_destroy_page)(void *);
 };
 
@@ -252,7 +252,7 @@
 int agp_generic_remove_memory(struct agp_memory *mem, off_t pg_start, int type);
 struct agp_memory *agp_generic_alloc_by_type(size_t page_count, int type);
 void agp_generic_free_by_type(struct agp_memory *curr);
-void *agp_generic_alloc_page(void);
+void *agp_generic_alloc_page(struct agp_bridge_data *bridge);
 void agp_generic_destroy_page(void *addr);
 void agp_free_key(int key);
 int agp_num_entries(void);
diff -Nru a/drivers/char/agp/ali-agp.c b/drivers/char/agp/ali-agp.c
--- a/drivers/char/agp/ali-agp.c	2005-01-12 12:56:47 -08:00
+++ b/drivers/char/agp/ali-agp.c	2005-01-12 12:56:47 -08:00
@@ -139,9 +139,9 @@
 	}
 }
 
-static void *m1541_alloc_page(void)
+static void *m1541_alloc_page(struct agp_bridge_data *bridge)
 {
-	void *addr = agp_generic_alloc_page();
+	void *addr = agp_generic_alloc_page(agp_bridge);
 	u32 temp;
 
 	if (!addr)
diff -Nru a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
--- a/drivers/char/agp/backend.c	2005-01-12 12:56:47 -08:00
+++ b/drivers/char/agp/backend.c	2005-01-12 12:56:47 -08:00
@@ -140,7 +140,7 @@
 	bridge->version = &agp_current_version;
 
 	if (bridge->driver->needs_scratch_page) {
-		void *addr = bridge->driver->agp_alloc_page();
+		void *addr = bridge->driver->agp_alloc_page(bridge);
 
 		if (!addr) {
 			printk(KERN_ERR PFX "unable to get memory for scratch page.\n");
diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	2005-01-12 12:56:47 -08:00
+++ b/drivers/char/agp/generic.c	2005-01-12 12:56:47 -08:00
@@ -202,7 +202,7 @@
 		return NULL;
 
 	for (i = 0; i < page_count; i++) {
-		void *addr = bridge->driver->agp_alloc_page();
+		void *addr = bridge->driver->agp_alloc_page(bridge);
 
 		if (addr == NULL) {
 			agp_free_memory(new);
@@ -950,7 +950,7 @@
  * against a maximum value.
  */
 
-void *agp_generic_alloc_page(void)
+void *agp_generic_alloc_page(struct agp_bridge_data *bridge)
 {
 	struct page * page;
 
diff -Nru a/drivers/char/agp/i460-agp.c b/drivers/char/agp/i460-agp.c
--- a/drivers/char/agp/i460-agp.c	2005-01-12 12:56:47 -08:00
+++ b/drivers/char/agp/i460-agp.c	2005-01-12 12:56:47 -08:00
@@ -510,12 +510,12 @@
  * Let's just hope nobody counts on the allocated AGP memory being there before bind time
  * (I don't think current drivers do)...
  */
-static void *i460_alloc_page (void)
+static void *i460_alloc_page (struct agp_bridge_data *bridge)
 {
 	void *page;
 
 	if (I460_IO_PAGE_SHIFT <= PAGE_SHIFT)
-		page = agp_generic_alloc_page();
+		page = agp_generic_alloc_page(agp_bridge);
 	else
 		/* Returning NULL would cause problems */
 		/* AK: really dubious code. */
diff -Nru a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
--- a/drivers/char/agp/intel-agp.c	2005-01-12 12:56:47 -08:00
+++ b/drivers/char/agp/intel-agp.c	2005-01-12 12:56:47 -08:00
@@ -269,7 +269,7 @@
 		return NULL;
 
 	switch (pg_count) {
-	case 1: addr = agp_bridge->driver->agp_alloc_page();
+	case 1: addr = agp_bridge->driver->agp_alloc_page(agp_bridge);
 		break;
 	case 4:
 		/* kludge to get 4 physical pages for ARGB cursor */
diff -Nru a/drivers/char/agp/intel-mch-agp.c b/drivers/char/agp/intel-mch-agp.c
--- a/drivers/char/agp/intel-mch-agp.c	2005-01-12 12:56:47 -08:00
+++ b/drivers/char/agp/intel-mch-agp.c	2005-01-12 12:56:47 -08:00
@@ -43,7 +43,7 @@
 	if (pg_count != 1)
 		return NULL;
 
-	addr = agp_bridge->driver->agp_alloc_page();
+	addr = agp_bridge->driver->agp_alloc_page(agp_bridge);
 	if (addr == NULL)
 		return NULL;
 
