Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423642AbWKFJij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423642AbWKFJij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 04:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423646AbWKFJij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 04:38:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30084 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423642AbWKFJii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 04:38:38 -0500
Date: Mon, 6 Nov 2006 10:38:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
Message-ID: <20061106093815.GB14388@elte.hu>
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org> <200611031230.24983.fzu@wemgehoertderstaat.de> <454BC8D1.1020001@rncbc.org> <454BF608.20803@rncbc.org> <454C714B.8030403@rncbc.org> <454E0976.8030303@rncbc.org> <454E15B0.2050008@rncbc.org> <1162742535.2750.23.camel@localhost.localdomain> <454E2FC1.4040700@rncbc.org> <1162797896.6126.5.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162797896.6126.5.camel@Homer.simpson.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> I just reproduced it running glibc make check.  I had just enabled 
> kprobes and recompiled with the stock SuSE-10.1 compiler while waiting 
> for you to send me your .config (nevermind that request) so I could 
> try to reproduce it here.

hm, so kprobe_flush_task() is likely PREEMPT_RT-unsafe.

could you try the patch below, does it help? (a quick review seems to 
suggest that all codepaths protected by kretprobe_lock are atomic)

	Ingo

Index: linux/kernel/kprobes.c
===================================================================
--- linux.orig/kernel/kprobes.c
+++ linux/kernel/kprobes.c
@@ -50,7 +50,7 @@ static struct hlist_head kretprobe_inst_
 static atomic_t kprobe_count;
 
 DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
-DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
+DEFINE_RAW_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
 
 static struct notifier_block kprobe_page_fault_nb = {
