Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136173AbRECHrT>; Thu, 3 May 2001 03:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136174AbRECHrK>; Thu, 3 May 2001 03:47:10 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:45574 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136173AbRECHrE>;
	Thu, 3 May 2001 03:47:04 -0400
Date: Thu, 3 May 2001 03:47:55 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Why recovering from broken configs is too hard
Message-ID: <20010503034755.A27693@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so you want CML2's "make oldconfig" to do something more graceful than
simply say "Foo! You violated this constraint! Go fix it!"

Let's start by formulating the general problem.  We'll simplify it by
ignoring the existence of string- and numeric-valued symbols and talk only
about tristates.  We have an old configuration which is broken; that is, it's 
a set of symbol bindings that violates one of the rule predicates. 

Note that by a "configuration" I don't mean just a set of three
bindings like {X86=y, SMP=y, RTC=n}.  I mean an *entire* configuration
of (at last count) 1976 settable options.  Many are linked by constraints in
complex ways (there are constraints in the Linux ruleset involving twelve
or more symbols).  Thus you can't consider the variables in the broken
constraint(s) in isolation from the others.

What you know, to start with, is (a) the configuration, (b) the
constraints, (c) the shape of the menu tree, and (d) which constraints
have failed.  What you want to do is find a set of corrected
configurations which fulfill all constraints and are in some sense
"close" to the broken one you have.  

Ideally, the corrected configurations will only require you to change
symbols already occurring in the broken constraints.  But in any case,
once you have your list of known-good configurations, you intend to
prompt the user to select one of them.

First problem: you don't know how to find *any* correct configuration.
from the information you have.  That's because you don't know in
advance what side-effects flipping the symbols in the broken
constraints will have -- every time you flip a symbol, other
constraints may force variables that are arbitrarily far away.

Computer scientists call this the "satisfaction problem" -- given a
set of constraints, generate a "model" (set of variable bindings) 
that satisfies them.

The obvious thing to try is to start with the configuration you have
and try mutating the variables that occur in the broken constraint(s).
Of course, there are 3^n of these where n is the number of distinct
variables, so this is going to blow up really fast; 3, 9, 27, 81, 243
and we ain't even to six symbols yet.  By the time we get to the
twelve variables that could be linked by just *one* constraint, there
are 531,441.  Even if you can check 500 configurations a second it's
going to take 16 minutes just to get a candidate list.

But wait!  There's more!  If some of the variables participate
in multiple constraints, the numbers get *really* large.  Worst-case
you wind up having to filter 3^1976 or

61886985104344314262549831301497223184442226760005632366142367454062\
53798069007245829607511803014461980205195265648765807533359692422405\
26663343478651948197640717559171334587246360190820597462466618699616\
83769466038480440588536443139761873343981834731232898868121056624288\
25175698197266097855144317654507849536499564272166336474891989097438\
35187399533347347604275259693285565328638904436467418552386274533685\
91327533953419273284845915678229675363862482902467758788105098892672\
89040426968478652648633090613090819909922898996729964073665423236084\
87819939319685920863027286269975666073166040062426792612975756185462\
81534154977458915332736966975415596732075433912438120798023875787687\
12139869442963906795755406077094024235937984546041146032870399467676\
50750114775766120549985366981610796100249952621482595580440335923663\
89536648507944663518188694691546583650254496327051865064380044199561\
11898186436375597975714968012719658007155903874756222061921

distinct configurations.  The heat-death of the Universe happens 
while you're still crunching.  

Obviously this is a stupid, brute-force, doomed approach.  Can we 
be smarter by using the structure of the constraints to narrow 
the configuration search space?  Well, sort of.

The best-known algorithm for this is called SATO, I give a reference
for it in my paper.  It's (a) complicated, (b) expensive, and (c)
slow, but it's there.

The good news is that we could use SATO to crank out some model that
will satisfy the constraints (we know there is at least one because my
ruleset compiler won't compile a set of defaults that is invalid).
The bad news is that there's no way to make it generate a model that's
"close" to our broken one!

There's a third way. The cheap, dirty attack on the satisfaction 
problem is to use what's called a "stochastic" or "hill-climbing"
algorithm.  It's a less ambitious version of the brute-force search
that essentially random-walks through the configuration
space looking for valid ones.

The problem with stochastic search is that (a) it's not guaranteed
to find a model even if models exist, and (b) you can't predict its
running time.  Oops...

Even assuming we could generate large numbers of candidate models
quickly, I've been putting the word "close" in quotes because there's
another nasty problem lurking here.  "Close" is not well-defined in
this space.

It would be hard to know how to order your candidates to present
them to the user in a natural sequence -- and the problem of deciding
which variable to present for mutation by the user next, if you choose
that UI, equates to this.

Have I got the point across yet?  There are *no* good solutions 
to this problem.  There aren't even any clean ways to separate 
easy cases from hard ones.  
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The conclusion is thus inescapable that the history, concept, and 
wording of the second amendment to the Constitution of the United 
States, as well as its interpretation by every major commentator and 
court in the first half-century after its ratification, indicates 
that what is protected is an individual right of a private citizen 
to own and carry firearms in a peaceful manner.
         -- Report of the Subcommittee On The Constitution of the Committee On 
            The Judiciary, United States Senate, 97th Congress, second session 
            (February, 1982), SuDoc# Y4.J 89/2: Ar 5/5
