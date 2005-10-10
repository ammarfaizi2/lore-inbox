Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVJJWJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVJJWJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 18:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVJJWJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 18:09:45 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:32602 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751284AbVJJWJo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 18:09:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H4bi6Inqwhry4iiacdJQt5wYfj7UiZndPOVIKK3jKZNZtL4fBY7BLHifPYsajS5/MGVQyyXjE90gim4wlCmUAg1fuGv2xhoRchGDejBrZyM9gruEHCB82tObeEbaIgU0Kxt7az74kRWsL+coJyKPaGWgVfti6Ndm2neboOYiJkY=
Message-ID: <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
Date: Mon, 10 Oct 2005 15:09:43 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Daniel Walker <dwalker@mvista.com> wrote:
> On Mon, 2005-10-10 at 14:28 -0700, Mark Knecht wrote:
> > On 10/10/05, Mark Knecht <markknecht@gmail.com> wrote:
> > <SNIP>
> > > > then goto Kernel Hacking and select
> > > > "Interrupts-off critical section latency timing"
> > > > Then select "Latency tracing"
> >
> > Only had to turn on Latency Tracing. The others I had on...
> >
> > <SNIP>
> > > >
> > > > Daniel
> > >
> > > Will do. Building now. I'll be back later.
> > >
> >
> > Unfortunately I didn't think I'd be back this fast. I built the new
> > kernel and rebooted. The boot starts, gets down to the point where it
> > tells me that the preempt debug stuff is on, and then jumps to an
> > endlessly repeating error message:
> >
> > init[1]: segfault at ffffffff8010fce0 rip ffffffff8010fce0 rsp
> > 00007fffffcb09b8 error 15
> >
> > This error repeasts endlessly until I reboot.
> >
> > Good thing I had another kernel I could boot back into! ;-)
> >
> > So, something isn't happy. Is this a -rt thing or a kernel issue?
>
> Hmm, it looks like latency tracing doesn't work on x86_64 .. I guess
> you'll have to wait till someone fixes it .
>
> Another option is to turn off "Latency Tracing" then reboot, like it was
> before but w/o the histogram. Then run,
>
> "echo 0 > /proc/sys/kernel/preempt_max_latency"
>
> Whenever a new maximum latency is observed it will log it with a stack
> trace in the system logs. You can report that back here on LKML .
>
> You can view the system log with the command "dmesg" , I think .
>
> Daniel
>
>
Yes, already that looks interesting. Do I have something going on with
acpi? This is before running Jack. I'm in Gnome.There are a lot of
these messages, but they've stopped. I suppose the 3997 is the delay?
That would coorespond with the info I sent earlier.

( softirq-timer/0-3    |#0): new 3997 us maximum-latency critical section.
 => started at timestamp 185717289: <acpi_processor_idle+0x20/0x379>
 =>   ended at timestamp 185721287: <thread_return+0xb5/0x11a>

Call Trace:<ffffffff801519ac>{check_critical_timing+492}
<ffffffff80151e05>{sub_preempt_count_ti+133}
       <ffffffff803f632c>{thread_return+70}
<ffffffff803f639b>{thread_return+181}
       <ffffffff803f6505>{schedule+261} <ffffffff8013a84a>{ksoftirqd+138}
       <ffffffff8013a7c0>{ksoftirqd+0} <ffffffff8014aa8d>{kthread+205}
       <ffffffff8010f716>{child_rip+8} <ffffffff8014a9c0>{kthread+0}
       <ffffffff8010f70e>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803f5df8>] .... __schedule+0xb8/0x5a6
.....[<00000000>] ..   ( <= 0x0)

 =>   dump-end timestamp 185721364

mark@lightning ~ $

   I started up Jack, mounted my 1394 drives and started streaming a
little bit of data. Basicaly my ultra-light load test. I see nothing
new in dmesg yet. I'll keep watching.

Thanks,
Mark
