Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVJWQy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVJWQy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 12:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVJWQy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 12:54:28 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:3980 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750752AbVJWQy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 12:54:27 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17243.49227.130982.289593@gargle.gargle.HOWL>
Date: Sun, 23 Oct 2005 20:54:35 +0400
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Lameter <clameter@sgi.com>, Russell King <rmk@arm.linux.org.uk>,
       Matthew Wilcox <matthew@wil.cx>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mm: split page table lock
Newsgroups: gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins writes:

[...]

 > + * When freeing, reset page->mapping so free_pages_check won't complain.
 > + */
 > +#define __pte_lockptr(page)	((spinlock_t *)&((page)->private))
 > +#define pte_lock_init(_page)	do {					\
 > +	BUILD_BUG_ON((size_t)(__pte_lockptr((struct page *)0) + 1) >	\
 > +						sizeof(struct page));	\
 > +	spin_lock_init(__pte_lockptr(_page));				\
 > +} while (0)

Looking at this, I think BUILD_BUG_ON() should be defined in a way that
allows it to be used outside of function scope too (see patch below,
compile-tested).

Nikita.
--
Fix comment describing BUILD_BUG_ON: BUG_ON is not an assertion
(unfortunately).

Also implement BUILD_BUG_ON in a way that can be used outside of a function
scope, so that compile time checks can be placed in convenient places (like in
a header, close to the definition of related constants and data-types).

Signed-off-by: Nikita Danilov <nikita@clusterfs.com>

 include/linux/kernel.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN include/linux/kernel.h~BUILD_BUG_ON-fix-comment include/linux/kernel.h
--- git-linux/include/linux/kernel.h~BUILD_BUG_ON-fix-comment	2005-10-23 20:09:33.000000000 +0400
+++ git-linux-nikita/include/linux/kernel.h	2005-10-23 20:44:03.000000000 +0400
@@ -307,8 +307,9 @@ struct sysinfo {
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
-/* Force a compilation error if condition is false */
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
+/* Force a compilation error if condition is true */
+#define BUILD_BUG_ON(x)							\
+	void __dummy_build_bug_on(int __compile_time_assertion_failed_[-!!(x)])
 
 #ifdef CONFIG_SYSCTL
 extern int randomize_va_space;

_
