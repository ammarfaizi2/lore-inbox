Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTKSKuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264001AbTKSKuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:50:54 -0500
Received: from holomorphy.com ([199.26.172.102]:169 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263997AbTKSKuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:50:52 -0500
Date: Wed, 19 Nov 2003 02:50:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm4
Message-ID: <20031119105049.GS22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031118225120.1d213db2.akpm@osdl.org> <20031119090223.GO22764@holomorphy.com> <20031119011951.66300f0d.akpm@osdl.org> <20031119093340.GP22764@holomorphy.com> <20031119101322.GQ22764@holomorphy.com> <20031119103419.GR22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119103419.GR22764@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 02:34:19AM -0800, William Lee Irwin III wrote:
> The following, incremental atop the smp_local_irq_*() removal, turns
> shrink_pagetable_cache() into a set_shrinker()-registered shrinker_t.
> I'm not entirely sure how good an idea this is given my prior remarks
> about the vmscan.c code skipping shrink_slab() under highmem pressure.
> Maybe the proper solution is teaching true slab shrinkers to honor
> the gfp_mask argument?
> This is also untested (apart from compiletesting).

If any of this goes anywhere, I probably deserve a wee bit of credit
for getting it done (well, I did put some time into it). Here's me
patting myself on the back, incremental atop the previous two.


-- wli



diff -prauN mm4-2.6.0-test9-4/arch/i386/mm/pgtable.c mm4-2.6.0-test9-5/arch/i386/mm/pgtable.c
--- mm4-2.6.0-test9-4/arch/i386/mm/pgtable.c	2003-11-19 02:26:04.000000000 -0800
+++ mm4-2.6.0-test9-5/arch/i386/mm/pgtable.c	2003-11-19 02:46:50.000000000 -0800
@@ -1,5 +1,6 @@
 /*
  *  linux/arch/i386/mm/pgtable.c
+ *  highpte-compatible pte cacheing, William Irwin, IBM, June 2003
  */
 
 #include <linux/config.h>
