Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVALJqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVALJqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 04:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVALJqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 04:46:53 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63182 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261307AbVALJqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 04:46:48 -0500
Date: Wed, 12 Jan 2005 15:19:35 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Greg KH <greg@kroah.com>, Nathan Lynch <nathanl@austin.ibm.com>,
       vamsi_krishna@in.ibm.com, suparna@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, maneesh@in.ibm.com
Subject: Re: [PATCH] Kprobes /proc entry
Message-ID: <20050112094935.GD1559@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <41E2AC82.8020909@gmail.com> <20050110181445.GA31209@kroah.com> <1105479077.17592.8.camel@pants.austin.ibm.com> <20050111213400.GB18422@kroah.com> <41E46ACE.2040101@gmail.com> <20050112063511.GB1559@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112063511.GB1559@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

Below is the latest patch that provides sysrq key feature
to list the applied kernel probes.
Please let me know your comments.

Thanks
Prasanna

---
Users like to list the kprobes inserted into the kernel.
This patch provides Sysrq-key to list all the kernel probes.
Usage Alt+SysRq+W to show the applied kprobes.
or $echo w > /proc/sysrq-trigger

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
---



---

 linux-2.6.10-prasanna/kernel/kprobes.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -puN kernel/kprobes.c~kprobes-sysrq-addn-feature kernel/kprobes.c
--- linux-2.6.10/kernel/kprobes.c~kprobes-sysrq-addn-feature	2005-01-12 12:29:49.000000000 +0530
+++ linux-2.6.10-prasanna/kernel/kprobes.c	2005-01-12 14:52:49.000000000 +0530
@@ -29,6 +29,8 @@
  *		exceptions notifier to be first on the priority list.
  */
 #include <linux/kprobes.h>
+#include <linux/sysrq.h>
+#include <linux/kallsyms.h>
 #include <linux/spinlock.h>
 #include <linux/hash.h>
 #include <linux/init.h>
@@ -131,10 +133,33 @@ void unregister_jprobe(struct jprobe *jp
 	unregister_kprobe(&jp->kp);
 }
 
+static void show_kprobes(int key, struct pt_regs *pt_regs, struct tty_struct *tty)
+{
+	int i;
+	struct hlist_node *node;
+
+	/* unsafe: kprobe_lock ought to be taken here */
+	for(i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		struct kprobe *p;
+		hlist_for_each_entry(p, node, &kprobe_table[i], hlist) {
+				printk("[<%p>] ", p->addr);
+				print_symbol("%s\t", (unsigned long)p->addr);
+				print_symbol("%s\n", (unsigned long)p->pre_handler);
+		}
+	}
+}
+
+static struct sysrq_key_op sysrq_show_kprobes = {
+	.handler        = show_kprobes,
+	.help_msg       = "shoWkprobes",
+	.action_msg     = "Show kprobes\n"
+};
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
 
+	register_sysrq_key('w', &sysrq_show_kprobes);
 	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++)

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
