Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVBNXQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVBNXQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVBNXQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:16:04 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12563
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261165AbVBNXP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:15:57 -0500
Date: Tue, 15 Feb 2005 00:15:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20050214231554.GQ13712@opteron.random>
References: <20041028192104.GA3454@dualathlon.random> <20041105080716.GL8229@dualathlon.random> <20041105083102.GD16992@wotan.suse.de> <20041105084900.GN8229@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105084900.GN8229@dualathlon.random>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the fix for this bug in 2.6.11-rc3 for this bug is wrong, I thought I
posted the right one (that I already applied to all SUSE branches except
the HEAD branch that probably is in sync with the inferior fix in
mainline). Right fix is the below one. And then of course drop those
useless -PAGE_SIZE in change_page_attr p->size parameter in the arch
code. Exposing vmalloc.c internal knowledge of the guard-page-size into
the arch code is an unnecssary breakage of the vmalloc abstraction and
I've been very careful to avoid that and I thought I posted it too. It
has been even quicker to fix it right for me in a single place than to
hand edit the (not single) change_page_attr callers. I'd like the right
fix to obsolete the hand editing of arch code in multiple places that
breaks the layering. Thanks.

From: Andrea Arcangeli <andrea@suse.de>
Subject: reject zero page vm-area request, align size properly
 and hide the guard page from the callers like ioremap - this avoids
 a kernel crash due one more page being passed to change_page_attr

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- sl9.2/mm/vmalloc.c.~1~	2004-12-04 01:44:23.352416128 +0100
+++ sl9.2/mm/vmalloc.c	2004-12-04 03:02:37.299827656 +0100
@@ -199,20 +199,22 @@ struct vm_struct *__get_vm_area(unsigned
 		align = 1ul << bit;
 	}
 	addr = ALIGN(start, align);
+	size = PAGE_ALIGN(size);
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
 		return NULL;
 
-	/*
-	 * We always allocate a guard page.
-	 */
-	size += PAGE_SIZE;
 	if (unlikely(!size)) {
 		kfree (area);
 		return NULL;
 	}
 
+	/*
+	 * We always allocate a guard page.
+	 */
+	size += PAGE_SIZE;
+
 	write_lock(&vmlist_lock);
 	for (p = &vmlist; (tmp = *p) != NULL ;p = &tmp->next) {
 		if ((unsigned long)tmp->addr < addr) {
@@ -290,6 +292,11 @@ found:
 	unmap_vm_area(tmp);
 	*p = tmp->next;
 	write_unlock(&vmlist_lock);
+
+	/*
+	 * Remove the guard page.
+	 */
+	tmp->size -= PAGE_SIZE;
 	return tmp;
 }
 



