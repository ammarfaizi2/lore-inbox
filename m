Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTKZEAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 23:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTKZEAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 23:00:24 -0500
Received: from holomorphy.com ([199.26.172.102]:43708 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263082AbTKZEAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 23:00:17 -0500
Date: Tue, 25 Nov 2003 19:59:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Jack Steiner <steiner@sgi.com>, Anton Blanchard <anton@samba.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031126035953.GF8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Jack Steiner <steiner@sgi.com>,
	Anton Blanchard <anton@samba.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, jbarnes@sgi.com
References: <20031125231108.GA5675@sgi.com> <Pine.LNX.4.44.0311252238140.22777-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311252238140.22777-100000@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Jack Steiner wrote:
>> That was a concern to me too. However, on IA64, all page structs are in
>> the vmalloc region

On Tue, Nov 25, 2003 at 10:39:10PM -0500, Rik van Riel wrote:
> Which you'll probably want to fix eventually.  At least
> PAGE_VALID() doesn't seem to work as advertised currently...
> (occasionally leading to "false positives", with PAGE_VALID()
> saying that a page exists while it really doesn't)

Speaking of which, no one's bothered fixing the X crashes on i386
discontigmem. Untested patch below.


-- wli


diff -prauN linux-2.6.0-test10/include/asm-i386/mmzone.h pfn_valid-2.6.0-test10/include/asm-i386/mmzone.h
--- linux-2.6.0-test10/include/asm-i386/mmzone.h	2003-11-23 17:31:56.000000000 -0800
+++ pfn_valid-2.6.0-test10/include/asm-i386/mmzone.h	2003-11-25 19:54:31.000000000 -0800
@@ -85,13 +85,19 @@ extern struct pglist_data *node_data[];
 })
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 /*
- * pfn_valid should be made as fast as possible, and the current definition 
- * is valid for machines that are NUMA, but still contiguous, which is what
- * is currently supported. A more generalised, but slower definition would
- * be something like this - mbligh:
- * ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) ) 
+ * pfn_valid must absolutely be correct, regardless of speed concerns.
  */ 
-#define pfn_valid(pfn)          ((pfn) < num_physpages)
+#define pfn_valid(pfn)							\
+({									\
+	unsigned long __pfn__ = pfn;					\
+	u8 __nid__ = pfn_to_nid(__pfn__);				\
+	pg_data_t *__pgdat__;						\
+	__pgdat__ = __nid__ < MAX_NUMNODES ? NODE_DATA(__nid__) : NULL;	\
+	__pgdat__ &&							\
+		__pfn__ >= __pgdat__->node_start_pfn &&			\
+		__pfn__ - __pgdat__->node_start_pfn			\
+				< __pgdat__->node_spanned_pages;	\
+})
 
 /*
  * generic node memory support, the following assumptions apply:
