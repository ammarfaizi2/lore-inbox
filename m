Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966553AbWKOAtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966553AbWKOAtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 19:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966554AbWKOAtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 19:49:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966553AbWKOAtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 19:49:01 -0500
Date: Tue, 14 Nov 2006 16:47:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: ego@in.ibm.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, vatsa@in.ibm.com,
       dipankar@in.ibm.com, davej@redhat.com, mingo@elte.hu,
       kiran@scalex86.org
Subject: Re: [RFC 0/4] Cpu-Hotplug: Use per subsystem hot-cpu mutexes.
Message-Id: <20061114164737.fba88299.akpm@osdl.org>
In-Reply-To: <20061114121832.GA31787@in.ibm.com>
References: <20061114121832.GA31787@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 17:48:32 +0530
Gautham R Shenoy <ego@in.ibm.com> wrote:

> Since 2.6.18-something, the community has been bugged by the problem to
> provide a clean and a stable mechanism to postpone a cpu-hotplug event
> as lock_cpu_hotplug was badly broken.
> 
> This is another proposal towards solving that problem. This one is 
> along the lines of the solution provided in kernel/workqueue.c

The approach seems sane to me.  Sort-of direct, specific and transactional..

I applied this fixup:

diff -puN kernel/cpu.c~define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release-fix kernel/cpu.c
--- a/kernel/cpu.c~define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release-fix
+++ a/kernel/cpu.c
@@ -139,7 +139,8 @@ static int _cpu_down(unsigned int cpu)
 	if (err == NOTIFY_BAD) {
 		printk("%s: attempt to take down CPU %u failed\n",
 				__FUNCTION__, cpu);
-		return -EINVAL;
+		err = -EINVAL;
+		goto out_release;
 	}
 
 	/* Ensure that we are not runnable on dying cpu */
@@ -187,6 +188,7 @@ out_thread:
 	err = kthread_stop(p);
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
+out_release:
 	raw_notifier_call_chain(&cpu_chain, CPU_LOCK_RELEASE,
 						(void *)(long)cpu);
 	return err;
_


please send a patch to fix up the kerneldoc things which Randy spotted,
thanks.

