Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965456AbWI0JKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965456AbWI0JKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965458AbWI0JKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:10:18 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:20178
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S965456AbWI0JKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:10:16 -0400
Date: Wed, 27 Sep 2006 02:09:39 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060927090939.GA17136@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com> <20060927050856.GA16140@gnuppy.monkey.org> <m11wpxrgnm.fsf@ebiederm.dsl.xmission.com> <20060927063415.GB16140@gnuppy.monkey.org> <m1d59hpy1j.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d59hpy1j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 01:29:44AM -0600, Eric W. Biederman wrote:
> Bill Huey (hui) <billh@gnuppy.monkey.org> writes:
> > One of the main claims about the -rt patch is that the kernel is basically
> > conversion of the current locking semantics in the kernel. What you mentioned
> > above would deviate from that and and clutter non-preemptive kernel maintenance.
> > If you're suggesting a more general change to that function, then it wouldn't
> > violate that.
> 
> Yes I am.  The motivator would be the RT work but I don't see a reason why
> the it couldn't be put in the mainline kernel.  If not at least we need
> the big fat comment in the mainline kernel that says put_task_struct must
> be safe to call with interrupts disabled.
> 
> The way the code is structured now it deviates from the mainline kernel in
> more than just changing locking behavior.  Which is what brought me into
> this conversation in the first place.  So removing that point of discord
> would be good.

Yes, there are few places. It was primarily to handle the reaping during the
finishing parts of a fork. All in all, it's not at all a critical path.

> If you have fixed rwsem_down_failed_common() like it sounds like you have.
> That would be a nice patch to for the mainline kernel.

The problem only exists under -rt in that scheduling path. I can't comment if
it's desired for mainline or not.
 
> > There are a couple of issues here.
> >
> > (1) The RCU callback isn't used in this case to back other RCU read critical
> > sections. It's just used as a generic callback mechanism in this case. Some
> > consider it a hack.
> >
> > (2) RCU isn't necessarily bad for -rt since Paul McKenney and folks are
> > working on making it preempt friendly. Any talk of removing the use RCU in -rt
> > is premature and probably unlikely because of this work. There are many options
> > here. RCU very useful for scalability so seeing it go away in -rt would be
> > generally a bad thing IMO.
> 
> Agreed.  However until the issues are resolved with call_rcu it appears quite
> silly to increase the usage of it in the RT tree.  
> 
> About the rcu removal discussion I heard it was more the possibility was
> suggested because the downside was significant, and normal locks were
> more deterministic.  The emphasis was that call_rcu could be a problem and
> that something needs to happen to fix that. 

In a general purpose system as complicated as Linux, "locks being more
deterministic" is kind of ridiculous. Tons of stuff can happen that you
can't control. The RCU thing that you heard was probably just ideas being
thrown around and there are many options that haven't been explored yet.
The actual scenario is more complicated than what you might have initially
heard.

> Agreed.  The normal rcu path is quite nice.  It is the call_rcu part used
> to implement delayed freeing where things get ugly.

The RCU callback stuff runs as a thread. The key part of a preemptible system
that can make guarantees is the ability to response to a higher priority thread
in a deterministic amount of time. That's the only real guarantee that can be
made in that system. Because of it running in a thread, callbacks in RCU don't
effect the preemptibility of the system at all.

Any kernel thread taking the risk of acquiring a lock cannot be deterministic
in any reasonable sense. Any claims of a guarantee is pretty much a lie since
the system is too complicated to analysize for determinism in any meaningful
way using the analysis techniques out there. The kernel is just too complicated.

In contrast, specialize RT apps with few threads is another scenario that's much
more controllable.

> Yes the current logic is simple and requires no changes elsewhere.
> It is always nice when you can do that.  But in this case it adds unnecessary
> overhead, and indeterminism.   From what little I understand of RCU both
> of those are bad things.  Thus my gut feeling that the approach is a hack
> and should get fixed properly.

I agree. It's a hack and it should go away. You're the fourth person to mention
something about this, but it's up to Ingo.

> Anyway short of submitting a patch I think I have said enough.
> Thank you for the explanation.

No problem, any time :)

bill

