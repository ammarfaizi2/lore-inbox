Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269822AbUJGWGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269822AbUJGWGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJGWES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:04:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:6815 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269356AbUJGWDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:03:21 -0400
Date: Thu, 7 Oct 2004 15:07:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.9-rc3-mm3
Message-Id: <20041007150708.5d60e1c3.akpm@osdl.org>
In-Reply-To: <1097185597l.10532l.1l@werewolf.able.es>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
	<20041007025007.77ec1a44.akpm@osdl.org>
	<20041007114040.GV9106@holomorphy.com>
	<1097184341l.10532l.0l@werewolf.able.es>
	<1097185597l.10532l.1l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On 2004.10.07, J.A. Magallon wrote:
> > 
> > This conflicts with kernel/irq/proc.c:
> > 
> > 	unsigned long prof_cpu_mask = -1;
> > 
> > Shouldn't this be:
> > 
> > 	cpumask_t prof_cpu_mask = CPU_MASK_NONE;
> > 
> > This will show problems when NR_CPUS > sizeof(long)....
> > 
> 
> Err....
> 
> There is a problem with this -mm:

Yes, there seems to be a mingo/wli bunfight over prof_cpu_mask.

Something like this, I think:

--- 25/kernel/irq/proc.c~prof-irq-mask-fixup	Thu Oct  7 15:04:14 2004
+++ 25-akpm/kernel/irq/proc.c	Thu Oct  7 15:05:30 2004
@@ -10,8 +10,6 @@
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
 
-unsigned long prof_cpu_mask = -1;
-
 static struct proc_dir_entry *root_irq_dir, *irq_dir[NR_IRQS];
 
 #ifdef CONFIG_SMP
@@ -65,34 +63,6 @@ static int irq_affinity_write_proc(struc
 
 #endif
 
-static int prof_cpu_mask_read_proc(char *page, char **start, off_t off,
-				   int count, int *eof, void *data)
-{
-	int len = cpumask_scnprintf(page, count, *(cpumask_t *)data);
-
-	if (count - len < 2)
-		return -EINVAL;
-	len += sprintf(page + len, "\n");
-	return len;
-}
-
-static int prof_cpu_mask_write_proc(struct file *file,
-				    const char __user *buffer,
-				    unsigned long count, void *data)
-{
-	unsigned long full_count = count, err;
-	cpumask_t *mask = (cpumask_t *)data;
-	cpumask_t new_value;
-
-	err = cpumask_parse(buffer, count, new_value);
-	if (err)
-		return err;
-
-	*mask = new_value;
-
-	return full_count;
-}
-
 #define MAX_NAMELEN 128
 
 void register_handler_proc(unsigned int irq, struct irqaction *action)
@@ -156,7 +126,6 @@ void unregister_handler_proc(unsigned in
 
 void init_irq_proc(void)
 {
-	struct proc_dir_entry *entry;
 	int i;
 
 	/* create /proc/irq */
@@ -164,16 +133,6 @@ void init_irq_proc(void)
 	if (!root_irq_dir)
 		return;
 
-	/* create /proc/irq/prof_cpu_mask */
-	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
-	if (!entry)
-		return;
-
-	entry->nlink = 1;
-	entry->data = (void *)&prof_cpu_mask;
-	entry->read_proc = prof_cpu_mask_read_proc;
-	entry->write_proc = prof_cpu_mask_write_proc;
-
 	/*
 	 * Create entries for all existing IRQs.
 	 */
_

