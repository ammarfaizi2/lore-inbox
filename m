Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270896AbUJUUPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270896AbUJUUPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270930AbUJUUJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:09:11 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:17680 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S270935AbUJUUGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:06:07 -0400
Message-ID: <417816BA.9000907@stud.feec.vutbr.cz>
Date: Thu, 21 Oct 2004 22:06:18 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
In-Reply-To: <20041021132717.GA29153@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -U9 Real-Time Preemption patch, which can be
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/

I have a reproducible BUG which I first hit in -U9 and it's in -U9.2 
too. It occurs always when a packet hits a REJECT rule in the INPUT 
chain of iptables.
To reproduce: iptables -I INPUT 1 -p tcp --dport 666 -j REJECT
...and telnet your TCP port 666 from the network.


BUG: semaphore recursion deadlock detected!
.. current task ksoftirqd/0/2 is already holding f890a6d4.
c0414ec4 f7c27f64 0000012c 00000001 f7c26000 00000000 f7c27f9c c0121687
        c03c8118 c0121758 c0121ae4 0000000a c03c8118 f7c26000 f7c26000 
00000000
        f7c27fa4 c0121770 f7c27fbc c0121ae4 00000001 fffffff6 f7c26000 
f7c25f70
Call Trace:
  [<c0121687>] ___do_softirq+0x87/0xd0 (32)
  [<c0121758>] _do_softirq+0x8/0x30 (8)
  [<c0121ae4>] ksoftirqd+0x94/0xe0 (4)
  [<c0121770>] _do_softirq+0x20/0x30 (28)
  [<c0121ae4>] ksoftirqd+0x94/0xe0 (8)
  [<c013116a>] kthread+0xaa/0xb0 (24)
  [<c0121a50>] ksoftirqd+0x0/0xe0 (20)
  [<c01310c0>] kthread+0x0/0xb0 (12)
  [<c0103319>] kernel_thread_helper+0x5/0xc (16)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: down_write+0x1a4/0x1b0 / (ipt_do_table+0x6a/0x330 [ip_tables])
.. entry 2: down_write+0x72/0x1b0 / (ipt_do_table+0x6a/0x330 [ip_tables])
.. entry 3: print_traces+0x1d/0x90 / (show_stack+0x83/0xa0)


Michal
