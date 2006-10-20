Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992592AbWJTSHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992592AbWJTSHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992608AbWJTSHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:07:32 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:59403 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S2992592AbWJTSHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:07:30 -0400
Date: Fri, 20 Oct 2006 19:07:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
Message-ID: <20061020180722.GA8894@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061014111458.GI30596@stusta.de> <20061015122453.GA12549@flint.arm.linux.org.uk> <20061015124210.GX30596@stusta.de> <20061019081753.GA29883@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019081753.GA29883@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 09:17:54AM +0100, Russell King wrote:
> On Sun, Oct 15, 2006 at 02:42:10PM +0200, Adrian Bunk wrote:
> > On Sun, Oct 15, 2006 at 01:24:54PM +0100, Russell King wrote:
> > > On Sat, Oct 14, 2006 at 01:14:58PM +0200, Adrian Bunk wrote:
> > > > As usual, we are swamped with bug reports for regressions after -rc1.
> > > > 
> > > > For an easier reading (and hoping linux-kernel might not eat the emails), 
> > > > I've splitted the list of known regressions in three emails:
> > > >   [1/3] known unfixed regressions
> > > >   [2/3] knwon regressions with workarounds
> > > >   [3/3] known regressions with patches
> > > 
> > > There's a raft of ARM regressions as well (see
> > > http://armlinux.simtec.co.uk/kautobuild/2.6.19-rc2/index.html), mostly
> > > related to the IRQ changes, as well as this error:
> > 
> > Thanks, I'll look at them before preparing the next version of my 
> > regressions list.
> > 
> > > sysctl_net.c:(.text+0x64a8c): undefined reference to `highest_possible_node_id'
> > 
> > This problem already got an entry a few hours ago:
> > 
> > Subject    : undefined reference to highest_possible_node_id
> > References : http://lkml.org/lkml/2006/9/4/233
> >              http://lkml.org/lkml/2006/10/15/11
> > Submitter  : Olaf Hering <olaf@aepfle.de>
> > Caused-By  : Greg Banks <gnb@melbourne.sgi.com>
> >              commit 0f532f3861d2c4e5aa7dcd33fb18e9975eb28457
> > Status     : unknown
> 
> Looking at this commit and the mails, it was known on the 4th September
> that this patch caused build errors while this change was in -mm, yet it
> still found its way into mainline on 2nd October.
> 
> Is anyone going to look at fixing this problem, or should we be asking
> for the commit to be reverted?

Since everyone seems intent at ignoring this issue, here's a patch to
try to solve it.

Probably will suffer from occasionally not being included in the kernel,
and therefore the function not exported for modules, but at least it's
a _lot_ better than the current utterly broken situation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/lib/Makefile b/lib/Makefile
index cf98fab..8845514 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@ #
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o irq_regs.o
+	 sha1.o irq_regs.o nodemask.o
 
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 7a2a73f..3a67dc5 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
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
diff --git a/lib/nodemask.c b/lib/nodemask.c
new file mode 100644
index 0000000..6c49eb5
--- /dev/null
+++ b/lib/nodemask.c
@@ -0,0 +1,19 @@
+#include <linux/kernel.h>
+#include <linux/cpumask.h>
+#include <linux/module.h>
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


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
