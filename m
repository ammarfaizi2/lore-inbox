Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWGCRBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWGCRBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWGCRBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:01:16 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:35976 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751207AbWGCRBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:01:14 -0400
Date: Mon, 3 Jul 2006 22:27:50 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060703165750.GB3899@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060627200105.GA13966@in.ibm.com> <20060628182137.GA23979@in.ibm.com> <20060628193256.GA4392@elte.hu> <20060628200247.GA7932@in.ibm.com> <20060629142442.GA11546@elte.hu> <20060629163236.GD1294@us.ibm.com> <20060629194145.GA2327@us.ibm.com> <20060629201144.GA24287@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629201144.GA24287@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 10:11:45PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > OK, I ran this with both torture types (rcu and rcu_bh) on i386 with 
> > CONFIG_PREEMPT=y on 2.6.17-mm4 and didn't see any "scheduling while 
> > atomic" oopses -- or any other oopses, for that matter.
> > 
> > Here is the .config file I used.  What am I missing here?
> 
> hm, i'm seeing some other types of crashes too - so rcutorture could 
> just have been collateral damage. It was on i386, an allyesconfig 
> bzImage kernel.

With 2.6.17-rt5 I see this -

llm17:~/rcutorture # set -o vi^H^H^H^H^H^H^H^H^H./rcutorture.sh ^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^Hls^H^H./rcutorture.sh ^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H
Starting pass 0
Unable to handle kernel paging request at ffffffff88006bd0 RIP:
<ffffffff802597d5>{rcu_process_callbacks+107}
rcutorture: --- End of test: SUCCESS: nreaders=8 stat_interval=1PGD 203027 PUD 205027 PMD 21eb18067 PTE 21829f163
Oops: 0000 [1] PREEMPT SMP
CPU 1
Modules linked in:
Pid: 19, comm: softirq-tasklet Not tainted 2.6.17-rt5 #1
RIP: 0010:[<ffffffff802597d5>] <ffffffff802597d5>{rcu_process_callbacks+107}
RSP: 0000:ffff810220a9deb8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff80713570 RCX: 0000000000000003
RDX: 0000000000000001 RSI: ffff810220a9c010 RDI: 0000000000000003
RBP: ffffffff88006bd0 R08: ffff810220a9c000 R09: ffff810220a8fed8
R10: ffff810220a8fe08 R11: ffffffff804fdb7e R12: 0000000000000000
R13: ffff8100051a7310 R14: ffffffff80531258 R15: ffffffff807b1310
FS:  0000000000000000(0000) GS:ffff810220b0cd40(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff88006bd0 CR3: 0000000000201000 CR4: 00000000000006e0
Process softirq-tasklet (pid: 19, threadinfo ffff810220a9c000, task ffff810220a9ad30)
Stack: ffff810220a41bc8 ffffffff80713570 00000000000f4240 ffffffff802357ef
       ffff8100051a7310 0000000000000020 ffff810220a41bc8 ffffffff80235f3b
       ffffffff00000001 ffffffff807b1310
Call Trace:
       <ffffffff802357ef>{__tasklet_action+181}
       <ffffffff80235f3b>{ksoftirqd+280}
       <ffffffff80235e23>{ksoftirqd+0}
       <ffffffff80243251>{kthread+212}
       <ffffffff80235e23>{ksoftirqd+0}
       <ffffffff8020a74e>{child_rip+8}
       <ffffffff80235e23>{ksoftirqd+0}
       <ffffffff8024317d>{kthread+0}
       <ffffffff8020a746>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------

I have been able to reproduce a similar looking oopse with 2.6.16-rt29.
2.6.16-rt20 works fine. I will try to track it down to the exact
release as far as I can.

Thanks
Dipankar
