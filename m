Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263192AbVGAHPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbVGAHPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbVGAHPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:15:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24243 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263192AbVGAHPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:15:34 -0400
Date: Fri, 1 Jul 2005 09:14:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       eliad lubovsky <eliadl@013.net>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2.6.13-rc1] i386: fix incorrect TSS entry for LDT
Message-ID: <20050701071436.GA18008@elte.hu>
References: <200507010043_MC3-1-A32F-B78B@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507010043_MC3-1-A32F-B78B@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> The LDT entry in the i386 TSS needs to be a selector, not an entry 
> number.

you are right - but this shouldnt really matter, because this TSS field 
is only loaded by a CPU upon a real TSS switch, which we never do. We 
load the LDT selector manually, via the lldt instruction (load_LDT*()).  
(It could at most matter when we do a double-fault, but the TSS of the 
doublefault handler is set up separately, which has the .ldt field 
cleared.)

so i'd rather suggest to remove the initialization altogether, as per 
the (tested) patch below.

	Ingo

---

noticed by Chuck Ebbert: the .ldt entry of the TSS was set up
incorrectly. It never mattered since this was a leftover from
old times, so remove it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/asm-i386/processor.h |    1 -
 1 files changed, 1 deletion(-)

Index: linux/include/asm-i386/processor.h
===================================================================
--- linux.orig/include/asm-i386/processor.h
+++ linux/include/asm-i386/processor.h
@@ -474,7 +474,6 @@ struct thread_struct {
 	.esp0		= sizeof(init_stack) + (long)&init_stack,	\
 	.ss0		= __KERNEL_DS,					\
 	.ss1		= __KERNEL_CS,					\
-	.ldt		= GDT_ENTRY_LDT,				\
 	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,			\
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0 },		\
 }
