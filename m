Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262777AbSIPShO>; Mon, 16 Sep 2002 14:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSIPShO>; Mon, 16 Sep 2002 14:37:14 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:38673
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262777AbSIPShN>; Mon, 16 Sep 2002 14:37:13 -0400
Subject: Re: BUG(): sched.c: Line 944 - 2.5.35
From: Robert Love <rml@tech9.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, spstarr@sh0n.net, venom@sns.it
In-Reply-To: <200209161636.JAA02714@adam.yggdrasil.com>
References: <200209161636.JAA02714@adam.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 14:42:13 -0400
Message-Id: <1032201735.1010.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 12:36, Adam J. Richter wrote:

> 	When I see this problem at boot, preempt_count() returns 0x4000000
> (PREEMPT_ACTIVE) and kernel_locked() returns 0.
> 
> 	I don't understand the semantics of PREEMPT_ACTIVE to know
> whether to
> 
> 	(1) change the test back to using in_interrupt instead of in_atomic, or
> 	(2) change the definition of in_atomic(), or
> 	(3) look for a bug somewhere else.

There are two problems: First, PREEMPT_ACTIVE is indeed set on entry to
schedule() from preempt_schedule() so we need to check for that too. 
Second, the BUG() is catching a bit of issues... you want something
like:

-	if (unlikely(in_atomic()))
-		BUG();
+	if (unlikely(in_atomic() && preempt_count() != PREEMPT_ACTIVE)) {
+		printk(KERN_ERR "schedule() called while non-atomic!\n");
+		show_stack(NULL);
+	}

I will send a patch to Linus.

> 	However, I know experimentally that changing the test back to
> using in_interrupt() results in a possibly unrelated BUG() at line 279
> of rmap.c:

This is unrelated.

	Robert Love

