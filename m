Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUCHSwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 13:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbUCHSwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 13:52:20 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:25214 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262527AbUCHSwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 13:52:17 -0500
Date: Mon, 8 Mar 2004 12:52:16 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
Message-ID: <20040308185216.GB1555@hexapodia.org>
References: <20040307144921.GA189@elf.ucw.cz> <20040307164052.0c8a212b.akpm@osdl.org> <20040308063639.GA20793@hexapodia.org> <1078738772.4678.5.camel@laptop.fenrus.com> <20040308163611.GA8219@hexapodia.org> <20040308183401.GE484@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308183401.GE484@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 07:34:01PM +0100, Pavel Machek wrote:
> > > > Note that there are some applications for which it is a *bug* if an
> > > > mlocked page gets written out to magnetic media.  (gpg, for example.)
> > > 
> > > mlock() does not guarantee things not hitting magnetic media, just as
> > > mlock() doesn't guarantee that the physical address of a page doesn't
> > > change. mlock guarantees that you won't get hard pagefaults and that you
> > > have guaranteed memory for the task at hand (eg for realtime apps and
> > > oom-critical stuff)
> > 
> > Well, that's fine -- you can certainly define mlock to have whatever
> > semantics you want.  But the semantics that gpg depends on are
> > reasonable, and if mlock is changed to have other semantics, there
> > should be some way for apps to get the behavior that used to be
> > implemented by mlock (and *documented* in the mlock man page).
> > 
> > It's a pity that mlock doesn't take a flags argument.
> 
> How would it help?
> 
> Block system-wide suspend because 4K are mlocked?

Sorry, I left too much of my train of thought implicit.  I'm suggesting
that it would be cool if there were an mlockf(addr, len, ML_NOSWAP) which
would allow an app to say "do not write this page to disk or send it
over the network."  If the kernel decided to evict that page (due to
doing a suspend, perhaps) it would just drop the mapping, and when the
app next used it there would be a SEGV delivered.

Alternatively, you could define a protocol for suspend to notify apps
with mlocked memory that they must clean up in preparation for a
suspend.  It doesn't have to be bulletproof; you can give them one
chance, and if they don't do it just proceed with the suspend.
(Unfortunately this does violate the "never write key material to
magnetic store" semantic as well, but at least you've given the app a
chance.)  Perhaps just SIGUSR1 or something?

Perhaps a better API than mlockf(addr, len, flags) would be a
mattr(addr, len, flags) with MA_NOFAULT, MA_FIXEDPHYSADDR, MA_NOSWAP...
mlock() could then be defined as mattr(addr, len, MA_NOFAULT).


I agree that all of this is beyond the scope of what you're trying to do
in swsusp.  I just want to bring up the issues so that they're not
ignored.

-andy
