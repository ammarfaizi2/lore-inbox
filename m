Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVALGcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVALGcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 01:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVALGcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 01:32:36 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:21640 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261238AbVALGc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 01:32:29 -0500
Date: Wed, 12 Jan 2005 12:05:11 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Greg KH <greg@kroah.com>, Nathan Lynch <nathanl@austin.ibm.com>,
       vamsi_krishna@in.ibm.com, suparna@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, maneesh@in.ibm.com
Subject: Re: [PATCH] Kprobes /proc entry
Message-ID: <20050112063511.GB1559@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <41E2AC82.8020909@gmail.com> <20050110181445.GA31209@kroah.com> <1105479077.17592.8.camel@pants.austin.ibm.com> <20050111213400.GB18422@kroah.com> <41E46ACE.2040101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E46ACE.2040101@gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

Applied kernel probes can also be listed using SysRq key.
Below is the small patch that provides this feature.
Please let me know your comments.

Thanks
Prasanna
> 
> Greg KH ha scritto:
> > On Tue, Jan 11, 2005 at 03:31:17PM -0600, Nathan Lynch wrote:
> > 
> >>On Mon, 2005-01-10 at 12:14, Greg KH wrote:
> >>
> >>>On Mon, Jan 10, 2005 at 05:25:38PM +0100, Luca Falavigna wrote:
> >>>
> >>>>This simple patch adds a new file in /proc, listing every kprobe which
> >>>>is currently registered in the kernel. This patch is checked against
> >>>>kernel 2.6.10
> >>>
> >>>No, please do not add extra /proc files to the kernel.  This belongs in
> >>>/sys, as it has _nothing_ to do with processes.
> >>
> >>Wouldn't this sort of thing be a good candidate for debugfs?  If you're
> >>messing with kprobes, then aren't you by definition doing kernel
> >>debugging? :)
> > 
> > 
> > That's an even better idea, I like it.
> > 
> > greg k-h
> > 
> 
> Good, I'll work on it ASAP.
> Thank you for your suggestions!
> 
> 					Luca


---
Users like to list the kprobes inserted into the kernel.
This patch provides Sysrq-key to list all the kernel probes.
Usage Alt+SysRq+W to show the applied kprobes.
or $echo w > /proc/sysrq-trigger

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
---



---

 linux-2.6.10-prasanna/kernel/kprobes.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+)

diff -puN kernel/kprobes.c~kprobes-sysrq-addn-feature kernel/kprobes.c
--- linux-2.6.10/kernel/kprobes.c~kprobes-sysrq-addn-feature	2005-01-12 11:54:08.000000000 +0530
+++ linux-2.6.10-prasanna/kernel/kprobes.c	2005-01-12 11:54:08.000000000 +0530
@@ -29,6 +29,8 @@
  *		exceptions notifier to be first on the priority list.
  */
 #include <linux/kprobes.h>
+#include <linux/sysrq.h>
+#include <linux/kallsyms.h>
 #include <linux/spinlock.h>
 #include <linux/hash.h>
 #include <linux/init.h>
@@ -131,10 +133,35 @@ void unregister_jprobe(struct jprobe *jp
 	unregister_kprobe(&jp->kp);
 }
 
+static void show_kprobes(int key, struct pt_regs *pt_regs, struct tty_struct *tty)
+{
+	int i;
+	struct hlist_node *node;
+
+	/* unsafe: kprobe_lock ought to be taken here */
+	for(i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		if (!hlist_empty(&kprobe_table[i])) {
+			hlist_for_each(node, &kprobe_table[i]) {
+				struct kprobe *p = hlist_entry(node, struct kprobe, hlist);
+				printk("[<%p>] ", p->addr);
+				print_symbol("%s\t", (unsigned long)p->addr);
+				print_symbol("%s\n", (unsigned long)p->pre_handler);
+			}
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
