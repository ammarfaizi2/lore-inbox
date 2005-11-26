Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbVKZPv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbVKZPv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 10:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbVKZPv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 10:51:58 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:62690
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1422657AbVKZPv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 10:51:57 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Sat, 26 Nov 2005 09:51:38 -0600
User-Agent: KMail/1.8
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511260625.31289.rob@landley.net> <20051126141926.GB17663@elf.ucw.cz>
In-Reply-To: <20051126141926.GB17663@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511260951.39093.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 November 2005 08:19, Pavel Machek wrote:
> > Also, zappable lines tend to clump, so if it gets 2 zappable lines in a
> > row it could speculatively try zapping 2 at a time to see if it makes
> > faster progress.  (The down side is the extra allnoconfig runs for
> > backing up and iterating through on failures to see _which_ ones made a
> > difference.  That's not low-hanging fruit, may not be edible at all...)
>
> Can't you just filter out all the comments beforehand?

The problem is that the comments aren't all comments.  The
  # CONFIG_BLAH is not set
comments are actually like negative dentries specifying "CONFIG_BLAH=n", and 
otherwise it's unspecified which means you get the default.  (They look like 
comments, but they have meaning and yanking them can change behavior.)

This is noticeable if you feed a script through oldconfig, where everything 
that isn't specified one way or the other gets the default setting (which 
might as well be from randconfig).  But even allnoconfig has a lot of "y" 
entries in the resulting script, and some of them (like CONFIG_KALLSYMS or 
CONFIG_DEBUG_BUGVERBOSE) we may very well want to switch off.

Try this:

make allnoconfig
grep -v "^#" .config | grep -v "^$" > .config2
mv .config2 .config
make oldconfig

On the other hand, if you instead mv .config2 to allno.config and make 
allnoconfig, you get something that matches the original .config back.  And I 
haven't seen an "# blah is not set" line wind up in a miniconfig yet.

My understanding is that if you set the right symbol to open up the menu that 
a symbol you want to switch off is in, then not specifying a symbol in that 
menu leads allnoconfig to switch it off, since otherwise it would have to be 
specified.  It's only closed menus that get the defaults.  So if you 
originally created your .config through menuconfig, the "# is not set" lines 
should never be essential.  I think.  (By the way: note that the contents of 
a lot of submenus never actually get written out at all if their guard symbol 
is switched off.  Look at firewire or i2o support in 
allnoconfig's .config...)

(I spent a lot of time poking at this to make miniconfig work back under 
2.6.10.  And the busybox CONFIG_ vs ENABLE_ stuff, too...)

Then again I still haven't figured out why running the shrinker script against 
allnoconfig's config insists that CONFIG_PM=y still has to be set or the 
behavior changes.  Something I need to look at one of these days...

In any case, 99% of the time we should be able to ignore the comments and that 
lets us skip large chunks of config and should be a noticeable speedup.  A 
fallback to handle cases where the "is not set" comments change stuff may be 
sheer paranoia, but I can't be sure it's never necessary just yet...

>         Pavel

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
