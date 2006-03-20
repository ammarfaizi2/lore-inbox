Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWCTHK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWCTHK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 02:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWCTHK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 02:10:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932174AbWCTHK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 02:10:57 -0500
Date: Sun, 19 Mar 2006 23:07:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       ak@suse.de, pj@sgi.com, haveblue@us.ibm.com, mingo@elte.hu,
       clameter@sgi.com
Subject: Re: [PATCH] Cpuset: alloc_pages_node overrides cpuset constraints
Message-Id: <20060319230712.5b15ee3e.akpm@osdl.org>
In-Reply-To: <20060318204027.13217.34767.sendpatchset@sam.engr.sgi.com>
References: <20060318204027.13217.34767.sendpatchset@sam.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> @@ -113,6 +114,11 @@ static inline struct page *alloc_pages_n
>   	/* Unknown node is current node */
>   	if (nid < 0)
>   		nid = numa_node_id();
>  +	/*
>  +	 * Specified (or implied by nid < 0) node overrides cpuset placement.
>  +	 * Various slab, page and device node specific allocations need this.
>  +	 */
>  +	gfp_mask |= __GFP_NOCPUSET;

You're kidding.  This adds more code to every page allocation on every
machine, cpusets or not.

I stuck this on top:

--- devel/include/linux/gfp.h~cpuset-alloc_pages_node-overrides-cpuset-constraints-speedup	2006-03-19 23:01:04.000000000 -0800
+++ devel-akpm/include/linux/gfp.h	2006-03-19 23:01:04.000000000 -0800
@@ -47,7 +47,11 @@ struct vm_area_struct;
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
+#ifdef CONFIG_CPUSETS
 #define __GFP_NOCPUSET	((__force gfp_t)0x40000u)/* Ignore cpuset constraints */
+#else
+#define __GFP_NOCPUSET	((__force gfp_t)0u)
+#endif
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
_

But it's a bit ugly.
