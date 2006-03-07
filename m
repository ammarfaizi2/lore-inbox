Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751979AbWCGKnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWCGKnX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 05:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbWCGKnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 05:43:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751979AbWCGKnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 05:43:22 -0500
Date: Tue, 7 Mar 2006 02:41:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: greg@kroah.com, dsp@llnl.gov, arjan@infradead.org,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-Id: <20060307024113.103bbf1c.akpm@osdl.org>
In-Reply-To: <20060306222400.GK27946@ftp.linux.org.uk>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	<200603061052.57188.dsp@llnl.gov>
	<20060306195348.GB8777@kroah.com>
	<200603061301.37923.dsp@llnl.gov>
	<20060306213203.GJ27946@ftp.linux.org.uk>
	<20060306215344.GB16825@kroah.com>
	<20060306222400.GK27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> On Mon, Mar 06, 2006 at 01:53:44PM -0800, Greg KH wrote:
>  > > 	rmmod your_turd </sys/spew/from/your_turd
>  > > and there you go.  rmmod can _NOT_ wait for sysfs references to go away.
>  > 
>  > To be fair, the only part of the kernel that supports the above process,
>  > is the network stack.  And they implemented a special kind of lock to
>  > handle just this kind of thing.
>  > 
>  > That is not something that I want the rest of the kernel to have to use.
>  > If your code blocks when doing the above thing, that's fine with me.
> 
>  One word: fail.  With -EBUSY.

It seems quite simple to make wait_for_zero_refcount() interruptible? 
Something like...



--- devel/kernel/module.c~modules-make-wait_for_zero_refcount-interruptible	2006-03-07 02:36:46.000000000 -0800
+++ devel-akpm/kernel/module.c	2006-03-07 02:39:18.000000000 -0800
@@ -578,8 +578,8 @@ static void wait_for_zero_refcount(struc
 	mutex_unlock(&module_mutex);
 	for (;;) {
 		DEBUGP("Looking at refcount...\n");
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (module_refcount(mod) == 0)
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (module_refcount(mod) == 0 || signal_pending(current))
 			break;
 		schedule();
 	}
@@ -645,8 +645,18 @@ sys_delete_module(const char __user *nam
 		goto out;
 
 	/* Never wait if forced. */
-	if (!forced && module_refcount(mod) != 0)
+	if (!forced && module_refcount(mod) != 0) {
 		wait_for_zero_refcount(mod);
+		if (module_refcount(mod)) {
+			/*
+			 * Signalled: back out
+			 */
+			mod->state = MODULE_STATE_LIVE;
+			mod->waiter = NULL;
+			ret = -EINTR;
+			goto out;
+		}
+	}
 
 	/* Final destruction now noone is using it. */
 	if (mod->exit != NULL) {
_

