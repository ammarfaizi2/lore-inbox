Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319065AbSHMUoz>; Tue, 13 Aug 2002 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319067AbSHMUoz>; Tue, 13 Aug 2002 16:44:55 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:44424 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S319065AbSHMUow>; Tue, 13 Aug 2002 16:44:52 -0400
Date: Tue, 13 Aug 2002 15:48:29 -0500
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Greg Banks <gnb@alphalink.com.au>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020813204829.GJ761@cadcamlab.org>
References: <3D587483.1C459694@alphalink.com.au> <Pine.LNX.4.44.0208131306040.6035-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208131306040.6035-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Kai Germaschewski]
> Well, it'd be nice to first "fix" the dep_* statements so that they
> don't break when that change is done (i.e. in this case, moving
> IDESCSI behind CONFIG_SCSI.

Yes.  That's my current plan.

> Basically, extend the "source" command to do a grep CONFIG_* in the
> file to be read and set all found symbols to "n", if unset - only
> then do the actual "source".

Ugly - I'd rather not have to do it that way. (:

> Anyway, some more points:
> 
> o a) dep_bool '  Blah' CONFIG_FOO $CONFIG_BAR         vs.
>   b) dep_bool '  Blah' CONFIG_FOO CONFIG_BAR
> 
>   (the latter proposed by Peter Samuelson)
> 
>   I see the following:
>   b) needs a large scale patch through all Config.in's. OTOH, it can be 
>   done step by step, only changing an instance after it has been looked
>   at. a) means only a patch to Configure/menuconfig etc, but since it 
>   changes semantics, it'd be nice to check all possibly breaking usages
>   (not too hard thanks to gcml2)

sed '/dep_/s/ \$CONFIG_/ CONFIG_/g' is quite effective.  In any case
it is not hard to support both syntaxes - once the transition is
complete, or reasonably complete, we can change the semantics to
'n'=='', which in Configure/Menuconfig can only be enforced in the
non-$ case (well, unless we use your 'source' statement idea).

>   I find a) more intuitive, for people who know sh, it's pretty
>   clear when we use "$" and when not. Also, for 'if' statements,
>   we'll have to use the "$" variant anyway for all I can see, so I
>   prefer that from a consistency point of view.

The problem with "intuitive for people who know sh" is that people
think Config.in *is* shell.  They start putting in constructs which
are not valid Config.in syntax but which *are* valid sh syntax, so
they work with certain parsers but not others.

Mutating the language, long-term, so that it looks less like sh and
more like a specialised language, is IMO a worthy goal.  And I think
it can be done.  The main thing to deal with is adding an alternative
syntax for 'if' statements which doesn't look like test(1).  More
about that in a separate message.

>   a) has the advantage of automatically getting rid of the ugly duplicated
>   'if' tests: (And I think it should allow for getting rid of the 
>   quotation marks, too)
> 
>   if [ "$CONFIG_FOO" = "" -o "$CONFIG_FOO" = "n" ]
>      --> if [ "$CONFIG_FOO" == "n" ] 
>   if [ "$CONFIG_FOO" = "y" -o "$CONFIG_FOO" = "m" ]
>      --> if [ "$CONFIG_FOO" != "n" ] 

See above - 'if' is due for an overhaul as well.

> o whatever we do, having a nice way to handle two exclusive drivers would 
>   be nice

You mean the case where

  A=y implies B=n
  B=y implies A=n
  A=m implies B<=m
  B=m implies A<=m

I agree.  Not sure if it needs special casing or just better general
facilities.  I think it can be well served by the dep_* !CONFIG_FOO
patch, where !y==n, !n==y, !==y, and !m==m.  Then

  dep_tristate CONFIG_A !CONFIG_B
  dep_tristate CONFIG_B !CONFIG_A

Peter
