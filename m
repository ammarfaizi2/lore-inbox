Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVGBVEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVGBVEd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 17:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGBVEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 17:04:32 -0400
Received: from opersys.com ([64.40.108.71]:7436 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261210AbVGBVEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:04:23 -0400
Message-ID: <42C703E4.2060202@opersys.com>
Date: Sat, 02 Jul 2005 17:15:16 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Michael Raymond <mraymond@sgi.com>
Subject: Re: [PATCH/RFC] Significantly reworked LTT core
References: <42C60001.5050609@opersys.com> <20050702160445.GA29262@infradead.org>
In-Reply-To: <20050702160445.GA29262@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the feedback, it's greatly appreciated.

Christoph Hellwig wrote:
> This code is rather pointless.  The ltt_mux is doing all the real
> work and it's not included.  And while we're at it the layering for
> it is wrong aswell - the ltt_log_event API should be implemented by
> the actual multiplexer with what's in ltt_log_event now minus the
> irq disabling becoming a library function.

Actually I kind of disagree here. Yes, you're partially right, ltt_mux
is doing a lot of work, and it's not included. However, what work
ltt_mux is doing is administrative and that's what was complained
about a lot last time the ltt patches were included. So yes, I could
provide a very basic ltt_mux that would instantiate a single relayfs
channel and does no filtering whatsoever, but that would be
insufficient for real usage. And if I provided a full mux, then we'd
pretty much end up with the same code we had previously.

By having it this way, the essential part of the mechanism, its
logging code, is shared by all, yet there can be any number of muxes
loaded on top of it. The LKST project, for example, has got a module
that just counts the events that occur. Plug that as the mux, and
always return NULL (no channel to write to) and you've ready to go.

For ltt, the mux would be quite involved, including having netlink
sockets going back and forth talking to a user-space daemon, and
allowing quite a few options/features to be set.

In other cases, it should be fairly simple to implement a mux
local to a given subsystem that a developer needs to monitor. He
can then manage everything about how tracing goes on without having
to rewrite his own logging function.

The rational here is simple: there is no need to have multiple
logging functions, but there are already multiple existing
implementations of deciding how and what needs to be logged,
how it's control, and how it interfaces with the outside world
(be it user-space or otherwise.) This code, simplistic as it may be,
serves this reality quite well.

If what's in ltt_log_event goes into the multiplexer, then we're
back to having each implementation have its own buffering mechanism
and yet no single entry-point for tracing inside the kernel.

Replacing local_irq_disable/enable() with function pointers is not
a problem, if that's something desirable.

> Exporting a pointer to the root dentry seems like a very wrong API
> aswell, that's an implementation detail that should be hidden.

That's just to allow add-on modules to find the hook point within
relayfs. We could just leave it to the multiplexer to "init tracing"
and then provide an API such as ltt_chan_add, ltt_chan_del,
ltt_chan_ctl, etc.

> Besides that the code is not following Documentation/CodingStyle
> at all, please read it.

I'll double-check, thanks.

> Besides that I'd sugest scrapping the ltt name and ltt_ prefix - we know
> we're on linux, adn we don't care whether it's a toolkit, but spelling trace_
> out would actually be a lot more descriptive.  So what about trace_* symbol
> names and trace.[ch] filenames?

I don't feel in any way patriotic about the ltt_ prefix, any other
name will do just fine. However, trace_ is so generic as to be
confusing. There are already plenty of trace* in the kernel. If
you've got any other more-specific/less-generic name, I'm all ears.
How about evtrace?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
