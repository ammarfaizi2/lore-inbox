Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVA0WQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVA0WQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVA0WQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:16:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19042
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261221AbVA0WLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:11:33 -0500
Date: Thu, 27 Jan 2005 23:11:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: tglx@linutronix.de, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: User space out of memory approach
Message-ID: <20050127221129.GX8518@opteron.random>
References: <1105403747.17853.48.camel@tglx.tec.linutronix.de> <20050111083837.GE26799@dualathlon.random> <3f250c71050121132713a145e3@mail.gmail.com> <3f250c7105012113455e986ca8@mail.gmail.com> <20050122033219.GG11112@dualathlon.random> <3f250c7105012513136ae2587e@mail.gmail.com> <1106689179.4538.22.camel@tglx.tec.linutronix.de> <3f250c71050125161175234ef9@mail.gmail.com> <20050126004901.GD7587@dualathlon.random> <3f250c7105012710541d3e7ad1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f250c7105012710541d3e7ad1@mail.gmail.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 02:54:13PM -0400, Mauricio Lin wrote:
> Hi Andrea,
> 
> On Wed, 26 Jan 2005 01:49:01 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> > On Tue, Jan 25, 2005 at 08:11:19PM -0400, Mauricio Lin wrote:
> > > Sometimes the first application to be killed is XFree. AFAIK the
> > 
> > This makes more sense now. You need somebody trapping sigterm in order
> > to lockup and X sure traps it to recover the text console.
> > 
> > Can you replace this:
> > 
> >         if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
> >                 force_sig(SIGTERM, p);
> >         } else {
> >                 force_sig(SIGKILL, p);
> >         }
> > 
> > with this?
> > 
> >         force_sig(SIGKILL, p);
> > 
> > in mm/oom_kill.c.
> 
> Nice. Your suggestion made the error goes away.
> 
> We are still testing in order to compare between your OOM Killer and
> Original OOM Killer.

Ok, thanks for the confirmation. So my theory was right.

Basically we've to make this patch, now that you already edited the
code, can you diff and send a patch that will be the 6/5 in the serie?

(then after fixing this last very longstanding [now deadlock prone too]
bug, we can think how to make at a 7/5 that will wait a few seconds
after sending a sigterm, to fallback into a sigkill, that shouldn't be
difficult, but the above 6/5 will already make the code correct)

Note, if you add swap it'll workaround it too since then the memhog will
be allowed to grow to a larger rss than X. With 128m of ram and no swap,
X is one of the biggest with xshm involved from some client app
allocating lots of pictures. I could never notice since I always tested
it either with swap or on higher mem systems and my test box runs
with an idle X too which isn't that big ;).
