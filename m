Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbTEWLJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 07:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTEWLJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 07:09:22 -0400
Received: from dp.samba.org ([66.70.73.150]:14052 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264021AbTEWLJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 07:09:21 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16078.1121.582683.336497@argo.ozlabs.ibm.com>
Date: Fri, 23 May 2003 21:22:09 +1000
To: Andrew Morton <akpm@digeo.com>
Cc: "Lothar Wassmann" <LW@KARO-electronics.de>, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
In-Reply-To: <20030523034551.0f80b17f.akpm@digeo.com>
References: <16076.50160.67366.435042@ipc1.karo>
	<20030522151156.C12171@flint.arm.linux.org.uk>
	<16077.55787.797668.329213@ipc1.karo>
	<20030523022454.61a180dd.akpm@digeo.com>
	<16077.61981.684846.221686@ipc1.karo>
	<20030523034551.0f80b17f.akpm@digeo.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> filemap_nopage isn't the right place to be doing these things though.
> 
> Given that there was no page at the virtual address before filemap_nopage
> was called I don't think any CPU cache writeback or invalidation need be
> performed.  Perhaps a writeback or invalidate is missing somewhere in the
> unmap paths, or there is a problem in arch/arm somewhere.
> 
> We have a no-op flush_icache_page() in do_no_page(), but I don't know what
> that thing ever did, not what it's doing in there.  (What happens if you
> replace it with a flush_cache_page(vma, address)?)

We used to use flush_icache_page() on ppc/ppc64 to ensure that the
i-cache was consistent with the d-cache and with memory.  It was
needed in do_no_page for the case where the page had just been read in
and the i-cache could have stale data reflecting the previous contents
of the page (the i-cache doesn't snoop on ppc).  But we now do that in
update_mmu_cache.

Paul.
