Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSHLLAL>; Mon, 12 Aug 2002 07:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSHLLAL>; Mon, 12 Aug 2002 07:00:11 -0400
Received: from mail3.alphalink.com.au ([202.161.124.59]:46377 "EHLO
	mail3.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S317861AbSHLLAJ>; Mon, 12 Aug 2002 07:00:09 -0400
Message-ID: <3D579629.32732A73@alphalink.com.au>
Date: Mon, 12 Aug 2002 21:04:09 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org> <3D53D50D.7FA48644@alphalink.com.au> <20020809161046.GB687@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> > You're willing to potentially perturb 2.4?
> 
> This stuff is trivial enough, and easy enough to test, that I think it
> could go in 2.4, yes.  

I think you're underestimating the Gordian knot that is the CML1 corpus.

> Obviously xconfig would need to be dealt with
> in sync with the others, which I'm not doing during the prototyping /
> idea-mongering stage.

Fair enough.

> > I'm pleased to see that you have preserved those semantics.  There
> > are many places in the corpus where a dep_* lists as a dependency a
> > variable which is not defined until later, or is only defined in
> > some architectures, or is never defined.  Earlier today I tweaked up
> > gcml2 to detect them and found 260 in 2.5.29.
> 
> You give me too much credit.  The main motivation for dropping the '$'
> was to make possible the "" == "n" semantics.  That the patch failed
> to do so was accident, not design.

Ah, well that's more disturbing.  Changing the existing semantics, regardless
of how broken we all agree they are, is asking for a world of trouble.  To
pick an example, in 2.5.29 drivers/ide/Config.in:17 is

   dep_tristate '    SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_ATAPI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI

But at this point in the menu tree for 14 of 17 architectures, CONFIG_SCSI has
not yet been defined.  The result is that CONFIG_BLK_DEV_IDESCSI only works
in "make config" and "make allyesconfig" precisely because of the semantic that
you wish to change.

In fact this is the first one gcml2 finds, I don't particularly feel like
trawling through the other two hundred-odd.  Some of them are harmless, I don't
know how many.


> I know the current behavior is documented, but I had thought this was
> because changing the behavior was not feasible due to our Bash-based
> "JIT parsers". 

Yes, changing the behaviour is infeasible with shell-based parsers.  However,
there is now a body of rules which implictly depend on the semantics.

>  Can you provide a rationale for why the current
> behavior is desirable?  

I wouldn't call it "desirable".  I would use words like "clunky", "congealed",
"unorthogonal", "riddled with errors", and "very hard to fix" like the rest of
the config language.

> It seems to me that it only encourages buggy
> Config.in code (since "" == "n" in other contexts like the #defines),

And "" != "n" in other contexts, like if [];then statements.  Did I mention
"unorthogonal" ?

The problem is that logic in config language is implicitly four-state, with
the null or empty value being a separate value distinct from y, m and n.
The fact that both "" and "n" mean "don't build this object" to kbuild doesn't
mean that "" and "n" are the same thing.  This isn't really obvious.

One example where there is a semantic difference between "" and "n" would be
an autoconfigurator, where "n" would mean "I have probed for this hardware and
it is not present" but "" means something like "I have not probed".

> and I don't see any benefits other than that it's the status quo.

I'm not defending the current syntax.  It sucks and it's broken.  But
fixing it will break things that currently aren't broken (or more accurately
are broken twice in opposite directions).  If it's your intention to change
the semantics of "", perhaps it would be better to add new statements which
feature the new syntax and new semantics *only* and have no backwards
compatibility baggage.  An example of this approach is the "nchoice" statement,
which does the same thing as "choice" but with a  more civilized syntax.

> > > +         case "$arg" in
> > > +           y|m|n) ;;
> > > +           *) arg=$(eval echo \$$arg) ;;
> >
> > Don't you want to check at this point that arg starts with CONFIG_?
> > Also, how about quoting \$$arg  ?
> 
> I suppose one could add sanity checks / diagnostics, but there are no
> other valid cases, so that's all they would be.  

Yes, but there are invalid cases, and surely you don't want to help to
*increase* the amount of bugginess in the rules corpus?

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
