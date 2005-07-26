Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVGZX5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVGZX5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVGZXzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:55:04 -0400
Received: from waste.org ([216.27.176.166]:35284 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262343AbVGZXxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:53:33 -0400
Date: Tue, 26 Jul 2005 16:53:14 -0700
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Steinmetz <ast@domdv.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [swsusp] encrypt suspend data for easy wiping
Message-ID: <20050726235314.GM12006@waste.org>
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org> <42DA7B12.7030307@domdv.de> <20050725201036.2205cac3.akpm@osdl.org> <20050726220428.GA7425@waste.org> <20050726221446.GA24196@elf.ucw.cz> <20050726225808.GL12006@waste.org> <20050726231249.GB29638@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726231249.GB29638@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 01:12:49AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Well, "how long are my keys going to stay in swap after
> > > swsusp"... that's pretty scary.
> > 
> > Either they're likely in RAM _anyway_ and are thus already trivially
> > accessible to the attacker (for things like dm_crypt or IPSEC or
> > ssh-agent), or the application took care to zero them out, or the
> > application has a security bug.
> > 
> > There are about 4 attack cases, in order of likelihood:
> > 
> > 1) An attacker steals your suspended laptop. He has access to all your
> > suspended data. This patch gets us exactly nothing.
> 
> Wrong. Without this Andreas' patch, he'll get access to your
> half-a-year-old GPG passphrases, too.

Ok, I'll revise that to "very close to nothing". See below.
 
> > 2) An attacker breaks into your machine remotely while you're using
> > it. He has access to all your RAM, which if you're actually using it,
> > very likely including the same IPSEC, dm_crypt, and ssh-agent keys as
> > are saved on suspend. Further, he can trivially capture your
> > keystrokes and thus capture any keys you use from that point forward.
> > This patch gets us very close to nothing.
> > 
> > 3) An attacker steals your unsuspended laptop. He has access to all
> > your RAM, which in all likelihood includes your IPSEC, dm_crypt, and
> > ssh-agent keys. Odds are good that he invokes swsusp by closing the
> > laptop. This patch gets us very close to nothing.
> > 
> > 4) You suspend your laptop between typing your GPG key password and
> > hitting enter, thus leaving your password in memory when it would
> > otherwise be cleared. Then you resume your laptop and hit enter, thus
> > clearing the password from RAM but leaving it on the suspend
> > partition. Then an attacker steals your machine (without re-suspending
> > it!) and manages to recover the swsusp image which contains the
> 
> Why without resuspending it? Position of critical data in swap is
> pretty much random. 

Typical swap partition sizes are about the same as RAM sizes. So the
odds of any given thing in a previous suspend getting overwritten by
the next one are high.

> What I'm worried is: attacker steals your laptop after you were using
> swsusp for half a year. Now your swap partition contains random pieces
> of GPG keys you were using for last half a year. That's bad.

And it's incredibly unlikely. Suspending while a supposedly
short-lived key is in RAM should be rare. Surviving on disk after half
a year of swapping and suspending should be negligible probability.

It's not worth even thinking about when we have real suspended laptops
getting stolen every day in REAL LIFE. Anyone who cares about your
highly contrived case also cares about 1000 times more about the real
life case of the stolen laptop. Otherwise they're fooling themselves.

This code is bad. It attacks a very rare problem, gives its users (and
apparently its authors) a false sense of security, reimplements
dm_crypt functionality apparently without much attention to the
subtleties of block device encryption and without serious review, and
it stands in the way of doing things right.

If we're going to encrypt the suspend image, let's do it right. Let's
cover the real life cases and reuse code that's intended for this
purpose.

-- 
Mathematics is the supreme nostalgia of our time.
