Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVDEIFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVDEIFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVDEH6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:58:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50306 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261599AbVDEHoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:44:37 -0400
Date: Tue, 5 Apr 2005 09:40:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, stsp@aknet.ru
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050405074014.GA25122@elte.hu>
References: <20050405065544.GA21360@elte.hu> <20050405000319.4fa1d962.akpm@osdl.org> <20050405071604.GA23355@elte.hu> <20050405072929.GA24560@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405072929.GA24560@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > this fixed my crashes too.
> 
> spoke too soon - they still trigger even with the patch applied.

the patch below fixes the crash, it was related to CONFIG_PREEMPT.

	Ingo

--
fix entry.S crash with PREEMPT+PAGEALLOC

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/entry.S.orig
+++ linux/arch/i386/kernel/entry.S
@@ -165,9 +165,9 @@ ENTRY(resume_kernel)
 need_resched:
 	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
-	jz restore_all
+	jz restore_nocheck
 	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
-	jz restore_all
+	jz restore_nocheck
 	call preempt_schedule_irq
 	jmp need_resched
 #endif
