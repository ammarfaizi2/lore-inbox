Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSHLOnL>; Mon, 12 Aug 2002 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318062AbSHLOnL>; Mon, 12 Aug 2002 10:43:11 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:53942 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316322AbSHLOnJ>; Mon, 12 Aug 2002 10:43:09 -0400
Date: Mon, 12 Aug 2002 09:46:53 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg Banks <gnb@alphalink.com.au>
cc: Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] config language dep_* enhancements
In-Reply-To: <3D579629.32732A73@alphalink.com.au>
Message-ID: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Greg Banks wrote:

> > > I'm pleased to see that you have preserved those semantics.  There
> > > are many places in the corpus where a dep_* lists as a dependency a
> > > variable which is not defined until later, or is only defined in
> > > some architectures, or is never defined.  Earlier today I tweaked up
> > > gcml2 to detect them and found 260 in 2.5.29.
> > 
> > You give me too much credit.  The main motivation for dropping the '$'
> > was to make possible the "" == "n" semantics.  That the patch failed
> > to do so was accident, not design.
> 
> Ah, well that's more disturbing.  Changing the existing semantics, regardless
> of how broken we all agree they are, is asking for a world of trouble.  To
> pick an example, in 2.5.29 drivers/ide/Config.in:17 is
> 
>    dep_tristate '    SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_ATAPI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
> 
> But at this point in the menu tree for 14 of 17 architectures, CONFIG_SCSI has
> not yet been defined.  The result is that CONFIG_BLK_DEV_IDESCSI only works
> in "make config" and "make allyesconfig" precisely because of the semantic that
> you wish to change.

But so the change would be a good thing, right? It would make the behavior 
consistent between all configuration tools, CONFIG_BLK_DEV_IDESCSI would 
be not selectable in either. So people would have to notice that this 
statement is broken and fix it.

> > I know the current behavior is documented, but I had thought this was
> > because changing the behavior was not feasible due to our Bash-based
> > "JIT parsers". 
> 
> Yes, changing the behaviour is infeasible with shell-based parsers.  However,
> there is now a body of rules which implictly depend on the semantics.

If they do, they should be fixed. And, as I pointed out before, it is 
possible to fix even shell-based parsers.

> >  Can you provide a rationale for why the current
> > behavior is desirable?  
> 
> I wouldn't call it "desirable".  I would use words like "clunky", "congealed",
> "unorthogonal", "riddled with errors", and "very hard to fix" like the rest of
> the config language.

So you agree a bit of spring cleaning wouldn't hurt, right? ;)

> > It seems to me that it only encourages buggy
> > Config.in code (since "" == "n" in other contexts like the #defines),
> 
> And "" != "n" in other contexts, like if [];then statements.  Did I mention
> "unorthogonal" ?

Well, you're right here. Which makes me think of my original idea as to 
define all CONFIG_* values to "n" unless they've explicitly been assign 
another value before.

> The problem is that logic in config language is implicitly four-state, with
> the null or empty value being a separate value distinct from y, m and n.
> The fact that both "" and "n" mean "don't build this object" to kbuild doesn't
> mean that "" and "n" are the same thing.  This isn't really obvious.
> 
> One example where there is a semantic difference between "" and "n" would be
> an autoconfigurator, where "n" would mean "I have probed for this hardware and
> it is not present" but "" means something like "I have not probed".

The main usage currently is "make oldconfig", though .config may be a bit 
confusing: Questions which have been answered before (even with "n") will 
not be asked again, whereas for undefined symbols, the corresponding 
question is put.

So I think the logic should really be tristate, "n","m","y", plus 
additionally a list of CONFIG_* values which have been defined (as opposed 
to just being "n" by default). This would get rid of the non-intuitive 
behavior of dep_* and allow simplifying all the if [ == "n" || == "" ] 
duplication. It's a bit cumbersome to implement in shell, but surely 
possible.

Of course, this is a 2.5 change, though the only potential for breakage 
are the dep_* statements which are arguably already broken. It shouldn't 
be too hard to come up with a script which points out the dep_* statements 
which reference symbols defined only later (or use gcml2, which I 
understand can do that already?) to see how much breakage there may be.

--Kai


