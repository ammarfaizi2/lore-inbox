Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319204AbSHNFKY>; Wed, 14 Aug 2002 01:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319205AbSHNFKY>; Wed, 14 Aug 2002 01:10:24 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:17600 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S319204AbSHNFKX>; Wed, 14 Aug 2002 01:10:23 -0400
Date: Wed, 14 Aug 2002 00:08:42 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Peter Samuelson <peter@cadcamlab.org>
cc: Greg Banks <gnb@alphalink.com.au>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] kernel config 3/N - move sound into drivers/media
In-Reply-To: <20020814043558.GN761@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0208132342560.32010-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Peter Samuelson wrote:

> Here's another one - this should fix the forward dependency between
> CONFIG_SOUND and CONFIG_SOUND_ACI_MIXER, by moving the sound config
> into the "Multimedia" menu - where I think it belongs anyway.

Hmmh, makes sense to me, but there will probably be people complaining 
"sound config has disappeared for me" ;)

> The big loser here is ARM - it no longer suppresses the sound card
> question for the appropriate boards.  But it's just one question, so I
> didn't sweat it too much.

Well, I think that's okay, but you should check back with _rmk_.

What I like about that patch is that it actually removes duplicated code. 
I think that's exactly where this effort should start. For example, the 
SCSI patch didn't do this, though AFAICS it would be nicely possible to 
unconditionally source drivers/scsi/Config.in and then have the if in 
there.

These are trivial changes, and they make it easier to see what's happening 
in the patches which actually change behavior. Taking that a step further, 
this should also be a nice opportunity to introduce drivers/Config.in and 
remove even more duplication from arch/$ARCH/config.in. It comes of the 
cost of testing for the architecture, since e.g. s390 does not want to 
include most of drivers/*, but that means we'd actually collect this 
knowledge at a centralized place.

Introducing drivers/Config.in could be done nicely piecemeal as well, 
without any change in behavior which is always good. It would also provide 
a possibility to not lose the ARM knowledge.

I think it's basically just a question of taste if you prefer to initial 
global subsystem question in drivers/Config.in or 
drivers/<subsys>/Config.in.

drivers/isdn/Config.in starts with

	mainmenu_option next_comment
	comment 'ISDN subsystem'
	if [ "$CONFIG_NET" != "n" ]; then
	   bool 'ISDN support' CONFIG_ISDN_BOOL

	   if [ "$CONFIG_ISDN_BOOL" = "y" ]; then
	      mainmenu_option next_comment

since I did not like having that duplicated in each arch/*/config.in. It
also makes sense in the "have as much information as possible about a
subsystem located in one place (drivers/<subsys>)". By the way, if you do
these kind of changes, also check Config.help, you may be able to remove
duplicated entries there as well ;)

The drawbacks of that solution as opposed to having the above in 
drivers/Config.in and ending with source "drivers/isdn/Config.in" are:
o We need to source all the Config.in files even when the subsys gets 
  disabled, since we cannot know that beforehand
o The trivial patches moving statements like the above into the 
  subsys/Config.in means that all of that file should be indented, which
  makes the patches look really large, even though they change very 
  little.

I have no strong opinion either way, but I'd certainly like 
a drivers/Config.in.

Oh, what I don't like about your patches: You don't include them inline, 
so I cannot easily (R)eply to them and have them quoted ;)

--Kai





