Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbUKDLjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbUKDLjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUKDLht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:37:49 -0500
Received: from mx1.elte.hu ([157.181.1.137]:63408 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262174AbUKDLUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:20:42 -0500
Date: Thu, 4 Nov 2004 12:17:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Michael J. Cohen" <mjc@unre.st>
Cc: "K.R. Foley" <kr@cybsft.com>, sboyce@blueyonder.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
Message-ID: <20041104111713.GA32306@elte.hu>
References: <4189108C.2050804@blueyonder.co.uk> <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk> <418988A6.4090902@cybsft.com> <20041104100634.GA29785@elte.hu> <1099563805.30372.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099563805.30372.2.camel@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michael J. Cohen <mjc@unre.st> wrote:

> Ingo
> 	Great timing! only 7 minutes after I posted my concession speech. ;)
> 
> Here you go:
> 
>   LD      .tmp_vmlinux1
> kernel/built-in.o(.text+0x1e57c): In function `___trace':
> : undefined reference to `irqs_disabled_flags'
> kernel/built-in.o(.text+0x1e797): In function `add_preempt_count':
> : undefined reference to `irqs_disabled_flags'
> make: *** [.tmp_vmlinux1] Error 1

the patch below should fix this - but i'd suggest to disable
LATENCY_TRACING, i had bad experience with x86_64 gcc & mcount. (it was
not possible to get a working -pg and -fno-omit-frame-pointers at once.)

	Ingo

--- linux/include/asm-x86_64/system.h.orig
+++ linux/include/asm-x86_64/system.h
@@ -316,11 +316,16 @@ static inline unsigned long __cmpxchg(vo
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 
+#define irqs_disabled_flags(flags)	\
+({					\
+	!(flags & (1<<9));		\
+})
+
 #define irqs_disabled()			\
 ({					\
 	unsigned long flags;		\
 	local_save_flags(flags);	\
-	!(flags & (1<<9));		\
+	irqs_disabled_flags(flags);	\
 })
 
 /* For spinlocks etc */
