Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbUBEB5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUBEB5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:57:12 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:10419 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264481AbUBEB5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 20:57:07 -0500
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
	X  (fwd)
From: Keith Mannthey <kmannth@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.58.0402041719300.2086@home.osdl.org>
References: <51080000.1075936626@flay>
	<Pine.LNX.4.58.0402041539470.2086@home.osdl.org> <60330000.1075939958@flay>
	<64260000.1075941399@flay> <Pine.LNX.4.58.0402041639420.2086@home.osdl.org>
	<20040204165620.3d608798.akpm@osdl.org> 
	<Pine.LNX.4.58.0402041719300.2086@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 04 Feb 2004 17:56:49 -0800
Message-Id: <1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 17:29, Linus Torvalds wrote:
> 
> So it does need to be fixed, and if it ends up being a noticeable
> perofmance problem, then we can look at the hot-paths one by one and see
> if we can avoid using it. We probably can, most of the time.
> 

Martin sent me a patch that fixed the X panics (NUMA and DISCONTIG
enabled).  (Thanks Martin!) I don't have the same X panics and issues I
had before. I don't know if this will work for the generic case. It
compiles with a simple memory situation just fine but I didn't boot it. 


diff -purN -X /home/mbligh/.diff.exclude virgin/include/asm-i386/mmzone.h pfn_valid/include/asm-i386/mmzone.h
--- virgin/include/asm-i386/mmzone.h    2003-10-01 11:48:22.000000000 -0700
+++ pfn_valid/include/asm-i386/mmzone.h 2004-02-04 16:39:12.000000000 -0800
@@ -84,14 +84,8 @@ extern struct pglist_data *node_data[];
                + __zone->zone_start_pfn;                               \
 })
 #define pmd_page(pmd)          (pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
-/*
- * pfn_valid should be made as fast as possible, and the current definition 
- * is valid for machines that are NUMA, but still contiguous, which is what
- * is currently supported. A more generalised, but slower definition would
- * be something like this - mbligh:
- * ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) ) 
- */ 
-#define pfn_valid(pfn)          ((pfn) < num_physpages)
+
+#define pfn_valid(pfn) ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) ) 
 
 /*
  * generic node memory support, the following assumptions apply:


