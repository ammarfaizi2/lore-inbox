Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUBRJYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 04:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUBRJYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 04:24:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:20713 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263851AbUBRJYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 04:24:44 -0500
Date: Wed, 18 Feb 2004 01:25:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: 2.6.3-mm1
Message-Id: <20040218012553.1228ae34.akpm@osdl.org>
In-Reply-To: <20040217234314.1cbe76c3.akpm@osdl.org>
References: <20040217232130.61667965.akpm@osdl.org>
	<20040217234314.1cbe76c3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
>  >
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm1/
> 
>  oops, it appears that rmmod hangs in D state all the time.  

Fixes:


 kernel/stop_machine.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/stop_machine.c~hotplugcpu-generalise-bogolock-fix-for-kthread-stop-using-signals kernel/stop_machine.c
--- 25/kernel/stop_machine.c~hotplugcpu-generalise-bogolock-fix-for-kthread-stop-using-signals	2004-02-18 01:14:27.000000000 -0800
+++ 25-akpm/kernel/stop_machine.c	2004-02-18 01:14:54.000000000 -0800
@@ -148,7 +148,7 @@ static int do_stop(void *_smdata)
 	complete(&smdata->done);
 
 	/* Wait for kthread_stop */
-	while (!signal_pending(current)) {
+	while (!kthread_should_stop()) {
 		__set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
 	}

_


 kernel/softirq.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/softirq.c~hotplugcpu-core-fix-for-kthread-stop-using-signals kernel/softirq.c
--- 25/kernel/softirq.c~hotplugcpu-core-fix-for-kthread-stop-using-signals	2004-02-18 01:19:14.000000000 -0800
+++ 25-akpm/kernel/softirq.c	2004-02-18 01:19:29.000000000 -0800
@@ -349,7 +349,7 @@ static int ksoftirqd(void * __bind_cpu)
 wait_to_die:
 	preempt_enable();
 	/* Wait for kthread_stop */
-	while (!signal_pending(current)) {
+	while (!kthread_should_stop()) {
 		__set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
 	}

_


 ipc/shm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN ipc/shm.c~add-syscalls_h-shmat-fix ipc/shm.c
--- 25/ipc/shm.c~add-syscalls_h-shmat-fix	2004-02-18 01:22:41.000000000 -0800
+++ 25-akpm/ipc/shm.c	2004-02-18 01:22:41.000000000 -0800
@@ -635,7 +635,7 @@ out:
  * "raddr" thing points to kernel space, and there has to be a wrapper around
  * this.
  */
-long sys_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
+asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
 {
 	struct shmid_kernel *shp;
 	unsigned long addr;

_

