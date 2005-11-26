Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVKZM0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVKZM0E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 07:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVKZM0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 07:26:03 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13495
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750835AbVKZM0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 07:26:01 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Sat, 26 Nov 2005 06:25:30 -0600
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511251620.12996.rob@landley.net> <4F23F6A0-EC33-43E0-B0D2-BCBFF25E5777@mac.com>
In-Reply-To: <4F23F6A0-EC33-43E0-B0D2-BCBFF25E5777@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511260625.31289.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 November 2005 20:34, Kyle Moffett wrote:
> I got interested so I started writing a Perl-based replacement that
> actually reads the source config into program memory and writes
> copies out of that RAM each time.

I did several variants before settling on the one I submitted as "least sucky 
for right now".  (Starting from zero and adding lines did not work at _all_, 
and trying to produce consecutively smaller diffs isn't a winner either.  
Anything fancy based on diff runs into the fact that dependencies can enable 
stuff _earlier_ in the file, and it's almost impossible to parse.  Besides, 
diff is noticeably faster when there are few changes, so this was the best 
performer of the lot too...)

And I try to avoid perl dependencies in the linux build process.  When you do 
cross-compiles that make a minimal toolchain (ala the Linux From Scratch 
"/tools" directory) and then chroot into it to create the new system, having 
to add perl to the mess is a disproprotionate hassle.

> I ran into a problem (although I can't reproduce it anymore) where the
> resultant configs had identical options but slightly altered whitespace or
> ordering, which naturally broke the diff method that miniconfig.sh used.

Not a clue, sorry.  The date stamp changes, but that's expected white noise...

> >> I'm not sure what I did wrong last time, it worked this time. My
> >> miniconfig is 6K instead of 46K, good. Still its quite long. Thanks!
> >
> > You mentioned you set a lot of options. :)
> >
> > I agree scripts/miniconfig.sh is clumsy.  I'm thinking about
> > improvements (both to how it works and to the user interface), but
> > I need to catch up on some other stuff first...
>
> I have a bit of time to tinker.  I'll send you my perl version once I
> get it working and test it out a bit.  It shouldn't be too hard to
> add the ability to use .config and rewrite that when exiting.

I came back up to speed on Perl earlier this year (having last used perl 4 
before that), and reminded myself why I really can't stand it.  (scalar vs 
list context, local is an abuse of the exception handler, javadoc didn't have 
to modify the interpreter to ignore /** */ markup, pervasive use of call by 
reference means the exact same operator can act like a comparison or an 
assignment based on context ($x=~blah vs $x=~s/a/b/), references were nailed 
to the side of the language horribly, no language should force every program 
to start with a "suck less than the default" directive like use strict...  I 
could go on for a while...)  If I was going to bang on something more 
advanced than bash I could do a python version easily, but I don't want to 
assume that the target environment will have Python.

The dominant time factor is running allnoconfig.  (Last I checked anyway, 
there's been some development under the bridge since then, might be worth a 
re-profile.)  One speed improvement is that it should be possible to zap some 
of the comment lines without doing an actual allnoconfig.  (Certainly when 
there's a range of contiguous comment lines it could try zapping all of them 
and only iterating through one at a time if that makes a behavior difference, 
which it very seldom should.  That's a low-hanging fruit.)

Also, zappable lines tend to clump, so if it gets 2 zappable lines in a row it 
could speculatively try zapping 2 at a time to see if it makes faster 
progress.  (The down side is the extra allnoconfig runs for backing up and 
iterating through on failures to see _which_ ones made a difference.  That's 
not low-hanging fruit, may not be edible at all...)

> One other minor nit:  If you pass a config file from a previous
> version to miniconfig.sh, it will return the full config file because
> nothing makes it match the original.
>
> Theoretically it should 
> probably allnoconfig with the full config first and use that for the
> rest, before removing lines.

Yup.  That's an upgrade I already have planned.  Right now the mini.config 
files aren't version specific but the shrinker is, but that's easily fixable 
for 2.0.

I kept the shrinker script minimalistic because I was hoping that the kconfig 
guys might like the idea enough to make kconfig's existing infrastructure 
spit out a mini.config, rendering the script obsolete.  But now it's clear 
their reaction is intense distain, I might as well improve my hack since it 
looks like I'll be stuck with it for a while...

I'm pondering making a self-contained "./configure" wrapper script that 
obsoletes my patch (since they refuse to apply it anyway).  The question is 
should it rely on the new "allnoconfig" behavior, or should it just do 
everything with sed so it works with older Linux versions (and busybox and 
uclibc and so on)?  Haven't decided yet.

(Under ./configure, miniconfig.sh would probably become "./configure --export" 
or some such...)

> Cheers,
> Kyle Moffett

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
