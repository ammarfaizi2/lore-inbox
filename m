Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVJKWpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVJKWpd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVJKWpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:45:33 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:17083 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751220AbVJKWpc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:45:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JRnzeZqukAKWybJkWSLvD5KcNUKrnxd5YXzI15QE4dvlOZVtzxEycORapcCarHrIn6DR/a8aW8Ymipl1/oYXKJb33VlbcziIy18ayS4Uqze8RuE9xEhuRCOCxQzV9/+IOsyFYtv76O/W0YscbYlvZysZVrubkxTGV6SxKE4qmBM=
Message-ID: <5bdc1c8b0510111545n29b77010h8558a1b69c4bf12a@mail.gmail.com>
Date: Tue, 11 Oct 2005 15:45:31 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20051011111700.GA15892@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
	 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
	 <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
	 <20051011111700.GA15892@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Mark Knecht <markknecht@gmail.com> wrote:
>
> > > ( softirq-timer/0-3    |#0): new 3997 us maximum-latency critical section.
> >
> > So the root cause of this 4mS delay is the 250Hz timer. If I change
> > the system to use the 1Khz timer then the time in this section drops,
> > as expected, to 1mS.
>
> this was a bug in the critical-section-latency measurement code of x64.
> The timer irq is the one that leaves userspace running for the longest
> time, between two kernel calls.
>
> I have fixed these bugs in -rc4-rt1, could you try it? It should report
> much lower latencies, regardless of PM settings.
>
>         Ingo
>

Ingo,
   This test now reports much more intersting data:

(           dmesg-8010 |#0): new 13 us maximum-latency critical section.
 => started at timestamp 117628604: <do_IRQ+0x29/0x50>
 =>   ended at timestamp 117628618: <do_IRQ+0x39/0x50>

Call Trace: <IRQ> <ffffffff8014c42c>{check_critical_timing+492}
       <ffffffff8014c64b>{sub_preempt_count_ti+75} <ffffffff80110159>{do_IRQ+57}
       <ffffffff8010e16c>{ret_from_intr+0}  <EOI>
<ffffffff80249a75>{copy_page+5}
       <ffffffff801671f1>{do_no_page+737}
<ffffffff801674ee>{__handle_mm_fault+414}
       <ffffffff8014c64b>{sub_preempt_count_ti+75}
<ffffffff803eac99>{do_page_fault+1049}
       <ffffffff8014c64b>{sub_preempt_count_ti+75}
<ffffffff80168eee>{vma_link+286}
       <ffffffff8010e4c1>{error_exit+0} <ffffffff8024a866>{__clear_user+22}
       <ffffffff801a46fb>{padzero+27} <ffffffff801a4b42>{load_elf_interp+850}
       <ffffffff801a5b1d>{load_elf_binary+3341}
<ffffffff8014c64b>{sub_preempt_count_ti+75}
       <ffffffff8014c64b>{sub_preempt_count_ti+75}
<ffffffff801a4e10>{load_elf_binary+0}
       <ffffffff80182ee0>{search_binary_handler+272}
<ffffffff801831f5>{do_execve+405}
       <ffffffff8010dbc6>{system_call+126} <ffffffff8010c634>{sys_execve+68}
       <ffffffff8010dfea>{stub_execve+106}
 =>   dump-end timestamp 117628777

(        nautilus-7955 |#0): new 14 us maximum-latency critical section.
 => started at timestamp 127874927: <do_IRQ+0x29/0x50>
 =>   ended at timestamp 127874941: <do_IRQ+0x39/0x50>

Call Trace: <IRQ> <ffffffff8014c42c>{check_critical_timing+492}
       <ffffffff8014c64b>{sub_preempt_count_ti+75} <ffffffff80110159>{do_IRQ+57}
       <ffffffff8010e16c>{ret_from_intr+0}  <EOI>
<ffffffff8010dbc6>{system_call+126}

 =>   dump-end timestamp 127874996

(        nautilus-7955 |#0): new 14 us maximum-latency critical section.
 => started at timestamp 128647499: <do_IRQ+0x29/0x50>
 =>   ended at timestamp 128647514: <do_IRQ+0x39/0x50>

Call Trace: <IRQ> <ffffffff8014c42c>{check_critical_timing+492}
       <ffffffff8014c64b>{sub_preempt_count_ti+75} <ffffffff80110159>{do_IRQ+57}
       <ffffffff8010e16c>{ret_from_intr+0}  <EOI>
 =>   dump-end timestamp 128647567

lightning ~ #

NOTE: In my first kernel build I turned on latency measurement for
both max preempt and ITQ-off. The kernel segfaulted immediately after
the boot messages reminding me that these were on. I rebuilt the
kernel with only the max preempt and that worked. I suspect some
problem with the IRQ-off section since that's the only change I made
and it did not segfault in -rc3-rt13.

Thanks,
Mark
