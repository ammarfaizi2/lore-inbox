Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTEISmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTEISmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:42:04 -0400
Received: from holomorphy.com ([66.224.33.161]:1698 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263276AbTEISle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:41:34 -0400
Date: Fri, 9 May 2003 11:54:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm3
Message-ID: <20030509185407.GB8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030508013958.157b27b7.akpm@digeo.com> <20030509181257.GB8931@holomorphy.com> <20030509181535.GZ8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509181535.GZ8978@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 11:15:35AM -0700, William Lee Irwin III wrote:
+static inline int __next_node_with_cpus(int node)
+{
+	do
+		++node;
+	while (!nr_cpus_node(node) && node < numnodes);
+	return node;
+}

GRRR, neither seems to hurt my booting it or cause warnings but there
are two mistakes:

(1) not checking node < numnodes before !nr_cpus_node()
(2) casting the arg of generic_hweight32() to unsigned long is wrong

Fixed patch(es) below.


-- wli


diff -urpN mm3-2.5.69-1/include/linux/bitops.h mm3-2.5.69-2/include/linux/bitops.h
--- mm3-2.5.69-1/include/linux/bitops.h	2003-05-09 09:22:16.000000000 -0700
+++ mm3-2.5.69-2/include/linux/bitops.h	2003-05-09 11:30:09.000000000 -0700
@@ -1,5 +1,6 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
+#include <asm/types.h>
 #include <asm/bitops.h>
 
 /*
@@ -107,11 +108,14 @@ static inline unsigned int generic_hweig
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
 
-#if (BITS_PER_LONG == 64)
-
-static inline u64 generic_hweight64(u64 w)
+static inline unsigned long generic_hweight64(u64 w)
 {
-        u64 res = (w & 0x5555555555555555) + ((w >> 1) & 0x5555555555555555);
+	u64 res;
+	if (sizeof(unsigned long) == 4)
+		return generic_hweight32((unsigned int)(w >> 32)) +
+					generic_hweight32((unsigned int)w);
+
+	res = (w & 0x5555555555555555) + ((w >> 1) & 0x5555555555555555);
         res = (res & 0x3333333333333333) + ((res >> 2) & 0x3333333333333333);
         res = (res & 0x0F0F0F0F0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F0F0F0F0F);
         res = (res & 0x00FF00FF00FF00FF) + ((res >> 8) & 0x00FF00FF00FF00FF);
@@ -119,22 +123,9 @@ static inline u64 generic_hweight64(u64 
         return (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
 }
 
-#define hweight_long(w)	generic_hweight64(w)
-
-#endif /* BITS_PER_LONG == 64 */
-
-#if (BITS_PER_LONG == 32)
-
-static inline unsigned int generic_hweight64(unsigned int *w)
+static inline unsigned long hweight_long(unsigned long x)
 {
-	return generic_hweight32(w[0]) + generic_hweight32(w[1]);
+	return sizeof(x) == 4 ? generic_hweight32(x) : generic_hweight64(x);
 }
 
-#define hweight_long(w)	generic_hweight32(w)
-
-#endif /* BITS_PER_LONG == 32 */
-
-#include <asm/bitops.h>
-
-
 #endif
diff -urpN mm3-2.5.69-1/include/linux/topology.h mm3-2.5.69-2/include/linux/topology.h
--- mm3-2.5.69-1/include/linux/topology.h	2003-05-09 09:22:16.000000000 -0700
+++ mm3-2.5.69-2/include/linux/topology.h	2003-05-09 11:29:52.000000000 -0700
@@ -32,8 +32,15 @@
 
 #define nr_cpus_node(node)	(hweight_long(node_to_cpumask(node)))
 
+static inline int __next_node_with_cpus(int node)
+{
+	do
+		++node;
+	while (node < numnodes && !nr_cpus_node(node));
+	return node;
+}
+
 #define for_each_node_with_cpus(node) \
-	for (node = 0; node < numnodes; node++) \
-		if (nr_cpus_node(node)
+	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
 
 #endif /* _LINUX_TOPOLOGY_H */
