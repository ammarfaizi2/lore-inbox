Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136303AbRECJb6>; Thu, 3 May 2001 05:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136294AbRECJbs>; Thu, 3 May 2001 05:31:48 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:7943 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136298AbRECJb2>;
	Thu, 3 May 2001 05:31:28 -0400
Date: Thu, 3 May 2001 05:32:14 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
Message-ID: <20010503053214.B28728@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503034755.A27693@thyrsus.com> <20010503104511.C754@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010503104511.C754@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Thu, May 03, 2001 at 10:45:11AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>:
> If the current dependencies of the symbols can be represented as
> a tree (or can be topologically sorted, to be CS-correct), then I
> would only care about the "leaves" of that tree.

Sorry, there are crosslinks, it's a DAG.  The example that triggered this
displays one.
 
> Most added symbols in newer configs are added as leaves. So this
> should suffice in most situations.

Oh?  What if the leaf participates in a newly-added constraint such that when
you flip it, something else (node or leaf) has to change?  There
could be ripple effects all through the tree.  

This isn't a farfetched case, either.  The new leaf might be a PCMCIA
card (for example) in which case enabling it would force generic PCMCIA
support on.  Sound harmless?  OK. Suppose the new capability is some
new IP filtering capability that interacts with NAT and connection tracking.
Now go look at the cross-constraints in IP filtering.  Take a bottle
of strong analgesic with you, because you're going to need it.

I told you there's no way to separate the easy cases from the hard
ones.  I didn't say that casually.  I've been thinking about problems
like this since last May.  The configuration-state space is all
tangled together by the the constraints in such a way that it's hard
to put a bound beforehand on the side-effects effects of what might at
first look like a single-point change.  Even in a new leaf node.

The most relevant distinction isn't "leaf vs. interior node"; it's
the size of a symbol's clique.  Consider the relation "X participates 
in a constraint with Y" (X co Y).  Now consider the transitive completion of
that relationship; we'll say that X is "related" to Y if there is
any chain of co relations between them.  The set of all Y related 
to X is its clique.

> If we miss a symbol from .config, we ask the user, using the one
> from defconfig as default, if we cannot derive its value from
> our constraints.

That's almost the way it works now.  If the user doesn't supply a
config the defconfig gets used.  Falling back on the defconfig 
for *individual* symbols if the user's config didn't supply a 
value...hmm. technically possible but doesn't strike me as 
a good idea.

What if the defconfig is set up for IDE but the user wants to
do SCSI?  He doesn't supply a value for IDE, it gets picked up
as y from the defconfig...user is now carrying code he doesn't
want and didn't expect.
 
> If we have a symbol in .config, that we don't know about, we
> simply ignore it (and tell the user that it's "obsolete or
> renamed").

Yup, I do that.

> If the value for a symbol is there, but doesn't fit our
> constraints: Ask the user or use the opposite (if it is boolean).

*You don't know which symbol is wrong*  That's the whole point!

> And will the derivation be in nearly constant time, if I change
> one symbol?

Deduction time is...hm.  Linear in tbe symbol's clique size.  I think.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Certainly one of the chief guarantees of freedom under any government,
no matter how popular and respected, is the right of the citizens to
keep and bear arms.  [...] the right of the citizens to bear arms is
just one guarantee against arbitrary government and one more safeguard
against a tyranny which now appears remote in America, but which
historically has proved to be always possible.
        -- Hubert H. Humphrey, 1960
