Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSGCHIA>; Wed, 3 Jul 2002 03:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSGCHH7>; Wed, 3 Jul 2002 03:07:59 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:54426 "EHLO
	pimout2-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S316935AbSGCHH5>; Wed, 3 Jul 2002 03:07:57 -0400
Message-Id: <200207030709.g6379pL378262@pimout2-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Tom Rini <trini@kernel.crashing.org>, "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [OKS] O(1) scheduler in 2.4
Date: Tue, 2 Jul 2002 21:11:31 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020701134937.23820A-100000@gatekeeper.tmr.com> <20020701234432.GC1697@werewolf.able.es> <20020702024825.GI20920@opus.bloom.county>
In-Reply-To: <20020702024825.GI20920@opus.bloom.county>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 July 2002 10:48 pm, Tom Rini wrote:
> On Tue, Jul 02, 2002 at 01:44:32AM +0200, J.A. Magallon wrote:
> > On 2002.07.01 Tom Rini wrote:
> > >On Mon, Jul 01, 2002 at 01:52:54PM -0400, Bill Davidsen wrote:
> > >> What's the issue?
> > >
> > >b) 2.4 is the _stable_ tree.  If every big change in 2.5 got back ported
> > >to 2.4, it'd be just like 2.5 :)
> >
> > So you want to wait till 2.6.40 to be able to use a O1 scheduler on a
> > kernel that does not eat up your drives ? (say, next year by this same
> > month...)
>
> I assume you mean 2.4.60 here, and no, I don't think O1 scheduler should
> go into 2.4 ever.  We're aiming for a _stable_ series here.  Let me

Ah, monday morning virtue, overcompensating for 2.4.10.  It's the hangover 
speaking...

"We upgrade our kernel on a production machine without testing it first, and 
we get mad if anything actually CHANGED.  We want that upgrade to be a NOP, 
darn it!  We want it to be as if we never did it in the first place, that's 
why we do it..."

If you want stone tablet stability, why the heck are you upgrading your 
kernel?  Downloading the new version off of kernel.org generally means you're 
mucking about with a working box, making changes that are not 100% required.  
If a security vulnerability comes out, you have the source and can patch the 
specific bug in your version.  (If you're not up to that, you're probably 
using a vendor kernel, which is a whole 'nother can of worms.)

If you install new hardware or software, and it going "boing" would be a bad 
thing, you try it on a scratch box first.  If you don't, you deserve what you 
get.

I'm under the impression 2.4.19 is introducing chunks of Andre Hedrick's new 
IDE code.  So it's ok to upgrade something that can, in case of a bug, eat 
your data silently in a way that journaling won't detect.  Why?  LBA-48 and 
ATA-133, of course.  But scheduling, which is SUPPOSED to be 
non-deterministic from day one and could theoretically be brain-dead round 
robin without affecting anything but performance...  That's not safe to 
upgrade.  Right.

If you have a race condition in your code that a new scheduler triggers, 
ANYTHING could trigger it.  2.4.18 behaves horribly under load, try md5sum on 
an iso image and then pull up an xterm and su to another user.  It can take 
30 seconds.  (Yeah, that's mostly IO starvation rather than the scheduler, 
but still, how is the new scheduler going to do WORSE than this?)

The argument here is basically "don't change anything".  It's not exactly a 
series then, is it?  If you want trailing edge, 2.0 is still being 
maintained, let alone 2.2.  Those have a great excuse for not accepting 
anything new beyond a really obvious bugfix.  2.4 does not, because 2.6 isn't 
out yet.  Backporting of somethings from 2.5 to 2.4 will occur until then, 
and O(1) is an obvious eventual candidate.

> stress that again, _stable_.  I'd hope that 2.4.60 is as slow in coming
> as 2.0.40 is.

So the fact that it's in Alan Cox's kernel (meaning Red Hat is shipping it in 
2.4.18-5.55, meaning that if more people aren't actually USING it yet than 
marcelo's 2.4, they will be soon), and andrea's kernel (meaning new VM 
development is being done with it in mind)...  It may not be "sufficiently 
tested" yet but it's GETTING a lot of testing.  You use anything EXCEPT a 
stock vanilla 2.4, you're probably getting O(1) at this point.

If the vendors are starting to ship the thing already, what is the DOWN side 
to integrating it?  The down side to NEVER integrating it is eventually fewer 
people using the kernel off of kernel.org.

Does this remind anybody else of the 0.90 software raid stuff?  At some point 
it makes more sense to keep the OLD one around as a patch for the 5% of the 
community that doesn't want to upgrade.  We're not there on the scheduler 
yet, but "should not happen" without a qualifier means "never"...

> > >c) I also suspect that it hasn't been as widley tested on !x86 as the
> > >stuff currently in 2.4.  And again, 2.4 is the stable tree.
> >
> > I know it is not a priority for 2.4, but say it wil never happen...
>
> I won't say it will never happen, just that I don't think it should.
> It's a rather invasive thing (and as Ingo said, it's just not getting
> stable).

Ingo's main objection was that the patch is only 6 months old, and that 2.4 
is only now stabilizing and that bug squeezing and smoothing should be given 
a little longer to ensure that people have the option of NOT upgrading, and 
that those upgrading want improvements rather than critical "this just 
doesn't work" fixes.  And that's a fine argument.

But 2.6 isn't going to be out this year.  It's not even having its first 
freeze until October.  Traditionally, we've been running a year and a half 
between stable releases (and another six months to actually get the new one 
battle-tested to where the distros and at least 50% of the production boxes 
upgrade.)  We've got a year to eighteen months left on that cycle.  Are the 
distros going to hold off adding it to 2.4 for a year to 18 months?

The real question is, how much MORE conservative than the distros should the 
mainline kernels be?

Rob
