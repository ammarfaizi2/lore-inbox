Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUGGAFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUGGAFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 20:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUGGAFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 20:05:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25257 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264771AbUGGAFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 20:05:39 -0400
Date: Tue, 6 Jul 2004 17:02:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: 2.6.7-mm6
Message-Id: <20040706170247.5bca760c.davem@redhat.com>
In-Reply-To: <20040706233618.GW21066@holomorphy.com>
References: <20040705023120.34f7772b.akpm@osdl.org>
	<20040706125438.GS21066@holomorphy.com>
	<20040706233618.GW21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 16:36:18 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> I have it isolated down to the sched-clean-init-idle.patch and
> sched-clean-fork.patch. sched-clean-init-idle.patch fails to build without
> the second of those two applied, so I didn't do any work to narrow it down
> further.

One thing to note is that we don't currently call the
wake_up_forked_process() thing in our SMP idle bootup
dispatcher in arch/sparc64/kernel/smp.c

Perhaps that is somehow related to the problems.
In that case the culprit would be the first patch,
sched-clean-init-idle.patch

See arch/sparc64/kernel/smp.c:smp_boot_one_cpu() for details.
When we start a cpu, by calling prom_startcpu(), the cpu
jumps from the firmware into arch/sparc64/kernel/trampoline.S

There, the cpu is initialized (just like it is for the boot cpu
in arch/sparc64/kernel/head.S), the current_thread_info() (%g6)
and 'current' (%g4) registers are initialized and the cpu jumps
into smp_callin().  smp_callin() returns when it is safe to do
so, which is when it's cpu bit is set in smp_commenced_mask.
When that occurs, it's cpu bit is set in cpu_online_map and
then it jumps right into cpu_idle().

Hope this helps.
