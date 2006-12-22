Return-Path: <linux-kernel-owner+w=401wt.eu-S1751786AbWLVTMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWLVTMD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWLVTMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:12:03 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37520 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbWLVTMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:12:01 -0500
Date: Fri, 22 Dec 2006 11:10:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-Id: <20061222111058.bb101d81.akpm@osdl.org>
In-Reply-To: <20061222141655.GE31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com>
	<20061222082248.GY31882@telegraafnet.nl>
	<20061222003029.4394bd9a.akpm@osdl.org>
	<20061222103005.GC31882@telegraafnet.nl>
	<20061222140059.GD31882@telegraafnet.nl>
	<20061222141655.GE31882@telegraafnet.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 15:16:55 +0100
Ard -kwaak- van Breemen <ard@telegraafnet.nl> wrote:

> On Fri, Dec 22, 2006 at 03:00:59PM +0100, Ard -kwaak- van Breemen wrote:
> >     262         if (!irqs_disabled()) printk(__FILE__ "%s(): blaat: interrupts were enabled early@%d\n",__FUNCTION__,__LINE__);
> >     263 
> >     264         ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
> ------------------------------------------^^^^^^^^^^^^^^^^^^^^^^^^^^^
> which does a         if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID,
> in include/asm-i386/ide.h
> 
> which should be really the part that does the irq enabling.

doh, I missed down_read():

--- a/lib/rwsem-spinlock.c~down_write-preserve-local-irqs
+++ a/lib/rwsem-spinlock.c
@@ -129,13 +129,14 @@ void fastcall __sched __down_read(struct
 {
 	struct rwsem_waiter waiter;
 	struct task_struct *tsk;
+	unsigned long flags;
 
-	spin_lock_irq(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (sem->activity >= 0 && list_empty(&sem->wait_list)) {
 		/* granted */
 		sem->activity++;
-		spin_unlock_irq(&sem->wait_lock);
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
 		goto out;
 	}
 
@@ -150,7 +151,7 @@ void fastcall __sched __down_read(struct
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock_irq(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -195,13 +196,14 @@ void fastcall __sched __down_write_neste
 {
 	struct rwsem_waiter waiter;
 	struct task_struct *tsk;
+	unsigned long flags;
 
-	spin_lock_irq(&sem->wait_lock);
+	spin_lock_irqsave(&sem->wait_lock, flags);
 
 	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
 		/* granted */
 		sem->activity = -1;
-		spin_unlock_irq(&sem->wait_lock);
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
 		goto out;
 	}
 
@@ -216,7 +218,7 @@ void fastcall __sched __down_write_neste
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock_irq(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	/* wait to be given the lock */
 	for (;;) {
_

