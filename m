Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVCKDhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVCKDhA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVCKDhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:37:00 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:13495 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261695AbVCKDgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:36:13 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 14:36:10 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
Subject: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As many of you will be aware, we've been working on infrastructure for
user-mode PCI and other drivers.  The first step is to be able to
handle interrupts from user space. Subsequent patches add
infrastructure for setting up DMA for PCI devices.

The user-level interrupt code doesn't depend on the other patches, and
is probably the most mature of this patchset.


This patch adds a new file to /proc/irq/<nnn>/ called irq.  Suitably 
privileged processes can open this file.  Reading the file returns the 
number of interrupts (if any) that have occurred since the last read.
If the file is opened in blocking mode, reading it blocks until 
an interrupt occurs.  poll(2) and select(2) work as one would expect, to 
allow interrupts to be one of many events to wait for.
(If you didn't like the file, one could have a special system call to
return the file descriptor).

Interrupts are usually masked; while a thread is in poll(2) or read(2) on the 
file they are unmasked.  

All architectures that use CONFIG_GENERIC_HARDIRQ are supported by
this patch.

A low latency user level interrupt handler would do something like
this, on a CONFIG_PREEMPT kernel:

  int irqfd;
  int n_ints;
  struct sched_param sched_param;

  irqfd = open("/proc/irq/513/irq", O_RDONLY);
  mlockall()
  sched_param.sched_priority = sched_get_priority_max(SCHED_FIFO) - 10;
  sched_setscheduler(0, SCHED_FIFO, &sched_param);

  while(read(irqfd, n_ints, sizeof n_ints) == sizeof nints) {
       ... talk to device to handle interrupt
  }

If you don't care about latency, then forget about the mlockall() and
setting the priority, and you don't need CONFIG_PREEMPT.

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

 kernel/irq/proc.c |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 153 insertions(+), 10 deletions(-)

Index: linux-2.6.11-usrdrivers/kernel/irq/proc.c
===================================================================
--- linux-2.6.11-usrdrivers.orig/kernel/irq/proc.c	2005-03-11 10:30:57.875619102 +1100
+++ linux-2.6.11-usrdrivers/kernel/irq/proc.c	2005-03-11 10:45:07.146928168 +1100
@@ -9,6 +9,8 @@
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
+#include <linux/poll.h>
+#include "internals.h"
 
 static struct proc_dir_entry *root_irq_dir, *irq_dir[NR_IRQS];
 
@@ -90,27 +92,168 @@
 	action->dir = proc_mkdir(name, irq_dir[irq]);
 }
 
+struct irq_proc {
+ 	unsigned long irq;
+ 	wait_queue_head_t q;
+ 	atomic_t count;
+ 	char devname[TASK_COMM_LEN];
+};
+ 
+static irqreturn_t irq_proc_irq_handler(int irq, void *vidp, struct pt_regs *regs)
+{
+ 	struct irq_proc *idp = (struct irq_proc *)vidp;
+ 
+ 	BUG_ON(idp->irq != irq);
+ 	disable_irq_nosync(irq);
+ 	atomic_inc(&idp->count);
+ 	wake_up(&idp->q);
+ 	return IRQ_HANDLED;
+}
+ 
+
+/*
+ * Signal to userspace an interrupt has occured.
+ */
+static ssize_t irq_proc_read(struct file *filp, char  __user *bufp, size_t len, loff_t *ppos)
+{
+ 	struct irq_proc *ip = (struct irq_proc *)filp->private_data;
+ 	irq_desc_t *idp = irq_desc + ip->irq;
+ 	int pending;
+	
+ 	DEFINE_WAIT(wait);
+	
+ 	if (len < sizeof(int))
+ 		return -EINVAL;
+	
+	pending = atomic_read(&ip->count);
+ 	if (pending == 0) {
+ 		if (idp->status & IRQ_DISABLED)
+ 			enable_irq(ip->irq);
+ 		if (filp->f_flags & O_NONBLOCK)
+ 			return -EWOULDBLOCK;
+ 	}
+	
+ 	while (pending == 0) {
+ 		prepare_to_wait(&ip->q, &wait, TASK_INTERRUPTIBLE);
+		pending = atomic_read(&ip->count);
+		if (pending == 0)
+ 			schedule();
+ 		finish_wait(&ip->q, &wait);
+ 		if (signal_pending(current))
+ 			return -ERESTARTSYS;
+ 	}
+	
+ 	if (copy_to_user(bufp, &pending, sizeof pending))
+ 		return -EFAULT;
+
+ 	*ppos += sizeof pending;
+	
+ 	atomic_sub(pending, &ip->count);
+ 	return sizeof pending;
+}
+
+
+static int irq_proc_open(struct inode *inop, struct file *filp)
+{
+ 	struct irq_proc *ip;
+ 	struct proc_dir_entry *ent = PDE(inop);
+ 	int error;
+
+ 	ip = kmalloc(sizeof *ip, GFP_KERNEL);
+ 	if (ip == NULL)
+ 		return -ENOMEM;
+	
+ 	memset(ip, 0, sizeof(*ip));
+ 	strcpy(ip->devname, current->comm);
+ 	init_waitqueue_head(&ip->q);
+ 	atomic_set(&ip->count, 0);
+ 	ip->irq = (unsigned long)ent->data;
+	
+ 	error = request_irq(ip->irq,
+			    irq_proc_irq_handler,
+			    SA_INTERRUPT,
+			    ip->devname,
+			    ip);
+	if (error < 0) {
+		kfree(ip);
+		return error;
+	}
+ 	filp->private_data = (void *)ip;
+
+ 	return 0;
+}
+
+static int irq_proc_release(struct inode *inop, struct file *filp)
+{
+ 	struct irq_proc *ip = (struct irq_proc *)filp->private_data;
+ 	(void)inop;
+ 	free_irq(ip->irq, ip);
+ 	filp->private_data = NULL;
+ 	kfree(ip);
+ 	return 0;
+}
+
+static unsigned int irq_proc_poll(struct file *filp, struct poll_table_struct *wait)
+{
+ 	struct irq_proc *ip = (struct irq_proc *)filp->private_data;
+ 	irq_desc_t *idp = irq_desc + ip->irq;
+	
+ 	if (atomic_read(&ip->count) > 0)
+ 		return POLLIN | POLLRDNORM; /* readable */
+
+ 	/* if interrupts disabled and we don't have one to process... */
+ 	if (idp->status & IRQ_DISABLED)
+ 		enable_irq(ip->irq);
+
+ 	poll_wait(filp, &ip->q, wait);
+
+ 	if (atomic_read(&ip->count) > 0)
+ 		return POLLIN | POLLRDNORM; /* readable */
+
+ 	return 0;
+}
+
+static struct file_operations irq_proc_file_operations = {
+ 	.read = irq_proc_read,
+ 	.open = irq_proc_open,
+ 	.release = irq_proc_release,
+ 	.poll = irq_proc_poll,
+};
+ 
 #undef MAX_NAMELEN
 
 #define MAX_NAMELEN 10
 
 void register_irq_proc(unsigned int irq)
 {
+	struct proc_dir_entry *entry;
 	char name [MAX_NAMELEN];
 
-	if (!root_irq_dir ||
-		(irq_desc[irq].handler == &no_irq_type) ||
-			irq_dir[irq])
+	if (!root_irq_dir)
 		return;
-
-	memset(name, 0, MAX_NAMELEN);
-	sprintf(name, "%d", irq);
-
-	/* create /proc/irq/1234 */
-	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
+	
+	if (!irq_dir[irq]) {
+		memset(name, 0, MAX_NAMELEN);
+		sprintf(name, "%d", irq);
+
+		/* create /proc/irq/1234 */
+		irq_dir[irq] = proc_mkdir(name, root_irq_dir);
+
+		/* 
+		 * Create handles for user-mode interrupt handlers
+		 * if the kernel hasn't already grabbed the IRQ
+		 */
+ 		entry = create_proc_entry("irq", 0600, irq_dir[irq]);
+ 		if (entry) {
+ 			entry->data = (void *)(unsigned long)irq;
+ 			entry->read_proc = NULL;
+ 			entry->write_proc = NULL;
+ 			entry->proc_fops = &irq_proc_file_operations;
+ 		}
+	}
 
 #ifdef CONFIG_SMP
-	{
+	if (!smp_affinity_entry[irq]) {
 		struct proc_dir_entry *entry;
 
 		/* create /proc/irq/<irq>/smp_affinity */
