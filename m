Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVGZXBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVGZXBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVGZW7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:59:00 -0400
Received: from waste.org ([216.27.176.166]:51660 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262312AbVGZW6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:58:16 -0400
Date: Tue, 26 Jul 2005 15:58:08 -0700
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Steinmetz <ast@domdv.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [swsusp] encrypt suspend data for easy wiping
Message-ID: <20050726225808.GL12006@waste.org>
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org> <42DA7B12.7030307@domdv.de> <20050725201036.2205cac3.akpm@osdl.org> <20050726220428.GA7425@waste.org> <20050726221446.GA24196@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726221446.GA24196@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 12:14:46AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > the attached patches are acked by Pavel and signed off by me
> > > 
> > > OK, well I queued this up, without a changelog.  Because you didn't send
> > > one.  Please do so.  As it adds a new feature, quite a bit of info is
> > > relevant.
> > 
> > I don't like this patch. It reinvents a fair amount of dm_crypt and
> > cryptoloop but badly. 
> > 
> > Further, the model of security it's using is silly. In case anyone
> > hasn't noticed, it stores the password on disk in the clear. This is
> > so it can erase it after resume and thereby make recovery of the
> > suspend image hard.
> > 
> > But laptops get stolen while they're suspended, not while they're up
> > and running. And if your box is up and running and an attacker gains
> > access, the contents of your suspend partition are the least of your
> > worries. It makes no sense to expend any effort defending against this
> > case, especially as it's liable to become a barrier to doing this
> > right, namely with real dm_crypt encrypted swap.
> 
> Well, "how long are my keys going to stay in swap after
> swsusp"... that's pretty scary.

Either they're likely in RAM _anyway_ and are thus already trivially
accessible to the attacker (for things like dm_crypt or IPSEC or
ssh-agent), or the application took care to zero them out, or the
application has a security bug.

There are about 4 attack cases, in order of likelihood:

1) An attacker steals your suspended laptop. He has access to all your
suspended data. This patch gets us exactly nothing.

2) An attacker breaks into your machine remotely while you're using
it. He has access to all your RAM, which if you're actually using it,
very likely including the same IPSEC, dm_crypt, and ssh-agent keys as
are saved on suspend. Further, he can trivially capture your
keystrokes and thus capture any keys you use from that point forward.
This patch gets us very close to nothing.

3) An attacker steals your unsuspended laptop. He has access to all
your RAM, which in all likelihood includes your IPSEC, dm_crypt, and
ssh-agent keys. Odds are good that he invokes swsusp by closing the
laptop. This patch gets us very close to nothing.

4) You suspend your laptop between typing your GPG key password and
hitting enter, thus leaving your password in memory when it would
otherwise be cleared. Then you resume your laptop and hit enter, thus
clearing the password from RAM but leaving it on the suspend
partition. Then an attacker steals your machine (without re-suspending
it!) and manages to recover the swsusp image which contains the
password. But with this patch, he's foiled because the password is
encrypted and the key's been erased! He's got all your other data
though, including all the aforementioned long-lived keys.

The right fix for case 1 is dm_crypt with a password prompt. The right
fix for 2 is beyond the scope of this email, but probably begins with
the letters s and e. The fix for 1 goes a long way towards fixing 3 as
well, provided the attacker suspends your machine. And I claim that
anyone who is paranoid enough to actually care about corner cases like
4 should damn well care about case 1 too, and should be more than
willing to type a password on resume, otherwise they're just fooling
themselves.

Together with the fact that this reimplements dm_crypt functionality
with an unreviewed and cryptographically naive replacement, I don't
think this patch makes any sense at all.

-- 
Mathematics is the supreme nostalgia of our time.
