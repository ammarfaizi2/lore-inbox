Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268588AbUJDV2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268588AbUJDV2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268589AbUJDV11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:27:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52422 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268580AbUJDVY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:24:56 -0400
Date: Mon, 4 Oct 2004 23:26:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: annabellesgarden@yahoo.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-ID: <20041004212633.GA13527@elte.hu>
References: <200410041634.24937.annabellesgarden@yahoo.de> <20041004122304.4f545f3c.akpm@osdl.org> <20041004122533.0a85a1ad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004122533.0a85a1ad.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> >
> > You're the second person who is seeing in_interrupt() returning true when
> >  clearly it should not be doing so.  Ingo, did you do soemthing which might
> >  have caused this?
> 
> I'm suspecting that something is causing preempt_count() to overflow
> into the softirq counter.  An imbalanced preempt_disable(), for
> example.

yes, that was it. Must not put side-effects into a macro that is NOP on
!SMP.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/net/neighbour.h.orig
+++ linux/include/net/neighbour.h
@@ -113,8 +113,9 @@ struct neigh_statistics
 
 #define NEIGH_CACHE_STAT_INC(tbl, field)				\
 	do {								\
-		(per_cpu_ptr((tbl)->stats, get_cpu())->field)++;	\
-		put_cpu();						\
+		preempt_disable();					\
+		(per_cpu_ptr((tbl)->stats, smp_processor_id())->field)++; \
+		preempt_enable();					\
 	} while (0)
 
 struct neighbour
