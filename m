Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWB1Cvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWB1Cvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 21:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWB1Cvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 21:51:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59818 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932130AbWB1Cvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 21:51:43 -0500
Date: Mon, 27 Feb 2006 18:50:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Cc: ananth@in.ibm.com, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       hiramatu@sdl.hitachi.co.jp, systemtap@sources.redhat.com,
       jkenisto@us.ibm.com, linux-kernel@vger.kernel.org,
       sugita@sdl.hitachi.co.jp, soshima@redhat.com, haoki@redhat.com
Subject: Re: [PATCH][take2][2/2] kprobe: kprobe-booster against 2.6.16-rc5
 for i386
Message-Id: <20060227185012.037c8830.akpm@osdl.org>
In-Reply-To: <4402E920.5080402@sdl.hitachi.co.jp>
References: <43DE0A4D.20908@sdl.hitachi.co.jp>
	<4402E920.5080402@sdl.hitachi.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp> wrote:
>
> Here is a patch of kprobe-booster for i386 arch against linux-2.6.16-rc5.
>  The kprobe-booster patch is also under the influence of the NX-protection
>  support patch. So, I fixed that.
> 
>  Could you replace the previous patches with these patches?

I'd prefer not to.  Once a patch has been in -mm for this long I really
prefer to not see wholesale replacements.  When people do this to me I
usually turn their replacements into incremental patches so we can see what
changed.  Which is useful.

Your first patch was identical to what I already have, so I dropped that.

Your second patch made these changes:

--- devel/arch/i386/kernel/kprobes.c~kprobe-kprobe-booster-against-2616-rc5-for	2006-02-27 18:40:29.000000000 -0800
+++ devel-akpm/arch/i386/kernel/kprobes.c	2006-02-27 18:40:57.000000000 -0800
@@ -305,7 +305,7 @@ static int __kprobes kprobe_handler(stru
 
 	if (p->ainsn.boostable == 1 &&
 #ifdef CONFIG_PREEMPT
-	    !(pre_preempt_count) && /*
+	    !(pre_preempt_count()) && /*
 				       * This enables booster when the direct
 				       * execution path aren't preempted.
 				       */
@@ -313,7 +313,7 @@ static int __kprobes kprobe_handler(stru
 	    !p->post_handler && !p->break_handler ) {
 		/* Boost up -- we can execute copied instructions directly */
 		reset_current_kprobe();
-		regs->eip = (unsigned long)&p->ainsn.insn;
+		regs->eip = (unsigned long)p->ainsn.insn;
 		preempt_enable_no_resched();
 		return 1;
 	}

The first hunk is surely wrong - pre_preempt_count is a local unsigned
integer, not a function.

And I'm not sure about the second hunk either - surely an `eip' should
point at an instruction, not be assigned the value of an instruction?

So I'll drop both patches.  If you have bugfixes, please make them relative
to already-merged things.  Against most-recent -mm is best, as I do fix
patches up, and other people send fixes which you might not have merged
locally.  And please ensure that the changes compile and run with and
without CONFIG_PREEMPT!

