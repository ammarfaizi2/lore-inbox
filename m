Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWFUIFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWFUIFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbWFUIF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:05:29 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:57752 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751289AbWFUIF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:05:26 -0400
Date: Wed, 21 Jun 2006 04:05:19 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ryan McAvoy <ryan.sed@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: realtime-preempt for MIPS - compile problem with rwsem
In-Reply-To: <642640090606201208g31a0a57bm268910b026ccd335@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0606210354050.29673@gandalf.stny.rr.com>
References: <642640090606201208g31a0a57bm268910b026ccd335@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ryan,

First, whenever sending mail about the -rt patch, always CC Ingo (and
perhaps Thomas Gliexner and myself).

On Tue, 20 Jun 2006, Ryan McAvoy wrote:

> I have been trying to get the realtime-preempt patches working on a
> MIPs processor with the 2.6.15 (and subsequently the 2.6.16) kernel.

2.6.15 had lots of problems with -rt.  Mainly the patch went through some
major rework, and Ingo was busy getting mutexes into mainline.  So the
2.6.15-rtX was sort of neglected.  It would be best to use 2.6.16-rtX and
maybe even 2.6.17-rtX

Which also comes the question: Which -rt patch are you actually trying?

>
> One problem I am having is as follows:
>
> - The mips configuration specifically disables
> CONFIG_RWSEM_GENERIC_SPINLOCK when CONFIG_PREEMPT_RT is on

That's a bug.  It should enable it not disable it.

> - This causes the include/asm-mips/rwsem.h to be included by
> include/linux/rwsem.h.
> - include/asm-mips/rwsem.h calls rwsem_down_read_failed which is
> implemented in lib/rwsem.c
> - rwsem.c is only compiled if CONFIG_RWSEM_XCHGADD_ALGORITHM is on.
> This option is also disabled if CONFIG_PREEMPT_RT is on.
>
> To summarise, if CONFIG_PREEMPT_RT is on, then the mips specific
> rwsem.h is included, but at the same time, it prevents inclusion of
> lib/rwsem.c which is needed by the mips rwsem.h.
>
> Does anyone have a solution to this.

Yep, try the following patch: (completey untested since I don't have a
mips machine).

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rt25/arch/mips/Kconfig
===================================================================
--- linux-2.6.16-rt25.orig/arch/mips/Kconfig	2006-06-21 04:02:54.000000000 -0400
+++ linux-2.6.16-rt25/arch/mips/Kconfig	2006-06-21 04:03:29.000000000 -0400
@@ -798,7 +798,7 @@ source "kernel/Kconfig.preempt"

 config RWSEM_GENERIC_SPINLOCK
 	bool
-	depends on !PREEMPT_RT
+	depends on PREEMPT_RT
 	default y

 config RWSEM_XCHGADD_ALGORITHM

