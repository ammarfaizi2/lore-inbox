Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266819AbUBFHUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUBFHUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:20:42 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:4033 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266819AbUBFHUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:20:40 -0500
Date: Thu, 05 Feb 2004 23:19:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>, Keith Mannthey <kmannth@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving X  (fwd)
Message-ID: <99000000.1076051967@[10.10.2.4]>
In-Reply-To: <98220000.1076051821@[10.10.2.4]>
References: <51080000.1075936626@flay> <Pine.LNX.4.58.0402041539470.2086@home.osdl.org><60330000.1075939958@flay> <64260000.1075941399@flay><Pine.LNX.4.58.0402041639420.2086@home.osdl.org> <20040204165620.3d608798.akpm@osdl.org> <Pine.LNX.4.58.0402041719300.2086@home.osdl.org><1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com> <Pine.LNX.4.58.0402041800320.2086@home.osdl.org> <98220000.1076051821@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix pfn_valid for architctures with discontiguous memory.
This only changes the NUMA definition, and it leaves the NUMA-Q
definition as was, because it's faster that way, it's in hotpaths,
and our memory is always contiguous.

diff -aurpN -X /home/fletch/.diff.exclude pfn_to_nid/include/asm-i386/mmzone.h pfn_valid/include/asm-i386/mmzone.h
--- pfn_to_nid/include/asm-i386/mmzone.h	Thu Feb  5 20:58:00 2004
+++ pfn_valid/include/asm-i386/mmzone.h	Thu Feb  5 22:08:57 2004
@@ -121,14 +121,19 @@ static inline struct pglist_data *pfn_to
 		+ __zone->zone_start_pfn;				\
 })
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
-/*
- * pfn_valid should be made as fast as possible, and the current definition 
- * is valid for machines that are NUMA, but still contiguous, which is what
- * is currently supported. A more generalised, but slower definition would
- * be something like this - mbligh:
- * ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) ) 
- */ 
+
+#ifdef CONFIG_X86_NUMAQ            /* we have contiguous memory on NUMA-Q */
 #define pfn_valid(pfn)          ((pfn) < num_physpages)
+#else
+static inline int pfn_valid(int pfn)
+{
+	int nid = pfn_to_nid(pfn);
+
+	if (nid >= 0)
+		return (pfn < node_end_pfn(nid));
+	return 0;
+}
+#endif
 
 extern int get_memcfg_numa_flat(void );
 /*

