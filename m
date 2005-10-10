Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVJJXtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVJJXtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVJJXtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:49:14 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:59803 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751124AbVJJXtN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:49:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GgwSrguk8QlPhOFLMzAOJQ0u/xpYx/uTy8s3TG44Ec+R2TBX5jKUPH/vzb/+BdzRGfu0BM3x7jADXOtcYzqV+9dhrz5xr7fLj0W5Ktl525vq6Nq2juw/zUTbbxMe9i9D1VNJZmkBX+a9TNAEOQUGYWGU82NK9vbhPQ33nZQYx+s=
Message-ID: <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
Date: Mon, 10 Oct 2005 16:49:12 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Mark Knecht <markknecht@gmail.com> wrote:
> On 10/10/05, Daniel Walker <dwalker@mvista.com> wrote:
>
> > > Yes, already that looks interesting. Do I have something going on with
> > > acpi? This is before running Jack. I'm in Gnome.There are a lot of
> > > these messages, but they've stopped. I suppose the 3997 is the delay?
> > > That would coorespond with the info I sent earlier.
> >
> > I think this is a false reading . Sometimes when a system goes idle it
> > will cause interrupt disable latency that isn't real (due to process
> > halting) . You could try turning ACPI off if you can , and turn off
> > power management ..
> >
> > Daniel
>
> OK. NO immediate difference with most of the power management stuff
> turned off. I'll just let it run a few hours and see if I get an xrun.
> If I do I'll look at the logs again and report back.
>
> Thanks for the help. I feel like I've got a chance of spotting something.
>
> Cheers,
> Mark

Well, I'm disappointed again. Some xruns came but no additional data
was put into the dmesage file:

( softirq-timer/0-3    |#0): new 3997 us maximum-latency critical section.
 => started at timestamp 253995015: <acpi_processor_idle+0x20/0x379>
 =>   ended at timestamp 253999013: <thread_return+0xb5/0x11a>

Call Trace:<ffffffff8014e32c>{check_critical_timing+492}
<ffffffff8014e785>{sub_preempt_count_ti+133}
       <ffffffff803ec76c>{thread_return+70}
<ffffffff803ec7db>{thread_return+181}
       <ffffffff803ec945>{schedule+261} <ffffffff801371ca>{ksoftirqd+138}
       <ffffffff80137140>{ksoftirqd+0} <ffffffff8014740d>{kthread+205}
       <ffffffff8010e6e6>{child_rip+8} <ffffffff80147340>{kthread+0}
       <ffffffff8010e6de>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803ec238>] .... __schedule+0xb8/0x5a6
.....[<00000000>] ..   ( <= 0x0)

 =>   dump-end timestamp 253999092

kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
lightning ~ #

Basically the trace above was there pretty much right after booting. I
mounted a 1394 drive, which is shown, and then started running apps. I
got 3 xruns:

16:42:59.826 XRUN callback (1).
**** alsa_pcm: xrun of at least 0.273 msecs
16:43:03.764 XRUN callback (2).
**** alsa_pcm: xrun of at least 2.082 msecs
16:43:41.618 XRUN callback (3).
**** alsa_pcm: xrun of at least 2.040 msecs

but no additional data in the logs.

So possibly this is an IRQ off latency? Or am I jumping to
conclusions? The trace above, if I understand it, indicates a delay of
nearly 4mS, and again, since I'm trying to run at sub 3mS, that would
seem like a potential problem.

I'm going to completely shut off power management as a test just to
see where that leads.

- Mark
