Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268187AbUHQL1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268187AbUHQL1w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUHQL1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:27:52 -0400
Received: from pD9EB1C8C.dip.t-dialin.net ([217.235.28.140]:8073 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S268188AbUHQL1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:27:33 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816120933.GA4211@elte.hu>
References: <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu>  <20040816120933.GA4211@elte.hu>
Content-Type: text/plain
Message-Id: <1092741974.14015.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 13:26:14 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> here's -P2:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P2
> 
> Changes since -P1:
> 
>  - trace interrupted kernel code (via hardirqs, NMIs and pagefaults)
> 
>  - yet another shot at trying to fix the IO-APIC/USB issues.
> 
>  - mcount speedups - tracing should be faster
> 
> 	Ingo

I think I stumbled across some bugs/false positives.
Those tests were run with acpi=off, so that this specific issue doesn't
interfere. voluntary_preemption is set to 3 throughout.

The first problem was already reported by Lee Revell. Creating a new tab
in gnome-terminal gives :

[...]
 0.064ms (+0.000ms): preempt_schedule (try_to_wake_up)
 0.065ms (+0.000ms): preempt_schedule (copy_page_range)
 0.065ms (+0.000ms): preempt_schedule (copy_page_range)
[... plenty of preempt_schedule (copy_page_range) skipped ...]
 0.202ms (+0.000ms): preempt_schedule (copy_page_range)
 0.202ms (+0.000ms): preempt_schedule (copy_page_range)
 0.202ms (+0.000ms): check_preempt_timing (touch_preempt_timing)

This is induced by kernel_preemption=0 and disappears with
kernel_preemption=1. It seems to be a side-effect of the current design.
Is there a way to avoid this ?

The second one still involves creating a new tab in gnome-terminal, but
with kernel_preemption=1 :

preemption latency trace v1.0
-----------------------------
 latency: 130 us, entries: 6 (6)
 process: gnome-terminal/14381, uid: 1000
 nice: 0, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): __vma_link_rb (copy_mm)
 0.000ms (+0.000ms): rb_insert_color (copy_mm)
 0.000ms (+0.000ms): __rb_rotate_left (rb_insert_color)
 0.000ms (+0.000ms): copy_page_range (copy_mm)
 0.000ms (+0.000ms): pte_alloc_map (copy_page_range)
 0.127ms (+0.126ms): check_preempt_timing (touch_preempt_timing)

When entering check_preempt_timing, preempt_thresh was 0, and
preempt_max_latency had been freshly reset to 100. It should have
triggered this code :
		if (latency < preempt_max_latency)
			goto out;
but for some reason it didn't (or there is a problem in the tracing
code, not showing events that would have increased 'latency').

Thomas


