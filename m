Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVJLBJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVJLBJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 21:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJLBJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 21:09:20 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:40235 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932367AbVJLBJT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 21:09:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mPDW0GlNIOV1UFOwJtq5talCag/TidLtapGsSuu4FRdfUQV7bAwjUZ7MasCCU7OOjqYKIwEmp2ZAQxLnkLFLFZMgqr/KSXv0ab3SeBQeteS366dEGZyt9JKNRrFZWXDTJDjXOkoQPQMMe29eC+r29R15HjdtMljfHNuiHfyPsek=
Message-ID: <5bdc1c8b0510111809v2609879ai8aa0a8e283acb58d@mail.gmail.com>
Date: Tue, 11 Oct 2005 18:09:19 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1129075368.7094.3.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
	 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
	 <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
	 <20051011111700.GA15892@elte.hu>
	 <5bdc1c8b0510111545n29b77010h8558a1b69c4bf12a@mail.gmail.com>
	 <1129075368.7094.3.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-10-11 at 15:45 -0700, Mark Knecht wrote:
> > On 10/11/05, Ingo Molnar <mingo@elte.hu> wrote:
> > >
> > > * Mark Knecht <markknecht@gmail.com> wrote:
> > >
> > > > > ( softirq-timer/0-3    |#0): new 3997 us maximum-latency critical section.
> > > >
> > > > So the root cause of this 4mS delay is the 250Hz timer. If I change
> > > > the system to use the 1Khz timer then the time in this section drops,
> > > > as expected, to 1mS.
> > >
> > > this was a bug in the critical-section-latency measurement code of x64.
> > > The timer irq is the one that leaves userspace running for the longest
> > > time, between two kernel calls.
> > >
> > > I have fixed these bugs in -rc4-rt1, could you try it? It should report
> > > much lower latencies, regardless of PM settings.
> > >
> > >         Ingo
> > >
> >
> > Ingo,
> >    This test now reports much more intersting data:
> >
> > (           dmesg-8010 |#0): new 13 us maximum-latency critical section.
> >  => started at timestamp 117628604: <do_IRQ+0x29/0x50>
> >  =>   ended at timestamp 117628618: <do_IRQ+0x39/0x50>
>
> This is the expected, correct behavior - very small maximum latency
> critical sections.  Do you get anything longer (say 300 usecs or more)
> if you leave it running?
>
> So far the latency tracer on my much slower system has only gone up to
> 123 usecs.  So the bug seems to be fixed at least on i386.
>
> Lee
>
>

I've been watching this now for a couple of hours. Still no xruns. Max
latency has only gone up to 19uS, so this is all good. However the
thing I am seeing is that all my free memory has gone away and I've
now swapped out just a little nit. There was really no change in the
state of the machine, other than xscreensaver starting and running for
a while, which is standard for me. None the less here's the sort of
state things are in - 17uS right after booting, and only 19uS now.
That's good. But in the middle look at the change in memory statistics
during a one hour time period.

(               X-7860 |#0): new 16 us maximum-latency critical section.
 => started at timestamp 259455017: <__schedule+0xb8/0x596>
 =>   ended at timestamp 259455034: <thread_return+0xb4/0x10a>

Call Trace:<ffffffff8014c42c>{check_critical_timing+492}
<ffffffff8014c64b>{sub_preempt_count_ti+75}
       <ffffffff803e7d9a>{thread_return+180} <ffffffff803e7ef5>{schedule+261}
       <ffffffff803e89e4>{schedule_timeout+148}
<ffffffff8013a660>{process_timeout+0}
       <ffffffff8018b767>{do_select+967} <ffffffff8018b2b0>{__pollwait+0}
       <ffffffff8018baad>{sys_select+749}
<ffffffff8010d9e9>{sys_rt_sigreturn+553}
       <ffffffff8010dbc6>{system_call+126}
 =>   dump-end timestamp 259455125

(               X-7860 |#0): new 17 us maximum-latency critical section.
 => started at timestamp 375451745: <__schedule+0xb8/0x596>
 =>   ended at timestamp 375451762: <thread_return+0xb4/0x10a>

Call Trace:<ffffffff8014c42c>{check_critical_timing+492}
<ffffffff8014c64b>{sub_preempt_count_ti+75}
       <ffffffff803e7d9a>{thread_return+180} <ffffffff803e7ef5>{schedule+261}
       <ffffffff803e89e4>{schedule_timeout+148}
<ffffffff8013a660>{process_timeout+0}
       <ffffffff8018b767>{do_select+967} <ffffffff8018b2b0>{__pollwait+0}
       <ffffffff8018baad>{sys_select+749}
<ffffffff8010d9e9>{sys_rt_sigreturn+553}
       <ffffffff8010dbc6>{system_call+126}
 =>   dump-end timestamp 375451852

kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
lightning ~ #



lightning ~ # date && free
Tue Oct 11 16:21:41 PDT 2005
             total       used       free     shared    buffers     cached
Mem:        510460     410816      99644          0      15896     169664
-/+ buffers/cache:     225256     285204
Swap:       996020          0     996020
lightning ~ # date && free
Tue Oct 11 17:39:03 PDT 2005
             total       used       free     shared    buffers     cached
Mem:        510460     504464       5996          0      39828     119012
-/+ buffers/cache:     345624     164836
Swap:       996020        304     995716
lightning ~ #



(       hdspmixer-8071 |#0): new 18 us maximum-latency critical section.
 => started at timestamp 2132546112: <snd_ctl_open+0x71/0x200 [snd]>
 =>   ended at timestamp 2132546131: <snd_ctl_open+0x8a/0x200 [snd]>

Call Trace:<ffffffff8014c42c>{check_critical_timing+492}
<ffffffff8014c64b>{sub_preempt_count_ti+75}
       <ffffffff88006a0a>{:snd:snd_ctl_open+138}
<ffffffff8800414b>{:snd:snd_open+267}
       <ffffffff801806d9>{chrdev_open+441} <ffffffff801766a8>{__dentry_open+280}
       <ffffffff80176877>{filp_open+135}
<ffffffff8014c64b>{sub_preempt_count_ti+75}
       <ffffffff80176a06>{get_unused_fd+230} <ffffffff80176b71>{do_sys_open+81}
       <ffffffff8010dbc6>{system_call+126}
 =>   dump-end timestamp 2132546239

(          IRQ 58-4526 |#0): new 19 us maximum-latency critical section.
 => started at timestamp 8439787551: <__schedule+0xb8/0x596>
 =>   ended at timestamp 8439787571: <thread_return+0xb4/0x10a>

Call Trace:<ffffffff8014c42c>{check_critical_timing+492}
<ffffffff8014c64b>{sub_preempt_count_ti+75}
       <ffffffff803e7d9a>{thread_return+180}
<ffffffff80146550>{keventd_create_kthread+0}
       <ffffffff803e7ef5>{schedule+261} <ffffffff80156062>{do_irqd+514}
       <ffffffff80155e60>{do_irqd+0} <ffffffff8014650d>{kthread+205}
       <ffffffff8010e676>{child_rip+8}
<ffffffff80146550>{keventd_create_kthread+0}
       <ffffffff80354d00>{pci_conf1_read+0} <ffffffff80146440>{kthread+0}
       <ffffffff8010e66e>{child_rip+0}
 =>   dump-end timestamp 8439787658

lightning ~ #


Now, I know these command line methods are probably frowned upon by
folks in the know so I'm happy to do this in a more rigorous way. (Is
it called valgrind?) Should free memory drop like that over time?

The only apps running were Aqualung, hdspmixer and Firefox. Is one of
them leaking, is the kernel leaking, or is this normal?

I will continue to let this run for another 4-6 hours today and hope I
catch another xrun. If not I'll start it up again tomorrow and
certainly will get something.

Thanks much,
Mark
