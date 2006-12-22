Return-Path: <linux-kernel-owner+w=401wt.eu-S1423130AbWLVPmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423130AbWLVPmh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 10:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423168AbWLVPmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 10:42:37 -0500
Received: from smtp0.telegraaf.nl ([217.196.45.192]:37822 "EHLO
	smtp0.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423130AbWLVPmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 10:42:36 -0500
Date: Fri, 22 Dec 2006 16:42:34 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061222154234.GI31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222144134.GH31882@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <20061222144134.GH31882@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 22, 2006 at 03:41:34PM +0100, Ard -kwaak- van Breemen wrote:
> Repeating: I am very stupid, so I don't know if saving the irq state is ok or
> not in down_read.
The Andrew Morton patch but the rewritten for down_read makes the
symptoms go away.

The problem obviously is that the ide_setup pokes the pci
subsystem way too early.
Parsing of the ide parameters should be delayed until the next
run of parse_args I guess.

--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rwsem-spinlock.patch"

--- linux-2.6.19.1/lib/rwsem-spinlock.c	2006-12-11 19:32:53.000000000 +0000
+++ linux-2.6.19/lib/rwsem-spinlock.c	2006-12-22 15:06:52.000000000 +0000
@@ -129,13 +129,14 @@
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
 
@@ -150,7 +151,7 @@
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock_irq(&sem->wait_lock);
+	spin_unlock_irqrestore(&sem->wait_lock, flags); 
 
 	/* wait to be given the lock */
 	for (;;) {

--LTeJQqWS0MN7I/qa--
