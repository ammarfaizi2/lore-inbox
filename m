Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbUADJZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 04:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUADJZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 04:25:26 -0500
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:49074 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265153AbUADJZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 04:25:23 -0500
Date: Sat, 3 Jan 2004 16:02:28 +1100
From: Rusty Russell <rusty@au1.ibm.com>
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Module Observations
Message-Id: <20040103160228.4692b373.rusty@rustcorp.com.au>
In-Reply-To: <20040102185509.A18154@in.ibm.com>
References: <20040102185509.A18154@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004 18:55:09 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> Hi,
> 	I was going thr' module code and made some observations:
> 
> 1. sys_init_module drops the module_mutex semaphore
>    before calling mod->init() function and later
>    reacquires it. After reacquiring, it marks
>    the module state as MODULE_STATE_LIVE.
> 
>    In the window when mod->init() function is running,
>    isn't it possible that sys_delete_module (running
>    on some other CPU and trying to remove the _same_ module)
>    acquires the module_mutex sem and marks the module
>    state as MODULE_STATE_GOING?
> 
>    Shouldn't sys_init_module check for
>    that possibility when it reacquires the semaphore after
>    calling mod->init function?

Good catch.  The module removal should refuse to remove it without --force.

I opened this hole when I dropped the sem around mod->init() (because
some modules load other modules in their init routine).

Andrew, please apply patch below.

> 2. try_module_get() and module_put()
> 
> 	try_module_get increments the local cpu's ref count for the module 
>    and module_put decrements it.
> 
>    Is it required that the caller call both these functions from the same CPU?
>    Otherwise, the total refcount for the module will be non-zero!

No, it's OK.  We only care about the *total* being zero.

Thanks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

Name: Prevent Removal of Module During Init
Author: Rusty Russell
Status: Trivial

D: Vatsa spotted this: you can remove a module while it's being
D: initialized, and that will be bad.  Hole was opened when I dropped
D: the sem around the init routine (which can probe for other
D: modules).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22325-linux-2.6.1-rc1/kernel/module.c .22325-linux-2.6.1-rc1.updated/kernel/module.c
--- .22325-linux-2.6.1-rc1/kernel/module.c	2003-11-24 15:42:33.000000000 +1100
+++ .22325-linux-2.6.1-rc1.updated/kernel/module.c	2004-01-03 15:59:54.000000000 +1100
@@ -687,8 +687,8 @@ sys_delete_module(const char __user *nam
 		goto out;
 	}
 
-	/* Already dying? */
-	if (mod->state == MODULE_STATE_GOING) {
+	/* Doing init or already dying? */
+	if (mod->state != MODULE_STATE_LIVE) {
 		/* FIXME: if (force), slam module count and wake up
                    waiter --RR */
 		DEBUGP("%s already dying\n", mod->name);
