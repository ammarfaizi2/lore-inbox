Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932833AbWJGU0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbWJGU0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWJGU0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:26:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49797 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932836AbWJGU0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:26:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
	<m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	<20061006202324.GJ14186@rhun.haifa.ibm.com>
	<m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	<20061007080315.GM14186@rhun.haifa.ibm.com>
	<m14pugxe47.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610071154510.3952@g5.osdl.org>
Date: Sat, 07 Oct 2006 14:24:15 -0600
In-Reply-To: <Pine.LNX.4.64.0610071154510.3952@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 7 Oct 2006 12:03:16 -0700 (PDT)")
Message-ID: <m1r6xjx4b4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 7 Oct 2006, Eric W. Biederman wrote:
>> 
>> I am hoping that by running the apics in a different delivery mode
>> that explicitly says just deliver this interrupt to this cpu we
>> will avoid the problem you are seeing.
>
> Note that having too strict delivery modes could be a major pain in the 
> future, with things like multicore CPU's a lot more actively doing power 
> management on their own, and effectively going into sleep-states with 
> reasonably long latencies.

Sure.

> Especially with schedulers that are aware of things like that (and we 
> _try_, at least to some degree, and people are interested in more of it), 
> you can easily be in the situation that one of the cores is being fairly 
> actively kept in a low-power state, and can have millisecond latencies 
> (not to mention no L1 cache contents etc).
>
> So I really do think that the belief that we should force irqs to a 
> particular core is fundamentally flawed.

For me this isn't about forcing an irq to a particular cpu.  It
is about not having global vector allocation, because that simply
cannot scale.

Being able to allocate a vector for just a subset of the cpus means we can
support arbitrarily large systems.  Making the size of the pool a single
cpu was the simplest implementation of that idea.

> We used to do lowest-priority stuff in hw, and then Intel broke it, but I 
> always told them that they were _stupid_ to break it. The fact is, 
> especially with multi-core, it actually makes a lot of sense to have 
> hardware decide which core to interrupt, because hardware simply 
> potentially knows better.
>
> This is one of those age-old questions: in _theory_ you can do a better 
> job in software, but in _practice_ it's just too damn expensive and 
> complicated to do a perfect job especially with dynamic decisions, so in 
> _practice_ it tends to be better to let hardware make some of the 
> decisions.
>
> We can see the same thing in instruction scheduling: in _theory_ a 
> compiler can do a better job of scheduling, since it can spend inordinate 
> amounts of resources on doing things once, and then the hardware can be 
> simpler and faster and never worry about it. In _practice_, however, the 
> biggest scheduling decisions are all dynamic at run-time, and depend on 
> things like cache misses etc, and only total idiots (or embedded people) 
> will do static scheduling these days.
>
> I think it's a huge mistake to do static interrupt routing for the same 
> reason.

I have no problem with that.  The only place where I caused a behavior
changes on x86_64 is genapic_flat which does this, and I figured it was
not a big deal simply because CONFIG_CPU_HOTPLUG is the default so it
is rarely used.  I figured if  my implementation was too simple someone
would scream and I could add the complexity to the vector allocator to
enable lowest priority interrupt delivery.

Well someone has screamed :)

Eric
