Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVDSSsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVDSSsC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 14:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVDSSsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 14:48:02 -0400
Received: from galileo.bork.org ([134.117.69.57]:41174 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261562AbVDSSr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 14:47:58 -0400
Date: Tue, 19 Apr 2005 14:47:58 -0400
From: Martin Hicks <mort@wildopensource.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@osdl.org>, holt@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pgtables: fix GFP_KERNEL allocation with preempt disabled
Message-ID: <20050419184758.GI21616@localhost>
References: <20050419170413.GB21616@localhost> <20050419113044.26911ebf.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419113044.26911ebf.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Apr 19, 2005 at 11:30:44AM -0700, David S. Miller wrote:
> 
> I think you should really drop the preempt disable during this allocation
> instead, that's what we do in the sparc64 quicklist code.
> 

Okay, here's an updated patch.

Hi Andrew,

This is a fix to the pgtable_quicklist code.  There is a GFP_KERNEL
allocation in pgtable_quicklist_alloc(), which spews the usual warnings
if the kernel is under heavy VM pressure and the reclaim code is
invoked.  re-enable preempt before we allocate the new page.

This patch is against 2.6.12-rc2-mm2

Signed-off-by:  Martin Hicks <mort@sgi.com>


 pgalloc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc2.wk/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.12-rc2.wk.orig/include/asm-ia64/pgalloc.h	2005-04-19 10:13:16.000000000 -0700
+++ linux-2.6.12-rc2.wk/include/asm-ia64/pgalloc.h	2005-04-19 11:40:09.000000000 -0700
@@ -49,12 +49,12 @@ static inline void *pgtable_quicklist_al
 		pgtable_quicklist = (unsigned long *)(*ret);
 		ret[0] = 0;
 		--pgtable_quicklist_size;
+		preempt_enable();
 	} else {
+		preempt_enable();
 		ret = (unsigned long *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 	}
 
-	preempt_enable();
-
 	return ret;
 }
 
