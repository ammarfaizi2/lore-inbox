Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVA1PVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVA1PVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVA1PVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:21:46 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:49442 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbVA1PVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:21:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Pq3CdLxl3TGFESa013NEEMmk7cTzOYSGEnCHgWNzgq6NiaWWfUfx0lbGdeAp/IB6twrimI4JuL6gS33lvlUA18KDM9sVn0jbnD03XpmRBg5pOdEe/mqZ+OK+kK391T28f9sixx8k4qKzTvRY2/GzKRaaPox3tLWFSL75hCQkUHs=
Message-ID: <3f250c71050128072151b46a2b@mail.gmail.com>
Date: Fri, 28 Jan 2005 11:21:11 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: User space out of memory approach
Cc: tglx@linutronix.de, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       ville.medeiros@gmail.com
In-Reply-To: <3f250c7105012805585c01a26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <3f250c7105012113455e986ca8@mail.gmail.com>
	 <20050122033219.GG11112@dualathlon.random>
	 <3f250c7105012513136ae2587e@mail.gmail.com>
	 <1106689179.4538.22.camel@tglx.tec.linutronix.de>
	 <3f250c71050125161175234ef9@mail.gmail.com>
	 <20050126004901.GD7587@dualathlon.random>
	 <3f250c7105012710541d3e7ad1@mail.gmail.com>
	 <20050127221129.GX8518@opteron.random>
	 <3f250c7105012805585c01a26@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,


On Fri, 28 Jan 2005 09:58:24 -0400, Mauricio Lin <mauriciolin@gmail.com> wrote:
> Hi Andrea,
> 
> On Thu, 27 Jan 2005 23:11:29 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> > On Thu, Jan 27, 2005 at 02:54:13PM -0400, Mauricio Lin wrote:
> > > Hi Andrea,
> > >
> > > On Wed, 26 Jan 2005 01:49:01 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> > > > On Tue, Jan 25, 2005 at 08:11:19PM -0400, Mauricio Lin wrote:
> > > > > Sometimes the first application to be killed is XFree. AFAIK the
> > > >
> > > > This makes more sense now. You need somebody trapping sigterm in order
> > > > to lockup and X sure traps it to recover the text console.
> > > >
> > > > Can you replace this:
> > > >
> > > >         if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
> > > >                 force_sig(SIGTERM, p);
> > > >         } else {
> > > >                 force_sig(SIGKILL, p);
> > > >         }
> > > >
> > > > with this?
> > > >
> > > >         force_sig(SIGKILL, p);
> > > >
> > > > in mm/oom_kill.c.
> > >
> > > Nice. Your suggestion made the error goes away.
> > >
> > > We are still testing in order to compare between your OOM Killer and
> > > Original OOM Killer.
> >
> > Ok, thanks for the confirmation. So my theory was right.
> >
> > Basically we've to make this patch, now that you already edited the
> > code, can you diff and send a patch that will be the 6/5 in the serie?
> 
> OK. I will send the patch.

As you know, Andrew generated the patch. Here goes some test results
about your OOM Killer and the Original OOm Killer. We accomplished 10
experiments for each OOM Killer and below are average values.

"Invocations" is the number of times that out_of_memory function is
called. "Selections" is the number of times that select_bad_process
function is called and "Killed" is the number of killed process.

Original OOM Killer
Invocations average = 51620/10 = 5162
Selections average = 30/10 = 3
Killed average = 38/10 = 3.8

Andrea OOM Killer
Invocations average = 213/10 = 21.3
Selections average = 213/10 = 21.3
Killed average = 52/10 = 5.2

As you can see the number of invocations reduced significantly using
your OOM Killer.

I did not know about this problem when I was moving the original
ranking algorithm to userland. As Thomaz mentioned: invocation
madness, reentrancy problems and those strange timers and counter as
now, since, last, lastkill and count. I guess that now i can put some
OOM Killer stuffs in userland in a safer manner with those problems
solved, right?

BTW, will your OOM Killer be included in the kernel tree?

BR,

Mauricio Lin.
