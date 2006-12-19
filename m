Return-Path: <linux-kernel-owner+w=401wt.eu-S932920AbWLST7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920AbWLST7H (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932917AbWLST7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:59:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33224 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932922AbWLST7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:59:06 -0500
Date: Tue, 19 Dec 2006 20:56:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [patch] hrtimers: add state tracking, fix
Message-ID: <20061219195650.GA8797@elte.hu>
References: <20061214225913.3338f677.akpm@osdl.org> <200612191815.kBJIFF4O018306@lx1.pxnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612191815.kBJIFF4O018306@lx1.pxnet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tilman Schmidt <tilman@imap.cc> wrote:

> I tried kernel 2.6.20-rc1-mm1 with the "tickless" option on my P3/933 
> but it has now for the second time in a row caused a system freeze as 
> soon as I left the system idle for a couple of hours. The second time 
> I was warned and switched to a text console before I left the system, 
> and was able to collect this BUG message (copied manually, beware of 
> typos):
> 
> EFLAGS: 00200082   (2.6.20-rc1-mm1-noinitrd #0)
> EIP is at __rb_rotate_right+0x1/0x54
[...]
> Call Trace:
>  [<c021d049>] rb_insert_color+0x55/0xbe
>  [<c012d15b>] enqueue_hrtimer+0x10a/0x116
>  [<c012d9b4>] hrtimer_start+0x78/0x93

thanks for the report - this made me review the hrtimer state engine 
logic, and bingo, it indeed has a nasty typo! Could you try the fix 
below, does it fix your problem? It might explain the crash you are 
seeing, because the typo means we'd ignore HRTIMER_STATE_PENDING state 
(which is rare but possible).

	Ingo

-------------------------->
Subject: [patch] hrtimers: add state tracking, fix
From: Ingo Molnar <mingo@elte.hu>

fix bug in hrtimer_is_queued(), introduced by a cleanup during
the recent refactoring.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/hrtimer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c
+++ linux/kernel/hrtimer.c
@@ -157,7 +157,7 @@ static void hrtimer_get_softirq_time(str
 static inline int hrtimer_is_queued(struct hrtimer *timer)
 {
 	return timer->state &
-		(HRTIMER_STATE_ENQUEUED || HRTIMER_STATE_PENDING);
+		(HRTIMER_STATE_ENQUEUED | HRTIMER_STATE_PENDING);
 }
 
 /*
