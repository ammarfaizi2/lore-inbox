Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262892AbTDAW3q>; Tue, 1 Apr 2003 17:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262895AbTDAW3q>; Tue, 1 Apr 2003 17:29:46 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:14505 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262892AbTDAW3p>; Tue, 1 Apr 2003 17:29:45 -0500
Message-ID: <3E8A135B.3030106@us.ibm.com>
Date: Tue, 01 Apr 2003 14:31:55 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [patch][rfc] Memory Binding (0/1)
Content-Type: multipart/mixed;
 boundary="------------090004010308090801050407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090004010308090801050407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

So I've made a couple attempts at adding a Memory Binding facility to 
the kernel.  Obviously, I've had no success as yet, so I'm stubbornly 
trying another approach! ;)

This patch is just a small pre-patch to the real memory binding.  It 
just adds get_zonelist() and get_node_zonelist() calls, to make some 
code a little more readable.  This patch is super straight-forward.  The 
real fun is in the next patch...

[mcd@arrakis membind]$ diffstat 00-pre_membind.patch
  gfp.h    |    2 +-
  mmzone.h |    8 ++++++++
  2 files changed, 9 insertions(+), 1 deletion(-)

-Matt

--------------090004010308090801050407
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

--------------090004010308090801050407--

