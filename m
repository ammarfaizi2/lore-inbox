Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbTDCFsq>; Thu, 3 Apr 2003 00:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263284AbTDCFsq>; Thu, 3 Apr 2003 00:48:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:3507 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263283AbTDCFso>;
	Thu, 3 Apr 2003 00:48:44 -0500
Message-ID: <3E8BCB96.6090908@us.ibm.com>
Date: Wed, 02 Apr 2003 21:50:14 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Christoph Hellwig <hch@infradead.org>,
       Paolo Zeppegno <zeppegno.paolo@seat.it>, Andi Kleen <ak@muc.de>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: [rfc][patch] Memory Binding Take 2 (0/1)
Content-Type: multipart/mixed;
 boundary="------------030405020403070806010806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030405020403070806010806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alrighty, let's give this another go...

This patch hasn't changed much.  Just added bitmap_t, typedef'd to 
unsigned long * for passing around bitmaps without breaking the 
abstraction.  I think it's good if we can keep the underlying data type 
hidden to partially future-proof (protect? ;) the code.

Part 1/1 coming up...

Cheers!

-Matt

--------------030405020403070806010806
Content-Type: text/plain;
 name="00-pre_membind.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="00-pre_membind.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-vanilla/include/linux/gfp.h linux-2.5.66-pre_membind/include/linux/gfp.h
--- linux-2.5.66-vanilla/include/linux/gfp.h	Mon Mar 24 14:00:10 2003
+++ linux-2.5.66-pre_membind/include/linux/gfp.h	Mon Mar 31 17:38:47 2003
@@ -52,7 +52,7 @@
 	if (unlikely(order >= MAX_ORDER))
 		return NULL;
 
-	return __alloc_pages(gfp_mask, order, NODE_DATA(nid)->node_zonelists + (gfp_mask & GFP_ZONEMASK));
+	return __alloc_pages(gfp_mask, order, get_node_zonelist(nid, gfp_mask));
 }
 
 #define alloc_pages(gfp_mask, order) \
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-vanilla/include/linux/mmzone.h linux-2.5.66-pre_membind/include/linux/mmzone.h
--- linux-2.5.66-vanilla/include/linux/mmzone.h	Mon Mar 24 14:00:45 2003
+++ linux-2.5.66-pre_membind/include/linux/mmzone.h	Mon Mar 31 17:38:47 2003
@@ -326,6 +326,14 @@
 #define num_online_memblks()		1
 
 #endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA */
+
+static inline struct zonelist *get_node_zonelist(int nid, int gfp_mask)
+{
+	return NODE_DATA(nid)->node_zonelists + (gfp_mask & GFP_ZONEMASK);
+}
+
+#define get_zonelist(gfp_mask) get_node_zonelist(numa_node_id(), gfp_mask)
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-vanilla/include/linux/types.h linux-2.5.66-pre_membind/include/linux/types.h
--- linux-2.5.66-vanilla/include/linux/types.h	Mon Mar 24 14:01:24 2003
+++ linux-2.5.66-pre_membind/include/linux/types.h	Wed Apr  2 18:13:27 2003
@@ -10,6 +10,7 @@
 	unsigned long name[BITS_TO_LONGS(bits)]
 #define CLEAR_BITMAP(name,bits) \
 	memset(name, 0, BITS_TO_LONGS(bits)*sizeof(unsigned long))
+typedef unsigned long * bitmap_t;
 #endif
 
 #include <linux/posix_types.h>

--------------030405020403070806010806--

