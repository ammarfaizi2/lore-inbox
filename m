Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVDGIKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVDGIKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVDGIJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:09:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16018 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262196AbVDGIGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:06:16 -0400
Date: Thu, 7 Apr 2005 10:00:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050407080004.GA27252@elte.hu>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru> <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425403F6.409@aknet.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stas Sergeev <stsp@aknet.ru> wrote:

> ENTRY(sysenter_entry)
> 	movl TSS_sysenter_esp0(%esp),%esp
> sysenter_past_esp:
> -	sti
> 	pushl $(__USER_DS)
> 	pushl %ebp
> +	sti

ah, yes, sysenter. SYSENTER creates a degenerate 'small' stackframe with 
an esp0 that is missing the 5 entry words relative to the normal entry 
(int80 or irq) esp0 stackframe. These 5 words are: xss, esp, eflags, 
xcs, eip. The sysenter code sets them up manually.

now if an interrupt hits at this point, it will set up a 'same privilege 
level' stackframe, which has eip/xcs/eflags, i.e. no esp/xss. If upon 
irq-return we then examine the stack due to your patch, it will be an 
incorrect stackframe -> kaboom.

your patch doesnt remove the condition, it only removes the crash, 
because it adds the 2 words space that is needed - but the information 
relied on by your irq-return test is still bogus. At this point i'd 
suggest to remove the ESP patch altogether.

the correct solution is to always let the sysenter path set up a full 
and correct stackframe, before allowing preemption (see the attached 
patch). This was a nasty bug in the waiting. (I have not made this 
conditional on CONFIG_PREEMPT, to keep it simple and because the impact 
to irq latency is small and predictable. There's no runtime overhead.)

so i think with the help of Stas the mystery has been fully explained 
and solved. Linus?

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/entry.S.orig
+++ linux/arch/i386/kernel/entry.S
@@ -179,12 +179,17 @@ need_resched:
 ENTRY(sysenter_entry)
 	movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
-	sti
+	#
+	# irqs are disabled: set up an entry stackframe without
+	# allowing irqs to potentially preempt us with an
+	# incomplete entry frame!
+	#
 	pushl $(__USER_DS)
 	pushl %ebp
 	pushfl
 	pushl $(__USER_CS)
 	pushl $SYSENTER_RETURN
+	sti
 
 /*
  * Load the potential sixth argument from user stack.
