Return-Path: <linux-kernel-owner+w=401wt.eu-S932767AbWL0VeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWL0VeM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWL0VeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:34:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37030 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932767AbWL0VeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:34:12 -0500
Date: Wed, 27 Dec 2006 22:31:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] update kmap_atomic on !HIGHMEM
Message-ID: <20061227213150.GA15638@elte.hu>
References: <20061227193550.324850000@mvista.com> <20061227212555.GA14947@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227212555.GA14947@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


plus on i386 the fix below is needed as well.

	Ingo

---
 include/asm-i386/highmem.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux/include/asm-i386/highmem.h
===================================================================
--- linux.orig/include/asm-i386/highmem.h
+++ linux/include/asm-i386/highmem.h
@@ -81,9 +81,9 @@ struct page *__kmap_atomic_to_page(void 
  * on PREEMPT_RT kmap_atomic() is a wrapper that uses kmap():
  */
 #ifdef CONFIG_PREEMPT_RT
-#  define kmap_atomic(page, type)	kmap(page)
-#  define kmap_atomic_pfn(pfn, type)	kmap(pfn_to_page(pfn))
-#  define kunmap_atomic(kvaddr, type)	kunmap_virt(kvaddr)
+#  define kmap_atomic(page, type)	({ pagefault_disable(); kmap(page); })
+#  define kmap_atomic_pfn(pfn, type)	kmap_atomic(pfn_to_page(pfn), type)
+#  define kunmap_atomic(kvaddr, type)	do { pagefault_enable(); kunmap_virt(kvaddr); } while (0)
 #  define kmap_atomic_to_page(kvaddr)	kmap_to_page(kvaddr)
 #else
 # define kmap_atomic(page, type)	__kmap_atomic(page, type)
