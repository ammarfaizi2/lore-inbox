Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSHIQKc>; Fri, 9 Aug 2002 12:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSHIQKc>; Fri, 9 Aug 2002 12:10:32 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:34432 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S314446AbSHIQKb>; Fri, 9 Aug 2002 12:10:31 -0400
Date: Fri, 9 Aug 2002 11:10:46 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020809161046.GB687@cadcamlab.org>
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org> <3D53D50D.7FA48644@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D53D50D.7FA48644@alphalink.com.au>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Greg Banks]
> I like the basic idea here, and I'm pleased that someone has the
> courage to tackle some of the brokenness of the kconfig language (if
> only because it will provide me with a precedent when I try to
> submit some of my patches ;-).

Thanks for the feedback. (:

> > This applies to 2.4.20pre and (except changelog bits) to 2.5.30 with
> > offsets.  
> 
> You're willing to potentially perturb 2.4?

This stuff is trivial enough, and easy enough to test, that I think it
could go in 2.4, yes.  Obviously xconfig would need to be dealt with
in sync with the others, which I'm not doing during the prototyping /
idea-mongering stage.

> The last statement is inconsistent with the shell code and the
> explanations of the dep_* statements, which sensibly preserve the
> current semantics where an undefined symbol has a distinct fourth
> value which is not y, m or n.
> 
> I'm pleased to see that you have preserved those semantics.  There
> are many places in the corpus where a dep_* lists as a dependency a
> variable which is not defined until later, or is only defined in
> some architectures, or is never defined.  Earlier today I tweaked up
> gcml2 to detect them and found 260 in 2.5.29.

You give me too much credit.  The main motivation for dropping the '$'
was to make possible the "" == "n" semantics.  That the patch failed
to do so was accident, not design.

I know the current behavior is documented, but I had thought this was
because changing the behavior was not feasible due to our Bash-based
"JIT parsers".  Can you provide a rationale for why the current
behavior is desirable?  It seems to me that it only encourages buggy
Config.in code (since "" == "n" in other contexts like the #defines),
and I don't see any benefits other than that it's the status quo.

[Not to demean the status quo - in 2.4 it is probably appropriate.]

> > +    In addition, the /dep/ may have a prefix "!", which negates the
> > +    sense of the /tristate/: "!y" and "!m" reduce to "n", and "!n"
> > +    reduces to "y".
> 
> Perhaps "negates" isn't quite the right word in four-state logic.

I wasn't sure what else to call it.  Besides, as explained above, it's
intended (rightly or wrongly) to be 3-state logic, where two states
represent a form of "true". (:

Perhaps "the /dep/ may have a prefix "!", which transforms the
/tristate/ as follows: ..."  This is particularly appropriate in light
of Roman's argument (which I buy) in favor of "!m" == "m".

> > +function dep_calc () {
> > +       local neg arg
> > +       cur_dep=y       # return value
> > +       for arg; do
> > +         neg=;
> > +         case "$arg" in
> > +           !*) neg=N; arg=${arg#?} ;;
> > +         esac
> > +         case "$arg" in
> > +           y|m|n) ;;
> > +           *) arg=$(eval echo \$$arg) ;;
> 
> Don't you want to check at this point that arg starts with CONFIG_?
> Also, how about quoting \$$arg  ?

I suppose one could add sanity checks / diagnostics, but there are no
other valid cases, so that's all they would be.  I'm not really trying
to produce a config.in 'lint' - leave that to the static parsers like
gcml2, xconfig and mconfig.

Peter
