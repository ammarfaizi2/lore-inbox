Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266416AbUBRMiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUBRMiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:38:13 -0500
Received: from zork.zork.net ([64.81.246.102]:33196 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266512AbUBRMiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:38:01 -0500
To: Jonathan Brown <jbrown@emergence.uk.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
References: <20040217232130.61667965.akpm@osdl.org>
	<4033491C.40407@emergence.uk.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Jonathan Brown <jbrown@emergence.uk.net>, Andrew Morton
 <akpm@osdl.org>,  linux-kernel@vger.kernel.org
Date: Wed, 18 Feb 2004 12:37:50 +0000
In-Reply-To: <4033491C.40407@emergence.uk.net> (Jonathan Brown's message of
 "Wed, 18 Feb 2004 11:14:36 +0000")
Message-ID: <6un07gh8bl.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Brown <jbrown@emergence.uk.net> writes:

> When I try to startx with this kernel I get this error:
>
> (EE) RADEON(0): shmat() call retruned errno 1013
>
> No problem with similar .config on 2.6.3. Can post .config if necessary.


I think you need to apply the third patch below, although all three
should probably be applied.


Date:	Wed, 18 Feb 2004 01:25:53 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: 2.6.3-mm1
Message-Id: <20040218012553.1228ae34.akpm@osdl.org>

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



