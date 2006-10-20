Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWJTSW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWJTSW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWJTSW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:22:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030275AbWJTSW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:22:26 -0400
Date: Fri, 20 Oct 2006 11:19:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
Message-Id: <20061020111900.30d3cb03.akpm@osdl.org>
In-Reply-To: <20061020180722.GA8894@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	<20061014111458.GI30596@stusta.de>
	<20061015122453.GA12549@flint.arm.linux.org.uk>
	<20061015124210.GX30596@stusta.de>
	<20061019081753.GA29883@flint.arm.linux.org.uk>
	<20061020180722.GA8894@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 19:07:22 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > > Subject    : undefined reference to highest_possible_node_id
> > > References : http://lkml.org/lkml/2006/9/4/233
> > >              http://lkml.org/lkml/2006/10/15/11
> > > Submitter  : Olaf Hering <olaf@aepfle.de>
> > > Caused-By  : Greg Banks <gnb@melbourne.sgi.com>
> > >              commit 0f532f3861d2c4e5aa7dcd33fb18e9975eb28457
> > > Status     : unknown
> > 
> > Looking at this commit and the mails, it was known on the 4th September
> > that this patch caused build errors while this change was in -mm, yet it
> > still found its way into mainline on 2nd October.
> > 
> > Is anyone going to look at fixing this problem, or should we be asking
> > for the commit to be reverted?
> 
> Since everyone seems intent at ignoring this issue, here's a patch to
> try to solve it.

I sent the below to Linus yesterday...



From: Andrew Morton <akpm@osdl.org>

Qooting Adrian:

- net/sunrpc/svc.c uses highest_possible_node_id()

- include/linux/nodemask.h says highest_possible_node_id() is
  out-of-line #if MAX_NUMNODES > 1

- the out-of-line highest_possible_node_id() is in lib/cpumask.c

- lib/Makefile: lib-$(CONFIG_SMP) += cpumask.o
  CONFIG_ARCH_DISCONTIGMEM_ENABLE=y, CONFIG_SMP=n, CONFIG_SUNRPC=y

-> highest_possible_node_id() is used in net/sunrpc/svc.c
   CONFIG_NODES_SHIFT defined and > 0

-> include/linux/numa.h: MAX_NUMNODES > 1

-> compile error

The bug is not present on architectures where ARCH_DISCONTIGMEM_ENABLE 
depends on NUMA (but m32r isn't the only affected architecture).


So move the function into page_alloc.c

Cc: Adrian Bunk <bunk@stusta.de>
Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 lib/cpumask.c   |   16 ----------------
 mm/page_alloc.c |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff -puN lib/cpumask.c~highest_possible_node_id-linkage-fix lib/cpumask.c
--- a/lib/cpumask.c~highest_possible_node_id-linkage-fix
+++ a/lib/cpumask.c
@@ -43,19 +43,3 @@ int __any_online_cpu(const cpumask_t *ma
 	return cpu;
 }
 EXPORT_SYMBOL(__any_online_cpu);
-
-#if MAX_NUMNODES > 1
-/*
- * Find the highest possible node id.
- */
-int highest_possible_node_id(void)
-{
-	unsigned int node;
-	unsigned int highest = 0;
-
-	for_each_node_mask(node, node_possible_map)
-		highest = node;
-	return highest;
-}
-EXPORT_SYMBOL(highest_possible_node_id);
-#endif
diff -puN mm/page_alloc.c~highest_possible_node_id-linkage-fix mm/page_alloc.c
--- a/mm/page_alloc.c~highest_possible_node_id-linkage-fix
+++ a/mm/page_alloc.c
@@ -3120,3 +3120,19 @@ unsigned long page_to_pfn(struct page *p
 EXPORT_SYMBOL(pfn_to_page);
 EXPORT_SYMBOL(page_to_pfn);
 #endif /* CONFIG_OUT_OF_LINE_PFN_TO_PAGE */
+
+#if MAX_NUMNODES > 1
+/*
+ * Find the highest possible node id.
+ */
+int highest_possible_node_id(void)
+{
+	unsigned int node;
+	unsigned int highest = 0;
+
+	for_each_node_mask(node, node_possible_map)
+		highest = node;
+	return highest;
+}
+EXPORT_SYMBOL(highest_possible_node_id);
+#endif
_

