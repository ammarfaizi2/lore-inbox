Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUI1Xzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUI1Xzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 19:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268104AbUI1Xzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 19:55:46 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:14744 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268101AbUI1Xzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 19:55:39 -0400
Date: Wed, 29 Sep 2004 01:55:38 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: jonathan@jonmasters.org, Lars Marowsky-Bree <lmb@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040928235537.GC29719@MAIL.13thfloor.at>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	jonathan@jonmasters.org, Lars Marowsky-Bree <lmb@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Thomas Habets <thomas@habets.pp.se>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200409242158.40054.thomas@habets.pp.se> <1096060549.10797.10.camel@localhost.localdomain> <20040927104120.GA30364@logos.cnet> <20040927125441.GG3934@marowsky-bree.de> <35fb2e590409270612524c5fb9@mail.gmail.com> <20040927133554.GD30956@logos.cnet> <20040927171253.GA9728@MAIL.13thfloor.at> <20040927164219.GA31645@logos.cnet> <20040928133352.GA24621@MAIL.13thfloor.at> <20040928123256.GC11779@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928123256.GC11779@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 09:32:56AM -0300, Marcelo Tosatti wrote:
> On Tue, Sep 28, 2004 at 03:33:52PM +0200, Herbert Poetzl wrote:
> > On Mon, Sep 27, 2004 at 01:42:19PM -0300, Marcelo Tosatti wrote:
> > > On Mon, Sep 27, 2004 at 07:12:53PM +0200, Herbert Poetzl wrote:
> > > > On Mon, Sep 27, 2004 at 10:35:54AM -0300, Marcelo Tosatti wrote:
> > > > > On Mon, Sep 27, 2004 at 02:12:26PM +0100, Jon Masters wrote:
> > > > > > Hi all,
> > > > > > 
> > > > > > Just out of interest then...suppose we've got a loopback swap device
> > > > > > and that we can extend this by creating a new file or extending
> > > > > > somehow the existing one.
> > > > > > 
> > > > > > What would be wrong with having the page reclaim algorithms use one of
> > > > > > the low memory watermarks as a trigger to call in to userspace to
> > > > > > extend the swap available if possible? This is probably what Microsoft
> > > > > > et al do with their "Windows is extending your virtual memory, yada
> > > > > > yada blah blah". Comments? Already done?
> > > > > 
> > > > > You dont to change kernel code for that - make a script to monitor 
> > > > > swap usage, as soon as it gets below a given watermark, you swapon 
> > > > > whatever swapfile you want.
> > > > 
> > > > hmm, sounds good, but what if next 'burst' of
> > > > swapped out data is larger than the watermark?
> > > 
> > > Give the watermark a large enough value.
> > 
> > right, probably setting it to the currently 
> > available swapspace solves that issue ;)
> > 
> > anyway as I said, I'm fine with 'does not
> > work' but not very happy with half-assed
> > userspace solutions ...
> 
> Herbert,
> 
> Honestly, I dont see much difference makes if the swapon procedure
> is called from within the kernel instead from userspace.

there is a small but (for me) important difference ...

userspace checks for
available swap space
(all fine, still N left)
				kernel decides to
				swap out N+1 right now
				because it's urgent ..
userspace has _no_ chance
to react, and something
gets killed ...

			   .vs.

				kernel decides to
				swap out N+1 right now

				after N-M swaps, kernel
				realizes that swap space
				is low and calls
userspace, which adds
more swap space so that ...
				the kernel can continue
				to swap out stuff ...


> Have you actually tried such a "on demand swapon" entirely
> from userspace to call it "half-assed" solution ? :)

no I haven't tried it, and I'm perfectly fine with
OOM kills and/or swappiness behaviour, seriously!

but to suggest an userspace solution which IMHO can
not be successful without kernel side support seems
to me like a "half-assed" solution ... maybe I'm
wrong and it is quite fine to assume that:

 a) userspace will detect that swap is becoming
    low just at the right moment
 b) userspace will have the additional swap available
    just right on time for the kernel to use it
 c) all delays will be just so that everything works
    out fine ... as with the OOM selection ;)

> The act of killing tasks is controversial and always generates
> debates here. I bet we will continue seeing them over
> the years.
> 
> If one dont want the OOM killing to happen, he should correctly 
> setup the swap size for his workload 

totally agreed!

> (or have a "on demand swapon" solution which can be implemented 
> in userspace), 

objection! see above ...

> or unset overcommit mode. 

agreed!

> There's not much to argue about that.
> 
> One controversial issue is the OOM killer policy, which is
> hardcoded into the kernel - through the last years there have
> been several attempts to make it selectable (which this 
> "oom_pardon" patch is about). 

IMHO this is papering over misunderstood behaviour
by trying to _not_ ejecting 'important' people ;)

> None of these attempts have made into the mainline kernel, 
> because there hasn't been an agreement on what is the best 
> implementation of such feature - each implementation is 
> specific to one user group need (for example "dont kill 
> tasks named bla" or "dont kill tasks from UID bla" or, or).

which IMHO is completely wrong, as the real solution
would be to make strict no overcommit the default and
let people who have broken^Wfunny apps enable it to
make them run ...

> But other than the OOM killer policy selection or tuning 
> there's not much to be argued really.

except that it should not be done, but as I said, that's
just my not so important opinion ...

putting that aside, thanks for your great work on linux
kernel and the time you spend on this stuff, I really
appreciate it!

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
