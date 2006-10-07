Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbWJGTDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbWJGTDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWJGTDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:03:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932719AbWJGTDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:03:40 -0400
Date: Sat, 7 Oct 2006 12:03:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
 handle IRQ -1"
In-Reply-To: <m14pugxe47.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0610071154510.3952@g5.osdl.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
 <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com>
 <m1d5951gm7.fsf@ebiederm.dsl.xmission.com> <20061006202324.GJ14186@rhun.haifa.ibm.com>
 <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com> <20061007080315.GM14186@rhun.haifa.ibm.com>
 <m14pugxe47.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Oct 2006, Eric W. Biederman wrote:
> 
> I am hoping that by running the apics in a different delivery mode
> that explicitly says just deliver this interrupt to this cpu we
> will avoid the problem you are seeing.

Note that having too strict delivery modes could be a major pain in the 
future, with things like multicore CPU's a lot more actively doing power 
management on their own, and effectively going into sleep-states with 
reasonably long latencies.

Especially with schedulers that are aware of things like that (and we 
_try_, at least to some degree, and people are interested in more of it), 
you can easily be in the situation that one of the cores is being fairly 
actively kept in a low-power state, and can have millisecond latencies 
(not to mention no L1 cache contents etc).

So I really do think that the belief that we should force irqs to a 
particular core is fundamentally flawed.

We used to do lowest-priority stuff in hw, and then Intel broke it, but I 
always told them that they were _stupid_ to break it. The fact is, 
especially with multi-core, it actually makes a lot of sense to have 
hardware decide which core to interrupt, because hardware simply 
potentially knows better.

This is one of those age-old questions: in _theory_ you can do a better 
job in software, but in _practice_ it's just too damn expensive and 
complicated to do a perfect job especially with dynamic decisions, so in 
_practice_ it tends to be better to let hardware make some of the 
decisions.

We can see the same thing in instruction scheduling: in _theory_ a 
compiler can do a better job of scheduling, since it can spend inordinate 
amounts of resources on doing things once, and then the hardware can be 
simpler and faster and never worry about it. In _practice_, however, the 
biggest scheduling decisions are all dynamic at run-time, and depend on 
things like cache misses etc, and only total idiots (or embedded people) 
will do static scheduling these days.

I think it's a huge mistake to do static interrupt routing for the same 
reason.

			Linus
