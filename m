Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319123AbSHMSjr>; Tue, 13 Aug 2002 14:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319126AbSHMSjq>; Tue, 13 Aug 2002 14:39:46 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:25022 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S319123AbSHMSjk>; Tue, 13 Aug 2002 14:39:40 -0400
Date: Tue, 13 Aug 2002 13:43:13 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg Banks <gnb@alphalink.com.au>
cc: Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] config language dep_* enhancements
In-Reply-To: <3D587483.1C459694@alphalink.com.au>
Message-ID: <Pine.LNX.4.44.0208131306040.6035-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Greg Banks wrote:

> Kai Germaschewski wrote:
> > 
> > But so the change would be a good thing, right? It would make the behavior
> > consistent between all configuration tools,
> 
> Sorry, I don't understand what you're getting at.  Currently the behaviour is
> consistent between config, menuconfig and xconfig: null-valued deps are ignored.

For some reason, I thought that menuconfig or xconfig were handling the "" 
case differently. Apparently not, sorry about that.

> > CONFIG_BLK_DEV_IDESCSI would
> > be not selectable in either.  So people would have to notice that this
> > statement is broken and fix it.
> 
> Ah.  If you're willing to knowingly feed Linus with patches that break current
> config behaviour, then OK we have a way to proceed.

Well, it'd be nice to first "fix" the dep_* statements so that they don't 
break when that change is done (i.e. in this case, moving IDESCSI behind 
CONFIG_SCSI.

> > So you agree a bit of spring cleaning wouldn't hurt, right? ;)
> 
> Absolutely, and I have a catalogue of dust puppies to help that process ;-)

Okay. Let me first state that I do not really have the time to get 
involved currently. ISDN4Linux and other pending kbuild stuff already 
takes somewhat more than the remaining free time I have. But if you guys 
want to get going with some step by step cleaning (w/o breaking too much), 
I can try to help reviewing and submitting to Linus.

> > Well, you're right here. Which makes me think of my original idea as to
> > define all CONFIG_* values to "n" unless they've explicitly been assign
> > another value before.
> 
> CML2's semantics were that all symbols have a default which is a zero; for
> booleans and tristates that means "n".  Changing from those semantics to the
> ones necessary to run the gcml2 rulebase on CML1 rules was one of the most
> painful parts of supporting CML1.
> 
> So I think having an explicit "n" default is a good idea, but I fail to see how
> you would actually implement such a thing in a shell based parser.

Basically, extend the "source" command to do a grep CONFIG_* in the file
to be read and set all found symbols to "n", if unset - only then do
the actual "source".

> > The main usage currently is "make oldconfig", though .config may be a bit
> > confusing: Questions which have been answered before (even with "n") will
> > not be asked again, whereas for undefined symbols, the corresponding
> > question is put.
> > 
> > So I think the logic should really be tristate, "n","m","y", plus
> > additionally a list of CONFIG_* values which have been defined (as opposed
> > to just being "n" by default). 
> 
> This is precisely the CML2 semantics.
> 
> > Of course, this is a 2.5 change, 
> 
> Agreed.
> 
> > though the only potential for breakage
> > are the dep_* statements which are arguably already broken. 
> 
> I don't think there's any value to gratuitously breaking 2.4's config.
> That's the point of a "stable" series right?

I agree.


Anyway, some more points:

o a) dep_bool '  Blah' CONFIG_FOO $CONFIG_BAR         vs.
  b) dep_bool '  Blah' CONFIG_FOO CONFIG_BAR

  (the latter proposed by Peter Samuelson)

  I see the following:
  b) needs a large scale patch through all Config.in's. OTOH, it can be 
  done step by step, only changing an instance after it has been looked
  at. a) means only a patch to Configure/menuconfig etc, but since it 
  changes semantics, it'd be nice to check all possibly breaking usages
  (not too hard thanks to gcml2)

  I find a) more intuitive, for people who know sh, it's pretty clear
  when we use "$" and when not. Also, for 'if' statements, we'll have to
  use the "$" variant anyway for all I can see, so I prefer that from a
  consistency point of view.

  b) is better if you want to add features like automatic 
  "(EXPERIMENTAL)"

  a) has the advantage of automatically getting rid of the ugly duplicated
  'if' tests: (And I think it should allow for getting rid of the 
  quotation marks, too)

  if [ "$CONFIG_FOO" = "" -o "$CONFIG_FOO" = "n" ]
     --> if [ "$CONFIG_FOO" == "n" ] 
  if [ "$CONFIG_FOO" = "y" -o "$CONFIG_FOO" = "m" ]
     --> if [ "$CONFIG_FOO" != "n" ] 

o whatever we do, having a nice way to handle two exclusive drivers would 
  be nice

--Kai



