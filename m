Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281202AbRKHApo>; Wed, 7 Nov 2001 19:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281213AbRKHApf>; Wed, 7 Nov 2001 19:45:35 -0500
Received: from holomorphy.com ([216.36.33.161]:50126 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S281202AbRKHApW>;
	Wed, 7 Nov 2001 19:45:22 -0500
Date: Wed, 7 Nov 2001 16:44:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] bootmem for 2.5
Message-ID: <20011107164400.G26577@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com> <1005017025.897.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <1005017025.897.0.camel@phantasy>; from rml@tech9.net on Mon, Nov 05, 2001 at 10:23:45PM -0500
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 10:23:45PM -0500, Robert Love wrote:
> The patch is without problem on 2.4.13-ac7.  Free memory increased by
> about 100K: free and dmesg both confirm 384292k vs 384196k.  This is a
> P3-733 on an i815 with 384MB.  Very nice.
> 
> Note that the patch and UP-APIC do not get along.  Some quick debugging
> with William found the cause.  APIC does indeed touch bootmem.  The
> above is thus obviously with CONFIG_X86_UP_APIC unset.
> 
> 	Robert Love

I've managed to reproduce the problem, and I heard from you elsewhere
that you've verified the fix (although it appeared to reduce the memory
savings to 4KB).

start_segment_treap() is a macro (operating largely on the same
principle as list_entry()) which converts a treap_node_t * to a struct *
given the field and struct name by computing offsets and casting. The
casting renders this somewhat less than type safe, and the patch below
corrects a type error I committed in calling it (the start_tree field
is already of type treap_node_t *).



Thanks again,
Bill
-----------------
willir@us.ibm.com

diff -urN linux-broken/mm/bootmem.c linux-bootmem/mm/bootmem.c
--- linux-broken/mm/bootmem.c	Wed Nov  7 16:31:37 2001
+++ linux-bootmem/mm/bootmem.c	Wed Nov  7 16:31:09 2001
@@ -860,7 +860,7 @@
 	while(pgdat) {
 		unsigned in_node;
 
-		tree = start_segment_treap(&pgdat->bdata->segment_tree.start_tree);
+		tree = start_segment_treap(pgdat->bdata->segment_tree.start_tree);
 		in_node = segment_tree_intersects(tree, &segment);
 		in_any_node |= in_node;
 
