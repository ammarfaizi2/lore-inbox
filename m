Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUELUM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUELUM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUELUM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:12:58 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:47436 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265221AbUELUMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:12:22 -0400
Message-ID: <40A2714B.2F27EA35@sgi.com>
Date: Wed, 12 May 2004 11:47:39 -0700
From: Mike Werner <werner@sgi.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; IRIX64 6.5 IP35)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davej@redhat.com
Subject: [RFC/PATCH]Allow agp memory allocations to use node information
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u linux-2.6.6.orig/drivers/char/agp/agp.h
linux-2.6.6/drivers/char/agp/agp.h
--- linux-2.6.6.orig/drivers/char/agp/agp.h     Sun May  9 19:32:28 2004

+++ linux-2.6.6/drivers/char/agp/agp.h  Wed May 12 11:43:19 2004
@@ -111,7 +111,7 @@
        int (*remove_memory)(struct agp_memory *, off_t, int);
        struct agp_memory *(*alloc_by_type) (size_t, int);
        void (*free_by_type)(struct agp_memory *);
-       void *(*agp_alloc_page)(void);
+       void *(*agp_alloc_page)(int);
        void (*agp_destroy_page)(void *);
 };

@@ -137,6 +137,7 @@
        int max_memory_agp;     /* in number of pages */
        int aperture_size_idx;
        int capndx;
+       int nodeid;
        char major_version;
        char minor_version;
 };
@@ -261,7 +262,7 @@
 int agp_generic_remove_memory(struct agp_memory *mem, off_t pg_start,
int type);
 struct agp_memory *agp_generic_alloc_by_type(size_t page_count, int
type);
 void agp_generic_free_by_type(struct agp_memory *curr);
-void *agp_generic_alloc_page(void);
+void *agp_generic_alloc_page(int);
 void agp_generic_destroy_page(void *addr);
 void agp_free_key(int key);
 int agp_num_entries(void);
@@ -325,4 +326,5 @@
 #define AGPCTRL_APERENB                (1<<8)
 #define AGPCTRL_GTLBEN         (1<<7)

+#define AGPGART_DEFAULT_NODE   (0)
 #endif /* _AGP_BACKEND_PRIV_H */
diff -u linux-2.6.6.orig/drivers/char/agp/backend.c
linux-2.6.6/drivers/char/agp/backend.c
--- linux-2.6.6.orig/drivers/char/agp/backend.c Sun May  9 19:32:53 2004

+++ linux-2.6.6/drivers/char/agp/backend.c      Wed May 12 11:43:48 2004

@@ -130,12 +130,13 @@
 static int agp_backend_initialize(struct agp_bridge_data *bridge)
 {
        int size_value, rc, got_gatt=0, got_keylist=0;
+       int nid = bridge->nodeid;

        bridge->max_memory_agp = agp_find_max();
        bridge->version = &agp_current_version;

        if (bridge->driver->needs_scratch_page) {
-               void *addr = bridge->driver->agp_alloc_page();
+               void *addr = bridge->driver->agp_alloc_page(nid);

                if (!addr) {
                        printk(KERN_ERR PFX "unable to get memory for
scratch page.\n");
diff -u linux-2.6.6.orig/drivers/char/agp/generic.c
linux-2.6.6/drivers/char/agp/generic.c
--- linux-2.6.6.orig/drivers/char/agp/generic.c Sun May  9 19:32:27 2004

+++ linux-2.6.6/drivers/char/agp/generic.c      Wed May 12 11:44:03 2004

@@ -154,6 +154,7 @@
        int scratch_pages;
        struct agp_memory *new;
        size_t i;
+       int nid = agp_bridge->nodeid;

        if (agp_bridge->type == NOT_SUPPORTED)
                return NULL;
@@ -174,7 +175,7 @@
                return NULL;

        for (i = 0; i < page_count; i++) {
-               void *addr = agp_bridge->driver->agp_alloc_page();
+               void *addr = agp_bridge->driver->agp_alloc_page(nid);

                if (addr == NULL) {
                        agp_free_memory(new);
@@ -877,11 +878,11 @@
  * against a maximum value.
  */

-void *agp_generic_alloc_page(void)
+void *agp_generic_alloc_page(int nid)
 {
        struct page * page;

-       page = alloc_page(GFP_KERNEL);
+       page = alloc_pages_node(nid, GFP_KERNEL, 0);
        if (page == NULL)
                return 0;

diff -u linux-2.6.6.orig/drivers/char/agp/i460-agp.c
linux-2.6.6/drivers/char/agp/i460-agp.c
--- linux-2.6.6.orig/drivers/char/agp/i460-agp.c        Sun May  9
19:32:39 2004
+++ linux-2.6.6/drivers/char/agp/i460-agp.c     Wed May 12 10:49:06 2004

@@ -508,12 +508,12 @@
  * Let's just hope nobody counts on the allocated AGP memory being
there before bind time
  * (I don't think current drivers do)...
  */
-static void *i460_alloc_page (void)
+static void *i460_alloc_page (int nid)
 {
        void *page;

        if (I460_IO_PAGE_SHIFT <= PAGE_SHIFT)
-               page = agp_generic_alloc_page();
+               page = agp_generic_alloc_page(nid);
        else
                /* Returning NULL would cause problems */
                /* AK: really dubious code. */
diff -u linux-2.6.6.orig/drivers/char/agp/intel-agp.c
linux-2.6.6/drivers/char/agp/intel-agp.c
--- linux-2.6.6.orig/drivers/char/agp/intel-agp.c       Sun May  9
19:32:36 2004
+++ linux-2.6.6/drivers/char/agp/intel-agp.c    Wed May 12 10:47:19 2004

@@ -221,7 +221,7 @@
        if (pg_count != 1)
                return NULL;

-       addr = agp_bridge->driver->agp_alloc_page();
+       addr = agp_bridge->driver->agp_alloc_page(AGPGART_DEFAULT_NODE);

        if (addr == NULL)
                return NULL;

diff -u linux-2.6.6.orig/drivers/char/agp/intel-mch-agp.c
linux-2.6.6/drivers/char/agp/intel-mch-agp.c
--- linux-2.6.6.orig/drivers/char/agp/intel-mch-agp.c   Sun May  9
19:32:00 2004
+++ linux-2.6.6/drivers/char/agp/intel-mch-agp.c        Wed May 12
11:16:02 2004
@@ -43,7 +43,7 @@
        if (pg_count != 1)
                return NULL;

-       addr = agp_bridge->driver->agp_alloc_page();
+       addr = agp_bridge->driver->agp_alloc_page(AGPGART_DEFAULT_NODE);

        if (addr == NULL)
                return NULL;



