Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTEKISG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 04:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTEKISF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 04:18:05 -0400
Received: from holomorphy.com ([66.224.33.161]:23721 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261153AbTEKISF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 04:18:05 -0400
Date: Sun, 11 May 2003 01:30:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct page protection for put_dirty_page
Message-ID: <20030511083035.GI8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@muc.de>, akpm@digeo.com,
	linux-kernel@vger.kernel.org
References: <20030511080841.GA31266@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030511080841.GA31266@averell>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 10:08:41AM +0200, Andi Kleen wrote:
> put_page_dirty must use the page protection of the stack VMA, not hardcoded
> PAGE_COPY. They can be different e.g. when the stack is set non executable
> via VM_STACK_FLAGS.
> I added an fallback path for now because I'm not sure if the stack VMA
> is always predowngrowed here, if the printk better it may be also needed
> to add an stack extension here.

We know which vma is involved at the callsite and what we just set its
vma->vm_page_prot to; I suggest this patch instead.


-- wli


diff -prauN linux-2.5.69-1/fs/exec.c exec-2.5.69-1/fs/exec.c
--- linux-2.5.69-1/fs/exec.c	Wed Apr 16 15:34:51 2003
+++ exec-2.5.69-1/exec.c	Sun May 11 01:27:47 2003
@@ -314,7 +314,7 @@
 	}
 	lru_cache_add_active(page);
 	flush_dcache_page(page);
-	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
+	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, protection_map[VM_STACK_FLAGS & 0x7]))));
 	pte_chain = page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
 	tsk->mm->rss++;
