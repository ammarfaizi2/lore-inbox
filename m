Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWCBVu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWCBVu3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWCBVu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:50:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932310AbWCBVu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:50:28 -0500
Date: Thu, 2 Mar 2006 13:52:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: greg@kroah.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       yanmin.zhang@intel.com, neilb@cse.unsw.edu.au, steiner@sgi.com,
       hawkes@sgi.com
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060302135227.012134f9.akpm@osdl.org>
In-Reply-To: <20060302111201.cf61552f.pj@sgi.com>
References: <20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
	<20060301142631.22738f2d.akpm@osdl.org>
	<20060301151000.5fff8ec5.pj@sgi.com>
	<20060301154040.a7cb2afd.pj@sgi.com>
	<20060301202058.42975408.akpm@osdl.org>
	<20060301221429.c61b4ae6.pj@sgi.com>
	<20060301234215.62010fec.akpm@osdl.org>
	<20060302111201.cf61552f.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> ...
>
> The initial failure is in the file:
> 
>     arch/ia64/kernel/topology.c
> 
> function:
> 
>     topology_init
> 
> line:
> 
>     sysfs_cpus = kzalloc(sizeof(struct ia64_cpu) * NR_CPUS, GFP_KERNEL);
> 
> With our large NR_CPUS of 1024, and the additional cost of
> the CONFIG_DEBUG_SPINLOCK* debug stuff, and the little bit of
> additional data added by this patch, that kzalloc() fails.
> 

Oh.   Maybe we should put a big fat printk in slab for that.

> I should stare at the code between this point of initial failure and
> the point that the house of cards finally collapsed and see if
> something should have squeaked sooner.

Probably a panic() in your topology_init().

Also the below patch should have been done ages ago.

> I suspect that the short term solution is to proceed without
> prejudice to the patch that triggered this:
> 
>   gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch

Well yeah, except I find that patch to be independently malodorous ;)

> while I look at some way, if just a stop gap measure, to complain
> earlier in the boot, closer to the scene of the original crime,
> so that others hitting this won't waste more time.

See below.

> Perhaps failing that first kzalloc should cause a complaint,
> if not a panic.  It would seem that the system is beyond repair
> if that kzalloc fails.  And since the system hasn't even finished
> booting yet, and is for sure trying to boot some larger than tried
> before configuration, might just as well announce ones death boldly.

Yeah, it's dead.




From: Andrew Morton <akpm@osdl.org>

We presently ignore the return values from initcalls.  But that can carry
useful debugging information.  So print it out if it's non-zero.

Also make that warning message more friendly by printing the name of the
initcall function.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 init/main.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff -puN init/main.c~initcall-failure-reporting init/main.c
--- 25/init/main.c~initcall-failure-reporting	Thu Mar  2 13:41:02 2006
+++ 25-akpm/init/main.c	Thu Mar  2 13:50:53 2006
@@ -565,17 +565,23 @@ static void __init do_initcalls(void)
 	int count = preempt_count();
 
 	for (call = __initcall_start; call < __initcall_end; call++) {
-		char *msg;
+		char *msg = NULL;
+		char msgbuf[40];
+		int result;
 
 		if (initcall_debug) {
 			printk(KERN_DEBUG "Calling initcall 0x%p", *call);
-			print_fn_descriptor_symbol(": %s()", (unsigned long) *call);
+			print_fn_descriptor_symbol(": %s()",
+					(unsigned long) *call);
 			printk("\n");
 		}
 
-		(*call)();
+		result = (*call)();
 
-		msg = NULL;
+		if (result) {
+			sprintf(msgbuf, "error code %d", result);
+			msg = msgbuf;
+		}
 		if (preempt_count() != count) {
 			msg = "preemption imbalance";
 			preempt_count() = count;
@@ -585,8 +591,10 @@ static void __init do_initcalls(void)
 			local_irq_enable();
 		}
 		if (msg) {
-			printk(KERN_WARNING "error in initcall at 0x%p: "
-				"returned with %s\n", *call, msg);
+			printk(KERN_WARNING "initcall at 0x%p", *call);
+			print_fn_descriptor_symbol(": %s()",
+					(unsigned long) *call);
+			printk(": returned with %s\n", msg);
 		}
 	}
 
_

