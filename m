Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUE1DTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUE1DTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 23:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUE1DS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 23:18:59 -0400
Received: from ozlabs.org ([203.10.76.45]:54465 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262100AbUE1DS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 23:18:57 -0400
Date: Fri, 28 May 2004 13:16:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: [PPC64] Remove silly debug path from get_vsid()
Message-ID: <20040528031659.GC15922@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

Currently the get_vsid() and get_kernel_vsid() functions have a test
which enables a different VSID algorithm for debugging.  Using a dumb
VSID algorithm for stressing the hash table is a reasonable debugging
tool, but switching it at runtime makes no sense at all.  Plus it adds
another test and memory access to the performance critical SLB miss
path.

This patch removes the test, replacing it with a compile time switch.
It seems to make a measurable, although small speedup to the SLB miss
path (maybe 0.5%).

Index: working-2.6/include/asm-ppc64/mmu_context.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu_context.h	2004-05-20 12:58:51.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu_context.h	2004-05-27 14:22:01.088506616 +1000
@@ -189,15 +189,15 @@
 	ordinal = (((ea >> 28) & 0x1fff) * LAST_USER_CONTEXT) | (ea >> 60);
 	vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK;
 
-	ifppcdebug(PPCDBG_HTABSTRESS) {
-		/* For debug, this path creates a very poor vsid distribuition.
-		 * A user program can access virtual addresses in the form
-		 * 0x0yyyyxxxx000 where yyyy = xxxx to cause multiple mappings
-		 * to hash to the same page table group.
-		 */ 
-		ordinal = ((ea >> 28) & 0x1fff) | (ea >> 44);
-		vsid = ordinal & VSID_MASK;
-	}
+#ifdef HTABSTRESS
+	/* For debug, this path creates a very poor vsid distribuition.
+	 * A user program can access virtual addresses in the form
+	 * 0x0yyyyxxxx000 where yyyy = xxxx to cause multiple mappings
+	 * to hash to the same page table group.
+	 */ 
+	ordinal = ((ea >> 28) & 0x1fff) | (ea >> 44);
+	vsid = ordinal & VSID_MASK;
+#endif /* HTABSTRESS */
 
 	return vsid;
 } 
@@ -212,11 +212,11 @@
 	ordinal = (((ea >> 28) & 0x1fff) * LAST_USER_CONTEXT) | context;
 	vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK;
 
-	ifppcdebug(PPCDBG_HTABSTRESS) {
-		/* See comment above. */
-		ordinal = ((ea >> 28) & 0x1fff) | (context << 16);
-		vsid = ordinal & VSID_MASK;
-	}
+#ifdef HTABSTRESS
+	/* See comment above. */
+	ordinal = ((ea >> 28) & 0x1fff) | (context << 16);
+	vsid = ordinal & VSID_MASK;
+#endif /* HTABSTRESS */
 
 	return vsid;
 }

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
