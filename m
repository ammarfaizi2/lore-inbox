Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSJJU0S>; Thu, 10 Oct 2002 16:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263740AbSJJUNJ>; Thu, 10 Oct 2002 16:13:09 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:9117 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262882AbSJJUHr>; Thu, 10 Oct 2002 16:07:47 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core (8/9) evms_biosplit.h
Date: Thu, 10 Oct 2002 14:39:28 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02101014305502.17770@boiler>
In-Reply-To: <02101014305502.17770@boiler>
MIME-Version: 1.0
Message-Id: <0210101439280A.17770@boiler>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Part 8 of the EVMS core driver.

This header file defines some of the common functions used by the
EVMS core to perform bio splitting. The remaining bio-splitting code
is in services.c. It would be our hope that this code might be taken
out of EVMS in the future and turned into a common kernel service.

The general idea behind this approach is for each plugin to determine
if a bio spans one of its internal boundaries (e.g. a request crosses
the boundary of an LVM PE or an MD chunk). If so, the plugin calls the
core biosplit code with the desired bio and boundary offset and gets
two bio's back. The first one can then be processed immediately. The
second one must then be checked again for further boundary conditions,
and possibly split again. After all necessary splits have taken place
and all portions driven to the devices, the core code handles the
callbacks and completes the original bio when all the split portions
are done.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/



diff -Naur linux-2.5.41/include/linux/evms_biosplit.h linux-2.5.41-evms/include/linux/evms_biosplit.h
--- linux-2.5.41/include/linux/evms_biosplit.h	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/include/linux/evms_biosplit.h	Thu Oct 10 11:20:31 2002
@@ -0,0 +1,143 @@
+/*
+ *
+ *
+ *   Copyright (c) International Business Machines  Corp., 2000 - 2002
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ *
+ */
+/*
+ *
+ * BIO splitting header file
+ *
+ * This is temporarily placed here until a common generic solution
+ * is available.
+ *
+ */
+ 
+#include <linux/mempool.h>
+
+static mempool_t *my_bio_split_pool, *my_bio_pool;
+static kmem_cache_t *my_bio_split_slab, *my_bio_pool_slab;
+
+/**
+ * slab_pool_alloc
+ * @gfp_mask:	GFP allocation flag
+ * @data:	mempool prototype required fields
+ *
+ * mempool allocate function
+ **/
+static void *
+slab_pool_alloc(int gfp_mask, void *data)
+{
+	return kmem_cache_alloc(data, gfp_mask);
+}
+
+/**
+ * slab_pool_free
+ * @ptr:	mempool prototype required fields
+ * @data:	mempool prototype required fields
+ *
+ * mempool free function
+ **/
+static void
+slab_pool_free(void *ptr, void *data)
+{
+	kmem_cache_free(data, ptr);
+}
+
+/** bio_cache_ctor - initializes bio elements
+ * @foo:	ptr to element
+ * @cachep:	ptr to slab cache
+ * @flags:	slab flags
+ *
+ * this function initializes the bi_io_vec field in the
+ * bio's allocates from our private bio pool.    
+ **/   
+#define EVMS_BIO_VEC_SIZE (sizeof(struct bio_vec) * (BIO_MAX_PAGES+1))
+static void   bio_cache_ctor(void * foo, kmem_cache_t * cachep, unsigned long flags)   
+{
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) == 
+	              SLAB_CTOR_CONSTRUCTOR) {
+		struct bio *bio = (struct bio *)foo;
+		memset(bio, 0, (sizeof(*bio) + EVMS_BIO_VEC_SIZE));
+		bio->bi_io_vec = (struct bio_vec *)((char *)bio + sizeof(*bio));
+	}
+}
+
+static int
+bio_split_setup(char * split_name, char * bio_name)
+{
+	/* initialize MY bio split record pool */
+	my_bio_split_slab = kmem_cache_create(split_name,
+						sizeof
+						(struct bio_split_cb),
+						0, SLAB_HWCACHE_ALIGN,
+                                                NULL, NULL);
+	if (!my_bio_split_slab) {
+		LOG_ERROR("error(%d): unable to create %s cache.\n",
+			  -ENOMEM, split_name);
+		return -ENOMEM;
+	}
+	my_bio_split_pool = mempool_create(256,
+					     slab_pool_alloc,
+					     slab_pool_free,
+					     my_bio_split_slab);
+	if (!my_bio_split_pool) {
+		LOG_ERROR("error(%d): unable to create %s pool.",
+			  -ENOMEM, split_name);
+		return -ENOMEM;
+	}
+
+	/* initialize MY bio pool */
+	my_bio_pool_slab = kmem_cache_create(bio_name,
+                                             (sizeof (struct bio) +
+					     EVMS_BIO_VEC_SIZE),
+					     0, SLAB_HWCACHE_ALIGN,
+					     bio_cache_ctor, NULL);
+	if (!my_bio_pool_slab) {
+		LOG_ERROR("error(%d): unable to create %s cache.\n",
+			  -ENOMEM, split_name);
+		return -ENOMEM;
+	}
+	my_bio_pool = mempool_create(256,
+	       			     slab_pool_alloc,
+	       			     slab_pool_free,
+	       			     my_bio_pool_slab);
+	if (!my_bio_pool) {
+		LOG_ERROR("error(%d): unable to create %s pool.",
+			  -ENOMEM, split_name);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void
+bio_split_remove(void)
+{
+	if (my_bio_pool) {
+		mempool_destroy(my_bio_pool);
+	}
+	if (my_bio_pool_slab) {
+		kmem_cache_destroy(my_bio_pool_slab);
+	}
+	if (my_bio_split_pool) {
+		mempool_destroy(my_bio_split_pool);
+	}
+	if (my_bio_split_slab) {
+		kmem_cache_destroy(my_bio_split_slab);
+	}
+}
Ðë9
