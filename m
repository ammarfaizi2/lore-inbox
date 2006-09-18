Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbWIRAPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWIRAPi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWIRAPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:15:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1432 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965166AbWIRAPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:15:37 -0400
Date: Mon, 18 Sep 2006 02:07:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918000703.GA22752@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060917153633.GA29987@Krystal>
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


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> * Ingo Molnar (mingo@elte.hu) wrote:
> >   - model #2: we could have the least intrusive markers in the main
> >     kernel source, while the more intrusive ones would still be in the
> >     upstream kernel, but in scripts/instrumentation/.
> > 
> 
> Please define : marker intrusiveness. I think that this is not a sole 
> concept. First, I think we have to look at intrusiveness under three 
> different angles :
> 
> - Visual intrusiveness (hurts visually in the code)
> - Compiled-in, but inactive intrusiveness
>   - Modifies compiler optimisations when the marker is compiled in but no
>     tracing is active.
>   - Wastes a few cycles because it adds NOPs, jump, etc in a critical path
>     when tracing is not active.
> - Active tracing intrusiveness
>   - Wastes too many cycles in a critical path when tracing is active.

as the primary factor i'd add:

  - Maintainance intrusiveness

but yes, agreed - with that addition this is a good summary of the 
intrusiveness factors.

> The problem is that a static marker will speed up the active tracing 
> while a dynamic probe will speed up the case where tracing is 
> inactive. The problem is that the dynamic probe cost can get so big 
> that it modifies the traced system often more than acceptable. [...]

do you base this opinion of yours on the kprobes+LTT experiment you did 
yesterday? If yes then would it be possible for you to try the 3 patches 
that i sent, and re-measure the impact of kprobes? The kprobes overhead 
should go down a bit, it would be interesting to see by how much.

Also, when forming your opinion do you consider djprobes - which in 
essence inserts a function call (and not an INT3) into the probed code?

> [...] Under this angle, I would be tempted to say that the most 
> intrusive instrumentation should be helped by marker, which means 
> accepting a very small performance impact (NOPs on modern CPUs are 
> quite fast) when tracing is not active in order to enable fast tracing 
> of some very high event rate kernel code paths.

i'm not fundamentally worried about the runtime impact of static probes, 
as long as the impact is unmeasurable. I'm more worried about their 
maintainance impact - so i want the option to move them to a dynamic 
script, if the tracepoint is for example not frequent. (but being a 
perfectionist i cannot completely forget about their runtime overhead 
either)

> >   - model #3: we could have the 'hardest' markups in the source, and the 
> >     'easy' ones as dynamic markups in scripts/instrumentation/.
> > 
> By "hardest", do you mean : where the data that is to be extracted is 
> not easily available due to compiler optimisations ?

yeah - hard in the sense of dynamic probing.

> > i agree, as long as it's lightweight markers for _dynamic tracers_, 
> > so that we keep our options open - as per the arguments above.
> 
> But I also think that a marker mechanism should not only mark the code 
> location where the instrumentation is to be made, but also the 
> information the probe is interested into (provide compile-time data 
> type verification and address at runtime). Doing otherwise would limit 
> what could be provided to static markup users.

yeah. If you look at the API suggestions i made, they are such. There 
can be differences though to 'static tracepoints used by static 
tracers': for example there's no need to 'mark' a static variable, 
because dynamic tracers have access to it - while a static tracer would 
have to pass it into its trace-event function call.

	Ingo
