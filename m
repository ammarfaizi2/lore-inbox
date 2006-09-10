Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWIJNWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWIJNWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWIJNWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:22:36 -0400
Received: from ns1.suse.de ([195.135.220.2]:7375 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932143AbWIJNWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:22:35 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Date: Sun, 10 Sep 2006 13:34:34 +0200
User-Agent: KMail/1.9.1
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu>
In-Reply-To: <20060910115722.GA15356@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101334.34867.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 13:57, Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> > > This kernel won't boot here: it starts a GPFs loop on
> > > early boot. I attached a screenshot of the first GPF
> > > (pause_on_oops=120 helped).
> >
> > It's lockdep's fault. This patch should fix it:>
> Well, it's also x86_64's fault: why does it call into a generic C 
> function (x86_64_start_kernel()) without having a full CPU state up and
> running? i686 doesnt do it, never did.

Actually i686 does now (since Jeremy's patches). The patch was for i386.
x86_64 doesn't need it.

But enough blame game. The "fault" in my original mail wasn't completely
serious anyways ...

>
> We had frequent breakages due to this property of the x86_64 arch code
> (many more than this single incident with lockdep), tracing and all
> sorts of other instrumentation (including earlier versions of lockdep)
> was hit by it again and again.

Well, just getting the new unwinder to work in lockdep was a nightmare
too (most of the problems I had with that were on i386, not x86-64) 
Just look at the number of patches that were needed for it.

>
> Basically, non-atomic setup of basic architecture state _is_ going to be
> a nightmare, lockdep or not, especially if it uses common infrastructure
> like 'current', spin_lock() or even something as simple as C functions.
> (for example the stack-footprint tracer was once hit by this weakness of
> the x86_64 code)

I disagree with that.  The nightmare is putting stuff that needs so much
infrastructure into the most basic operations.

> > Hackish patch to fix lockdep with PDA current
>
> hm, this is ugly beyond words. 

Agreed it is :). But it was the quickest way to fix it.

> Do you have a config i could try which 
> exhibits this problem? I'm sure there is a better solution.

You need the latest x86_64 patch (or latest mm) and enable lockdep
on i386. Possibly with some more interdependencies, but I hope not.

I guess a cleaner way would to set the global variable that turns
the tracing off during boot and then enable it when it starts making
sense. Not 100% sure where that point is.

-Andi
