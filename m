Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932845AbWF1Piv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbWF1Piv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932847AbWF1Piu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:38:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36289 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932845AbWF1Pit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:38:49 -0400
Date: Wed, 28 Jun 2006 17:34:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm3 -- BUG: trying to register non-static key!
Message-ID: <20060628153403.GA32131@elte.hu>
References: <a44ae5cd0606271447j58ad9cdchc4728c010245df5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0606271447j58ad9cdchc4728c010245df5b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Miles Lane <miles.lane@gmail.com> wrote:

> mmc0: starting CMD0 arg 00000000 flags 00000040
> BUG: trying to register non-static key!
> turning off the locking correctness validator.
> [<c1003502>] show_trace_log_lvl+0x54/0xfd
> [<c1003b6a>] show_trace+0xd/0x10
> [<c1003c0e>] dump_stack+0x19/0x1b
> [<c102c0a8>] __lock_acquire+0x101/0x95e
> [<c102cbca>] lock_acquire+0x60/0x80
> [<c11fcc7b>] _spin_lock_irq+0x29/0x38
> [<c11faa0a>] wait_for_completion+0x24/0xd0
> [<f8831367>] mmc_wait_for_req+0xa2/0xaf [mmc_core]
> [<f8831539>] mmc_wait_for_cmd+0x50/0x5b [mmc_core]
> [<f883162f>] mmc_idle_cards+0x83/0xe0 [mmc_core]
> [<f8831a0e>] mmc_rescan+0x18a/0xec4 [mmc_core]
> [<c1024198>] run_workqueue+0x86/0xcb
> [<c1024711>] worker_thread+0xe1/0x114
> [<c1026ca7>] kthread+0xb0/0xdc
> [<c1001005>] kernel_thread_helper+0x5/0xb
> sdhci [sdhci_tasklet_finish()]: Ending request, cmd (0)

does the patch below fix this?

	Ingo

------->
Subject: lockdep: annotate on-stack completions, mmc
From: Ingo Molnar <mingo@elte.hu>

lockdep needs to have the waitqueue lock initialized for on-stack
waitqueues implicitly initialized by DECLARE_COMPLETION().

Annotate mmc_wait_for_req()'s on-stack completion accordingly.

Has no effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/mmc/mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/mmc/mmc.c
===================================================================
--- linux.orig/drivers/mmc/mmc.c
+++ linux/drivers/mmc/mmc.c
@@ -129,7 +129,7 @@ static void mmc_wait_done(struct mmc_req
 
 int mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
-	DECLARE_COMPLETION(complete);
+	DECLARE_COMPLETION_ONSTACK(complete);
 
 	mrq->done_data = &complete;
 	mrq->done = mmc_wait_done;
