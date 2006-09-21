Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWIUEyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWIUEyn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 00:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWIUEyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 00:54:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41180 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751220AbWIUEym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 00:54:42 -0400
Date: Thu, 21 Sep 2006 06:46:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
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
Subject: Re: [PATCH] Linux Markers 0.4 (+dynamic probe loader) for 2.6.17
Message-ID: <20060921044603.GA2089@elte.hu>
References: <20060920234517.GA29171@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920234517.GA29171@Krystal>
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

> +menu "Marker configuration"

> +config MARK_SYMBOL
> +	bool "Replace markers with symbols"
> +	  Put symbols in place of markers, useful for kprobe.
> +
> +config MARK_JUMP_CALL
> +	bool "Replace markers with a jump over an inactive function call"
> +	  Put a jump over a call in place of markers.
> +
> +config MARK_JUMP_INLINE
> +	bool "Replace markers with a jump over an inline function"
> +	  Put a jump over an inline function.

This patch still has the fundamental failure of offering 3 annotation 
methods instead of offering _one_ annotation method. I mention it again, 
distros want to have _one_ method they enable, not: "oh, by the way, LTT 
requires MARK_JUMP_CALL, so no matter how low-overhead MARK_SYMBOL is, 
you have to enable MARK_JUMP_CALL anyway".

We have to face it, tracing is a very optional infrastructure, thus it 
has to be _very low (preferably zero in most cases) overhead when 
offered by a kernel binary but kept inactive by the user_ and thus you 
/have to/ program on the edge to get it into the upstream kernel.

It wont be easy to achieve this, and you'll have to work with the other 
tracing projects (and upstream kernel folks) to get one unified markup 
mechanism agreed on, but nevertheless it's possible technologically.

and the only acceptable near-zero-overhead markup scheme proposed so far 
(and suggested by me all along) is the symbol based markup method. 
Symbol based markup also has the advantage that the coupling between the 
kernel and the tracer moves to the symbol space (from the binary 
instruction-stream space), and thus the in-kernel implementation of it 
becomes alot more flexible. Flexibility of the upstream kernel design is 
another thing that we require for 'very optional' features.

Yes, LTT will probably have to embrace kprobes/SystemTap to insert the 
tracepoints themselves, but that's the price we get for uniformity, and 
that's the price you get for _having the markers maintained upstream_.

If after that point upstream cannot optimize kprobes performance to a 
sufficient level, /then/ can we think about /perhaps/ allowing direct 
calls generated into the kernel image. But that decision /must/ be 
driven by distributions and customers. Until then, kprobes based marking 
and tracing will be 'good enough'.

It affects all tracers: SystemTap/LKST has to adapt to such a scheme 
too, because currently there's no markup scheme in the kernel. So this 
is not something 'against' LTT, but something /for/ a unified landscape 
of tracers. (and as i mentioned it before, it will be easy for you to 
offer a simple "LTT speedup patch", which distros and the upstream 
kernel can consider separately. But it must be /optional/.)

So far i have not seen any real arguments against this simple but 
fundamental upstream requirement which i pointed out for v0.1 already.

	Ingo
