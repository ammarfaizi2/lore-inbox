Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVHZCIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVHZCIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 22:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVHZCIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 22:08:20 -0400
Received: from ozlabs.org ([203.10.76.45]:49131 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965048AbVHZCIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 22:08:20 -0400
Subject: Re: Redundant up operation in stop_machine.c ?(2.6.12)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Yingchao Zhou <puppylove_0814@yahoo.com.cn>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050825135937.85228.qmail@web15003.mail.cnb.yahoo.com>
References: <20050825135937.85228.qmail@web15003.mail.cnb.yahoo.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 12:08:22 +1000
Message-Id: <1125022102.9945.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 21:59 +0800, Yingchao Zhou wrote:
> In stop_machine function, there are codes:
> 	if (ret < 0) {
> 		stopmachine_set_state(STOPMACHINE_EXIT);
> 		up(&stopmachine_mutex);
> 		return ret;
> 	}
> And in __stop_machine_run ,there are:
> 	if (!IS_ERR(p)) {
> 		kthread_bind(p, cpu);
> 		wake_up_process(p);
> 		wait_for_completion(&smdata.done);
> 	}
> 	up(&stopmachine_mutex);
> 
> Is the first up op is really redundant?

Yes, it seems you have found a bug.  I tested it (inserting a spurious
failure), and indeed, it gets up'ed twice.

Good catch!
Rusty.

Name: Redundant up operation in stop_machine.c
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (authored)

Yingchao Zhou <puppylove_0814@yahoo.com.cn> noticed that we up() in
stop_machine on failure, and also in the caller (unconditionally).

Index: linux-2.6.13-rc7-git1-Misc/kernel/stop_machine.c
===================================================================
--- linux-2.6.13-rc7-git1-Misc.orig/kernel/stop_machine.c	2005-08-26 11:18:00.000000000 +1000
+++ linux-2.6.13-rc7-git1-Misc/kernel/stop_machine.c	2005-08-26 12:05:01.000000000 +1000
@@ -115,7 +115,6 @@
 	/* If some failed, kill them all. */
 	if (ret < 0) {
 		stopmachine_set_state(STOPMACHINE_EXIT);
-		up(&stopmachine_mutex);
 		return ret;
 	}
 

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

