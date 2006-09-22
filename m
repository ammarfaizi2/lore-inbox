Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWIVQz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWIVQz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWIVQz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:55:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:47842 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932591AbWIVQz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:55:27 -0400
Date: Fri, 22 Sep 2006 18:45:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060922164550.GA11857@elte.hu>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922070714.GB4167@elte.hu> <20060922150810.GB20839@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922150810.GB20839@Krystal>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:

> Some details are worth to be mentioned :
> 
> - The 5-NOP variant will imply a replacement of 5 1 bytes instructions 
>   with 1 5 bytes one, which is trickier. Masami Hiramatsu's proposal
>   of 2 bytes near jump + 3 NOPS is nicer.

yeah.

> - Patching such a 5-bytes instruction memory region doesn't turn 
>   markers into a complete function call, which includes argument 
>   passing.

please read:

   Message-ID: <20060921185029.GB12048@elte.hu>

about how to turn it into a complete function call / jump.

[ i came back to this point from the end of the mail, where you consider 
  this an "interesting idea" - so i guess your above claim is moot. If 
  it is not moot not then by all means i'm happy to further debate it. ]

> > And one reason why i want to avoid "static, build-time function call
> > based probing" is because high-performance computing users dont want 
> > any overhead at all in the kernel fastpath.
>
> - The argument "most of the users wont use a particular feature" 
>   contradicts what you said earlier about every distribution wanting 
>   to enable a tracing mechanism for their users.

enabling a feature does not mean it's actually used by most users!
For example, Fedora currently enables:

   CONFIG_NETPOLL=y

but only a tiny, tiny minority of users actually make use of it. Then 
why is it still enabled? Because it has little to zero overhead to have 
it enabled but not utilized. In the fastpath it has zero overhead. (and 
yes, i originally designed and implemented netpoll/netconsole to be like 
that, and i intentionally shaped it to be zero-overhead because i knew 
it would be used as a debug feature.)

the same goes for tracing. We want to have it enabled in distros, but 
only if it's near zero-cost. But because tracing wants to be there in 
every fastpath, we have to work /hard/ to achieve this desired 
end-result. I am "in your way" unfortunately /precisely/ because tracing 
we want to enable in Fedora, but we want to pay as little cycles for it 
on 99.998% of the Fedora boxes that wont be using any tracing at all. 

> > > - High performance computing users won't want a breakpoint-based probe
> > 
> > I am not forcing breakpoint-based probing, at all. I dont want _static, 
> > build-time function call based_ probing, and there is a big difference. 
> > And one reason why i want to avoid "static, build-time function call 
> > based probing" is because high-performance computing users dont want any 
> > overhead at all in the kernel fastpath.
> > 
> 
> I think that the performance benefits gained by using tracing 
> information for studying a system makes the overhead of a jump in the 
> kernel fast path insignificant. [...]

sorry, but as Alan mentioned it before, this leads to "death by a 
million cuts". See above to understand what kind of feature is 
acceptable to a distro (and hence to the upstream kernel) and what not.

> > > - djprobe is far away from being in an acceptable state on 
> > >   architectures with very inconvenient erratas (x86).
> > 
> > djprobes over a NOP marker are perfectly usable and safe: just add a 
> > simple constraint to them to only allow a djprobes insertion if it 
> > replaces a 5-byte NOP.
> > 
> 
> 2 bytes jump + 3 bytes nops.. Yes, it should modify it without causing an
> illegal instruction, but how ? Are you aware that their approach has to :
> - put an int3
> - wait for _all_ the CPUs to execute this int3
> - then change the 5 bytes instruction
>
> I can think of a lot of cases where the CPUs will never execute this 
> int3. Probably that sending an IPI or launching a kernel thread on 
> each CPU to make sure that this int3 is executed could give more 
> guarantees there. [...]

this is easy to solve, for example via the use of freeze_processes() and 
thaw_processes().

> > > - kprobe and djprobe cannot access local variables in every cases
> > 
> > it is possible with the marker mechanism i outlined before:
> > 
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=115886524224874&w=2
> > 
> > have i missed to address any concern of yours?
> 
> Interesting idea. That would make it possible to probe local variables 
> at the marker site. That's very good for use of kprobes on low rate 
> debug-type markers, but that doesn't solve my concern about the 
> cat-and-mouse race expressed earlier about live kernel polymorphic 
> code.

i dont consider polymorphic code a problem at all. Java JITs (and the 
dot-NET runtime) are faced with it every day and they have no problem 
_dynamically rewriting high-performance code all the time_. In fact, in 
the kernel we have /more/ tools to solve such problems. We can disable 
interrupts, we can flush caches, we can send IRQs, we have total control 
over every task in the system, etc., etc.

Furthermore, it is even more of a side issue in our case because unlike 
Java JITs, for us the polymorphic code is in the /absolute slowpath/. We 
could even turn off all caches while doing the code patching and nobody 
would notice. (but such drastic measures are not needed at all)

	Ingo
