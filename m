Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290868AbSAaDLo>; Wed, 30 Jan 2002 22:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290870AbSAaDLX>; Wed, 30 Jan 2002 22:11:23 -0500
Received: from femail46.sdc1.sfba.home.com ([24.254.60.40]:55511 "EHLO
	femail46.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290867AbSAaDLO>; Wed, 30 Jan 2002 22:11:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 22:12:20 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C586C8D.2C100509@inet.com> <20020130231701.FKGV22669.femail15.sdc1.sfba.home.com@there> <20020130175729.N22323@work.bitmover.com>
In-Reply-To: <20020130175729.N22323@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020131031113.KFXH25423.femail46.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 08:57 pm, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 06:18:11PM -0500, Rob Landley wrote:
> > > And you just lost some useful information.  The fact that so-and-so did
> > > fix A and then did B is actually useful.  It tells me that A didn't
> > > work and B does.  You think it's "crap" and by tossing it dooms all
> > > future developers to rethink the A->B transition.
> >
> > <rant>
>
> I'll see your rant and raise you a nickel.
>
> > If developers can't ever make temporary changes to their tree which they
> > do NOT intend to send to linus, they can't FUNCTION.  (Except my not
> > doing development in said tree.)
>
> Of course they can do that.  They get to decide what they push and
> what they don't.  I don't think you understand BK.

Entirely possible.  Quite likely in fact, I'm trying to pick it up as I go 
along.  (I've fired up the docs, but haven't had time to read too far yet.  
Trying to finish some paying work before hitting LWE tomorrow.)

> What we are talking
> about is the problem that the change has been committed to CVS, other
> changes are built on top of it, and now Linus realizes that the change
> was bad news.

The inflexibility of CVS relative to simply applying or reversing patches to 
a source tree on disk is a documented reason Linus doesn't use CVS.  Don't 
compare to CVS, compare to what Linus is currently using.  Beating a straw 
man doesn't HELP.

> The problem is extracting stuff out of the middle which
> has already been built upon for more stuff.  How would you propose solving
> that problem because that is the problem statement?

I'm not quite sure how Linus does this, but how I'd do it is keep around the 
last shipped tree and assemble a patch set against it.  If stuff gets really 
screwed up (a change in the middle needs to be reverted but doesn't unapply 
cleanly), then you can always revert back to the last shipped tree, re-apply 
the patches before the dead one, and then re-apply the patches afterwards 
fixing up rejects as necessary.  (And if I were Linus and the fixup took more 
than 30 seconds, I'd probably throw the dependent ones back down to a 
lieutenant or maintainer with a quick and dirty explanation and have THEM 
fixup the diffs, possibly by making them apply cleanly to the next released 
-pre version and submitting them again then.)  Bounces and even reversions 
due to conflicts are eminently understandable and part of the cost of doing 
business.  (It can be annoying at times, but debugging always is...)

This isn't me trying to make policy, this is me trying to guestimate what's 
going on today.  (I'm not trying to speak for Linus, just explain my 
understanding of how Linus works.)  Now that needs to translate into 
bitkeeper, and if it's HARDER to do in bitkeeper, bitkeeper probably needs to 
be fixed.

> If someone sends Linus a patch, he checks into BK or CVS or whatever,
> he then gets 5 other patches and applies them in BK/CVS, and THEN he
> wants to take out the first patch, how would you suggest we do that?

If the patch no longer unapplies cleanly, then a reversed patch to take it 
out may have to be applied to the tree.  In Linus's tree, this can also 
happen if he's shipped a -pre release with the old patch in it, so reverting 
it would need to be in the next incremental patch Linus releases anyway 
because we're beyond a checkpoint.  (Write barrier, changes committed to 
kernel.org, no longer able to be reordered in cache...)

But if the patch DOES unapply cleanly, and we haven't checkpointed yet, 
there's no good reason Linus can't just revert it.  There should definitely 
be an option to delete all traces of it from the hierarchy (carving moses' 
name off the pillars and all that).

Reverting a change out of order should not ARTIFICIALLY cause conflicts just 
because that's not the way bitkeeper expects people to think.  That would be 
another case of "false dependencies", and gets us back to Linus' backmerge 
concept.  This is sort of reverting a backmerge.

When there is a logistical problem with simply reverting a change because 
other changes really are on top of it, then logically the removal is either 
sort of a patch, or the later changes need to be temporarily reverted and 
fixed up before being reapplied.  (This is not conceptually new, as I said it 
happens with patches all the time.  Whether bitkeeper provides better tools 
to do this than diff, patch, and vi do is an open question.  It might be 
possible to make some sort of "--force --nodeps" way to revert a patch by the 
short and curlies, followed by a manual fixup of the patches that went in on 
top of it with that "bitkeeper fix -c" thing, but probably isn't worth the 
effort and I'm just not going there right now.)

But pointing out that "that history is valuable, leave the old residue in the 
tree even if it hasn't been sent out anywhere yet" is bogus.  Between 
checkpoints, Linus could translate his entire tree into fortran and back if 
he wanted to, and nobody else should ever have to care if he doesn't want 
them to.  The set of changes Linus chooses to ship to turn pre7 into pre8 is 
his choice, not yours.

What Linus seems to want is the shortest and most convenient straight line 
from checkpoint to checkpoint to be stored in his tree.  (Basically, like the 
patch files he puts out NOW, only more granular, with his changelog 
information broken up and stored with each change.)  How can bitkeeper 
provide THAT?  (If it can do more, great.  But if it can't provide this basic 
functionality without some bell or whistle interfering and making it hard to 
use, then there's a problem.  Please be very clear when you're talking about 
an an enhancement over and above this level of functionality when it is NOT a 
requirement...)

Rob
