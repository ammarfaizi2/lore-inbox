Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265150AbUETQTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbUETQTF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 12:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUETQTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 12:19:05 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:49720 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265150AbUETQTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 12:19:01 -0400
Date: Thu, 20 May 2004 11:19:01 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: overlaping printk
Message-ID: <20040520161901.GD13601@hexapodia.org>
References: <1XBEP-Mc-49@gated-at.bofh.it> <1XBXw-13D-3@gated-at.bofh.it> <1XWpp-zy-9@gated-at.bofh.it> <m3lljnnoa0.fsf@averell.firstfloor.org> <20040520151939.GA3562@elte.hu> <20040520155323.GA4750@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520155323.GA4750@elte.hu>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 05:53:23PM +0200, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > another solution would be to break the lock only once during the
> > kernel's lifetime. The system is messed up anyway if it needs multiple
> > lock breaks to get an oops out to the console. We dont care about
> > followup oopses - the first oops is that matters.
> 
> i.e. something like the attached patch, against BK-curr. (i've also
> attached a cleanup patch that gets rid of the many instances of
> bust_spinlocks() - we now have a generic one in lib/bust_spinlocks.c)
> 
> i consider any secondary lockup after the first oops has been printed a
> feature - sometimes the first oops gets washed away by the many followup
> oopses.

> +unsigned long zap_spinlocks = 1;
[snip]
> -	if (oops_in_progress) {
> +	if (oops_in_progress && test_and_clear_bit(0, &zap_spinlocks)) {

It looks like this will cause problems if the user experiences an oops
during boot, runs for a few hours, and then has another oops.  Won't the
second oops fail to break the lock, and end up just deadlocking?

Yeah, of course you shouldn't blithely ignore the first oops.  But I bet
it happens.

Perhaps zap_spinlocks could be reset after 10 minutes without an oops?

-andy
